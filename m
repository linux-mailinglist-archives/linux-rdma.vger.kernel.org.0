Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD6482148
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 02:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbhLaBhx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 20:37:53 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:54914 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242480AbhLaBhx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 20:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1640914673; x=1672450673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HcBCcs8gH/9XZ5zn4TDfHZS3TmsJqnuGSvuHuDoVOTY=;
  b=TMuGBq0VM91dDZxQVTYtc0IkFZP38eVAl5fo9rth3glvRaawbhyeopxc
   zJkdsOzt/Moc8ZWREBbio8kXyGvTYeQEshG/EmshcWyQzdy8h4wto6yhK
   h/TP0ytjRGhdITKnITx9KTmzvvrSHM3J0MtqxSPo4EhAOD0EFIlbbJbpI
   iMCCaQW/tQsIIWLFhe512TRPG7ygegUqdAFnjH4+ZqfRN2FP5415PnMLK
   YV7eCSMZeeLfN6qX3HSGqaVJ0TBKYZCelPu0r1qmxeR4F84nGxoUHAMx+
   9GbIwXZmzmr/N6fdXjbTnXLaavl1GyVAiqTCk2uqcHGcPFbdxcqA3mbqv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="46647855"
X-IronPort-AV: E=Sophos;i="5.88,250,1635174000"; 
   d="scan'208";a="46647855"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 10:37:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeFG87M8LTW3gqEbwuzeC1HfCTkkfFwX0d9wneiI3ngwp3uccqVHfQ3TJOp1Y7H2kyq1qPwR7is49hVGiZ14HX3XClA1CPrMOTwV+vb+QA7B5HeEyGzeOak1r3d0X9dYDPuH+ZtORRPsQPIffK09OaSO1eWxcJXNZHflyozzLOnbholY0DSgF9B2QSWUt6KRnyfjrgf3Zb1hKnx9FxOu+TptBkIJysiwQAvy6CLyb9sfwFG5GNHHSsDSj47KXYXyo1Mtb1popNWbiJsDwRWMDogLvVuD/jUeQva4+Le1QjrIB+xb7OFSTN7+E5z/MPDpxby/FhG76GDYnzYf+0ZI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcBCcs8gH/9XZ5zn4TDfHZS3TmsJqnuGSvuHuDoVOTY=;
 b=BOtx7ffv+m8bxNyg0nejEPsPW3AKhjeseaB/VYc4FTd67lgeSB4R+/SKPYvKC4hm/x9/sq6BZ+8BvyCRjMrz14hUV+B30uNWZ0huV2pb3jl6Iav1wGv9xagLKnFaZgOtvtt7VqhzzE0u7gOHzbjXrcUotwpJ0GBG1J9q4qdFRf3ka+2UT6iPqCYZlvMb/ShtLI0lbYiqmBiiivdtRBRwgdjoxcv7+3CeXsqW0saQPMTruQAe18I/7BvyxcuF0FNbBdJbAro8+Xu7FewgODLN2AaVqz1t9PjtYNX+kOJEKqdCC80OpAKB8WyEtEe6CyiegLzVXWtjwfVEd6tZXQ1vCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcBCcs8gH/9XZ5zn4TDfHZS3TmsJqnuGSvuHuDoVOTY=;
 b=h0Y2fx9papEsm7ztY02FT/9nHGdAr4Q5HwUiUlCIHMwLSsY9X+o+IEI48g5e3v1RSuqbkFksVpaKaBFai81Xo7b5WEtHFYJl6LRQN/iQD5RBdRZ4zHyqpfZ6/OycGrxOHH9E1VdGJdGuKnayMupxY7TcyJ00O0dyK0qbMFvx12U=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OS3PR01MB7286.jpnprd01.prod.outlook.com (2603:1096:604:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Fri, 31 Dec
 2021 01:37:45 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::e93c:fa4b:dda5:ff26]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::e93c:fa4b:dda5:ff26%9]) with mapi id 15.20.4823.023; Fri, 31 Dec 2021
 01:37:45 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xLnrSAgAA33IA=
