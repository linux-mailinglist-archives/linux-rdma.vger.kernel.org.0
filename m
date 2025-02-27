Return-Path: <linux-rdma+bounces-8181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C5A4752C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 06:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2833B7A3A22
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6EE1EB5DA;
	Thu, 27 Feb 2025 05:23:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913D270026;
	Thu, 27 Feb 2025 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633784; cv=fail; b=pt5Zie/PVVxbemo/CuQvWU69HosVHzjhBCj4dWvXcFE+GqEwYZ9xeTh/R+cLmB4CT74Gk5vlxiFCDeAO6GAthuDNnpRwh1arccUQhdFhcsgSPRGS8oE7wE1mmAEYdxkATAvnIsdYSHfPJe+H2FZnT6mIIVtjAMSBi4G9eP8tt0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633784; c=relaxed/simple;
	bh=/ueZ78UR902fyej7eQ4vnIppKdl4dct/0ctHXNrWNqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DypnnFNHP4L3+dTfSCGOJ+ZGBj9N+61NqmeI9b0mC6tU/zDzB5D9oE+d7das7Ncn+AS4xXT655+7xfUARSQIPFvbLcSne4zl+tLWLZBq+jg95sfjiNMSz/TfQUWb2lWBRkqnqeHR45OwkjvrLtEjKl8nbuY//8Zd2Pz/zEmkLso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx6P3Z2OgR+LF6VfKaCIAGQ4oimSJzBOw2wDmaxjcaMenqAsevbIc052HF4i4sQTFcrWe1KxI8ujU2jbU5ZL/knWCy8t7XdGl1nr1TZayoNdpUuYPtprzwgrHHotkrMlvX2g8zuQsLmW1tR7cxz6YwNanhxXN2kIYjkYA9H0L631xRAh3VH4nB0pW8TzzJxqJwD+YfO9CMIzhN3nF2rgT3IXcMpJ55X5uIqn7/ixwqA0cL/H/7aJBC92CwQNQ2OjAyLalpXFIYvJEmHqFrwqewORt1yplNfPsbU7q3DmhzRnPAhPdNv/9UjpWKpXbQiLOpqk5IRw0KwKZr65DbtzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc4NFAiwjDBfM+bsms+ekdndaemTarECl4o22dgZRX0=;
 b=AZVnLJ+FJ9etOcvLUh7VinLmaYj0HbGntZvaHoYAfaO7VUZWcak3IfuBwqNTHfLEOMmiw9zQmFDSw12zH7QttnxMNJY0B6/9Huxo0XiMm3mv5HeyErvY4MMaxjwyPTtwCq9cOaSzcbCFLYNqAa6cB5hzzBXx6Y0LktgzxtIbe88mGPrfFv6nz+7KRtejtQuHUQrxRx7hvwHiDJFLSlTagLcGd6tJ/riHjlwmIfwyv/eZupzHkkryc54fhFEH7f8upn7is3Ixec8URX6UsjTMuTR9eWWwyFkpey0dcRKjhs1eFDdz6c4fnTZnD0apGpCQPXhgFwAWW4/YjZwgwnF9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 05:23:00 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 05:22:59 +0000
From: Parav Pandit <parav@mellanox.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/core: don't expose hw_counters outside of init net
 namespace
Thread-Topic: [PATCH] RDMA/core: don't expose hw_counters outside of init net
 namespace
Thread-Index: AQHbiIEA5fOsJxc08ECAgVhmqEKTB7NanCBQ
Date: Thu, 27 Feb 2025 05:22:59 +0000
Message-ID:
 <CY8PR12MB719566F1EE6987670B7D85F0DCCD2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250226190214.3093336-1-roman.gushchin@linux.dev>
