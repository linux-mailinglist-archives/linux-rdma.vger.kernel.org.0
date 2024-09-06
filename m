Return-Path: <linux-rdma+bounces-4788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9596E9C7
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 08:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BC81C216EF
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 06:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C513BC0E;
	Fri,  6 Sep 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Xz1hvI15"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC553B1A2;
	Fri,  6 Sep 2024 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603129; cv=fail; b=kq5yebI4QjUAWr13aJjewjlE9LiX/yzcCn/geHxZAzjkzHWX+V50YdaLzAeOiwj1lpIj2WWTJdgrurOyaI4TuiQfm+UdA5hiv6/XDxd6w2jt9UgrLNu47IDMrbto+Kk9f9iAcyux/SPJjJ5vy58PNsvtxprtUPvxyrGCGcf1700=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603129; c=relaxed/simple;
	bh=ZrR8gGTPNeGYbxcvLpWUb23AYu6bdkrBawddl9DF5pk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uU0tmZ3CF5PDU/f85PDSHLYEaUVZ2WTAhbEWpy7Zt9nPVvKR41hgQXiudHERsvcyELlcIyrrPY9nYgta7ngSeyLTzD+07XbfyI8hNLoVlEwcmeHfyxdywp2Im8mLShA/59VLcR73oJgmgZSRFVBl0kHakHDaYi4WgkH1f6AO2CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Xz1hvI15; arc=fail smtp.client-ip=40.107.243.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKrfin2+tZYm7WhX1ECtGsmNzembmZz1n6VyGmyOYdF4XZsz2tR+vGOWKNamhMKmaeQQ3/eU9H4FApJZOgZOOsKJuYmheBWVi4j287SFXryh8WPUbnlEiDnzBYQFRHNT9h3WqHCk5tnc9zYUvf6Si6i1ycs1qnEmT46emDb396ItfIFMpCnF6yNYJppDjE5kJmuDeNtZ2+qMyCHALNAQHATfUtodQ4OqHSzdbPl8Q5aIUzNH++nEQYKjnkOFfxOzl/YbwOeDmPemzLZKaBnbQN87smOWYn3KjmZsfmZdKLzpxU3CW4CjcjHA7di7PVeqFj2I4ax5jAuKh7U4BodeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t8gyHvq9gyLlczE/uXc8bSJoDLL314D8OnSoXfVKnE=;
 b=bx27snXbQJc8FXU70m3MUjtlCVQk//mqir9vf2CenXjBIN+W6pPOr626+FjBAQ79OetE6oqtz2tWJiBTwVotR7y9aCBxnwWHULMldf6Z+SLGqZBEGdugU0+cRLwl3AAQmVLeBU90qN218clqD0eR43+3TvPLVzY0Ltx3ZnS+yru5Q18rYFzrLuvGl+PLKGcmA1bj5jSvLTVtz4gLRJ2zp7gBNxk4n28aP34zMSPRvgUXv4lkTtrvHy52dEGbCH/bedj6mRU5OrLWq6MDUofC5fVGevl2t0hZXGOy8pzPp0Tfl9u0PzZkYZpu6LkUjpUyxxpshGL6umTf1x6NfAW1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t8gyHvq9gyLlczE/uXc8bSJoDLL314D8OnSoXfVKnE=;
 b=Xz1hvI15Q14hHgzVJX9HXdLNBMVLscdq7lu7JwVTfWN3bniIVa+8/MpTUefN/qZIGGt/MJq0IzjdA+XOWwaZm8dVWRRpVItxv01wiJEGJJkB2kvf+mTrkeuVUKrz72N/4JwarwsZe0AMr2EayHPyaFurew/cmwhPTFfHgEqXoGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 SJ2PR01MB8077.prod.exchangelabs.com (2603:10b6:a03:4f3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 06:12:04 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:12:04 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	cl@os.amperecomputing.com,
	shijie@os.amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH] net/mlx5: Node-aware allocation for mlx5_buf_list
