Return-Path: <linux-rdma+bounces-3651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B52A927B3F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 18:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D332860C7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623891B3F2C;
	Thu,  4 Jul 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="ao5uGO4B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2103.outbound.protection.outlook.com [40.107.223.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252D1B3F09;
	Thu,  4 Jul 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111079; cv=fail; b=OtrngivLc8StZCgm2HCKxWnFiGXZ4xth6MsdRRwYZ/YO2tfVilyN950RNPVA3ZTZdhf/I8vAORyd0iNvKq5I0JTTf8kLANHxpZEroTcsJ6cqQdmllyzsDoqPyAOqFExddgRDRwvVbxNNn+Gqy6k0z+sqc+m2mnIfXtWs7fdvcaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111079; c=relaxed/simple;
	bh=szLQRnqhp3lsW0d8v40eokUGOw6zDrK50Xox6WfGvgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCL9TIDHG1PutU2kt5lbgHBTosBaKHZSj08YUWMiNBdbgKNdsSXxkbBBtgtfApeESyigIu+nq45MoJoWiZQavddndvTT9p1Bb7psDf1PN6nyQczSeI1nyx7Qb9ok9d5SvKmMGcMkfm6uqF3bnmUmxQnH8dgKakzIXHrBE6sDsGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=ao5uGO4B; arc=fail smtp.client-ip=40.107.223.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NssNFLK76PWVM8nRhYfj98qgVcJwUN0Z0kLLF3Nib9UBGU5kS/x6t3KxY/DJzr9iZbOUMF2aC+O2PwOhOz89swGOjvO6oIRVytbdErjp1kiTzJ7nmWhe/n0+tD2MhQyVcT39Khur+1HRpISTChIkOBmobkrffhloEAiQla0NXyV5ln+aiYof82SRaI1qfMmmPHhFAOg2drA2OEfoXGZ7z6hvAGHL2vjB6CIuy5TLs0EnlFa9ke2klQfiqJSj4187vS1/7PQoZjcveA6lJV9hx2gDRijTIbO1tW+ankSj+Y5jq3VNGexEY6KbqtoepwGWTRrw7QjT+k7hWN1564q1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YueMmbvCvTSA1MKV+udXlu2nutuaCG4yOb4CpEEFNc0=;
 b=WKmeA+GMx7yTMbGvUrDt15a2Cfws5E8ACHuWZ869DUYvRIFOJthxWVOgSbmeJAyBFXouE/+3c8c3diMW2CVu78bQXp31J3AIUIaPwiXrMiaHu6rSMlh8989Ex+RZT39Sm4ckfTs9GNW83/ZiDYwR5sF4Mk4KJhEWT+7iigUiBgPi4e0uz7uWBDAFMvShvdknuJ4fKdZpB2lYu1GwYYYNbAn3lzja0TpFu1+ptvO0X9oeLJwVPnq5Pz8yL1OAUy63j9vvbaBv/HvWLo4yWIOEifruuetyzrRm61lGaNPUB+jyqJbeE0SZq5TSCJNfM8cI1RZs2zQ96hQuhlYJItrnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YueMmbvCvTSA1MKV+udXlu2nutuaCG4yOb4CpEEFNc0=;
 b=ao5uGO4B1MVpMILxKMNbYBN6GzyAmPjGCSnplrCTjFWIHvDxBJmup+tkA7nnLxDo/LCIk2ekA7GGT1n6e9l7odt3GXMLVoTGZMN4sj4IQKn+mo/25xXgyJkEqhQANpjK/eB3TAQAwnlBpPqXiFUZ4UZAeYhpEP+xu67nh8hrWkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by CH0PR19MB7850.namprd19.prod.outlook.com (2603:10b6:610:189::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 16:37:52 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%5]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 16:37:52 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 3/3] RDMA/umem: add support for P2P RDMA
