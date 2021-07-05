Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22243BB517
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGECMg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Jul 2021 22:12:36 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:5535 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhGECMg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Jul 2021 22:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1625451000; x=1656987000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KjuAiyqCrmi+qbbKalF9z2pLuBdjD+jS8mo42J2Eqlg=;
  b=pOKJxzSbZi+qn/y2eKPQ1nXU1Qiy5VPc+OkZW3viM87zTgP0F2iwS4uq
   0zbg1MkL8pr9fMyKsL5WIIJANirZC8OQnHEk6e09L8Vjw7cRL0gT/1CJ/
   8e3+fpxFpGCIeO13hkEyXR/iupPmE7r//XP4EqzvpCJhTWdGAF8Y0GljS
   UeDfuIt61dKTZMPlvNadYQTW6YdetnumhX7RwSBVpNsHeogpymNkzAP+N
   6qixuNWQvlgGN0YH7plpu40flc7ZUwyCgJRRJxPNzweFixZdq+hudC2my
   0TpYaHIbROsNEpTxgr3c09fs5qz2K7iWLWd7UxhAHRsIHf5n0h3P45PdE
   A==;
IronPort-SDR: AqbbDLDWWFw7gDoUJ+WdXDa821/uAlzWSQPGiopEu97FRy04Myo+Lc3szdZnKJS62bmmmJsgMh
 LXGwiWgPGNqOrHAa8yLSSiVXGnJQ3o3ctMVN+EisNp1Od9lIVNzDbtQdT0UJVlGl7tdzvh0bGg
 H8ogr7xVmed+Y9PqRshViYGYu20vr8+Rr57/ps1mKRaxwLumjX41MpjWvPxpt9y8s1LIomsa93
 apczncIpNUEL2r5w4jJ38bh6hAqNIX4rrQs2rB7ZcYcO905uWLxAW0nqI/vxa9hpfmyYypRqvc
 hvA=
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="34095084"
X-IronPort-AV: E=Sophos;i="5.83,325,1616425200"; 
   d="scan'208";a="34095084"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 11:09:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLMVIHQGTasQ0iQNt51ew3M+QXjrgsBxcRN0bIztsYXHSEUTwalddg1I8LkER5xrpVPsvllmNPLyLz9/9MyXwpFoFo3Kgza40Yr670imZS74ny71H7t0S2w1vsAvtOYyEc543rYZomqzC1DZKSuHJvFJGKHBmwlXGnA6GewNgC8k2PzvRMu7WWX20LbbP1lFmqGFE6I3+HuIE8QggySJy6jSZihcF8pd76oYvMjbrj94JMCUnGntVcX5yU+ozqEw+mWqSa0sKglP99ubPnbI5OY5b72EB0kAQf5NAveG3tr+oEFGnzIe2oQnYY45u9XoOWC8mqwFe4G1WYG8Vbm9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjuAiyqCrmi+qbbKalF9z2pLuBdjD+jS8mo42J2Eqlg=;
 b=QH0qSUwFrUJkBWVSYSJXiTDEymwj0K5ZA59F9Ioq9foImjJ1viqrJedgIuriXOsUl7xq9DTQf+9EukhBS1RehCUltWa/F5IICRQ9G7p+S/cPK5jTXr6SHAe8Wu6q2G6jV5yse1OisCwBz6Sbsel4nA+gWlUCqoCYSGfygliifzQsKg57AoF4rr4TcEJlYVETZZXVtN1SU4ytT0uXsUSRZkh2sckw61VzOE8mqGnlUAsnn3fPSQU/TR3zo3TjttEBQXBrFrzATaIxGmZ6XWJQNenCLQCuRslozw6Rs6+iOdEntlJlv2JOhF6KwNm4g0G6XwRQPCaKMrdc/86quVNsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjuAiyqCrmi+qbbKalF9z2pLuBdjD+jS8mo42J2Eqlg=;
 b=KTuUEhuB7sGPduIoOeSWVz1D0dy33aah6pMB34aorPgDp4SiKEOvMq5agqrXl2WryvSLBxLJPUF84fCY6ZalxjXdhNCNQPIQz2UCOUTyIaglXtzVwa6u14vFgJXwyjA5r1bovJXyxu9L0EBi+wYHn4Uma2DlaF0Yh2B7YKSXujE=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSYPR01MB5480.jpnprd01.prod.outlook.com (2603:1096:604:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Mon, 5 Jul
 2021 02:09:54 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::ed7e:e7f1:4e67:376]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::ed7e:e7f1:4e67:376%6]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 02:09:54 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "haakon.brugge@oracle.com" <haakon.brugge@oracle.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Thread-Index: AQHXcSU6nIba+DYW9EW9S/UaBqS5nqszo2MA
