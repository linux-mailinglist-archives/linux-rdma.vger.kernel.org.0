Return-Path: <linux-rdma+bounces-21722-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1oTWCqbUIGoe8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21722-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C363C307
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rFAl0qHT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21722-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21722-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01058300E00E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B50261B8A;
	Thu,  4 Jun 2026 01:28:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9825B098
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536482; cv=fail; b=Tv8xDvdhGMGnWEgXRHPScptTdMIp/0hsd7ubktsC1R6fuyzOgt8RTU0LquGzVTGHNFM8V3ZtVP4IbhbnAF8kAXafPWV+SgYkTQJNtFoPPx/M8JyPu/d0VD9HrcnAt5WEQ6XIDyJoV8hAnw563ImoB0hBd33e2g9/cDVakIFpUkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536482; c=relaxed/simple;
	bh=hwUUnfJfMUs8BPcgPLM1hL8a6LDdHPl92B+ORy7X9zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnlt8SOL1knXh44rZYq24TVmiOMk7AqS7dY6AV8JoZHCdukxZVOi4tTne+QwPhUOiv9+Fg+tkyJHEu1Ypa+UizkjpQowSjVnPLztx/UqZph4/Mh8pe1g2kliN4Aj4oCcIfEJasYFOPxrYJdk2+BLSw9Y8G35nQk0RVM/caRTP/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFAl0qHT; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiHfNn3n2KJ/o84+a6a1gPEHdg2w6b/LiSfaKvxYVPWVx8Itp7Mb4vGtJBGN7ItkoU2cMMSceMUdygL8/Vfytb3XHyh84xhzf9Cf5fEXzZmCQZtbv2h0naCV4ndBBWckPL0lMbScryD1jKnXUx2J0uOaJKnq+CJ+QgSJkxtbIG2ytLaZz0Ldtr1Nt3uHrSTFcyXFcgOo7qGYEb6K0xrw9xt8QtDWqF13+WeF6mkRa+YugszliwT7yntq3bkMBejLwXV8NBJcfdkiaByYx0xRBr2Z6mLrzlsJ3MKrKinZnUearOM09HwGm62ROM+oDrtiqNGQjQzJP/uh4HPrvd1h9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7n5m2O5svPhx99oFd2KADsmzAj98LMMHU98zfj8nh8=;
 b=n2dSMPVgNJDGlsyVS4OWfzJsizB1wdSZjqjbwxQ+p+Yo5E6eN8kw+OBTDo3z+l87A84P15EvHv7j6jrhbmjCIjfEcMg40OYEv/zhev/aAwPD3V2h1rxN1TSy4Qv7GWRVHyXjhNffue3nImkXycxrPSquUt6HqbwBOwUQe8U63xq0dkJAiHmWVJ/bQYcprAUKbDmv8edHOuW4IiASCPKKpOvr20vqsI5KzBJdYtad//raWOGMRhiqYYMaVaotJGBLZK1TzX+s9pEaYibg7xXOXGCNIUfhzd9t23vjtsTMP9b19lRIuUP2imVAJgqmZ0K4uFNHvvM5lSbbGb76mz2F7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7n5m2O5svPhx99oFd2KADsmzAj98LMMHU98zfj8nh8=;
 b=rFAl0qHT/r/FRxO+bfPDoiZpR9m+fMUVMaPV7Wh005AEwJto7O5J7z43iPtPrmqzJD7lMbbIUQcrd5EzLZwVxa/lXG4OIcRAgtI65XASxqAXR+v4ayouoHoJRDzqP3wQ1WLzMwdOgG0rWw/dBt2S8MZdMROur6prmdmYEztFvAt31x//DQcyhxmu+ObD5RfviAB1cGKvWa1m5SumGpD/oVhyxi5cAmNHVoRvrWAW2E2eDuqawvHgkz5yKa5AvAhevmAD2ioDh8l7vN5LZo2Jf9vXRjH7XS9kp0Docjx1hMBPYQvy46Hy1jgv21MpJiLfGf8PFSnEWvl8FVgvKWlCUA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:57 +0000
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
Subject: [PATCH 06/10] IB/mlx5: Pull the pdn out of the depths of the umr machinery
Date: Wed,  3 Jun 2026 22:27:45 -0300
Message-ID: <6-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0053.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 579ef4c9-bd2f-4635-1284-08dec1d8806e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NAeRzDqxtKCGunECx8gW5Iv8T96mkVRU8ch6lzf4P4wBMN5yizdosWszjpvFK+vUgpf8LiFpdC983GHV6aNrIGZXn7tFVYqCdSTrpG61K6npin5vKIolHVberxpB8g6fPaH7Vw0HgGdaFRDiJfjZeYUqw6TyO5E0lWUIutZ1zKpzYa+5MrqtSIrdMgFiSJVCLaqCkyTQ8ZQFvHCqIGrfxpABY37FXOZfdP6Vo8pS2Upf66S7ayr4Ezexo62GZ9PCgHrqJFBERlmQcsx/XDHJ4ljP/Ub6dr9w0NgIT9y546nKkG/sYVYdeaJ7EhvYavBM33TrRlKUkNXqJjPY6mXGoGRtJWTIjcz39QC1K8jBKkqdujwqJRozb4nMC59Pn48m8dmRezfCM8FVHOSWdvoR3tJKG+qcmp3R21pnq24U4pi6qqN0dBRI4wev3pdD6CCBHvcME50Y3nNlWeRTBOaxVwXZsQZ2SAiTpdWQNqH/MQ/9wu3Ubeh7pGHj64GJEnURirZusWmM601TMa4IFGroUtk5/1A7i8vVKgqiAy1wKzy9llt5oDJzr3ZUIq5nO6SCsRg2wuUo+Tfd+pNPy2rfAXa+dw/PD0fC3UbT6s4xaY4gmQr+34qF/ot5rNahj8/Vqi1/u97aj7LXUSf+xJkKp6scKg4jE+5p3MKdcVTAZMee62bvOXJNhNEvXP8+WbV5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PwAF7kMhiOOR8JJu2uz2NAvYz/1NGDS9ogv3QVQ/W1iRAfWcOi53uDKM/xBf?=
 =?us-ascii?Q?oLuLJIWgjS7siW5tLeFaTcqL77ZsVY3TaLRSwBRAQketNVSzi/Jcl4xoMNAL?=
 =?us-ascii?Q?5gY7RNyQE98GABo89+TDkYN5nRSCbN3v70v8U9Sq6FphNM9zutbGjG3NkBCF?=
 =?us-ascii?Q?EFDsdB6xJ5RDdVZi41Ra7lLoZ5fwKxOaBNjgFOBdEuVlwIWO3JUuw3t88jxi?=
 =?us-ascii?Q?Ghv2Fq5V/qZfVcsOJ6lpkBuWq96YN7M6ZYneTp6PONip2dgBaby/66+ETcZC?=
 =?us-ascii?Q?dlh4i1FthIu7Khp4t+UXyKyY9JmL8ardRt8HMcZC1eZl1Gh6gGDJcuaLsSzW?=
 =?us-ascii?Q?xp9zoC0/5/tmcn36QilhLMXpktLalHDn2Q6VVEybs7iUeu2CVOFpOOgiSgQ8?=
 =?us-ascii?Q?geKCXI0X9Dr7ml2Vf0JkSwk7+hrIW+BX4oDp1om1ggawhayOz+5KP4wW9Iih?=
 =?us-ascii?Q?TocQMxDnyoq2gQ/rczR5viO3xAFonPUYVMiUVzv3SIk4aa/KWwHHnfJ1IRLi?=
 =?us-ascii?Q?LBbx28iDUp1fyPar2tQNj/Kx2z6FSgZsHja2xBzDG5fsXDCk8MaqXMPN3r/p?=
 =?us-ascii?Q?Qxbei2BVmn5ud3TCMOUNTVD2QTZLCKTKweTpRbEd5g4WjmdC6YFOpqETXfyU?=
 =?us-ascii?Q?vVVD+tPi2BS0RTQgH9KSz/OEtQ/OIIn21J2idNNyJHIJFHDzBeRPtIHAV2ly?=
 =?us-ascii?Q?i85YlR7IX+mTiHnz+tabJ3LEIfa8ZshG559cVIJGDaU6SlCDlL5pnSz4Pfrw?=
 =?us-ascii?Q?MknWcLg0hz0TKy05/hga3XBgNafuoG7Jrc+4F3ZBiNJaDnlF1QY/o6ZZsHvQ?=
 =?us-ascii?Q?SC/YK6qlaOUcgL9uxTHM6hhn6fIbFzAJUYMPBDIeCT5mABR8EGcEU8wf4/Pv?=
 =?us-ascii?Q?CtnvSWqRC+dYfmOjSxBmjsCG6mJX/sD4zf0T+7XPpQC0Ini8Er/Uw9RB9ntb?=
 =?us-ascii?Q?Lyc4Qg59Zudzv5lYcr6VuZXltNAbpw44+vnM2JZji+/2j0E5ehg8JkvRzpfF?=
 =?us-ascii?Q?tQVvKiNCy1GaSJay29yH8KN3dLyCfq9+zDDbC9+ouLK41gYGcRcIqXmDKj+x?=
 =?us-ascii?Q?xVJ14gN7dQ8qGvqMW/vmJajdXko/6j7UUSGzJEZDrBYrxYX4UKn6i74NQP4n?=
 =?us-ascii?Q?AvzSG/46uAfCnedT5SStdhKnuTajds9istSjj5EjESUOOL2rqayyleksvMq7?=
 =?us-ascii?Q?r6VYDrhLcL6wpU4OAlPSulpV8SEGWP18/VmX+aWnBcGilEGalSmomXeypu9q?=
 =?us-ascii?Q?GtO4j5P80HigPv1TMbIi9g72vDiL2uf7toVz4Ff5Jt9cp9vMCWhAnAe43Ooc?=
 =?us-ascii?Q?KC5egg6gZXYMJ0Q1SoVvfcP+lV+xL5zSTfZ4A9GYzpMIYFJs2K8vCwjB1FjS?=
 =?us-ascii?Q?HyZZVU2pl/3xe6xPNfTXK5eDemzJsb7uqW/Wj8Dqin4qjLk54HL/+qCf3uhv?=
 =?us-ascii?Q?oBKedwHoSzcAjbRWdOwK1XuzfSfjBe6wq/5WZ67mno2xGTCgpTHsEHQ3tEg8?=
 =?us-ascii?Q?DtqKJajwBtc+N3rujYN6bX+gmVZISYaQwB8fdKp1gA/Rjl5ICPeoV+eWE5Ms?=
 =?us-ascii?Q?v0jsmpndmJo8suj2++RTJtDCTA3V2/iS1YoeNCq9+GtRGEpi/gaeM3QzwyTJ?=
 =?us-ascii?Q?zfzraHWiWYgOq9yH5lt9heBodTilrd9sXjdVtBQgwSQld7zAZGHvSS+4o5o4?=
 =?us-ascii?Q?bQOMzqF4rMGCkc4nGKXI98P7gyCW3FEavlSZtXN/2rESmgpv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579ef4c9-bd2f-4635-1284-08dec1d8806e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:54.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxfemmi+M4mkxBh/O9KSHKWlfizDgSwdoUYoggm+OknIxm30HGWw735Z1oQCBeyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21722-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B75C363C307

