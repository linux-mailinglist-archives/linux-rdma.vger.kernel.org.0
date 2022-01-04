Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C9F483F20
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 10:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiADJ2M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 04:28:12 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:13534 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbiADJ2L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 04:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641288492; x=1672824492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rz1zJuHCjF6xHgC0Y+zx/1thRqlQ/v5h78hDuXCR3Xk=;
  b=N4x7OI5d7D35ndMZfBiiEMsrYJXeXJVXUGldTqBzVqJ4sKFPaRF0OTUP
   XL2AQvlEFmihz8vWH4iF0xRy/R381nr7dWAwOCuWtXPDTvUCNak9/H8Os
   SvJo1r9lTStaX3gdKP2DQO1Ub3xw3N2Ywerzc/uQeI0rvlR67TvnzUdAO
   NnvGnFJEsV5nWx+j7oSlbgbjfyYz7Zl7axbXYMPF2YDVMbzR2zX5WyDuo
   kC4ZvqyFPCnHv6kn5ztKXzIXNxVY6aWfMn55Dvv/+2ti8wvrZGp0SMc7B
   dqQBgaJTRgxEp1jsy+fYrJS+JxEYSzJRHcdmYRpD9wv3ZkvrRP6ybBVO6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="46844291"
X-IronPort-AV: E=Sophos;i="5.88,260,1635174000"; 
   d="scan'208";a="46844291"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 18:28:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD6qBTCVG9paLl8Ra6d1sDOuakn9TwsnmagNqssasPn7ML+s348Y/mcKodHBsT9A0KfKqwl+ZPMaeLpmzxcBIXbBLUd5Tva5IajNKmz4eXQeBN3FQ5hJtVASrXqYl+Tc9tHpoLXEzgap1B87MkzObBXNVbP1j0PGSHstYRPZmHx6fbuTerg9Np+RXFTrfwoF4kXfzZqddukhA6ODnxB9jCy/ePldqBJle6gT06WQlu/Ob0zgT84WyR5/HeSWtkvctywsESjlz7ucUP41rYFMN4kgEQBBbm2niOG3QyPWJmHi+3aMBHaHgToV9VPTz4YfdOp6DyPMwbWfq3bbnGop8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz1zJuHCjF6xHgC0Y+zx/1thRqlQ/v5h78hDuXCR3Xk=;
 b=asFwMTGCu08Ri7l/S/31NUWjUNYXA3s72aNUOMqf22O2e2e8zpe8FobW1S36xZDZlQM6FSmVXQLC5V284G+A6Se1hk2LP6a7oRbtlHCtzKtx5yW7ZEJYbMjg2NRCPrbd3b+yT1uNShmqF6/QyrWUPulP4yzBvRomRzO+mZRHKhby7DS8aGQackD/U3VFMWEOOrCqK38hewIZ0YaazawJ9VGRT33MqkkbgKwWSEnlWE+wWiwW4dPkNnAVnc1w9SWpXWouCS49EgIxPCdV5QRiwoOTC5e438FW6XBznPw3Ko90HCGRRUay7dn9gVbTiT0Cn4g5Vs11ACYQ8k3A0Nz4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz1zJuHCjF6xHgC0Y+zx/1thRqlQ/v5h78hDuXCR3Xk=;
 b=lVjRDdreLb/nqdbgoke4sLOwodmK3QiA+R3xN01wTrnffQQXPnGHsVcvQqYGtNF2Kc8Mjl1MKHJ1iw5oyKKHmuqMZBaElJbPiUmeckP0heUZCF29GZq2p3wDktkSmndACArbWzJaI8k5EEdPuImqXY6z8ATQl18nL2h/0c1QZ3Y=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB7000.jpnprd01.prod.outlook.com (2603:1096:604:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 09:28:05 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%3]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 09:28:05 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbrMyXFTG4iC0uvkiFLA5nCQaxLae+AgAAndACAAJOUAIAGetKA
