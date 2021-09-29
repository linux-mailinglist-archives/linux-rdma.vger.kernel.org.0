Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3E41BE75
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 06:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhI2EqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 00:46:19 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:35196 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243866AbhI2EqS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 00:46:18 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2021 00:46:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632890678; x=1664426678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l17cjP7tji8SHSQSWj8TIc/Wo4SlAt2uZsuMFMrABqs=;
  b=v5nEGvIzMldU5CWdkH8zMfh8CrkTqP+A8GLzxxDuWv4Idg58aAks2/Yh
   uLO74qgoQKoOp1b0T508EIoVq1XZLhER+1TrL5+i62DfWxu5fv66X1gsb
   35vLox0RohC1wOZ533G2sjjCrgrQFaITlKzv+VTPyiL54Dq6lsvhHD6Wl
   Dw3UPZlaqy69o6Q0/p9a0tsnlKz7Jma0f+ACLRR2pjTb+SX6kRY8CyvGs
   fSSLGXK18KFSJ7ollzYZPak+NQ3TPHAzEy2v4e8A9Bf8iNhQIOAxz4e+z
   f9qRgDvslC8f8Zk+/4qiyANBPbtCR+MYokLAg7VoVOKorDRtNAU44/+wG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="39884326"
X-IronPort-AV: E=Sophos;i="5.85,331,1624287600"; 
   d="scan'208";a="39884326"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 13:37:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8gc7QNaqDA3XyVjJMHOuWdI68pAA5ixevoE/DUH0a3s7f3GzCoozf7N78Sma4+jMRTzQxiUWwfhCwn8ToHsaCmrFcRsiRkaqlutYXlX3YlrFgbYYRlpyYtlWIfmLIHblPYlrDeqbbrtTfeg93GrLy349GsO0uvaDsWHiNPdzhY8AhcRg0vNKIvMbJ65F21H2ttneLH+/65ICf9+CuPVsdNcO7UlhrUJPeO48o/BPpZRnPRhO0yf9vgHAR/AkDmvN7HVHSJlbIwxYQMnaIa2qN0OltL0xQweetkAc3rRHxzt5+3rjgMR48iPLlYOExarlBLvQ/IS4yrfr99JhhXalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l17cjP7tji8SHSQSWj8TIc/Wo4SlAt2uZsuMFMrABqs=;
 b=Xw1nwQCkQZlN+KsiHPQJItK+4/YXmVKrGd0GwqQBuknTDMafMmyOy89bynXcT15f+db9PGLY0tRy0RwrLjWW+NcIizm9Oka+xaf1WFMbl4w9jmLazbFjM1PvS9UbeDwGb0lu8jrNrWEblXPL8FP8fDOkelFUfbzCZohIwWKt3vG1yfV1GgD87TIt8xzBp9Z0RTUWHy6ZjzRSlbVi94OFuDAM74QCP+RoIDn3hXXKLOuSKX7HgIU8UJuRoEPAyyvIuOr7IasjyHQtfmLxle1iRrsuFBLeOel4Sfk7VP8wz0SfvGIrmLrveBnEnVy0o7Q01zhF6QGFWKefN/QbqtkAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l17cjP7tji8SHSQSWj8TIc/Wo4SlAt2uZsuMFMrABqs=;
 b=owU7+u60pN4v0wz9Dy+jBNfeIJYgSZRpnZn8JobNTcs2aKXIYLXcusfkr13m8G1cQO9LfmnxfELt2d82qrXyznR0ewQ/W8n+Jsug/Ck6VhOvosB/BaMnAKHb8RDIxRyhD2OAvKSapY156qzekNaXzcilR+e+aEqt5KZ0d0/i+lY=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OS3PR01MB8588.jpnprd01.prod.outlook.com (2603:1096:604:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 04:37:23 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::bca0:815f:1da0:911]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::bca0:815f:1da0:911%6]) with mapi id 15.20.4544.018; Wed, 29 Sep 2021
 04:37:23 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx5: unify return value to ENOENT
Thread-Topic: [PATCH] IB/mlx5: unify return value to ENOENT
Thread-Index: AQHXoJ/HyxlES6SvX0+PJ4+/45Jv8qu51b8AgADAF4A=
Date:   Wed, 29 Sep 2021 04:37:22 +0000
Message-ID: <ea12fb42-97e4-0321-da0d-049a0650db9f@fujitsu.com>
References: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
 <20210928170846.GA1721590@nvidia.com>