Instead of getting the pdn deep inside the umr code, pass it in from the
top. to_mpd(mr->ibmr.pd)->pdn is not safe due to the rereg races, so all
the call sites need some revision to obtain the pdn in a safe way.

Mark them with mlx5_mr_pdn(); following patches will go through and remove
these.

Cases where the XLT flags are known and do not require the PDN can pass 0,
such as for mlx5_ib_dmabuf_invalidate_cb().

Also extract the DMABUF data_direct special case from inside the UMR code
and into the only place that needs it, pagefault_dmabuf_mr(). The actual
mr was created directly without using the UMR flow. Ultimately this will
be moved into mlx5_ib_init_dmabuf_mr().

Assisted-by: Codex:gpt-5-5
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 ++++
 drivers/infiniband/hw/mlx5/mr.c      |  8 +--
 drivers/infiniband/hw/mlx5/odp.c     | 12 +++--
 drivers/infiniband/hw/mlx5/umr.c     | 75 ++++++++++++++--------------
 drivers/infiniband/hw/mlx5/umr.h     |  6 +--
 5 files changed, 64 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e156dc4d752996..0a2b8ede0d818a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -331,6 +331,10 @@ struct mlx5_ib_flow_db {
 #define MLX5_IB_QPT_DCT		IB_QPT_RESERVED4
 #define MLX5_IB_WR_UMR		IB_WR_RESERVED1
 
+/*
+ * A valid pdn is required when flags include MLX5_IB_UPD_XLT_ENABLE,
+ * MLX5_IB_UPD_XLT_PD or MLX5_IB_UPD_XLT_ACCESS.
+ */
 #define MLX5_IB_UPD_XLT_ZAP	      BIT(0)
 #define MLX5_IB_UPD_XLT_ENABLE	      BIT(1)
 #define MLX5_IB_UPD_XLT_ATOMIC	      BIT(2)
@@ -1209,6 +1213,11 @@ static inline struct mlx5_ib_pd *to_mpd(struct ib_pd *ibpd)
 	return container_of(ibpd, struct mlx5_ib_pd, ibpd);
 }
 
