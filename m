Return-Path: <linux-rdma+bounces-20618-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI2EHA/5BGpuRAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20618-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 00:19:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2F53B605
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 00:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94E3730091F5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6238B12E;
	Wed, 13 May 2026 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R0y5I+15"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020091.outbound.protection.outlook.com [52.101.193.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B338F646;
	Wed, 13 May 2026 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710788; cv=fail; b=nbGPJbKii7aRW9y8tn0+vI00S+oDkSBk0WgPVEE4OEj0Ssgdcr0F2J3TuXpvOPzF84qzX4+JhO6Oz3/0WUeMtsGEKU+x+APm1wgOlwpr1ij6+2J1qAzcEiP86rlfuY1ZMqJ97+84B3Ply9EwqM/qmQeFJRB5YmRUkYtyWeP5SRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710788; c=relaxed/simple;
	bh=19Nckdd3RZZtuoOMFjvG4uE/DD85HcecBU4cDK6yMDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JqH3suNDB0s1ATuKfOMvR443oLntM4cW+TlzcYRtAVftJzZpB1uuRuc+Dx/1t6kH7ebeYuoff1AFeDaxROrAZeUz9zLDiv6AtcCKy+cmwLwK+m3uzp6xNolbTT+FvQouCTenn/DlGSOooArVvveluWmUtk4klTgMZh19rjH+vOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=R0y5I+15; arc=fail smtp.client-ip=52.101.193.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv/OVOmYS0Y7/qkf8LA6McZZ94VXJQa/GE3/6TrLxFZ23IvmhIxsoDpGE+XdpwYc/1EAYjm3GaaOXQaBnRAZx4WSz77CGa+Abc8753e7i9nCwYiKFkGisjmAVHocXOjLEogFdpheNYNGktJChjuuAfi38khR73SLZNhgOLMv9y7Vh+/zDGH2KCfz/bYNxoKVySg5/RefsNyb6aGRKvnzNcaX3TMRccPDjH3yHghBf3YrLMDb5gT9ou0N0AVf+U+jS/mQqrZJZgS4e7gCzFlvLTEcXARafhiCpdBp3yV3Zz9R2QW7WPlBWbdw7OBMZEJDjN6TGz5/4xaHWrisrl1k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyPXnbZsNWfFcrG3BqmX2JzopHu6KBBBpe6lU4XsF7U=;
 b=ZTzLrws/5OG1ZHuNFypi9DP5zGRAE5v7CtX1ub39Ghw5j1IxWYN3xmWW5f0QErMnqb9Y2WTul5s/hPlVJzfVmGs0GtioDzz7COsVBxYt4HGTTnxn40BznWqhHut5s+7IJHUut5ikGtUPmPs30zk56yZiEuMoQBMNIm+Ecb5KhHFAvI4bRgsywblAnzsjq7DRFhLRokVMgkrnBlmUo+ij26rG38yw/8xOX/t83Dj3eaZaozKq37KtDvnxbnlzH52cLX2MQmtI6bO5budzRgtH8g3Zu3iuxKrRpYB70g4cB3CQWzWr2cuX89NYshyXixfZvErcnK60pPAuaYo2rH4pAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyPXnbZsNWfFcrG3BqmX2JzopHu6KBBBpe6lU4XsF7U=;
 b=R0y5I+15ayAgoJ2Etw7NcA/cYv7x5UavwywfUWLXYuapzdPhKmHH91MCEp5v1DRU1TdIwVOS84QCh0IEFsto/JPPqS3hr7FQUaLD/jYmbbnjCrfIScuKirApN0m75aN3CiayCfF4QNvMQnEJ3k4bZU1UeWcPnMg+5HJqeDwVA+c=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6875.namprd21.prod.outlook.com (2603:10b6:806:4a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.4; Wed, 13 May 2026
 22:19:42 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Wed, 13 May 2026
 22:19:42 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/mana_ib: Report max_msg_sz in
 mana_ib_query_port
Thread-Topic: [PATCH rdma-next] RDMA/mana_ib: Report max_msg_sz in
 mana_ib_query_port
Thread-Index: AQHc4fOdrvxDE+zz1kSO1uzPi4qp87YMiTPg
Date: Wed, 13 May 2026 22:19:42 +0000
Message-ID:
 <SA1PR21MB6683D894CC90D091C2C9A2BBCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260512094209.264955-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260512094209.264955-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19632ecb-f692-415c-8ac8-a7ee6a00550e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-13T22:19:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6875:EE_
x-ms-office365-filtering-correlation-id: 986eba0e-fa19-4e71-0b92-08deb13dbb18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|11063799003|56012099003|22082099003|3023799003|18002099003;
x-microsoft-antispam-message-info:
 FXB4hf+4B8w0+Msp99+Xai++/vKsGZvAwdQIUlC2HXwTWRHOl0CgOp8RCsq9MZhlwIScvTdRqwwH1rbMHnwrKN2gsdUDMiLg20hCPZPMGnUqLca54lcuiqcmU/En60y9dGHNlwGPKnbrPjRjF9KXguJvZ+0D6DeKP5/aMv4u+mbOuDXauSkLbYySYWFT0nxe53IzL4vHOt1uDaVOBigHoemzhV0EjbrbB9jRLoAmndgCoeewVwb4CVHUdRPasM0qiuLoOatoaJHPKm/ZkHx66kpUvj7sOwqY40gv3JklKG54sqrXzqydHnSDHdWc+RzDx876qur86MiF3Log0ZYa+/FeKgAYTdGMKZh9QqG2iYdRWfsvVPUryobMfX79PyIiqOAp5MuBLzxrc1JbKc9EdaEMaCrTwwOFj15no6yV9HDAuOjHOW/i8E6vakk5Fu65aGYg3r7oSjQXX4XZx40rir/QGtsYmnaVeQ52gUKqNzCxCB+E5D1N9cNPWCZNgn95nY19lv87SX2vks3nXpQ3uIqpAeubMklAXqdesjFLF7/CgbYqY4gcMsLKthjMXhi9b6SuTlgzOtIBONuoR+2Eed2yKE8arM6Ta5nBCajcLCynIr/FHkE4EQa8zAwjcGhEMst4Q/DFoClCgN+1fei/ChAZGPsDxXXjw4p3ijjumQIFr2PGMwJKc6j4nKw7cMCgEEX82wnV9xgoVpJ9wtWiSpJOGmsLiCIu58ghkUJFGCssFfvkatg2wfP9Z0nv7btb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(56012099003)(22082099003)(3023799003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NeCQgSKyiEjY4tlK/AihVEq4P45Jk3AKYdaxFhM1D1YVVOl00BMng3xsQDXn?=
 =?us-ascii?Q?bj+ZdiryEXv552Tv6TwMwR2FDf/sMFuJinzbADnYfgvTuJDPXZ7x2eWfuwKk?=
 =?us-ascii?Q?qOX73/jZkNXxlK+iNxit2NP7kpmnnKKYherUxJLzk7UTUse7iN0+zf0J1t3C?=
 =?us-ascii?Q?vV8Ju96NcEK9Iabiti57B0laOlZt6anw520cPOSu6UNANrUzb5i8mHvcf4Yj?=
 =?us-ascii?Q?IY368j13iHbD8Ct/+bmL4iTZkD1O3pe67znYpUAGX9UtsMbtVWDWim5jI9PZ?=
 =?us-ascii?Q?H9tbwKBSXciKiq1yNMbCK2bJmL8+1cORFLlXgdJT4c0tlf0/Nrw7F+SwSGO+?=
 =?us-ascii?Q?hQaYtEfoHAjn4AXmUGvESJ0tYgBFml0z2ksUjxLRo/F5RtdXoI54ong95ufS?=
 =?us-ascii?Q?MuZTDbgdXZSk2r1SBm1yg7AI2RAOX4pmf0/pSHq8us4dGS1Yx0hUJeQ6Wm6L?=
 =?us-ascii?Q?AsBXPfbg4VSU0ke4mcbMqwSWFbmOpR4J0xX0XT08+VxvkzL/owJxDwI2EoDH?=
 =?us-ascii?Q?fEK5VGQkPWQSsza6fMaO6co3daJeK46bPm6kOD9ajQQCIiAf72fB06UK7rYN?=
 =?us-ascii?Q?U0Gmo1QgBJRUJrcHY0ljOKtGMAXLFgWqS8x4KouNSpX+cffCPe8NCwj+NyWN?=
 =?us-ascii?Q?emsOFhd54zkA4WnAFbwoQgbOtKm/IsPGgrW8DpWXzGjFiIA1NVyZY+0lTVG3?=
 =?us-ascii?Q?H/8dJb2VJr9l8AOvKeaNw8yrBrPU2nfEHj3aEutTmETbBhKIAjaJooOA+sVU?=
 =?us-ascii?Q?aBjrpclPLpmaRMphDTFWt5ygaYkuy0buBkU1fYHO+fn/5Fv5wWGXZ14G2YVo?=
 =?us-ascii?Q?jSPUHmGARQzppdsm55opBh87t8wVHJThwU9GQAFC9VKgHOBMumZIISzGrWBq?=
 =?us-ascii?Q?Nfyll27lw9w/BxHwbu7PEEvSQpgyRCG+W5xagmxbREMSXq4rza1RMDXNjYWD?=
 =?us-ascii?Q?vD7wyrGu8ajQ66Kf2zgYGSb2RzW6k3+RtFpjw7GqMs076FkWs2l8cQwWBZmD?=
 =?us-ascii?Q?+Xpj0DCuU5Xpk1hyCtY80ByxR0LFDNiujyYTeHhCA2Z67Hy5+bwwFmjB34o6?=
 =?us-ascii?Q?eRs2mLGXF/aHXdNUNjbA8KuZlckfk2HToGy2ave/3mAWsFTrfnG1o8g4xj8g?=
 =?us-ascii?Q?8kVz5uqUBqRrZL6hUfYRhBO+0FD4c+sRWJWG6xvuHSA2B9BbpdEMnAmyYRCz?=
 =?us-ascii?Q?2JDjnk7nriWWHu5Ds6b2U+zsHdnZeJT23T44WZ334ehA1qOjRKw0kzM6h7eE?=
 =?us-ascii?Q?aWlpeCpQkqGVKO82g7VQuF2RQpxIdiW8S/tWQczMA0f50gEgy9xQHP7pVJQ9?=
 =?us-ascii?Q?jwFEhc9PCdgF/kzAmBdcfWqgs8kg/p6kStYUa0pA/RhKpM0DNbE8zff6LUf0?=
 =?us-ascii?Q?oB4O55wA0L8UNdyp4986Mx6uANBbaX3mM+dnpYWf6Kj2aBTMi8/saSKGyxgi?=
 =?us-ascii?Q?xzulFJPX0Vv6sO1/yt56RPBSrhRmfQSGrus+jV1oSEMR442Uu8y6IpQBWW20?=
 =?us-ascii?Q?dNuv0anTvlw8N3ZhMl2re8bi03hKkq2mqQjkY8C+v0QUIjyXuozt5YY/cHTk?=
 =?us-ascii?Q?2hmWjwFS7J5ck2pY5sZ4SX/7j6SioncAqOnWjWJGz/qyhSZTu/3lHlkdaWOv?=
 =?us-ascii?Q?v6RsL2He/VMXbgZ0mlI4AfX+12iMuGLxek7vVkuABDunn/MAoBlSapuFDzxg?=
 =?us-ascii?Q?v63ge02WwWrJpFi3sPKKQY6gAiQ0/YnVkxjwEolB2MOGCbH6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986eba0e-fa19-4e71-0b92-08deb13dbb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 22:19:42.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZhZ6dYOfoZlFvcRZVvW3nH1UuJOJdtZ93kAlUy95YCzdqXY7bWso6HLrmmzCwDMfd8ImCqTaM+9TSoQj5qy5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6875
X-Rspamd-Queue-Id: A8B2F53B605
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20618-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6683.namprd21.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> From: Shiraz Saleem <shirazsaleem@microsoft.com>
>=20
> Report max_msg_sz for mana_ib, which is 16MB.
>=20
> Fixes: 4bda1d5332ec ("RDMA/mana_ib: Implement port parameters")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/infiniband/hw/mana/main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 9af92a4..4c211ac 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -638,6 +638,7 @@ int mana_ib_query_port(struct ib_device *ibdev, u32
> port,
>  	if (mana_ib_is_rnic(dev)) {
>  		props->gid_tbl_len =3D 16;
>  		props->ip_gids =3D true;
> +		props->max_msg_sz =3D SZ_16M;
>  		if (port =3D=3D 1)
>  			props->port_cap_flags =3D IB_PORT_CM_SUP;
>  	}
> --
> 2.43.0


