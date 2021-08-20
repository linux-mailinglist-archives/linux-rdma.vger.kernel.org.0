Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05A3F2A49
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhHTKtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 06:49:46 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:17049 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhHTKtp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 06:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629456548; x=1660992548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eqgHbxplx31ngKI7ibaH4rtbbPrwfRSsoZeVw+XhOpI=;
  b=K1SotFzhPo/yB7Ohe6XZfM8IeCLS2M8gb9o6N9bLLFqq5s6vgsHS01Fy
   IoyOomGJuvIxAbtFiO3OsW0PDBzSs8kogBI7kuVFZOgSqTUFL9ESCSAQq
   Xf53Inb9px8813lpU/EyOtsQzFR+VXrWqf/Pm1rFN0RzyVPXIEG1CsmFr
   AK5AfZ+/mvTZTVNtkBGzhzJp5EEwL5BJA6b2I7SGVFlyX4qkiy7pzlotE
   yxKQThNph2oCS68cmSCAM+9QkXw3CaSU8c/XaiulRW7/cOZuFHdH9xdG0
   Q2ugJs0OzF4W8UQjTtI0VtfLdIKbu7o5l9AY5AKNbqm754k4NfFG0v2Ps
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="37096992"
X-IronPort-AV: E=Sophos;i="5.84,337,1620658800"; 
   d="scan'208";a="37096992"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 19:48:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSa/QUhBL7/nAzY6s4tBxjFyREUplnya/L+hB71XufsHHY2YF5Ittvw7umNN3brSAg88lj8Ys096IKNE7/6FqeCV+v4AK0vNz5vUVos63mU7RRP2ZTLw9Efi1wiudL4XKjXDYEAlLPsaWiyn9oGGFM+rnD/Xs/GDNE3iww2nyiAustjPA7HtjDGUL2gJH6cG82aQ3h6OEVBZxgmptYFU2HOyOJyJTbAIAMEYVaFwR+TpNtnJvhwltLXeMJyh5A8uL2nn8Kcq2cni0f6FbVJlT7oV/IuZBVNwKzdb6K+7n0xZJvdgBVbZWc47ZoaH7ywu2E6Z8c8aYZPDF8mcpG09ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqgHbxplx31ngKI7ibaH4rtbbPrwfRSsoZeVw+XhOpI=;
 b=kDLLj9LCu7nuXNiqgl4ZAmxznHdk+F3kHPhygeq7/0BkQ/ahZV5PcXag1x1D6gw551fWXPdzPCOmP2TDN1bFeUPvhqu39dEecdOJ4m67Y+NpwEfnQihJHK2UOe0JE3wbk6r3IOw/Jn9QOjXNW+e36g+tR66zNLJu/RYMXSwuM+NmP6sF6QINX99CGDG1FYaL18JFFaDEDiRz4+hGZx4CMsom+fOR0xfPe2l6C3rsBn1e3sHVa58j7I0jUoaK3/b7EhrIv83LAaCb00bTD9CUp9tSnFrM499n2OrNAC7jK1xm049V9uPi1WA2GGT4PjTkEIMz1uOL2NmaJb9UEGBfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqgHbxplx31ngKI7ibaH4rtbbPrwfRSsoZeVw+XhOpI=;
 b=HmWl9vZ/UemEF48eftNsJEHKA3Y8mudu2hDyJ1QGvkeEpcIxweyUCE5xCe5Wwc/MQae3Nuyv+0ziQqouLyUjwMm27Sj+wWPoP8B+W6tSyOenzG9JbEhj+VjOH3bRM8m0d5/N8TIG2KQOo/dOOuZB7IXWYwRCdjkl7KjB7ERP2ds=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB2451.jpnprd01.prod.outlook.com (2603:1096:603:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 10:48:46 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 10:48:46 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Topic: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Index: AQHXlbAkwqjHlJzA7Ue2Vhqx7eRcdKt8NoWA
Date:   Fri, 20 Aug 2021 10:48:46 +0000
Message-ID: <611F888D.1050608@fujitsu.com>
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
In-Reply-To: <20210820111509.172500-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e89798a-c0cf-4873-db59-08d963c81642
x-ms-traffictypediagnostic: OSAPR01MB2451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB24513EBFAA1DCE0451B5643F83C19@OSAPR01MB2451.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qStLPdXnujvcp1Ma2zPiHcxyQGpqs1R8lyEkO0nPikKxGt/x4OnejiFnYD7ED0tJv8xY68pj0I35ZeJKwn7H3Sl50hQZ09jrw56QVXrYPe9pCU39TWiSicDlyXTvJV2O92femyXLwvwoHxtf7aZBVU0eilzMBPLOBKbkxpvDxhcWYD69HTl5V+8p/GzX/To26PFNLxJEjSc4zbbqpIvfcjcO3Y40YUrjGfttYSILCMGXZqZpzewX6GBXScFpcemznVQFoVAkJdZfoZmGOIBZjmaKuB34rTd/mxIZKkgkMv2p6BIWx+mRMiIl+vBBGQL6ru82NJKYm9immZ0pOoZgGMBn7c3aDJ9XGdDnWj74iwats54XnSwa16XFwSuFRSPWBxb4SRIKZw7dWwXXCNqJ4Gw6AjdUtbF9ehWEOfxt/IHAKCh5Uw7mkA2t8I7WO67wgeeztK9zt+Kvgx8FCg/Un0RVgyzTr4kCCOjbpwQK/mOGdkw7qpB07H96moG5Tp7oJ30ggR1FhZTjgEfLN029zj3dvTLdHfiAMSRx34NpteOZF7yrGsiTJk/mCKLXD8UkwMiOMTBd6BhyLrBORtPD7OMpFC/2zwF8ekTvSsoXcRb4uGRYPwzyiPIo64abxsnJkAkodh1Tq/H/cPZRAUC/r3O4cdI6azb420sxvDLv76MXpKVcEkdWkDHGeV+7E/5Z91OUetCTNwVeWfx8ytmcnvMoytLti6sV/LKy3GZuMut4EoQzMaZJ59ysEmVtw/7X63opIRa38D24MTV9jyZMbI5ONH7FQS3/jtCMX52qohYhKwNzEzwV2DCVJLscaJr7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(26005)(6916009)(33656002)(8676002)(8936002)(186003)(64756008)(66476007)(2616005)(66946007)(6512007)(86362001)(2906002)(38070700005)(71200400001)(478600001)(5660300002)(38100700002)(83380400001)(122000001)(87266011)(66446008)(316002)(966005)(76116006)(6486002)(91956017)(53546011)(6506007)(36756003)(85182001)(66556008)(54906003)(4326008)(3076002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b1QzZUlka1p0T3YwOWI0RU0ybWJ4c3dkYmhBc2k3aWdxWStIMnl5NUpSZUp0?=
 =?gb2312?B?SEF6YjZ0U2RicW45bElvRGxMUUwvQ0NWZnpUazhJUGUyVlhJRys3TTRzM2Fi?=
 =?gb2312?B?ejJMUXBRd3d5RW4wUWd3MHlTT3dCcU1ZSlBIZmVXa1pTV3JybFFYb043ZTQ1?=
 =?gb2312?B?KzZRTGo5M3VDUlhPdVNla3Z4elhQUHFKaCswWVlKWWRmc1FsQTJwbkpDVDdq?=
 =?gb2312?B?YXlRcGQ0dmNqVk82N3RBelNBRDlWT2krZ2FsMkduZ2tzK2ticjNmQ2FoRVZq?=
 =?gb2312?B?RWdsRFRPdTFGNUpobHVsamVPTEtETUwyS29OSGNlVkRzZHVaekhtTjJmUzUw?=
 =?gb2312?B?L1IwWUpHaGJiM25yc3dSMk9RWkNwRUN6anpyeGFpV3NmVHNLbUtpNXpic05K?=
 =?gb2312?B?T25XeHJaanZhRTB1aWMvcHN2QVFTYUQ2bFlib0IvaElXQ2Ixam1sZWYrVlIv?=
 =?gb2312?B?enBxWW5oU3FoUEQ2eG1HWHczMVloNDRVRjUxS1N1T3dETjA1cGpLK2lGQ1R1?=
 =?gb2312?B?MThYM0x2ZDFVWGVzVmM0M012emNlWWxxOGtYbEc3N2xHNG1GSTFBdWhQMVJK?=
 =?gb2312?B?M2lLOGJKempCcjYxMUZlcDc5UW5JRStoY0poU0J4alhJYW9BL2lramloRmt3?=
 =?gb2312?B?cDdscnRycEZGQUMwalBmcmhGN1dzN2QyRVVRVkxlN2pURnFsSnpZeGFxOTdH?=
 =?gb2312?B?c2VvQ1FLRDNJU0hML2hZalV1VnlWdnEveTNMQVk0Wlg5K3FYOElDVVk4dWlI?=
 =?gb2312?B?S0hnTTNOZUxieEtST2JtT0E4aXBrbHBzVG5XM1B2QjREbWtaTDd4UDVoVGow?=
 =?gb2312?B?R1ZzNW1pMEQ4ZkFHR2RPVm1FQlNTTEMrem9JZFR6Nysyc0VzZmJyZTNRcXhR?=
 =?gb2312?B?eFQzUFhmQm43Q0dTc1R5SXE3a25vY2RLQkE1TnhnOUJsSGFkVmlsem1rM3Uw?=
 =?gb2312?B?YVJLWEgwWjcwRmtqYXpqVmxnbWlHbmxFU1hyT3JEb1M0YUlwZWlyUngwOHh0?=
 =?gb2312?B?SlZkOTQ1MXI0eitnNFJKVUszb0Nla0RtQlBITkpZK3JGRm9rVjlSZ08xS09r?=
 =?gb2312?B?RFFROXl4K0hqMjNuSWZlcnhVNVlhNFFWdjV1NmJhOVBIcTJuSk1wZ2ZqTzV1?=
 =?gb2312?B?MlV2Tm50VkhzNW1hS3dHSEFVaGtYTXlMb3MvUFVKRzFXK3Z6UUJab3ROdXp2?=
 =?gb2312?B?OENRT0FRMTlMcklBZGZUQVJwaEVaN05TaFdPd2lqcFh3L21yMDNzVXdiL0Q1?=
 =?gb2312?B?YUhiMkd0YWlvRFo1b0R5REsxSTVubldscEZoTHBhWHBhK2p6cWZKb1dPU0h4?=
 =?gb2312?B?RlZqRVR5MGZHMFhEK0NtUFVoU2pMMXgxWXFTdmd3SjBUV1BKU3FVamYyb2NW?=
 =?gb2312?B?U3JIT1ZrYm0yUW1XZWpNSS8rRCs1VEJCZnBoa2lLZVdGNHhkWU9KekZydld5?=
 =?gb2312?B?OEY3bUh4L2hnVFpoTjVqOU1jeW44Qllkdk9rWEluVDNOOWZqaXRDL2FYWmhr?=
 =?gb2312?B?dERIZXp5SUJmWlpkVVBZQTNwRFYrdWdlWE1ab1JZYjJhMWxYSnpSUFpaZGFn?=
 =?gb2312?B?Zzh3akNndGNYMDVjUXg4WmJNV1dXajQ4U21ETmVoamN0RUxvb0NlSDFTV3RG?=
 =?gb2312?B?ZXlTN3ZKWjduc211Z2p6TVZpS3ZOVXJPNjVtZVAwUzBnNW5mUjV2Y0dHaTRu?=
 =?gb2312?B?aXdIcGpBRkF5Y1Z0aW1XZ2gvME12QktVU3ErbjhsMXhucTUwdURDOTc5WHR1?=
 =?gb2312?B?Skd1WndJKzJPQVpJZ2ZUb3htVlp0RmRORjIzS1FuWW0yZjl5SFJXSUVHbDVD?=
 =?gb2312?B?a3Z0UnJYV2lQNFB5OWdsQT09?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <0AFAD5E124433346B539D94ACFB2874B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e89798a-c0cf-4873-db59-08d963c81642
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 10:48:46.6639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+IQNqs8+c8h852+q+8dJuq1VdbULiAcnvFdbxfRnYdgn8fhkHyw7ucV5868fPQtXAJtK+Hahf07OUdAXpiD0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2451
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgT2xnYSBLb3JuaWV2c2thaWEsDQoNCkNvdWxkIHlvdSBjaGVjayBpZiB0aGlzIHBhdGNoIGNh
biBmaXggeW91ciBpc3N1ZXM/DQoNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4
LXJkbWEvbXNnMTA0MzU4Lmh0bWwNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4
LXJkbWEvbXNnMTA0MzU5Lmh0bWwNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4
LXJkbWEvbXNnMTA0MzYwLmh0bWwNCg0KQnkgdGhlIHdheSwgdGhpcyBwYXRjaCBjYW4gZml4IG15
IHBhbmljLg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCk9uIDIwMjEvOC8yMCAxOToxNSwg
WGlhbyBZYW5nIHdyb3RlOg0KPiAxKSBOZXcgaW5kZXggbWVtYmVyIG9mIHN0cnVjdCByeGVfcXVl
dWUgaXMgaW50cm9kdWNlZCBidXQgbm90IHplcm9lZA0KPiAgICBzbyB0aGUgaW5pdGlhbCB2YWx1
ZSBvZiBpbmRleCBtYXkgYmUgcmFuZG9tLg0KPiAyKSBDdXJyZW50IGluZGV4IGlzIG5vdCBtYXNr
ZWQgb2ZmIHRvIGluZGV4X21hc2suDQo+IEluIHN1Y2ggY2FzZSwgcHJvZHVjZXJfYWRkcigpIGFu
ZCBjb25zdW1lcl9hZGRyKCkgd2lsbCBnZXQgYW4gaW52YWxpZA0KPiBhZGRyZXNzIGJ5IHRoZSBy
YW5kb20gaW5kZXggYW5kIHRoZW4gYWNjZXNzaW5nIHRoZSBpbnZhbGlkIGFkZHJlc3MNCj4gdHJp
Z2dlcnMgdGhlIGZvbGxvd2luZyBwYW5pYzoNCj4gIkJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdl
IGZhdWx0IGZvciBhZGRyZXNzOiBmZmZmOWFlMmMwN2ExNDE0Ig0KPg0KPiBGaXggdGhlIGlzc3Vl
IGJ5IHVzaW5nIGt6YWxsb2MoKSB0byB6ZXJvIG91dCBpbmRleCBtZW1iZXIuDQo+DQo+IEZpeGVz
OiA1YmNmNWE1OWM0MWUgKCJSRE1BL3J4ZTogUHJvdGV4dCBrZXJuZWwgaW5kZXggZnJvbSB1c2Vy
IHNwYWNlIikNCj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5jIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXVldWUuYw0KPiBpbmRleCA4NWI4MTI1ODZlZDQu
LjcyZDk1Mzk4ZTYwNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfcXVldWUuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5j
DQo+IEBAIC02Myw3ICs2Myw3IEBAIHN0cnVjdCByeGVfcXVldWUgKnJ4ZV9xdWV1ZV9pbml0KHN0
cnVjdCByeGVfZGV2ICpyeGUsIGludCAqbnVtX2VsZW0sDQo+ICAJaWYgKCpudW1fZWxlbSA8IDAp
DQo+ICAJCWdvdG8gZXJyMTsNCj4gIA0KPiAtCXEgPSBrbWFsbG9jKHNpemVvZigqcSksIEdGUF9L
RVJORUwpOw0KPiArCXEgPSBremFsbG9jKHNpemVvZigqcSksIEdGUF9LRVJORUwpOw0KPiAgCWlm
ICghcSkNCj4gIAkJZ290byBlcnIxOw0KPiAgDQo=