In-Reply-To: <20250226190214.3093336-1-roman.gushchin@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PPF12042BF6F:EE_
x-ms-office365-filtering-correlation-id: d05bb8bd-ee7e-4001-3547-08dd56eeccf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3yJcQqODr1kb/QqyDX/WCPcxgAAIYs3DTJwAbgmcfook4VSsKvo2dTiimO26?=
 =?us-ascii?Q?3VlfJRHxTgSrCF1yYcUfzRWkPmkv0vE0HaYfm0BXhXWsipcGVHzAaXJ61SRS?=
 =?us-ascii?Q?wTYsv1EMkA7lUvgqNekuyotT0158b6uSjWtdr7HL0+wXHjjD3SMORE1VapZf?=
 =?us-ascii?Q?90ZimBbiGI9WQzbhPH3asI6U8snaVj9UQt+DNZzLbordE1ZxnsBvRLVbR8c3?=
 =?us-ascii?Q?mFLyCF8lcYUfteUAG9PZ0nlAf5qaGENMpRTAQrUKHrmBt6zBQ4HVZYPhyuxt?=
 =?us-ascii?Q?dTqlABhzOfSO6JNk0TfnlUuIUHk5VpikxtXmtc41wmE2tikHHhS9fMAyfLIs?=
 =?us-ascii?Q?Sv24XuKADtlL9kmAHkEV+wCu+JMZUYCy7FCm1PIPFlZ4yVxjoqya8iaYq6ic?=
 =?us-ascii?Q?7eD/bO2eN96Y3dSlZQgw2kvlFLhxyQuumdvIgdnu3Qab1qqJjavqPQ4kX33h?=
 =?us-ascii?Q?jYbcNFfyBh8JPr0BmbyG58EngrdOet2mzFiJ3oOxgeAkzFgD0+ztNFy2wFia?=
 =?us-ascii?Q?qzufF0GXueSJ+4hjYAWOvGUTtNzpQC3e0usB6V5SBQM30S4mxy1lcZ9YNmyg?=
 =?us-ascii?Q?v8sKVbdYhWUymcLqL6TE508phYE7YklXoIP5371PvDgM1wN5KyEE7TFO+dnV?=
 =?us-ascii?Q?9dhh3RNyk3kKRmLWpgNMXaM2oI8iXfGfNBYBsm8lLyQiHPwohROh12JV+CDy?=
 =?us-ascii?Q?npOUUIt0nu1lZqbBTDm1HrwkVx8ySMbcqmyTuP1QzRB1L3ll4cAXpg/h1r0p?=
 =?us-ascii?Q?4GE71T5fEq5SuDu68zmJ1As65ayAewIo4yCILnLmDun4pggV89kskyVrVyyo?=
 =?us-ascii?Q?S8xof6cwiQyDUi+nEg85uYWPYqfXJ9ePGl6Fzd74lJQ1KsF1nLH+2nofNN/o?=
 =?us-ascii?Q?pJ8Yk1wsRx1zILFekK/RCyrMkEhLe26gBRN5Ygo3jwzA95ZynUv1IA0bYVRj?=
 =?us-ascii?Q?vWuBjxqbeUaa747plOqskijtcHgeX/KeQDElJh1dfFREpRQ+JuSfOtWpgxT+?=
 =?us-ascii?Q?5GdMFe/En0Pt9a39+xEcxazhp12Z5KLJlISuYe0SqcuAst3c5nn9xny+3YLA?=
 =?us-ascii?Q?ZFgVlpgmsMInt3j2hyJVm/KqOUa3EORPzIdxsX943k9EYrSM4PpwioqpkYgJ?=
 =?us-ascii?Q?hL3mrdyDgvMDFkrayTeULSfObVaLeaRhbs91RtFN9NtG8Sksu2zie1Bn+Ry9?=
 =?us-ascii?Q?mfjRfgugaPH/GOhDGZ6fCqHwXpxJztyUwusunl7dbnCI5MJVWx8H7Ek4nu/X?=
 =?us-ascii?Q?75Zf2kvoSxvxCv3wGyXZKIv25UN4PjBMcN26Zi9ZX1u2pOwdiOzyvrex4dPQ?=
 =?us-ascii?Q?M30CLAFA7p5klC+zBx4k6DBVEUKehXSAO0k3lFSzsVcvlxCtU56DFnOqCYki?=
 =?us-ascii?Q?KJ3YBi2dLhlYi3cuvV2LYGdmWykGhiRcSPCnaegHLThIxMPf37S/Y1ze3bN4?=
 =?us-ascii?Q?NBajZrG5homwtmbWN5tms0aOeSSXVGk6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+fwxEDusSMvqJxtQqirF6ffRfFn//briKxwk9iUGQdEz9KLeVpoXJB1OIXhn?=
 =?us-ascii?Q?N5JFGuSgTRx7S73XsklAJBINEYxfiDk4AGTWEl8kH8FoKIGkKhQM7l09sUtE?=
 =?us-ascii?Q?9G+pM1wYMsX1vHQLrLoyW8lZ+ic808b9tUt8TGQH1pNqs2fZHFrvH/9tbpuJ?=
 =?us-ascii?Q?S9tzt5PHuSDF/93f6rECp+a4xOCpeZE1jPXols518Vk1E9ybw9SZ3ZTN2wsT?=
 =?us-ascii?Q?f4azJDDmCZx/0tUZhbYw8PR8E65A49esMXokQF/nXOXMWxIj/Az0LRDnPY52?=
 =?us-ascii?Q?/DapSODr0qe+v2nffw+jeIP37UZcWVdcmW8BPLM0AbdihcpDonhLyh/sJVUN?=
 =?us-ascii?Q?5n/ALe0G/0wZXDrdsx5vfmo2eJ60YWcC5qwJMSsgmyJOaQpm8ksEBosh3SD3?=
 =?us-ascii?Q?tLSwjJOVz1PMaXQ26F4W0bV5WsC/EpQBc5Zd1Og8I8MrsRCGcLweai7bU6Ep?=
 =?us-ascii?Q?NFPGch4N2UxhlPfE1lvfPUgpj/Fr9C2ywRPn31JDkiiyjq24LMm1WGJ8IBCZ?=
 =?us-ascii?Q?hbPj9ovuvf/rsbNkibnEqJ2rN07cNadxKT32Tf4qKrgkeNMkXurzX38IHq3M?=
 =?us-ascii?Q?9/tNQke4EyNx6haIbdBFBMghz9B46HBA9ammGiECr+d+FIwEDSK2crAdAnPy?=
 =?us-ascii?Q?rxYaDpf2u1SH1UOn6EfAchTCUHSecXk4aVqLzKvfCrBlyUpSDzZvPnrqotrc?=
 =?us-ascii?Q?7r+wUg/XI6Bheu75lxIlSH+9c1lXfqAsKFUrT5s24RsVMn8AHRUrNb4iBskt?=
 =?us-ascii?Q?tRSpO7utICrEggu6lFR0uXzyEHF0Nhtp871vIG1XQpWErgctbQKc3vOAulfS?=
 =?us-ascii?Q?PN8PEc8quhdUxJovMCoBx7k9PbnNa195StNMT1X8iM4DvOIa24GFQOB2PdQN?=
 =?us-ascii?Q?e4hYe1yVVNfYCM8BBM6lFcTagMBS5/5HoYIz7qO2AwLw9E6OuYCVNuvcwsft?=
 =?us-ascii?Q?+DVw87EpXmnrAQuVZiRQ+I/Ep0rT7d80Wnj8O4GpHThZxap3NxVR3UK6WdQG?=
 =?us-ascii?Q?WZcM6fl2vZvlbhyVwVZWDpG/vTUI5L2ktSMdbBPHBEDxa2SDz0P/W/OqUg/5?=
 =?us-ascii?Q?zWkjqQhoMyETz3n4YPvIPwNnWcEXKrFPrX97HtnBEKjgFI9LVPWMDUvtoNSf?=
 =?us-ascii?Q?dEuTIpUgmzWgxus8N/KGKkP/jRcY+vf7sqJXnaE/pDtkGeIO3mkcp2e7xhcS?=
 =?us-ascii?Q?t4EM5evYVmCZJ4Qv92SFEWpiqjUK5fV9qZr7B2kdGPlGq/dJsuWVgGHsntW3?=
 =?us-ascii?Q?KNHWj19rLG9lv8f8jRqhXnURpA3I0vivyoH8mKd3ThyUm7weP6hbJl6/LuZT?=
 =?us-ascii?Q?OUUVgF5F54UY1X8LpbXK03maRpB86XTz+p7zmK2Kiv5MU3xXrhj1NvyQmSGG?=
 =?us-ascii?Q?I6VYSlNnRph5sZZXpcAjmSqZJ7Iii2klH2ik8z/w9yHJ04kyOHbWHVLxDwK6?=
 =?us-ascii?Q?9FuSHKzk/JCVcGFVOGd/q0MQV5WyKM67tYrWKBMn2urtXTmpiavi94nod9xd?=
 =?us-ascii?Q?ujnMpjatYJTFEGIpg8mjp6OiLJeGy6duetdkqYWy0SeiYlzzXIEr8k35wK4z?=
 =?us-ascii?Q?qUCzU7/Xj5hfqE+/hlA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05bb8bd-ee7e-4001-3547-08dd56eeccf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:22:59.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0XNq/pnIVawhWMW2pxVqPw9g9i4513E+xV/08Gz7vrOhMWw6uUyh/5VkP0+MJGDrsagSWN6DtALwQ6o8yGWRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F


> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Thursday, February 27, 2025 12:32 AM
>=20
> Commit 5fd8529350f0 ("RDMA/core: fix a NULL-pointer dereference in
> hw_stat_device_show()") accidentally almost exposed hw counters to non-in=
it
> net namespaces. It didn't expose them fully, as an attempt to read any of
> those counters leads to a crash like this one:
>=20
It is not the commit 5fd8529350f0.
You just want to say cited commit accidentally..

> [42021.807566] BUG: kernel NULL pointer dereference, address:
> 0000000000000028 [42021.814463] #PF: supervisor read access in kernel
> mode [42021.819549] #PF: error_code(0x0000) - not-present page
> [42021.824636] PGD 0 P4D 0 [42021.827145] Oops: 0000 [#1] SMP PTI
> [42021.830598] CPU: 82 PID: 2843922 Comm: switchto-defaul Kdump: loaded
> Tainted: G S      W I        XXX
> [42021.841697] Hardware name: XXX
> [42021.849619] RIP: 0010:hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.855362] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1=
f
> 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0 fa ff ff <=
48> 8b
> 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48 [42021.873931=
]
> RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287 [42021.879108] RAX:
> ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI:
> ffff940c7517aef0 [42021.893230] RBP: ffff97fe90f03e70 R08:
> ffff94085f1aa000 R09: 0000000000000000 [42021.900294] R10:
> ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530 [42021.90735=
5]
> R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15: ffff94085f1aa000
> [42021.914418] FS:  00007fda1a3b9700(0000) GS:ffff94453fb80000(0000)
> knlGS:0000000000000000 [42021.922423] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033 [42021.928130] CR2: 0000000000000028 CR3:
> 00000042dcfb8003 CR4: 00000000003726f0 [42021.935194] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400 [42021.949324] Call Trace:
> [42021.951756]  <TASK>
> [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70 [42021.959030]
> [<ffffffff86c58468>] ? __die+0x78/0xc0 [42021.963874]  [<ffffffff86c9ef75=
>] ?
> page_fault_oops+0x2b5/0x3b0 [42021.969749]  [<ffffffff87674b92>] ?
> exc_page_fault+0x1a2/0x3c0 [42021.975549]  [<ffffffff87801326>] ?
> asm_exc_page_fault+0x26/0x30 [42021.981517]  [<ffffffffc0775680>] ?
> __pfx_show_hw_stats+0x10/0x10 [ib_core] [42021.988482]
> [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
> [42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
> [42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
> [42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0 [42022.017058]
> [<ffffffff869f50ee>] ksys_read+0x6e/0xe0 [42022.022073]  [<ffffffff8766f1=
ca>]
> do_syscall_64+0x6a/0xa0 [42022.027441]  [<ffffffff8780013b>]
> entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> The problem can be reproduced using the following steps:
>   ip netns add foo
>   ip netns exec foo bash
>   cat /sys/class/infiniband/mlx4_0/hw_counters/*
>=20
> The panic occurs because of casting the device pointer into an ib_device
> pointer using container_of() in hw_stat_device_show() is wrong and leads =
to a
> memory corruption.
>=20
> However the real problem is that hw counters should never been exposed
> outside of the non-init net namespace.
>=20
> Fix this by saving the index of the corresponding attribute group (it mig=
ht be 1
> or 2 depending on the presence of driver-specific
> attributes) and zeroing the pointer to hw_counters group for compat devic=
es
> during the initialization.
>=20
> With this fix applied hw_counters are not available in a non-init net
> namespace:
>   find /sys/class/infiniband/mlx4_0/ -name hw_counters
>     /sys/class/infiniband/mlx4_0/ports/1/hw_counters
>     /sys/class/infiniband/mlx4_0/ports/2/hw_counters
>     /sys/class/infiniband/mlx4_0/hw_counters
>=20
>   ip netns add foo
>   ip netns exec foo bash
>   find /sys/class/infiniband/mlx4_0/ -name hw_counters
>=20
> Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs
> attributes")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Maher Sanalla <msanalla@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/infiniband/core/device.c | 9 +++++++++
> drivers/infiniband/core/sysfs.c  | 1 +
>  include/rdma/ib_verbs.h          | 1 +
>  3 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 0ded91f056f3..8feb22089cbb 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -528,6 +528,8 @@ static struct class ib_class =3D {  static void
> rdma_init_coredev(struct ib_core_device *coredev,
>  			      struct ib_device *dev, struct net *net)  {
> +	bool is_full_dev =3D &dev->coredev =3D=3D coredev;
> +
>  	/* This BUILD_BUG_ON is intended to catch layout change
>  	 * of union of ib_core_device and device.
>  	 * dev must be the first element as ib_core and providers @@ -539,6
> +541,13 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
>=20
>  	coredev->dev.class =3D &ib_class;
>  	coredev->dev.groups =3D dev->groups;
> +
> +	/*
> +	 * Don't expose hw counters outside of the init namespace.
> +	 */
> +	if (!is_full_dev && dev->hw_stats_attr_index)
> +		coredev->dev.groups[dev->hw_stats_attr_index] =3D NULL;
> +
>  	device_initialize(&coredev->dev);
>  	coredev->owner =3D dev;
>  	INIT_LIST_HEAD(&coredev->port_list);
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sy=
sfs.c
> index 7491328ca5e6..0ed862b38b44 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -976,6 +976,7 @@ int ib_setup_device_attrs(struct ib_device *ibdev)
>  	for (i =3D 0; i !=3D ARRAY_SIZE(ibdev->groups); i++)
>  		if (!ibdev->groups[i]) {
>  			ibdev->groups[i] =3D &data->group;
> +			ibdev->hw_stats_attr_index =3D i;
>  			return 0;
>  		}
>  	WARN(true, "struct ib_device->groups is too small"); diff --git
> a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> b59bf30de430..a5761038935d 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2767,6 +2767,7 @@ struct ib_device {
>  	 * It is a NULL terminated array.
>  	 */
>  	const struct attribute_group	*groups[4];
> +	u8				hw_stats_attr_index;
>=20
>  	u64			     uverbs_cmd_mask;
>=20
> --
> 2.48.1.711.g2feabab25a-goog

With above suggested small commit log correction,=20
Reviewed-by: Parav Pandit <parav@nvidia.com>

