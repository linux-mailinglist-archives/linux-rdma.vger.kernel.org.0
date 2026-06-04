Return-Path: <linux-rdma+bounces-21725-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XNWEDefUIGoz8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21725-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC93D63C336
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Jsu+DXYg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21725-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21725-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDCC8303CD3A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB626C3B0;
	Thu,  4 Jun 2026 01:28:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A619266B46
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536485; cv=fail; b=qjZs8zkcX4lfwk6PRTvILHT8zc43RX432lqsAc/PjUGd6m1z4htfVUgl1ZNPOf/7kgqrTkdXAdzuJ8YDeJxdr7C9F3YAef+S3v8m7l5FbKDleDsSGYYeIyIM4qbyA9BSwubw5cKQpz7kyFhgR6xRPfHX+0P8vIiHscxapNX1Xk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536485; c=relaxed/simple;
	bh=HxDOgAfZ12l9KlDVOZnOu7a0Y9nWJLzAiv3c6E6Ccn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FyKg/0uPXx1FqS/oJAq+0dH1sCHA16bgSW3d3nYhr+7AsduS1W+kxl1uvedtbDrJtduSQUsLhw1XM6DQ+lDRUZfBCx3+EzPOXAZT9E82k9ICKbbB2R+NqtT7rbrm5p2eRG5KsBfTiF5hQwy83+UGc4AuvyGl5v9UflBtaYVzTw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jsu+DXYg; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwS2Z6jj/HSN8Ie9puPV8K3txl+MIZseNogkxFHtOE7x7DEjeJNUjiX9KDHk4AuGYDpnEnn/JnZWZMhh5IcP0n5pF1+hCKcpTy6JKgfdZoLY/5chkDvK5X+eVfAY9q6E1zcK+CwfSatkOTrTFL+L3apXOxmKCNuLrgCaiokdxB5it8OQEnajrImDbA4zgYeXSdydElsmlmSEX5sp0jrydDJml6mZYOBySw3Xj0AEKUp9Q29pFrupOnS9x4rgOVwGHfOyg/djJakhvWYJG4dMAoBLNJnbi4MPAgfwjWgFgEcjLTiir7UUph7vpSKlFywhGkDs4qKsxmqUDaIBtNWBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP6vPx531s8GXGFTYUfbcNTqXJu+7Ia/wVgQEl0t5KM=;
 b=UkJECTojzQ8zS9CnzDJGe37hE6k7OJB8VNH6BWqBTzIC7QVLRkCwCqHlD/dib5aqW2JNOcocF40+ICWczLNbdepu0phkwFy/nvh6OhafId5uQU8/q407DzpCdLqUZtR0+eAtwu3Lz7Jy52NEGVgbAyKPT4SllGZ6CwTeSYF9kiJaReNRR5plSOTJS0Vmpxyldx9Vaxs9lKOZW+W/u2JqL/k8ucodWpPk/WBgxEjaiffhxi5S2Vg77BY0EvU6It8+IlfRL2Ma8Ph2oytG7pOteyb9l1dub78lqmjZTLpy1Vo63rxyZfcz78tKCBqVogQSOGDxApFOjVTEdheTQf/9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP6vPx531s8GXGFTYUfbcNTqXJu+7Ia/wVgQEl0t5KM=;
 b=Jsu+DXYg/bp8F+Q2JI0zCR93tvjmg+8UklVi8xGgpLNgKv0ON15meG9io7hbgLi8czAZztdO9pjMhp2rIaWXrefdDdVL7vxz54G6HlCpnZ4w+J9AeDcmwvEjL08eNrRPj/xzRBOxXPnrGvBFFzkC81IM+ssi8RO0AUtkgqtym94QQD5lglfgEWCTphrgnPOMEOcppZyL/k87vyUC+TF0kZbV4eVPkXJRSSBGd2Is3gwV3rk45EVHo+JdeDlI5ROMu/4HenB98s45NBij3jYmmw2wCTs8xdBVrNzjrjQH2F5KA5LYkN8WCHuzrn6BiFYWcFYGOfjf3LPZEcJvrzAZzA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:56 +0000
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
Subject: [PATCH 07/10] IB/mlx5: Don't mangle the mr->pd inside the rereg callback
Date: Wed,  3 Jun 2026 22:27:46 -0300
Message-ID: <7-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 74800c78-b219-41de-d9be-08dec1d8806f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	DikWLGBB9i7WovaE8ycm6NRJomo5NETczRnHrIDLXsyjIEyDu2RJZeMQLv9aBEZoatfNyn2Ookm76ulCgCEVNVtjwsndJZvpOoJ6fq7rGGS8kUrjz6AUNOKeZ0pLjFe8rLHUzK1UD1tqQSJCZZDhYp/hfBMrijjRHkmtbEsgfpzhZeyRQ9MoK4goSQn5iImfODqHR1VD8UFeTNz8Nv7HIWd333+qMpLTtTsr9oM5idbtkfYVBOqyFiSAUFN0jCaFkXwdDxQk/esC2V3k1pIKlOQJbdettllVtkgESdHI4gmRcy+NARbZuTw3BVJQZ6novoUUVKdaS7R0RReaVHfeGQuGrqn/ko9L4fVTY8QswJg1RG3spgAdgvMuwflaH8sqJjYMPbGYBefa4VHJLFhnyqzNc41YfnLnudSssRBaGOSoParMFiegp+ZoeqoCzAJXO8ZRzbZHYY/Px89yuS18JP9377FYcxHyKsSWASGBPGVrZgP5gNAUjGT297quTnd5xti2L0h6SPinLU/CGjexieKkPPK1LLRNjssF0krT3Nv8/YjAsFbNvUKP3Tflj28isxcsFz8ObBcD8Xl63tN4H235tJgkZSosdVVGa/rJZXVD6kC7GAsQmqqyCxAQwHi0LC1visumCoLPgLVnhrVqJ2uGaIw5V14PGPhz9hoRdo976o27uy4+b+PB7SoWSFPb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KP+qfp/ZdSdXx7dJ+pT/jGUf0DlKVZJS0RkJ043yywKbTYCKPY/tv8XFQuIw?=
 =?us-ascii?Q?m7tVNnqKZfLKYlZjL1yJL0s4tejKq47bY/yUzfC59IAx+FmloKoFqOpSBATo?=
 =?us-ascii?Q?tAQ+2ZHGWJnJo0JilHX+toaIPeoAGLytMMakq5y5YLxhp9A4KDebu3D7W4f2?=
 =?us-ascii?Q?o/ST9WlhDJrJDG9vJSF2Pp3lWCwz+RwLznk+1LEgPrT6x5InfWKi9UmWD4Qd?=
 =?us-ascii?Q?arFI5zEAmgm7f0t5WvTlu9VTiP+9ASHImgHlsKaL1cbpC+JiCGYbDJGtvMj5?=
 =?us-ascii?Q?PUKieYGGGoZAZRAEUWKsrYLYi2yqwKeALVYRfceaxrpcMtELf+GD9sBHWYNn?=
 =?us-ascii?Q?oTT2AwXUAdAaU+Z/0CIJGvLoKnHADEbSc3SKz+z5Ml3QIC/dB/El0JIbeVTW?=
 =?us-ascii?Q?bvDXQhXWgL2i4FxXjVnHgBlwdL8VJwjEVPPhaoXP0dbWkSl6SzJpE+Jqm51q?=
 =?us-ascii?Q?tpwgggxDENocDPiXzBXD6aUDFhMJaI/izXeKN7Bgc0ZAuzp3abbBWauUp+dn?=
 =?us-ascii?Q?LC7OmC7uq+rOBMzJNaSH2gWQCcGCguYrBh9zAFabyiCx1CYYKr1Sa7OWOSrj?=
 =?us-ascii?Q?8UpRszEj2zGvOf9cX1D8AkJdOLHVWGzbCg9A6FcHW1k9LEXH/fAamNOd6OJT?=
 =?us-ascii?Q?3jpmTL8w3G1wh34SXsl3EuUKbmSrs6oi3wiUSsey2T7BP+TnsXaEqHW5SdCV?=
 =?us-ascii?Q?I5JDd/3KRGkz+lHBI8HAtVsufBh2KUWC39jxlphNBdVuCodDj+PscE1e1JxK?=
 =?us-ascii?Q?0E7YGNuz86u48nRsyzODV5ezO7zftOcAVhMC2t/zTlYr4HncGvMD4gfFXOQu?=
 =?us-ascii?Q?E90QdQHlw48nnKdYq/jzcU7xQkXJHXXbhfLI+yrZoHmMQTVzVNrLuiJf4t6Z?=
 =?us-ascii?Q?rZYTZVbr/Fdjk+DvHPRfqDTdd217eyIndU5GGcd63GYCp35RVpKX6QIrKIG3?=
 =?us-ascii?Q?gQtdN5xq90zYIANL5L/i3OsSRv676qCXzEPrH81gzymXjcLrPHbqJkgtitME?=
 =?us-ascii?Q?h9nAoRqwGm034pBNIGX9sDTaqjwstJUVZwCQN9Xfe6i1kGbxW4tM99qElM5x?=
 =?us-ascii?Q?rev/3HQ4+GWcXBO4iC/QZuOvboPVXFFKd2I0t0FQcWg77AfO6zq+T9F71nF0?=
 =?us-ascii?Q?08kfLo/Dk8JuVzwt/ppvyfxlgup/btXPmymhwMtP5oKYNNbXOpC35MDkiecz?=
 =?us-ascii?Q?apij/JiCDQGuxt0FF4SG07Jcyp3UBplymNrVK5hqkSXSZte23lBBSFUFf7B1?=
 =?us-ascii?Q?rp3Ot5LmrdCnNYd/68wKB/p71cDFNpSffGhugg5HM9z21WyDByMqFHBIeLhF?=
 =?us-ascii?Q?6evNNHFhanLvITkMtj91Ldu63aD3R6PxkZs+PCKpyRmOzVjClu8p+OR/l5a1?=
 =?us-ascii?Q?ft5ZbpHfwgkClBFOHBFJyn3GZNrzL8mU8BOC1Q/6UMK5G60S34v3D11zBBvU?=
 =?us-ascii?Q?ihRAztV/w75tUAOV+az+UuT9pWQzogAU8INl9+42lxAuVFaLB7aTkbeaL/Sv?=
 =?us-ascii?Q?7kvd7bRipxelejCyvF5SX38OlS1ndKJvb2mkOdzCPYLtwbzcgDRU6tmeL6UM?=
 =?us-ascii?Q?IVFaW+QzDXVEIhrxR/oWdv0YnQx7SwPkajc+dB8c+lPbUSxz+i6IIxyXdu4z?=
 =?us-ascii?Q?xBdVc73NhNf8b7zK9NwP+bIc71eqQzfbayetIQIQ2Tzfka/RmUP7c33wzktL?=
 =?us-ascii?Q?xcNxGHwPJC5/6tCdUGuRItYuIzIlQRYX3nQBvsfd0148rK65?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74800c78-b219-41de-d9be-08dec1d8806f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:54.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbYFkuB63MWCnLuXUh5GehgMTYjxw8+wg3+h3BSC9gFjd0D2oFSrmXCzw5ijM/pa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21725-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC93D63C336

