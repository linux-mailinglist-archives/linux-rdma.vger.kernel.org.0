Return-Path: <linux-rdma+bounces-2916-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0AE8FD689
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A212A1C248EA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3C154BF9;
	Wed,  5 Jun 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="pi3w3toA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A71514E6;
	Wed,  5 Jun 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615824; cv=fail; b=M/TWBoi9zF1RanrqdGiiNOyKX5N4qQTZ96y9UTWJtrsxGCk2ESBm34DXDcE/d6hU+AM5SQr19iVfSxyzogngYF8zuI5+qrzEq0ohAeUMz9rJ1M5Vxzdyx2wCxMHFDG/1gMXwkDzPG03BEqV8EBjNoQxvhLmn1LEVhf9h6zxzRhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615824; c=relaxed/simple;
	bh=4a3k6y2crYCilo4927vRW7ZxB2urJxhgN01xNP/IdWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iumhYRwVMNnfaoGLwOMV5rt/QJJOANnneUOJeZWxbWp2OMAPBXmI7NTvzaBdxCc6/l0ix8hTzj+GjaVCCQB7ugekmE0JVH9SLUltwbciA0jbWwdiea30qc1c5+bjMHVvz11eMvh3w1OdVgDiHD2mztCXkq697Qs08fP23J5qvxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=pi3w3toA; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+40/1HbSdhQLVXDWUzYOMVHsxynjBpASwATfSvqcJNiuP0Z6WfCGly+JSeHVin582JlnnFp3OaMma0NQ0Dy74ezuKaD4TKHycGkCCIGB4heWar/1c3OpCfDjwty6EvVUb6wnSuYXd869t/R3KI9A4/RB1FnoBrSoEVaAiqjB092ZjtXyzJQsP2p+iPeOediGJvjPk/uJ1n5Ys9erj1fzvURzxALPrjVYFtxeI7TFSEecNRk3ojKZAhrhHjs8TC11AOXFTsn6W0f6+Pg3LKg8AYa8h5YU7QhvH3qByhkjeJnWQUUdjwT5tk3c8IzzHMkVu7BM/3fbQUrF6yHEq/16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLEvtGJwZjuGUInJS9PLacP482Vjf2UziijYhxnFPGQ=;
 b=KbE1hACcQLe4EUN0tP6JkzcySKJbFj7YBjLOqyTko0KC16n8/OAAbAQE+WhYy0Ub8DoJPc3ezdSmJlKRyykVQV1+Hk96alaL3klMfACcOmGn4m8J5Njgrl51r3E3zJvIo6uRP+OyDXaOs09I8IZGI8AizuSIl2jribPApnXV+ofj7UtW5m0z7nFVdnyCTuu+G9xOcVJmRM3mjZ3vdy0oma9swvajuar8WuBYOak5LdGz3db/Um6vfhI1/1ZxbC3PtSkaBBuuTx6eMdITGfjY6xJCKYS2wFxf2utzqzj6UdinVL80flKsKA+9RuZaaj7lQ4qEKXS2dtU6u8Z4m2REgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLEvtGJwZjuGUInJS9PLacP482Vjf2UziijYhxnFPGQ=;
 b=pi3w3toAAxyC8KcTlZpOoHpX26inCpEg2vGib9/5uqGydOm66qHIAyhFAsIfNB/SFjjpSIYLa8uIYKfQyZTSVfEL15sTqx5adK67u5FJ1inD9wLK0QXwU/lnsLtJkXcdxMqMsg8lzpbkoq61cLd1z2u0ac0UGoG+2OiwiAcHa6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by PH8PR19MB7093.namprd19.prod.outlook.com (2603:10b6:510:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 19:30:11 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 19:30:11 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 6/6] RDMA/umem: add support for P2P RDMA