Date: Fri,  6 Sep 2024 06:11:15 +0000
Message-Id: <20240906061115.522074-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|SJ2PR01MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3381ad0b-c5f4-407d-c3fa-08dcce3ad3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIS/0SlyntQQpUuPiCACScuuwbuiO32WBiaF5s3ok8klPgsDJXzcfpIm6SdH?=
 =?us-ascii?Q?vB4c74g1zfzDZtRutt3LSjsjHQDpZy/V/lWP23RXjVvF1m/gEfXCS3qXet7s?=
 =?us-ascii?Q?hGglZzoAC8UHLsvt7chSIgR1EMfL8lUQs93DI9gHKZlQMV4yuVVwoPD4KVjD?=
 =?us-ascii?Q?5DDP1GYtXQpZgQeM0BvRylSHLp6+9n+Mr67hL8LW/P1nbxvQBCBDdcp/p+xO?=
 =?us-ascii?Q?oHXyIukpQrHcVbBKjV6wolQSL5p3srzkjiD8TjvnpAydlq8RzQQg4UyxzsL4?=
 =?us-ascii?Q?1yvSfMTx0bGqLAUUkH74Mqg2FPxo77OABJPmXYDeb9YO5uO5amM5vPEk6cQ0?=
 =?us-ascii?Q?qejlZFXAe+vIaYoxSMzWfnPu9Uh5AR0JEVyv2XHQtrYSB2CANDCHyKovUv6n?=
 =?us-ascii?Q?4CkWQmtb78lqak/gyLu1vaDvZ0j3MzRTJ7fDTlbGbhiKkgueAYomyi7WGaLG?=
 =?us-ascii?Q?lW3rcTQvw3V5RYWajmUyCm5bodow6g6xUmdZ/SpjKBBwPkrZLzRV7ukIatZi?=
 =?us-ascii?Q?1nanoDYKb5WBwTRxiSrwzUBNiZ6KDHBPnXiBEoUDKSgYcLHgz+Dz1N2AmLiT?=
 =?us-ascii?Q?7o/isFFEJ93SngpMVI1sOJu6i7fh2ZY3XorMvGyxT/dks+G2KxKPcJwmW9o4?=
 =?us-ascii?Q?3aIh7Ix3A/TbQ1m0SssdRAMEAIHZRT7oIt7jZ9JkduPFx9gWJjdLwO6Eiafe?=
 =?us-ascii?Q?uKq6n1BrYkfR4LCfGtr7c6a+NfVRFyKRRMHGJWCyEfF27h9uziucEQG3KFfN?=
 =?us-ascii?Q?j6sNjTbSWQwU5/hXGwLPbmKnLGt/iDK1VPOtnfnVMM/Fy/XH0E+fuy9p9EFs?=
 =?us-ascii?Q?Tu9zXgPuSMdrchdbfOcai9uaXMfs38wN0oWObfgT6RWRqVMCKE7t6o9ahVUb?=
 =?us-ascii?Q?FlkPAtHlLzfz7dKkB9n+OH0uaWIaCG0I6bjbRnC43KVD8/bQbw2U7+SaXpxv?=
 =?us-ascii?Q?ON99NtuR7lheR220P1j7D3Psu0UaCQ6UuARqEPCssqIwLVrkS//U4Ls2tjCd?=
 =?us-ascii?Q?8+ku69nbhRLynavgsdAENuOyQ/Gz+P7BWSWY4mXAwblwM5BZh3gPe+IsCNzu?=
 =?us-ascii?Q?HXGKzbap2946zBMBeUYKpzi/u3S3eywyckFx2aev9GMjqSQzuCDAfGwfC5UQ?=
 =?us-ascii?Q?6L8mRwJQ3zlGZsOATbFejK8H31na4wgx/6Cy6lRUpilykAXgRYnsnJuQTFms?=
 =?us-ascii?Q?PZWT0e6O0lpSSYwzGHvo3oFN8yZSymTWe671md28TXUtenVbrhT88fIo0pzm?=
 =?us-ascii?Q?5OyLq+Sr854sVc1XujN7f+TOTmaYojOzoaGIIwcsVPuBOAAAVpS6zJmcjlzo?=
 =?us-ascii?Q?JFNsK+/giMTxOwMeSP79QTSZ2LKz/642ZBCuIrBU5gQzZxuJpkstxXnm01z+?=
 =?us-ascii?Q?L0s5WgDtVowFbfgsTuVuTSZ/yliEOPMVukirYX2BJptrZ9Uvrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SddihhJCuIDL/IcFivZlSrV6iJ1eFqa681kBw1UnaXUdyccS4a04kXQwhnCq?=
 =?us-ascii?Q?30e+wqHbxyKDlZ9p+eLKmIsXFzZFKB5Iz6AYrSve7JOgT+K56n9Cnxdf8mPH?=
 =?us-ascii?Q?fmp/Pv1/whOT/RO7d8O+IoNHhEEdMt2JkMy02t3ptmpy6MQuJNM8cmdma3Di?=
 =?us-ascii?Q?en3HogzI/fv4PvstRWrYUP7dszwuZHybgdUbEvyFDUTOUD8wsW+SYFsTGpUK?=
 =?us-ascii?Q?Y864dNSlM1TPCR6a3P+SWok8V7QpJptp6ixtCeCqM5VAgf53NELOQ+Ors2q1?=
 =?us-ascii?Q?Wxj6c0YWTv/MyWhRJTEQrd0gqQvHphitUgGOTZ6kz+8nq8LywKKZF4K0ulzf?=
 =?us-ascii?Q?lb4Pvt16lVVYdfHl/EaGYXap3uyMrHfDXBgS9tBbeeCdlqHkbt0lwDgBD71z?=
 =?us-ascii?Q?NMwtgcYI7jxOysECnxRed/2Cbrw8VCjt5+f+idC7d1pyplXZhQzyxXX+GRND?=
 =?us-ascii?Q?aj1qwM281vw4DuwHrZ0kuT+aLcmepzocF4+mvV75GKZXfp4ToZBC42reRdSl?=
 =?us-ascii?Q?8Tgbc9xF3zDkpJGG+dEu55t06XeUDiLv7qJte3VFe9H3Gua0YT01/92srU21?=
 =?us-ascii?Q?c+lyi75i3EJKkAuI5MwoW+G80SBrC5y7ouvdiTVTC/q2/0csjTjjAL+ZiQRc?=
 =?us-ascii?Q?Wc4CSKeSnncnf+ep84xen9zRG0HODLwdaXgm3BKBCWfJwhwjGvVPnO/xImuu?=
 =?us-ascii?Q?yT+9r1Z1OKsawEkE2PrtzQZGb90zKxhazh9Xn3u9VP7xjD1q3gARCau13Imh?=
 =?us-ascii?Q?j3KDDIeq3NMGgmK4kjomJMN2NEc3oqbUmoLysDdyLY37gA4KG7x1WqJu3cbl?=
 =?us-ascii?Q?t2BpksU3//y/Z/yZUMhKmhXYUtt0VQmC9Raux/zx+8fuCKdjsiv4AOlHX6Tm?=
 =?us-ascii?Q?w/Zcm9VSQdfEN9RrHkLmKFj95pn0CDf3O92ZGl+HikN/vDVo/6ciWnAZ2MVe?=
 =?us-ascii?Q?ih94yzzFhH+nVmTSBhTJlUjlOwxsQy9qaaygoK99NN1qpn2BseeADLpk7eB4?=
 =?us-ascii?Q?Sc0jjh+oqRymhVIIDuAeFfovbHcY/7sup0WhflLb8YiGPEkUuYrvwsRich1q?=
 =?us-ascii?Q?zRDr9DBn6yNQ1s66lFBHLp8JYkj/EVgcakwZo5QQ4JpqkBpZ+159gSJlFuc1?=
 =?us-ascii?Q?qn1aSKuJr3Z8rmrlHLwdr6w4lpuknEOgN2leBFm8leKtU8ozIstX55kRWD2F?=
 =?us-ascii?Q?1q11BWxHADTvQeDJBtOzwKLwbDnDvzLjImLxDJug+mtaQUfPELm7jiGsdLev?=
 =?us-ascii?Q?JDCqRCyBgVdlF4nQiFfoRb8nHerS4QaxbtZVTZDt71dH2KHlMhEXQ1FnPpYq?=
 =?us-ascii?Q?zNIJnLknae8vfchypy5gC9wqZ+Q/qBaSQ/2Rv6maJmZuc9UyFMUInySb7dEZ?=
 =?us-ascii?Q?8VGAigysg6gVw3/N6gykGR7yQDHGpK9Xl5Euaoy99CJv2vQxrjpYJGDWCMtv?=
 =?us-ascii?Q?AZqulZO4rzotPMCRpL8jaMy3klY9mt5PGWHJY84NxxDF8EaqrnYP0Tezb86q?=
 =?us-ascii?Q?mK3xQL7fr0SM8YgVzbvaFiAwL4ba03eQ+/d74XGoEnRFH4KVpTI8/SRY3YPT?=
 =?us-ascii?Q?C2MYMZ/C1VSa4f+Ihyat2+VkK5cUKCq6xyprl2QqHq6r1Lt1xi72RTugO7O4?=
 =?us-ascii?Q?p3ZxgSbXUNmEHQ/4SG5G1Kk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3381ad0b-c5f4-407d-c3fa-08dcce3ad3ac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:12:03.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lY3Ec3KV1olBnYdXTipm6RnISeut6jEppq0XjxK2+U5EZytxDn7Z3tYmj8AKdAkrRkQzkHXDF3Rb7Dgk6SWLuZOibJ3fQl3gGNv/ol88RX5fZWLP9WQJfw8LCZlaFH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8077

Allocation for mlx5_frag_buf.frags[i].buf is node-aware.
Make mlx5_frag_buf.frags allocation node-aware too.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index 6aca004e88cd..fda17b41ff17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -79,8 +79,8 @@ int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
 	buf->size = size;
 	buf->npages = DIV_ROUND_UP(size, PAGE_SIZE);
 	buf->page_shift = PAGE_SHIFT;
-	buf->frags = kcalloc(buf->npages, sizeof(struct mlx5_buf_list),
-			     GFP_KERNEL);
+	buf->frags = kcalloc_node(buf->npages, sizeof(struct mlx5_buf_list),
+				  GFP_KERNEL, node);
 	if (!buf->frags)
 		goto err_out;
 
-- 
2.25.1


