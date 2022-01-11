Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B748A5B6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 03:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346609AbiAKCe6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 21:34:58 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:17114 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244251AbiAKCe6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 21:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641868498; x=1673404498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C0qyrTgTp3SAbyfj1vF4w+LWMDGgFmGk2hiBolSUbi8=;
  b=uAn8M8Og32Jgx7G253nkIWblzZFcM1PzrTYqo2r1ztXMk1CPcJLVADC7
   4SXgIS7ROwBn5w2xXQ1ytG2Yajx7mWiP0PJRZkktZcbHqc+odWIUSnxxi
   qk6Pv0+cK4U8v5LqNIekpAPTlnWjrng3SG3rSYHs8zwrWQ/Q86S9Bp71r
   v+wcghyv0PqDAoOrnRUx7dlqO8nubmm9lMgqT472153qCvqcOlUcbzl9b
   /56nTBY4xescUl5jCLL70I27bPLJpS7gx/xgHVRBNwpWzPxPkFW1DIpYy
   yufzx1BABBMpP69mFBIL62Fg3yG4K+x6AsUAgGOgg3XQSLJCdKovdhMAN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47314324"
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; 
   d="scan'208";a="47314324"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 11:34:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0G6A9zLYJp30RDYnboVnVlB3B60M+EboQ28MEBWpvIfYmc9GFtZhU4P6lVQee2XSwu6caqPGlNEcs+/a1P5XHKCK51bG3zpmTeoh/lI9HiDwjU++XxtofGVqH49kzMXyk/sP07hSfOpdn20I9QAv395M/Xsf987xB0qBWzVhJFQO+NTNGAyhPL/7jyQs6trLKgXv2EacAWlommTIH4bmOrVx1wiUYGF5edI7wVc+kg3L1OYGUnCULGLqmSLFBuB8Gc7HKKOAjPbAUTJKq0SxvLsu4rEOojz+w4RY7khXbkQru2MaNL+dOHcMaTAL/LucOWqEIFBQQLM1rkWFHUCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0qyrTgTp3SAbyfj1vF4w+LWMDGgFmGk2hiBolSUbi8=;
 b=LoYEaN+oyaGsKhT8g53dHtkVOaMbEZb/rg5nQanv4RWP+Rl5uYUcHgRUUybdVSmrl4Ap9tgIIh00s2Ltwz+eaWQxo/Bzxyt1+cCZQlkhfQwUfc+k35+3I9ezaTs7LLB0foHWMAXp6IRomwJ23rvrf/ePaDxJj5dPmALUGRwnl2wHVjCTMKW+OePtdTL3F6sfzHUTfqE0SDoSNIJp9u8F/0bjFid6hdFYbCGf+fCy/mg7B0KNJ5n9byIJVGbwcpAHO5vAPV42y67RXaizoHb6MxEKojtZp3A1YNBR4vTXWBibbtQHAJOIU3bIvgUVAVY/ni6pQivZKbM6C79aGGRQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0qyrTgTp3SAbyfj1vF4w+LWMDGgFmGk2hiBolSUbi8=;
 b=GJym2TbQ5kNmJGvEB98/LCEpHDUqQbEwyQpIbEt/vQLTi31VZXnJ8xD+lI8d3Px0I9C7GkmBKKWSWv+Ih+sSaHX+l2m/uXje0afMbiZxYeDtGOAwwsLA9WGG38FVF4+N+osKIQ0tS8VbOdk117+rvb+3D0/1PZbIIXrTYCnVaR8=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB4389.jpnprd01.prod.outlook.com (2603:1096:604:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 02:34:52 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 02:34:52 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Tom Talpey <tom@talpey.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbrMyXFTG4iC0uvkiFLA5nCQaxLae+AgAAndACAAJOUAIAGetKAgABhiwCAAKMMAIABgeqAgAAfdoCABzCOgIAAtkCA
Date:   Tue, 11 Jan 2022 02:34:51 +0000
Message-ID: <61DCECAF.10206@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com> <61D4131D.5070700@fujitsu.com>
 <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
 <61D4EDB6.7040504@fujitsu.com> <20220106000153.GW2328285@nvidia.com>
 <61D64BD5.9020401@fujitsu.com> <20220110154205.GD2328285@nvidia.com>
In-Reply-To: <20220110154205.GD2328285@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02828419-a062-47e6-a422-08d9d4aaf214
x-ms-traffictypediagnostic: OSBPR01MB4389:EE_
x-microsoft-antispam-prvs: <OSBPR01MB438944954A64ABDC9AA490BE83519@OSBPR01MB4389.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WEaCnhy+m8wrCLaH7o4VVDHGR3xVeIaTspmS+239D8gG8r4iexYR7JOQyI88Z7pqdrJOnWcxGE/s8etrUt4BY7g5uIc9eAWpHvBhOr0UfQTHVMCdP+w+nnRLzY2Fdq3yszyLF8peWcqs+g+I16+jLZNkh6Ij3xIjE4h2KnnKjbjnkMJCMjpvcy/MfEBHBf7W9DjAUgz8CBow7FMg+3WZWix2Yj1bqj4HBCE0y2dKRY6ajATt6cuEnZDyuFxWOYsQB8WQdzfTYm2JnWLtvoBPCzfX1UqPv6L7LHSz6DLNkQoKYk+2OQBXavPrS4lrTsCFMx7iRB/pRlOgsg0VRER1yzA7B5EDPa3lM+Gs4gW0Xtvgv/DA+7OvOjV3BNwnqTgeBoXgG0kx3qMNZZvezhfioOZaG/iaX3vdJM3oO/8tHNo3iloxdb2UTK4Zeheu5XRgHZrGhqlw77D8tXwnV54CJ3Y4qMnuKa5Cukah3oilR0yCbcgjPzsCfD6vULJ7CIhDzWl9h7sjsmqlDRsctmtNC2YZoezHVvMg2qF+GJjIDsflCg/lp/4dR3uS+DVE/WrZsNaEl3BpNlS6R6l+qMCpQNF9JUC57qSava08G1nue8PdWYaW8p03yjuQCXRlWm6b07pim3FxKU54tR3K4lDhQJqQ8MBlNozdoIHnyAnEgSSx8TjUCA9kHmbH6xPSoPDF7ur1jOTxPVmdbHNP+5IATQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8936002)(54906003)(2616005)(508600001)(4326008)(85182001)(38070700005)(64756008)(186003)(316002)(66476007)(33656002)(66446008)(66556008)(36756003)(86362001)(71200400001)(38100700002)(5660300002)(6486002)(122000001)(66946007)(91956017)(107886003)(26005)(2906002)(76116006)(6506007)(53546011)(6916009)(6512007)(8676002)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K1ZkY2J0RFNScjJaUGQ0RUFNT1NmcUR2SnhOMmw4ZXV0K2cyZTJ5TmZMdUE1?=
 =?gb2312?B?cGl0dTdzcHQ1aDdpdHVxbjhYWE9qNXFXZWs2bHRBdFVUVjlaL3EwY0dLcTc3?=
 =?gb2312?B?VFF3UDRKYmNrODNiNEo1YmRuOUIrTis1Qmp0RjViTzdDbnNHT1hMUXRKc3Fn?=
 =?gb2312?B?MEIyR2xsRFpRS0N1aXlVZWNZZWJVc0FyR1prT0hoNGNtc0xobUV2OStUd0pP?=
 =?gb2312?B?Q2R4OWpQSjdKRzk2RitEYm5aQkY3bWovMGw5ZkpFZ3FKZENpUWx5UFRpWHQy?=
 =?gb2312?B?Y1UzazgzeUkvM0JUeFJlZzhVQlBwejRuV1BBU1pPcUZlVE5PTGxmUEpaY0Vu?=
 =?gb2312?B?R3habklXVXRoNFcvby9yS2tIV1dQcGc0UEFGZm51VG9MS2lENVpFK05Zeldn?=
 =?gb2312?B?TG5kdGxYS1F2ZktLMkFpS3JJUTNBRlpDR3R2cmFPb3RWME53M0tRRjV4YkhY?=
 =?gb2312?B?NC9WNXBxTDVhUUhFTytSWktQK2g0VmVpSmtCS0JZSktXN1EreC9ZMk9uMFRv?=
 =?gb2312?B?YW9SVGNxTmt5Q0MvMkdKbk5aTzNZekV1bFJrWFZUdjFHdURRRzB0b1BhMUVH?=
 =?gb2312?B?RCtmVGNxcHdEajAvQlNwLzBTbVJrcm5RR29nWGZFWDF3YXAwdnEyQ0FkbzVu?=
 =?gb2312?B?TENDb25tencvbnRmQVMyQ3Ewa0N5QzRmODNrdWNSVStTdmFraFMvRzBGa2ZF?=
 =?gb2312?B?UE1nb3FzQ21OeTFld0JQOHFlSFYxK0VLQVpyU3p1S1Jaajc2UkY3ODlISU5J?=
 =?gb2312?B?VDhwU1dtcHlJaStIb0g1bWw1N3BSSHdFYWJSYnZNcXAvVlRlY3lpa3dES2lk?=
 =?gb2312?B?LzBVelNSaXhHcEFyL04vdmVNSDVFRnlQamxpOG9WdmhnWGdzUTFjV3pvTE00?=
 =?gb2312?B?T0xqWDZ3YjRhOUNNTUc0bExIb2p5b2ZPZlVhSzFYZHg0VEVFK2gzTGJYQnpR?=
 =?gb2312?B?ckJOUzlTNHNrVnNNNjRFMWVzRTE0cDdPMUJuZU5vOUI4eDNIV0VnOHlwU3Vh?=
 =?gb2312?B?RjBoY0RHdloxem1Bd3p6SjVGKytFS3V3aWhiMU5PQ01tdG83L2g2VC8wSnJ6?=
 =?gb2312?B?ZTFzZ2N1cGZtUEVDc0hZVlQwSFVYV1lnYTFwM2Y0UjNWYVRCZ1FZRFZtSE1J?=
 =?gb2312?B?ZzA0djJPOENHQ240UC9kdk9adjZ0ZGhuV0dwTzFpSm5MU08vbmVQeSswT0g4?=
 =?gb2312?B?VHBBMFQyYWlkZ042dHF3ZFdGNytFbS9zV3hDWWc0WW1NWFl0akNIdXNZTXNB?=
 =?gb2312?B?NGhOdlJ4b2Zzenllb1ZwVGNmc294ZjZhcmpwcERHOWVhRmVUdU1nb2N5TFQz?=
 =?gb2312?B?RnNMT3FnNmNqVFZ6MmRodDRqU2dONGQ1Vk0zakRkRkdFanFKV0JjekU0bmNi?=
 =?gb2312?B?aHR2ZndRaytnZVhiZ2QwOXZ0czhYdWUrbCtDQmc4WEwrb25mb2QrRWgxaUtn?=
 =?gb2312?B?UTR2cExDZkJkK0FSa1RTbnZEMkpyR2IrU1RvWnVxQkI0ZzBwWmVHS3BSeEhC?=
 =?gb2312?B?WGExWnpKaFp4NUR1bVlVRVMzOHZwcEI2K3NrSFFMcVFBK1hyMnNBTzlkcnNK?=
 =?gb2312?B?bXowb2lQeTBIdUxmYXg1djYrVlRYUHdZVjV4Q2lzVU1NTHMyM2Q1OW5Uak5r?=
 =?gb2312?B?TTlvOHdseFRZL0JucC8rRzlxSFpjTE4yMVROa3BNakg5NmYxa0hBNTVSQ1Bk?=
 =?gb2312?B?Z0orN0doZFdRYlY2MlNkLzZHTWNEc1lucXg2dkV1YVQzR1RKQVBWSHhaUmVI?=
 =?gb2312?B?TVgyZGVvWEpaR3VENHgwV0NsbGI4cXcwbTlRcksrN09aeXdqNWt6N2pGMU1U?=
 =?gb2312?B?V2R5aG9qd1JsYjNjQWg2MGRST1B1WUhUK3V1RFo2MXBzaTFGNWNnUWtuaGxt?=
 =?gb2312?B?ZUM4NEYwQ0hMdll6a2lEYzJudUNONHczMVdCV0RzdHhLLy9pMXlNU1hGcmZn?=
 =?gb2312?B?SExMUk9NOVUwVzgzbnRMSUxzTUxiN0pNY3FWQ3BCVm5JNi9GWUczTlkrQzdH?=
 =?gb2312?B?MFVTZWM1TDE4clpwdS9qWHplYlpqTmQvOTZSYTNHR25lZmFrQUUrVGJ1UTR3?=
 =?gb2312?B?R0t6bkw0d05WRGV1K1ZOem1aaXZsS2pYbDE2eGRNQTdSSWNmTU9sNENqcWFL?=
 =?gb2312?B?MGJtaU5kTUFpNHliNnNURTJ0TFJSMGsyUDFTM1d5U3NxVFhYa3hpbDVQZ2ZB?=
 =?gb2312?Q?6LgN7IDnXeR/6xrSPDZP4cw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <8CB875AC6F75CC40AB3E81CF31687376@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02828419-a062-47e6-a422-08d9d4aaf214
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 02:34:51.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLiAGbVclGOjbKurgsNhfFPjqNArtRg+tw3Ne1wLguJEUEl8bAgXnqwFP0PWZwSBD+4f6KxertO8YwMJtVpTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4389
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzEwIDIzOjQyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFRodSwgSmFu
IDA2LCAyMDIyIGF0IDAxOjU0OjMwQU0gKzAwMDAsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3Rl
Og0KPj4gT24gMjAyMi8xLzYgODowMSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+IE9uIFdl
ZCwgSmFuIDA1LCAyMDIyIGF0IDAxOjAwOjQyQU0gKzAwMDAsIHlhbmd4Lmp5QGZ1aml0c3UuY29t
IHdyb3RlOg0KPj4+DQo+Pj4+IDEpIEluIGtlcm5lbCwgY3VycmVudCBTb2Z0Um9DRSBjb3BpZXMg
dGhlIGNvbnRlbnQgb2Ygc3RydWN0IHJkbWEgdG8gUkVUSA0KPj4+PiBhbmQgY29waWVzIHRoZSBj
b250ZW50IG9mIHN0cnVjdCBhdG9taWMgdG8gQXRvbWljRVRILg0KPj4+PiAyKSBJQlRBIGRlZmlu
ZXMgdGhhdCBSRE1BIEF0b21pYyBXcml0ZSB1c2VzIFJFVEggKyBwYXlsb2FkLg0KPj4+PiBBY2Nv
cmRpbmcgdG8gdGhlc2UgdHdvIHJlYXNvbnMsIEkgcGVyZmVyIHRvIHR3ZWFrIHRoZSBleGlzdGlu
ZyBzdHJ1Y3QgcmRtYS4NCj4+PiBObyB0aGlzIGlzIGJhc2ljYWxseSBtZWFuaW5nbGVzcw0KPj4+
DQo+Pj4gVGhlIHdyIHN0cnVjdCBpcyBkZXNpZ25lZCBhcyBhICd0YWdnZWQgdW5pb24nIHdoZXJl
IHRoZSBvcCBzcGVjaWZpZWQNCj4+PiB3aGljaCB1bmlvbiBpcyBpbiBlZmZlY3QuDQo+Pj4NCj4+
PiBJdCB0dXJucyBvdXQgdGhhdCB0aGUgb3AgZ2VuZXJhbGx5IHNwZWNpZmllcyB0aGUgbmV0d29y
ayBoZWFkZXJzIGFzDQo+Pj4gd2VsbCwgYnV0IHRoYXQgaXMganVzdCBhIHNpZGUgZWZmZWN0Lg0K
Pj4+DQo+Pj4+Pj4gSG93IGFib3V0IGFkZGluZyBhIG1lbWJlciBpbiBzdHJ1Y3QgcmRtYT8gZm9y
IGV4YW1wbGU6DQo+Pj4+Pj4gc3RydWN0IHsNCj4+Pj4+PiAgICAgICAgIHVpbnQ2NF90ICAgIHJl
bW90ZV9hZGRyOw0KPj4+Pj4+ICAgICAgICAgdWludDMyX3QgICAgcmtleTsNCj4+Pj4+PiAgICAg
ICAgIHVpbnQ2NF90ICAgIHdyX3ZhbHVlOg0KPj4+Pj4+IH0gcmRtYTsNCj4+Pj4+IFllcywgdGhh
dCdzIHdoYXQgVG9tYXN6IGFuZCBJIHdlcmUgc3VnZ2VzdGluZyAtIGEgbmV3IHRlbXBsYXRlIGZv
ciB0aGUNCj4+Pj4+IEFUT01JQ19XUklURSByZXF1ZXN0IHBheWxvYWQuIFRoZSB0aHJlZSBmaWVs
ZHMgYXJlIHRvIGJlIHN1cHBsaWVkIGJ5DQo+Pj4+PiB0aGUgdmVyYiBjb25zdW1lciB3aGVuIHBv
c3RpbmcgdGhlIHdvcmsgcmVxdWVzdC4NCj4+Pj4gT0ssIEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNo
IGluIHRoaXMgd2F5Lg0KPj4+IFdlIGFyZSBub3QgZXh0ZW5kaW5nIHRoZSBpYl9zZW5kX3dyIGFu
eW1vcmUgYW55aG93Lg0KPj4+DQo+Pj4gWW91IHNob3VsZCBpbXBsZW1lbnQgbmV3IG9wcyBpbnNp
ZGUgc3RydWN0IGlidl9xcF9leCBhcyBmdW5jdGlvbg0KPj4+IGNhbGxzLg0KPj4gSGkgSmFzb24s
DQo+Pg0KPj4gRm9yIFNvZnRSb0NFLCBkbyB5b3UgbWVhbiB0aGF0IEkgb25seSBuZWVkIHRvIGV4
dGVuZCBzdHJ1Y3QgcnhlX3NlbmRfd3INCj4+IGFuZCBhZGQgIGlidl93cl9yZG1hX2F0b21pY193
cml0ZSgpID8NCj4+IHN0cnVjdCByeGVfc2VuZF93ciB7DQo+PiAgICAgICAuLi4NCj4+ICAgICAg
ICAgICBzdHJ1Y3Qgew0KPj4gICAgICAgICAgICAgICBfX2FsaWduZWRfdTY0IHJlbW90ZV9hZGRy
Ow0KPj4gKyAgICAgICAgICAgX19hbGlnbmVkX3U2NCBhdG9taWNfd3I7DQo+PiAgICAgICAgICAg
ICAgIF9fdTMyICAgcmtleTsNCj4+ICAgICAgICAgICAgICAgX191MzIgICByZXNlcnZlZDsNCj4+
ICAgICAgICAgICB9IHJkbWE7DQo+IFlvdSBjYW4ndCBtYWtlIGEgY2hhbmdlIGxpa2UgdGhpcyB0
byBhbnl0aGluZyBpbg0KPiBpbmNsdWRlL3VhcGkvcmRtYS9yZG1hX3VzZXJfcnhlLmgsIGl0IGhh
cyB0byByZW1haW4gY29tcGF0aWFibGUuDQpIaSBKYXNvbiwNCg0KSG93IGFib3V0IGFkZGluZyBh
dG9taWNfd3IgbWVtYmVyIGF0IHRoZSBlbmQgb2Ygc3RydWN0IHJkbWE/IGxpa2UgdGhpczoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0Kc3Ry
dWN0IHJ4ZV9zZW5kX3dyIHsNCiAgICAgLi4uDQogICAgICAgICBzdHJ1Y3Qgew0KICAgICAgICAg
ICAgIF9fYWxpZ25lZF91NjQgcmVtb3RlX2FkZHI7DQogICAgICAgICAgICAgX191MzIgICBya2V5
Ow0KICAgICAgICAgICAgIF9fdTMyICAgcmVzZXJ2ZWQ7DQorICAgICAgICAgIF9fYWxpZ25lZF91
NjQgYXRvbWljX3dyOw0KICAgICAgICAgfSByZG1hOw0KICAgICAuLi4NCn0NCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSWYgaXQgaXMgYWxz
byB3cm9uZywgaG93IHRvIGV4dGVuZCBzdHJ1Y3QgcmRtYT8NCj4NCj4+IHN0YXRpYyBpbmxpbmUg
dm9pZCBpYnZfd3JfcmRtYV9hdG9taWNfd3JpdGUoc3RydWN0IGlidl9xcF9leCAqcXAsDQo+PiB1
aW50MzJfdCBya2V5LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDY0X3QgcmVtb3RlX2FkZHIpDQo+PiB7DQo+PiAgICAgICAgICAgcXAtPndyX3JkbWFfYXRv
bWljX3dyaXRlKHFwLCBya2V5LCByZW1vdGVfYWRkcik7DQo+PiB9DQo+IFllcywgc29tZXRoaW5n
IGxpa2UgdGhhdA0KPg0KPj4gQmVzaWRlcywgY291bGQgeW91IHRlbGwgbWUgd2h5IHdlIGNhbm5v
dCBleHRlbmQgc3RydWN0IGlidl9zZW5kX3dyIGZvcg0KPj4gaWJ2X3Bvc3Rfc2VuZCgpPw0KPiBU
aGUgQUJJIGlzIG5vdCBhbGxvd2VkIHRvIGNoYW5nZSBzbyB3aGF0IGlzIGRvYWJsZSB3aXRoIGl0
IGlzIHZlcnkNCj4gbGltaXRlZC4NClRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbi4NCg0KQmVz
dCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IEphc29uDQo=