Date:   Mon, 5 Jul 2021 02:09:54 +0000
Message-ID: <60E269F0.4040208@fujitsu.com>
References: <20210704223506.12795-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210704223506.12795-1-rpearsonhpe@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43ca92ad-1380-4b3d-81e9-08d93f59fb1a
x-ms-traffictypediagnostic: OSYPR01MB5480:
x-microsoft-antispam-prvs: <OSYPR01MB5480619C42F828AC0559AC72831C9@OSYPR01MB5480.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPuwCuc8oGiUStk1MlyMK14asGk//U4MDEelQiKB+8wx+s8EYqP0FWr2qp4K5q6HVa3ukiNP1zV/GNuMkjYx1oEjVFCA4hhyQK6ozAixuEkcpmKIP7HKd6FXDq38BlJDIRC83PCVDbbUCgPlyllo0pfg5YzoRfBkx30mIKI5JNbONsNLrV4mVGlSNBhuSPx/wd42pckvgk3J3M3GkHPGh3SE7QihfmIo25CGFFmIE5ZGZp0OhevczYQvka/L+NbGj0eK38c64cWFpPQayUDBm8iIPIa72XmYfYXIqgUp+Xevl4x0SV+SHiuCPLzmTaMNxgZaN8cHTne9IXLzXCmPM+BOOPqUz0rHYz+MYqL+GLj566v8prDLGIkVIErloYMwuhmtIt6iEHc9B4ABcO99WSIsewzKGWV1pQf582nHumn82kwE+b0pJda0zgqmQrGovEVjON1t8f5+iH5q8dPwalZe/ZHcekyPHAhUY8xKjj9B90DzouqqSKPrZqBkYhYEtHv/1TAfOf6ZwJqQFhC846UySZL5QRNh0Yi8czTMICrDU4bsUOSOO8jy9nv/HmSvSNlnhFoF9sZVOyoW4S7nllN8KvRHL8ErOoXT23VOzSJe1IhmZsEoNAQ3Oe6m4tGD9We2DGl39FeXOMH1aJ+ojA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(38100700002)(83380400001)(8676002)(66946007)(71200400001)(122000001)(2616005)(5660300002)(316002)(8936002)(54906003)(478600001)(36756003)(64756008)(66446008)(186003)(87266011)(86362001)(66476007)(66556008)(2906002)(6486002)(26005)(33656002)(6512007)(85182001)(4326008)(53546011)(76116006)(6916009)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bXlYTmhSVE1FN0xuYnQ1RVdmZEhPTi8wc1c3b1phQzlxdFFxd0xBclVzdm44?=
 =?gb2312?B?am53dHZmMWlOT3JsaGhwaTNvOWFkMUlmNStIYTFGYkdZNXovUFJqYnQ5Nmx2?=
 =?gb2312?B?SHRGeUdrbC9VSGFXZ3R1c2x3WEhIWW0wYjJtbmhFSUN0OUVSbW9scjZFaTVw?=
 =?gb2312?B?aEtucnpKSk0zU0RsZndQYUxsRmVUaGRKSzJvSlA3TU9CY0JrMTNtZkxZNjZN?=
 =?gb2312?B?NmRXdkhoU1V2Zi95MXhuTC8xbTBvNyszbXQ2YS9QWXFybUoyMit6R2QrU01V?=
 =?gb2312?B?TzY1TUVrYkdCcEJyOHlBUXduRENBc3htRE8rZXZXUS9lL0FjMXR2NlAwSCt0?=
 =?gb2312?B?ZUM5bUh4b0JNWjZQaDBvSndoenhiRDRKaUxEcW9NaVhiL3YzRlVtYzBCd3Fz?=
 =?gb2312?B?aVl4WlRPMmhDclN5OStESDhmMnRmREdzeWhqY2FPNGwycndWOFBIdUNGNVJN?=
 =?gb2312?B?aEVxRFJDQU01U2o3K2pIMmlud0wyY3V1YkNoZ3l6ZUtmRWFjNG1TVnVodGdL?=
 =?gb2312?B?TmJ3UWNibldBczJVb1NuVTJCRnB3YUNLaDZucTduczMwQmZFMG5kL3J2bG8z?=
 =?gb2312?B?ZERWbU5xcmdoVVlac1dkd2drNjZmREN0ZGgvd24wKy95MkQ3YS9rMjZDQWUy?=
 =?gb2312?B?UVAxall1RU5nbWdIY3dDV01GN1pPajRMUHVnZVVKL2FvNFNvMEpxQ21Xb000?=
 =?gb2312?B?eFNIb0xCU21SWjlXM2tadnl6c0dMZ2N6ODQzUlczQmFwSTNoalRYamFvR0Z3?=
 =?gb2312?B?N0NwR3pHaUE5aVZrWkU4SHFSZ1lRU2ZvbFB3NUlmNURPOGUrOTZ6Sm1JTHdX?=
 =?gb2312?B?dG8rb3ZNTHFjeWljZXNFREdROUpvRHV1VHgySktOc2wrRVhQRUsvSXpYUGtV?=
 =?gb2312?B?T3R6OVRSbExtcXhla2xtV2pNcmh3elBOWWRpL2F4VGxhZkpQOWJ6eEFSV2Zx?=
 =?gb2312?B?QVdELzVLUERnTHhGdFVDRDgvaSt1WW8yMzkzanJmS2g0UDNUaXhjTzRnVVJM?=
 =?gb2312?B?VE56VFpEaGRqTU5TN1dWVUZoZW1iN2QyYXMzM1Mvc2NzTHB2aWh4RDBQQWRv?=
 =?gb2312?B?RGtoZm11V2NKS2I4b0pYVWx6OUVOZGdCQWtLRHU4eVN0bVZ2OElTYzVmNmpM?=
 =?gb2312?B?QVdnanYzSUh6MHIybzhXQkZqaVl4amQrNzlZSDFoa0VYSWRBcFhmRVA5dld3?=
 =?gb2312?B?ZkJ5OC9rY0Q1WVVYOSt0d0RseHVqbnR2bkVvTyswN21XODI2SjNkczR4Q3RL?=
 =?gb2312?B?V1hVZUVoTE9BY0Y0M2h3WmIrb1I0UERBSnJ3MFFwcnByMnJlcjl2U3VCWjl6?=
 =?gb2312?B?cStjRmNnYnBjZ2dUSS9Jc1RkaUdLUVgzbDdsNGpwaU1kZWhoMGJpb2NCM3lF?=
 =?gb2312?B?UWVVUW5MdHdJVGU3TFp5Y2ZDUmQ4QWhQY1FxWWo5TnpNRnU3Qk8yZ2F2ZnFn?=
 =?gb2312?B?S0ZyM3poR1BhVmV2NG9DOURNeHBaMkFLOVh6SWRISE9GODJiNXVMVDJodnBz?=
 =?gb2312?B?Y1dtcW5OSGp1VklPd25PWjlwanVtV0syTHltRURYdzNlRGZjNGZhbXh2ZFNG?=
 =?gb2312?B?bk5nNmxZNnRQL05ucXBmS21rb2twcXpNZjYyYW9yUlRXa3JNM09mZThuOHZy?=
 =?gb2312?B?RVprREtzS0JZVElHTDY5cXQ4NVRKNm1mZGxPdG1Lb21yUHNaL1hTTlRrRDhP?=
 =?gb2312?B?cmdQOFBuR09zRHdta2N0ekpUM05Hd1d0UkRtUFJHRU45aWpSSnJmQVJpeld1?=
 =?gb2312?Q?lsCbJEPkHtQYGCL7u/CtFV/qt7+NNWzWYHhrnzU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <5DC451778B6AA4459AD19E278A01F5ED@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ca92ad-1380-4b3d-81e9-08d93f59fb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 02:09:54.6705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFX0yxMJDlYEwgVcYI0sLlZRT9gDdyPCeYuE5Ef5AbmlvSmq6yKjHeaFrm5U23Vs7vyj95EaYPFqFub28YBtTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5480
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS83LzUgNjozNSwgQm9iIFBlYXJzb24gd3JvdGU6DQo+IEluIHJ4ZV9tcl9pbml0X3Vz
ZXIoKSBpbiByeGVfbXIuYyBhdCB0aGUgdGhpcmQgZXJyb3IgdGhlIGRyaXZlciBmYWlscyB0bw0K
PiBmcmVlIHRoZSBtZW1vcnkgYXQgbXItPm1hcC4gVGhpcyBwYXRjaCBhZGRzIGNvZGUgdG8gZG8g
dGhhdC4NCj4gVGhpcyBlcnJvciBvbmx5IG9jY3VycyBpZiBwYWdlX2FkZHJlc3MoKSBmYWlscyB0
byByZXR1cm4gYSBub24gemVybyBhZGRyZXNzDQo+IHdoaWNoIHNob3VsZCBuZXZlciBoYXBwZW4g
Zm9yIDY0IGJpdCBhcmNoaXRlY3R1cmVzLg0KSGkgQm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgcXVp
Y2sgZml4Lg0KDQpJdCBsb29rcyBnb29kIHRvIG1lLg0KUmV2aWV3ZWQtYnk6IFhpYW8gWWFuZyA8
eWFuZ3guanlAZnVqaXRzdS5jb20+DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBGaXhl
czogODcwMGUzZTdjNDg1ICgiU29mdCBSb0NFIGRyaXZlciIpDQo+IFJlcG9ydGVkIGJ5OiBIYWFr
b24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCb2Ig
UGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX21yLmMgfCA0MSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IGluZGV4IDZhYWJjYjRkZTIzNS4uZjQ5
YmFmZjljYTNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9t
ci5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4gQEAgLTEw
NiwyMCArMTA2LDIxIEBAIHZvaWQgcnhlX21yX2luaXRfZG1hKHN0cnVjdCByeGVfcGQgKnBkLCBp
bnQgYWNjZXNzLCBzdHJ1Y3QgcnhlX21yICptcikNCj4gIGludCByeGVfbXJfaW5pdF91c2VyKHN0
cnVjdCByeGVfcGQgKnBkLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPiAgCQkg
ICAgIGludCBhY2Nlc3MsIHN0cnVjdCByeGVfbXIgKm1yKQ0KPiAgew0KPiAtCXN0cnVjdCByeGVf
bWFwCQkqKm1hcDsNCj4gLQlzdHJ1Y3QgcnhlX3BoeXNfYnVmCSpidWYgPSBOVUxMOw0KPiAtCXN0
cnVjdCBpYl91bWVtCQkqdW1lbTsNCj4gLQlzdHJ1Y3Qgc2dfcGFnZV9pdGVyCXNnX2l0ZXI7DQo+
IC0JaW50CQkJbnVtX2J1ZjsNCj4gLQl2b2lkCQkJKnZhZGRyOw0KPiArCXN0cnVjdCByeGVfbWFw
ICoqbWFwOw0KPiArCXN0cnVjdCByeGVfcGh5c19idWYgKmJ1ZiA9IE5VTEw7DQo+ICsJc3RydWN0
IGliX3VtZW0gKnVtZW07DQo+ICsJc3RydWN0IHNnX3BhZ2VfaXRlciBzZ19pdGVyOw0KPiArCWlu
dCBudW1fYnVmOw0KPiArCXZvaWQgKnZhZGRyOw0KPiAgCWludCBlcnI7DQo+ICsJaW50IGk7DQo+
ICANCj4gIAl1bWVtID0gaWJfdW1lbV9nZXQocGQtPmlicGQuZGV2aWNlLCBzdGFydCwgbGVuZ3Ro
LCBhY2Nlc3MpOw0KPiAgCWlmIChJU19FUlIodW1lbSkpIHsNCj4gLQkJcHJfd2FybigiZXJyICVk
IGZyb20gcnhlX3VtZW1fZ2V0XG4iLA0KPiAtCQkJKGludClQVFJfRVJSKHVtZW0pKTsNCj4gKwkJ
cHJfd2FybigiJXM6IFVuYWJsZSB0byBwaW4gbWVtb3J5IHJlZ2lvbiBlcnIgPSAlZFxuIiwNCj4g
KwkJCV9fZnVuY19fLCAoaW50KVBUUl9FUlIodW1lbSkpOw0KPiAgCQllcnIgPSBQVFJfRVJSKHVt
ZW0pOw0KPiAtCQlnb3RvIGVycjE7DQo+ICsJCWdvdG8gZXJyX291dDsNCj4gIAl9DQo+ICANCj4g
IAltci0+dW1lbSA9IHVtZW07DQo+IEBAIC0xMjksMTUgKzEzMCwxNSBAQCBpbnQgcnhlX21yX2lu
aXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92
YSwNCj4gIA0KPiAgCWVyciA9IHJ4ZV9tcl9hbGxvYyhtciwgbnVtX2J1Zik7DQo+ICAJaWYgKGVy
cikgew0KPiAtCQlwcl93YXJuKCJlcnIgJWQgZnJvbSByeGVfbXJfYWxsb2NcbiIsIGVycik7DQo+
IC0JCWliX3VtZW1fcmVsZWFzZSh1bWVtKTsNCj4gLQkJZ290byBlcnIxOw0KPiArCQlwcl93YXJu
KCIlczogVW5hYmxlIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3IgbWFwXG4iLA0KPiArCQkJCV9fZnVu
Y19fKTsNCj4gKwkJZ290byBlcnJfcmVsZWFzZV91bWVtOw0KPiAgCX0NCj4gIA0KPiAgCW1yLT5w
YWdlX3NoaWZ0ID0gUEFHRV9TSElGVDsNCj4gIAltci0+cGFnZV9tYXNrID0gUEFHRV9TSVpFIC0g
MTsNCj4gIA0KPiAtCW51bV9idWYJCQk9IDA7DQo+ICsJbnVtX2J1ZiA9IDA7DQo+ICAJbWFwID0g
bXItPm1hcDsNCj4gIAlpZiAobGVuZ3RoID4gMCkgew0KPiAgCQlidWYgPSBtYXBbMF0tPmJ1ZjsN
Cj4gQEAgLTE1MSwxMCArMTUyLDEwIEBAIGludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVf
cGQgKnBkLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPiAgDQo+ICAJCQl2YWRk
ciA9IHBhZ2VfYWRkcmVzcyhzZ19wYWdlX2l0ZXJfcGFnZSgmc2dfaXRlcikpOw0KPiAgCQkJaWYg
KCF2YWRkcikgew0KPiAtCQkJCXByX3dhcm4oIm51bGwgdmFkZHJcbiIpOw0KPiAtCQkJCWliX3Vt
ZW1fcmVsZWFzZSh1bWVtKTsNCj4gKwkJCQlwcl93YXJuKCIlczogVW5hYmxlIHRvIGdldCB2aXJ0
dWFsIGFkZHJlc3NcbiIsDQo+ICsJCQkJCQlfX2Z1bmNfXyk7DQo+ICAJCQkJZXJyID0gLUVOT01F
TTsNCj4gLQkJCQlnb3RvIGVycjE7DQo+ICsJCQkJZ290byBlcnJfY2xlYW51cF9tYXA7DQo+ICAJ
CQl9DQo+ICANCj4gIAkJCWJ1Zi0+YWRkciA9ICh1aW50cHRyX3QpdmFkZHI7DQo+IEBAIC0xNzcs
NyArMTc4LDEzIEBAIGludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVfcGQgKnBkLCB1NjQg
c3RhcnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4g
LWVycjE6DQo+ICtlcnJfY2xlYW51cF9tYXA6DQo+ICsJZm9yIChpID0gMDsgaSA8IG1yLT5udW1f
bWFwOyBpKyspDQo+ICsJCWtmcmVlKG1yLT5tYXBbaV0pOw0KPiArCWtmcmVlKG1yLT5tYXApOw0K
PiArZXJyX3JlbGVhc2VfdW1lbToNCj4gKwlpYl91bWVtX3JlbGVhc2UodW1lbSk7DQo+ICtlcnJf
b3V0Og0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCg==