Date:   Fri, 31 Dec 2021 01:37:45 +0000
Message-ID: <fd561077-358e-e38d-a7d0-5c61593eff6a@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <9f97d902-aad5-db0f-f2dc-badf913777c4@talpey.com>
In-Reply-To: <9f97d902-aad5-db0f-f2dc-badf913777c4@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92300fb7-f426-4405-62e2-08d9cbfe250e
x-ms-traffictypediagnostic: OS3PR01MB7286:EE_
x-microsoft-antispam-prvs: <OS3PR01MB72864FE9A37A0406AD73A516A5469@OS3PR01MB7286.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4rWll+KOtVF/+g3GCxzsEi59P1GLtu6PK6MvFsIt70HnxDPMIlkfV4YGg1wSJdRtGoDyMQBgu1JQRuuVC75wIkeir1ygbGHCpPgU42pbt8FnJKl1KI8OxOaa0TebpiuTuQHgwIuBZoYQvnUvJeMi9kEVSLIDR/9xs8DOhEB4dwrAlTWkb22LDV8CySaDQM88cYCskSQmqoR06P4MlBpnD7EHVS+yt4O064NPiYqTkknY7AIUDTR4UxChUPJhZ3MI5UOXcthTTLKCf7cIyWsC67dZOoN1beLcCCmbDPe5ahkMQcpum7UFm3ZnVA6v7t9D6hvrmscLTZpwVD9iMKLJbW3D52UYAD7sRi9yeaQEDbi4BMQxifVfXtcIVBbHlvCkkqDuG5A06ZtGxE5I2QITmlPX5iM4yaRYcImp8mjDhp8vDWqyQolwLeMtQHzoU3iFckUvDCsbeHjMJVVjjAL9fG1y8puY9cIq3oeXp6/FGN6okdHPpqFgzQoUPMAvQ24ZFFR+ZBRpstYWPlDc4T8VLuT9ToJZaBZ4xZByy6U7KbXjHkBvKhaQQBChgeU0Lm+D1OHEQEUpAPdE8BX4DiN1FeuEKeurJNOpqFnc/bFlzwskXc07Zs1coLU2cmbV4u62oBa5iDGruODuPv8Nru/OMFeDcnYstC/TUukdoTrrPZYTftTT0nO0sYemu0t5GvJQbpBdYgm2ThD0X2tYRRWQUvLTCo4fkeaunebuQ/Hbl9SAUgxMizJGkBCwnOsgIWk4zGH1ku7em8ef9F42Qur6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(2906002)(6486002)(31696002)(71200400001)(122000001)(186003)(66556008)(86362001)(76116006)(83380400001)(316002)(6506007)(8936002)(91956017)(66476007)(26005)(36756003)(66446008)(508600001)(64756008)(110136005)(53546011)(31686004)(38070700005)(82960400001)(7416002)(6512007)(5660300002)(85182001)(4326008)(107886003)(54906003)(66946007)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1NaNSs1NUxuU3dmWWlsRHpONWt2NUw0L1JPcm9HenZmdmdVWUFxUWsxRnRq?=
 =?utf-8?B?dTIxLzZ2bW9oQkZ4QzBZTXFLTSs5N3JleTNLMVJrQ3hpN1NhanJaNXo1emxw?=
 =?utf-8?B?V3ZXQ3RnRzZSTGphSmRnSnBzejJwdFkwN0hScnZxblFqUUZmTVJYRzA3dDRv?=
 =?utf-8?B?azRnWHpwbTVYVnd2VXJOWUtFWEUyT3J4bk12b1BMc3owenB1RWlnWnBJZHF1?=
 =?utf-8?B?aU9NTUREM0xWUFd1NmdUNjBXaWw3dE1ZVjFHYjZoMU9GMmp5bVRyVUJ0M0pJ?=
 =?utf-8?B?WXJTY01JaTRxQlh5UnZPR1A0UjI2UmxUNWk5SDdXOEh0dUh6RDRYUUFwQkwv?=
 =?utf-8?B?ZUZ6SlhDczJ6UXZHeWEwU0pHa050L3oxL1F3em5ra2FIUldWa3FIY1FIR1hL?=
 =?utf-8?B?RnVjZHd4WkU3dG84RW05UTFTUmNheERoZ0k1MU9pQ2wyaUt3aVc3d3ZPcVhH?=
 =?utf-8?B?b2xEU3FJdXVYRG16aWtjT3JFWkdKWUlEWThqQWtmakZzN3l0OUl4bmNHNE01?=
 =?utf-8?B?MGJYT2MxOWhML0xuYVo0MXFWVkYxQjlTa2pIWGpjcVRONGVsUWdnL3hKZ1Ey?=
 =?utf-8?B?REMrTThqWjF4WGdUZWNUbzRhUDhSOGRacUIyNkcxd25CZ05KV3JMWG8wNXdV?=
 =?utf-8?B?emYvTnlnRU1jRTlRemkzbzlhVTZCOE01cHNDUnVpYXpIamM1TXNEUCtETzQz?=
 =?utf-8?B?M0ticldSdXBCSDIzdkxLa2dWWlRPU3BQemlwYzg2bHNJaXVRMFNCZkZvVS8w?=
 =?utf-8?B?d3NjaHF3NGdPS0ZEWlFYZkwvczBnNnhLc0tONEZudmFySnNISHJ5VEQxUysz?=
 =?utf-8?B?cDJhVHgvTXZKdU5FM0VhTDdWMHgxbDAwUDB2VkdIQVZ1U2hOVWtvSUxKMkVy?=
 =?utf-8?B?QnBCVTV1emV3M1lIZ0FjVFYvNFoyRGJteFF6RjAyTUY0dGVYcU5IU09mQ3lS?=
 =?utf-8?B?V0dmUExVM08vUlJiTzV1UWpRSi9MZklUY2xGbjljenpZY2wrenI1c0F4SFJJ?=
 =?utf-8?B?WmhNVlhnSU50dzMwbmN1YWVUY3dSb1ZuVHBFN29veGc4RjRqL25MeEtTdkxF?=
 =?utf-8?B?SHNMRGcwOFdxdWZNb2J1d0pFV3Q4cWQ3WWtjaTdsQ3hKOGlsTXdZU21iY2Vj?=
 =?utf-8?B?dGliZWxCcitLQ3JTS0hWVjNjMks2RHE1R01lR1hnaDE1VHR3by96REtRUCtz?=
 =?utf-8?B?UDlvNnUxdGhQK0ZXOVMyQ05IY3c4dlJ4amZUenZHTSsyRUpFNjlvcEhLbXZt?=
 =?utf-8?B?VXdRVmdTWjZQUllhT05VSVdOTU5qYzFEejMxZ3dpdE9NQ1QxdEgyRDBZSHBw?=
 =?utf-8?B?eEpDbGUxeGpubWJVR0xzODlvMW50NG1PVkRWL21LNEVFUzZjN3FFK1d6aGNo?=
 =?utf-8?B?Q2FUZFVoNVFsbFlmZmpMSVRnSnBCZVgzMld4cTVLczNBeE9RSWtIZGlKZkJq?=
 =?utf-8?B?N2JmbTZwVkJXSzV1eUlmZlBjRSs3MFZmNlUwKzl0VC9qWlpEWjJ1b0FjdFIz?=
 =?utf-8?B?V1VDYzJYUGNERTYwSXBEVnRYeGZJSTdCNjEvZmdIUVdJb0I3WUxITGZrTFV3?=
 =?utf-8?B?UjcvOGpuL0hjRzArREtOTGlCOHJzMU85WmRwYUcwTFFYQkNKcTNNNmkxUWxq?=
 =?utf-8?B?dmMxQklxNERUWEMzUnlFN2FVdTRzL3JpMmZxQUJyTHlZRzN5M1VzcnRvOUlx?=
 =?utf-8?B?VzRJa3E0cVZHUnR2QktOTU9uNlZxUVFwMXlyMzg1ZnhCWmNIWFByZFNicktm?=
 =?utf-8?B?bjNCRWlQbnBhcmduZzFtR2xMbkxkUXAvaUJOZUtlU0FadlhieDBTNTNOOEd4?=
 =?utf-8?B?MElSTmhhaTFHU3ZBbHQ5VzMvc3lyellrVkxDRjZ2K2Uxa1NkSXNGQVJjZUNj?=
 =?utf-8?B?NnZzSWM5b3JuellsVyt0MWFYS3FBUGZKbi9iTUNCSjk3NkFKTDR3Z0tIdm5j?=
 =?utf-8?B?Z1p3anlETnkrNUhmN1E2MXNnd2N6ejRuRVVtdFBZUnphQlhqajBja0d6bEpB?=
 =?utf-8?B?SWx0Wm1TcWNiSlR5N1UvWmRweWMyZldMd3FVQkRJMUZFLzZDd1pudWlpYWFN?=
 =?utf-8?B?VEs5MlVpbVBVYmUwbXBicDFzc3NNWU9PWkpxb3hRQWtNVHJiblZQcWFCNEN2?=
 =?utf-8?B?MVdVRzdvU1dFcXE4ZkVBQlVZZUM0QWVLcG95blFVOEJ1R1psb3VsenJweTg2?=
 =?utf-8?Q?ko8DPTolm5wArIRa3ozi22Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AC9FA6BF8F8B941AE874445116DE9C5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92300fb7-f426-4405-62e2-08d9cbfe250e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 01:37:45.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApvETNc8OJxh3dm88wIpR20Zx8NNKzH9tGUx/brKf84gAME5ZyxjCKyDSpsdjVRqM+NIIjm5941uXRQ+smvaMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7286
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDMxLzEyLzIwMjEgMDY6MTgsIFRvbSBUYWxwZXkgd3JvdGU6DQo+IE9uIDEyLzI4LzIw
MjEgMzowNyBBTSwgTGkgWmhpamlhbiB3cm90ZToNCj4+IEluIGNvbnRyYXN0IHRvIG90aGVyIG9w
Y29kZXMsIGFmdGVyIGEgc2VyaWVzIG9mIHNhbml0eSBjaGVja2luZywgRkxVU0gNCj4+IG9wY29k
ZSB3aWxsIGRvIGEgUGxhY2VtZW50IFR5cGUgY2hlY2tpbmcgYmVmb3JlIGl0IHJlYWxseSBkbyB0
aGUgRkxVU0gNCj4+IG9wZXJhdGlvbi4gUmVzcG9uZGVyIHdpbGwgYWxzbyByZXBseSBOQUsgIlJl
bW90ZSBBY2Nlc3MgRXJyb3IiIGlmIGl0DQo+PiBmb3VuZCBhIHBsYWNlbWVudCB0eXBlIHZpb2xh
dGlvbi4NCj4+DQo+PiBXZSB3aWxsIHBlcnNpc3QgZGF0YSB2aWEgYXJjaF93Yl9jYWNoZV9wbWVt
KCksIHdoaWNoIGNvdWxkIGJlDQo+PiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMuDQo+Pg0KPj4gQWZ0
ZXIgdGhlIGV4ZWN1dGlvbiwgcmVzcG9uZGVyIHdvdWxkIHJlcGx5IGEgcmVzcG9uZGVkIHN1Y2Nl
c3NmdWxseSBieQ0KPj4gUkRNQSBSRUFEIHJlc3BvbnNlIG9mIHplcm8gc2l6ZS4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQo+PiAt
LS0NCj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2hkci5owqAgfMKgIDI4ICsr
KysrKw0KPj4gwqAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmjCoCB8wqDCoCAy
ICsNCj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmPCoMKgIHzCoMKgIDQg
Ky0NCj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDEzMSArKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4+IMKgIGluY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJf
dmVyYnMuaMKgwqDCoCB8wqAgMTAgKysNCj4+IMKgIDUgZmlsZXMgY2hhbmdlZCwgMTY5IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pg0KPg0KPiA8c25pcD4NCj4NCj4+ICtzdGF0aWMg
aW50IG52ZGltbV9mbHVzaF9pb3ZhKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgaW50IGxl
bmd0aCkNCj4+ICt7DQo+PiArwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyOw0K
Pj4gK8KgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ5dGVzOw0KPj4gK8KgwqDCoCB1
OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnZhOw0KPj4gK8KgwqDCoCBzdHJ1Y3QgcnhlX21hcMKg
wqDCoMKgwqDCoMKgICoqbWFwOw0KPj4gK8KgwqDCoCBzdHJ1Y3QgcnhlX3BoeXNfYnVmwqDCoMKg
ICpidWY7DQo+PiArwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbTsNCj4+ICvCoMKg
wqAgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpOw0KPj4gK8KgwqDCoCBzaXplX3TCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG9mZnNldDsNCj4+ICsNCj4+ICvCoMKgwqAgaWYgKGxlbmd0aCA9PSAw
KQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPg0KPiBUaGUgbGVuZ3RoIGlzIG9ubHkg
cmVsZXZhbnQgd2hlbiB0aGUgZmx1c2ggdHlwZSBpcyAiTWVtb3J5IFJlZ2lvbg0KPiBSYW5nZSIu
DQo+DQo+IFdoZW4gdGhlIGZsdXNoIHR5cGUgaXMgIk1lbW9yeSBSZWdpb24iLCB0aGUgZW50aXJl
IHJlZ2lvbiBtdXN0IGJlDQo+IGZsdXNoZWQgc3VjY2Vzc2Z1bGx5IGJlZm9yZSBjb21wbGV0aW5n
IHRoZSBvcGVyYXRpb24uDQoNClllcywgY3VycmVudGx5LCB0aGUgbGVuZ3RoIGhhcyBiZWVuIGV4
cGFuZGVkIHRvIHRoZSBNUidzIGxlbmd0aCBpbiBzdWNoIGNhc2UuDQoNCg0KPg0KPj4gKw0KPj4g
K8KgwqDCoCBpZiAobXItPnR5cGUgPT0gSUJfTVJfVFlQRV9ETUEpIHsNCj4+ICvCoMKgwqDCoMKg
wqDCoCBhcmNoX3diX2NhY2hlX3BtZW0oKHZvaWQgKilpb3ZhLCBsZW5ndGgpOw0KPj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiAwOw0KPj4gK8KgwqDCoCB9DQo+DQo+IEFyZSBkbWFtcidzIHN1cHBv
cnRlZCBmb3IgcmVtb3RlIGFjY2Vzcz8gSSB0aG91Z2h0IHRoYXQgd2FzDQo+IHByZXZlbnRlZCBv
biBmaXJzdCBwcmluY2lwbGVzIG5vdy4gSSBtaWdodCBzdWdnZXN0IG5vdCBhbGxvd2luZw0KPiB0
aGVtIHRvIGJlIGZsdXNoZWQgaW4gYW55IGV2ZW50LiBUaGVyZSBpcyBubyBsZW5ndGggcmVzdHJp
Y3Rpb24sDQo+IGFuZCBpdCdzIGEgVkVSWSBjb3N0bHkgb3BlcmF0aW9uLiBBdCBhIG1pbmltdW0s
IHByb3RlY3QgdGhpcw0KPiBjbG9zZWx5Lg0KSW5kZWVkLCBJIGRpZG4ndCBjb25maWRlbmNlIGFi
b3V0IHRoaXMsIHRoZSBtYWluIGxvZ2ljIGNvbWVzIGZyb20gcnhlX21yX2NvcHkoKQ0KVGhhbmtz
IGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KDQoNCj4NCj4+ICsNCj4+ICvCoMKgwqAgV0FSTl9PTl9P
TkNFKCFtci0+Y3VyX21hcF9zZXQpOw0KPg0KPiBUaGUgV0FSTiBpcyByYXRoZXIgcG9pbnRsZXNz
IGJlY2F1c2UgdGhlIGNvZGUgd2lsbCBjcmFzaCBqdXN0DQo+IHNldmVuIGxpbmVzIGJlbG93Lg0K
Pg0KPj4gKw0KPj4gK8KgwqDCoCBlcnIgPSBtcl9jaGVja19yYW5nZShtciwgaW92YSwgbGVuZ3Ro
KTsNCj4+ICvCoMKgwqAgaWYgKGVycikgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IC1FRkFV
TFQ7DQo+PiArwqDCoMKgwqDCoMKgwqAgZ290byBlcnIxOw0KPj4gK8KgwqDCoCB9DQo+PiArDQo+
PiArwqDCoMKgIGxvb2t1cF9pb3ZhKG1yLCBpb3ZhLCAmbSwgJmksICZvZmZzZXQpOw0KPj4gKw0K
Pj4gK8KgwqDCoCBtYXAgPSBtci0+Y3VyX21hcF9zZXQtPm1hcCArIG07DQo+PiArwqDCoMKgIGJ1
ZsKgwqDCoCA9IG1hcFswXS0+YnVmICsgaTsNCj4+ICsNCj4+ICvCoMKgwqAgd2hpbGUgKGxlbmd0
aCA+IDApIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCB2YcKgwqDCoCA9ICh1OCAqKSh1aW50cHRyX3Qp
YnVmLT5hZGRyICsgb2Zmc2V0Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIGJ5dGVzwqDCoMKgID0gYnVm
LT5zaXplIC0gb2Zmc2V0Ow0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChieXRlcyA+IGxl
bmd0aCkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ5dGVzID0gbGVuZ3RoOw0KPj4gKw0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGFyY2hfd2JfY2FjaGVfcG1lbSh2YSwgYnl0ZXMpOw0KPj4gKw0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGxlbmd0aMKgwqDCoCAtPSBieXRlczsNCj4+ICsNCj4+ICvCoMKg
wqDCoMKgwqDCoCBvZmZzZXTCoMKgwqAgPSAwOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGJ1ZisrOw0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGkrKzsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoaSA9
PSBSWEVfQlVGX1BFUl9NQVApIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGkgPSAwOw0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFwKys7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBidWYgPSBtYXBbMF0tPmJ1ZjsNCj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+PiArwqDCoMKg
IH0NCj4+ICsNCj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+PiArDQo+PiArZXJyMToNCj4+ICvCoMKg
wqAgcmV0dXJuIGVycjsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMg
cHJvY2Vzc19mbHVzaChzdHJ1Y3QgcnhlX3FwICpxcCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QpDQo+PiAr
ew0KPj4gK8KgwqDCoCB1NjQgbGVuZ3RoID0gMCwgc3RhcnQgPSBxcC0+cmVzcC52YTsNCj4+ICvC
oMKgwqAgdTMyIHNlbCA9IGZldGhfc2VsKHBrdCk7DQo+PiArwqDCoMKgIHUzMiBwbHQgPSBmZXRo
X3BsdChwa3QpOw0KPj4gK8KgwqDCoCBzdHJ1Y3QgcnhlX21yICptciA9IHFwLT5yZXNwLm1yOw0K
Pj4gKw0KPj4gK8KgwqDCoCBpZiAoc2VsID09IElCX0VYVF9TRUxfTVJfUkFOR0UpDQo+PiArwqDC
oMKgwqDCoMKgwqAgbGVuZ3RoID0gcXAtPnJlc3AubGVuZ3RoOw0KPj4gK8KgwqDCoCBlbHNlIGlm
IChzZWwgPT0gSUJfRVhUX1NFTF9NUl9XSE9MRSkNCj4+ICvCoMKgwqDCoMKgwqDCoCBsZW5ndGgg
PSBtci0+Y3VyX21hcF9zZXQtPmxlbmd0aDsNCj4NCj4gSSdtIGdvaW5nIHRvIGhhdmUgdG8gdGhp
bmsgYWJvdXQgdGhlc2UNCg0KWWVzLCB5b3UgaW5zcGlyZSBtZSB0aGF0IHdlIHNob3VsZCBjb25z
aWRlciB0byBhZGp1c3QgdGhlIHN0YXJ0IG9mIGlvdmEgdG8gdGhlIE1SJ3Mgc3RhcnQgYXMgd2Vs
bC4NCg0KDQo+PiArDQo+PiArwqDCoMKgIGlmIChwbHQgPT0gSUJfRVhUX1BMVF9QRVJTSVNUKSB7
DQo+PiArwqDCoMKgwqDCoMKgwqAgbnZkaW1tX2ZsdXNoX2lvdmEobXIsIHN0YXJ0LCBsZW5ndGgp
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIHdtYigpOyAvLyBjbHdiIGZvbGxvd3MgYnkgYSBzZmVuY2UN
Cj4+ICvCoMKgwqAgfSBlbHNlIGlmIChwbHQgPT0gSUJfRVhUX1BMVF9HTEJfVklTKQ0KPj4gK8Kg
wqDCoMKgwqDCoMKgIHdtYigpOyAvLyBzZmVuY2UgaXMgZW5vdWdoDQo+DQo+IFRoZSBwZXJzaXN0
ZW5jZSBhbmQgZ2xvYmFsIHZpc2liaWxpdHkgYml0cyBhcmUgbm90IG11dHVhbGx5DQo+IGV4Y2x1
c2l2ZSwNCk15IGJhZCwgaXQgZXZlciBhcHBlYXJlZCBpbiBteSBtaW5kLiBvKOKVr+KWoeKVsClv
DQoNCg0KDQoNCj4gYW5kIGluIGZhY3QgcGVyc2lzdGVuY2UgZG9lcyBub3QgaW1wbHkgZ2xvYmFs
DQo+IHZpc2liaWxpdHkgaW4gc29tZSBwbGF0Zm9ybXMuIA0KSWYgc28sIGFuZCBwZXIgdGhlIFNQ
RUMsIHdoeSBub3QNCiDCoMKgIGlmIChwbHQgJiBJQl9FWFRfUExUX1BFUlNJU1QpDQogwqDCoMKg
wqDCoCBkb19zb21ldGhpbmdBKCk7DQogwqDCoCBpZiAocGx0ICYgSUJfRVhUX1BMVF9HTEJfVklT
KQ0KIMKgwqDCoMKgwqAgZG9fc29tZXRoaW5nQigpOw0KDQoNCg0KPiBUaGV5IG11c3QgYmUgdGVz
dGVkIGFuZA0KPiBwcm9jZXNzZWQgaW5kaXZpZHVhbGx5Lg0KPg0KPiDCoMKgwqDCoGlmIChwbHQg
JiBJQl9FWFRfUExUX1BFUlNJU1QpDQo+IMKgwqDCoMKgwqDCoMKgIC4uLg0KPiDCoMKgwqDCoGVs
c2UgaWYgKHBsdCAmIElCX0VYVF9QTFRfR0xCX1ZJUykNCj4gwqDCoMKgwqDCoMKgwqAgLi4NCj4N
Cj4gU2Vjb25kLCB0aGUgImNsd2IiIGFuZCAic2ZlbmNlIiBjb21tZW50cyBhcmUgY29tcGxldGVs
eQ0KPiBJbnRlbC1zcGVjaWZpYy4gDQpnb29kIGNhdGNoLg0KDQoNCj4gV2hhdCBwcm9jZXNzaW5n
IHdpbGwgYmUgZG9uZSBvbiBvdGhlcg0KPiBwcm9jZXNzb3IgcGxhdGZvcm1zPz8/DQoNCkkgZGlk
bid0IGRpZyBvdGhlciBBUkNIIHlldCBidXQgSU5URUwuDQpJbiB0aGlzIGZ1bmN0aW9uLCBpIHRo
aW5rIGkganVzdCBuZWVkIHRvIGNhbGwgdGhlIGhpZ2hlciBsZXZlbCB3cmFwcGVyLCBsaWtlIHdt
YigpIGFuZA0KYXJjaF93Yl9jYWNoZV9wbWVtIGFyZSBlbm91Z2gsIHJpZ2h0ID8NCg0KQWdhaW4s
IHRoYW5rIHlvdS4NCg0KVGhhbmtzLg0KDQoNCg0KDQo+DQo+IFRvbS4NCg==
