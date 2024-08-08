Return-Path: <linux-rdma+bounces-4256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A200D94C46B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 20:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E806287EF5
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E7615666B;
	Thu,  8 Aug 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="e2SwepBc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2130.outbound.protection.outlook.com [40.107.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97A13D63E;
	Thu,  8 Aug 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142041; cv=fail; b=pJY+5wA/4wdxuz6ETR160azdp+lX3mw0DIP5OgHNN6rMhfSUo2JUWEBiLNPLdccFCGR9yJt7Ji6tWfjdcWGA3JNBpVPZeVXixl/NOIrktrDtv2sNQSTGaSaLyoult/1vV+jrzAX6AfetswGf1XAvcsT52Wi+IU4ET0+3E58iQTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142041; c=relaxed/simple;
	bh=DAJxoPvAhAmZO+nhmrqzk2QwoaGJG5l4HRJIVEMfJFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AZfFRG9hKe/gGbJEkEgoqgPQrytKZmaegWR33JUnnPNcj4wAm9VDcHMMzg9rfrcBchUVc11NqAE8oBiYe14rloFQXmyKqcVGy3MQS6fhlZSuYN+qX6EXfjv5oBCf96ZEQmBJdOZ4E1tnzwj26j/th8Iw0qmjsFiJhtawGOvVB2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=e2SwepBc; arc=fail smtp.client-ip=40.107.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBth5Ki4owJPn3df35ss6Ii+bPwPaxuWZ0/HzNxtUcyTNKtx2i9jvJTtsxtSOnVg5soj7HmRcUmOoKI58b8g8fCALXKeu8W5M220hf+BbQc346Ey1gFMIXnRA5+4ul6iyMC8TiyEA8bUSu+/nRs/5JhrU3oDo+D/Xu2+6jHd703ePSqEE3qFeT1YldytyWqjHfu9SC4MHaxBo6IGme4FMbaCp+ni2Ec4+EZDxlujv/uNi3Pipr62R/iqqppCNdponJkDajtJ9SSPskkFtzeHyWCcKdXo5jW2IdfugqifTqluExZCmRpuQDWdYaVQNDuaymHlvtGMMOLPi2p+gULyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM+81ayAtTLFvHOakRNJe8YX626jXBDowTU0GcX7MMs=;
 b=KSt+7Lrr4HdS52FAwBYoARjzYMD+ITrvFDRbm+qgJ+GWmT2uKQDqxVXFHqCPMK3rdbXytompydINjhxZ6UZYPqNCvlOlcH/gucQ64NBvwNyOFIPdjY07GixIDOd8cencQ0oeS6jTSvpvwR/2fCBD/LCmyINAplfT02+P5r4t11q1arDqRfpXBek4irN1yI70+4QmsAMGhV/bwFurryZHd4cY7ijn/WZGk/81qhfKyzvIxSLCEHrA47Uo70Mb5LbwTI2yIEqscLMCbZ8l6S5ddmMsDu8RGChKxP5O0Q8gDBQ0FJVEw+eQ/uRI+78l+fSIxsQsulGWztgRYyN+UbqurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM+81ayAtTLFvHOakRNJe8YX626jXBDowTU0GcX7MMs=;
 b=e2SwepBcGIAeoOtAr5+TT22sQVWqBlEhAtqG2Xlw8Wd/7rP88eF5Zkf4VLHj/niPnqnuVL0eECSrdW5eeAPxuWmza4w6ZXk+boqyzpQIBfqj6fG2lvrOjq/nGGdXNFF6bXZIzi/m4Gq17fAVLUolWycEWTqh2BTfZp77KfYX+/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from PH7PR19MB6828.namprd19.prod.outlook.com (2603:10b6:510:1ba::20)
 by IA1PR19MB6348.namprd19.prod.outlook.com (2603:10b6:208:3e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 18:33:56 +0000
Received: from PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849]) by PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:33:56 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 4/4] RDMA/umem: add support for P2P RDMA
Date: Thu,  8 Aug 2024 12:33:40 -0600
Message-ID: <20240808183340.483468-5-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808183340.483468-1-martin.oliveira@eideticom.com>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:303:6b::17) To PH7PR19MB6828.namprd19.prod.outlook.com
 (2603:10b6:510:1ba::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR19MB6828:EE_|IA1PR19MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2d9e41-c152-4c08-bca9-08dcb7d8a921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u2cO1CvDeX53TNI81bLQDi5hhFhenPl1bOdoE+Px+QRPX/ekjgYjS1XXUgMP?=
 =?us-ascii?Q?yPGPnblBBotJsrvotqu2B0CuVvSknWM5aGfG3bXRqkm9ahCSsLwl+jKJNIv4?=
 =?us-ascii?Q?b7EiSuTe6YJa+/9ZkmZ5w7eGoyh/9Ysh+12kWNyfvbW3QWLXP3NRorGhMoRh?=
 =?us-ascii?Q?sofWXfpiBQlyeRQPS0uefRJ73PoRiv0NC4fdG6HIbk31h9YseLQC0DcX+mjS?=
 =?us-ascii?Q?6W+atGXtizyTFVRJhrRkmVUw0UgOUySp5LuymMq0lYtOcQYLC5Qr6I4bH0iL?=
 =?us-ascii?Q?bFyGutkiDIO0yg3o1k1lKnIuTHWOTmVKuRSU9hhaNeZoOjybWNq506XCoPEC?=
 =?us-ascii?Q?POTJV1Fm4xxsssi+pLxk0gxFJPNnnwT4vuGKH1TW7PmPQnJZmoFDrOXCn7FM?=
 =?us-ascii?Q?C2n3CvOBHmBLitlZY84WqiJlPhnuEUFCyfuGbHbPT50w7dteiSgiO3+2ma9B?=
 =?us-ascii?Q?w3KP7autFN9mltQ/N1DZYkX7B5DemeSLFYrTnV7gFjFveAm+J5KFBK5yZX0J?=
 =?us-ascii?Q?mjBU121dafUItrhZ/Xv4iwhZtdem4GVcrDkawHOiLhgn0/jbUDkDdG4vrLxN?=
 =?us-ascii?Q?FZV7oIMDOzFju2YFiTLNuRw5C7yXzGX3vP/SacSYF+ykczDCZOy4/Tl6UU23?=
 =?us-ascii?Q?20lUh7VHgEqYvOpMFPjuC8JPt2v6y80VbcIfyXT2jdVmxV/kcOzgCUV2FGXO?=
 =?us-ascii?Q?o9BZgP2dTaAy0ZYoREBe12zWNc3sNtU/GW1DTpHDbz/sKR5Hh7jPwr7bJSh/?=
 =?us-ascii?Q?NYDYEhPLKssrJVcbv0hQ3MLY0SqeY9KvclIR5IhGDezW7oVIKa3uWObmIFeF?=
 =?us-ascii?Q?BVn5bzqdrMbFjJjc6b2yRBL4YTTIS4UclkOtt/+HGlqMgfsxIEXeap95m41q?=
 =?us-ascii?Q?r6stUA8IAB3tNfn66UnMOI48ztOtHdcRZ+HJguC7DolInmAC+OBAtRihe2Tn?=
 =?us-ascii?Q?a/0K94mDmm/jZJApFN0MwERTkaA1ZH3hmv7aOJMu5Eg74xVipUH328Jp+52X?=
 =?us-ascii?Q?PVCr3iqRMI1K4wYV4oJdU+rh6e+NAbojAxOJDaqqCLjGUe5olX3cL+S9XA6I?=
 =?us-ascii?Q?Izf0Je6mGHqSzMOTSLNqrjY02DVptpFJXST8YlpcsEAsZmEtFDMS36sRHdTR?=
 =?us-ascii?Q?DmxaL2krZ3z5waeM961RSjE6nH45lS2NYilCPpHbt8gfhQ3UOk5ANq/0MdQH?=
 =?us-ascii?Q?h/+Xd0FwW79ak+j6PijiPIMwZoV9AQSoDVggn7oQP9KilYtxZwuAm3yOjqXu?=
 =?us-ascii?Q?UtXdCif/RoK5Of0qPLKE7ahaOKIeHjmXTZ8OHDgcYrg++6KOQ05BnMufMW4b?=
 =?us-ascii?Q?Ak0NQ+zDsNVZEbmXpep/WxkRhMmaNlPwLdbOgBlsyO+o42TA+OJC0oFfVlCo?=
 =?us-ascii?Q?tn5gD1hHNKzHMQPn/u3Jz4xQR1iNCyDUA+yACdTkT8cJVEhPJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6828.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G4AoJDchhPfOk7tlSGE+qTcMOCpjdP7Xnb/Ya163wV96hJhOuQ4njF04LzQY?=
 =?us-ascii?Q?0okOFa/8qzb8mIMAASVI0ZZexqkveh3hbkukWtaUN0z2TIU2KrsjLfmo+0NP?=
 =?us-ascii?Q?r3TL/PSykOqnmRf99cJmwgS44EdP39h6SEjY1Ppux+M2vejZYgIrUz1P2sgQ?=
 =?us-ascii?Q?blFmsX8vkt6BrYNmuY3UdwUw2QCWhjOcW+fHy3vTE0ClIU/erK9BiArgNoKa?=
 =?us-ascii?Q?ls/nrypwK9iTs2K2ewJfLlzqDVsT3I/7bHr6ymQkJj5YdtFT/2P8OuaouWHC?=
 =?us-ascii?Q?zLUS0of2Vvh+G3Y2VfiWoAy+CYJvVJQ1ANHiJodH2f8nC2wdCxU5d1xkzQZN?=
 =?us-ascii?Q?zzK2xeJ/QIsuOjShbjRNMVR7mWfenIjqVQ0u9eW2sLCIQQcNF/SsFncvSHpl?=
 =?us-ascii?Q?Mi2seAqauJBmL0BzAk8tN3xm6RZfa1N7pKA0lx2wZOKlayvOsNtw52hWk2ca?=
 =?us-ascii?Q?vsBDqkNninvaTukAlEeLZK9KRq8unE9gelSK+bZq/B30GFyqeCw+kIe2aTWK?=
 =?us-ascii?Q?RO2EUG3kpGEo/o+mHj9BK8mgi+8n4aCZn8zLa2NTeU//EdufHxG1JIubwR5x?=
 =?us-ascii?Q?26HKUJbGlNvqBy5ZjJOVkukvP1XDuv9aHFPoAABBWRmmyZgvnjErXZEK5uG5?=
 =?us-ascii?Q?d59AY38G/mIgGB6Rd0ODOOytpvzHRVWLNe3s6XpkPQRrS2bZ0MYuHuAYwEOD?=
 =?us-ascii?Q?qYR/y43IvMPeDpnIw7kMv4Bsm4sBpZ/cLzcJUgQrRr78JwNj9SpkBALbV0US?=
 =?us-ascii?Q?qq1x9eF35qk1wv5dzlipS2g2W8dnLK21tYkVukg+Bu/TjfloSClMSwT3W2XD?=
 =?us-ascii?Q?9Xbhv6+BmD34i94yqOl8iiZ2Slh5YykDjllIG0Oud9OH5MfDNAchiEEub/me?=
 =?us-ascii?Q?mNsQAfCOEpyGs8n87+EKeZIw/kp5VjXa8lBR1Ukvogz72DUXRSO81Kpa090x?=
 =?us-ascii?Q?b1VZoddN9TXCeB7ufj0N4GT9OZy1isL39CUZ+9OcTcBgAN+G8apfUwppPIVR?=
 =?us-ascii?Q?e3e1xc1f4lMZMCg1gJVmSQjL9D2vCJqoaKKrNstqxcj52obh7y+TQc61L57p?=
 =?us-ascii?Q?G9l0zxrvHnWvmysShbM8GMWUlA0gsXHDwzRLJe1Mfsl/NvOSaonnUvgsHlTm?=
 =?us-ascii?Q?mXiIWX/YSWVJgIqO7I2jesjUGsKKvxaOOYeKI47cwc36h4CXPCNqGzfYIGbE?=
 =?us-ascii?Q?ACSQQxtyqjsyCUJgyCtYT5si12aqO4i5ZmuxKJOuLSnbPPU+03Jc77nM+tOQ?=
 =?us-ascii?Q?APYAcHmy9BPF6Xfn9NeeybEQePp4JFdkDi5vOpd9XjGv8nxtRBxvT9msusus?=
 =?us-ascii?Q?Ai5244m/1gsjwyUigqaffjkGS7QOFCjWROGzJx7aIRW2Xskc8H3WVJPzqptV?=
 =?us-ascii?Q?lrqRek8O76CjA6+m2xVRTPIzncBu+rcyNV2wlP5BWpc88eSXehX4zgrqhnLE?=
 =?us-ascii?Q?piha1uYBiNlH1OGNCGqHVg0s2dm4KsKhAYVPguX813EtajbmlUMm8tHfEnvg?=
 =?us-ascii?Q?rS2XEQV0dBarPHwBf1UD/0W4h6aJp2TLzKOzbRiyZSTNte8ronjjfofMS4x9?=
 =?us-ascii?Q?qVA9+n8WAuzmITZsPM0WIwr/24YJWlsxyUmYuxXwA4bOJthPgJTXskQY6Vmf?=
 =?us-ascii?Q?0zPWmSDn4MCK8D5Nv5GXHZo=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2d9e41-c152-4c08-bca9-08dcb7d8a921
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6828.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:33:55.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJqWVk+jsUd30CvrPYOdskSZeE5/eHtjjUITK6vp0O5ci4VQ+p6gWPPq8kOij49aDmNnHSzLseG7Gn1NYZt9lq9l7Q5fB22DFTlRjAw4fGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6348

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
2.43.0