Date: Thu,  4 Jul 2024 10:37:24 -0600
Message-Id: <20240704163724.2462161-4-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
References: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|CH0PR19MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: e5de9dfb-cf45-4925-6519-08dc9c47a5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T46nsiwx1A7Y1lTFHcrR+KB5C95vi+7pEF/KvWB+habevjHSET3dlp43hu6j?=
 =?us-ascii?Q?oXokqmbZAFgqqso34+hbMpl/QQqt/4LCxJiR1XK/h5yH/3KvA5PogVImG9Gw?=
 =?us-ascii?Q?O0Qy5bgExmxxwBCCUx6JW4h8SEPy8hK6IdDKAOHymjoJhnbvlK640Ga3AwbS?=
 =?us-ascii?Q?xwRC8Ljhm5wJoTNc36NnqcexmkpqN3G7LECO6RG+9XhTOZ5YOdsY1wZXYh8k?=
 =?us-ascii?Q?MR4jFws6cKOKQ5Q/4MiKVLb+SDjAB5EdfhPT+ZbpiRNUuu8DYBM4gbMXlfaR?=
 =?us-ascii?Q?YAU39fVb3CjbUDk5GwIlLGOo5xVwDWnfLLZCCJJ3YAb2gn7auei+r0+3j3zc?=
 =?us-ascii?Q?Zg6mA19vb/l080sg8p3o2/sSr9imVugg3qfFeMWOAMMIAoQVmKdPiDmDYopC?=
 =?us-ascii?Q?k4xcSFt6ELSfGrqNhGirAZyRaHeFTlo/nE/gxpwpR0bIOd6UNmSTZb5QR8jw?=
 =?us-ascii?Q?OyvMRuDvaAHxgGxi9KDgOLRKGpF1ziCLO9mbBnIJwZowi/GkB5jaiTSBF6gq?=
 =?us-ascii?Q?bLc1CF4TpDz6QhFZvDldbIIfw/pmh0ZVUMSNkeU0YZPtnvCGO0sVISBipizq?=
 =?us-ascii?Q?26W3JDVhWZ8Cj2nDp6awxF065ujbvk57A0NSeUnGfZlPO74vOpOLozw4qQC/?=
 =?us-ascii?Q?hoEXx/8u2Sx8J6eTb8+dBKNLJ70OvUgj8gm9npAME28tCdCZEwWKjSqgsSOW?=
 =?us-ascii?Q?DAkoq2dPAYlNZvipMUc5jSbrhNrCtLPO9aYo79T8HUtxsqq1tRsRvrdNqoOB?=
 =?us-ascii?Q?iElCLQW6NIOPYvOhg0r356zBuNKq2VOgY8b47V9AyfWYXcO/NZ8otD+U14D7?=
 =?us-ascii?Q?VqjsSSBsvI0e2jI8Phd/n3SQIej1aqe1XT7OPUUD4+GD+uVCkhBeH0GAFXy/?=
 =?us-ascii?Q?6MH2Uu5abprUkV7LMDuHIQ2Ga4cywWJ4Wlcll4Xk+4wvzEazoWPVJfzPt0m4?=
 =?us-ascii?Q?oz/ct/068VQZ7POLyf7NmO69I28+0Cbr0uVbdznbix7+E0YvXDqgtOq6jufm?=
 =?us-ascii?Q?aVNWf4KxBsItMGtxjChAfrKm9kOrvG0manLvsS+E8PlU+k6p+3HkDvk8M42w?=
 =?us-ascii?Q?lE4hThpjdFYBeJfeOGmicDrkAP5H+S4ZypSPtYJP8ME9lJ1/6tyv02mFdoRc?=
 =?us-ascii?Q?kqEyH2EMSkXYAo9LVlqytngKFyJ8yJ4pDi66ptvOoYprn23g0TvINLtushMx?=
 =?us-ascii?Q?2j+1siXUonroewggFS4D4Cn05r4KmMJheMLf10iZ/6FTpb2i0QrBGuf+iklw?=
 =?us-ascii?Q?2dp4PsUx0VKKeraZ6x5lIj2dd4Ff3j86XN5H6EQUL5Qt5j2sEzr3y3P/XfpS?=
 =?us-ascii?Q?D2BSdEXjG0UahJvEEyBkZFSmW1uTthLUY4L/X2YW35hG6LIJ9jyryzkL/Neu?=
 =?us-ascii?Q?a6Ji6yfPDNprDxnUYVZK8VrGFBJstD8EErxUnkdN24TjJEJeDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iYV9ErrjxIeQIOsHo/0csBdP7EmNTFTsUWPXryGmIRAXUkrjpTXY/RXWNGS0?=
 =?us-ascii?Q?lZ1v4YGgu14NqjFvDIrqNpfZ9N6GkUwA2pb1nS3eYDZ19n318evOVZUDBWQT?=
 =?us-ascii?Q?lvJcjETUaA/+8/JmKbiMjg1HdUWSi2ytUIzSiSUjSGp2XuS9w/WjGsaWmFPE?=
 =?us-ascii?Q?MEXijPSYXYA6WsR2G7IChTZqbrn4n60dpLrv+HOa7Q8IsUy9VoA0pT574LLp?=
 =?us-ascii?Q?mJ++5t/M1ehzsJ/6D50O6+bj+o/B/a7R55+jKREp8o4zrkPkpM9RQqHDD6Hb?=
 =?us-ascii?Q?bHc4HQEaS9I/icPnYKwWvnUoCSmFuudWrSFrQxhPyx5i8VNKCFb8I9pZZwYt?=
 =?us-ascii?Q?MNP3sxyoC9pTc0RMCK8YnNPLsnDKZ88/YQNykbJSUEnnDpKsvDwT5C8QgPYR?=
 =?us-ascii?Q?VwJcOEb/0nW8+p3bDW5+mioMTfOEKawbFLZKXwc/O+PI50uWeoMCYAVDzvoD?=
 =?us-ascii?Q?01dHbJudn1hnygccrz+3hnNCpTzkcrjWX/3YE7an2l2Oyu6ViF/OvOUepgt/?=
 =?us-ascii?Q?DwU7bsgd6OPxjTwi7HQciTqpbvICRkwJua8tzPY4QC79iPTV/diCGJnWUQV4?=
 =?us-ascii?Q?6qa0tHKhallCyGeC91HAuJG8gPR6SySAiNDNtrYrV5uvSFqmrxxfOzKwVsou?=
 =?us-ascii?Q?rkdW89gJAO/oSnjtRmENN4on/upWe58KiPqcEwQ3nyIAzK0gyfPaIDv2VpTm?=
 =?us-ascii?Q?D66OqIXk5EuZ8qKh0C4C1c6t/o1opGM1HlRqEe5fwR3PxPXXM8y9vq+UGNLi?=
 =?us-ascii?Q?SHLtuWXnjp5ww/9oDBlsk1RambUrp3jlB0OJj2Fl4V3I+rqt/zaA7B/mTcBD?=
 =?us-ascii?Q?fIKRVZHDGTuEF8fqpfxBqoByyC2HRXC4iA2qBWUbQk1/GiA/9AiEw1viUXtA?=
 =?us-ascii?Q?hApoD0DwQzP5BZ7m2DBREuZKRSdX8ZnY+R6nD3XcRXolpAcJLsWw9qLOXG38?=
 =?us-ascii?Q?qlHiP+oOR7V9j1vT5g7UH4Jlw34iTOsX3BMLmd3p01Ew95JjsXTuFoLDqImR?=
 =?us-ascii?Q?iyOe23wH9dUicjYhf736AtV38ttglHnmVodRcKOoRPAMQyfuMfscRhq/Ht0h?=
 =?us-ascii?Q?+tHvkyxvNjDlj9leWzyi2oiPNjevqKdW8VzRL/u1PXCmvG55Z9B4mivue4bJ?=
 =?us-ascii?Q?QIHGsjPwqj0h+lyXZzvZQcr587Sq/NIwiXzSxIcJmjyGc91vLtV7Dt1fxpei?=
 =?us-ascii?Q?2v+sADJh0VQQSXaI5h1MmVk68SCw3wE2flSLS33b5YFveGxiPRRScQsre8Dm?=
 =?us-ascii?Q?RHAfFXtuYNdGVW6wrmxbgtB9Tp9aOMhx8f92FS6C+0/+zLDbBTYzgAy0BODH?=
 =?us-ascii?Q?2gqETfvZ31drBFqxTNVSGiFgGwGrE9ApPWkcuo0Wj9EBqLHwlhmlwBx15U3L?=
 =?us-ascii?Q?iMb8xAsDKrAdGUIcp6nEv4poylYQHbma2CZyWXgwahkLV3GpPLjJf1G6mD/X?=
 =?us-ascii?Q?wcSdPWmufacj1ajv1HRTBt0HFlHtdPvE9TTwnfqNFmzxMJfxiRp1GpWC7khV?=
 =?us-ascii?Q?ZtM8lIbg9Fk9FX7yIaVwSOfqi/+b4cwYq8hLKyXK7ull66q6GiCVXSYTgRh+?=
 =?us-ascii?Q?budvZHkmd2NPKGC7zSdUAhOrI0vO8/q1FE7D0iIoP0cN9EqLgCDh/c6O7ByY?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5de9dfb-cf45-4925-6519-08dc9c47a5cf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:37:51.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+csYIwx7YAmDc0SyasvTCBKH5jlY56NwjLs78GcE8GogcFcGy10XcmUwRRa9efwo17qA1jb+inwu8TKWqw4AeO4JVyYpg8oKWzAioeQk4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7850

If the device supports P2PDMA, add the FOLL_PCI_P2PDMA flag

This allows ibv_reg_mr() and friends to use P2PDMA memory that has been
mmaped into userspace for MRs in IB and RDMA transactions.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
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


