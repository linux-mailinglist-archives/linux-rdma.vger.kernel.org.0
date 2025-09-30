Return-Path: <linux-rdma+bounces-13734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C6BACB33
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 13:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664FA4E0718
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775925D1F7;
	Tue, 30 Sep 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YVZYICKm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010003.outbound.protection.outlook.com [52.103.20.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA05259CA4;
	Tue, 30 Sep 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232105; cv=fail; b=COuJaLL/N9B39RWCbqGpPJgL5zBysSp7Taxj5L1ZVvhy01akOBSsIvmF+1mzftwmOXxADNYyiV3WCMi5lqDlObSMVOre0Of0SosQ9S6ACwB8CHVYLXBnKURtva73gB+6tumSDhLMmTyVt6FziXY/Sv7XZCNd3Pl7YS58OXux/Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232105; c=relaxed/simple;
	bh=FIxxStkKJFLk7kjxhjZv6J7mvrCOb0m4RcaOAztZ0b0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WS2zoHdGYV5sS/Wq/tZ+kRCHMPoS9kqjVgq/+2aLWJPQ3r/VIchh4gLq63pGlIQhu5c2Dh6Dq3UXXpusldsKTS7V0kSVRuM1jFJuvb5ct++xiKycZaAulMz0OcsKgvBcJ7HroppdAy4K2sSBoUAjU7KkRbJP7pFeoJ9yhaQTdSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YVZYICKm; arc=fail smtp.client-ip=52.103.20.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2dKiY7/eIXGg//fUYQ6Sy1/TGIaY3mocUn+txeZbEqwQJlfjQnWva3hDwpBwpkiqpxG6lK00HokiWr4RpzCxUbT1SI5RSMJjhYlHpZvzqQ5e6/7Gfjg+Xnc7j1Vd+wfn+zJ1ZIKqOn7g81OBk8slIoAccYHnKyLVgHZQCTIrSCwoeTpPWuPoCSgfxcZBYz9yxft/CbW8oKP+HDYaYv200A8T6HaHey/Q/77FpD2goYami/WBMl99HO34HocFeHH8L2qyscZfxg8JkjMGaAO8r1wsRXIkWwVB0Olxce8OsnvgNyM6e7RWqxXELGIuHa9jckSz0aPecmjydu37/tEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2ZtgzzsHmj5ucwCUqPumqP0LcW9Z4zSsDtEGg6HZCE=;
 b=mW0g4Y6Eq7C3wetp4+VO2GttSIN+dcvsccnGgGl6taRplaugST4TcGuNuUe90qY41dUS7cmXMx3U8QW+pe5Y24c4LGyIFkNY/aBaXe5CUU6qQNaTROv5bqtSX4Mr6/3lrm/zClheeNb+GLNlCeLvB5Epzi2C0qj/lFjH4Rmh2DU9MzhD7RS0de546QyQpsHYJrnsYyoTiSeShfk175iRl0Xp3EtNzbqa4mFs7RkmVZ/1WKbMyMf31xKdiKHGjx2gTPET7uPUfjusFjPVdLdqWHdMSw4sF/uqUP+cS6nNsoGAPiq5yi9VsJbqtYkA2oFtIrJwdqyejjgqWqkLmgJv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2ZtgzzsHmj5ucwCUqPumqP0LcW9Z4zSsDtEGg6HZCE=;
 b=YVZYICKmkOrU8Qve7wwGGw7cFzEYbsIvE1TUI8aRMCZZMuQn55UIDcyWWrbtu/r0Wg8miFoXyT68wq3eVFfHApt0VAtiVa7BDBOERhSC6l+ij5jcIM8TF8O+otmed5+/moGVzLYD55TntmN6YaLbBWXzr0EI0HdYATwaVIuQdOfN1h0jpZSjwrLobr+rRKBJeWrvx15IkB7CILLXfkyoPih8GVOMu4D48IMbjPuJ7O/9jUQPNBUzoKikMYwBFdULnnweNmnTHgM9oeMRqjxQEX5V5ZtFEF/y4m7oa9AQlY90QWX18HNkTpYL21bIBZPeyM2+jpDrlrAynJ6TTlIu/g==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by SA2PR16MB4057.namprd16.prod.outlook.com (2603:10b6:806:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:34:55 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:34:54 +0000
From: Mingrui Cui <mingruic@outlook.com>
To: dtatulea@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	mingruic@outlook.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Date: Tue, 30 Sep 2025 19:33:11 +0800
Message-ID:
 <MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To MN6PR16MB5450.namprd16.prod.outlook.com
 (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID:
 <20250930113311.691688-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|SA2PR16MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bc7110-1464-4575-ce76-08de00156046
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|461199028|15080799012|23021999003|41001999006|19110799012|13031999003|8060799015|1602099012|40105399003|440099028|4302099013|3412199025|10035399007|3430499032|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qMGkEpYoEYJqtb6HSxKXgdqHsbTtEeIIEQGMMphInJ9yzOrLnxEkUOSAGTqi?=
 =?us-ascii?Q?qQpgNof0MiKkviboFbjliufEpMx38a+Lm0HVE9aDFzR9B0Ya7FXSOvBqg4Bt?=
 =?us-ascii?Q?JFZ0noJ91nONf5niMQwDCS1HXdfMMvCrSggZt6ntIgBNoXQctqLNKlJ5hKyx?=
 =?us-ascii?Q?L/tb+KnfuI5RUom737DOnb4FXNk9neoE78EnOJRyomPHyi6xChxxLE/gi3cP?=
 =?us-ascii?Q?m/hay3Hktwy5JzmYJ6B03fDPgHC+iOSyXdH1Ay+I5HG0DlYAg4i2di6s+dYA?=
 =?us-ascii?Q?VW6u+wJLSh8XZpYF5KBhLOebOESmioETFS8NbokP7DZ8wWZisAQOp6pUAd8t?=
 =?us-ascii?Q?ecwPL8ASKKer/3dDntiVf3QkkYb9jkkL0aI2p2vMPKQJO4vPVwmmAdegx/cY?=
 =?us-ascii?Q?+JtYIw+zfC3hCPUA72GQLhr3ZiKzf+WiA1HBokF1bitl23DVARrbzCtKY/TS?=
 =?us-ascii?Q?q/tODApmWUnKmQxdrsqJzhdocyoUPa4vyy7kBTJu2ZAL/tLVATcZldMjsfBx?=
 =?us-ascii?Q?6UKYW0gM+/a4tlXEmvQQTTn+CeX9/XZX914pwJCD/y4nPM+nXxs0eazOqRN3?=
 =?us-ascii?Q?QYR7zwQI3oISTaHuOlXIprgenWlqqPJTQpOhY7yMN1L7FOUvRB/DTMjsdUHo?=
 =?us-ascii?Q?x8OX1H0Lr1egifuMCATx6UOykEMN5bvYfmrO798cJ4i2f+nT0ANlb6SfU2ej?=
 =?us-ascii?Q?+I9mL2BawJxiAXL/rtH7riWRzTjxQg8w5FIpNS+mDsIkvEWAgHlLPGZ2POsK?=
 =?us-ascii?Q?b6YpHSy+l5/ZmPaucFkY8h8zY/h+yBLhbMIio4zsCFcSYtfmL7YiJqJSUp9Q?=
 =?us-ascii?Q?8b7hv3X0q8MJ6lohgkSM4oVUnl4fPZmQl7Nq8axtc5BvyXnonl8I328dwGHq?=
 =?us-ascii?Q?OTkcle+rR6NWHKogxRKZ3UYCr1jaUnYBwLXP7OAsefivCuqXFLSfDzl6vas8?=
 =?us-ascii?Q?Rf4HhlYVfa95FoUzejbtkVCb7wn2I3qNxN1/mK8lMbsfQjMhsKjxj0v0rMS9?=
 =?us-ascii?Q?D4PtMGUox2cfkV5aty1w54hjzXvJ8E5vY691hwz+zyiVEuZtD+vkG8OqfATJ?=
 =?us-ascii?Q?I6j6FzNfmwZ+CIi9NZQR8pTkwdSqJjVwmUxvGB5PC5xResmCwVve9xsjSlCB?=
 =?us-ascii?Q?oyATpxKW5XfHNTKmXzPkkerzAEHAfdogFcuaTAY5m3n6d1NE8/AvWpDxpKUa?=
 =?us-ascii?Q?uqinICNb2OF3XYZ8vgHt5Oz9KfVnwjry+26WnmR+6sQODbqZtYKD1yuVyJlL?=
 =?us-ascii?Q?VxmhR0tWCphIIdfzIScmDx6NP2zyykJCiJaMLOjC5TMZ9DaQRirdqkpHl1jk?=
 =?us-ascii?Q?tLbe5rsrYibxrLHxgEGuCTRE220o5h3hDwYMRm9eYtWOeEv9uwb5w5DAWABg?=
 =?us-ascii?Q?GsfIlgGDWBeChPAuI0kxFKuRfAzm?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gM7KQghzgR+8Yx1tPdaNlezcUf9mcXz6tqL3JVsODHJWCC9KOD3PdzeYDr0Z?=
 =?us-ascii?Q?dShguYfvNU7wyTf0BZSGHt6eg1LX3+MZChaYaFqWCbryyrTSx1kIcY/+FVZR?=
 =?us-ascii?Q?mExeAENtmyIr8gyu00+TAitgFy5fA/1jchQEi0+pWfCeoGH1oB6GVI+zOnih?=
 =?us-ascii?Q?Oj/N6yMBfeKiQNn/ijfOPOXlXqdsFlOpUhnMjfaW5xqKrfeSs+WZ4TGbOePb?=
 =?us-ascii?Q?iiQiRi/hNr2l1+lsh7r/LJ9t8F3Gu0xzR1q7Ly0hZADrApyWAgciXU4VwgMe?=
 =?us-ascii?Q?q6SVM3N6WKi2k4qOoUjzJPgEbaoJveUtR7PFS1h8OCX2WuTKvBYaQ+2U8rGh?=
 =?us-ascii?Q?6+LYxRDg23lgd0h4spnbt53yZa+FmbwgGgbDnrPGkTP2Rh7VWgjF/BghEg21?=
 =?us-ascii?Q?FQbjD7KI+yBIdSTet5uztEE2D0thMjvkuPaZ63Y5QCybBSI7R5CuiKmfDekR?=
 =?us-ascii?Q?9cqauZvpmc6beD9GQOFIaytsPc+f7TPGgkrboCpFYx48JwTRU1fuoCl8uA0t?=
 =?us-ascii?Q?uh9mCuyhJSS4Ni3zBC0+qTWVOQj+dl2PVyUM13GA0jsCtSzuVENhsosAGcZi?=
 =?us-ascii?Q?f45IuX4eAZJ3EugdVHb+nZXZYTQD7UDiKEXR1Q/VoaZhWXs+ZjJjDbtxRSQu?=
 =?us-ascii?Q?B/IUYkOBGFp7kgxYcdoJPa1c86HFQnhvYyXZoQJvE1DUZ58aaeOwirp7I3fb?=
 =?us-ascii?Q?qR8oqQJ0POFhYpTZQq7QxWqXB+1OSwEpZXifKc1w9PTnl73FNOoH0BvLp4dF?=
 =?us-ascii?Q?p0Pse3cJfEP01CNCWzZ385fWAXmW+r9r41FEiHK4p4+QfqXCchG4QU/OO2Pm?=
 =?us-ascii?Q?A+zo0aL8lZRbir0KniHhpOj5jTs0HbOdgzBSCDSpv+2EMtFPwGDTEKdI2oxo?=
 =?us-ascii?Q?PI5oJOTJP87SHRSRnNO5Voa8cLgdw3DsPn9QPwbxIAS6HCwbExDLnAzFJEwF?=
 =?us-ascii?Q?+kz0zhxpUog5bVnbJLsplr+XfzYWr+9gkwKNJLFvW8z8JC7CK8fst7rN0JJG?=
 =?us-ascii?Q?RTNKZht5ZhRCgDCkGt8tNp2OxNO4Bqo3n5q/u8eXBcySqGVCVjunx+jcaQhe?=
 =?us-ascii?Q?mOAJmzzJVtRa1wcwJTx8SSIS0bEz3Hz8lBbHI8bNUtefOzVt8HtstQsP5Vzt?=
 =?us-ascii?Q?5ftl0izBiTyi4UQr3uMfdJFcmfw8c1Y9FQZ2G/4jJRT4hHB9OBdiuXqVWLEN?=
 =?us-ascii?Q?DkuLTMgOw45bcYKYkrfYjTBuiBdor8MrE/x2JAQAK73VzeHVsqyfLYb9yiwR?=
 =?us-ascii?Q?A7DchbVAyqkTjAM4lvLO0bd9lcz4EDA/LiHlAdEEBA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc7110-1464-4575-ce76-08de00156046
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 11:34:54.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR16MB4057

When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
fragments per WQE, odd-indexed WQEs always share the same page with
their subsequent WQE, while WQEs consisting of 4 fragments does not.
However, this relationship does not hold for page sizes larger than 8K.
In this case, wqe_index_mask cannot guarantee that newly allocated WQEs
won't share the same page with old WQEs.

If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
page with its subsequent WQE, allocating a page for that WQE will
overwrite mlx5e_frag_page, preventing the original page from being
recycled. When the next WQE is processed, the newly allocated page will
be immediately recycled. In the next round, if these two WQEs are
handled in the same bulk, page_pool_defrag_page() will be called again
on the page, causing pp_frag_count to become negative[1].

Moreover, this can also lead to memory corruption, as the page may have
already been returned to the page pool and re-allocated to another WQE.
And since skb_shared_info is stored at the end of the first fragment,
its frags->bv_page pointer can be overwritten, leading to an invalid
memory access when processing the skb[2].

For example, on 8K page size systems (e.g. DEC Alpha) with a ConnectX-4
Lx MT27710 (MCX4121A-ACA_Ax) NIC setting MTU to 7657 or higher, heavy
network loads (e.g. iperf) will first trigger a series of WARNINGs[1]
and eventually crash[2].

Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
size.

[1]
WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0
 walk_stackframe+0x0/0x190
 show_stack+0x70/0x94
 dump_stack_lvl+0x98/0xd8
 dump_stack+0x2c/0x48
 __warn+0x1c8/0x220
 warn_slowpath_fmt+0x20c/0x230
 mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
 mlx5e_free_rx_wqes+0xcc/0x120 [mlx5_core]
 mlx5e_post_rx_wqes+0x1f4/0x4e0 [mlx5_core]
 mlx5e_napi_poll+0x1c0/0x8d0 [mlx5_core]
 __napi_poll+0x58/0x2e0
 net_rx_action+0x1a8/0x340
 __do_softirq+0x2b8/0x480
 [...]

[2]
Unable to handle kernel paging request at virtual address 393837363534333a
Oops [#1]
CPU: 72 PID: 0 Comm: swapper/72 Tainted: G        W          6.6.0
Trace:
 walk_stackframe+0x0/0x190
 show_stack+0x70/0x94
 die+0x1d4/0x350
 do_page_fault+0x630/0x690
 entMM+0x120/0x130
 napi_pp_put_page+0x30/0x160
 skb_release_data+0x164/0x250
 kfree_skb_list_reason+0xd0/0x2f0
 skb_release_data+0x1f0/0x250
 napi_consume_skb+0xa0/0x220
 net_rx_action+0x158/0x340
 __do_softirq+0x2b8/0x480
 irq_exit+0xd4/0x120
 do_entInt+0x164/0x520
 entInt+0x114/0x120
 [...]

Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memory scheme")
Signed-off-by: Mingrui Cui <mingruic@outlook.com>
---
Changes in v2:
  - Add Fixes tag and more details to commit message.
  - Target 'net' branch.
  - Remove the obsolete WARN_ON() and update related comments.
Link to v1: https://lore.kernel.org/all/MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com/

 .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 3cca06a74cf9..00b44da23e00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -666,7 +666,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
 	info->refill_unit = DIV_ROUND_UP(info->wqe_bulk, split_factor);
 }
 
-#define DEFAULT_FRAG_SIZE (2048)
+#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
 
 static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 				     struct mlx5e_params *params,
@@ -756,18 +756,13 @@ static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 		/* No WQE can start in the middle of a page. */
 		info->wqe_index_mask = 0;
 	} else {
-		/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
-		 * because there would be more than MLX5E_MAX_RX_FRAGS of them.
-		 */
-		WARN_ON(PAGE_SIZE != 2 * DEFAULT_FRAG_SIZE);
-
 		/* Odd number of fragments allows to pack the last fragment of
 		 * the previous WQE and the first fragment of the next WQE into
 		 * the same page.
-		 * As long as DEFAULT_FRAG_SIZE is 2048, and MLX5E_MAX_RX_FRAGS
-		 * is 4, the last fragment can be bigger than the rest only if
-		 * it's the fourth one, so WQEs consisting of 3 fragments will
-		 * always share a page.
+		 * As long as DEFAULT_FRAG_SIZE is (PAGE_SIZE / 2), and
+		 * MLX5E_MAX_RX_FRAGS is 4, the last fragment can be bigger than
+		 * the rest only if it's the fourth one, so WQEs consisting of 3
+		 * fragments will always share a page.
 		 * When a page is shared, WQE bulk size is 2, otherwise just 1.
 		 */
 		info->wqe_index_mask = info->num_frags % 2;
-- 
2.43.0


