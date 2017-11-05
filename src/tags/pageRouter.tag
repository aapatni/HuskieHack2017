<page-router>
  <router>
    <route path="/">
      <home></home>
    </route>
    <route path="/login">
      <login></login>
    </route>
    <route path="/admin/createPage/*">
      <createPage></createPage>
    </route>
    <route path="/admin/createPage">
      <createPage></createPage>
    </route>
    <route path="/admin/pages">
      <pages></pages>
    </route>
    <route path="/admin/editMenu">
      <editMenu></editMenu>
    </route>
    <route path="/admin/editMenu">
      <editMenu></editMenu>
    </route>
    <route path="*">
      <notFound></notFound>
    </route>
  </router>
</page-router>
