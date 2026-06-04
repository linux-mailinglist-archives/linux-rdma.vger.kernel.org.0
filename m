Return-Path: <linux-rdma+bounces-21721-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FFgBI6fUIGof8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21721-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AD263C30A
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lDbs6tI6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21721-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21721-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5FBE301996A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A229261B9C;
	Thu,  4 Jun 2026 01:28:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505B261B8A
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536481; cv=fail; b=eGmsFhF1KqpCEPh+LHoCGnAuu6HUcTC2a9yglrAjRaCdGgnnfpwe4jMFGRpVLCv4kvfS/AGDUI35rOyDj/P94Ntd6jgbR3P/UnQfyOu4BQzMJxwacHVn9j3Tp6AjoCeP5kns6+gVvKJT0c9IsQYh5aCgWG5GfpQZbm9FMIYyv14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536481; c=relaxed/simple;
	bh=5Gh2YVoaxTIjHzx8xJcIybzHixTeNlvEWiMRz3SHGOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCf79a2cyODnJeylGPK3BzQDmQP1LGTRiRy/07C+KPxe/4m9+O1nFVNFq2c0fU3Sx4c0IhDIugwqlxtX3rRaNeBogyZ2g3qrc9gaBHEhzUoDg7tgyN4QQjJwHvPka56KbPNPZS/BxxqlzQdTb5fTRQZR7dOa48YeNr1ArRnPi9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lDbs6tI6; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZTQN1MNWR4WZ+Vi54/oF6SjjdSKvv9oEN+qzxGovLoibCuENm3AKI973UmzbjBuRRthb57jNCvzwAtZfvuualfvooBmMFk8+tqq0xTDo9u6XsFRM02XNYiqvLIvxniKZ4OzbuJK76RdaloRS2TfKXH7QpN8AY9vCHUNy0ycqfhBNebekVbtD1vgEFZb4kw+dkGxN+8G1xoSUYeWMbTF2cIbOzjLO9P3L5mrkeeAUPtrBenNNudYUFIDRol3T6fXfkdqz2HelZLA3rwsbdSC9ZXY40JfG9xHT03IcGfV3IZtOb0TWqpMeQqMpA55UF0VbtU7Acmu2GONP6mk1egcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V562cyhCrXigwrLrwtF3NQUDiBCO/Pesvh8BdJlD4TM=;
 b=bXs/2SVzL1E56huXV5hm7jrz1sAVEXY7JkuI0DmpEudQfrgo6XZVUG1XGEwyGnP02mq37JLa0eUO/CDgJDN+28Ito5NGtiK2Xm7eIMXPY9ueqqsVBrdu3Cccg4hbrsxyX9DjXRQyIp5yDpWnY4Yl2AgiQZM9BQrdmNou5leFhUWGe3blplNwbbwh3aKTsZtHIX5tp9FqhQIC/QCPL8vjlTFVmll6vQF9Q1PA9Xk/zkbeNxrq2Bz1L8LdqUAqDyaeWyoeY8QeLVDZuHZIU6y8RcrDPqyv4aRlukKam7xLuSNkszRcTfY9pxIHXEeq7dDb+h+5EtlYO0DcW+6hlprn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V562cyhCrXigwrLrwtF3NQUDiBCO/Pesvh8BdJlD4TM=;
 b=lDbs6tI66456m6LaqMaWvsZhD945yqXXuaGpbRROJcNoSUD9tytCtHpI4uOtR9TzQSwNemCccoF7t8jVYCXQGLkLXTHckir4FbW1V0LQKJTLhnvcxfwVgSQNkqnYS8JP3n9cFvwtn2pMXwE9//3aCAGevH2PAew1cX/SxtKILIvcdYqA/AkEFHunR6/lwox5pBwWMOZlyHjnHnMHsCV+EHFvXHfsDxlySdj0HAQkQXJNBA4iU4vh7jT1tzKDpJ3GZrDBClb1Fw35mHOZdRR7afkgZZOpwlQym+PMHQVyhUuNoZRL9+LbNZXxyfMguAoBjZ+fNRmH9Jjl2oHxYSO8TA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:54 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 01/10] IB/mlx5: Don't take the rereg_mr fallback without a new translation
