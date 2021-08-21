Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7283F3AB6
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhHUNAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 09:00:52 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:45126 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhHUNAw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 21 Aug 2021 09:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629550813; x=1661086813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mv6LU/+FjFf3o7E6r4VTDn4+xdZWzFz+p0cV1dVUzzg=;
  b=TUHVKYc3GsHkGZl1045vGq2AJ/Xzg4uHqidV8NKTs/56jxib/LN4BkVL
   1IZwsAU02jzWjCj9PiPmQcaR7pGEH7qFH/4iJg09TbhqjsArTcGeyW+Vf
   06XKEp21Cd6FlXKX2YLM0QUD8JwgnXzCHEbVrQcVk0osVrbq4AVpy8Obr
   61FvoGd2x+ZTQpvjLg5+kAmBuFz+v9fpaZLqROe4TrmNCgJ5Vd5h2tuBY
   JN1Bs85ZM1P0DvMmbthjzCrGq7Rg+iWCuyyfVdEdX2p14BIlUNlkwYAfv
   eoZonX+eWdCd1CQoy1R/276orKYlbVv3EdGY0zGTVzbqQ9DXKlDCsWFdq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="37152696"
X-IronPort-AV: E=Sophos;i="5.84,340,1620658800"; 
   d="scan'208";a="37152696"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2021 22:00:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLRlRtmcOF1rAE1aVEH9c4XjPsoSR89XuJrt6N+DvVbBEYoO2sNROJ3Aj6aShZk8axiCJGmD1wknszOktim+UyVeunnS147XQ7nd4XEMenoC3fFbYRxo80zE4aO4bNMZbkMMI4JUxTXMVo+3ROnIZsvc5jQasoUXn2YlIlznGOCQesIWTbEdC416LvrLu998ypC23W72645AgYbKCVQaKTtea7pv0TaF53487kIbHpHyd86+gxf3IPC1BJC8LhwWUfjtKDh4zmBiHwhGW39IdBTV5NNen0zh+ltHBdDawk2DgNmwXK6NxR/9W6i88gUOg7OE9JjYWfUmQFwdzpO5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv6LU/+FjFf3o7E6r4VTDn4+xdZWzFz+p0cV1dVUzzg=;
 b=KbGuS6+lPty83raL2QbGH4/+vBEWajoL9X89bn9GS8yTnbLaz+LpT0ZXku1vjHkrXCaBMifcCxyT7qlnDXTIChj1eh9A8J0ZfZu+ZeEE7/dhKDC8SSVFPkP+E3JC8dC+IKRI94Ov4JfN5iWJBGfWu6MjP0pydh7Dz7fB84nTgFj4AEb1uurKo5tmgxUawfNpVHKgaFQWft+iXedz2pXiINqmMpt83r7AQ0GjcXxtrDl8xsFx8evIMWC39xRdqd3Wwx/IwrLxGJpHfAJzEYqLFUxvdVcJAPWrkbCi454CrtvfnwmWyMPS1aSfDLm1BtTal7j3Pg13jD8oCNy+ssuPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv6LU/+FjFf3o7E6r4VTDn4+xdZWzFz+p0cV1dVUzzg=;
 b=aKWajJGNmf2rHoEAf3SOO6+PTocp387WRXi38erAh3EXyOPO+1HkSKjmplhYQavNP56vuq3pVr4TFD5M/JuBfRZibcOHhHXAMXGuKtV1fWkH4coMNHhANF85qEnWMFwFjSsnYyiA277ShnWcO9HKiGtcdSx6w9EOIPdTi05PEM0=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB7077.jpnprd01.prod.outlook.com (2603:1096:604:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Sat, 21 Aug
 2021 13:00:06 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4415.026; Sat, 21 Aug 2021
 13:00:06 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Topic: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Index: AQHXlbAkwqjHlJzA7Ue2Vhqx7eRcdKt8u12AgAEyLoA=
Date:   Sat, 21 Aug 2021 13:00:06 +0000
Message-ID: <6120F8D5.6050408@fujitsu.com>
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
 <9302c160-5905-0bf3-5e1c-98d673aaa2fc@gmail.com>
In-Reply-To: <9302c160-5905-0bf3-5e1c-98d673aaa2fc@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 977f8b8c-6ef0-4855-db5b-08d964a3999f
x-ms-traffictypediagnostic: OS3PR01MB7077:
x-microsoft-antispam-prvs: <OS3PR01MB707753D41BB4AE6AD07D8F6783C29@OS3PR01MB7077.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AfCGaxFkeIKq+HtnKrKcy32454mWD2R8SE8L85Rmd4zRWrqBKxobOhUvaH/WaKzyPcmGkvCgdXcwLLlPSZilj0le0ygz/vlw7o5tEpoQ43gSE5qmnz+HOjHz9kdXYavSQM/DB6zayJpyKqDqhTNGX04JAEXFiMFsI4wz1Ff5MMm52jhDHts3cTkyTJJYHi7L/F8RtaefolcpFUsGgZb1IlRNAz8X1BSfFQ5Zk7UL3sFnOxeylPYyyYAxJIZnzGXM8UOsaFEE0+GoJtBQ63811huxrq4hqWk5U/0I1sARbEXPlAEsFZRlB/nZEciVeA17fVfxZR+OOFSQ5rq2mtNfMD7l/wqUxfz8lItJsvKTsR0LCkxg48OVxCQ2dZ1KutmeyP9ljRo5qD8WJn+2yVibEJKCHmDmfU3B2K4VaKL4BQVZArbVaIIa+9pYoJDhoIz+2YI2adKIpBV0sIhV6DkQkL/NDYiUiJBV+XyEW6O8e1kqIgERL3yB1P05am8bQyXfehBCU0cLSTB/LVGXtGhjnfEY5AilOt+6uMn9br4/tD1fPhraWn+EOFf8Np5jJv3BNpsxAxV6cz38h7Hn38P6r3YT0d1m0apEaoqHp2oQrUs1M5dJnncGjhvypAnZ3jr9z7U182FB+q2p2bYH6MrNABijGE1riikbMv/1+ZS5T0BhoiOLRPC6fxPuziKBI4XWulVGF7eXkYm3vuGlZ+tdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(6506007)(53546011)(26005)(5660300002)(6486002)(316002)(54906003)(66946007)(122000001)(91956017)(186003)(87266011)(36756003)(76116006)(66476007)(6512007)(66446008)(6916009)(38100700002)(64756008)(478600001)(66556008)(2616005)(85182001)(8676002)(38070700005)(71200400001)(4326008)(86362001)(8936002)(33656002)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVJvWGtocTdOTkZFckVjSUxHbVZmcWF6em5vVmYydUdMS3dHa3RUdVpMZkI3?=
 =?utf-8?B?K3ozVGJla0t0YjBWOFllRkVjWlZHUU14dUF4R2pIRUVETTY3ajFkTCtNQ1NW?=
 =?utf-8?B?VGo1VG1nekU3M2phZFdLc0c4UUhaN2RHN0lJRVpPdmhmZ3NvWWlMdGUwbFpE?=
 =?utf-8?B?a2pwSzBZc2h5cFNvQmswSlZPclVoTVRxOWVRdGFHbGY0QXYzbWhuTTNmV3RM?=
 =?utf-8?B?T0VQb0tjbzNLVWVIb1B3Y2tYSXIwTlZsdUJ2c3ZxMXZiUTJ3cUJJaTdyangv?=
 =?utf-8?B?TjIyOVFoSFQzS0FkbURWa01BTkNFUS9DemQ2Ri9BRGdhM2l1a0o1Y0FGbmtm?=
 =?utf-8?B?VW53N3h5S1pJcVRESlNqNlB0ekN2RUdkd1kvSVFpdkhNQmZoSnhWWFZxQVc2?=
 =?utf-8?B?RzJBV05lQUZRNUhlV3d1LzNLNTJWNFUxOHIyeno3c3FpdExsbys3NHMrNmxp?=
 =?utf-8?B?anU3NkJndmpZY0xscTZ3NlFlT25DM2RaN1FzT1Y3UmQ0QWc3N2hydWZTTGx4?=
 =?utf-8?B?QWJGQVlybkM3RmZLUFkycXFrbHJNM1YwSUQwbm44RFRoZGJSMG9UK000SEhF?=
 =?utf-8?B?RlNmSUR4VmdUVkExQVhadGt4MVR4QjUrYzY3Y3hRaE82VTFEU1dkQnU3NEtY?=
 =?utf-8?B?OG43cWdpQStoV09oVVNFRDNtWTdJT1RHTEtGQ2tCTlNEK0dBczFDNzBaaTMy?=
 =?utf-8?B?d3lxbzE2YVNPcTBqdjFpT1hjb0hGV1d2Q0dRUlZwcGNKQWFtZUh6eGNlTVN0?=
 =?utf-8?B?M00vSTVtM0lablRseWpDSDNKZ1BsVjdFKzZScnJNSEs0OFN2MVFnRnVBam8r?=
 =?utf-8?B?OG1TRTh5eFpBbHd4ei96MWtoTTUzY3hoWDBnNG1XRWlhTnRFN2xDeFZYM2Mv?=
 =?utf-8?B?NnVTNVFIdCtXZ2hPeE1tSm11cDBnSlJscWE5eEppMFVHODI0T2hqeXc1MEk5?=
 =?utf-8?B?eEo5Y0NZT05yWkNsY2VxRWFhRjFPOC84aWg3QnRMVU12NlowejNESWFOM2Ft?=
 =?utf-8?B?RERMK045TVhNOW05aFNjRjRrczRYUGltM0hwZitWUkNDWjFzTmNMcnJXYVRy?=
 =?utf-8?B?eVR1QjBVSWFidGthL25sYk5FUU40cmtjdWVPNHRtRVVZcE44TnlyOW95bnha?=
 =?utf-8?B?UldKV1cwWGQxQnZKaUdpY2RFUUtkcStSZmVZcTZQaS9wUHNzTmx4ZnZWV2U3?=
 =?utf-8?B?NFp5dktNclJHejlKMGtSOWtUcStialA4NDl1cUFXL1BCVDllQTJTYVhZNjBi?=
 =?utf-8?B?dVFkU2pjTWZBZy9WNmdpM1EvbGpOa2pDVkdvcThmTDQ1MkoxdXc0dDEyNWo3?=
 =?utf-8?B?U0M1MTNacGZlTittdzNpb1k1MXZyRE9lZFVVcTRWd3hCa0t3SXRlQ1FibTFR?=
 =?utf-8?B?VExhRXR4L3ZUWkY0czNVQWMzbGlqWUZjbStLSWN5a2RGQUZUZExPSFNmOXlQ?=
 =?utf-8?B?K3VPZU1udWcvcFIzNGhYUERiMDJQLzN6cFFnZTZFcVF4Q1M3R1ZWSGgyKzF1?=
 =?utf-8?B?T2xzOFI2YTY5VlZwelU0bHNhL3l0eVhVeTlIQWxHQzRoUEk2NThQNVpkNXNZ?=
 =?utf-8?B?T2hlOFg1YmJiOVd6M0J6dHA5ODdCQ2M0T0hEajkrMmdOc1RjTXhlM1EyeVMz?=
 =?utf-8?B?WFFvbHlidVRZczdnNkkvVlh6TDUySkJ1Z1BZUE1tdE9hT1JWQW5nUEN4L29R?=
 =?utf-8?B?dWRHVmNHeXR1VEpPZTBUMkNPdmsvWHdRK3VSSTNwSWN0VmhodkhuUUQwaE54?=
 =?utf-8?B?OXAzYzdBd3lMdG9sMEtzUFp4SXRhdnZhb1oydGZiYkFCejN1RXhHTytwbldS?=
 =?utf-8?B?ZVRqTlFRdHBmRFdnd1Vrdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <25366B1A0F84754BA0B75B7FC07A0183@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f8b8c-6ef0-4855-db5b-08d964a3999f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2021 13:00:06.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCPQxhwwhddKgPU9KUBGlq6srYoU0fiznx+XpwtWuUUPw1QGE6yXdFNWL4J3hhA77fSFeXIXWL44FQMymg3CFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7077
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzIxIDI6NDQsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA4LzIwLzIxIDY6MTUg
QU0sIFhpYW8gWWFuZyB3cm90ZToNCj4+IDEpIE5ldyBpbmRleCBtZW1iZXIgb2Ygc3RydWN0IHJ4
ZV9xdWV1ZSBpcyBpbnRyb2R1Y2VkIGJ1dCBub3QgemVyb2VkDQo+PiAgICAgc28gdGhlIGluaXRp
YWwgdmFsdWUgb2YgaW5kZXggbWF5IGJlIHJhbmRvbS4NCj4+IDIpIEN1cnJlbnQgaW5kZXggaXMg
bm90IG1hc2tlZCBvZmYgdG8gaW5kZXhfbWFzay4NCj4+IEluIHN1Y2ggY2FzZSwgcHJvZHVjZXJf
YWRkcigpIGFuZCBjb25zdW1lcl9hZGRyKCkgd2lsbCBnZXQgYW4gaW52YWxpZA0KPj4gYWRkcmVz
cyBieSB0aGUgcmFuZG9tIGluZGV4IGFuZCB0aGVuIGFjY2Vzc2luZyB0aGUgaW52YWxpZCBhZGRy
ZXNzDQo+PiB0cmlnZ2VycyB0aGUgZm9sbG93aW5nIHBhbmljOg0KPj4gIkJVRzogdW5hYmxlIHRv
IGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNzOiBmZmZmOWFlMmMwN2ExNDE0Ig0KPj4NCj4+
IEZpeCB0aGUgaXNzdWUgYnkgdXNpbmcga3phbGxvYygpIHRvIHplcm8gb3V0IGluZGV4IG1lbWJl
ci4NCj4+DQo+PiBGaXhlczogNWJjZjVhNTljNDFlICgiUkRNQS9yeGU6IFByb3RleHQga2VybmVs
IGluZGV4IGZyb20gdXNlciBzcGFjZSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmc8eWFu
Z3guanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfcXVldWUuYyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3F1ZXVlLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5j
DQo+PiBpbmRleCA4NWI4MTI1ODZlZDQuLjcyZDk1Mzk4ZTYwNCAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3F1ZXVlLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3F1ZXVlLmMNCj4+IEBAIC02Myw3ICs2Myw3IEBAIHN0cnVjdCBy
eGVfcXVldWUgKnJ4ZV9xdWV1ZV9pbml0KHN0cnVjdCByeGVfZGV2ICpyeGUsIGludCAqbnVtX2Vs
ZW0sDQo+PiAgIAlpZiAoKm51bV9lbGVtPCAgMCkNCj4+ICAgCQlnb3RvIGVycjE7DQo+Pg0KPj4g
LQlxID0ga21hbGxvYyhzaXplb2YoKnEpLCBHRlBfS0VSTkVMKTsNCj4+ICsJcSA9IGt6YWxsb2Mo
c2l6ZW9mKCpxKSwgR0ZQX0tFUk5FTCk7DQo+PiAgIAlpZiAoIXEpDQo+PiAgIAkJZ290byBlcnIx
Ow0KPj4NCj4+DQo+IFRoYW5rcyBmb3IgdGhpcyEhIEkgYW0gaGFwcHkgdG8gdGFrZSB0aGUgYmxh
bWUgYnV0IHRoaXMgaGFzIGJlZW4gdGhlcmUgZnJvbSB0aGUgb3JpZ2luYWwgMjAxNiByeGUgY29t
bWl0LiBJdHMgYSBnb29kIGNhdGNoLg0KSGkgQm9iLA0KDQpUaGUgb3JpZ2luYWwgMjAxNiByeGUg
Y29tbWl0IGFjdHVhbGx5IGludHJvZHVjZWQga21hbGxvYygpIGJ1dCBpdCANCmluaXRpYWxpemVk
IGFsbCBtZW1iZXJzIG9mIHN0cnVjdCByeGVfcXVldWUgYXQgc3Vic2VxdWVudCBzdGVwcy4NCldo
ZW4gdGhlIG5ldyBpbmRleCBtZW1iZXIgb2Ygc3RydWN0IHJ4ZV9xdWV1ZSB3YXMgYWRkZWQsIGl0
IGRpZG4ndCANCmluaXRpYWxpemVkIGF0IHN1YnNlcXVlbnQgc3RlcHMuICBTbyBJIHRoaW5rIHRo
ZSBpc3N1ZSB3YXMgY2F1c2VkIGJ5IA0KeW91ciBwYXRjaC4NCkkgdXNlIGt6YWxsb2MoKSB0byBm
aXggdGhlIGlzc3VlIGJlY2F1c2UgSSB3YW50IHRvIGF2b2lkIHRoZSBzYW1lIGlzc3VlIA0Kd2hl
biBhbm90aGVyIG5ldyBtZW1iZXIgd2lsbCBiZSBhZGRlZCBpbiBmdXR1cmUuDQoNCkJlc3QgUmVn
YXJkcywNClhpYW8gWWFuZw0KPiBSZXZpZXdlZC1ieTogQm9iIFBlYXJzb248cnBlYXJzb25ocGVA
Z21haWwuY29tPg0K