+static inline u32 mlx5_mr_pdn(struct mlx5_ib_mr *mr)
+{
+	return to_mpd(mr->ibmr.pd)->pdn;
+}
+
 static inline struct mlx5_ib_srq *to_msrq(struct ib_srq *ibsrq)
 {
 	return container_of(ibsrq, struct mlx5_ib_srq, ibsrq);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ab0ba34448eb89..a7924e96c2817a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -781,7 +781,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		 * configured properly but left disabled. It is safe to go ahead
 		 * and configure it again via UMR while enabling it.
 		 */
-		err = mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ENABLE);
+		err = mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ENABLE,
+					      to_mpd(pd)->pdn);
 		if (err) {
 			mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 			return ERR_PTR(err);
@@ -890,7 +891,8 @@ static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
 	if (!umem_dmabuf->sgt || !mr)
 		return;
 
-	mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ZAP);
+	/* MLX5_IB_UPD_XLT_ZAP does not change the pdn */
+	mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ZAP, 0);
 	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 }
 
@@ -1145,7 +1147,7 @@ static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 	mr->ibmr.length = new_umem->length;
 	mr->page_shift = order_base_2(page_size);
 	mr->umem = new_umem;
-	err = mlx5r_umr_update_mr_pas(mr, upd_flags);
+	err = mlx5r_umr_update_mr_pas(mr, upd_flags, mlx5_mr_pdn(mr));
 	if (err) {
 		/*
 		 * The MR is revoked at this point so there is no issue to free
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 10c11b72f41247..d7feb49b28fbac 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -833,12 +833,14 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 			       u32 *bytes_mapped, u32 flags)
 {
 	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
 	int access_mode = mr->data_direct ? MLX5_MKC_ACCESS_MODE_KSM :
 					    MLX5_MKC_ACCESS_MODE_MTT;
 	unsigned int old_page_shift = mr->page_shift;
 	unsigned int page_shift;
 	unsigned long page_size;
 	u32 xlt_flags = 0;
+	u32 pdn = 0;
 	int err;
 
 	if (flags & MLX5_PF_FLAGS_ENABLE)
@@ -857,8 +859,12 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 		err = -EINVAL;
 	} else {
 		page_shift = order_base_2(page_size);
+		if (mr->data_direct)
+			pdn = dev->ddr.pdn;
+		else
+			pdn = mlx5_mr_pdn(mr);
 		if (page_shift != mr->page_shift && mr->dmabuf_faulted) {
-			err = mlx5r_umr_dmabuf_update_pgsz(mr, xlt_flags,
+			err = mlx5r_umr_dmabuf_update_pgsz(mr, xlt_flags, pdn,
 							   page_shift);
 		} else {
 			mr->page_shift = page_shift;
@@ -866,8 +872,8 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 				err = mlx5r_umr_update_data_direct_ksm_pas(
 					mr, xlt_flags);
 			else
-				err = mlx5r_umr_update_mr_pas(mr,
-							      xlt_flags);
+				err = mlx5r_umr_update_mr_pas(mr, xlt_flags,
+							      pdn);
 		}
 	}
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 062a47d0c991b7..f92f222b899f8d 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -603,11 +603,11 @@ mlx5r_umr_set_update_xlt_ctrl_seg(struct mlx5_wqe_umr_ctrl_seg *ctrl_seg,
 
 static void mlx5r_umr_set_update_xlt_mkey_seg(struct mlx5_ib_dev *dev,
 					      struct mlx5_mkey_seg *mkey_seg,
-					      struct mlx5_ib_mr *mr,
+					      struct mlx5_ib_mr *mr, u32 pdn,
 					      unsigned int page_shift)
 {
 	mlx5r_umr_set_access_flags(dev, mkey_seg, mr->access_flags);
-	MLX5_SET(mkc, mkey_seg, pd, to_mpd(mr->ibmr.pd)->pdn);
+	MLX5_SET(mkc, mkey_seg, pd, pdn);
 	MLX5_SET64(mkc, mkey_seg, start_addr, mr->ibmr.iova);
 	MLX5_SET64(mkc, mkey_seg, len, mr->ibmr.length);
 	MLX5_SET(mkc, mkey_seg, log_page_size, page_shift);
@@ -670,23 +670,22 @@ static void mlx5r_umr_final_update_xlt(struct mlx5_ib_dev *dev,
 	wqe->data_seg.byte_count = cpu_to_be32(sg->length);
 }
 
-static void
-_mlx5r_umr_init_wqe(struct mlx5_ib_mr *mr, struct mlx5r_umr_wqe *wqe,
-		    struct ib_sge *sg, unsigned int flags,
-		    unsigned int page_shift, bool dd)
+static void _mlx5r_umr_init_wqe(struct mlx5_ib_mr *mr,
+				struct mlx5r_umr_wqe *wqe, struct ib_sge *sg,
+				unsigned int flags, u32 pdn,
+				unsigned int page_shift)
 {
 	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
 
 	mlx5r_umr_set_update_xlt_ctrl_seg(&wqe->ctrl_seg, flags, sg);
-	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe->mkey_seg, mr, page_shift);
-	if (dd) /* Use the data direct internal kernel PD */
-		MLX5_SET(mkc, &wqe->mkey_seg, pd, dev->ddr.pdn);
+	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe->mkey_seg, mr, pdn,
+					  page_shift);
 	mlx5r_umr_set_update_xlt_data_seg(&wqe->data_seg, sg);
 }
 