The rereg protocol expects the core code to change mr->pd and synchronize
that change with the atomics and syncs. The driver should not touch it.

mlx5 needed to update it in umr_rereg_pas() because
mlx5r_umr_update_mr_pas() required the updated mr->pd to build the
UMR.

Simply switch mlx5r_umr_update_mr_pas() to use the pdn directly from
the new pd and remove the mr->pd update.

Fixes: 56e11d628c5d ("IB/mlx5: Added support for re-registration of MRs")
Assisted-by: Codex:gpt-5-5
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index a7924e96c2817a..a56443b9053734 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1134,10 +1134,8 @@ static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 	if (err)
 		return err;
 
-	if (flags & IB_MR_REREG_PD) {
-		mr->ibmr.pd = pd;
+	if (flags & IB_MR_REREG_PD)
 		upd_flags |= MLX5_IB_UPD_XLT_PD;
-	}
 	if (flags & IB_MR_REREG_ACCESS) {
 		mr->access_flags = access_flags;
 		upd_flags |= MLX5_IB_UPD_XLT_ACCESS;
@@ -1147,7 +1145,7 @@ static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 	mr->ibmr.length = new_umem->length;
 	mr->page_shift = order_base_2(page_size);
 	mr->umem = new_umem;
-	err = mlx5r_umr_update_mr_pas(mr, upd_flags, mlx5_mr_pdn(mr));
+	err = mlx5r_umr_update_mr_pas(mr, upd_flags, to_mpd(pd)->pdn);
 	if (err) {
 		/*
 		 * The MR is revoked at this point so there is no issue to free
-- 
2.43.0


