Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0214932A8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 03:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbiASCBP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 21:01:15 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:27700 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238748AbiASCBO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 21:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642557674; x=1674093674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J+iKMGXYN4CK3JwaR5vxDnoFz8CvauzzR8X0tX9Zb04=;
  b=jg497RZnwW+xmyJQgQ2+ncZ6iNdkAIdPQ1l/T1ogBjR+BuMcvYSW+km+
   2l/b8PQQCZfo8B7TIFrKWteTQnfxvIXxC94Pky4Wyj9QGSNhzQIi/y/38
   GPTAo2ufc9tRNkX8bAgyrSqYphgavhw7wY3McnR50xbtg/vgOL1zG3ER8
   8+0dHUv5kilgJHweCf6QFa6W4fBWWpJNYKseuGnNpY1uKKDs9dbvw5F7i
   FcMidDPetbhcmrG4srHtc6HYuAt91+yWHPghWNu2S7UBFsriRErdYRXYC
   cUu2y9wgj4L9Sjg5heLaIm8vZDnel8ev+RG9bMylq9Xlv8Fy1f3p8y744
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="47774459"
X-IronPort-AV: E=Sophos;i="5.88,298,1635174000"; 
   d="scan'208";a="47774459"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:01:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGYAvQAbmJwOpET+VRYiTq7FqNuZY0mWYgaT1t+4zCvb3Nquy4geejuw/CBrYJBdjPG6XWZz7/eyr83E6UUm30iB1yZ2dRYzEFhQAjC+GXIrUaQQtEVY/TeRiYvIPMohgU60ILAd7cYiuqD0CkYUzuZ/MjFxkPTMQvVc9Vy93YrMth5HfC4e/1Ez+q7MJuGbcKW0G+uELdX5hHsRthA8HEblHf3IzPtR91hjwmFpkXlOxZzmq1DRskaBblXGE66yBEqdQonE9KPexMDn8YUesZr3hY0QVR582+hYr3GSOfqulflsOdTy1Mt3RfQ8cjss9DK8IddGxX22+RFNIKqKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+iKMGXYN4CK3JwaR5vxDnoFz8CvauzzR8X0tX9Zb04=;
 b=OkRaYH60KP4c09+6KO8vZ465X2NJh6Qo7VkuScdXi1nDR89uNGAgxmrCs6HJsclc4x5O2u0usFbYaNnHcT+S9yt6R0m4mCOmOYaL5DbPQ4k85lmcTU76hbgTonRMeGoq0DHnX/Y++2aQruSHjV80h2fDUImUXFLGA8wC0o/f0cn/G+CUwg8IMVHF6lbJtrdpZnorZb5jET4bkJFIg2T/AQVVJAKLxQfTw+3B+cf0V7i+w2ohMx88ZuiU644UItUBYlpJf9YhPZzRLW15tJ7A6zv6HprptlfWyy5cpI7UKNdxJekXnjwEreJQEhq/avyVv4+A5iQPTQVjAGEctAfT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+iKMGXYN4CK3JwaR5vxDnoFz8CvauzzR8X0tX9Zb04=;
 b=N0CZlm9UlkHKNXHG0MFjwGi2UxCI4AniBAU0DWQEhzNurhKnc8ha4gp338Cs3OeshtnTfF3rJgjyb0B/lTN5sV7KTIRU+DzmwaXD74lvfkjv6tkFT6/nwL6oG/9QzUSIx6g3hDWHXAqDXc6tYFrAwEW4fDZX5h7/jMpiySGGAy0=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB3157.jpnprd01.prod.outlook.com (2603:1096:604:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 02:01:07 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 02:01:07 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Thread-Topic: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Thread-Index: AQHX+8Eq2ywj9xVE/k2ZPCJONlAra6xVLzEAgABiHQCAEIAbgIACiU0AgABt+wCAALCeAA==
Date:   Wed, 19 Jan 2022 02:01:07 +0000
Message-ID: <d01c2745-be7d-6df4-0b21-f5e5a89e24d6@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-2-lizhijian@cn.fujitsu.com>
 <20220106002130.GP6467@ziepe.ca>
 <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com>
 <CAPcyv4h2Cuzm_fn9fi9RqQ_iEwOwuc9qdk5x_7W=VXvsOAVPFA@mail.gmail.com>
 <050c3183-2fc6-03a1-eecd-258744750972@fujitsu.com>
 <CAPcyv4h2wiJ+2h8Q9PKOysJ-3bG7N7yDeBucW+jWttUjPXRJ7Q@mail.gmail.com>
In-Reply-To: <CAPcyv4h2wiJ+2h8Q9PKOysJ-3bG7N7yDeBucW+jWttUjPXRJ7Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57c1a813-1901-4723-3bae-08d9daef8e7f
x-ms-traffictypediagnostic: OSBPR01MB3157:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3157D0AA6D775A7FF7E71A48A5599@OSBPR01MB3157.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0KiquPN6o1Rz4d1WyIKENF9eTS8g0k0C8MUeHFv6g4k+y05MAtFMWi0gWaRkiMlmU+AdNe+/8hrRETbGhg043VPha/h8TEaYl/pFyXOIhuXZtYO7Xf1dJFj6pekujeCSDL91P5wSqN/U+H4jg7NpaxAqEp6glIzuWzcNUHseTalBykT8euB6gR6wy2vx+AYbLgYS6tMB/5AfwCGSNuh4FoPQzizkdMuHWffTg4dnI6cM05lZXQOHa5iOdFc6JCGA0dpz/H0ULGv81nrS2RIiSzEPrSrzWv7NqwVGFBNf3IkcyULhke+kWog9AYFHxTQZDc7PcDYz6W/2lN73q7gz02dps/wggT2EbRCx+AlKxg+BcYa/+UH8YeAK6d2jllIOhnNl7VlurLVa3dGsHxl8uyebUo67210Y1dyY/DGbvXWBK/0jRTkGAix74/p1ZTKiBJhpmJHzDMBiOsKRnciBXACT87WMcthsXBlEycnPeeUjHUou3q6BKxXb6S9/N+LtlZoal96DTJmqR2R1XM/S6KxMYgiKQx0pVtMTu5qot7dpXHgXIb8oayOEvC46oZU2CVy4Fwrez2YnAdYWYWBKYqBEpvQL0V1RgeDfGQaoN6JcbDEOo+ytz7QOIX1xbGDUsywoL80iphxgEZPCekBMXrnG8lu/vlA6+R9wMEWcgBCnpLDYA1xKUB/aBGUsOVuRdlV2vG17GT3h20YHKmBMQKQ7WHE+pd5puPtiBfGtlcm71923SS7c6wFk9gPS9GJJdn+m6k3aG8WpkkpKZwh9D2ED5eW9XmyW5KN47FqN/gBDlpwHQuQIRsh/uOWNaxg1qvxrKqgm9mJvPeMcQ79VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(91956017)(83380400001)(76116006)(38070700005)(8676002)(6506007)(38100700002)(8936002)(66946007)(26005)(66446008)(66476007)(82960400001)(508600001)(64756008)(85182001)(71200400001)(5660300002)(31686004)(186003)(54906003)(36756003)(86362001)(2616005)(7416002)(6486002)(31696002)(6512007)(2906002)(53546011)(316002)(4326008)(122000001)(107886003)(6916009)(21314003)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDdsRXhhK29pRW9VcytZR1RNdmZVRmZZb3JqZlhjT2FBTDJNc2cvbVNSTzVl?=
 =?utf-8?B?eUsrQU8xNysxMW1BLy9JbzhVbzNwYUN5c2l1QWdxV1I0Rk9HaFIxVlg4RWJr?=
 =?utf-8?B?UkkyeFJ1Kzl6L1l3VHAvZ0duaW5nVjEwd1g0M2lwa2VqbVY3RmNQV1VlREZl?=
 =?utf-8?B?SUtUc2RRREVUTE9Hbkw2MjVhWFFLR0FEdGxEd3NpR2RPSUlaSnZidldJZ0Mw?=
 =?utf-8?B?RC8yRnBBUjhWelVmZUJXQStLd2xuUFZIZHRxbjBmdS9kdk5qNTY2TnRnVU9t?=
 =?utf-8?B?cUprWnc5QWNrVnhaVFBtUmd2T3RpSkFBQ2kvV1V5WGUvdmwxWkhpOGo2YVYv?=
 =?utf-8?B?ZzNwQUQycFRFZys5VCtjeTdHbEN6dmcwRW50OHM0SkJCNmxQTDBJbU1CT3RG?=
 =?utf-8?B?aWd2R0VuNTlYRzIwU0NydElkUzhRTThiSmxFVHZ6Vy9BdS8rV1BMa3JEVE93?=
 =?utf-8?B?K2JMWkxkT3lOZ2hLN3JsOW1qaXJ4bC9iRW4wZDlKeEUwZjVlMGRqbzE3VWp6?=
 =?utf-8?B?QUF2bmZFbkxwM0FiOHNsVjdqNHVLL1RRNk5vb2YvdjRYajczVnhzNWR1U2FX?=
 =?utf-8?B?cWFLM0xvVmhzcHI0YXB0UnFZVlVBaUpSZE9ZQ1JrR1hIdDR5SVNld1drdEV0?=
 =?utf-8?B?aWs4RXlodHNkWThzYktCV0tuc2JZeThhUnNCNnFVdWhQZHgvZm01RGdHWkh0?=
 =?utf-8?B?a25YZjFoMUw4MjhTSVo4TTNrRjVSTzZjU3JFMXV2ZWZ2Z0VQYXJXMTQ1YlNT?=
 =?utf-8?B?QnB4RE9oVWNKdWppMjhReU40b0NiSmlVV3VLMEwxcGRUT3RCWm40bk9XMUNR?=
 =?utf-8?B?c0RadHl1UmdzcDFySmpZTnpSNlRXWTJBQjlOTERTYi96Snkxb3A4Q0U1UFpK?=
 =?utf-8?B?aWR5TVZUNWpwcm53N1JQR3o1elZpV05GV0ttdm5lTUEyekFidER1YThpWUxP?=
 =?utf-8?B?cTU3NFNLOWE3dHcxVlEwbzlWcnB5Y2xOQkxjbS9ORDFhZlhJQkgvTzNxakZ4?=
 =?utf-8?B?dkQ5RGhoL0xIdGVBWXNBNkhNY3ozaVhHVENkYmk2dkpPSThPSWFJclpodEU2?=
 =?utf-8?B?RVRDUm92K1pQWGRYSmpHTUdBWnN2WE9sejlIbWdZU1BOalk3VktUVW55N3RC?=
 =?utf-8?B?VUMrTko1TDlheVprRWdMMS9DT1lRNEtjU0JIUlRGYzlrbmQwZUV0NGpkbUIw?=
 =?utf-8?B?YTY1L0p3UE1aU1orc0liWkx2TTBuYy8yYkRTSzRlRjAxbmM4SnZQdEhJZHhz?=
 =?utf-8?B?LzJNc1Q5bnJyeHU0bnJTUGRvZlRscGFPd3VtbGFWRnhoL1FpYzBXVi9tU0d0?=
 =?utf-8?B?R2JZTnFncUVWNkk5VWU4WXFiOXM4YklnNFFoN0V3Ukg0VUgxc2Y5a0VTQnVO?=
 =?utf-8?B?QTN4amZQZUNkNlFyU09xdDlTMkxvOGlmWVB2Y0hlODNlRmYxSERFcG82Yll3?=
 =?utf-8?B?cU9RaWo5TElJZVRNRFpoOVJnUlFjTUg5bW81ZFNQUzF2SHpGZ05iYklUZmJo?=
 =?utf-8?B?TDEwZVdjMnBISUtUeW9MaDlUYURRRlVDUXROVTB5RzUvUmZ1Zm5FVGFBaVpo?=
 =?utf-8?B?L3BWT3g0VW1DVWtLcXdYKzVUYkZIWkg0MmtnSUViMFlLYmdtcDV1VVlmOHNR?=
 =?utf-8?B?UG96SW5MQjh2aFE2dGhYbVBXUzBlRjlyUXdUZEdGdWVuT21pUng5emNnSFNN?=
 =?utf-8?B?WGsxYjE0dHRTOVdlMkN5eXJXdTE0a3Mxa2FQOWNiZHp1TmJSajhod0NMVy9V?=
 =?utf-8?B?b0MyWkJrcGhzQnkxRDc3M05GaVVxNUFtUXBUK1p2dHRUUUcrbG1mUUVQeDNv?=
 =?utf-8?B?RkM1TVQ5ZEhUejBWQm9vcTc5aWREeVRCbTl1SXlpeXNYZERNZkNKbnhleG1H?=
 =?utf-8?B?aFRUaHN3T25qM2RObTAxOTdrbk5vU0dpQnFrU2hqQUZPRVZiZXpxVzA0cHBG?=
 =?utf-8?B?NXp2SEFqSDhNK0llbDNVbWNmUWF0U1k2clExSVpZQUI5V2V2M3R6YWdJWVk4?=
 =?utf-8?B?Rk1ucUNwTWRFM3JWZWMwaklSNG1MMnVrOUtRdFc2bHNZSlgwK09TWE5kWmNW?=
 =?utf-8?B?bkFNenQrRmVNL1I4S2J4c09JUlN6TXdhL0JpV2c3bVFnQm9aQWFjYzU4bFRp?=
 =?utf-8?B?aEx2YUcrWXp3Yk9WNlA1OVVDZjlhcTBLdHhEVXEzN0FRNnFqV2pwdi9COWdN?=
 =?utf-8?Q?iUtFgIhU2eJk+ws4ZlUG7jE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1578C2B8255B7D4099B1595858A390C7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c1a813-1901-4723-3bae-08d9daef8e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 02:01:07.1909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 707LE8ZDZC0ytQf7NRNq/oIdic4NYS5WHXyErSPc/YTtzYZ3JcG9sM4FmQwDxoaitk0N3iGWN2BHwdf2xr75Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3157
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE4LzAxLzIwMjIgMjM6MjgsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gVHVlLCBK
YW4gMTgsIDIwMjIgYXQgMTI6NTUgQU0gbGl6aGlqaWFuQGZ1aml0c3UuY29tDQo+IDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAxNy8wMS8yMDIyIDAyOjExLCBE
YW4gV2lsbGlhbXMgd3JvdGU6DQo+Pj4gT24gV2VkLCBKYW4gNSwgMjAyMiBhdCAxMDoxMyBQTSBs
aXpoaWppYW5AZnVqaXRzdS5jb20NCj4+PiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPiB3cm90ZToN
Cj4+Pj4gQWRkIERhbiB0byB0aGUgcGFydHkgOikNCj4+Pj4NCj4+Pj4gTWF5IGkga25vdyB3aGV0
aGVyIHRoZXJlIGlzIGFueSBleGlzdGluZyBBUElzIHRvIGNoZWNrIHdoZXRoZXINCj4+Pj4gYSB2
YS9wYWdlIGJhY2tzIHRvIGEgbnZkaW1tL3BtZW0gPw0KPj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+PiBP
biAwNi8wMS8yMDIyIDA4OjIxLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4+PiBPbiBUdWUs
IERlYyAyOCwgMjAyMSBhdCAwNDowNzowOFBNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4+
Pj4+IFdlIGNhbiB1c2UgaXQgdG8gaW5kaWNhdGUgd2hldGhlciB0aGUgcmVnaXN0ZXJpbmcgbXIg
aXMgYXNzb2NpYXRlZCB3aXRoDQo+Pj4+Pj4gYSBwbWVtL252ZGltbSBvciBub3QuDQo+Pj4+Pj4N
Cj4+Pj4+PiBDdXJyZW50bHksIHdlIG9ubHkgYXNzaWduIGl0IGluIHJ4ZSBkcml2ZXIsIGZvciBv
dGhlciBkZXZpY2UvZHJpdmVycywNCj4+Pj4+PiB0aGV5IHNob3VsZCBpbXBsZW1lbnQgaXQgaWYg
bmVlZGVkLg0KPj4+Pj4+DQo+Pj4+Pj4gUkRNQSBGTFVTSCB3aWxsIHN1cHBvcnQgdGhlIHBlcnNp
c3RlbmNlIGZlYXR1cmUgZm9yIGEgcG1lbS9udmRpbW0uDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQo+Pj4+Pj4gICAg
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgfCA0NyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+Pj4+PiAgICAgaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmggICAgICAg
ICAgICB8ICAxICsNCj4+Pj4+PiAgICAgMiBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCsp
DQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+Pj4+PiBpbmRl
eCA3YzRjZDE5YTlkYjIuLmJjZDVlN2FmYTQ3NSAxMDA2NDQNCj4+Pj4+PiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+Pj4+Pj4gQEAgLTE2Miw2ICsxNjIsNTAgQEAg
dm9pZCByeGVfbXJfaW5pdF9kbWEoc3RydWN0IHJ4ZV9wZCAqcGQsIGludCBhY2Nlc3MsIHN0cnVj
dCByeGVfbXIgKm1yKQ0KPj4+Pj4+ICAgICAgICBtci0+dHlwZSA9IElCX01SX1RZUEVfRE1BOw0K
Pj4+Pj4+ICAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiArLy8gWFhYOiB0aGUgbG9naWMgaXMgc2ltaWxh
ciB3aXRoIG1tL21lbW9yeS1mYWlsdXJlLmMNCj4+Pj4+PiArc3RhdGljIGJvb2wgcGFnZV9pbl9k
ZXZfcGFnZW1hcChzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4+Pj4+PiArew0KPj4+Pj4+ICsgICAgdW5z
aWduZWQgbG9uZyBwZm47DQo+Pj4+Pj4gKyAgICBzdHJ1Y3QgcGFnZSAqcDsNCj4+Pj4+PiArICAg
IHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXAgPSBOVUxMOw0KPj4+Pj4+ICsNCj4+Pj4+PiArICAg
IHBmbiA9IHBhZ2VfdG9fcGZuKHBhZ2UpOw0KPj4+Pj4+ICsgICAgaWYgKCFwZm4pIHsNCj4+Pj4+
PiArICAgICAgICAgICAgcHJfZXJyKCJubyBzdWNoIHBmbiBmb3IgcGFnZSAlcFxuIiwgcGFnZSk7
DQo+Pj4+Pj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+Pj4+PiArICAgIH0NCj4+Pj4+
PiArDQo+Pj4+Pj4gKyAgICBwID0gcGZuX3RvX29ubGluZV9wYWdlKHBmbik7DQo+Pj4+Pj4gKyAg
ICBpZiAoIXApIHsNCj4+Pj4+PiArICAgICAgICAgICAgaWYgKHBmbl92YWxpZChwZm4pKSB7DQo+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgcGdtYXAgPSBnZXRfZGV2X3BhZ2VtYXAocGZuLCBO
VUxMKTsNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICBpZiAocGdtYXApDQo+Pj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwdXRfZGV2X3BhZ2VtYXAocGdtYXApOw0KPj4+Pj4+
ICsgICAgICAgICAgICB9DQo+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgcmV0
dXJuICEhcGdtYXA7DQo+Pj4+PiBZb3UgbmVlZCB0byBnZXQgRGFuIHRvIGNoZWNrIHRoaXMgb3V0
LCBidXQgSSdtIHByZXR0eSBzdXJlIHRoaXMgc2hvdWxkDQo+Pj4+PiBiZSBtb3JlIGxpa2UgdGhp
czoNCj4+Pj4+DQo+Pj4+PiBpZiAoaXNfem9uZV9kZXZpY2VfcGFnZShwYWdlKSAmJiBwYWdlLT5w
Z21hcC0+dHlwZSA9PSBNRU1PUllfREVWSUNFX0ZTX0RBWCkNCj4+Pj4gR3JlYXQsIGkgaGF2ZSBh
ZGRlZCBoaW0uDQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+Pj4gK3N0YXRpYyBib29sIGlvdmFfaW5f
cG1lbShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIGludCBsZW5ndGgpDQo+Pj4+Pj4gK3sN
Cj4+Pj4+PiArICAgIHN0cnVjdCBwYWdlICpwYWdlID0gTlVMTDsNCj4+Pj4+PiArICAgIGNoYXIg
KnZhZGRyID0gaW92YV90b192YWRkcihtciwgaW92YSwgbGVuZ3RoKTsNCj4+Pj4+PiArDQo+Pj4+
Pj4gKyAgICBpZiAoIXZhZGRyKSB7DQo+Pj4+Pj4gKyAgICAgICAgICAgIHByX2Vycigibm90IGEg
dmFsaWQgaW92YSAlbGx1XG4iLCBpb3ZhKTsNCj4+Pj4+PiArICAgICAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPj4+Pj4+ICsgICAgfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIHBhZ2UgPSB2aXJ0X3Rv
X3BhZ2UodmFkZHIpOw0KPj4+Pj4gQW5kIG9idmlvdXNseSB0aGlzIGlzbid0IHVuaWZvcm0gZm9y
IHRoZSBlbnRpcmUgdW1lbSwgc28gSSBkb24ndCBldmVuDQo+Pj4+PiBrbm93IHdoYXQgdGhpcyBp
cyBzdXBwb3NlZCB0byBtZWFuLg0KPj4+PiBNeSBpbnRlbnRpb24gaXMgdG8gY2hlY2sgaWYgYSBt
ZW1vcnkgcmVnaW9uIGJlbG9uZ3MgdG8gYSBudmRpbW0vcG1lbS4NCj4+Pj4gVGhlIGFwcHJvYWNo
IGlzIGxpa2UgdGhhdDoNCj4+Pj4gaW92YSh1c2VyIHNwYWNlKS0rICAgICAgICAgICAgICAgICAg
ICAgKy0+IHBhZ2UgLT4gcGFnZV9pbl9kZXZfcGFnZW1hcCgpDQo+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgIHwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAr
LT4gdmEoa2VybmVsIHNwYWNlKSAtKw0KPj4+PiBTaW5jZSBjdXJyZW50IE1SJ3MgdmEgaXMgYXNz
b2NpYXRlZCB3aXRoIG1hcF9zZXQgd2hlcmUgaXQgcmVjb3JkIHRoZSByZWxhdGlvbnMNCj4+Pj4g
YmV0d2VlbiBpb3ZhIGFuZCB2YSBhbmQgcGFnZS4gRG8gZG8geW91IG1lYW4gd2Ugc2hvdWxkIHRy
YXZlbCBtYXBfc2V0IHRvDQo+Pj4+IGdldCBpdHMgcGFnZSA/IG9yIGJ5IGFueSBvdGhlciB3YXlz
Lg0KPj4+IEFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5IGluIHJlc3BvbmRpbmcuDQo+Pj4NCj4+PiBU
aGUgU3ViamVjdCBsaW5lIG9mIHRoaXMgcGF0Y2ggaXMgY29uZnVzaW5nLCBpZiB5b3Ugd2FudCB0
byBrbm93IGlmIGENCj4+PiBwZm4gaXMgaW4gcGVyc2lzdGVudCBtZW1vcnkgdGhlIG9ubHkgbWVj
aGFuaXNtIGZvciB0aGF0IGlzOg0KPj4+DQo+Pj4gcmVnaW9uX2ludGVyc2VjdHMoYWRkciwgbGVu
Z3RoLCBJT1JFU09VUkNFX01FTSwgSU9SRVNfREVTQ19QRVJTSVNURU5UX01FTU9SWSkNCj4+Pg0K
Pj4+IC4uLnRoZXJlIGlzIG90aGVyd2lzZSBub3RoaW5nIHBtZW0gc3BlY2lmaWMgYWJvdXQgdGhl
IGRldl9wYWdlbWFwDQo+Pj4gaW5mcmFzdHJ1Y3R1cmUuIFllcywgcG1lbSBpcyB0aGUgcHJpbWFy
eSB1c2VyLCBidXQgaXQgaXMgYWxzbyB1c2VkIGZvcg0KPj4+IG1hcHBpbmcgInNvZnQtcmVzZXJ2
ZWQiIG1lbW9yeSAoU2VlOiB0aGUgRUZJX01FTU9SWV9TUCkgYXR0cmlidXRlLCBhbmQNCj4+PiBv
dGhlciB1c2Vycy4NCj4+Pg0KPj4+IENhbiB5b3UgY2xhcmlmeSB0aGUgaW50ZW50PyBJIGFtIG1p
c3Npbmcgc29tZSBjb250ZXh0Lg0KPj4gdGhhbmtzIGZvciB5b3VyIGhlbHAgQERhbg0KPj4NCj4+
IEknbSBnb2luZyB0byBpbXBsZW1lbnQgYSBuZXcgaWJ2ZXJzIGNhbGxlZCBSRE1BIEZMVVNILCBp
dCB3aWxsIHN1cHBvcnQgZ2xvYmFsIHZpc2liaWxpdHkNCj4+IGFuZCBwZXJzaXN0ZW5jZSBwbGFj
ZW1lbnQgdHlwZS4NCj4+DQo+PiBJbiBteSBmaXJzdCBkZXNpZ24sIG9ubHkgcG1lbSBjYW4gc3Vw
cG9ydCBwZXJzaXN0ZW5jZSBwbGFjZW1lbnQgdHlwZSwgc28gaSBuZWVkIHRvIGludHJvZHVjZQ0K
Pj4gbmV3IGF0dHJpYnV0ZSBpc19wbWVtIHRvIFJETUEgbWVtb3J5IHJlZ2lvbiB3aGVyZSBpdCBh
c3NvY2lhdGVzIHRvIGEgdXNlciBzcGFjZSBhZGRyZXNzIGlvdmENCj4+IHNvIHRoYXQgaSBjYW4g
cmVqZWN0IGEgcGVyc2lzdGVuY2UgcGxhY2VtZW50IHR5cGUgdG8gRFJBTShub24tcG1lbSkuDQo+
IE9rLCBJIHRoaW5rIGZvciB0aGF0IGNhc2UgeW91IGFyZSBiZXR0ZXIgc2VydmVkIHVzaW5nIHRo
ZQ0KPiBJT1JFU19ERVNDX1BFUlNJU1RFTlRfTUVNT1JZIGRlc2lnbmF0aW9uIGFzIHRoZSBnYXRl
IGZvciBhdHRlbXB0aW5nDQo+IHRoZSBmbHVzaC4gVGhlIGRldl9wYWdlbWFwIGlzIG90aGVyd2lz
ZSBvbmx5IGluZGljYXRpbmcgdGhlIHByZXNlbmNlDQo+IG9mIGRldmljZS1iYWNrZWQgbWVtb3J5
IHBhZ2VzLCBub3QgcGVyc2lzdGVuY2UuDQoNClRoYW5rcyBhIG1pbGxpb24gZm9yIHlvdXIga2lu
ZGx5IHN1Z2dlc3Rpb24uDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg==
