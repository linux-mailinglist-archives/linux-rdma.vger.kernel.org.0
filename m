Return-Path: <linux-rdma+bounces-22332-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7qttCjD/Mmqk8QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22332-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 22:10:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC469C4F2
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 22:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=a2j2BgRC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22332-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22332-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A5F3017252
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB63AFAE0;
	Wed, 17 Jun 2026 20:10:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021143.outbound.protection.outlook.com [40.93.194.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B33A9601;
	Wed, 17 Jun 2026 20:10:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727014; cv=fail; b=R3I8V6HtgMuMwO41iKCpMCt5NgNunJMtyk+SKP+RK9dRMJFUIH5UV5yB3/K+gE8CSDxbSGQ77Fz0phpXkVRjgPj9peGQdzi5KIqL58Lv5EmG7fYCD7AKhDAG6kBBYKyBXcnmeFPEki0JWZNM+u6b4UrhOw++pAvG9ggJBbUK8lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727014; c=relaxed/simple;
	bh=bxy+5GrkzzZ5zjvW8hvTG1FUL2J58plIHjzBGXjQj0M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b8hC+HVPpvGU7ypT6CdPxqb78ZgL0GCDVCtACvwGBEW5UZymB/xex4hla1olKEAcr55uSV101YoLuwRa3Sc26TFV2kz9lJxnVx9ux9MQ2CLnLyFxtxqLdVhReWaNly4akxlCxUbOmfIk1x6yEoGDZUD4J+rk2ZQNUqYJD77sPPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=a2j2BgRC; arc=fail smtp.client-ip=40.93.194.143
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/bYXl5MQWvRDPsT2t2BPkmksI1zpatcTbkydY9X9C6KHt/C/iEAJWllEczAvWA7zfuhLFRhd7h4+egl8s6zIMp32BehAeH7jHNcmG8C85C16Gm3LXrjaGhkZM79zC6JPKln9hMpeAHqht4q4JEQ9vqBtPljRPnCYHrXV3aV00SJgEYIyMQ0DkmpN4tIFgp+A2xVGWWOeiH4+Spg3CL1D5qg/fXVXwt1svxcEm8FkMJQqTwxALrZHZr2lswkHs7GLp7hTc0QQypDCk5xkuffD0TzNTkrDhBaCJk0z/iUCAMmVGiGGWHS+ELZTWZI3QeDG+G2lDMPs+V2PytQ5PTpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMBWJIbqhj07LvtR8E6edrn3Eo3mLFwZ2fpfgITxtUg=;
 b=IP/w5vxqBv5DPvcsCJ/OdVIFrEzulHIWOAbKzP/+7817Dw83VFAMD4+nHCYXFk/Ivc2Sd2n2M4FlhhuCFjANsoQHW6SFblSu5JhenwbROtjfCwF1HezJH4RIM1Gts3DKBH7c1JaqoqT1eZR05JImBBFwdNvriYOLCTVupOSjo95vx0TA7jBeH7h2cs2+01cH9FHbHJstCQwdUGb4yO6Fmmt0RjWu5KdNzgNyqTPA2E7mJBCnVi+FTomGiSDGumzZty3p5vju8llYw/ALU85muIHWLLN6BHMhneZRPGfs2G3RALRAbsMTSGnHajHLclaQ3e74B/XQDpOWZmTzVPw4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMBWJIbqhj07LvtR8E6edrn3Eo3mLFwZ2fpfgITxtUg=;
 b=a2j2BgRCvbK9bXQSMjB4w5fZ0+nTyAUTeWuCOg9rShGypcBvHsN7uym9MG/0rROD/CXyY3qu8nheEVFq+gJF2A8lu0cKLJn3uOpUE2NVbAflN2iJcNJduuRKODPJPE9962o/ORGm88hFF3C77PGVLrOq+/cnzVcKFy+mTTb9DNc=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5770.namprd21.prod.outlook.com (2603:10b6:806:492::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.6; Wed, 17 Jun
 2026 20:10:07 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0139.005; Wed, 17 Jun 2026
 20:10:07 +0000
From: Long Li <longli@microsoft.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>, Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] RDMA: initialize return values for empty work
 request lists
Thread-Topic: [EXTERNAL] [PATCH] RDMA: initialize return values for empty work
 request lists
Thread-Index: AQHc/ohdjslHBTOoXUOt9jZt0cWgz7ZDLI/A
Date: Wed, 17 Jun 2026 20:10:07 +0000
Message-ID:
 <SA1PR21MB6683FA0FD6F1AA58DEF1969DCEE42@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260617183724.1099387-1-ruoyuw560@gmail.com>
In-Reply-To: <20260617183724.1099387-1-ruoyuw560@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d5993040-f55a-4c8e-a3ba-0335efc83792;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-17T20:06:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5770:EE_
x-ms-office365-filtering-correlation-id: 6af39c88-f2f0-4c8f-a4f2-08deccac6d5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 5jQ+R2YC+hKWSMn6Yx3Fk+UMFX/u70GJEJK0y5K/Ak1iRYJeQV0ZYa3iR5rOL4E5WWv/i9JX7lvwfumet9U+b9Esk32fRaRRpnno2BWuPcIgxSZLcDeStAr6/E/Qws8fcfxnuUEPvHxwLJZEapsm897OJrXIOjEKpYMiUn3JNCAU1dDMOmWis8JZLug52BSyNMMvNNJyEQd7kLVHNj7hURqteGGKiYBukknfOhkPqT7pu/gaOeaE/ZBRFkRRV1W6Aj+SFaQrWeD9wWPD0jvC9sUMJRGLsBeX3zN0QwFK81Vn6Wk92utDsgZCSDA+xJSjsQ0XOcmYu0M+ehJpN+09dilz3XCzn6444QwH0fBd7UD/FTGV4OYBcOJ5tv8SAzvu7VH0Gocd/rzjdFerdXMpg/MNyqt5bzgP8MMKnWf3a9UFug+8fc4MIY6YAAtXdQpXwxVtHmwS05hdUz0PtuUY1+4jLfqvMCUUFJkkxT1tg+6bhxZwlEpo21sfnfywWf35w+PFviFKSLjk3OXSmV0F44PaorHVQzMIuOymLZqhpI5FDJhfrLGuKE9HH7x9Hmz8NE3iljrMh3ml5HVkdW5h5kS9IjcKb7Lq+AkoN8LylQNjTV3KxQ8p5d0t5sAqaYmT8A/MJxcr36GmE05kFUp4/idtlB+JSh20XjdQIxb3M6eZ2YRBPDW3oju+aQI5HhRiYIaHsRPaAP9Brbx7bx/jdEZZgXeFbJ7QVaOd+Ea/hfPwE697D8B4yeUJvcP/1AX2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TeaB5hG2thGhACqkJcsvn0zQPA08eU7R0gul0COKf3WeAZVEqXUxlom8dz8v?=
 =?us-ascii?Q?8CimmVhs9qZg52Jz3mLsvb5sJ4GLSmi5wEaQo0glTB4tKJbv4VV8r3y5Y5cD?=
 =?us-ascii?Q?JE4bPY1MKypIR6vM6K1wu1u8VHTkAFYn2Lqwb5/aRWka9aczwtxkgaqNrR/q?=
 =?us-ascii?Q?jIO+NbSVwlz/5Q0RvuOkUs5NOhZ7CqH7ETYzyggQuOk/Vp9C+3XhB1BfcIcB?=
 =?us-ascii?Q?SpiW0due274tramv2sfLUlTGFfPlWBd2tNqujP7OwdnsoR/nVtQtdwUhrAi1?=
 =?us-ascii?Q?v/kL/yIvuzE+3cZmwv0Q1HhiDBawNiV328+OJ/d7TqY5Pyekls4VVryk2rdW?=
 =?us-ascii?Q?GiprJi4/T6aespV5Sm26gr+8BJ84bCpCnoPNNqEyjtJiw6WyRwRQyXgfaQHP?=
 =?us-ascii?Q?BKsSerCXInN3X/KM4KfMdbcgJWtxGsXAac9tdSIEz2K5xOlVJdVL16jXoDHN?=
 =?us-ascii?Q?IUovPM0VQtjJuYfAcPnm8vXye7CaqeXiozNVm6d1c7wr1TJQM1k8AbSt5+rO?=
 =?us-ascii?Q?s34HPUND0NFehDDUUj7uIQlDFpyr1yWVxeyvM0a64Z2KDtK0qGxe2DseCarl?=
 =?us-ascii?Q?51XV5F/QwEwRFQ81pnRcdqRAxQ9wCp2KaG210kf/2/RqG7+2wceLTCgga2fa?=
 =?us-ascii?Q?lsIBqFinvDEJlNJ+eY92s1UeMsoPji0HxMcTFy+86uydtBmuwck9QXr1MMr3?=
 =?us-ascii?Q?vBtR299jb0JgvvLb/fpQDP12771PF1YDixDdfhyi0jQBOnK49exztpSTLx01?=
 =?us-ascii?Q?3+EfzA1nHZiHNFMEmIyVVBz8V7e4DXkEKE/TCsQ3LHlwt7ZolVifXKpfXSQk?=
 =?us-ascii?Q?Ns+6qa+BfYZRQM3d0UQZFP09ZKlaWoWVavcoFH+0fxpFjh2DE6tQUQtGfsdt?=
 =?us-ascii?Q?6KsXgWg4uky7boaIr7jwSvJ5ryFMTAhgZSk5V3i27Ah7PEc6De7/09F4F6vX?=
 =?us-ascii?Q?DJToZSlE1O7Nk1sx7iY1Rv8LZWXCfD3NHNVRMR+ldba4hEcP0I/Ntm6Bu/z3?=
 =?us-ascii?Q?xtCigY5A4SgAmPr0bWOrvqF9iEUDDlYoo8SBzJj345VLwR+8oEIfd3J7R7HW?=
 =?us-ascii?Q?8SgFzvvhFTiegl8LWdTZNj5IAmMk7OM48YVN5iLyD9q2TjnjsrpqL4OSKIwc?=
 =?us-ascii?Q?SqdpF2IYWHdugMY/W7gUFK7I9p1G7NjcJAH3S5QreNR9TwYhW8WV3LzFi5rB?=
 =?us-ascii?Q?xCuuBTLtZ/RE5PrQSuikg3rSerfPQ48UGUiBmsmDSuNqSqjcv5hyKAjEqZ0o?=
 =?us-ascii?Q?kRsm/Rmx/bWTDaFVFef0c4wWXbEOW1Hz43KLnmvH4dVgLyRWQVqo3pSPk+4w?=
 =?us-ascii?Q?MOxwIeJhES2x/HCaZzg1aQZ0BzTte2THqK6yE0Wra9BXFbxyx4csoRPL25ds?=
 =?us-ascii?Q?9rFGblH6CDmwQUDzeRXVPxnadlunE/bQzbQRRSkkdlHXeXoZ9zM8gYNbRs1B?=
 =?us-ascii?Q?rC7LOJXtdqHZ1Dp4WSDsmoIiqhKpz5O9vR9KeoJE1z5b4AUkaNKtKNpklFE4?=
 =?us-ascii?Q?/HYmzXrAUUkhd477vEcF5coq+4+KE4cD+Lya4d6bLjJ6/bIzuOrd71p05Skt?=
 =?us-ascii?Q?X8sMZfnw/UGxNo0pIv0tMp040NFaZKkejLPGcQx3f1VVYly20RA/Ep0Z9Axc?=
 =?us-ascii?Q?vkoHtx9IwMZ8Qtch5XnzLctzjEjFMIKK7mLby71S3f+E8aWtSfqe2STSgRnb?=
 =?us-ascii?Q?rAsxziY+hlAk7QlHR7l0EayXYL6ZLT38XncDerEOfgq+v3/5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af39c88-f2f0-4c8f-a4f2-08deccac6d5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 20:10:07.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TF5vGZe4UEsToFBde5QMkTEpWyHCDyIM7tkt/VyH8EnQH9CvGTmxYpcE1oXhp30MdwQqsn61HjqAB4UBvOBZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5770
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22332-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:kotaranov@microsoft.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,ziepe.ca,kernel.org,microsoft.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75DC469C4F2

> erdma_post_recv() and mana_ib_post_send() both return their loop status
> variable after walking a work request list. If the caller passes an empty=
 list, the
> loop is skipped and the variable is not assigned. Initialize the return v=
alue to 0
> for the empty-list success path.
>=20
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

The code change for mana looks good to me.

It's better to have two patches, each targeting a different driver. And eac=
h should have a "Fixes:" tag for that driver.

> ---
>  drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
>  drivers/infiniband/hw/mana/wr.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c
> b/drivers/infiniband/hw/erdma/erdma_qp.c
> index 25f6c49aec779..e002343832f74 100644
> --- a/drivers/infiniband/hw/erdma/erdma_qp.c
> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
> @@ -734,7 +734,7 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct
> ib_recv_wr *recv_wr,
>         const struct ib_recv_wr *wr =3D recv_wr;
>         struct erdma_qp *qp =3D to_eqp(ibqp);
>         unsigned long flags;
> -       int ret;
> +       int ret =3D 0;
>=20
>         spin_lock_irqsave(&qp->lock, flags);
>=20
> diff --git a/drivers/infiniband/hw/mana/wr.c
> b/drivers/infiniband/hw/mana/wr.c index 1813567d3b16c..36a1d506f08f6
> 100644
> --- a/drivers/infiniband/hw/mana/wr.c
> +++ b/drivers/infiniband/hw/mana/wr.c
> @@ -144,7 +144,7 @@ static int mana_ib_post_send_ud(struct mana_ib_qp
> *qp, const struct ib_ud_wr *wr  int mana_ib_post_send(struct ib_qp *ibqp,
> const struct ib_send_wr *wr,
>                       const struct ib_send_wr **bad_wr)  {
> -       int err;
> +       int err =3D 0;
>         struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, i=
bqp);
>=20
>         for (; wr; wr =3D wr->next) {
> --
> 2.51.0


