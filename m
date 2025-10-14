Return-Path: <linux-rdma+bounces-13857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2475BD9352
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C3E18A27F2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9357310654;
	Tue, 14 Oct 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVdqzKoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F23101D1;
	Tue, 14 Oct 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443434; cv=fail; b=eAo2tvBm6vaQGLd8OaiXfdAWk+DHsvkJEKQMwaJI+scaReWGss1nu7858lw+87MEuapJAb8Kp4qgswsASVt90Aa7+5huuJtqrSxLwkn9mBz1Wfmedj7FR5KRW5VUaP0G3b4JDzqelXAnzAAgusb0+ch2oXeADwB+jUUT81ivyD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443434; c=relaxed/simple;
	bh=JvwPi051iINLqZDWWhfxbXLp5Z+l9Bu1pEpBjgF26w8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QNu5GTgUXWEi/RbC9MnZgVz1MfBdjWO4Nr6sK57PCX7f/PeDks+vZkNpR4xdUESwqMj1JBoyC162QgS/HoKeq86CEdH1DlKdDTViluhIop5cLe84nEO1PZoZTCXoc9nFRs6FpjHxFnWlZyU4G5+Azbt4Jw8bR6dmhQvyASZHM/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QVdqzKoa; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOmpsn4DrJwF2wYSU+iHEqHY8F2GIoLHuVBSmb+fQ+Z7wqhAa3oL3r3G3zdC7LtV4aa2RIYm0v0zWueNQcp/aDXbpu46BIVbpliaGdYhdnL7cKj2rfMDpZUehd5xZLNDkXGkDX7JJTuD2Y3GGTu8D2itQ1NVAB853iMoLWv9c/ySstDi9JwW/pjEMAd4XYJG4CTlNgpy8esjQi+07gGiVT8vlONCNC2Hs2eToDHYIJxUz1SsKbhAEnU65u2yfop1YgxjgMotU12GIL+X53bMNzymz2A4faAqeUMjVJDrfGBIGSBdEJvps3Hv/qAOb6o4MHoDBXfSUelFzMmzhjakjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2QQekI+cIa1BjDoRhzTD/URMxrjczUa9RT/uiL+WG8=;
 b=IyDenbN3EmfgIKaAUCrDhZTqx8XqcANWXM6JU9wrwxXueBZLy5Gg2d3HoxprVjpbXX1hJdSeLVmHRBxEDVrEzV1yVTrmp8H4my6K90HoQFI/lZVpCuhATY+SjLOmwhXB+hXQ0XuY3YaFK1zi9Caz3o3Cmu8gwj9vYojD02NeVKM7lAE6yhKILiWSjzU2quCYw1J6GdVEdPywXmj7AeGu5W+lwxa6EKRkPuzaLscvcD9RVXg/ynxTwhvJrMnmUqutrBzMxmRYkbyrS10ZkNXloNw7YtjUGaqdQX3GtML3cE6RXnBYvv6EpniDLXl+4Gxt1rWdbsC9FF6xTcNHEjGxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2QQekI+cIa1BjDoRhzTD/URMxrjczUa9RT/uiL+WG8=;
 b=QVdqzKoa3NGIQ9+AJ3KQkytgxdqCaVv3Cv7giNjKG3kJGYll4musbU/16dYN2KosFCnSls1CepJ9BtEmFtqQh7HC/jRtX0hjMtriGyAykD6tZACm5Tu6Tx4s3rDgDbv7GggHE5vSUCr/up/7CTGzTlWcEAbuHWCzZ54Bm4vMDjftk+TJoMBLXqVOsVlzL2275lZnjHxGQtu7hRSV/HWNaRIDPJ5F3JpYgI824brM4xPQfWgscZlM5LxuMhBhPFc5k1K5ueRuwD9Fj33rqwwNCwrFnAt8lDEmxFxoY2uaFgi+C/e/PyOoP6c+ggvUVxAPBtKoEHAPW9s+PV8KFvA3Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) by
 DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Tue, 14 Oct 2025 12:03:46 +0000