-static int
-_mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd,
-			 size_t start_block, size_t nblocks)
+static int _mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags,
+				    u32 pdn, bool dd, size_t start_block,
+				    size_t nblocks)
 {
 	size_t ent_size = dd ? sizeof(struct mlx5_ksm) : sizeof(struct mlx5_mtt);
 	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
@@ -720,7 +719,7 @@ _mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd,
 
 	orig_sg_length = sg.length;
 
-	_mlx5r_umr_init_wqe(mr, &wqe, &sg, flags, mr->page_shift, dd);
+	_mlx5r_umr_init_wqe(mr, &wqe, &sg, flags, pdn, mr->page_shift);
 
 	/* Set initial translation offset to start_block */
 	offset = (u64)start_block * ent_size;
@@ -811,7 +810,8 @@ int mlx5r_umr_update_data_direct_ksm_pas_range(struct mlx5_ib_mr *mr,
 	    !(flags & MLX5_IB_UPD_XLT_KEEP_PGSZ)))
 		return -EINVAL;
 
-	return _mlx5r_umr_update_mr_pas(mr, flags, true, start_block, nblocks);
+	return _mlx5r_umr_update_mr_pas(mr, flags, mr_to_mdev(mr)->ddr.pdn,
+					true, start_block, nblocks);
 }
 
 int mlx5r_umr_update_data_direct_ksm_pas(struct mlx5_ib_mr *mr,
@@ -821,12 +821,13 @@ int mlx5r_umr_update_data_direct_ksm_pas(struct mlx5_ib_mr *mr,
 }
 
 int mlx5r_umr_update_mr_pas_range(struct mlx5_ib_mr *mr, unsigned int flags,
-				  size_t start_block, size_t nblocks)
+				  u32 pdn, size_t start_block, size_t nblocks)
 {
 	if (WARN_ON(mr->umem->is_odp))
 		return -EINVAL;
 
-	return _mlx5r_umr_update_mr_pas(mr, flags, false, start_block, nblocks);
+	return _mlx5r_umr_update_mr_pas(mr, flags, pdn, false, start_block,
+					nblocks);
 }
 
 /*
@@ -834,9 +835,9 @@ int mlx5r_umr_update_mr_pas_range(struct mlx5_ib_mr *mr, unsigned int flags,
  * Dmabuf MR is handled in a similar way, except that the MLX5_IB_UPD_XLT_ZAP
  * flag may be used.
  */
