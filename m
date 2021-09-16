Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572EF40D5F4
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhIPJSY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 05:18:24 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:17695 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235493AbhIPJSD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 05:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1631783802; x=1663319802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hsMa1yAdzEI0b3m6j302RXEV9tmUD1xwbMvariEe/zU=;
  b=jadhlfqTpjCq+e6crsWn7LWOEVOCOOnJ/J5+tjBtiyHV2qt9oqdS3jTe
   kTfdXSCVmg3dvL1Us5nt8NsqcFmeVq2NnA2YD9LH0ToAyLNtnHRLy/ouf
   hvpP57aFcFH4IbuWZXtH1Fy9tTkrMpP/8RndTZHbal4Vy+3zlQ3T2NTVi
   d3TcP447nn25OqOe9ma8PZut8wjiSNEDEkGm+MlK+g4iaAAjyl9IZtoAn
   LAulVKgVg6zAqXdQpNccOSCaAnGjtf+751PD8wiGVE8XjxRb0JGDGmJBz
   sDZPnf29b+yY+ffTYmqDPOupGaAEcpMazKdqkJ7TUvscAdXXgGW1X3IQb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="39332518"
X-IronPort-AV: E=Sophos;i="5.85,298,1624287600"; 
   d="scan'208";a="39332518"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 18:16:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciDh6iFrges7JJSCSLUhv+CoraNPhqne5xDSP6eHIm3II69XNAXrra9QMHQdonaxiOgijNFoQW4hHgweh1Bww6ROYhsYIe6gfrfuwRH3BbfbAb9Pb4Ak6e0heWqhwyM3EX6afmoIl58gE7wbxqpb/HVPH8vvDgaYrO96IaDh6DaFqmFlRwbFfCmtkenkms+moZ9AtBvsJm/rCyas2XKKJryEWzXIYiiO8FFJOixkfU4rfLe0ozvRh0luQEycszlZUAcjg2wCm0RSuMkhkm0AicIZTG8Lonm5Wlkr7G+VmwFuqzMPzMZLY+/vSb7PGXtC+MaVd8LZ8cL+Pw4jE7DCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hsMa1yAdzEI0b3m6j302RXEV9tmUD1xwbMvariEe/zU=;
 b=boGFw33/KyvKl1FVChk/ZBbH430V0G3DCnh87a9PetajzkW+oqdpLn5YjV5I3TkoPMfAhLa+wK/tRzZZ+3MAOHy7VCUaBHMB/WDdRqqfYBd/d3JHKgxvjzLiBb0S62VufQTbsl3SClKClk/Ai7eNE33Fvf5NJPndy2mDxnQhtUhoPGr4xGsYzH2gCII9gYyPmV7rF53WOWvcQ7aj6WIpWp9oLAKclDFVGz1rr178IRHhds1nSRrUZWqVHkaVWVjsnj5n4K7xg3iN2eJILfs2SESWgkxcNdao2TRz2VitTgj+i0O9wVztlRvkeZJaFWEAKO/9wCfgzvwdLHqmohQeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsMa1yAdzEI0b3m6j302RXEV9tmUD1xwbMvariEe/zU=;
 b=M/wXmGlDfWAojJf6LNgOmnf3dwPd5EZ68Dn7eWfh0866p5uqeFG5+VClnkUIJ76AgosRLUxlYfM9eTpzLRHBzm6Q5TPEA6ylCE+70KjDp9XlvJmAaprAK+dOLsdU0TFeiMH22m8TOn9u+Zwp1zynWhzjtwKnasbxXmtZNL4rntA=
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com (2603:1096:400:99::12)
 by TY2PR01MB2793.jpnprd01.prod.outlook.com (2603:1096:404:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 09:16:35 +0000
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::1535:e824:b68a:c23]) by TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::1535:e824:b68a:c23%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 09:16:35 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v2 1/5] RDMA/rxe: Remove unnecessary check for
 qp->is_user/cq->is_user
Thread-Topic: [PATCH v2 1/5] RDMA/rxe: Remove unnecessary check for
 qp->is_user/cq->is_user