Date: Wed,  3 Jun 2026 22:27:40 -0300
Message-ID: <1-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0059.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: fa751bff-4736-4a89-8c64-08dec1d87ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	G9u9BdakJ6j9W3MmsjEGoyFOc1GrwahzBqXYVeeHuvoUpasPFlVUbzscalgoO0p6klYssQc4Fz+r2vk9/YUX31dNsNh1qE6mW8yesVRV/dqu/hMxV7GEg3HAraO/eqYj4wLmXMaw+fEdlEFoabzjYZGLG+EcgyK/pFzVDIpAnNMhIZYc7DzOb10AGPe844OyIAjYwk2bq5FNhIjolQxxFEJCM5CDSrMnC1yD2vjLpbxZlo8zky7g0fNLgZHpsYE5a/AQ0NtExc4MOC9m8IVhGL+/tX4WM13c+NBTsFP4OZ3q1Wb95ZqAiweIPxqzMCFY3psdWbjddKmPbno+y1OCZF9CnGpVB4zKtVwQ1V8AmYNwZJzisku7z08hMhby1Z6RECO+zzI9/OAgPIoABaZxgEme/fTTYuYvWSBAxIlpmuQRG/yQSQmluNER8S8gRSiH/e7AV8/YUPodYR7+wk/I/ic7BzyLUHEAlz0pLxnI2yvjBDRmHYT1PFt/DX3HQIxQG8gYp9wQAG/ao34rvLD52FJAzQOZop7JBt8Cmcef04OKhUIGk79bdOgVbh/bcwz57U7VcWc6J5sGbAAgT2YHFOAtWpPmnvNJ/d3I6lY743MNS15WSQZSj9vXJ5ZIO5W1CB/NmZyQm0y3hJ738403OUwG7UIXJ31DU+5K6weq38lXvipMiWqoPVj+VwC90rEV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufOQu89+PbtcWvCRol/rHP/Qe4AOOZKkEfXZvXzVz2YKRzuWrhdC3qUpdgYA?=
 =?us-ascii?Q?XRzhYZRnfPnTZPP3XKPBmlco0h5x41mxMC4jCcOtV4H+Sog02FVEmR4vDtq2?=
 =?us-ascii?Q?6Fv9MFY3IkYshQT4FClt73QihfA9MMwRP1IH0M2NrOZyckOrOuxAvh21M/ci?=
 =?us-ascii?Q?SqUCXZTaBXBhO7qwzteVyptlFVigTtHeuBCUt2YExMtQf1u511EGoZHvwAWG?=
 =?us-ascii?Q?eo6X4PoE8xZg68n5phBbRBhe52vZkqRquhb4YpIX69MzBIRBEqCasKwCb5M1?=
 =?us-ascii?Q?LVOUaRlgRStRKY7FrJziXoWnZj5io7vcVeYRwFYRoGdUY2QlJoMze8Mh2O1i?=
 =?us-ascii?Q?SEjeSupdyywBWAnVTS3SNLUEsRiv7YXUjvpxYdctoROV2BckPi2AlhRymAqZ?=
 =?us-ascii?Q?7XkLxwjehz/3r+Uap45PBpUDQfWK6eoGDPf2zkWyuQT1QqtOSxC+Ym3KlSzF?=
 =?us-ascii?Q?JIRT/yuQrTDoXQrRdo8Ph1fvaBVIXef9TZAQFBSXVApVddvTG6T4rMbbOuVG?=
 =?us-ascii?Q?stS36gHAzzUQ0E73WcMSpxfRvpiL8r4s84/Yp+ILPUvkjDmrLrHUxM0ohzw7?=
 =?us-ascii?Q?MITKwpIusNRGpNUcjlV0TjpWdUawY8ADGSIGbKMq+2Wxm4EzQGSOUWklMI1W?=
 =?us-ascii?Q?GAMh4JxriKFtY6VNtKppi32tkknOLearwiAqW70O2BzHHdzyqOb+jOxmr2tz?=
 =?us-ascii?Q?hsxmWmRg7CrKdgJfarJRkHHhR2IIpB7M8RtfAGJVVeS6Of4qjfJRuv5cL0dw?=
 =?us-ascii?Q?kQIsRhP9mMVCLPqNcW41bWiUpwa8h/F+NoLg+SFnip4HRoLQ8fK4P7vmXyKp?=
 =?us-ascii?Q?2uWkQE+kf4pA7t/5Ae02Nv1LtwILh0srj92HNbSzgyD+uV+9JlBCXtDj351l?=
 =?us-ascii?Q?HWm5pneAKGhPHpb77BiLSzZR1DIxmjy9j1iOfVpwcorkhxI33tvIL48pbi8Y?=
 =?us-ascii?Q?DrYJa0b4q3qDTkPWSi8aVW23TXshCTnf3L2VHWoNRUiDwS5mgDGu62riHCq8?=
 =?us-ascii?Q?ym8qMdlzUuPWyA/LssDDA3l7KGrUjNU93FLrrggFMDvrX/pjkL0VaRv6pAQo?=
 =?us-ascii?Q?MatRP+ADpRfW1LpP/oKWb0zCC2IjmPnhEme9gcBoX+zSRHzY9Qovm6GaOpdS?=
 =?us-ascii?Q?j5SiTrI1IYik4QIwdepFB9AQlS9g7v5Ow81bGmM3xqBBHs8l6bm0L1n2jx67?=
 =?us-ascii?Q?kgcIzynpc81HZjXTLlwkoJP3EmYpbesFJ6UP5MGROnmyvaz/WC0VvvwI9sIF?=
 =?us-ascii?Q?1gZAj47jsT9ZCu6+rTbgBhWPlfPvpkVeVtgkykLx9YCp9+bb1tOdw2EdzWtk?=
 =?us-ascii?Q?k1S+1gRas27vAnjQZtkNYAoIMimoSK8O0Fx9IWNBJLLkHDPA2xY+Ot01X3Go?=
 =?us-ascii?Q?gHDscSHK4PgFXc3PZzaWs9CMNzbPm2BuuGAP+Bkf2x2NLgWoXO79l+vc5WEs?=
 =?us-ascii?Q?PywsKmnTXJC+kk5qpddqhNwo2DTEbMbed/3USW/st8vozROiwjIy7mz4z+f7?=
 =?us-ascii?Q?/vIf0EzTeS5GMAuPGGYiqX/pUE6MDCfi0eVh6+C/KOYEYifwPcLqC5ZObLiT?=
 =?us-ascii?Q?14bcwvw84IaKQB9J8eU5fWOhKDjSskV9QC6hPJ0mUa/3k50KJ0D5V2KOD6oV?=
 =?us-ascii?Q?ElZrs1DE+HxFxlOwBmDtU4LXSc7MQdHQPMR4wuUrJHzgsgq7qqxBlDTXNOPB?=
 =?us-ascii?Q?m0bFD3KiYnV1hZmtCIr7PL50cnGI004TG8sNNqo5GgN2DzCW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa751bff-4736-4a89-8c64-08dec1d87ee6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:52.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0CCHgvVC4f5Tp/rb/u7MVw+/2vlNZGKnGVhA3cs/TnfhJWKnzMlczF8TW4eB7RN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21721-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82AD263C30A

Jumping to mlx5_ib_reg_user_mr() without IB_MR_REREG_TRANS set will use
garbage values for start, length, and iova. Recovering the original mr
parameters for ODP and DMABUF to properly recreate it is too hard in this
flow, so just fail it.

Fixes: ef3642c4f54d ("RDMA/mlx5: Fix error unwinds for rereg_mr")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3b6da45061a552..35125bbb380c47 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1198,7 +1198,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		}
 		/* DM or ODP MR's don't have a normal umem so we can't re-use it */
 		if (!mr->umem || is_odp_mr(mr) || is_dmabuf_mr(mr))
-			goto recreate;
+			return ERR_PTR(-EOPNOTSUPP);
 
 		/*
 		 * Only one active MR can refer to a umem at one time, revoke
-- 
2.43.0