-int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
+int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, u32 pdn)
 {
-	return mlx5r_umr_update_mr_pas_range(mr, flags, 0, 0);
+	return mlx5r_umr_update_mr_pas_range(mr, flags, pdn, 0, 0);
 }
 
 static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
@@ -861,6 +862,7 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	size_t orig_sg_length;
 	size_t pages_iter;
 	struct ib_sge sg;
+	u32 pdn = mlx5_mr_pdn(mr);
 	int err = 0;
 	void *xlt;
 
@@ -895,7 +897,8 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	}
 
 	mlx5r_umr_set_update_xlt_ctrl_seg(&wqe.ctrl_seg, flags, &sg);
-	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe.mkey_seg, mr, page_shift);
+	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe.mkey_seg, mr, pdn,
+					  page_shift);
 	mlx5r_umr_set_update_xlt_data_seg(&wqe.data_seg, &sg);
 
 	for (pages_mapped = 0;
@@ -962,17 +965,18 @@ int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
 	return err;
 }
 
-static inline int
-_mlx5r_dmabuf_umr_update_pas(struct mlx5_ib_mr *mr, unsigned int flags,
-			     size_t start_block, size_t nblocks, bool dd)
+static inline int _mlx5r_dmabuf_umr_update_pas(struct mlx5_ib_mr *mr,
+					       unsigned int flags, u32 pdn,
+					       size_t start_block,
+					       size_t nblocks, bool dd)
 {
 	if (dd)
 		return mlx5r_umr_update_data_direct_ksm_pas_range(mr, flags,
 								  start_block,
 								  nblocks);
 	else
-		return mlx5r_umr_update_mr_pas_range(mr, flags, start_block,
-						     nblocks);
+		return mlx5r_umr_update_mr_pas_range(mr, flags, pdn,
+						     start_block, nblocks);
 }
 
 /**
@@ -986,11 +990,9 @@ _mlx5r_dmabuf_umr_update_pas(struct mlx5_ib_mr *mr, unsigned int flags,
  * Return: On success, returns the number of entries that were zapped.
  *         On error, returns a negative error code.
  */
