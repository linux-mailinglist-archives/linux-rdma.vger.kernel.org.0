Return-Path: <linux-rdma+bounces-908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12057849621
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 10:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AF31C21213
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643911CBD;
	Mon,  5 Feb 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SYAlOLjD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2111.outbound.protection.outlook.com [40.107.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA23125A1;
	Mon,  5 Feb 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124526; cv=fail; b=F4Yi1vEtRivgSuOaibQzFwvNXNEU6493p6PmVhopsKxbMJGbM1wX9gDWqv+jD6rXu9apB/sh6qW0cPElNCMdmwlJ+XY7sh2B6IOl53SKP7k40zhQaTEgRGuEb4vGuR/7juvkn9pFuYFegnxKKyBrAGlgL6al2NMlGQogVkPrRMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124526; c=relaxed/simple;
	bh=nEXqz9rGmaOrAAD1jugn8lJwv3BqZQatV9J6WnAlCyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OeqPHZHYkUZ9sm/8IDHgN0lZnv2BPt0ny+y+cVa5gfB2KesnBELIqBToM9H4rsWyn3glye5j2noq2OMERyDtJ9DTnwSPO/qq2iznvD+FE2/n9vgWcdrJCTvt1Ic+C5wapCTZVKKiZAZtYWP1Uw6wnQ+1J3UzYawG/U+KNiWaMpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SYAlOLjD; arc=fail smtp.client-ip=40.107.8.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/CORF0ua4LQdKWCthF4bQjjR6b+ZestzEQuhyxy1xGpWrMOFKtAM3GmaG15i8ZAxouMr4w0oKjPoHXpLn5TyJTsoJC+dSel91d8xbLwcrM0y4jnw1bEGFpIDrB9NSMkj42RsTA5hS35M+pynozVl1VvHZ155Cl+hHiBLgU6rRDMop9Bs2rUZOvnuV92EXlGhogw9ppt8JtYc/RFg5+qzG+NPN7rDJ4XI2QXjIPKmK316N+wczA6x/Mg57AtRUYzldmRXqOtuaJinEk8xYSrgltNGxYx1ddjTGfJAd77BNxrfPUl8DNSpeCrBxkSyuU95lnOB8+7oqFcIBuveil/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEXqz9rGmaOrAAD1jugn8lJwv3BqZQatV9J6WnAlCyo=;
 b=Vqir/5wosB6L7KGUSsNyIIUJQmgq9kQchwM9KZhmvLokLJcReDToWdKPzbimwLnUW0uA6bxllU0pQudjjUi7PKK3KlwQ0jv/1kB8bYtUXwoVHyR+fSC3RZXkqNnSHVVD6mw3OghxWoo068BfkvCzX4NFGMqfYZgh6dIPh6ZM6JXvM4k09q0SW/4fhuZe9vXbyLLxYHDCl9vHP4m+pnRkk4iFx9G8cnmCE/CATX/iNUfMh+K4ymP0xxuleTVpGWpqgQdIQYwxZL0fQIcEEvm7YLZLfUC65Z+sfg6Y4NmPVEqD0uLaW8nMv536LdIfHCV2XCnzQ5tF2OmP8voFNVmFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEXqz9rGmaOrAAD1jugn8lJwv3BqZQatV9J6WnAlCyo=;
 b=SYAlOLjDz9f+XID2usotSnKDNie6W9PDoJ9oMcCCMcKvp5JxxNvRSkggchJRNe5HfETgE6eUuzWo0yI0v+aDMUyfKYNEPi8StXzN38ExmEZG5uOkIKvINwgxM4ytcWD5zcAXjmfzxn2Bha8xcl3IopHvMRFJ+a4Ezkde1xRqc6Y=
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com (2603:10a6:10:322::19)
 by GVXPR83MB0583.EURPRD83.prod.outlook.com (2603:10a6:150:154::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.4; Mon, 5 Feb
 2024 09:15:19 +0000
Received: from DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d]) by DU0PR83MB0553.EURPRD83.prod.outlook.com
 ([fe80::a8db:9564:bfb1:181d%4]) with mapi id 15.20.7292.001; Mon, 5 Feb 2024
 09:15:19 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v2 2/5] RDMA/mana_ib: Create and
 destroy rnic adapter
Thread-Index:
 AQHaVelzQoHpJTBxI0CA3jYtbVkPuLD6H/mAgAA1LyCAABPsAIAABMBwgAD3XACAABKq4A==