Received: from DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968]) by DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 12:03:46 +0000
From: Colin Ian King <coking@nvidia.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rxe: remove redundant assignment to variable page_offset
Date: Tue, 14 Oct 2025 13:03:43 +0100
Message-ID: <20251014120343.2528608-1-coking@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::34) To DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8294:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c80fe7-618a-4898-34fb-08de0b19ba1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xl7zgTB/iUXFbsqttqXsJbV1XxKfjxOC0jbFMsS+dv5g8RX4FQes1qFyy9On?=
 =?us-ascii?Q?jxKGPYyaXWasx/IzP2RTEgxft+qQs79PDXLvpmLdaVBOsNT5y6eI7x5Ff/Q6?=
 =?us-ascii?Q?dYESTAyiNNe2AEfBY4htxF3/H5J0gpeZ0Y9AOong9c9olEz9JZyEVG3jIBXA?=
 =?us-ascii?Q?dOPVM9oEJregOZRr4trKLZBr161NWjBu/e/zBEnpbarq4MXk3nKegIgJRPmr?=
 =?us-ascii?Q?vlHDEXZhcg6j+JDRQLFMhl7EDqviPCuSssEb1hmg0gbwogL40WNQYvnBsySG?=
 =?us-ascii?Q?TQqNpvH3DWoku4w6E0LS4WgpSo+8qeXJE4lM0GSBkem4zztQ/xw69tp2t/eM?=
 =?us-ascii?Q?Id8zxLIp8TnCslegMicK8jJ1HcwJv7cCpeeNE7JLP5j8X0Cm0UABvQK05ZC4?=
 =?us-ascii?Q?KKwIZhZ9PAyO3YG9Vr7gxOKEVTxillgJZ+Mn4xjZllE64ziI14UCNzoy55fX?=
 =?us-ascii?Q?JF0gGV8xpf2fMh/JcHbQU6PLNdiQi0gStSAhuBgMYEZtVTbFV2zVtR2l87Bq?=
 =?us-ascii?Q?tY3chuITIUR71yZK72Zdy68DTuwnrkyK45eQHKfbydv//kdlwqz8h+gtsqLm?=
 =?us-ascii?Q?1Avk2ZNg0xvm4csfHw4gpBEReZl6hntxzUAKIx7/yT90w3rNu7dnnI65VbzL?=
 =?us-ascii?Q?nvbvWLZEEhsKvDRzh9AvzqHO+spDE7TBYj/L47N9LyL18CH+7mTXYtWm4PLY?=
 =?us-ascii?Q?9EG9q5Od83LuDxV0Y5kTyfVmTaYYW8VNKf+UFUmDS8KHv9QdWBJRrV2Y/rMM?=
 =?us-ascii?Q?VPIS8zkgHLjmuQ2UbyPceYxI4j3G6DMLXGvTbFr/wR0Ca03BTs6VeTA8VJuD?=
 =?us-ascii?Q?DXcI4+kAzFL8ZFtgJN5LgxTDkg7MlvGjsRghc5cssg9QTd7ni2BzZiPrbRXN?=
 =?us-ascii?Q?5uorZ/UMXEJ6BGGhvxvd8Rkqewel6DRHvenHThhnFCJhhgmVyygrB7id1lOD?=
 =?us-ascii?Q?Edrj73sOK6elFLdmfQdhuW/xo84GInXmtmvPJRT/es8LX97c/GYhefkxex9R?=
 =?us-ascii?Q?ASIPEoxveC7gDP0dAu0aU7h8Z5GovVUnKA/uLaN/fWELVWF2PfXJkLsbkXHP?=
 =?us-ascii?Q?yFKKFAijOIUrwvnOtkD91TzxrtoQlJmtMz7QzZUQz6yHFvy125fLw7LmAVr1?=
 =?us-ascii?Q?0zfgE64OjJ6eKbcsawKa9dkKpHlYqrCPwYdsQWJlzKnaphvtLCCBx3vF7NGg?=
 =?us-ascii?Q?gWDVRF5bFsaI/kTYEm86yUh99PAHhBgBeTBsN3oIxoSx1xRxd741bpeFw/Jc?=
 =?us-ascii?Q?fbypIiX30Lf4Sfj2LyZ2HWeRgg+deOxAQZxCIjM47fWeggDxBa43PAZM1Okh?=
 =?us-ascii?Q?DXiVncMRctcpB3ogTem0YGjnFUPcBqXV27f+kI6ezGDu4GWwP2DqgNfkG4Cj?=
 =?us-ascii?Q?fb/saR6JhDF563j73Sk538XjxuT+Vd8SzD8fGb8+7QtP7BHzs2CrcEJe4ZSX?=
 =?us-ascii?Q?r6ZGq9SDpK2KfTzz4Ofiy72PCLjbDTUG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RUi/Nek5IuMD2XTumzxcJBsR8mg63kIv8Mo9HrE6nbqpaDGuWnaNwb5+BuJR?=
 =?us-ascii?Q?WjE1TsV+Icyro52k8wqYK4IQwDghfPbxrAfYKzEomLz5K2AEkN9JOkv6fbli?=
 =?us-ascii?Q?Ku0rxU8FfBoXkGElNK0vvkg6kDN3IJdKit9DgHdOslzYJgEbTk6WOz0o/DJk?=
 =?us-ascii?Q?L56lSy/cHmDnyI5vrJzjtuBtMi9EIbhiwLEue7HPShe08RoqDcF+gF21PhvE?=
 =?us-ascii?Q?cdvjGk34mRi1U4OJZ/NFdikyb8+4NifnhxdAmZIiSH/WYMoyiGC9dUt7G2pO?=
 =?us-ascii?Q?Y/A7aQ9QglQK8WHtykHzss7vSEplmIzG2U8v8xnVN7TCbh0BCTj4pL6ji110?=
 =?us-ascii?Q?jWCajMclQVfqvIeUnGQtzqaGNCE09S7DlhUQk2fd+HkvSG+9B4KBZfKhge6e?=
 =?us-ascii?Q?xTx+v/Wg/7nKfRsvWjkvcEeM9b39GVLV3WlQj+WnRzVnPzjyLebVCcMA6nWX?=
 =?us-ascii?Q?gaGfi+onQo+lOrRk8a/esbcONYEVZX7anRWuWDPp6G3wGiy1WX06r4B84Jry?=
 =?us-ascii?Q?ebKMPA8SMNribK0TIe4asrzQD/61I/ok2jR63tN2KGZiqPrR+wi6kCSxzDV5?=
 =?us-ascii?Q?aRvRpTVEsFmaV/bHEErqTYF682r3h9OfwUEvkkl08O07OTxoEnBH3SkYyClE?=
 =?us-ascii?Q?cOE88DoRoCVAvFAoBN0rfw2KGg0DffvHBZX6Qojbsl4XxWDxN0yR8qPumpZd?=
 =?us-ascii?Q?W/b3Avkbzk3ol1apBHHgzGj9XLD/NO3gTNIwP/kS/+wcXF79hAI5wtKeaeyV?=
 =?us-ascii?Q?wCxRe3xkEJwq/tP31DGKrSy0MqaQ9MBBk2d2D8J8KW/PqFxjQVffCXsOUW5E?=
 =?us-ascii?Q?S3Q6Oy3JqOjfCETi2BRpcvX/S29vygePlRbf3e7dkbbsS94CwtyHEw/3BpB7?=
 =?us-ascii?Q?L5mWr7hyJzXnekxnNhoYm4ZMffpODLNRrLqR1nZh2Yvulx+r+ajK/u7wnoXZ?=
 =?us-ascii?Q?rP1JZT681tsQdXftpAZ3DbEfiYDVM/9HESwx7fq5GS2rUlhCYw4QILM2oPPb?=
 =?us-ascii?Q?NMiI9ZMw2T6byYTwMc7OEMJBfByWf8ONvNaAkav+DiA247bvzfL8ym7BYtSh?=
 =?us-ascii?Q?osvxeBBQBkG0QogwzUinKMsF4EHhuzOA9YiOkxNFoVN6KiMF3f/yw6XKf+Pm?=
 =?us-ascii?Q?wm55WKaSZ66Op0qvEpUWOM7IvXLkE22QtSPQXXegJ6pfbLfZB2JRq5ZTJ9Ud?=
 =?us-ascii?Q?6WkEErz10eDH1EN6AEXJKemcQZdjl+lCN59hmPRJ4PIJOlY0yT5Ee8pDDcCn?=
 =?us-ascii?Q?/7ycYncV70LxgcjVeDGdIwQ8ifgtr3gr7msa+jxIDQqiSGV09YTw+CYvkQSC?=
 =?us-ascii?Q?zp9+ZE7smrWcmGSiJnMvtFlN9g6FZ22QFqFru9Jn2JS8oF5BHG6kmwmsq+QA?=
 =?us-ascii?Q?7j6tuO550Q1wHcdPWa6e29dzoTEo/FoePTkgh1GnPM25gS3BDfRWtbePizJ4?=
 =?us-ascii?Q?6xOOWVh/2gCkdVrhhgvWt/Cn8Z4qIwIDKN4LWoOsNJz+NTDWHQeV7yxJrRYa?=
 =?us-ascii?Q?XVQA+YuZodgZDGT0C5G0r95WYBeaHs4Wq+OlwsTbyXT1dY/N/pQpRbzNZWf+?=
 =?us-ascii?Q?JY0mv/qK5ZFWsk3L8mdGoA53yPM1HUOD0pip9bzW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c80fe7-618a-4898-34fb-08de0b19ba1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:03:46.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRRI4monmAL59qbj1LKeoW9Y7zuDT6GMTKITJqrz7DE2cfeT/bedV264DdMf7reUDxZ9aGh+gxmK30+yNi9AzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

The variable page_offset is being assigned a value at the start of
a loop and being redundantly zero'd at the end of the loop, there
is no code that reads the zero'd value. The assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <coking@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c  | 1 -
 drivers/infiniband/sw/rxe/rxe_odp.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bcb97b3ea58a..b1df05238848 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -452,7 +452,6 @@ static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int leng
 
 		length -= bytes;
 		iova += bytes;
-		page_offset = 0;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index f58e3ec6252f..ae71812bea82 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -358,7 +358,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 
 		length -= bytes;
 		iova += bytes;
-		page_offset = 0;
 	}
 
 	mutex_unlock(&umem_odp->umem_mutex);
-- 
2.51.0