In-Reply-To: <20210928170846.GA1721590@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a47b97-3685-421c-5559-08d98302d4a5
x-ms-traffictypediagnostic: OS3PR01MB8588:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB858858498EF9E5CC6AE61C92A5A99@OS3PR01MB8588.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dXZ+vEi7cAYVXEGuzEhyeH2m0PZ8huKp88INz7vldP1vfjT5v2UuI8KIhulSVqSfpmD35zf2QWi//dZec9ZjP+MG6Fk1+P6y6ro47DySguVpM2BPMYNEq9uw08UjEW8OJU5Cad9FlCZxyryT7B8NWYSdooFDnlqN0xt2CMibOG7cGQcc7QNvNdicBO++qAuJne+mwSlE8Eo2bkufR9ytcmlNnrJpRq9LTpA7k2vxfB2SSdkFxu4/LLTa198Z/gByYZDsBwUvcCIuV1q11u+lRTRUM7BnxpYLCsTUE+xk/Y4+g/b3HBPyt5wXIjvSXEEWyFfpE6RAdEXRmosKzX8RMgM6NUlejeYC0IEx/hgXX1n0WrMPKvV77TyyEcAv6cnYTGge5gUL0niARpQW5EKNN7Rga6CsGvhOjqNra84HbfT3Af0IAD+T5PC/BOYMuOZfHKFqcAfCxWkb27HlThYu36ym1J8tV2EvSOxjKRGSMopyLX3ujMszVDPvCLf/2loQZEFgTTfOLUdKoBwBXeKvjf4PGBIaNxQR6YXG/jeg9Hs9KBFMrtKgnkW9QaKUSLp/t/vjMLnHMjHDYc1LCFTp9Lb1SC3GOhZT0tjxpVTGjKLn/YKx2+EFcrrPZhXBAVtJ3sOhut2cHL2emUGdYelLK96EXuIQdB43l4kDP48qHUkf84DdZDZCj4ft/rVXQTfD7sYhUDrMd1YN2QQePURHDaJexhAsSdPKkPoExOqJKPJNMSGUqVfa2H+OAKyFyYNApRCT0TB8PA6Mi6aArwdeKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(26005)(36756003)(38100700002)(8676002)(316002)(6512007)(2616005)(8936002)(31686004)(86362001)(54906003)(31696002)(5660300002)(508600001)(4326008)(2906002)(186003)(66556008)(85182001)(76116006)(91956017)(66446008)(71200400001)(66946007)(64756008)(53546011)(6506007)(83380400001)(6486002)(122000001)(66476007)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTFzcEZ0SlA4WHBpR1ZwUHdKQjJTcm5pSko5dmNmQnJEclRpS0wzMFduR0ZD?=
 =?utf-8?B?OXAva1JUQW1lNjc0YVhZTTg0bUQyZ3VLZ0ZFeDdWN0YrRHkxS241RzVCMDFI?=
 =?utf-8?B?d0diR2FaOFZDcCtkWHgwaVBiK1BpKzhwSjNybmprOWhDNkhjNkJEZ2h5ZUl6?=
 =?utf-8?B?V0VjWk84SnJRSktRZDZXd0xTcG1LMmM5MG1XMm55V1l3MmMyTlRXQVFFVWtM?=
 =?utf-8?B?R2xkdmQ4bU05dW5XQ2JGaDF1NS9ma3o4cnMwR1FQOVpqQUNWV1V2TVhjSHdn?=
 =?utf-8?B?ak5TUjFMMGkzYnpwMTNsWk51N3pmTjNYMFZISlB1MElZVUE0MEZaU2FlVzhS?=
 =?utf-8?B?SEF3NGlwYmFOLzloZzN4NDI2a3pwbU9tUllvUFpoU0NtaTFOaWdlWE9Eck9D?=
 =?utf-8?B?N3JIdnk3em1aUENQVnZ3LzF4KzFCUVFCWkJIdzZoVmMrN1FvdjRTL2VoK1Rz?=
 =?utf-8?B?SlRFNWNKUE93cFZHOFY1dDJyMWRzNm5ieEMrNTg1RXpnVEdscU9IdGljUGpB?=
 =?utf-8?B?MnpLUHVmY3VhRmd3b0ZKTHh4Wm1ONVZreGx2QVJjMlBVQUYySm5Zc3ZRSHBw?=
 =?utf-8?B?RVE2UmY1RHR2NnlTZUFhZGdBL3dpUHkxK2NxR0swMG85Rm1yaEcwbzFYSkxZ?=
 =?utf-8?B?TXBGSm8rSHZrL0hnMWxzWkEvVThZRVZ3N1I4cVF0OTZQTnNIRzk2NHRBZlpl?=
 =?utf-8?B?U2MxUHc4OXFQVWMvRnJaSzBURWZDSDgySDZMM1Jma3BkcmNtUzJ2VUlWUzV5?=
 =?utf-8?B?S0VxUGQ2N1ViK0xKaDdVN0Q5Y1MyTmJSblA2bm8vN3pzbjhXRFFYcmtQNjI1?=
 =?utf-8?B?TkY1MjZjWWpqdE5GaDR6Uk5vT3N1b24vaW9ERG42QlBoM240R1A5anNEc0My?=
 =?utf-8?B?Y29oeWFDeU8wWmJNWTk1R3U2ZmlZT05oSGxTbVJCTlZ2QWtlU0lNaENSYWtP?=
 =?utf-8?B?Ujh5eEppMHkvQTc1Zzd6YTZRR1o4Q0h3bGFiUFd3S09CUG9yVWtUK2xjOURm?=
 =?utf-8?B?cjJzN2xiRjZTWTBXNlZOcjhNSHFoNzhJbkZQUmY5ZStSV0dTZG5VZS8yNXFu?=
 =?utf-8?B?VTdBcUNQbU9SbjFLNk9NY1VGeEt2NVlNRUg5SE5EMFcvczBFTWFaOWlHY0Vr?=
 =?utf-8?B?cUdiMmFoRWNpRzMxM210NkhsNGIvVXAzM3ptMDFSZ3NsTnVNRjhkdzFtRXJs?=
 =?utf-8?B?SXdhY0ozelZXYnpUZVovMmtDMzdpNzFTaE9paWtaWEJQS1NVMDRHYVFnYzZ4?=
 =?utf-8?B?bmpNOWlWdngvdDFNM01NOFdrNjZoUFlIRExsR3FGL3ExSVVQRndXVjNlNWpq?=
 =?utf-8?B?eHl3dkh4LzhzdEZad3ZOUGdPOE5pZGhUOWw2M20vc0VCalRJZE9XVDl2dE90?=
 =?utf-8?B?NlhOdWlGVDRxbm55NjVpY1hXdkFFeUVwbW5BL1paYXJaZEo5VldDT3o3bzdF?=
 =?utf-8?B?S1h6aVVHVUhPcEVYRnMxUWRqVzhYQjB3eWJmWmRaT2dyUTA2ZXc3eXZmOFBq?=
 =?utf-8?B?R1lNNDV4QVhOd21qZVVSQ2poVWZkZ3hYUlVOU1ZLU1JJZmhScmZCc0w1ZzZT?=
 =?utf-8?B?MXh0eVZGTjRWMElVb1BISW1Da3poaWNRMFh2UUorbjYybittVzNVeUoyRFJU?=
 =?utf-8?B?SkFjdFRBZWk0WVF1VjY4ZDdsYkNNMmF1NFFHd0w0NzJIWENKRzljTWViMFdH?=
 =?utf-8?B?K1A4ekIzOEU5c0tudzZGbHkzaWJYRTQwT05paVhHdkNJM21pMjdVMUcrOThq?=
 =?utf-8?B?WG1KbkxXeW9nenNQT2FrWTJVczY4c0dxeDh2RHpHc2Q0VGxncVdCSU9yL0x3?=
 =?utf-8?B?ZXdkQlBad1B3NDFoRFh6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D50313A46B18B429D5A9F94FB18CC73@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a47b97-3685-421c-5559-08d98302d4a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 04:37:22.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjzCvznlhVNUDMQ3SP/CfcVVpqvdSpdz+VHOBToMRsRWyzZSAlIuCfd6TCD3e7PdSInC1AYtct6Aq2XCNGdABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8588
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U28gc29ycnksIEkgbWlzc2VkIHRoaXMgcmVwbHkgYXQgcHJldmlvdXMgcGluZw0KDQoNCk9uIDI5
LzA5LzIwMjEgMDE6MDgsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gRnJpLCBTZXAgMDMs
IDIwMjEgYXQgMDQ6NDg6MTVQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+IFByZXZpb3Vz
bHksIEVOT0VOVCBvciBFSU5WQUwgd2lsbCBiZSByZXR1cm5lZCBieSBpYnZfYWR2aXNlX21yKCkg
YWx0aG91Z2gNCj4+IHRoZSBlcnJvcnMgYWxsIG9jY3VyIGF0IGdldF9wcmVmZXRjaGFibGVfbXIo
KS4NCj4gV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhpcyBpbnN0ZWFkPw0KVGhhbmsgeW91LCBp
dCdzIG11Y2ggYmV0dGVyLg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQoNCg0KPg0KPiAgRnJvbSBi
NzM5OTIwZWQ0ODY5ZGVjYjAyYTBkYmM1ODI1NmU2YzcyZWM3MDYxIE1vbiBTZXAgMTcgMDA6MDA6
MDAgMjAwMQ0KPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBEYXRl
OiBGcmksIDMgU2VwIDIwMjEgMTY6NDg6MTUgKzA4MDANCj4gU3ViamVjdDogW1BBVENIXSBJQi9t
bHg1OiBGbG93IHRocm91Z2ggYSBtb3JlIGRldGFpbGVkIHJldHVybiBjb2RlIGZyb20NCj4gICBn
ZXRfcHJlZmV0Y2hhYmxlX21yKCkNCj4NCj4gVGhlIGVycm9yIHJldHVybnMgZm9yIHZhcmlvdXMg
Y2FzZXMgZGV0ZWN0ZWQgYnkgZ2V0X3ByZWZldGNoYWJsZV9tcigpIGdldA0KPiBjb25mdXNlZCBh
cyBpdCBmbG93cyBiYWNrIHRvIHVzZXJzcGFjZS4gUHJvcGVybHkgbGFiZWwgZWFjaCBlcnJvciBw
YXRoIGFuZA0KPiBmbG93IHRoZSBlcnJvciBjb2RlIHByb3Blcmx5IGJhY2sgdG8gdGhlIHN5c3Rl
bSBjYWxsLg0KPg0KPiBTdWdnZXN0ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWpp
dHN1LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNv
bT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvb2RwLmMgfCA0MCArKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tbHg1L29kcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvb2RwLmMN
Cj4gaW5kZXggZDBkOThlNTg0ZWJjYzMuLjc3ODkwYTg1ZmMyZGQzIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9vZHAuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvaHcvbWx4NS9vZHAuYw0KPiBAQCAtMTcwOCwyMCArMTcwOCwyNiBAQCBnZXRfcHJlZmV0Y2hh
YmxlX21yKHN0cnVjdCBpYl9wZCAqcGQsIGVudW0gaWJfdXZlcmJzX2FkdmlzZV9tcl9hZHZpY2Ug
YWR2aWNlLA0KPiAgIA0KPiAgIAl4YV9sb2NrKCZkZXYtPm9kcF9ta2V5cyk7DQo+ICAgCW1ta2V5
ID0geGFfbG9hZCgmZGV2LT5vZHBfbWtleXMsIG1seDVfYmFzZV9ta2V5KGxrZXkpKTsNCj4gLQlp
ZiAoIW1ta2V5IHx8IG1ta2V5LT5rZXkgIT0gbGtleSB8fCBtbWtleS0+dHlwZSAhPSBNTFg1X01L
RVlfTVIpDQo+ICsJaWYgKCFtbWtleSB8fCBtbWtleS0+a2V5ICE9IGxrZXkpIHsNCj4gKwkJbXIg
PSBFUlJfUFRSKC1FTk9FTlQpOw0KPiAgIAkJZ290byBlbmQ7DQo+ICsJfQ0KPiArCWlmIChtbWtl
eS0+dHlwZSAhPSBNTFg1X01LRVlfTVIpIHsNCj4gKwkJbXIgPSBFUlJfUFRSKC1FSU5WQUwpOw0K
PiArCQlnb3RvIGVuZDsNCj4gKwl9DQo+ICAgDQo+ICAgCW1yID0gY29udGFpbmVyX29mKG1ta2V5
LCBzdHJ1Y3QgbWx4NV9pYl9tciwgbW1rZXkpOw0KPiAgIA0KPiAgIAlpZiAobXItPmlibXIucGQg
IT0gcGQpIHsNCj4gLQkJbXIgPSBOVUxMOw0KPiArCQltciA9IEVSUl9QVFIoLUVQRVJNKTsNCj4g
ICAJCWdvdG8gZW5kOw0KPiAgIAl9DQo+ICAgDQo+ICAgCS8qIHByZWZldGNoIHdpdGggd3JpdGUt
YWNjZXNzIG11c3QgYmUgc3VwcG9ydGVkIGJ5IHRoZSBNUiAqLw0KPiAgIAlpZiAoYWR2aWNlID09
IElCX1VWRVJCU19BRFZJU0VfTVJfQURWSUNFX1BSRUZFVENIX1dSSVRFICYmDQo+ICAgCSAgICAh
bXItPnVtZW0tPndyaXRhYmxlKSB7DQo+IC0JCW1yID0gTlVMTDsNCj4gKwkJbXIgPSBFUlJfUFRS
KC1FUEVSTSk7DQo+ICAgCQlnb3RvIGVuZDsNCj4gICAJfQ0KPiAgIA0KPiBAQCAtMTc1Myw3ICsx
NzU5LDcgQEAgc3RhdGljIHZvaWQgbWx4NV9pYl9wcmVmZXRjaF9tcl93b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqdykNCj4gICAJZGVzdHJveV9wcmVmZXRjaF93b3JrKHdvcmspOw0KPiAgIH0NCj4g
ICANCj4gLXN0YXRpYyBib29sIGluaXRfcHJlZmV0Y2hfd29yayhzdHJ1Y3QgaWJfcGQgKnBkLA0K
PiArc3RhdGljIGludCBpbml0X3ByZWZldGNoX3dvcmsoc3RydWN0IGliX3BkICpwZCwNCj4gICAJ
CQkgICAgICAgZW51bSBpYl91dmVyYnNfYWR2aXNlX21yX2FkdmljZSBhZHZpY2UsDQo+ICAgCQkJ
ICAgICAgIHUzMiBwZl9mbGFncywgc3RydWN0IHByZWZldGNoX21yX3dvcmsgKndvcmssDQo+ICAg
CQkJICAgICAgIHN0cnVjdCBpYl9zZ2UgKnNnX2xpc3QsIHUzMiBudW1fc2dlKQ0KPiBAQCAtMTc2
NCwxNyArMTc3MCwxOSBAQCBzdGF0aWMgYm9vbCBpbml0X3ByZWZldGNoX3dvcmsoc3RydWN0IGli
X3BkICpwZCwNCj4gICAJd29yay0+cGZfZmxhZ3MgPSBwZl9mbGFnczsNCj4gICANCj4gICAJZm9y
IChpID0gMDsgaSA8IG51bV9zZ2U7ICsraSkgew0KPiArCQlzdHJ1Y3QgbWx4NV9pYl9tciAqbXI7
DQo+ICsNCj4gKwkJbXIgPSBnZXRfcHJlZmV0Y2hhYmxlX21yKHBkLCBhZHZpY2UsIHNnX2xpc3Rb
aV0ubGtleSk7DQo+ICsJCWlmIChJU19FUlIobXIpKSB7DQo+ICsJCQl3b3JrLT5udW1fc2dlID0g
aTsNCj4gKwkJCXJldHVybiBQVFJfRVJSKG1yKTsNCj4gKwkJfQ0KPiAgIAkJd29yay0+ZnJhZ3Nb
aV0uaW9fdmlydCA9IHNnX2xpc3RbaV0uYWRkcjsNCj4gICAJCXdvcmstPmZyYWdzW2ldLmxlbmd0
aCA9IHNnX2xpc3RbaV0ubGVuZ3RoOw0KPiAtCQl3b3JrLT5mcmFnc1tpXS5tciA9DQo+IC0JCQln
ZXRfcHJlZmV0Y2hhYmxlX21yKHBkLCBhZHZpY2UsIHNnX2xpc3RbaV0ubGtleSk7DQo+IC0JCWlm
ICghd29yay0+ZnJhZ3NbaV0ubXIpIHsNCj4gLQkJCXdvcmstPm51bV9zZ2UgPSBpOw0KPiAtCQkJ
cmV0dXJuIGZhbHNlOw0KPiAtCQl9DQo+ICsJCXdvcmstPmZyYWdzW2ldLm1yID0gbXI7DQo+ICAg
CX0NCj4gICAJd29yay0+bnVtX3NnZSA9IG51bV9zZ2U7DQo+IC0JcmV0dXJuIHRydWU7DQo+ICsJ
cmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgbWx4NV9pYl9wcmVmZXRjaF9z
Z19saXN0KHN0cnVjdCBpYl9wZCAqcGQsDQo+IEBAIC0xNzkwLDggKzE3OTgsOCBAQCBzdGF0aWMg
aW50IG1seDVfaWJfcHJlZmV0Y2hfc2dfbGlzdChzdHJ1Y3QgaWJfcGQgKnBkLA0KPiAgIAkJc3Ry
dWN0IG1seDVfaWJfbXIgKm1yOw0KPiAgIA0KPiAgIAkJbXIgPSBnZXRfcHJlZmV0Y2hhYmxlX21y
KHBkLCBhZHZpY2UsIHNnX2xpc3RbaV0ubGtleSk7DQo+IC0JCWlmICghbXIpDQo+IC0JCQlyZXR1
cm4gLUVOT0VOVDsNCj4gKwkJaWYgKElTX0VSUihtcikpDQo+ICsJCQlyZXR1cm4gUFRSX0VSUiht
cik7DQo+ICAgCQlyZXQgPSBwYWdlZmF1bHRfbXIobXIsIHNnX2xpc3RbaV0uYWRkciwgc2dfbGlz
dFtpXS5sZW5ndGgsDQo+ICAgCQkJCSAgICZieXRlc19tYXBwZWQsIHBmX2ZsYWdzKTsNCj4gICAJ
CWlmIChyZXQgPCAwKSB7DQo+IEBAIC0xODExLDYgKzE4MTksNyBAQCBpbnQgbWx4NV9pYl9hZHZp
c2VfbXJfcHJlZmV0Y2goc3RydWN0IGliX3BkICpwZCwNCj4gICB7DQo+ICAgCXUzMiBwZl9mbGFn
cyA9IDA7DQo+ICAgCXN0cnVjdCBwcmVmZXRjaF9tcl93b3JrICp3b3JrOw0KPiArCWludCByYzsN
Cj4gICANCj4gICAJaWYgKGFkdmljZSA9PSBJQl9VVkVSQlNfQURWSVNFX01SX0FEVklDRV9QUkVG
RVRDSCkNCj4gICAJCXBmX2ZsYWdzIHw9IE1MWDVfUEZfRkxBR1NfRE9XTkdSQURFOw0KPiBAQCAt
MTgyNiw5ICsxODM1LDEwIEBAIGludCBtbHg1X2liX2FkdmlzZV9tcl9wcmVmZXRjaChzdHJ1Y3Qg
aWJfcGQgKnBkLA0KPiAgIAlpZiAoIXdvcmspDQo+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gICAN
Cj4gLQlpZiAoIWluaXRfcHJlZmV0Y2hfd29yayhwZCwgYWR2aWNlLCBwZl9mbGFncywgd29yaywg
c2dfbGlzdCwgbnVtX3NnZSkpIHsNCj4gKwlyYyA9IGluaXRfcHJlZmV0Y2hfd29yayhwZCwgYWR2
aWNlLCBwZl9mbGFncywgd29yaywgc2dfbGlzdCwgbnVtX3NnZSk7DQo+ICsJaWYgKHJjKSB7DQo+
ICAgCQlkZXN0cm95X3ByZWZldGNoX3dvcmsod29yayk7DQo+IC0JCXJldHVybiAtRUlOVkFMOw0K
PiArCQlyZXR1cm4gcmM7DQo+ICAgCX0NCj4gICAJcXVldWVfd29yayhzeXN0ZW1fdW5ib3VuZF93
cSwgJndvcmstPndvcmspOw0KPiAgIAlyZXR1cm4gMDsNCg==
