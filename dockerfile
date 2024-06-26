FROM centos:7
RUN yum install httpd -y
RUN echo "<h1> HELLO AJAY </h1> > /var/www/html/index.html"
CMD httpd -DFOREGROUND
EXPOSE 80


FROM centos:7
RUN yum install epel-release java-openjdk -y
ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.89/bin/apache-tomcat-8.5.89.tar.gz /opt/
WORKDIR /opt
RUN tar -xzf apache-tomcat-8.5.89.tar.gz -C /opt && rm -f apache-tomcat-8.5.89.tar.gz
WORKDIR /opt/apache-tomcat-8.5.89   
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war webapps/
COPY context.xml conf/context.xml
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar lib/
CMD ["./bin/catalina.sh", "run"]
EXPOSE 8080
