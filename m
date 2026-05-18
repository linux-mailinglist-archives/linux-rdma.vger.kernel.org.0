Return-Path: <linux-rdma+bounces-20894-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CE8L2bfCmqR8wQAu9opvQ
	(envelope-from <linux-rdma+bounces-20894-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:44:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A684569F5B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4964D30B1686
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C913E7165;
	Mon, 18 May 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="m05SgRom"
X-Original-To: linux-rdma@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D683E7172;
	Mon, 18 May 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097003; cv=fail; b=D75X1xS3SVmQzzxr2i2mLNY1WJmyobP0tvXSyFSYVx17YsTg8ubzPmgD+XqYTOw4ER+OMgFfQYXxSr30uIgXRQgyQd2MysWWP7iiIfJ0PpNkltpRtrbYZvxRM+Msr0TKVAI5I0lG1nE7CZSa41n3vT1vXHnxSoaFJ9pyUvECv/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097003; c=relaxed/simple;
	bh=o0CZsXr/Wd/yIu1r26NVuoSN7WzaVV3TwaG67VnIEjk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awcZaJzgsRN9voiVv8c++Pq08nxC5Nd6lNrv6f4pb0fJ4b0Xyv0J8w/EHUaXqt+6+2Dr4yPJXdXUWW5ZdOCpn5lWPbWcDAOnLXVMsr7X50dUYE6AD2Hv6cYgPYBDDAqGDoOpsjd8jU7bYdRINIEi5KlWnwbRvu4fc/p4FMBIGB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=m05SgRom; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Awth8sWXNIszZBd0tdl8HAKppZdaEhFU7/8rUnn6gWbv7JVbk1EJx4YvB6qaMmRonQ4A4NCluAYzR/qJckQbQmc1wmJ0BCk/p2N5BH6cr4uTDY6ToX+/cVaabhMqORqt8R16DuOdf5FMAMDFTCZvdj3v0zqYWzMqPY0cZ4bMiZRhu1Je28yd1BLJkh1AHM1Ofye3Y7bmfiaf3/gfM0lfPnICLPyrdYzimSwPWjAaV133bt/Rb1OqJ9T1BTUzXC6mKS43t7T+K3GS4al2gvY3Q31/8YnlMpUqGmdWUdtYQyChSCdSeVNtlxNGg91t0zwhDmlA/ytGJf3fsiC9v0TmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3ANBjDiRFANAOwutlfxbjMCt4B/5jUztkk4vhtfhhY=;
 b=KS/6FmPuAO4yowG0ua+pzPYLblIYz+OrA5KQ4DeRgwhTC7hHtga58NennDYxTTRt8meME5hhqqM3QfcfTSF3ASMpZsOj5rC5Wtv/qP130kHopfn3CdXq9cFQVGPeCo9v4HVPZFYSYTOCWvLkgGkYPDMo+5LhDyGuI8/WFdHQDt10anqWh6Y3/9kCxHSldxM75K8et9M+Qpkt3qEepAsYGq6lE4SWGyzsrOoTu6CNNbVpU6PKFg2FFHJNtfvYjg9oRe87GsqrUA2kmNScgg4znqCIa1LTbbCemJaoL/N+SW2tb65+mCjfQRItHoYV5ATnas8yt9vhSsL9Lbx8Dgvx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3ANBjDiRFANAOwutlfxbjMCt4B/5jUztkk4vhtfhhY=;
 b=m05SgRomelyl5ImX8hNlcRBATuxinlZwYcZaVmP3koalwZWoGfMSSrQ/7Uw0bpSfVIp0J/sSLTqmc5PAdgwNBCdp9g6+9lg5Dl+athvX+bd0WiDEMulBk8mQdsIpjV+U+7vdlqxX4ehwdqGfS7nHEGjN6YFffZ2T/QLiiiQ/oWQHDfh+oz5QenOpvVsR8qhfJPLvmxpTImwQFWkAQDXYD0vZ2KjtN4dfPloFuaBMgtlZMieuGqx88Fx0i69qwxUpffXhtKW017OEFNIfeWGhVQ7/kD4dMUhWXQGmXk1Fyp+Nyunr6htZFOr1U4WP6RXTdQA37+JCQhiAqtD74f7juw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GVXPR07MB10171.eurprd07.prod.outlook.com (2603:10a6:150:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 09:36:35 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:36:35 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "parav@nvidia.com" <parav@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>, "shaojijie@huawei.com"
	<shaojijie@huawei.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "leonro@nvidia.com" <leonro@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
Thread-Topic: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
Thread-Index:
 AQHczn6f0twYI64FckqHOyx2gZ15hbXsSTaAgAByMYCAADgPAIAAKsaAgCZ/ksCAABYygIAAAlLQ
Date: Mon, 18 May 2026 09:36:35 +0000
Message-ID:
 <PAXPR07MB7984D1A3B0F22BB917690E21A3032@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
 <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
 <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
 <e6aa13f1-4284-4ae0-9dda-1a506e729156@redhat.com>
 <8b610e49-ff64-497e-8712-588b2228df02@nvidia.com>
 <PAXPR07MB79846075432AA7F7CAD67006A3032@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <9c324e5b-24a0-40ef-bd00-fb305825d06e@nvidia.com>
In-Reply-To: <9c324e5b-24a0-40ef-bd00-fb305825d06e@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GVXPR07MB10171:EE_
x-ms-office365-filtering-correlation-id: 11f7e3a4-8849-40fe-174e-08deb4c0f3f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007|921020|38070700021|4143699003|11063799003|3023799003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 0xYBqOTpIRy6bzoXxa/BjhNy9LYwbkXvqfor2DCdPa/qbkUFxXRFrvOSTYieA4VZGKlbOocUuuf38J67jiBa6+dxlZ5Ypu6uMDXMCGZkiQ8x4Q2h7yJHe5+2ZDds8mk6x879ZMG4rLZnU7G23ZJ2kVHia8ImA1YuMpNRU9mMtxR/Th+eMKuI6oE43cpWyjkn6vk2/1LzA3Az/u+7FyWo7YFCEtFMxausE7tnuxeeaa9DLU547O0eLX3D3+eHHFh/C4jnxD4aimkMt7vyHqu+MoR4hAjgd5er3Zc4Iu6cQasIzHQ4jlseV40rausciGsFmyZnErWMMntMl3lzG4p5u7x6CuVCGdshFwn71t9t5ydoIu3H4yzjFbI6bDTrpor8LgwmeVwvEWKpk26suWwTrCn8pPV7+28L4EAexqtzs3+e3Zh8u7tzoGf1eawlvlyVsYrYeC1V9F8fTHzmK2bE4fVs+LWIgug5rgNCdzGnxb+fPeTotVsA9NLibqiziY5PZOMfZoeN5kF6KTxPawavkSAz2MGk88IhADY1Wls2/gr3QvLzEL27HW1ysmdK/CmlqZdv89/o+VIzH25SsVry/M0V7ax6aoYTYmC9poJCyUaQotpi7g1pY7uc66wwt8QHjeDPQ4kUHMuXAw0Wwx6/dvdgVR5bPHPbxdyj4gdtrmmoEzPYLLIc2VZht7fxqezZWfaOnxYHZN9uOL6OpE1d9uQZnmLgPQGPrtfTepWYY1K9hamBKAD8VMs7Fy5HwKkYsE8AQ0DgNqe2zHOSNLTWeA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007)(921020)(38070700021)(4143699003)(11063799003)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KgRuroQSXpoOrB16W+PDZZYauaE7hLwqCQLuL3BvSWSScBMg9OM0YwaVpQdy?=
 =?us-ascii?Q?PtoYihviA94SkxZW2WVWgJPM6MfAsIz4WonJq3nCdKONh25fakYAZ16swVC2?=
 =?us-ascii?Q?mBE/8b0JHprwEJ7lzLtUdaBdEcd31WThJgAJBY4mEgTmg/nEGn8xQmg7hgH9?=
 =?us-ascii?Q?1WH894R2cc1MEbVM6UhAB9M9T+6RnzuGqofcnCnrtLWgilCzPQf2ILmCiu44?=
 =?us-ascii?Q?WxucsJuoTg7aaYJSUJo5OSaIw6OxcxAT9LGH3OwJiT2bVvxGWyMhLn1HIDV8?=
 =?us-ascii?Q?28K9OCcfSrF3pqamy19SoxdTvFy3wNGXnwdFwXqWCdvEZlSGBzbpvaCrgn4T?=
 =?us-ascii?Q?BS6jhT7HmwX2NsmjaZjNhdfL0BP+wLeFy/A8GE4wRBkdBzEEycHmy2Pn4XoK?=
 =?us-ascii?Q?cM3OGC4YHBAyuANq3g3OI3nUxVn1fFiNp1KAEQMax6RBDJeaxKZyzZlw6hAQ?=
 =?us-ascii?Q?Av4ZdodjroDuLM+TdpPIL61rPqv0aLFYhVnvhl7pPqIwtLmzhk3DFVGJ2UYw?=
 =?us-ascii?Q?yOQ5BCjUGATpqmZi1vEAbLOT02voBVeCQlGrwRtEALNmDSSqj7INpilbZRFu?=
 =?us-ascii?Q?f4YPsMrCGYPowMoWsFzYGn2BL3fW3lGQYaI55mIcthrX4hgs/Jnv9m45z6nR?=
 =?us-ascii?Q?I0QWM0cTW0oBukcTgZW+orPJaeAo751zJrq0vUJ9oEC6YQ+zmbdG5ZzFBn1W?=
 =?us-ascii?Q?WvNjISdu8Wpek8pp0BLpWwMTWKU0NXkkSCja8p8T6C8warIlLJzXubVbmxbH?=
 =?us-ascii?Q?0fYWOSbh1O701vKsBFoojUj0jeEMPvwZnR+rVQNRs6yGQIy2bpGZy0i9b5pm?=
 =?us-ascii?Q?ysLmzshkkU8+XTlc1dRc7ljWCn8jNbrV765A4WE/Qf9Qc6LvUMXOAEcvGYsg?=
 =?us-ascii?Q?WZqn5tFq79XK/OoUdZ+IGtTms/dpnleVnnB3A7p8yZf8V2+SKlzcEwpza66z?=
 =?us-ascii?Q?UYEgVvSxJkGlMBbW3ecwc9mhD87OC/JBTzWH0ol/kgiYnMHIgTu0ADG1zzrj?=
 =?us-ascii?Q?dsRDS+QgRkY5ttgKfO7feDemY+1tzFfCavEiil+RTeVdaUbLDHP2I87e0f8P?=
 =?us-ascii?Q?GmvJzXI1+o4D7LF3VgFXeklW7xRxguukDeDhWsWKScP+8S02xU1cAJ2KNqLu?=
 =?us-ascii?Q?S+Kdl/24b9RuJYWJHYw2VJypabBfJWS7A8DH+Gz5jKLeoFHPpDovQpHzTl3W?=
 =?us-ascii?Q?DGFsF1+hv7oWToBw1i2F9zf+e+hTjY6Aq2p5/LaRU11t8JBceO8c2L3dPXNb?=
 =?us-ascii?Q?N2FWKSBmlIXj2t0uePL554CbXD1K95Rt2reINXFUmcoRB/Kw0N1swz+kXPnW?=
 =?us-ascii?Q?rQt3dVOwtOH0sgpDXtzxrQgD7wZBaUmBPyT7Gm89bUSn02WPLB5impClcwhS?=
 =?us-ascii?Q?8qIA5j+KpdhMtmCU/mMqbRyC3xUBdTNTBkL57RPsISrBJpWNqj3r6Ht08ZEK?=
 =?us-ascii?Q?OiEoHGgfm3LTvg1tOoxJmytxLyIXCZf2QUQmHxE7pNpC7u+lNL4/ZITBSglC?=
 =?us-ascii?Q?6zUejqA2DCvvCGcPo7PemiZ+yolKBi0WIrfcoxoceFKus1od9MkJ8kUo9KVJ?=
 =?us-ascii?Q?OYTBVwh8ozGtKw2BNj7aplbYoL6OwrRroIfYTBFpIba60HHZXctD1gLBcXJP?=
 =?us-ascii?Q?QLPoerrNzA4aBN/q/VWwRt+DuxtCKVDvxoy0LWfyGU/pHPNFYgI2lCGShk8t?=
 =?us-ascii?Q?h2vCmBuSUOuHvZOV54L+x2OSJmAYJcaWj3RRo3o/QuNihuNVrv5vx6bSlUG2?=
 =?us-ascii?Q?pmJzjSaS/lvPfugzgjTaduQFaQczqWc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f7e3a4-8849-40fe-174e-08deb4c0f3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:36:35.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aG0aqtJDubN+fNMGGYFlUQzVlx1kIVPK9TTHa5ePIkKxIAhExj4jTccUsHg1ttCdWHhsFwO8DW6yRfs0JDdrVcsUjhx9EDs2/wPhpuR3Ztk1rMf24IuCsbJtVkIrZN1H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10171
X-Rspamd-Queue-Id: 4A684569F5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20894-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,redhat.com,huawei.com,lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

>-----Original Message-----
>From: Dragos Tatulea <dtatulea@nvidia.com>=20
>Sent: Monday, May 18, 2026 11:27 AM
>To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; Paolo Abeni=
 <pabeni@redhat.com>; linyunsheng@huawei.com; andrew+netdev@lunn.ch; parav@=
nvidia.com; jasowang@redhat.com; mst@redhat.com; shenjian15@huawei.com; sal=
il.mehta@huawei.com; shaojijie@huawei.com; saeedm@nvidia.com; tariqt@nvidia=
.com; mbloch@nvidia.com; leonro@nvidia.com; linux-rdma@vger.kernel.org; net=
dev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kuba@kernel.=
org; horms@kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Scheppe=
r (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; in=
gemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@app=
le.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
>Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to=
 preserve ACE signal
>
>[You don't often get email from dtatulea@nvidia.com. Learn why this is imp=
ortant at https://aka.ms/LearnAboutSenderIdentification ]
>
>CAUTION: This is an external email. Please be very careful when clicking l=
inks or opening attachments. See the URL nok.it/ext for additional informat=
ion.
>
>
>
>On 18.05.26 11:20, Chia-Yu Chang (Nokia) wrote:
>>> -----Original Message-----
>>> From: Dragos Tatulea <dtatulea@nvidia.com>
>>> Sent: Thursday, April 23, 2026 10:13 PM
>>> To: Paolo Abeni <pabeni@redhat.com>; Chia-Yu Chang (Nokia)=20
>>> <chia-yu.chang@nokia-bell-labs.com>; linyunsheng@huawei.com;=20
>>> andrew+netdev@lunn.ch; parav@nvidia.com; jasowang@redhat.com;=20
>>> mst@redhat.com; shenjian15@huawei.com; salil.mehta@huawei.com;=20
>>> shaojijie@huawei.com; saeedm@nvidia.com; tariqt@nvidia.com;=20
>>> mbloch@nvidia.com; leonro@nvidia.com; linux-rdma@vger.kernel.org;=20
>>> netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com;=20
>>> kuba@kernel.org; horms@kernel.org; ij@kernel.org;=20
>>> ncardwell@google.com; Koen De Schepper (Nokia)=20
>>> <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com;=20
>>> ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com;=20
>>> cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com;=20
>>> vidhi_goel@apple.com
>>> Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in=20
>>> drivers to preserve ACE signal
>>>
>>>
>>> CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
>>>
>>>
>>>
>>> On 23.04.26 19:40, Paolo Abeni wrote:
>>>> On 4/23/26 4:19 PM, Dragos Tatulea wrote:
>>>>> On 23.04.26 09:30, Paolo Abeni wrote:
>>>>> [...]
>>>>>>> ---
>>>>>>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>>>> index 5b60aa47c75b..9b1c80079532 100644
>>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>>>>> @@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(=
struct mlx5e_rq *rq, struct iphdr *
>>>>>>>    skb->csum_offset =3D offsetof(struct tcphdr, check);
>>>>>>>
>>>>>>>    if (tcp->cwr)
>>>>>>> -          skb_shinfo(skb)->gso_type |=3D SKB_GSO_TCP_ECN;
>>>>>>> +          skb_shinfo(skb)->gso_type |=3D SKB_GSO_TCP_ACCECN;
>>>>>>
>>>>>> Here there is an open question for nVidia:
>>>>>>
>>>>> Sorry for missing this question in v3.
>>>>>
>>>>>> Is the above enough or will later segmentation lead to the wrong=20
>>>>>> results? I think/guess the firmware is (still) aggregating the=20
>>>>>> wire frames using the ECN schema, i.e. the first wire packet has=20
>>>>>> CWR =3D=3D 1, the later CWR=3D=3D0.
>>>>>>
>>>>> For mlx5 HW-GRO a packet with the CWR flag will flush the previous=20
>>>>> GRO session and will not start a GRO session for this packet
>>>>> (napi_gro_receive() will be called on this single segment skb).
>>>>>
>>>>> So this change won't impact the current GRO behavior from the mlx5 dr=
iver/hw side.
>>>>
>>>> OK, thanks!
>>>>
>>>> For my education: doesn't the above also means that mlx5 will never=20
>>>> build GSO packets with CWR set (and so the above statement should=20
>>>> never be reached)?
>>>>
>>> It does look like it... Thanks for pointing it out! Will be addressed i=
n a patch.
>>>
>>> Thanks,
>>> Dragos
>>
>> Hi Paolo and Dragos,
>>
>> First, sorry for my late reply and thanks for clarification.
>>
>> The table below is to ensure my understanding of mlx5 is correct.
>>
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> |     Packet id     | CWR flag |   Flushing?   |     gso_type    |
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> |         0         |     0    |       0       |        0        |
>> |        ...        |     0    |       0       |        0        |
>> |       n - 1       |     0    |       1       |        0        |
>> +-------------------+----------+---------------+-----------------+
>> |         n         |     1    |       1       | SKB_GSO_TCP_ECN |
>> |       n + 1       |     0    |       1       |        0        |
>> +-------------------+----------+---------------+-----------------+
>> |       n + 2       |     1    |       1       | SKB_GSO_TCP_ECN |
>> |       n + 3       |     1    |       1       | SKB_GSO_TCP_ECN |
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>>
>> Currently, mlx5 will flush GRO session and emit a single packet when the=
 CWR flag is set on the RX.
>>
>> So, this patch (changing gso_type from SKB_GSO_TCP_ECN to SKB_GSO_TCP_AC=
CECN) seems more for future-proof than a bug fix.
>>
>> I will update the commit message to spcify that (or please suggest other=
 changes needed).
>>
>Hi Chia-Yu,
>
>Based on Paolo's comment, we have a pending patch that completely removes =
the setting of the gso_type in the HW-GRO path.
>
>Thanks,
>Dragos

Thanks Dragos, could you please put me in cc when submitting that patch?

Thanks!
Chia-Yu