Thread-Index: AQHXn9KmQhbBlDeCCUmyKF3Qo+jU4quj7iYAgAKJPYA=
Date:   Thu, 16 Sep 2021 09:16:35 +0000
Message-ID: <61430B67.5000301@fujitsu.com>
References: <20210902084640.679744-1-yangx.jy@fujitsu.com>
 <20210902084640.679744-2-yangx.jy@fujitsu.com>
 <20210914183240.GA136302@nvidia.com>
In-Reply-To: <20210914183240.GA136302@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2593e842-c60c-4d65-cc21-08d978f2ae6b
x-ms-traffictypediagnostic: TY2PR01MB2793:
x-microsoft-antispam-prvs: <TY2PR01MB2793D972816232A0B423EE7F83DC9@TY2PR01MB2793.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Mzk3yyPG8veOgNJtRgpJXFAIibUn/ce9stvnpRWOx7QkAFHVsg6S1qv9Vky22MfYJPFaQB7Lqng+3HF5+5joVZ+pBIZTrGrMbrFSD5eL3v7mqRbJBSLfnvH8LVUAH5ZTcaydJECaZgZTeTMHrpuF+H8YafO0vgaB5sKMEf/1xaYWBqZS+dFmSz28nuVvGzInirkqDHhXBzX82feiue6m6tWytfZMUBT0r/UEzRlWTiL5+0KvbpYTcxzfWwaTex9jZq66GU6Hm+PXLNuPWlGq4vA+dZosXYhihSF/kEYiTniHXJ7JrtheRKCFcezZncoBCYu1sW9d4E3KmyBfJj/oOfq8Ekh/U8NPjEklYQgWEGKP30YMuV86yFNS97inWVInybyWbOMBUL/Sf1sNyULw9eohFPKmW2+sv7WaAAtlvyBl4UHCzCuesK54fB4hjLScvGBuxMByPJPIWxALfIyHxrJO/mDzk5Fch8jVaxQ/r1g6M86Fyy/gwABSV1GGmJbgUIglf0ZNex8yETptuI2Lf16yQOEI2EDBpg+5soEmTdQsXrnlK/YR+V38icFOXtWu5XOfzncqGXvauef5B3BJUq3USjdBR4xeOv3WaDF6vFr3/j0T7f73BGJSojX5f7lmDw5H9Dmm1YeYww5kiotKKv4JlbrYa8qbJLnScsnncge3DGg9XFtVBRD5yzk2z0jgIVMs5zsIN/N684qE85Qtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6382.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(26005)(38100700002)(33656002)(71200400001)(6916009)(4326008)(186003)(66476007)(86362001)(54906003)(122000001)(2906002)(36756003)(5660300002)(53546011)(64756008)(6486002)(6506007)(478600001)(83380400001)(91956017)(76116006)(85182001)(66946007)(6512007)(87266011)(316002)(8936002)(8676002)(66556008)(66446008)(2616005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZmpkTk50bmNsOFY4Y3VhMHJHTTdVbVdQK1ZBSE5TVmFCalhNY3h5eW1wdURQ?=
 =?gb2312?B?enh3Ukp3bnFxaHpZOU9iWnFTazE2bnpwb1dScGhSMU5pTlRzVVl5c3pSaUtE?=
 =?gb2312?B?REUwVU9Tb3RWVWVXaGJKcWZRdDFlbXlUc0wvUkNkNUZuQngvNEJSdWdFVTRw?=
 =?gb2312?B?cDJIc0J0RnBPWHZnQThucFphOVVqQmJUbUZudTZBTjEzL2NIMTluZzdqUVhr?=
 =?gb2312?B?b2lKUEJqOVRScEdkYy82bW5raUdNOGJZa0hGYThJc2RzRW9uRklTdE5WYjdK?=
 =?gb2312?B?K0VrUmhmZ3FNT0lXR0IvSjlkbko0ai9PLzhhcC9OTFFTTVlnSDRMS05mRkNW?=
 =?gb2312?B?OE0wNFZZS05GOEo1ZjBvNk9hU1pMZmplSDhiTFRlaVhiTWZVMWR0VEwzY1Uy?=
 =?gb2312?B?a3duay8xSEZ5Tm1vbCtMMGVRWFMrSE9WaWsxUEtvVVhibXl1eUJPTDNoRWR6?=
 =?gb2312?B?MG9KNitXeVc5bzMySmwvV3NvNVBrWFBUVDhWZVg2NWNZY2Q2bWRvM1Q4Vzht?=
 =?gb2312?B?bkVjUEdjNmMwOVAwSUpVUkdMdVNoWldnNnd3cnU0R054VktGSmVKSnp2Vk5j?=
 =?gb2312?B?Y2NCcEdpOEhmNjN6UlU3eDZWd3UyYkxPTjNrT3FlUDhoU0hQdWxhSTloOWc5?=
 =?gb2312?B?Y0l2anJYdkRGNURqQWltMnU1aVZoRWRrU01VRG1nK3pFMkkzSkxjWjBDUGNT?=
 =?gb2312?B?NVBqSjYyd0sxbDZaSnJISFArWEcrZXBEdjF2WXVEd3VQOElLS0JHQ1FzYkg5?=
 =?gb2312?B?OENlZDlMMTl5a1lnNGlMNWIyZnpvZm0rem5KYmhjOHI1VGJnUnBzaEFvMlFp?=
 =?gb2312?B?QWc3TnVnTEY0SERrRmkrd0FxdWdRaElFb0NPYkJyOGM5OFI2YnE4TkdONUFN?=
 =?gb2312?B?eGE1dnArYjY4eVhYNjNUYWR2V040blQ3Z2g4V1RaQ3dxWWhuNURpcW15NDJq?=
 =?gb2312?B?Wk5acWdNbm1iaWllS2d1YndYKzZ2R0RSRWV6eFRkSzA0cmNtN09BdVJoZmVQ?=
 =?gb2312?B?dGk2aXZVVlZUNUlxYVY3SUhSMzNoN09qOVdMWkg3b0VFMVlYVStGTnZXdkRH?=
 =?gb2312?B?eU91ZzN4LzJML29SQk95M0RQd2hQSUdsOVJDU3g1VElIWkZZSjd3bG1HQWpr?=
 =?gb2312?B?LzlrRmwrK3hFcmcyWXZnTnBrcDZhRXAvMW51MTEwbFJudmxSKzYvaEU1c3NC?=
 =?gb2312?B?WjM1K0xXVW8wZk96aGNQcTk2TU9nb2FzZjBkU29Vc1Rsd3ZBdjYvQmQweHdU?=
 =?gb2312?B?TDd3cDIyV01WVG9BQVdiK25rSlRqRjdtQlNIZ0Zja3oydVN6OU1VRUx0MXNN?=
 =?gb2312?B?V3BpODdtYTRXSENZc3c5Q09pa0Jkd3EvWTRyY3RXazdZbEdCTklwWjJWQWFW?=
 =?gb2312?B?T25KM0RFMEFWUjBaNE96WktvdnU5TkJTZk9ZL0FlTVROell2dFJmWVNBaFRw?=
 =?gb2312?B?N2MvOUlGcHd1MmlMYStWRkd6anZZQ281MUFGWEdnNGNHRldLaGZDc2Q1YVhk?=
 =?gb2312?B?c2xBc3VoVDExOW1lRERsMUlpT3BldnUwUEVnUHQ2NFpjbjJPbHI3Q2FjdXpa?=
 =?gb2312?B?WlhwMHN2bFZCWFdkczZtb2VVS0wyUGxxdGRmVmNZZjV2VzdSeGdNUXlSM2lu?=
 =?gb2312?B?c0xFZlp5Zk41ekRyd0R4SmY4Z0ttUUFURVcxZkYwL3ZpSVFFb3BQUm9ZL3pT?=
 =?gb2312?B?R3hZREtxZFMwTmRVZUpYY3BxOGhXNkNHNnJLVVNjeVJ2R0lpQ2hXUGhtUlhh?=
 =?gb2312?Q?WZHNY8OyP8ODDlE/6GWXvrjzRLd5sgzkx+JfNlq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <AD98D4E8B53785478B478E6841E9FD6F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6382.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2593e842-c60c-4d65-cc21-08d978f2ae6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 09:16:35.2269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDSPEfGZfQI0eVp6wkvI3qY/7tUbdEgLcBaodZgcUC/JeBoiRIky1PZN0PWLJlySxZHWItfwBsXu8MFZYgBjKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2793
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS85LzE1IDI6MzIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVGh1LCBTZXAg
MDIsIDIwMjEgYXQgMDQ6NDY6MzZQTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPj4gMSkgcG9z
dF9vbmVfc2VuZCgpIGFsd2F5cyBwcm9jZXNzZXMga2VybmVsJ3Mgc2VuZCBxdWV1ZS4NCj4+IDIp
IHJ4ZV9wb2xsX2NxKCkgYWx3YXlzIHByb2Nlc3NlcyBrZXJuZWwncyBjb21wbGV0aW9uIHF1ZXVl
Lg0KPj4NCj4+IEZpeGVzOiA1YmNmNWE1OWM0MWUgKCJSRE1BL3J4ZTogUHJvdGV4dCBrZXJuZWwg
aW5kZXggZnJvbSB1c2VyIHNwYWNlIikNCj4+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZzx5YW5n
eC5qeUBmdWppdHN1LmNvbT4NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVy
YnMuYyB8IDI5ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3ZlcmJzLmMNCj4+IGluZGV4IGMyMjM5NTlhYzE3NC4uY2RkZWQ5ZjY0OTEw
IDEwMDY0NA0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYw0K
Pj4gQEAgLTYzMiw3ICs2MzIsNiBAQCBzdGF0aWMgaW50IHBvc3Rfb25lX3NlbmQoc3RydWN0IHJ4
ZV9xcCAqcXAsIGNvbnN0IHN0cnVjdCBpYl9zZW5kX3dyICppYndyLA0KPj4gICAJc3RydWN0IHJ4
ZV9zcSAqc3EgPSZxcC0+c3E7DQo+PiAgIAlzdHJ1Y3QgcnhlX3NlbmRfd3FlICpzZW5kX3dxZTsN
Cj4+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+PiAtCWludCBmdWxsOw0KPj4NCj4+ICAgCWVy
ciA9IHZhbGlkYXRlX3NlbmRfd3IocXAsIGlid3IsIG1hc2ssIGxlbmd0aCk7DQo+PiAgIAlpZiAo
ZXJyKQ0KPj4gQEAgLTY0MCwyNyArNjM5LDE2IEBAIHN0YXRpYyBpbnQgcG9zdF9vbmVfc2VuZChz
dHJ1Y3QgcnhlX3FwICpxcCwgY29uc3Qgc3RydWN0IGliX3NlbmRfd3IgKmlid3IsDQo+Pg0KPj4g
ICAJc3Bpbl9sb2NrX2lycXNhdmUoJnFwLT5zcS5zcV9sb2NrLCBmbGFncyk7DQo+Pg0KPj4gLQlp
ZiAocXAtPmlzX3VzZXIpDQo+PiAtCQlmdWxsID0gcXVldWVfZnVsbChzcS0+cXVldWUsIFFVRVVF
X1RZUEVfRlJPTV9VU0VSKTsNCj4+IC0JZWxzZQ0KPj4gLQkJZnVsbCA9IHF1ZXVlX2Z1bGwoc3Et
PnF1ZXVlLCBRVUVVRV9UWVBFX0tFUk5FTCk7DQo+PiAtDQo+PiAtCWlmICh1bmxpa2VseShmdWxs
KSkgew0KPj4gKwlpZiAodW5saWtlbHkocXVldWVfZnVsbChzcS0+cXVldWUsIFFVRVVFX1RZUEVf
S0VSTkVMKSkpIHsNCj4+ICAgCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZxcC0+c3Euc3FfbG9j
aywgZmxhZ3MpOw0KPj4gICAJCXJldHVybiAtRU5PTUVNOw0KPj4gICAJfQ0KPj4NCj4+IC0JaWYg
KHFwLT5pc191c2VyKQ0KPj4gLQkJc2VuZF93cWUgPSBwcm9kdWNlcl9hZGRyKHNxLT5xdWV1ZSwg
UVVFVUVfVFlQRV9GUk9NX1VTRVIpOw0KPj4gLQllbHNlDQo+PiAtCQlzZW5kX3dxZSA9IHByb2R1
Y2VyX2FkZHIoc3EtPnF1ZXVlLCBRVUVVRV9UWVBFX0tFUk5FTCk7DQo+PiArCXNlbmRfd3FlID0g
cHJvZHVjZXJfYWRkcihzcS0+cXVldWUsIFFVRVVFX1RZUEVfS0VSTkVMKTsNCj4+DQo+PiAgIAlp
bml0X3NlbmRfd3FlKHFwLCBpYndyLCBtYXNrLCBsZW5ndGgsIHNlbmRfd3FlKTsNCj4+DQo+PiAt
CWlmIChxcC0+aXNfdXNlcikNCj4+IC0JCWFkdmFuY2VfcHJvZHVjZXIoc3EtPnF1ZXVlLCBRVUVV
RV9UWVBFX0ZST01fVVNFUik7DQo+PiAtCWVsc2UNCj4+IC0JCWFkdmFuY2VfcHJvZHVjZXIoc3Et
PnF1ZXVlLCBRVUVVRV9UWVBFX0tFUk5FTCk7DQo+PiArCWFkdmFuY2VfcHJvZHVjZXIoc3EtPnF1
ZXVlLCBRVUVVRV9UWVBFX0tFUk5FTCk7DQo+Pg0KPj4gICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmcXAtPnNxLnNxX2xvY2ssIGZsYWdzKTsNCj4gVGhpcyBiaXQgbG9va3MgT0sNCj4NCj4+IEBA
IC04NTIsMTggKzg0MCwxMyBAQCBzdGF0aWMgaW50IHJ4ZV9wb2xsX2NxKHN0cnVjdCBpYl9jcSAq
aWJjcSwgaW50IG51bV9lbnRyaWVzLCBzdHJ1Y3QgaWJfd2MgKndjKQ0KPj4NCj4+ICAgCXNwaW5f
bG9ja19pcnFzYXZlKCZjcS0+Y3FfbG9jaywgZmxhZ3MpOw0KPj4gICAJZm9yIChpID0gMDsgaTwg
IG51bV9lbnRyaWVzOyBpKyspIHsNCj4+IC0JCWlmIChjcS0+aXNfdXNlcikNCj4+IC0JCQljcWUg
PSBxdWV1ZV9oZWFkKGNxLT5xdWV1ZSwgUVVFVUVfVFlQRV9UT19VU0VSKTsNCj4+IC0JCWVsc2UN
Cj4+IC0JCQljcWUgPSBxdWV1ZV9oZWFkKGNxLT5xdWV1ZSwgUVVFVUVfVFlQRV9LRVJORUwpOw0K
Pj4gKwkJY3FlID0gcXVldWVfaGVhZChjcS0+cXVldWUsIFFVRVVFX1RZUEVfS0VSTkVMKTsNCj4+
ICAgCQlpZiAoIWNxZSkNCj4+ICAgCQkJYnJlYWs7DQo+Pg0KPj4gICAJCW1lbWNweSh3YysrLCZj
cWUtPmlid2MsIHNpemVvZigqd2MpKTsNCj4+IC0JCWlmIChjcS0+aXNfdXNlcikNCj4+IC0JCQlh
ZHZhbmNlX2NvbnN1bWVyKGNxLT5xdWV1ZSwgUVVFVUVfVFlQRV9UT19VU0VSKTsNCj4+IC0JCWVs
c2UNCj4+IC0JCQlhZHZhbmNlX2NvbnN1bWVyKGNxLT5xdWV1ZSwgUVVFVUVfVFlQRV9LRVJORUwp
Ow0KPj4gKw0KPj4gKwkJYWR2YW5jZV9jb25zdW1lcihjcS0+cXVldWUsIFFVRVVFX1RZUEVfS0VS
TkVMKTsNCj4+ICAgCX0NCj4gQnV0IHdoeSBpcyB0aGlzIE9LPw0KPg0KPiBJdCBpcyB1c2VkIGhl
cmU6DQo+DQo+IAkucG9sbF9jcSA9IHJ4ZV9wb2xsX2NxLA0KPg0KPiBXaGljaCBpcyBwYXJ0IG9m
Og0KPg0KPiBzdGF0aWMgaW50IGliX3V2ZXJic19wb2xsX2NxKHN0cnVjdCB1dmVyYnNfYXR0cl9i
dW5kbGUgKmF0dHJzKQ0KPiBbLi5dDQo+DQo+IAkJcmV0ID0gaWJfcG9sbF9jcShjcSwgMSwmd2Mp
Ow0KPg0KPiBUaGF0IGlzIHVzZWQgY2FsbGVkPw0KSGkgSmFzb24sDQoNCmliX3V2ZXJic19wb2xs
X2NxKCkgaXMgY2FsbGVkIGJ5IGlidl9jbWRfcG9sbF9jcSgpIGluIHVzZXJzcGFjZSBidXQgcnhl
IA0KdXNlcyBpdHMgb3duIHJ4ZV9wb2xsX2NxKCkgaW5zdGVhZC4NClNlZSB0aGUgZm9sbG93aW5n
IGNvZGUgaW4gcmRtYS1jb3JlOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbGliaWJ2ZXJicy9jbWQuYzoNCmludCBp
YnZfY21kX3BvbGxfY3Eoc3RydWN0IGlidl9jcSAqaWJjcSwgaW50IG5lLCBzdHJ1Y3QgaWJ2X3dj
ICp3YykNCnsNCiAgICAgLi4uDQogICAgIHJldCA9IGV4ZWN1dGVfY21kX3dyaXRlX25vX3Vodyhp
YmNxLT5jb250ZXh0LCANCklCX1VTRVJfVkVSQlNfQ01EX1BPTExfQ1EsICZjbWQsIHNpemVvZihj
bWQpLCByZXNwLCByc2l6ZSk7DQogICAgIC4uLg0KfQ0KDQpwcm92aWRlcnMvcnhlL3J4ZS5jOg0K
Li4uDQoucG9sbF9jcSA9IHJ4ZV9wb2xsX2NxLA0KLi4uDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpJbiB0aGlzIGNh
c2UsIHJ4ZSBoYXMgbm8gY2hhbmNlIHRvIGNhbGwgaWJfdXZlcmJzX3BvbGxfY3EgZnJvbSB1c2Vy
c3BhY2UuDQoNCnJ4ZV9wb2xsX2NxKCkgY2FuIGFsc28gYmUgY2FsbGVkIGJ5IGt0aHJlYWQsIGxp
a2UgdGhpczoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpbIDEyNDcuMDYwNTg3XSBDYWxsIFRyYWNlOg0KWyAxMjQ3LjA2MDU5
Ml0gIF9faWJfcHJvY2Vzc19jcSsweDU3LzB4MTUwIFtpYl9jb3JlXQ0KWyAxMjQ3LjA2MDYzM10g
IGliX2NxX3BvbGxfd29yaysweDI2LzB4ODAgW2liX2NvcmVdDQpbIDEyNDcuMDYwNjcxXSAgcHJv
Y2Vzc19vbmVfd29yaysweDFlYy8weDM5MA0KWyAxMjQ3LjA2MDY4MF0gIHdvcmtlcl90aHJlYWQr
MHg1MC8weDNhMA0KWyAxMjQ3LjA2MDY4N10gID8gcHJvY2Vzc19vbmVfd29yaysweDM5MC8weDM5
MA0KWyAxMjQ3LjA2MDY5NV0gIGt0aHJlYWQrMHgxMjcvMHgxNTANClsgMTI0Ny4wNjA3MDFdICA/
IHNldF9rdGhyZWFkX3N0cnVjdCsweDQwLzB4NDANClsgMTI0Ny4wNjA3MDZdICByZXRfZnJvbV9m
b3JrKzB4MjIvMHgzMA0KWyAxMjQ3LjA2MDcxM10gLS0tWyBlbmQgdHJhY2UgMjRhN2QyMjE3ZGE0
ZjJiNSBdLS0tDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KDQpCeSB0aGUgd2F5LCAgSSB0aGluayB0aGUgZm9sbG93aW5nIGNv
ZGUgYWxzbyBpbmRpY2F0ZXMgdGhhdCANCnJ4ZV9wb2xsX2NxKCkgaXMgYWx3YXlzIHByb2Nlc3Nl
ZCBieSBrZXJuZWwuDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQptZW1jcHkod2MrKywgJmNx
ZS0+aWJ3Yywgc2l6ZW9mKCp3YykpOw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpCZXN0
IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4gSmFzb24NCg==
