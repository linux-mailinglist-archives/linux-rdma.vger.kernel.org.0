Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E214822D2
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 09:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhLaIgW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 03:36:22 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:43799 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229862AbhLaIgV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Dec 2021 03:36:21 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Dec 2021 03:36:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1640939782; x=1672475782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q/bQVoaSTMwkRcKBZzpUN8LSvKKQxZt7HboKiJegNeM=;
  b=PhCfttQk8dVzJAyH9r6chUg/oK+Th9XOUAMiHJTRwMPEM5+VHbKGrWqd
   vuwShqakSNhIIR0sLbSprWcuK8RQ104qlmtD8PVqz4DVUeh1T2010stQ0
   bBMKgjV4yKauLbjEFylZYkr/Yk6d533/jOfeaf+5O0GyxzhZSX/TZSZ8y
   FLQWiCJm2Y+tOcG3d4INqUqLElO5pA6iD1fHh5huoPzlaNX6+vrASLCKE
   9kQeFCnPAapoHfFpKWU4K65TSjw75iArrpMgBRkjL/borVVTtpKsnA/Tr
   scB+DqPOZW24UqDWwVPhWbTMJ/0UCDOTLlFKxkL93bmkUiwS7lvp+Qoll
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="46711834"
X-IronPort-AV: E=Sophos;i="5.88,250,1635174000"; 
   d="scan'208";a="46711834"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 17:29:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpqD4p6u+/hy0ZUgwmJIvzZF2ptxtM+taZ9x5/BxrOxuamya3Kp0ZPNTgiIhoFpmf7QT4cOhQprfhI2EdmiXlLzo+FaN3XP+Fq1jn9LHWO/7mfOO0rgc28Y7E3eWIOUpF7+R2xl0EssoUHgiPvlJ+fLd2z2FFizkOjf+dxLDaqGznf75NZsHF4Z2PEBKAygAgl4Yd0zyr/2UYIwGzHTZOAXD5X9XlqwjDCnrhQzBEWKg4Tzd++IZJjeulh8rN3eWj1cx0G531G8/dhqGRX8JjY+WxXQ8G64NmVfMpDrxrpKR4q2ZVdFy6HyOQzdkIr/lAXeGTSIY4szRaJDL2dZXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/bQVoaSTMwkRcKBZzpUN8LSvKKQxZt7HboKiJegNeM=;
 b=ZjpoF4lVfPMCOiDNk1Xb9/9vP8u5shsv23mVzESEWADpI9TXzWHhYcGFKVB2RljCjwMt5KeuTWKCplVZU/cfMiNCHE4dkE7aUZSo0dhdPIqf0TaYpOogQYurxgMpB/aW3D0C+zKLTXsiWpuNJ/xIkrLc6b8LsbBylPdNi1xP9RIQ2iMEODTvpMs0ZMdYqzq7mANg7AIogBLJRQeaDn0Mb4PhSQcZax4qOIHtO61AWrYDVgw/glVs3yggxRZiBw0KlVE9RtXfYQpBuj0Lx9V0NhB17JVfB/3wtME1mqaqn/XgdXegKg6OiIpWy/Fuws/clv3Q/SICG1my5tyL9mFaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/bQVoaSTMwkRcKBZzpUN8LSvKKQxZt7HboKiJegNeM=;
 b=pDSVol3++9cuyHxneAlNN6chyC2a3p1Ya3ahCcf5sGM5R8XOA/aBy6c8EjI8yrqap8FM2t0CzTl/NFtSIOqcmaYCTDW0nuZ7AZdD+ZQYwigmlm1/G361xxvYZxYurGfZeUJ8JUmgv2Ns0uBPHzQ4jUObGevlvmjl0ZV6g15rQUQ=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB7015.jpnprd01.prod.outlook.com (2603:1096:604:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Fri, 31 Dec
 2021 08:29:06 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%3]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 08:29:05 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbsojLLXTBWKk+I52jDqCmDKaxLkGOAgAC1nQA=
