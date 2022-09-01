Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF975A907C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiIAHiu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiIAHit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 03:38:49 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F81108BE
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1662017928; x=1693553928;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Yh26+k6e2xdhTCk+4mj94/mJDxFPrw7W8ddtpMkP2dk=;
  b=EGdrrLOiPsyQVru+TghK6RVffswlGNqMjoY1HNcYaT/GUoqstQva2P1Y
   gZZzKBcY1KVvLzjCuhL3PJC669RX9hiT1hCWDZci93h6dgdwvgGOR4jR9
   EtY6MNHAd7eXikwjEurbbnSefJQF7QyvFigH1ptdk1JBZXiQzV4QYZAV1
   QIHs4sGBvZevsYU0OIz1kv9Kjl0uX738BgaNYrLkyOfb79aMU0C/g8axf
   USWiFgw4mxV+838BDx2O/O/gpSsL7fnGV2L9vPcdAKB7bVFZsSCLlQQDt
   9W2h9tPCIh8BAQHh8T760VAmxhkenoXoNunpZqGBzeVkn4glA+r3FCETb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="63721720"
X-IronPort-AV: E=Sophos;i="5.93,280,1654527600"; 
   d="scan'208";a="63721720"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 16:38:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcSkFde5Qx2IrHvU4vFuOb2FvSgtLOAeRP63wRzyABpZtBU3YXotppxkoIgXQId7F0R3yMFoymzMFnx+vPiPHpjO9UzjAz6qzKeQbYRYr2BgYb+Aw5NDIprLAKNvqG9FwI2Rh7qyMk9RqJ3uThakdOPvo9lHjugdirI6z+vbAkynfiYLqqgZTa6F6O/cNiCarQiixIhyH7DLHgdWaiQO3IljVjHifA7aqDfYyrcy1rwRQlRHIamo8/tAjlsWEPgDBlM//ovalUpLvVjbABa1McnDbvZVuwmlo1EDj76oPNIjfcSKOKbydgevDXrg1XaK/GUZ31JklMCFkd5/Z/NMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh26+k6e2xdhTCk+4mj94/mJDxFPrw7W8ddtpMkP2dk=;
 b=Ud3fukD0JuKqqUN1A6tDRfSIKemj61s4K44drr9zebpPnco4uv3kO11NMIrxHFgE65PU3VuWPOom7IAPgGl9OgiKJBV+Pgj22TJE67dYZjkkxPPMzJ73J2NvSkA0sLECNY9el1bCm91AsTRMF8R8snFkVn3Naei6OQnzxKjtrCucmW1jYtfDSGhuDLH1YrmLzGb7nObrkFN9CdGWUSZ1cz5MjQRplPKhPUz9aD3tbX/pICXFeo+xmREHU0JS8wQfEQvcOTUpUh4nOHAiAIJOm4ZTRnAMNGCRTYzxwEBni4HOxzJgpLDTBKhCbghEl+bpADzO4cdkBwq1jxNZm9MdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB6307.jpnprd01.prod.outlook.com (2603:1096:604:f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:38:41 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 07:38:41 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH rdma-core] tests: Pass the specified gid index to
 u.get_global_route()
Thread-Topic: [PATCH rdma-core] tests: Pass the specified gid index to
 u.get_global_route()