-static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
-			       unsigned int flags,
-			       unsigned int page_shift,
-			       size_t *nblocks,
-			       bool dd)
+static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr, unsigned int flags,
+			       unsigned int page_shift, size_t *nblocks,
+			       u32 pdn, bool dd)
 {
 	unsigned int old_page_shift = mr->page_shift;
 	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
@@ -1030,7 +1032,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 	 */
 	if (*nblocks)
 		mr->page_shift = max_page_shift;
-	err = _mlx5r_dmabuf_umr_update_pas(mr, flags, 0, *nblocks, dd);
+	err = _mlx5r_dmabuf_umr_update_pas(mr, flags, pdn, 0, *nblocks, dd);
 	if (err) {
 		mr->page_shift = old_page_shift;
 		return err;
@@ -1055,6 +1057,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
  * entries accordingly
  * @mr:        The memory region to update
  * @xlt_flags: Translation table update flags
+ * @pdn:       Protection domain number
  * @page_shift: The new (optimized) page shift to use
  *
  * This function updates the page size and mkey translation entries for a DMABUF
@@ -1074,7 +1077,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
  *
  * Returns 0 on success or a negative error code on failure.
  */
-int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
+int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags, u32 pdn,
 				 unsigned int page_shift)
 {
 	unsigned int old_page_shift = mr->page_shift;
@@ -1083,7 +1086,7 @@ int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
 	int err;
 
 	err = _mlx5r_umr_zap_mkey(mr, xlt_flags, page_shift, &zapped_blocks,
-				  mr->data_direct);
+				  pdn, mr->data_direct);
 	if (err)
 		return err;
 
@@ -1096,10 +1099,8 @@ int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
 		 * the page size in the mkey yet.
 		 */
 		err = _mlx5r_dmabuf_umr_update_pas(
-			mr,
-			xlt_flags | MLX5_IB_UPD_XLT_KEEP_PGSZ,
-			zapped_blocks,
-			total_blocks - zapped_blocks,
+			mr, xlt_flags | MLX5_IB_UPD_XLT_KEEP_PGSZ, pdn,
+			zapped_blocks, total_blocks - zapped_blocks,
 			mr->data_direct);
 		if (err)
 			goto err;
@@ -1108,7 +1109,7 @@ int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
 	err = mlx5r_umr_update_mr_page_shift(mr, mr->page_shift);
 	if (err)
 		goto err;
-	err = _mlx5r_dmabuf_umr_update_pas(mr, xlt_flags, 0, zapped_blocks,
+	err = _mlx5r_dmabuf_umr_update_pas(mr, xlt_flags, pdn, 0, zapped_blocks,
 					   mr->data_direct);
 	if (err)
 		goto err;
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 59809d4d7d7297..99192ec67957c7 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -101,13 +101,13 @@ int mlx5r_umr_update_data_direct_ksm_pas_range(struct mlx5_ib_mr *mr,
 					       size_t nblocks);
 int mlx5r_umr_update_data_direct_ksm_pas(struct mlx5_ib_mr *mr, unsigned int flags);
 int mlx5r_umr_update_mr_pas_range(struct mlx5_ib_mr *mr, unsigned int flags,
-				  size_t start_block, size_t nblocks);
-int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
+				  u32 pdn, size_t start_block, size_t nblocks);
+int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, u32 pdn);
 int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 			 int page_shift, int flags);
 int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
 				   unsigned int page_shift);
-int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
+int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags, u32 pdn,
 				 unsigned int page_shift);
 
 #endif /* _MLX5_IB_UMR_H */
-- 
2.43.0