Date:   Fri, 31 Dec 2021 08:29:05 +0000
Message-ID: <61CEBF4E.1090308@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
In-Reply-To: <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d6314c6-d373-4a17-c1d4-08d9cc379bce
x-ms-traffictypediagnostic: OS3PR01MB7015:EE_
x-microsoft-antispam-prvs: <OS3PR01MB7015E3ABCDA3C8358EDB56AA83469@OS3PR01MB7015.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mn7pLGSdbC/HNIDsLjjMq5+qIK8aUNes5Y1jrc3VLE/t6cKNrXIimvcGbUy4RfO69e2niax84ihkg1vRoUQbYOl0XUo/uskeSEaZnabihUAhJzgtXMMcJT8D3ODtx2gAyOTg4MNNKuPiKYeao2Vh1DQ3rjTP5FWjBOTQQPnyqXKxcCSSeA3WU+q+mG3fhXV6cxQ6Lt8do8JJxbrXNWbgOZk5dVc9Q0yodAPrxwkk8kvaOzOazLZ3emjCzb80gssAtJIL1SoH442tFmsjjxBqgKE9T7N511dfVWlH9IHoqQDhB60Q621WM/Mp1QzFnxYaMsccO7jYtj84a3hZpqb+hjRSZXja0iq6yBdtVFMmtbNWPv7UxqoFwaXi5yPYRCAX0ICNtEvff1Z5BW1cg7rt/QRJj5tXMBV0mWQuTqImo/tN/8Sjc75ENA6gil+qjfhLU+4OH0DeShlPwmizqDQNjW8VarCGwi3aoMXXR3OnXFvk6RCDaXnO+rTeF359zyJfqn6ugOLWCHHIVrN+LkWFWIfj/7KjZdXXIRNoNGyxk0Vr1nZAOIU6wSMht3NWuw7IjvIvUkShOpH9D8Q4lBeqfaZGRiYEUVKqWuZTSo5MNe/fT55rO+3ODdxntQab7q5BzghOZnMJz7TFVGDlhLKj5i5fBsNXjqiUvL1kpNSl3XsUEPH1VfaS60KBcLRBI7xgldPrOp9g8C34qIDMcZdgXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(82960400001)(508600001)(38070700005)(2616005)(6916009)(186003)(64756008)(8676002)(6512007)(85182001)(4326008)(5660300002)(2906002)(71200400001)(54906003)(38100700002)(6486002)(76116006)(87266011)(66446008)(66556008)(316002)(66476007)(8936002)(53546011)(36756003)(6506007)(26005)(91956017)(122000001)(86362001)(83380400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXlDOW13S3F0dXNZbWUwaGo0cGhMdk9DSit5ZmtSbjBJRk1INExHa1JUOWFp?=
 =?utf-8?B?ZHhZc1lvb2ZFUFZKSWcrVGpiNTBPblR4TzNKR2JsSThiNVBaM0RUZ2h6RVBP?=
 =?utf-8?B?MEk2QmczY29pREZnZlY2bTJ3ZGlaQVN2MVhmc2Y5YnFwZHRhdEdxOThMaXBV?=
 =?utf-8?B?bjVJZWptdFlTY2kvZW8xM0VWVDdQL2xlb3htNUZoZnRUWVNDN0lJcHN2Z3lS?=
 =?utf-8?B?dDQrMk9TMi90QlljeC81NGtod21OQmVDQ0wzRnFtOStkZDhPWWpYYkhWZ0RF?=
 =?utf-8?B?SkdiMkhtNENKK1NPODhGRWtOQlZqZlo4eVRSMzRYSElTdDdYVkFMMzQ5ck9r?=
 =?utf-8?B?UXQrTDFpc3JZYm42SUxGTFhrRVdmaUNCMndyWjI1SENnTzZUWkJBS3JDTkpu?=
 =?utf-8?B?MHozUGFmMVMrRlNNWFJ3MFVaaXZRV3NVSmNlUWRnQ3BxWTlFNU91VUM3QjlM?=
 =?utf-8?B?MDRMQUFvc2h2RmlIbHlSb1JDVmxjVENsZy9OaWhzYW1TSHdORmhXbjY3d1dC?=
 =?utf-8?B?ME5SUXRndnFBeHV1UCswZG9BK0NjVEU4b2tzQ2wvbTFXRlJxVXk1NE1uYUFY?=
 =?utf-8?B?Z2p3ZzVZSW01S0puTjBqMnN6bHJSdy84dk1GWE5xNFhBRWhaQjdZTTFOU0VS?=
 =?utf-8?B?bW5tYW5TcC9FSVFFRWhJWVNLeFZ0RjkrTmtub0drS29sV3RYa0lseStjVFQv?=
 =?utf-8?B?TnA5b0pPV1FrVkJ3SFk3UkZhNktIRkZmM1NWUnd5bDc5RUlxVnFGVTZzNitu?=
 =?utf-8?B?Q1pma3VsNWRMeUdCOUVqR2krMWk3anYyZWcwQ3RHWjZkV1B3YjUyNklpN2tI?=
 =?utf-8?B?OTBoOVNqWnA1T1NYay8yVlJ5TnBqd29nbGxab0hrUmN5LzFEQzU0OVdDVmhT?=
 =?utf-8?B?RWJYQ0pxbWNSOXZEZkVxaEMyaE12cnhiSGcyMlpJazU0b2VrT1FmR2dUMEJm?=
 =?utf-8?B?ZFlCMmo1YUxJNFBwN1J6Q1pKWWxxQUhxanZJeGt6a0hFNFpHaFcyUmFyOVcx?=
 =?utf-8?B?L252UkI2dTFzem0zWllDT0lQRmFwUFcvWm5pTnBhdnRSbGN1c3QyaUhBUTBr?=
 =?utf-8?B?TGRSaXArSlJDMGlORTNQS3lzcmlRQ2VIelNxbjlFUWc2QXZuV2hZV2hZcndK?=
 =?utf-8?B?UFgyb3FHRWxsTXZ6V1dRaTFPNlEvK0FvNXlPcVRYOEh5NDhMRm1ZbkVEU015?=
 =?utf-8?B?WHR2OXlZRW5kMVNtSkdBVFRLZmhodFZoWTRrY3VSZWtoYk95TUtuVHp6aXRS?=
 =?utf-8?B?R042cy9RNXZ3bldrYUI4QUlPZUY3WWJLRnlJWW1ubXY4Nit4cUdianA4TDV0?=
 =?utf-8?B?NU9taFZNVFhsRk8vZ2w1WlpLOTFpRFNPei91SnUwR1NnSmJmL1JrMytuZHZo?=
 =?utf-8?B?T0lyVFR1cTBZWG1zM2RFYTVnRk80QnloTC9LMWtsOGZkT1g5a2Nud0VxUXkz?=
 =?utf-8?B?MTRqbHhsZ20rQWdkemYxQkwxYXA2UFgzZTZxQ0hUdHAzbGVZZEM4SWQwZG9O?=
 =?utf-8?B?WHh0K0tCdmNJSzYrdSt3OEkvQWhRWHVIM2hDVTlPdnl0QjZ3THBQWTZvWXJL?=
 =?utf-8?B?Q0xyOVZLMWtsR25Hb2R3V1NheVBJSlBYcWlQNVNNTGN6d2Q4VmppcXpUaDVj?=
 =?utf-8?B?NjBxMFdDUXlQQlpIeFdYMjRPSlFHZHpVMU93dGZ1d0ljdEtheWVoMXN5Vkxa?=
 =?utf-8?B?S1EySmRpQjB3MXhYczBFTUFMZ0Q0T21SMjZ2aFNFNXRWb0E5VEh5M0hpQ3Uw?=
 =?utf-8?B?a0pNdHc2bFJwV2JQTjBHd2dCZnB2Qnpsa0tLWEh4bXlhTGRwS3I5OUFWSVly?=
 =?utf-8?B?Tk5TYU13VUlEcUtheEk2N05XNDJGT2VNd0dySlJrTmUxQWJkL1p5bXhYcE45?=
 =?utf-8?B?d1crUXFMZG5YaXBoT1BaT3V0VER0c0w0RkI2MEdUalVFSDNwYTVyNVZYWXpI?=
 =?utf-8?B?RU82S01XcnZ2MXZvZitKZ0JaYitxbXhZMEtsUHZ1WTR2cE9Wa0JsZzVmdVVv?=
 =?utf-8?B?V2oyQUNBKy9WVHlmdDZhUzd4d1NtVWdFYWU1bmFLR0J6TEZ4QXBXcER2czl6?=
 =?utf-8?B?VHRzb3ZFVkh5RlZBc01OVjJ3KzQ5Q0ltUGxlK3Y5aEsyUE0zU1BCM3FBd3hM?=
 =?utf-8?B?SVI1cjJ1SzlRWVNnbXVYN1NObnYxTVo3WlVtQkRuSkFWbXpzTXdrbW94NHFu?=
 =?utf-8?Q?jAdZwQBV/+LEEx52tVTgA6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3A4FE84F6063B4EAE5922613BD4C2AD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6314c6-d373-4a17-c1d4-08d9cc379bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 08:29:05.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5BUz9xAXEngfwTv2Q9d75jyNFzfhQsoS2EvkR11XxvdxB6rW6bKMzZFrhTx0/lsB/uYabF5BwJviFoKMWe+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7015
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS8xMi8zMSA1OjM5LCBUb20gVGFscGV5IHdyb3RlOg0KPg0KPiBPbiAxMi8zMC8yMDIx
IDc6MTQgQU0sIFhpYW8gWWFuZyB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBSRE1B
IEF0b21pYyBXcml0ZSBvcGVyYXRpb24gZm9yIFJDIHNlcnZpY2UuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9jb21wLmMgICB8ICA0ICsrKw0KPj4gICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUuYyB8IDE4ICsrKysrKysrKysNCj4+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bjb2RlLmggfCAgMyArKw0KPj4gICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jICAgICB8ICAzICstDQo+PiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jICAgIHwgMTAgKysrKy0tDQo+PiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyAgIHwgNDkgKysrKysrKysrKysrKysrKysrKysrLS0t
LS0NCj4+ICAgaW5jbHVkZS9yZG1hL2liX3BhY2suaCAgICAgICAgICAgICAgICAgfCAgMiArKw0K
Pj4gICBpbmNsdWRlL3JkbWEvaWJfdmVyYnMuaCAgICAgICAgICAgICAgICB8ICAyICsrDQo+PiAg
IGluY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfdmVyYnMuaCAgICAgIHwgIDIgKysNCj4+ICAgOSBm
aWxlcyBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4+DQo+DQo+
IDxzbmlwPg0KPg0KPj4gKy8qIEd1YXJhbnRlZSBhdG9taWNpdHkgb2YgYXRvbWljIHdyaXRlIG9w
ZXJhdGlvbnMgYXQgdGhlIG1hY2hpbmUgDQo+PiBsZXZlbC4gKi8NCj4+ICtzdGF0aWMgREVGSU5F
X1NQSU5MT0NLKGF0b21pY193cml0ZV9vcHNfbG9jayk7DQo+PiArDQo+PiArc3RhdGljIGVudW0g
cmVzcF9zdGF0ZXMgcHJvY2Vzc19hdG9taWNfd3JpdGUoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCByeGVfcGt0X2luZm8gKnBrdCkNCj4+ICt7
DQo+PiArICAgIHU2NCAqc3JjLCAqZHN0Ow0KPj4gKyAgICBzdHJ1Y3QgcnhlX21yICptciA9IHFw
LT5yZXNwLm1yOw0KPj4gKw0KPj4gKyAgICBzcmMgPSBwYXlsb2FkX2FkZHIocGt0KTsNCj4+ICsN
Cj4+ICsgICAgZHN0ID0gaW92YV90b192YWRkcihtciwgcXAtPnJlc3AudmEgKyBxcC0+cmVzcC5v
ZmZzZXQsIA0KPj4gc2l6ZW9mKHU2NCkpOw0KPj4gKyAgICBpZiAoIWRzdCB8fCAodWludHB0cl90
KWRzdCAmIDcpDQo+PiArICAgICAgICByZXR1cm4gUkVTUFNUX0VSUl9NSVNBTElHTkVEX0FUT01J
QzsNCj4+ICsNCj4+ICsgICAgc3Bpbl9sb2NrX2JoKCZhdG9taWNfd3JpdGVfb3BzX2xvY2spOw0K
Pj4gKyAgICAqZHN0ID0gKnNyYzsNCj4+ICsgICAgc3Bpbl91bmxvY2tfYmgoJmF0b21pY193cml0
ZV9vcHNfbG9jayk7DQo+DQo+IFNwaW5sb2NrIHByb3RlY3Rpb24gaXMgaW5zdWZmaWNpZW50ISBV
c2luZyBhIHNwaW5sb2NrIHByb3RlY3RzIG9ubHkNCj4gdGhlIGF0b21pY2l0eSBvZiB0aGUgc3Rv
cmUgb3BlcmF0aW9uIHdpdGggcmVzcGVjdCB0byBhbm90aGVyIHJlbW90ZQ0KPiBhdG9taWNfd3Jp
dGUgb3BlcmF0aW9uLiBCdXQgdGhlIHNlbWFudGljcyBvZiBSRE1BX0FUT01JQ19XUklURSBnbyBt
dWNoDQo+IGZ1cnRoZXIuIFRoZSBvcGVyYXRpb24gcmVxdWlyZXMgYSBmdWxseSBhdG9taWMgYnVz
IHRyYW5zYWN0aW9uLCBhY3Jvc3MNCj4gdGhlIG1lbW9yeSBjb21wbGV4IGFuZCB3aXRoIHJlc3Bl
Y3QgdG8gQ1BVLCBQQ0ksIGFuZCBvdGhlciBzb3VyY2VzLg0KPiBBbmQgdGhpcyBndWFyYW50ZWUg
bmVlZHMgdG8gYXBwbHkgdG8gYWxsIGFyY2hpdGVjdHVyZXMsIGluY2x1ZGluZyBvbmVzDQo+IHdp
dGggbm9uY29oZXJlbnQgY2FjaGVzIChzb2Z0d2FyZSBjb25zaXN0ZW5jeSkuDQo+DQo+IEJlY2F1
c2UgUlhFIGlzIGEgc29mdHdhcmUgcHJvdmlkZXIsIEkgYmVsaWV2ZSB0aGUgbW9zdCBuYXR1cmFs
IGFwcHJvYWNoDQo+IGhlcmUgaXMgdG8gdXNlIGFuIGF0b21pYzY0X3NldChkc3QsICpzcmMpLiBC
dXQgSSdtIG5vdCBjZXJ0YWluIHRoaXMNCj4gaXMgc3VwcG9ydGVkIG9uIGFsbCB0aGUgdGFyZ2V0
IGFyY2hpdGVjdHVyZXMsIHRoZXJlZm9yZSBpdCBtYXkgcmVxdWlyZQ0KPiBzb21lIGFkZGl0aW9u
YWwgZmFpbHVyZSBjaGVja3MsIHN1Y2ggYXMgc3RyaWN0ZXIgYWxpZ25tZW50IHRoYW4gdGVzdGlu
Zw0KPiAoZHN0ICYgNyksIG9yIHJldHVybmluZyBhIGZhaWx1cmUgaWYgYXRvbWljNjQgb3BlcmF0
aW9ucyBhcmUgbm90DQo+IGF2YWlsYWJsZS4gSSBlc3BlY2lhbGx5IHRoaW5rIHRoZSBBUk0gYW5k
IFBQQyBwbGF0Zm9ybXMgd2lsbCBuZWVkDQo+IGFuIGV4cGVydCByZXZpZXcuDQpIaSBUb20sDQoN
ClRoYW5rcyBhIGxvdCBmb3IgdGhlIGRldGFpbGVkIHN1Z2dlc3Rpb24uDQoNCkkgd2lsbCB0cnkg
dG8gdXNlIGF0b21pYzY0X3NldCgpIGFuZCBhZGQgYWRkaXRpb25hbCBmYWlsdXJlIGNoZWNrcy4N
CkJ5IHRoZSB3YXksIHByb2Nlc3NfYXRvbWljKCkgdXNlcyB0aGUgc2FtZSBtZXRob2Qoc3Bpbmxv
Y2sgKyBhc3NpZ25tZW50IA0KZXhwcmVzc2lvbiksDQpzbyBkbyB5b3UgdGhpbmsgd2UgYWxzbyBu
ZWVkIHRvIHVwZGF0ZSBpdCBieSB1c2luZyBhdG9taWM2NF9zZXQoKT8NCg0KQmVzdCBSZWdhcmRz
LA0KWGlhbyBZYW5nDQo+DQo+IElPVywgbmFrIQ0KPg0KPiBUb20uDQo=