Thread-Index: AQHYvdXbWVIpxNgYSUGkgpb55eqB0w==
Date:   Thu, 1 Sep 2022 07:38:41 +0000
Message-ID: <20220901073836.1573-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd9d80e9-dd37-4eab-a89e-08da8becfdfa
x-ms-traffictypediagnostic: OS3PR01MB6307:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBjvYq5+NGkLEjvnNgkdpIgAX2pZ4pHIL1lCSqRZFbDmMiB31jeIRW+4h6h6JJicws+cKGz9scOgOaZRgv7yxUYjeDKEl1VOlSDnIu2ip789w8NDqEPOWqjuluGzaCckw/2UuEHujYW695BOpu/PPfe5p/GMaXafFQ2H8hYQ9GYrm13mW4entYezCakoaW+BD0EOcVHp5k8IAa15WSyhEWG5t9t5PUl6ewONqNwg4fdkgrCCSZCbJSUfTCNUjX/2GtzuVZYI7BmbK+5464vMDXwECmP639FBL9s0Yl9LA9dEBqzvGnL5Q8L4b1QICcNtYlawH6d/WJLzYaFw0xEi92LIfWXSC9svXSbSXxhlEupsNujxthLnpvqhtGBUznViFUyq6+GD4zzFZg7pUYmrOI2XtOZfykhedvuQU0IjjtluJ2I2gcCJpbHUi1+Hk9U+ITyRIHXdAdugKDRQIkeTLJWkWI4TOhEXxWZuB4LLlmyygRg5xLLCMj2aCwno02wheKAc3tHfAYc9CUvH5D+ssHeQ1WjyptE75oC5YeTUyOPLhcpnb87M/c9mgJgmxzmWmXNrtsiiPtuXlT8CyOQGx+lyranuef5JtbWJ9TcgHs1lNXrdBYONv1j5v3dr0gF+Or+Rm5JFna7u2oIB4AF6TMNUw/VUP7/oOlAGrg9oF9GwsKe9Y0Tn3wFwR/0TiOhopxOGkJLAf/izF/J53PS3GpL9jzsF1fruWftguUy4rrlSZZRYXIbwREpGiATUTqqnF+4Hfsu2/AeLJr7o2i6GIlRSrhbfUoz8Dpap0RCfMfo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(1590799006)(85182001)(91956017)(66556008)(83380400001)(71200400001)(64756008)(36756003)(66476007)(4326008)(66946007)(66446008)(6916009)(76116006)(316002)(8676002)(54906003)(41300700001)(26005)(6512007)(86362001)(1580799003)(1076003)(2906002)(6506007)(6486002)(8936002)(2616005)(5660300002)(478600001)(186003)(82960400001)(38100700002)(38070700005)(107886003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aHNYYllNTHVlbXBibWw2dzNFOThJT0lGSEwwL1lXRyt5c3FBeGJ2SFVKR0VY?=
 =?gb2312?B?bDJTWlQ1S3crbW9FbVdNKzkvRnJJL2RZcFpmT256Z3hzWWo2K3lmdlF5dWdz?=
 =?gb2312?B?bFR3YTRZMjJuOXpuM3Q4dEVoeGNNbmIyeVBCS1Z3WVZNKzdPcFlLREE1ZVNa?=
 =?gb2312?B?eVhjbmpybXlHQ1Fwb0JRdkNVYTJrYXhzdWhEeXE1OUZDeE9ENmJqMUJnYWVM?=
 =?gb2312?B?TlcrcWVKWGdPWURtMWFQd0hpNU5ZcGdMMzdoR3lJUDBqZ2tia1d3SGtwdHd6?=
 =?gb2312?B?eldQbkRVbHhROGlvZ1Z5bWlmNFZjbmVRVm1UbXBINzdvSFBLMlVRR2VwaFZS?=
 =?gb2312?B?NWEyaXN0bytpdWNOdkVtUFZXWStjUktaVGFaMFVhL0YvMURUY2tQTWcwVlJL?=
 =?gb2312?B?blhrdVh5UjZJUGY0SkhKVk5mR0YwMldYYThJOEQ3TGkrQmJUdXg4RXhlakRj?=
 =?gb2312?B?cEE2L1lXYzFvSGhabUVyN1ZOdlBDME5EOVEwVHVyYXpueFdLRTdMcktqRWx0?=
 =?gb2312?B?b05idGFZLzJUeTk1b3NoNWxVeW54TUk0dVMvdzJYZU4yeHMwN0Q4aDF3aFhL?=
 =?gb2312?B?cTlYSmVqU1c2cGZTTndCbG8zd2pTQzdEVVJ3aWZsYkhvUjJ3WXYvNENrZFJm?=
 =?gb2312?B?Skhwa1FLeHo1WlBtVlBLSVF6dDVCcko5QkdMNjl1V3BrVUw3cWI2MXpIK1dT?=
 =?gb2312?B?N01MUlRZZVB5TVNWS04zRVB5UUN1dHZiVHQ4QW95d0pFcE05cVU5OHdUd256?=
 =?gb2312?B?R1RhdHREZFdjekVLaFVYWjQ3aExMZk1PNXVzbSt2R0xRMXltbWVGMlFkMmVT?=
 =?gb2312?B?LzI5RktUSi82cFFFa09QR1ZMQ2thUlkxRVp6REl0SmY0c0I1Wk9KNzh2a0ta?=
 =?gb2312?B?NEJQQWU2SEl1K3Vyb3BJTHV1ZjAzcC9XbmE0ZXgxdWVHMlJnd1pHckF4UGpo?=
 =?gb2312?B?T2NkdURqMnU0aU43QmxpeHZWUkJ0eEg1bE00cUtERTkxbUFqTWo2b2hxU2JQ?=
 =?gb2312?B?bzB3TnZaUmFKTUlHYUE3cXJ6MEhGRjIyQ2JCZEFDNnQzTmhKNnNOYXhLNWhh?=
 =?gb2312?B?M0FKd2lEa2ZQZnRRTHdKRlJPQkgrK1B4NEpCbzRreWkyTE1PVGJCbnV5anNa?=
 =?gb2312?B?TEpsR3AxQm9wN3h1REtYY3MzWmhnQjA2VkZwb0V1TkhNM01JT01mMmhwRDJQ?=
 =?gb2312?B?Qy9HSVpENFdrK1FyYTlrTG5Qamdta3RKK2tyZzhBaCtIN3hpemV2VTBtWWRy?=
 =?gb2312?B?dUEwandWcU9rcWthQTFqdlBxOExBdDZlOHFmK2xrRzJqanRVVk9DdUI4akxy?=
 =?gb2312?B?UnRUa0tSN1JRWHNUV05XNHBQK1U3OUdpNWJQcGdWMVNtZlZTTk9EaXpJOUZl?=
 =?gb2312?B?eTdoc1grWnZuNEptc2NkMUJRRWNLS3dvTnp1V1pYQTNObllzNUo2YmZvVys3?=
 =?gb2312?B?eHV1SE80cW5RYng5SWxrbjJOWW9TR0RwM205MTB1SUk2QnV0U2NaMWI0YlBV?=
 =?gb2312?B?WS9VKzR3eDJ6aUtjWmRzdUNSWmFyYktNbU9ZTTZ0VG5PeS9FamdPem84bVRG?=
 =?gb2312?B?K2ZvV2lXRjg2Z0kxK052V0Fwa0laMG1kTEtSZ092UmxTeWtILy9zdEFYbUlp?=
 =?gb2312?B?ODZoZXRXaE1yOERKMEdqQVUzaWlvQkJScHpNTWV0ZW1SM2xsRThrSE1Sc05R?=
 =?gb2312?B?T3hibzgyRXk1NDlxa2YvaGY0QkRiTXJGeEM5dFlzaFZ1ZEdPbERoVnRaZWdD?=
 =?gb2312?B?eSsya1N2NlRaU2pEQWZuNEZnY1pBMWZKVERBK1cvQzN5ZHMreS9Nc3NwVlJ3?=
 =?gb2312?B?OEdXK3FFdG9POFYxOGs0TVNKSzh2b25OYlA1UG1LbEJZY0JCR0VyOTZQQlRI?=
 =?gb2312?B?UWtTTWg1UUpWOTJwNEtNVVpOa0ZyblU0MHVkNGppV3pKSlVxVWdyd25HQTYz?=
 =?gb2312?B?bHNtUXJNSkJjSE5ZWjU1WDNqNUJKVnNxNFUxRkJraFpmM1IzUnozemFic3k3?=
 =?gb2312?B?NEV4ZGNheEkxVnRYT25xc2JnNnhyNGROeDE1TUJmOXNSQ0wzcjE3TWN2NmJ2?=
 =?gb2312?B?SjNEZVFMREp2bWlXckh2QUs1SlZHZmJNWnZ2OE9ONUV0OUdRc1RWbG5UeVJj?=
 =?gb2312?B?YUw4cWxxMHp5czR6ZzY4cUR1YXE4NHRTT3dIUC9wcnpPLzFwQXkxcFZ4dWxs?=
 =?gb2312?B?dlE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9d80e9-dd37-4eab-a89e-08da8becfdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 07:38:41.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dha4il/y82WrIL1utN9YqTwpL71KMLWeOrFSuI7y/4vCHzWTvYhYqb4FKa2ZDQyzBRPr5g6ft62kijkGXLAgbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6307
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dGVzdF9jcmVhdGVfYWgoKSBvciB0ZXN0X2Rlc3Ryb3lfYWgoKSBhbHdheXMgdHJpZ2dlcmVkIHRo
ZSBmb2xsb3dpbmcNCmVycm9yIG9uIFNvZnRSb0NFIGJlY2F1c2UgdGhlIHNwZWNpZmllZCBnaWQg
aW5kZXggZGlkbid0IHdvcmsuDQoNCiQgYmluL3J1bl90ZXN0cy5weSAtLWRldiByeGVfZW5wMHM1
IC0tZ2lkIDEgLXYgdGVzdHMudGVzdF9hZGRyLkFIVGVzdC50ZXN0X2NyZWF0ZV9haA0KdGVzdF9j
cmVhdGVfYWggKHRlc3RzLnRlc3RfYWRkci5BSFRlc3QpDQpUZXN0IGlidl9jcmVhdGVfYWguIC4u
LiBFUlJPUg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQpFUlJPUjogdGVzdF9jcmVhdGVfYWggKHRlc3RzLnRl
c3RfYWRkci5BSFRlc3QpDQpUZXN0IGlidl9jcmVhdGVfYWguDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUcmFj
ZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQogIEZpbGUgIi9yb290L3JkbWEtY29yZS90
ZXN0cy90ZXN0X2FkZHIucHkiLCBsaW5lIDUxLCBpbiB0ZXN0X2NyZWF0ZV9haA0KICAgIHJhaXNl
IGV4DQogIEZpbGUgIi9yb290L3JkbWEtY29yZS90ZXN0cy90ZXN0X2FkZHIucHkiLCBsaW5lIDQ3
LCBpbiB0ZXN0X2NyZWF0ZV9haA0KICAgIEFIKHBkLCBhdHRyPWFoX2F0dHIpDQogIEZpbGUgImFk
ZHIucHl4IiwgbGluZSA0MTAsIGluIHB5dmVyYnMuYWRkci5BSC5fX2luaXRfXw0KcHl2ZXJicy5w
eXZlcmJzX2Vycm9yLlB5dmVyYnNSRE1BRXJyb3I6IEZhaWxlZCB0byBjcmVhdGUgQUguIEVycm5v
OiAxMTAsIENvbm5lY3Rpb24gdGltZWQgb3V0DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClJhbiAxIHRlc3Qg
aW4gMS4yNzFzDQoNCkZBSUxFRCAoZXJyb3JzPTEpDQoNClRyeSB0byBmaXggdGhlIGlzc3VlIGJ5
IHBhc3NpbmcgdGhlIHNwZWNpZmllZCBnaWQgaW5kZXggdG8gdS5nZXRfZ2xvYmFsX3JvdXRlKCku
DQoNClNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+DQotLS0N
CiB0ZXN0cy9iYXNlLnB5ICAgICAgfCA0ICsrKysNCiB0ZXN0cy90ZXN0X2FkZHIucHkgfCA0ICsr
LS0NCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL3Rlc3RzL2Jhc2UucHkgYi90ZXN0cy9iYXNlLnB5DQppbmRleCA5MjI5ZGYz
NS4uMmJmMTlmZjAgMTAwNjQ0DQotLS0gYS90ZXN0cy9iYXNlLnB5DQorKysgYi90ZXN0cy9iYXNl
LnB5DQpAQCAtNzYsNiArNzYsNyBAQCBjbGFzcyBQeXZlcmJzQVBJVGVzdENhc2UodW5pdHRlc3Qu
VGVzdENhc2UpOg0KICAgICAgICAgc2VsZi5jdHggPSBOb25lDQogICAgICAgICBzZWxmLmF0dHIg
PSBOb25lDQogICAgICAgICBzZWxmLmF0dHJfZXggPSBOb25lDQorICAgICAgICBzZWxmLmdpZF9p
bmRleCA9IDANCiANCiAgICAgZGVmIHNldFVwKHNlbGYpOg0KICAgICAgICAgIiIiDQpAQCAtOTMs
NiArOTQsOSBAQCBjbGFzcyBQeXZlcmJzQVBJVGVzdENhc2UodW5pdHRlc3QuVGVzdENhc2UpOg0K
ICAgICAgICAgICAgICAgICByYWlzZSB1bml0dGVzdC5Ta2lwVGVzdCgnTm8gSUIgZGV2aWNlcyBm
b3VuZCcpDQogICAgICAgICAgICAgc2VsZi5kZXZfbmFtZSA9IGRldl9saXN0WzBdLm5hbWUuZGVj
b2RlKCkNCiANCisgICAgICAgIGlmIHNlbGYuY29uZmlnWydnaWQnXToNCisgICAgICAgICAgICBz
ZWxmLmdpZF9pbmRleCA9IHNlbGYuY29uZmlnWydnaWQnXQ0KKw0KICAgICAgICAgc2VsZi5jcmVh
dGVfY29udGV4dCgpDQogICAgICAgICBzZWxmLmF0dHIgPSBzZWxmLmN0eC5xdWVyeV9kZXZpY2Uo
KQ0KICAgICAgICAgc2VsZi5hdHRyX2V4ID0gc2VsZi5jdHgucXVlcnlfZGV2aWNlX2V4KCkNCmRp
ZmYgLS1naXQgYS90ZXN0cy90ZXN0X2FkZHIucHkgYi90ZXN0cy90ZXN0X2FkZHIucHkNCmluZGV4
IDU2MTgxMmRlLi41YjZjNWVmYiAxMDA2NDQNCi0tLSBhL3Rlc3RzL3Rlc3RfYWRkci5weQ0KKysr
IGIvdGVzdHMvdGVzdF9hZGRyLnB5DQpAQCAtMzgsNyArMzgsNyBAQCBjbGFzcyBBSFRlc3QoUHl2
ZXJic0FQSVRlc3RDYXNlKToNCiAgICAgICAgIFRlc3QgaWJ2X2NyZWF0ZV9haC4NCiAgICAgICAg
ICIiIg0KICAgICAgICAgc2VsZi52ZXJpZnlfc3RhdGUoc2VsZi5jdHgpDQotICAgICAgICBnciA9
IHUuZ2V0X2dsb2JhbF9yb3V0ZShzZWxmLmN0eCwgcG9ydF9udW09c2VsZi5pYl9wb3J0KQ0KKyAg
ICAgICAgZ3IgPSB1LmdldF9nbG9iYWxfcm91dGUoc2VsZi5jdHgsIGdpZF9pbmRleD1zZWxmLmdp
ZF9pbmRleCwgcG9ydF9udW09c2VsZi5pYl9wb3J0KQ0KICAgICAgICAgcG9ydF9hdHRycyA9IHNl
bGYuY3R4LnF1ZXJ5X3BvcnQoc2VsZi5pYl9wb3J0KQ0KICAgICAgICAgZGxpZCA9IHBvcnRfYXR0
cnMubGlkIGlmIHBvcnRfYXR0cnMubGlua19sYXllciA9PSBlLklCVl9MSU5LX0xBWUVSX0lORklO
SUJBTkQgZWxzZSAwDQogICAgICAgICBhaF9hdHRyID0gQUhBdHRyKGRsaWQ9ZGxpZCwgZ3I9Z3Is
IGlzX2dsb2JhbD0xLCBwb3J0X251bT1zZWxmLmliX3BvcnQpDQpAQCAtNzIsNyArNzIsNyBAQCBj
bGFzcyBBSFRlc3QoUHl2ZXJic0FQSVRlc3RDYXNlKToNCiAgICAgICAgIFRlc3QgaWJ2X2Rlc3Ry
b3lfYWguDQogICAgICAgICAiIiINCiAgICAgICAgIHNlbGYudmVyaWZ5X3N0YXRlKHNlbGYuY3R4
KQ0KLSAgICAgICAgZ3IgPSB1LmdldF9nbG9iYWxfcm91dGUoc2VsZi5jdHgsIHBvcnRfbnVtPXNl
bGYuaWJfcG9ydCkNCisgICAgICAgIGdyID0gdS5nZXRfZ2xvYmFsX3JvdXRlKHNlbGYuY3R4LCBn
aWRfaW5kZXg9c2VsZi5naWRfaW5kZXgsIHBvcnRfbnVtPXNlbGYuaWJfcG9ydCkNCiAgICAgICAg
IHBvcnRfYXR0cnMgPSBzZWxmLmN0eC5xdWVyeV9wb3J0KHNlbGYuaWJfcG9ydCkNCiAgICAgICAg
IGRsaWQgPSBwb3J0X2F0dHJzLmxpZCBpZiBwb3J0X2F0dHJzLmxpbmtfbGF5ZXIgPT0gZS5JQlZf
TElOS19MQVlFUl9JTkZJTklCQU5EIGVsc2UgMA0KICAgICAgICAgYWhfYXR0ciA9IEFIQXR0cihk
bGlkPWRsaWQsIGdyPWdyLCBpc19nbG9iYWw9MSwgcG9ydF9udW09c2VsZi5pYl9wb3J0KQ0KLS0g
DQoyLjM0LjENCg==
