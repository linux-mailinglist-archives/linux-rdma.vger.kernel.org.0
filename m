Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1704920D1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 09:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiARICH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 03:02:07 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:7028 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343834AbiARICG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 03:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642492926; x=1674028926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
  b=wdUIgxz0P7TPdjMnEqMzEYCy4l72hfWSwrsbJsEWhj0MhQvffvXgPZo5
   9m+p860kZNd5xGWxDNFb8Ivpctid9Fy3fMxIOUF0LINF+Q2j7Ts5IbM+i
   AChbeN6tW03jeIxbamdyrT84XoURIPz1eZLU/u7rHpHoDfdTtiGAUkeM2
   HjyEUw41HX4MZ5vRd50f5zbmUVAFUsDiMMnUdHF77WoMH9FLglSSzNYGY
   0YbgnVKEHQDGU/DA6ccWIlAPQgZa36QkOh9+CEDjQ6EUzsb3ZA+pbMy2g
   /pq8+/3YTHud+FYpRi3oOX/Y3MsvaGnbu4eTK1OIcKwNupaS0oUGQ+zYO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="47704233"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; 
   d="scan'208";a="47704233"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:02:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx5iyxzrp85Y2pkSFiYhvHeXbLCDdVme6b/25jfRMcJJvzGBtdHnu/2Bx0cnubSEt5adVtHDouIIWzLK8aDq0F8MsZyp2KZFCwik0j5x7eg/6VNnu5vIIpt0Ef7GA6vihUc9HovfZ7jMTbQJVzffRa1QihNkZauVVvAlfU5j2E4qJdez9lrK7yXLfP0u3GFw2PDL2B/F+1OnIgCLEolG/j24bjCuTbG0jriVutq5KVTCdHHcqAN3qL2Fvxgo1LNJiIsC0RBUh2GYGEpIJOaV2JcBpEDq7OHBR6eTt+UjpocapDNhDoiQWVoTzBfDrMNCh9atpq0+xGF9IAlfZoRy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
 b=BeiiD45hSXgKR4VgHGwCohu+jaHA+DUSmbUpZDbctd1Umh04wnF9VoU6wo9jTRx+O9w10svWPIy/QcyZiAMS5Xi8U1QCu5jECdC6t9eJxldXFdmq0LLZdeRU1yOThVHAhDu5/jhvjJqiI3bBUcmb9qc/W+y8YOvaw9IPaDbrlHb6bs9515Nv67Jb7wMoeeuYkWDAOpFNWw80oHUaMCNE8T3jbKGhlxkIvLKuoMfWaddhDw1fhet3HS0lF7YyFbsKOIwH+ypCGWcNQWdxu+EzMSLcPR0zKLbYo2KzrzSaK6RzgcH9QCcvhDDectOoWE8jdkE9uwggrO2LPIkoM6c0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
 b=n9zBZ/LKPzCxKQBWHaFcpDrGuP9+wdGpU8fW1qaytJ6KxzLlcCI0sTkeMrGwWlpR0fW52yNi5osq6tRqY6nOj0hf+MdsD6chTBQhzXbLdL+SWEMEzVQdV4oUmJ65B7y9sp+Ch3385fVTPIg6/RqoZuEXTlxo4MxK2wfZMnESb0M=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYXPR01MB1757.jpnprd01.prod.outlook.com (2603:1096:403:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 08:02:00 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:02:00 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUccBUAPZcPEOP46lbsjIBJKxnOIUAgAE6bAA=
Date:   Tue, 18 Jan 2022 08:01:59 +0000
Message-ID: <61E673EA.60900@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
In-Reply-To: <20220117131624.GB7906@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01985164-ddd0-463c-88b3-08d9da58ce2b
x-ms-traffictypediagnostic: TYXPR01MB1757:EE_
x-microsoft-antispam-prvs: <TYXPR01MB1757D21909BDEE629A1E946583589@TYXPR01MB1757.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lERyQW8P4eUEYo3GY34X12FMwIpzL7sjBcW6xF2PihNP0G6myX2uK9sMYC9F2vOCBLYqEBn4PC95qZ827Ewqb86reUyd8Mt/b/HN4jwg52HzXH1m5oLVMHBe2isdUjWKHWaRzxegzE3xqZ8+jDW2uJ0+CemmSb3VGKfOtn9SNSAXRprnGoNmR/2Q/n+rqBlSAemGeESdn3h6Xp7sA1z5VdhxwXyytalv3JGEXCo37G+T/H+wa6yDwpWfskKFuUL7FAB/UKClqAmQxb9iYzS2uKuEg5I04PVKBZNwNzP6RDS8w5yf2U1WNWfvv+7lX9h547eXVkPv/r9e778An8NIuSB3qaS2EM+UAWbc/0fXkJA5X1hw3NnQin/reyHcGQ7a4U3+6r09KQesf2lf6p5ZumTHV8DJXXsxiK5Ls3/QoybdFbjFCxkteoo8vovz0tdoImUq5FD+Uy9qH6lfIiYdK6DRJNPbr4UjNgjvae++zT6GASBJAqsv56VRqqNKzRKzwSXn7x6Zzh3cJj/5sXGZOnfwxOpiGJ/oKgBVloIQUQXNB30TX8FTdo+taPg4WfDvBJz3GA20HRnUqx3+aa0K63IWM9mxnPQQvuHpcv7Yu5dYXic4sLnFkqRDrhc9NkqdVhtbqdBy34cmYf7glRhFwYglTJ8x2HaF6V5cAdz4/ZpilqWXYgDM0+4qNQthwdHdfkfaNG/AR27jR+A0aCmyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(4326008)(38070700005)(6512007)(316002)(86362001)(71200400001)(6506007)(91956017)(64756008)(26005)(66476007)(33656002)(186003)(66556008)(66946007)(66446008)(82960400001)(38100700002)(76116006)(122000001)(508600001)(2906002)(5660300002)(6486002)(6916009)(54906003)(85182001)(36756003)(4744005)(8676002)(8936002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?REZkekpBM3pocUxzOU5Vc285YU1EaEtscnMxbmNXNE5nR21RcDA2TG1hdURT?=
 =?gb2312?B?VVBFYlNid1F6UnRGenJGODl5enoyVUpLUndGaHA4OTNtb2lxQlRzVmR6cStl?=
 =?gb2312?B?M3VZOTB5Q2lqUzRNSFhHQTdnekJJdjJxS3Raay9iT1o4TndWR2x6RFBqYk5P?=
 =?gb2312?B?S3lZMnhncTFkaEZNQzlPbXFadDI4bmZneE43VVRzVlRESmd1blBsZFFQVXhT?=
 =?gb2312?B?UHpiNGh0LzFVbEVacUpiZW5jMnN2bEZScStGaE1DL1RvMGJBTk1Sem1NeUtp?=
 =?gb2312?B?WHVIMmRKYXJwY1lheUoyblI5b3Y0Y2tjZytQYWNVS1p3UTZCOFVSWTdJc05K?=
 =?gb2312?B?dDhkaGk0ZmtEZzZ4VU5wa3BBWGxmQlZrN1hVb1VMMFptaDdwTERuSmZIMStj?=
 =?gb2312?B?SmhlNllxVUxQcjNwZVpQKzNkUHRUTnRSbXd3SUl0R1NScVE1M0RNdklLcTJQ?=
 =?gb2312?B?TFZaZEVEMWRQY21EY21CL0RFZ0JiQ3RLRzhydm9DQkppRVhLR0txT2RVMEFQ?=
 =?gb2312?B?ZUNYR0s2K21XcmtQbTk0K3ViS0FyR2lDNnpNWUlZeWsrNkM1Skl0UG9sMDBa?=
 =?gb2312?B?a1RLWm5KZ0NhYWVTUEg2VXlkV2g3Vm8wZHdFaWpDVmhtTHgxV2gxN1NtQzNY?=
 =?gb2312?B?QmpZQlNsWDRRZzd0WEVvL0dGY1I1TDBLZFRTUklTMHIycWxDYmUvTVM5QVYy?=
 =?gb2312?B?bitUTlBSdnRPWUUzWTVLblVYb3ZvOFA4c3VrSHRxRGxPd2NFeUwweGp1eEc1?=
 =?gb2312?B?THZkQVRrUXFRUzU0YlN5c0JXVkZMNEZGVk9maUlmK1VFUk45U2tPeEtTQTUy?=
 =?gb2312?B?bm13VVFEZnRGdHBhWXppTWdLSUNoanpDd1NDTUQ4R1dpTkxJeDE5cm5jbmdR?=
 =?gb2312?B?MUZkd0lkZTBGQmhSNEdRTDc4dXlrME50MVBlTkQ5SnZlbnR1bzJETUtFNWQ5?=
 =?gb2312?B?YlYvQnhyRm5vS1QzZ0Ira3lJNlo2WW5TTXdDYnVXTUxJUmdoWmFxUFk3UDF0?=
 =?gb2312?B?c0IvTFI1ZXZ0NzJCZ1B0RGp0a1NyejgrNjAwQ0FvZTlsRlRIY2l0UytKeXJx?=
 =?gb2312?B?cVVwMlNBM1JCZitUYzBJWU5YeFZVY29nYnQydnFRMlVSWktyR3krNm9SQjUw?=
 =?gb2312?B?ck1yem1oaW05QnQrNmd1R3lvcHMyYmU3MXNXVk9aMWpxZ1FuZWFVcFFHV0JT?=
 =?gb2312?B?N2xYRkVXS3VHZ2FkZDVsTmwwRjNncTAvWFBYWG0rNm5GeVYrYlBxZW9kVFRW?=
 =?gb2312?B?aG1kQ3lwdmErMm1iTlo3cy9EUDBIZFZyTGw0dHZhUlJHM3J6cDUzV1hra2Rj?=
 =?gb2312?B?UnNuaWRJOWVYSjI4d0lRMEpTQUl6QkJPQ0ZwNGtxSjhDN3ZIMmRjVVJTSk9j?=
 =?gb2312?B?SHZpLzhJRFdsV3F6Uk9hNnIycE1wSFlkKy90WHZIa1djV3VwK2w0TVdFcSt3?=
 =?gb2312?B?ZHlpQmx0YTdHREZBSFRhckZFSkNMSVhCdVNkTzhueHN6c3lmRHErTkZUU2N3?=
 =?gb2312?B?OFNyMDAvc055VmRCUTJnc0VrZmpnSURmTTUyQm9kRTRUTnBjTjlmUTBRR3E1?=
 =?gb2312?B?ckFGdEJIYjZtWHZvYkNXeW5zM0ppRy9DUkF4TjNuWVlxRXZ6d2ZMVSt1VHpZ?=
 =?gb2312?B?cVJISWJpSER2S081aklKTVhLbmtQRG55Tmw0dk9DM1U1SlljcWUxTWU5akhZ?=
 =?gb2312?B?dHlmNC9halBnVzNEUkFUY3RPQm05VFFLb3k2RW54UXluMXVEb1NJNnpXNTlz?=
 =?gb2312?B?bS81ME04ek1wL0RDVmlPM1FESFB3QmN3K3o0TW5xaTZoV0JTdWh4S3hUVGtF?=
 =?gb2312?B?ZW5tQVVNekNkMW8xNE1uRnc4UXl3bmNjZUNBZUtXTjUyb0JweUFmdmN5aVZJ?=
 =?gb2312?B?QXg3elVPZjN4UVl0U0h4OXpwVEgrVWxNVWNiRjUwV3dkWHhrY0xCZG9ockg0?=
 =?gb2312?B?bVgzeHN4Z0QxWjJ6QmZxMG55Mjlhbkg0RUhkck4zZTNEcllCWlBYSWdldk5I?=
 =?gb2312?B?eUN1VlNzalRaQll0QUtkcE9MbHd4aC80eWM5b3BzajZoUjlpR1VwYi9uTmd6?=
 =?gb2312?B?QVFxZDNnM0dzdXVaeGV4cEdScDVSbHJnbHdRWHhWRDRKZzZFREVydHRhUFpM?=
 =?gb2312?B?ZzJhNjk1S3VidkJpU1I2dXd5eGY1ME9Jc0k4SEdOK21MT2ZhNUFlSDRXcFB0?=
 =?gb2312?Q?5ATA0D/RsnC09Gxh9SX8AeY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <79DC5495A485C149BA0F94C70E4BCF93@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01985164-ddd0-463c-88b3-08d9da58ce2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:01:59.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4ikuDzGLoOuvwGTaiS4JIvrHGXWIJCfwX5ewkbs1jIftjSo2DuwTsjx+e/I5z7qpR5BZ9fAeGFxfB3qwOggsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1757
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzE3IDIxOjE2LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFRodSwgSmFu
IDEzLCAyMDIyIGF0IDExOjAzOjUwQU0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+ICtzdGF0
aWMgZW51bSByZXNwX3N0YXRlcyBwcm9jZXNzX2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX3FwICpx
cCwNCj4+ICsJCQkJCSAgICAgc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KPj4gK3sNCj4+ICsJ
c3RydWN0IHJ4ZV9tciAqbXIgPSBxcC0+cmVzcC5tcjsNCj4+ICsNCj4+ICsJdTY0ICpzcmMgPSBw
YXlsb2FkX2FkZHIocGt0KTsNCj4+ICsNCj4+ICsJdTY0ICpkc3QgPSBpb3ZhX3RvX3ZhZGRyKG1y
LCBxcC0+cmVzcC52YSArIHFwLT5yZXNwLm9mZnNldCwgc2l6ZW9mKHU2NCkpOw0KPj4gKwlpZiAo
IWRzdCB8fCAodWludHB0cl90KWRzdCYgIDcpDQo+PiArCQlyZXR1cm4gUkVTUFNUX0VSUl9NSVNB
TElHTkVEX0FUT01JQzsNCj4gSXQgbG9va3MgdG8gbWUgbGlrZSBpb3ZhX3RvX3ZhZGRyIGlzIGNv
bXBsZXRlbHkgYnJva2VuLCB3aGVyZSBpcyB0aGUNCj4ga21hcCBvbiB0aGF0IGZsb3c/DQpIaSBK
YXNvbiwNCg0KSSB0aGluayByeGVfbXJfaW5pdF91c2VyKCkgbWFwcyB0aGUgdXNlciBhZGRyIHNw
YWNlIHRvIHRoZSBrZXJuZWwgYWRkciANCnNwYWNlIGR1cmluZyBtZW1vcnkgcmVnaW9uIHJlZ2lz
dHJhdGlvbiwgdGhlIG1hcHBpbmcgcmVjb3JkcyBhcmUgc2F2ZWQgDQppbnRvIG1yLT5jdXJfbWFw
X3NldC0+bWFwW3hdLg0KV2h5IGRvIHlvdSB0aGluayBpb3ZhX3RvX3ZhZGRyKCkgaXMgY29tcGxl
dGVseSBicm9rZW4/DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBKYXNvbg0K