Date: Mon, 5 Feb 2024 09:15:19 +0000
Message-ID:
 <DU0PR83MB05531986447918EBD42EE9A8B4472@DU0PR83MB0553.EURPRD83.prod.outlook.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
 <1706886397-16600-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240204123013.GE5400@unreal>
 <DU0PR83MB0553DF0BA184971EDD66DB0EB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240204165152.GH5400@unreal>
 <DU0PR83MB05536AACA6D1E980AD91BD8DB4402@DU0PR83MB0553.EURPRD83.prod.outlook.com>
 <20240205075412.GA6294@unreal>
In-Reply-To: <20240205075412.GA6294@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89f7dc95-6eba-492e-b445-3a941e35c3e0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-05T09:01:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR83MB0553:EE_|GVXPR83MB0583:EE_
x-ms-office365-filtering-correlation-id: 511bba24-7df7-4be1-12a8-08dc262af960
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z9nnvRy1INF6qrrwnDmeFTIxXbdEgMes6YtpCK26TfbQEsai9lzv9yvXEToyOgYipg/kfGsMWCHIQp/4+Ip/QcFWUhAenZA+NrtLVbqNdiToiUP5ryNObforqiD9zi+k/o8jNCbKCqnCm+xiJnvENUsNYLdjseP9qoLsenQNq2pj4G0HtS2arPB6+ezBgc+fbidzOsrzspdDkk2P9z7+hAjsX8TMEKcG9M/s2NQDscOBhnC6Giw/rzV0n563TTh1OR6IXM3T11dukAI6Raa53w14bIeK0gttoFJgBpm7imGnC/xfg4LieAqoiNwf8tlwp+jQ93ihV4FDdNzeAdJdo5A6n7kl2AbrR2kVdDPgBgiJBYJVMH/cuBTea5SjFIT4PdrPASOGSzBkYAXcDL7m+f3Zd3b5nsPbJMqv1DhBOGwQChhnGkHxYFmcJUW3hFFkklSrTL09EY7+25dba8Z72pe0GnQrnDIGk91t5elYbUpSOgNuWoj8u/e8YK8e/cVL2GJtuxKBjVSJAY1QZOykM1lFq+ywCNw1sIoJHRMHTRGy45IpoZDK8jqth4D9yJ0WRsoTScOLWZ8gG99tt9G9iE4UktDP1Hp6VTkN+jBntIocGOecEWZQ69RH3+xzEcvL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR83MB0553.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(55016003)(2906002)(41300700001)(5660300002)(83380400001)(122000001)(26005)(86362001)(9686003)(8990500004)(7696005)(6506007)(54906003)(6916009)(478600001)(64756008)(66446008)(38070700009)(10290500003)(33656002)(71200400001)(316002)(82950400001)(82960400001)(38100700002)(66476007)(66556008)(52536014)(4326008)(8676002)(8936002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjFwUEZYa0w0Yk5mQ1lyeTlhQWJqYnBhVHozMnVTY2Y3RmNZRVAxclJMb0hX?=
 =?utf-8?B?am5NN1JSbzFQUVlTSk9XQldlSE1KSzZJbkM4eGZwbTR0NDZQZExrS1lXUUg1?=
 =?utf-8?B?Nno3cjNiR2ZmR0ZwZkIrVStBUXZoWU9oY1dNNE1EcUs3cHlsQ0llaXU5c3RX?=
 =?utf-8?B?dG15cC8zY0k4WjZac0RxV0lrUng0WmpUOTg1aW9vZUtIdVU2MGZjOUVkL0k0?=
 =?utf-8?B?TzBQVEgwbStqL3U3UVBWem1xcmhvQitGbWFmdVIrTDNpSkQvTjZGN3EwdllM?=
 =?utf-8?B?MWdPZTRsem1SUFJhT0VVZkN3TnFPM21zd2dLZzdPTUcwV0Ivd2xWd2pTdVJp?=
 =?utf-8?B?b2JXWGtsVVQ2ZlB2M0s4bXNvYmx6MTlYK3RMbGpWcTNSZGE5UTd3OEFHMmsx?=
 =?utf-8?B?akZTMGRNaVkrSUttZmMzSnRKeHlEdFNlUXZDNlVLZGxmV1Jtd3pXdTVhOHNT?=
 =?utf-8?B?dnIyRmxpcjl2aVYwMjNjU3ZXM014Q1VYRmw1bERPMUNsZ1hwWm1hZkdDYm9U?=
 =?utf-8?B?b0NhY1JiMUlDM29QazJ0T1BIMXpFRndjMFJFNEhlWCtMTXJ6Z2xxUmp4Vi9B?=
 =?utf-8?B?K2JIdlBqVzlxaldoVUZlZmxkWTBRY3BMRzN0d3cySzA0OElwYVpvS0xteDJl?=
 =?utf-8?B?cytNcm9qMFMyenk2NXhBQ0pVSVlIZVJiYkpQcmY2UkE0Zm9HRWNWeGxGdGhB?=
 =?utf-8?B?WUgrUnVxSCswTzM0c1FtMmFYRVBjV0RCOWVIUzczRElFYjBKVm5ib1oyNHNQ?=
 =?utf-8?B?VHFUdEVLUCtYcjM0cG5TUjRVU0tTbnJCQlZaekYwSUN3dkpPS0JFZHIwWDFF?=
 =?utf-8?B?SVJsSGJCajd1RWF5c0VpN01oTW51V29yVjdJaDkrVG1SYVlqeWthSHdFODln?=
 =?utf-8?B?Y2svVGt2RUVtV0g3NEdKUUV3MVIwT2JMUldNMHgxWmFvdHZFVzU4RE0wQ2Ux?=
 =?utf-8?B?YW0rVWloYlZYUlljMERveDNWMXprYTN4SDNlTmdNSy9Pc3cyNXJ1Z21saUlN?=
 =?utf-8?B?YUdsOUZ4UVVVQUxVZ3lza3NYazFTdXFoV0phaGFvUVdHV1B2QjZGMWVXN2ZT?=
 =?utf-8?B?aTl6S0xZVE1UVndoRE1FakdtV1djOHB6bnBXa1M2MkU0QU5Yc1FxSmdQNkFI?=
 =?utf-8?B?bmVnRkx1N0w1NXNzRU5RWk1YM2pTUU42R1lYS0xWaFdHZFFRRVBWRFNEbjIv?=
 =?utf-8?B?OEdHd1F2b2pkOFJOS0FCd1hLOWlhMWpGQTRtMTdaSEV5SzhId0Z6MThvZE5y?=
 =?utf-8?B?cndTUkdUQmYvVmlwYlQ3UnpaMUNtaGFKY1dMZW5jMXZTRE5LWGVibTRrQ2Q0?=
 =?utf-8?B?S0Q2RXJiZUNFQ0IwVEt6THd1aXg5VTE1R01zU291T2FoeU5JYS96akZpcE1q?=
 =?utf-8?B?bUlJV3hneVJzalI4TDQ2ajFaTFhHcVF6TWd3ZkVHaHdtdFJFazlGMXRIa2ti?=
 =?utf-8?B?UmptamUvNHpjNkZkVTR0NzA2V0Z2bmx6dkZ2aU1YOEJpcmUwcG5wZ2srTkpY?=
 =?utf-8?B?bzYxWkZKcVU4WkFjVWNJZEJOanZvam1ZSXZpQk9vdTNnb3h6eDI3TDZZY3Q1?=
 =?utf-8?B?R3IvbWcrK0NWdkNySzRjbWFLVVpFVGpqWXVSdUQ4cXczYlBuNThqcURSWkUr?=
 =?utf-8?B?bVM5NHNJVGRMWWY0alFoZjVNNktQUzJnTlZOYVQyYVBoQlNjQytZTnlDajI0?=
 =?utf-8?B?Q0ppRmRmQm1MQnlhN0V2UFRsUHpsMXBNQzRNRHpXOHJ5aFBkLzFDRXMzYW81?=
 =?utf-8?B?WUNLTnU3aWIvNUdXWVFpL2RQQUl3QVZyUk1sYUlwa3BYMXhWM1Fhd1Z3RmQv?=
 =?utf-8?B?c3lVRkc2bXdBMGQzOVAwNmszekZCenhHeGFxNytyMlNlZlhFRlFKYy9DWVR5?=
 =?utf-8?B?T2hZK1ViU3BCSy9IYkxueW5qcTVLcUE2NTZlellpTlhoUWk0NkJvdERxOUpF?=
 =?utf-8?B?dkVDQzNDZDJ2UVV1R2s5WEhvL0U0NG81NXpVUEVvQmx4UVdlZTQ0ZndXNDBp?=
 =?utf-8?B?NlBnNFpSd29VT2x1QWxwQWRta0ZjQ3hQVzduWGZneHFYbG9IL0UwQ0FobXgy?=
 =?utf-8?Q?N7oom1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR83MB0553.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511bba24-7df7-4be1-12a8-08dc262af960
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 09:15:19.3725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stQb1St6SZciLAn8esv+hUtbIH3x0OPUcdhHmvS3cc/JbS8G3c1nASvDtv8bTjNqvcETpB1eB8XI2U1FK3ewMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0583

PiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gT24gU3VuLCBGZWIg
MDQsIDIwMjQgYXQgMDU6MTc6NTlQTSArMDAwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0K
PiA+ID4gRnJvbTogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IE9uIFN1biwgRmVi
IDA0LCAyMDI0IGF0DQo+ID4gPiAwMzo1MDo0MFBNICswMDAwLCBLb25zdGFudGluIFRhcmFub3Yg
d3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+
IE9uIEZyaSwgRmViIDAyLCAyMDI0IGF0DQo+ID4gPiA+ID4gMDc6MDY6MzRBTSAtMDgwMCwgS29u
c3RhbnRpbiBUYXJhbm92IHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIFJOSUMg
Y3JlYXRpb24gYW5kIGRlc3RydWN0aW9uLg0KPiA+ID4gPiA+ID4gSWYgY3JlYXRpb24gb2YgUk5J
QyBmYWlscywgd2Ugc3VwcG9ydCBvbmx5IFJBVyBRUHMgYXMgdGhleSBhcmUNCj4gPiA+ID4gPiA+
IHNlcnZlZCBieSBldGhlcm5ldCBkcml2ZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTbyBwbGVh
c2UgbWFrZSBzdXJlIHRoYXQgeW91IGFyZSBjcmVhdGluZyBSTklDIG9ubHkgd2hlbiB5b3UgYXJl
DQo+ID4gPiA+ID4gc3VwcG9ydGluZyBpdC4gVGhlIGlkZWEgdGhhdCBzb21lIGZ1bmN0aW9uIHRy
aWVzLWFuZC1mYWlscyB3aXRoDQo+ID4gPiA+ID4gZG1lc2cgZXJyb3JzIGlzIG5vdCBnb29kIGlk
ZWEuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+
ID4gPiBIaSBMZW9uLiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIHN1Z2dlc3Rpb24uIEkg
d2lsbA0KPiA+ID4gPiBpbmNvcnBvcmF0ZSB0aGVtDQo+ID4gPiBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KPiA+ID4gPiBSZWdhcmRpbmcgdGhpcyAidHJ5LWFuZC1mYWlsIiwgd2UgY2Fubm90IGd1YXJh
bnRlZSBub3cgdGhhdCBSTklDDQo+ID4gPiA+IGlzIHN1cHBvcnRlZCwgYW5kIHRyeS1hbmQtZmFp
bCBpcyB0aGUgb25seSB3YXkgdG8gc2tpcCBSTklDDQo+ID4gPiA+IGNyZWF0aW9uIHdpdGhvdXQg
aW1wZWRpbmcgUkFXIFFQcy4gQ291bGQgeW91LCBwbGVhc2UsIHN1Z2dlc3QgaG93DQo+ID4gPiA+
IHdlIGNvdWxkDQo+ID4gPiBjb3JyZWN0bHkgaW5jb3Jwb3JhdGUgdGhlICJ0cnktYW5kLWZhaWwi
IHN0cmF0ZWd5IHRvIGdldCBpdCB1cHN0cmVhbWVkPw0KPiA+ID4NCj4gPiA+IFlvdSBhbHJlYWR5
IHF1ZXJ5IE5JQyBmb3IgaXRzIGNhcGFiaWxpdGllcywgc28geW91IGNhbiBjaGVjayBpZiBpdCBz
dXBwb3J0cw0KPiBSTklDLg0KPiA+DQo+ID4gQXQgdGhlIG1vbWVudCwgdGhlIGNhcGFiaWxpdGll
cyBkbyBub3QgaW5kaWNhdGUgd2hldGhlciBSTklDIGNyZWF0aW9uIHdpbGwNCj4gYmUgc3VjY2Vz
c2Z1bC4NCj4gPiBUaGUgcmVhc29uIGlzIGFkZGl0aW9uYWwgY2hlY2tzIGR1cmluZyBSTklDIGNy
ZWF0aW9uIHRoYXQgYXJlIG5vdCByZWZsZWN0ZWQNCj4gaW4gY2FwYWJpbGl0aWVzLg0KPiA+IFRo
ZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHdlIGNhbiBoYXZlIHRoZSBwcm9wb3NlZCAidHJ5IGFuZCBk
aXNhYmxlIiBvciB3ZQ0KPiBtdXN0IG9wdCBmb3IgZmFpbGluZyB0aGUgd2hvbGUgbWFuYV9pYi4N
Cj4gDQo+IFJOSUMgY3JlYXRpb24gY2FuIGJlIHNlZW4gYXMgYW4gZXhhbXBsZSBvZiBhbnkgb3Ro
ZXIgZmVhdHVyZSB3aGljaCB3aWxsIGJlDQo+IGFkZGVkIGxhdGVyLCB5b3Ugd2lsbCBuZXZlciBr
bm93IGlmIGl0IHdpbGwgYmUgc3VjY2Vzc2Z1bCBvciBub3Qgd2l0aG91dA0KPiBjYXBhYmlsaXRp
ZXMuDQo+IA0KPiBJZiB5b3UgY29udGludWUgd2l0aCB0aGlzIHRyeS1hbmQtZmFpbCBhcHByb2Fj
aCwgSSBhZnJhaWQgdGhhdCB5b3Ugd2lsbCBlbmQgdXANCj4gd2l0aCB3aG9sZSBkcml2ZXIgd3Jp
dHRlbiBpbiB0aGlzIHN0eWxlLiBTdHlsZSB3aGVyZSB5b3UgZG9uJ3Qgc2VwYXJhdGUNCj4gYmV0
d2VlbiAicmVhbCIgZmFpbHVyZXMgKHdyb25nIGNvbmZpZ3VyYXRpb24sIE9PTSBlLnQuYykgYW5k
ICJleHBlY3RlZCINCj4gZmFpbHVyZXMgKGZlYXR1cmUgaXMgbm90IHN1cHBvcnRlZCkuDQo+IA0K
DQpIaSBMZW9uLiBJIHVuZGVyc3RhbmQgeW91ciBjb25jZXJucyBhbmQgSSBzZWUgaG93IHRyeS1h
bmQtZmFpbCBhcHByb2FjaCBjYW4gZ28gd3JvbmcuDQpJIHRoaW5rIHlvdSBtaXN1bmRlcnN0b29k
IHRoZSBjdXJyZW50IEhXIGxpbWl0YXRpb24gd2UgaGF2ZS4gV2UgKmRvKiBkaXN0aW5ndWlzaCBi
ZXR3ZWVuIA0KZmFpbHVyZXMgYW5kIHRoaXMgIiB0cnktYW5kLWZhaWwgIiB3aWxsIGJlIHVzZWQg
b25jZSBkdXJpbmcgaW5pdGlhbGl6YXRpb24uIEFzIEkgbWVudGlvbmVkIGFib3ZlLA0Kb3VyIGN1
cnJlbnQgSFcgY2FwYWJpbGl0aWVzIGNhbm5vdCByZWZsZWN0IHdoZXRoZXIgUk5JQyBpcyBzdXBw
b3J0ZWQuIFRoZXJlZm9yZSwgd2UgbXVzdCB0cnkNCnRvIGNyZWF0ZSBpdCB0byB1bmRlcnN0YW5k
IHdoZXRoZXIgaXQgaXMgcmVhbGx5IHN1cHBvcnRlZC4gU28sIGlmIHdlIHN1Y2NlZWQgdGhlbiB0
aGUgUk5JQyBmZWF0dXJlDQppcyBzdXBwb3J0ZWQgYW5kIGFsbCBSTklDLXJlbGF0ZWQgb3BlcmF0
aW9ucyB3aWxsIHdvcmsuIE90aGVyd2lzZSwgUk5JQyBjYXBhYmlsaXR5IGlzIG5vdCBwcmVzZW50
DQphbmQgaW4gdGhpcyBjYXNlLCB3ZSBqdXN0IHdhbnRlZCB0byB3YXJuIHRoZSB1c2VyIGFib3V0
IGl0LiBJZiBpdCBjb25jZXJucyB5b3UsIEkgY2FuIHJlbW92ZSB0aGlzIHdhcm4gbWVzc2FnZS4g
DQoNCkdpdmVuIHRoZSBwcm92aWRlZCBleHBsYW5hdGlvbiwgSSB3b3VsZCBhcHByZWNpYXRlIGlm
IHlvdSB3cm90ZSB3aGV0aGVyIHRoaXMgYXBwcm9hY2ggb2YgcXVlcnlpbmcgUk5JQyBzdXBwb3J0
DQpjb3VsZCBiZSBhY2NlcHRlZC4gDQoNClRoYW5rcyENCg0KPiBUaGFua3MNCj4gDQo+ID4NCj4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS29u
c3RhbnRpbiBUYXJhbm92DQo+ID4gPiA+ID4gPiA8a290YXJhbm92QGxpbnV4Lm1pY3Jvc29mdC5j
b20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcv
bWFuYS9tYWluLmMgICAgfCAzMQ0KPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiA+ID4gPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmgg
fCAyOQ0KPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+
ID4gPiA+ID4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+ID4gPiA+
ID4gaW5kZXggYzY0ZDU2OS4uMzNjZDY5ZSAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9p
bmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gPiA+ID4gPiBAQCAtNTgxLDE0ICs1ODEsMzEg
QEAgc3RhdGljIHZvaWQgbWFuYV9pYl9kZXN0cm95X2VxcyhzdHJ1Y3QNCj4gPiA+ID4gPiA+IG1h
bmFfaWJfZGV2ICptZGV2KQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICB2b2lkIG1hbmFfaWJf
Z2RfY3JlYXRlX3JuaWNfYWRhcHRlcihzdHJ1Y3QgbWFuYV9pYl9kZXYgKm1kZXYpDQo+ID4gPiA+
ID4gPiB7DQo+ID4gPiA+ID4gPiArICAgICBzdHJ1Y3QgbWFuYV9ybmljX2NyZWF0ZV9hZGFwdGVy
X3Jlc3AgcmVzcCA9IHt9Ow0KPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IG1hbmFfcm5pY19jcmVh
dGVfYWRhcHRlcl9yZXEgcmVxID0ge307DQo+ID4gPiA+ID4gPiArICAgICBzdHJ1Y3QgZ2RtYV9j
b250ZXh0ICpnYyA9IG1kZXZfdG9fZ2MobWRldik7DQo+ID4gPiA+ID4gPiAgICAgICBpbnQgZXJy
Ow0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICsgICAgIG1kZXYtPmFkYXB0ZXJfaGFuZGxlID0g
SU5WQUxJRF9NQU5BX0hBTkRMRTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgICAgIGVy
ciA9IG1hbmFfaWJfY3JlYXRlX2VxcyhtZGV2KTsNCj4gPiA+ID4gPiA+ICAgICAgIGlmIChlcnIp
IHsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgaWJkZXZfZXJyKCZtZGV2LT5pYl9kZXYsICJG
YWlsZWQgdG8gY3JlYXRlIEVRcw0KPiA+ID4gPiA+ID4gZm9yIFJOSUMgZXJyICVkIiwNCj4gPiA+
ID4gPiBlcnIpOw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBnb3RvIGNsZWFudXA7DQo+ID4g
PiA+ID4gPiAgICAgICB9DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gKyAgICAgbWFuYV9nZF9p
bml0X3JlcV9oZHIoJnJlcS5oZHIsIE1BTkFfSUJfQ1JFQVRFX0FEQVBURVIsDQo+ID4gPiA+ID4g
c2l6ZW9mKHJlcSksIHNpemVvZihyZXNwKSk7DQo+ID4gPiA+ID4gPiArICAgICByZXEuaGRyLnJl
cS5tc2dfdmVyc2lvbiA9IEdETUFfTUVTU0FHRV9WMjsNCj4gPiA+ID4gPiA+ICsgICAgIHJlcS5o
ZHIuZGV2X2lkID0gZ2MtPm1hbmFfaWIuZGV2X2lkOw0KPiA+ID4gPiA+ID4gKyAgICAgcmVxLm5v
dGlmeV9lcV9pZCA9IG1kZXYtPmZhdGFsX2Vycl9lcS0+aWQ7DQo+ID4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gPiArICAgICBlcnIgPSBtYW5hX2dkX3NlbmRfcmVxdWVzdChnYywgc2l6ZW9mKHJlcSks
ICZyZXEsDQo+ID4gPiA+ID4gPiArIHNpemVvZihyZXNwKSwNCj4gPiA+ICZyZXNwKTsNCj4gPiA+
ID4gPiA+ICsgICAgIGlmIChlcnIpIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgaWJkZXZf
ZXJyKCZtZGV2LT5pYl9kZXYsICJGYWlsZWQgdG8gY3JlYXRlIFJOSUMNCj4gPiA+ID4gPiA+ICsg
YWRhcHRlciBlcnIgJWQiLA0KPiA+ID4gPiA+IGVycik7DQo+ID4gPiA+ID4gPiArICAgICAgICAg
ICAgIGdvdG8gY2xlYW51cDsNCj4gPiA+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gPiA+ICsgICAg
IG1kZXYtPmFkYXB0ZXJfaGFuZGxlID0gcmVzcC5hZGFwdGVyOw0KPiA+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ID4gICAgICAgcmV0dXJuOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICBjbGVhbnVw
Og0KPiA+ID4gPiA+ID4gQEAgLTU5OSw1ICs2MTYsMTkgQEAgdm9pZA0KPiA+ID4gPiA+ID4gbWFu
YV9pYl9nZF9jcmVhdGVfcm5pY19hZGFwdGVyKHN0cnVjdA0KPiA+ID4gPiA+ID4gbWFuYV9pYl9k
ZXYgKm1kZXYpDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIHZvaWQgbWFuYV9pYl9nZF9kZXN0
cm95X3JuaWNfYWRhcHRlcihzdHJ1Y3QgbWFuYV9pYl9kZXYNCj4gPiA+ID4gPiA+ICptZGV2KSAg
ew0KPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IG1hbmFfcm5pY19kZXN0cm95X2FkYXB0ZXJfcmVz
cCByZXNwID0ge307DQo+ID4gPiA+ID4gPiArICAgICBzdHJ1Y3QgbWFuYV9ybmljX2Rlc3Ryb3lf
YWRhcHRlcl9yZXEgcmVxID0ge307DQo+ID4gPiA+ID4gPiArICAgICBzdHJ1Y3QgZ2RtYV9jb250
ZXh0ICpnYzsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAgIGlmICghcm5pY19pc19l
bmFibGVkKG1kZXYpKQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICByZXR1cm47DQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICBnYyA9IG1kZXZfdG9fZ2MobWRldik7DQo+ID4gPiA+
ID4gPiArICAgICBtYW5hX2dkX2luaXRfcmVxX2hkcigmcmVxLmhkciwNCj4gTUFOQV9JQl9ERVNU
Uk9ZX0FEQVBURVIsDQo+ID4gPiA+ID4gc2l6ZW9mKHJlcSksIHNpemVvZihyZXNwKSk7DQo+ID4g
PiA+ID4gPiArICAgICByZXEuaGRyLmRldl9pZCA9IGdjLT5tYW5hX2liLmRldl9pZDsNCj4gPiA+
ID4gPiA+ICsgICAgIHJlcS5hZGFwdGVyID0gbWRldi0+YWRhcHRlcl9oYW5kbGU7DQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICBtYW5hX2dkX3NlbmRfcmVxdWVzdChnYywgc2l6ZW9m
KHJlcSksICZyZXEsIHNpemVvZihyZXNwKSwNCj4gJnJlc3ApOw0KPiA+ID4gPiA+ID4gKyAgICAg
bWRldi0+YWRhcHRlcl9oYW5kbGUgPSBJTlZBTElEX01BTkFfSEFORExFOw0KPiA+ID4gPiA+ID4g
ICAgICAgbWFuYV9pYl9kZXN0cm95X2VxcyhtZGV2KTsgIH0gZGlmZiAtLWdpdA0KPiA+ID4gPiA+
ID4gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmgNCj4gPiA+ID4gPiA+IGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFuYV9pYi5oDQo+ID4gPiA+ID4gPiBpbmRleCBh
NGI5NGVlLi45NjQ1NGNmIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL2h3L21hbmEvbWFuYV9pYi5oDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvaHcvbWFuYS9tYW5hX2liLmgNCj4gPiA+ID4gPiA+IEBAIC00OCw2ICs0OCw3IEBAIHN0cnVj
dCBtYW5hX2liX2FkYXB0ZXJfY2FwcyB7ICBzdHJ1Y3QNCj4gPiA+IG1hbmFfaWJfZGV2IHsNCj4g
PiA+ID4gPiA+ICAgICAgIHN0cnVjdCBpYl9kZXZpY2UgaWJfZGV2Ow0KPiA+ID4gPiA+ID4gICAg
ICAgc3RydWN0IGdkbWFfZGV2ICpnZG1hX2RldjsNCj4gPiA+ID4gPiA+ICsgICAgIG1hbmFfaGFu
ZGxlX3QgYWRhcHRlcl9oYW5kbGU7DQo+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3QgZ2RtYV9xdWV1
ZSAqZmF0YWxfZXJyX2VxOw0KPiA+ID4gPiA+ID4gICAgICAgc3RydWN0IG1hbmFfaWJfYWRhcHRl
cl9jYXBzIGFkYXB0ZXJfY2FwczsgIH07IEBAIC0xMTUsNg0KPiA+ID4gPiA+ID4gKzExNiw4IEBA
IHN0cnVjdCBtYW5hX2liX3J3cV9pbmRfdGFibGUgew0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ICBlbnVtIG1hbmFfaWJfY29tbWFuZF9jb2RlIHsNCj4gPiA+ID4gPiA+ICAgICAgIE1BTkFfSUJf
R0VUX0FEQVBURVJfQ0FQID0gMHgzMDAwMSwNCj4gPiA+ID4gPiA+ICsgICAgIE1BTkFfSUJfQ1JF
QVRFX0FEQVBURVIgID0gMHgzMDAwMiwNCj4gPiA+ID4gPiA+ICsgICAgIE1BTkFfSUJfREVTVFJP
WV9BREFQVEVSID0gMHgzMDAwMywNCj4gPiA+ID4gPiA+ICB9Ow0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ICBzdHJ1Y3QgbWFuYV9pYl9xdWVyeV9hZGFwdGVyX2NhcHNfcmVxIHsgQEAgLTE0Myw2
ICsxNDYsMzIgQEANCj4gPiA+ID4gPiA+IHN0cnVjdCBtYW5hX2liX3F1ZXJ5X2FkYXB0ZXJfY2Fw
c19yZXNwIHsNCj4gPiA+ID4gPiA+ICAgICAgIHUzMiBtYXhfaW5saW5lX2RhdGFfc2l6ZTsgIH07
IC8qIEhXIERhdGEgKi8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArc3RydWN0IG1hbmFfcm5p
Y19jcmVhdGVfYWRhcHRlcl9yZXEgew0KPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IGdkbWFfcmVx
X2hkciBoZHI7DQo+ID4gPiA+ID4gPiArICAgICB1MzIgbm90aWZ5X2VxX2lkOw0KPiA+ID4gPiA+
ID4gKyAgICAgdTMyIHJlc2VydmVkOw0KPiA+ID4gPiA+ID4gKyAgICAgdTY0IGZlYXR1cmVfZmxh
Z3M7DQo+ID4gPiA+ID4gPiArfTsgLypIVyBEYXRhICovDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+
ID4gPiArc3RydWN0IG1hbmFfcm5pY19jcmVhdGVfYWRhcHRlcl9yZXNwIHsNCj4gPiA+ID4gPiA+
ICsgICAgIHN0cnVjdCBnZG1hX3Jlc3BfaGRyIGhkcjsNCj4gPiA+ID4gPiA+ICsgICAgIG1hbmFf
aGFuZGxlX3QgYWRhcHRlcjsNCj4gPiA+ID4gPiA+ICt9OyAvKiBIVyBEYXRhICovDQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArc3RydWN0IG1hbmFfcm5pY19kZXN0cm95X2FkYXB0ZXJfcmVx
IHsNCj4gPiA+ID4gPiA+ICsgICAgIHN0cnVjdCBnZG1hX3JlcV9oZHIgaGRyOw0KPiA+ID4gPiA+
ID4gKyAgICAgbWFuYV9oYW5kbGVfdCBhZGFwdGVyOw0KPiA+ID4gPiA+ID4gK307IC8qSFcgRGF0
YSAqLw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK3N0cnVjdCBtYW5hX3JuaWNfZGVzdHJv
eV9hZGFwdGVyX3Jlc3Agew0KPiA+ID4gPiA+ID4gKyAgICAgc3RydWN0IGdkbWFfcmVzcF9oZHIg
aGRyOyB9OyAvKiBIVyBEYXRhICovDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArc3RhdGlj
IGlubGluZSBib29sIHJuaWNfaXNfZW5hYmxlZChzdHJ1Y3QgbWFuYV9pYl9kZXYgKm1kZXYpIHsN
Cj4gPiA+ID4gPiA+ICsgICAgIHJldHVybiBtZGV2LT5hZGFwdGVyX2hhbmRsZSAhPSBJTlZBTElE
X01BTkFfSEFORExFOyB9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiAgc3RhdGljIGlubGlu
ZSBzdHJ1Y3QgZ2RtYV9jb250ZXh0ICptZGV2X3RvX2djKHN0cnVjdA0KPiA+ID4gPiA+ID4gbWFu
YV9pYl9kZXYNCj4gPiA+ID4gPiA+ICptZGV2KSAgew0KPiA+ID4gPiA+ID4gICAgICAgcmV0dXJu
IG1kZXYtPmdkbWFfZGV2LT5nZG1hX2NvbnRleHQ7DQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+
ID4gMS44LjMuMQ0KPiA+ID4gPiA+ID4NCg==