Date: Wed,  5 Jun 2024 13:29:34 -0600
Message-Id: <20240605192934.742369-7-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605192934.742369-1-martin.oliveira@eideticom.com>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|PH8PR19MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3302fa-a446-48fc-9457-08dc8595e9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WoUhsWdI3dWrJg9T87g52xJSlUVURxPCcyyDhKPF1hhfWr8myBzRA5TxcToF?=
 =?us-ascii?Q?IkXO4CEq6z2AA4gT9+5X9m6YciHwQOu3jc5sWUEB4eiIsZe07mUT+HVQ5o15?=
 =?us-ascii?Q?aaaKxJoB4tF0kowb1vTLXnwcxYqcUxmD3BYZ37Bg0bGGov2L3j0vTzImBJ6g?=
 =?us-ascii?Q?YkgXG0pNBxgmGH6CO4+kQu08NPwKnwHZRq+j3pAyp5C3zrouhUsDh0pvbu2A?=
 =?us-ascii?Q?H0O+18T56VaW0qkBx/TatrXj+u/hilDyw/eRpDQ3ad5xCk6NUT5eYpBf3666?=
 =?us-ascii?Q?QVD8W6Q9eGSqOS2SZ7Dk4LDxfRdG/4brXy4mcQz5pQ22QAg9ZsuysHEbLQaC?=
 =?us-ascii?Q?+dViv1riocolLlmmkiVGoe3jrzskpFnHRL7DfYgezj2vPOMdCkx5t1Z2quL3?=
 =?us-ascii?Q?XA3pOSq5eMIa2W2m8E0qdgmKTgRUChx6hJB0MdkKgYhus4IaWIAIwvzjx2RN?=
 =?us-ascii?Q?yJHeW7O0HhnW3ZOhMgZ11UPlKKmXplA52CUy9mFitqpbQgd+2KC65HLH2nFK?=
 =?us-ascii?Q?piIWcFu+OVJqUd8GugrUPZyoYu9ZicRqeWdJylxiiZAOWy2liPq2E4755JhU?=
 =?us-ascii?Q?nXsuyCFQ5OdAdz8XOODyd1w1JCoXUsJHBVLTWFd9N4vBPuZES8ZGTqKzohlZ?=
 =?us-ascii?Q?Y4nK6YXoOS58YPtn1DCkw2GuP0vSyXM6PL/9yrt+hZ3gDEbY/jJE2ZHxhHrK?=
 =?us-ascii?Q?qOxoGPkzs/la04X0dabBcEGactd90WO5YbwjfVD+5iRf2X378MoQ1j/qO5V7?=
 =?us-ascii?Q?t6EgYrUUaRcN9qo5irYTI89eTk3o0Toa2nFqqXFTHIur9zcpXYR8htfFBli0?=
 =?us-ascii?Q?75H6x0CAsTSaQvGys8Eq+dlGDU/jOKZ1q6ZLBmJ02wiorIizJSpJ7lwhCLaN?=
 =?us-ascii?Q?3TR7FTS1Lhdq7J04MetRvqCSZT7UV8lRthXWz8SvmzFS2ZwRNWeu9WEbGJwU?=
 =?us-ascii?Q?v5K2bbGfFpFaap//MT/DEdrFuS93TxH6tN0muHQUX//TxzCHN5v8YqlTrWi3?=
 =?us-ascii?Q?lALbAIo8LBJWLr9S3yhouv3Uzsf8dKxMq2AzJcf1bygdUJdUf3Z0cOWZV+ui?=
 =?us-ascii?Q?AcE6fC26TaiNEsvlz+oYd9Omt1cJuktDRYDTf/9d1lyW5hkj6b5eNz/MFioL?=
 =?us-ascii?Q?2eOcNLoaRDlr5ecCosUYPgH2WutHUMoSIgFsn8+ypYcNG8TjyZT0Y5XQG02Q?=
 =?us-ascii?Q?9eooXHIXSxr6Q2GlExqQ2oM9ykvIaxZbnyYTZjRTScDMg5qEbl4KJcB51eHV?=
 =?us-ascii?Q?WsCCmFK7Xk4XfTyz5u4LbIhNf5y2CqgWu/wflhHlnaghOtUU+UarVg1pd83Q?=
 =?us-ascii?Q?x6zS6TdlBbf5FHsLhAjzDP+ZQzsq4eSItZRKn/9sfa4gy3qaJJIA0C5XTEOR?=
 =?us-ascii?Q?Y2ZqvCA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VwS2HTB3sluArf9tP/AMjIZe8Jxn2fndAsKHv7BqtII0aix5KJf3NgL/xP2v?=
 =?us-ascii?Q?A1sdQit89Ye4uDZvLWJyjZoT2QfmEaOfR8JzZlGebpJQBRIZSftYhVIIi3WT?=
 =?us-ascii?Q?aCi943r+SNxpYbtU/VO7YPotIjvbHRJH0s7DVuCm8WYTgyZ9ndXdM2GYBrfr?=
 =?us-ascii?Q?Ax0O1nOzYZGVJAhdpjNaifPV7Xw0IqopVxEkuUaiJRfP0xBcpJFF9o96NaZT?=
 =?us-ascii?Q?uPdR8t1+MJQVlSWdYgXBsBOqvnLSvoAw52vNAQRdbpApMWk8mLuX2wywCPjR?=
 =?us-ascii?Q?/5ufTKaN/VX3YycqXojbhTqsURnjUSn//tv6nLQDNYJCKEBhGFp9sSLt8OZM?=
 =?us-ascii?Q?KIyfeYZWkh6YbP0y0b2wU1NNlzNokfF/R92hS26Wa+xlcCQIx9Mhjl4OZQT/?=
 =?us-ascii?Q?9KMjx0trlXUUeCG5xtK5dYG+ExUThszBq1YjlExblOShkNCEhKFFPQXwPFJ1?=
 =?us-ascii?Q?z/rFzZUn29pNNrUhtBw11bwLNR1qVpNK3ZmKuZShXFDTq1sE08d1wduhgC/2?=
 =?us-ascii?Q?nQruvom9YQHA8eTeO3iifNjgSNBk0sFASNy5EJE+IaoJr+C5YCluWpkMUykO?=
 =?us-ascii?Q?XCXtYEctyRWK/AisG3sqZsV1YpRRTCNK7t1TsyuTIVXHvH7z2FRWMRYNalzu?=
 =?us-ascii?Q?CgFwxAWC2So+22EZUvilnMmUD9lSwOWbCdVZBpPgCNTwt568yhd0W0OFAyDd?=
 =?us-ascii?Q?v4souxmopQ/XT0LAQnt/VBjJrqMdwsrXLtlJ7o1jIwkqZE6KQiV/jsRzFvmF?=
 =?us-ascii?Q?xeOTjHf2YkKg5Pi+kGpP0rEN0rKHX7xISlaSm1zu8kIKCdcBKLKP5DHiS6vn?=
 =?us-ascii?Q?d1eeahteF+rAHukOAtrG9tv1htx73WL0h2Bt1SBwl3PC8PQtEecwFRisqL0r?=
 =?us-ascii?Q?5BzJtB3+KWr5ySQNzo8Y+N2jDo4rJr0GAz0qbB+63faZHd1+vuwdRKWG6XE8?=
 =?us-ascii?Q?jXobF12cgfBzHPCsyf8bAB+0L8jZyzX1uRwmtkR3l+vnSvPqpJDkdPC7IQml?=
 =?us-ascii?Q?Epm9V/JoIJD5cDokliDbM9n6E3ALgEZhne4026gcdoBGtlIN03Bef7qiAqGz?=
 =?us-ascii?Q?ShcrytVulkHxOVpNFTTS9MiWdrpjO6oazCkzWNZZqXWmufd2qV0zDeXhs/8z?=
 =?us-ascii?Q?gHvlRIeokMaPUtUIYhGY+/8CsY2p9sCc845hyob4ZeENo8PphiG+KxObq9v0?=
 =?us-ascii?Q?mRoTpV86QEWR+ZGtLwaDWNMjLkl74C2wTpXnnfV2qa3KyDC+BDvqXS/R3nHz?=
 =?us-ascii?Q?X/dosdyJwDcIkta/EjY+ZOy5ZyQlNQ7hm0M92eyt7KEQTV4ChNw/ywYJpG3I?=
 =?us-ascii?Q?A+kemtRnD9NkPFbqB1nmS2mWR+mzXWJ9GylmJYtC7D6yvUdxjbb5nGCQkdvN?=
 =?us-ascii?Q?FsYnj/Id3EPXveofN5QxVBFAqqnThdO/jUDFwPBwVPMa1rhCjO7mTT3enudT?=
 =?us-ascii?Q?nnLYqYWh+f1hTI77Kl+AzPLdxL8+2l/2MPdRqoNueQqr57WGtJha6BOPf/lT?=
 =?us-ascii?Q?+RY2K/HMZZ+0YYHwvi1a5JRShA0jenFOsuwwtDvSGIygwRBVYexdcfAgjXsw?=
 =?us-ascii?Q?zoz8yofD6Lj0FPrXa+Rg0DEM4g6/J1V5kHWWXgnaXVjtAaizXTXCFTpxlAIJ?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3302fa-a446-48fc-9457-08dc8595e9df
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:30:10.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW4vfJjQZhLVzHXkMV3OJtREdxV0qWStmNY5Mhj3g+/P+PsH5Ok55ex2XALbpfaYTEzPgsqjRzbj003OD5RBNLbpgz9x5kbuzKMr1z6RIeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7093

If the device supports P2PDMA, add the FOLL_PCI_P2PDMA flag

This allows ibv_reg_mr() and friends to use P2PDMA memory that has been
mmaped into userspace for MRs in IB and RDMA transactions.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 drivers/infiniband/core/umem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 07c571c7b699..b59bb6e1475e 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -208,6 +208,9 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	if (umem->writable)
 		gup_flags |= FOLL_WRITE;
 
+	if (ib_dma_pci_p2p_dma_supported(device))
+		gup_flags |= FOLL_PCI_P2PDMA;
+
 	while (npages) {
 		cond_resched();
 		pinned = pin_user_pages_fast(cur_base,
-- 
2.34.1