Date:   Tue, 4 Jan 2022 09:28:05 +0000
Message-ID: <61D4131D.5070700@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com>
In-Reply-To: <61CEA398.7090703@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee880b5d-b49d-4596-3609-08d9cf64834b
x-ms-traffictypediagnostic: OS3PR01MB7000:EE_
x-microsoft-antispam-prvs: <OS3PR01MB700009D5A0FC65D508D9C0B1834A9@OS3PR01MB7000.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FW3aSj9Tmx6YWKDo1+BbmCbwlmtkM+vTvrQ82oQDBhaKFIzvNksAM9ALniJHd4TQaoWn1jsohVzVGEOFDwtS2lggpIKAVce1MUxqnHWRfiKYcoHL0zmhJC01xVyKLBgAVH5Jyqi5FfAOee90m/dvMv/pkGVO1/OWjL5EV4a+EaYz+T/HteJx8OQ6eRtdmxuCo/YAUjDFviDqqPgEmVEvrcoahM1UBCN7BwAvjY0pDNuVpzE+fTtSwJJlvBznFfHbxfbKZM5XJAOGOMTcQJ3Kik6JAtH+wVqPwYO4kTxV/aEo5dWN8NlmpphS3U1Z7IfR7CQVgHMbNeOZp4QvRsyQ2CCaJizazcQqrlAdYPeVBVS4OA7gCfdR+F8mC7e/IaC/svqtGeFrdI32zfUFXlv5sXNRhRna2RBNN/g3wuLRGnWScwMdPh9WfVVtPOKyxjgpdth0EazQwe+UVmGThuetZvzm9qfh92C8T7tIWumxhpkkB4oBb9vf++Yj2XeI6G60LGzZFuXq52YLcVGFtNG8u2bQCtqtgYmpEkeMb0apSeTX2uRZEKKru5y7woMIM/VKGn4090Y4wwiMHUY1WVzoQkrHclebuWrXdQl//7bt/SXNiXNd+3T4I4yMW54+gD8DgDSvA52zEqVRIEM+T4VoPguIPEwxpOMs1ado1rgfjvVgTUgu6FolbrtRDeS7LaQuq7pDNfs8uX79tHtXia91gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(53546011)(5660300002)(66476007)(38100700002)(36756003)(6512007)(107886003)(87266011)(8936002)(71200400001)(2906002)(6506007)(4326008)(110136005)(38070700005)(508600001)(122000001)(86362001)(8676002)(186003)(33656002)(54906003)(82960400001)(26005)(85182001)(83380400001)(66946007)(91956017)(66556008)(76116006)(66446008)(316002)(64756008)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2V0NDJwckRZNlpOOFc1RXFFK0diTUVpSUVSaFFGMWpzTU42c2NmcUF3UWVt?=
 =?utf-8?B?dG5EOUVINmtyK1oxcXZ4Q2dZalQ1VVJBMUZmRm1MaTh6K28wVThyVnd2WDRu?=
 =?utf-8?B?QjFxR1ZyVlJWTGRpUy9mUy82MHAwRitQcllhcXBqcU9tWEJCY3J1Q1ZQSkFt?=
 =?utf-8?B?ejIwMHBJb1ZMYTB1TFphZGJQRC91cDVBbEVSV3R5Sktuc1RVZ2lWVDN6dlFQ?=
 =?utf-8?B?V0dqSFIweEJyL0pPdU5SY3ArOFNSQnRqR1FiczNsV0x1aHV2YWhvYlY2VkZR?=
 =?utf-8?B?VVYwRnhuVHI0WXcyNXFGenB0ZXZCZUgvem1vU1RFWnRIcVE5akFoNmVHOUgz?=
 =?utf-8?B?aERjR0orQWRSU3BCL0RBaEpoR24xNDFaOHhwZkRxdXM0TFFDYTM1clJ4Ym5B?=
 =?utf-8?B?RlRPSlg2NEl2RjhQNmpLZVpFWDlkWmpPaXBSYXVtYmt4UzFuWWNKdlJOanVL?=
 =?utf-8?B?c05kWGxsbzd6UXBQYzN5TkRnckRKVnlLZXFCZHV5cG5tVFVJY01zUFBsYjdI?=
 =?utf-8?B?S2VDV3lpRVREc3Q0V1V0QmV2Y1VoWXV5Wlpqalh2M3U2YTYxZ3BYdmFiSmJJ?=
 =?utf-8?B?OFFJQ21UYlNlQTZsaXR3YVl3MnZPZnpzbGNnTUozdDJVQVFEQ2lCdW1TUHlD?=
 =?utf-8?B?YTBrNlk2QnhhdDduTkMyQjlPNVV5anVDenNCeWdlR3ZoRmdteDNqZlEzem05?=
 =?utf-8?B?dGxBdFU4MXg0SFArYldXL0FCMW1lLzNJMGxLN0h2WEJ5Qm5RZHozS0I3NEN1?=
 =?utf-8?B?eFd2a3ZZT1ZzcTd1aGt5dE51b2ZTOW9JTGM0ZDZRWGVvTXNqeWhRT2o3cUtw?=
 =?utf-8?B?QWNRVEx4bVo0Tk9YNkQ2TkZVK0M2SmVoK1JkeHpIS0thK1RlbnFHTmVaUGNj?=
 =?utf-8?B?eXlIVGFxWUR2QnBYdUtzd3ZoMHZlN1NsYkJROWc0dGZ4QU5MOTZEckR5TmJX?=
 =?utf-8?B?ckdxZ1o5YXRON2dLdzlJOVZPSkNMNTRVek9mK3BJYnA1QXpoYU5GWUNKSXJv?=
 =?utf-8?B?ckJQaXkrL2NXNnphMnlsQTltZms5Sk5SUlh4Sm05aUZVUlUvTEpJcU16dzdr?=
 =?utf-8?B?S2h3M2lqaDBmL3plaTF5SnFoWmxZZVdGSi9Pb2NCOVNCZGlHT0hUUXFMTmJo?=
 =?utf-8?B?RjErdzByRFlkOE1WU2R4dWFMNk5OQ0E5bW93dHMrQ0o4YTlZYnN5dGJSeVQr?=
 =?utf-8?B?bjVBVzVyalJFM094OTVucG1KcVk0YkZ5eS9DaGhoWlpWbEh0MHkxZ0FNMUZ5?=
 =?utf-8?B?QzRNZkxnamRTUUF4OTNObGhTRUNWUlUvS3RhZnZBeldWMEpnWlVCWkNHTnI3?=
 =?utf-8?B?Wm1ORkEyQXNMZTRwRkcxS1ZMYkJOVCtZNTM1SGZjemN1dzduYWZWWlFxM2FG?=
 =?utf-8?B?SWlMUXNOS1JRSXdTRHlOcTlUV1JLdEhjZTBFMFhKc2pWSzJHdHhOSWN2NVBS?=
 =?utf-8?B?YjFTYnVpSjN4VUFQam1JYVBGbk45dGZMM0JSWUlncmNCcGFhMk9xeWJvOHlW?=
 =?utf-8?B?NGhCQTB0N0lkUkU3QzhrYk9WcVIvMUFQQkFzbHorZW95d21aY2g0cm4yd2RQ?=
 =?utf-8?B?WDRTTkJ4S0plSUVqNnFLU3FyWFVhcjladW0yT0tVM3lIQ2FBME11dTE1OE5p?=
 =?utf-8?B?VjlxUEsyM2VwblFtSWxNMlZKVUg1WGN5S0tOaDA3MzJOdkhWMWl3QXpTR253?=
 =?utf-8?B?T2hiL2M1UFlXdGdWUWZFZTRiTEY5aGoxUWdHeTEzWCtneFYzN1ZjYWN4clor?=
 =?utf-8?B?M29GdTZTblBCQ0FoMGFBd0UwRTRYcC8rM3lEMndHdGZsNGZVN3dkQXl0MldK?=
 =?utf-8?B?aXEzRmR4R2YvbUgzNVpXNzNFK2pHUEhBTVUwci8vTXUyN3M4THllVzRFZllV?=
 =?utf-8?B?MVFiTEx0SjdFZTlWb2JLUGk2eUJyQVM4eEZWRWlIVm1VRUh4L0FHV3NucERE?=
 =?utf-8?B?Ym5mTGZXT2lTWkY0RmMyWTZBQ0FrWDJWZjlwYUdObEcwaGRsdHpBRDMyekNH?=
 =?utf-8?B?cE1TVmZJRUx3K1FmUHZXcGxYcm9CeEROSXJBa3ZlUVJZbTIxYUFIcUlOQm4z?=
 =?utf-8?B?R1ZUV0svMXJxb2V1clQyZ3BDUW8rNmd4Y041UkhRQWFQaXdoT1J5bGdnRlZB?=
 =?utf-8?B?dlF4eTlJVXZ1SUZBVlVKZFVvTU5uai9xVjhBWkdpT3JqaXpITU1DdVphaGNZ?=
 =?utf-8?Q?zYpdoRebnKp2DvdFLav+wCc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55391B70BCB944EA2AF8DE65D2076FF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee880b5d-b49d-4596-3609-08d9cf64834b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 09:28:05.5278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qry2NKzlPyO323A6fr5ROwQ/7ArZr2WwA/aqUZ9rIQ1sfKSdsxj07GD1n4FoFpB5qph3lJswENvq3DJKqpELTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7000
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS8xMi8zMSAxNDozMCwgeWFuZ3guanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+IE9uIDIw
MjEvMTIvMzEgNTo0MiwgVG9tIFRhbHBleSB3cm90ZToNCj4+IE9uIDEyLzMwLzIwMjEgMjoyMSBQ
TSwgR3JvbWFkemtpLCBUb21hc3ogd3JvdGU6DQo+Pj4gMSkNCj4+Pj4gcmRtYV9wb3N0X2F0b21p
Y193cml0ZXYoc3RydWN0IHJkbWFfY21faWQgKmlkLCB2b2lkICpjb250ZXh0LCBzdHJ1Y3QNCj4+
Pj4gaWJ2X3NnZSAqc2dsLA0KPj4+PiAgICAgICAgICAgICAgaW50IG5zZ2UsIGludCBmbGFncywg
dWludDY0X3QgcmVtb3RlX2FkZHIsIHVpbnQzMl90IHJrZXkpDQo+Pj4gRG8gd2UgbmVlZCB0aGlz
IEFQSSBhdCBhbGw/DQo+Pj4gT3RoZXIgYXRvbWljIG9wZXJhdGlvbnMgKGNvbXBhcmVfc3dhcC9h
ZGQpIGRvIG5vdCB1c2Ugc3RydWN0IGlidl9zZ2UNCj4+PiBhdCBhbGwgYnV0IGhhdmUgYSBkZWRp
Y2F0ZWQgcGxhY2UgaW4NCj4+PiBzdHJ1Y3QgaWJfc2VuZF93ciB7DQo+Pj4gLi4uDQo+Pj4gICAg
ICAgICAgc3RydWN0IHsNCj4+PiAgICAgICAgICAgICAgdWludDY0X3QgICAgcmVtb3RlX2FkZHI7
DQo+Pj4gICAgICAgICAgICAgIHVpbnQ2NF90ICAgIGNvbXBhcmVfYWRkOw0KPj4+ICAgICAgICAg
ICAgICB1aW50NjRfdCAgICBzd2FwOw0KPj4+ICAgICAgICAgICAgICB1aW50MzJfdCAgICBya2V5
Ow0KPj4+ICAgICAgICAgIH0gYXRvbWljOw0KPj4+IC4uLg0KPj4+IH0NCj4+Pg0KPj4+IFdvdWxk
IGl0IGJlIGJldHRlciB0byByZXVzZSAoZXh0ZW5kKSBhbnkgZXhpc3RpbmcgZmllbGQ/DQo+Pj4g
aS5lLg0KPj4+ICAgICAgICAgIHN0cnVjdCB7DQo+Pj4gICAgICAgICAgICAgIHVpbnQ2NF90ICAg
IHJlbW90ZV9hZGRyOw0KPj4+ICAgICAgICAgICAgICB1aW50NjRfdCAgICBjb21wYXJlX2FkZDsN
Cj4+PiAgICAgICAgICAgICAgdWludDY0X3QgICAgc3dhcF93cml0ZTsNCj4+PiAgICAgICAgICAg
ICAgdWludDMyX3QgICAgcmtleTsNCj4+PiAgICAgICAgICB9IGF0b21pYzsNCj4+IEFncmVlZC4g
UGFzc2luZyB0aGUgZGF0YSB0byBiZSB3cml0dGVuIGFzIGFuIFNHRSBpcyB1bm5hdHVyYWwNCj4+
IHNpbmNlIGl0IGlzIGFsd2F5cyBleGFjdGx5IDY0IGJpdHMuIFR3ZWFraW5nIHRoZSBleGlzdGlu
ZyBhdG9taWMNCj4+IHBhcmFtZXRlciBibG9jayBhcyBUb21hc3ogc3VnZ2VzdHMgaXMgdGhlIGJl
c3QgYXBwcm9hY2guDQo+IEhpIFRvbWFzeiwgVG9tDQo+DQo+IFRoYW5rcyBmb3IgeW91ciBxdWlj
ayByZXBseS4NCj4NCj4gSWYgd2Ugd2FudCB0byBwYXNzIHRoZSA4LWJ5dGUgdmFsdWUgYnkgdHdl
YWtpbmcgc3RydWN0IGF0b21pYyBvbiB1c2VyDQo+IHNwYWNlLCB3aHkgZG9uJ3Qgd2UNCj4gdHJh
bmZlciB0aGUgOC1ieXRlIHZhbHVlIGJ5IEFUT01JQyBFeHRlbmRlZCBUcmFuc3BvcnQgSGVhZGVy
IChBdG9taWNFVEgpDQo+IG9uIGtlcm5lbCBzcGFjZT8NCj4gUFM6IElCVEEgZGVmaW5lcyB0aGF0
IHRoZSA4LWJ5dGUgdmFsdWUgaXMgdHJhbmZlcmVkIGJ5IFJETUEgRXh0ZW5kZWQNCj4gVHJhbnNw
b3J0IEhlYWRlKFJFVEgpICsgcGF5bG9hZC4NCj4NCj4gSXMgaXQgaW5jb25zaXN0ZW50IHRvIHVz
ZSBzdHJ1Y3QgYXRvbWljIG9uIHVzZXIgc3BhY2UgYW5kIFJFVEggKyBwYXlsb2FkDQo+IG9uIGtl
cm5lbCBzcGFjZT8NCkhpIFRvbWFzeiwgVG9tDQoNCkkgdGhpbmsgdGhlIGZvbGxvd2luZyBydWxl
cyBhcmUgcmlnaHQ6DQpSRE1BIFJFQUQvV1JJVEUgc2hvdWxkIHVzZSBzdHJ1Y3QgcmRtYSBpbiBs
aWJ2ZXJicyBhbmQgUkVUSCArIHBheWxvYWQgaW4gDQprZXJuZWwuDQpSRE1BIEF0b21pYyBzaG91
bGQgdXNlIHN0cnVjdCBhdG9taWMgaW4gbGlidmVyYnMgYW5kIEF0b21pY0VUSCBpbiBrZXJuZWwu
DQoNCkFjY29yZGluZyB0byBJQlRBJ3MgZGVmaW5pdGlvbiwgUkRNQSBBdG9taWMgV3JpdGUgc2hv
dWxkIHVzZSBzdHJ1Y3QgcmRtYSANCmluIGxpYmlidmVyYnMuDQpIb3cgYWJvdXQgYWRkaW5nIGEg
bWVtYmVyIGluIHN0cnVjdCByZG1hPyBmb3IgZXhhbXBsZToNCnN0cnVjdCB7DQogICAgIHVpbnQ2
NF90ICAgIHJlbW90ZV9hZGRyOw0KICAgICB1aW50MzJfdCAgICBya2V5Ow0KICAgICB1aW50NjRf
dCAgICB3cl92YWx1ZToNCn0gcmRtYTsNCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IEJl
c3QgUmVnYXJkcywNCj4gWGlhbyBZYW5nDQo+PiBUb20uDQo=
