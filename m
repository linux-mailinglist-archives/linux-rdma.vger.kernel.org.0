Return-Path: <linux-rdma+bounces-3069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA20904396
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 20:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D80287889
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E458153835;
	Tue, 11 Jun 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="QTeiy5Vg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F071527B6;
	Tue, 11 Jun 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130492; cv=fail; b=QA1aLjyvOeWMZl0ff8w8QfnSfXgF8TSSKN1xXvVxoG7V01iOIJM3va4IOL47JFZpCiJ7beDVHFgNIsJfeGp/3AKKvA4VD5UN6B7mtCEkOsh0NC2XxUTsV9eBGEMGFMCO3bAp3n2aCg2YCWb+46TputYGK3qsu0y1hoiENd845n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130492; c=relaxed/simple;
	bh=IXBEWYopPoD6OpN+sUxXksUBBaWrlmVhCGXuL2Tnjr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbY4h2pSMcM/xLSf3c24ytM1Ix4QuiPH2QAlE+8wOTT+hbAK97mgtyAHE9WJw8hqTEVSL9ozBlalTUn9laZ+9dq9r6Cg9XWt3uhVYdoWIlvtpOuP1L6+PLiuCbn/jotW4ynifRxl0rXhWlFtMBTdfUfFW3GE2Br3CnwDbds8MSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=QTeiy5Vg; arc=fail smtp.client-ip=40.107.94.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHPv94/4NYgc+yrQA43KgpiQ3tU4Ofy7LopO3JPab5fgIZz7sfZ4v++KFSKkTN4+7d54IIt4fPwQ44hcGyHJKfZ3AAfaT1kNCibDDXs8qhiRrRHz83JBdgezz+kKuqSEAbeb8Yy1A3ke4UThnIOAakS9LN4k/iO9Uw0HwbHTsBlUSYqH1ziEjwMXEYBZVGrodK2RJl5revROrP4xovSVdgG7FYIw+Tgnm70nD222/tQzHBtd05I08uudRw6Y5QDiui1ZuBikoyNnOdGbdR0UuMf2f8rWsO4agdTpQK7NqEKFNhbER/MkhBxHevRZKyYifez0Tc0nEoI0xhfSFggerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvCcvfD9XrahsrBCD4LSwm0IoahU4H0qyoBCobOTXhU=;
 b=FEvOcS295EU3BM0NDOmpLsmqWRFKpR843ESEhiFn+jR6xQCogR3k6l1qoQyS5/znLVG4ngdY80IAtwXOMzo5XBEcyJeru8H083qmUJ04VMyyzjA+IlIttD5qqyFqyD4iV0RO0+0WnhfEM+DFQV4uOI7SFEVg9kT6wYgAWkpktPjOEalFFWbmEEy4eTB9zfgtOsWyezu4guO2ihdzpEEYpaGVMhDGWiLOXotl5HSy1eHAA6x08uXlMAuuWaolvMSWxQ9+8hPl4YQbgcRQx9/LtfcEb2bho7Y1Z5uqpboTALO+crNbgjejMnP3JiyMtIbM7eUL8a/pJS4h58U4Kg1k3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvCcvfD9XrahsrBCD4LSwm0IoahU4H0qyoBCobOTXhU=;
 b=QTeiy5VgaRI/FsOLUlwLFDe1qgC8D/k6PT8t/cN48VAA+3yCw+1Ygy+G8P24csDVhIRHqd21aSl240+u895x+LyzBKLHvHWN7hwnUxBb9u5eFXtw5ZD58rMNFYsyG7sfJEfsBW/213ZPJU5BlYgfTXKUnew7wuZieS7nmusw/Rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by BL1PR19MB6105.namprd19.prod.outlook.com (2603:10b6:208:39c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:28:01 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:28:01 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 4/4] RDMA/umem: add support for P2P RDMA
Date: Tue, 11 Jun 2024 12:27:32 -0600
Message-ID: <20240611182732.360317-5-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611182732.360317-1-martin.oliveira@eideticom.com>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|BL1PR19MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8f2ddd-db78-4eb9-4ae7-08dc8a4439e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9WyAYOuOMhT9KUFnod/oddFU56uiOZt5NRKABGc9HTPlYE1IZmJwmBKttma?=
 =?us-ascii?Q?dUaw6N5jOYulqr/exv1Ao886YxVt6g7p+7Eob2v0puSX6DU5xE37YM8DzPjo?=
 =?us-ascii?Q?jAcPUU0vNStqqxI0FvPzg9Gi3cGPx7VRMH/sgFZ9ciX1fNJJZ5wrFVUsr6MF?=
 =?us-ascii?Q?eYvGUJYw31vG/8ijN+7o05jLIzm9jKMXACH/P8NB45mR55ayLfep1pwVf/YY?=
 =?us-ascii?Q?rXHb6p1pf6feOt/nmQU9iNoHZuzz9NtGmVkU2zSKgAV6NJZn9RI7MwdHg/d6?=
 =?us-ascii?Q?0Z3EX1Rqduwhlp9lwpE2xAVPskdfut0j7th5w9+PyU+AL/CFEALVOFQRlTHo?=
 =?us-ascii?Q?24oj/1yUwcX96aCDdd8MZVS0TNL9WbIrnLmu2pw4siYkNSLaNAbPSPKqOjMM?=
 =?us-ascii?Q?n4Zb2m1QhI4tExS+rE0CWw7ofPwcRod6lSzI2+rEjjyPkBj2Qi9PcJ1f6Fi9?=
 =?us-ascii?Q?93gx8WGY1G3vMrGLX89atgvgLMIjOHIa1kieqHgN51YNrrvWrylwY8z1Zfht?=
 =?us-ascii?Q?p02uUrRIdjpycEJICycF+tsU67TjJn5L4prgBc8q93NH51D5BNpIn10mbP0O?=
 =?us-ascii?Q?ox7tAkQEorwUcKR88Mes202SaMS0RNJAiMEbCYzBkOCT2apoj6A/hztHQUzt?=
 =?us-ascii?Q?APMyiFlT2IGhMpWBWTx2eYkBkDnHqIaNggtkc2pIbqCoNybb291sRIOKendh?=
 =?us-ascii?Q?hG7rNn3qKKVVLrZ3En4Sr8eDK5LS82LivBvl+tBsc7WPLi+7o3qZIKQljSlD?=
 =?us-ascii?Q?FsNCbV5VVwSBjypmCJqyvWwOkGlFnzjmnLwOvKzLfPgMfRGJlij15cu1WdS2?=
 =?us-ascii?Q?9Qt+an26uiVEyMRyk5DvgpDqbDAdiUATv0vRxCtZ38rwELUK0qwFW/UmNmfX?=
 =?us-ascii?Q?BisEWPnwZDU9sXwsacDJDc2FA+YFBTPBFVz2KbT2Mm0thx3rrYv2rO3LizGg?=
 =?us-ascii?Q?DRL3kv1RdUtTpx7ZRGo2AUXWoBp2WYgk+nW3jFEl4+7dnB1+J77zElnlD/m2?=
 =?us-ascii?Q?C9YgcTPTs5aI3bnN/B+3VJAxR80gIscMUCET4lK0KNi7UiJOcydrreYH2eN1?=
 =?us-ascii?Q?YJPMSNHF4HORK1vaPK0I/PQ4SpX1p6z6/XeU4w+bb5ZMoBRvZ6AgNgWx7V0s?=
 =?us-ascii?Q?OFoyPV/lLGeI50ewARvSyeV6247ElzAc7XAcsudK987vTjkrRV8e4twZ7qIg?=
 =?us-ascii?Q?DYg/HL3CxqTa6cu/lkJ5bEArbPJbGIbYN5CygWkeZrJpsWbZc8nL6mONfqwG?=
 =?us-ascii?Q?56qE4qIhyr1Ey1cal4fLXSdPnby/K8PZoc/hcOXLw/5lHAKbtDu9KGVW9Vdg?=
 =?us-ascii?Q?x3CEU2WhKYaW1x/g51fcXipaaJj/BAzMBX3e7/1hq4hw66kc1JtAvInE/ZXy?=
 =?us-ascii?Q?etdX4RU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEy0VCfL5PhTY8q8PXYLsIvYXOD0eOmxZG5GGLayO2B8iWO4JkRI3MyYwaCK?=
 =?us-ascii?Q?/RWruZwY/3vZuP2STXLghIOlscAkNTn5eHtb5Ig261fVTW/k71eOQULZzloE?=
 =?us-ascii?Q?8cZaGY1CfUWsLL875LciboCzAPnpQ21376hBeEla7wCnCEoLbqfPnKG89fXx?=
 =?us-ascii?Q?9sHG7okwSyedlXuIkEYRxaD4ktnF2XQBIov2J0TwdGA+vmQV29l+GCHeyVxv?=
 =?us-ascii?Q?5g8haxq1bes/HFY9e2d21m8qWYQnFnxXIqAvxQFioKmxo/fhzp/H125bew2A?=
 =?us-ascii?Q?6HHuvwg/ChQA42nfAmjOPjrFnmJDgIjYWmw+fUYOl087XONxha6bVl3oFoNX?=
 =?us-ascii?Q?oRsmuBdxcbzHOV+XHJTF0YTdqj+UEMABflg0YtqBR+sbiqBxRSfMl0UMfRD5?=
 =?us-ascii?Q?hDKTQNom1/bmpCE33gar01QwKb8vWSepv4w+SDfSn141rN/7FGGiv+RYpnW2?=
 =?us-ascii?Q?5xseRFJBD2S6lwt7zNS98CzCMLvZrbK+z8LUXLYa+DwetOJREVZvH6X/pEul?=
 =?us-ascii?Q?dDEbUarUk0MtnqQXEOL/39arrBnEQmjD9OgsLRgZ13gERbmE9R1LI89cLqfw?=
 =?us-ascii?Q?e7WN8P+B2N2ogZonrn1p6A1aOlRqNrHA9bfxqtcGZDmyxqpyCnZpyVmhmnKY?=
 =?us-ascii?Q?GdfLiJrYY2FwcNPpW5hPhckuNAmoStBwcw3qc9lu7fk1DEeTiVZefjrPE/Ev?=
 =?us-ascii?Q?YneXGa+DVmBuh8NBNUmmN5nlwvvr409uYH4H0HKAvkPzyfd1MYz0UK88yHsu?=
 =?us-ascii?Q?p7tlPfkcxynP18QvUz81tyGWaxmf+7I/KG6wHTELqBllUXgxEECpp1EyDhi2?=
 =?us-ascii?Q?VHIbqh7LEbpx2zU6/HBHNr+RDV8aJy0Y5e6xXA+cMrTPFF/9rBWQxgFaHk8A?=
 =?us-ascii?Q?eBR/fi9ydmVVBxIMg+LBWUBGS5NV/JRK0GfERgJxViJGOx5t90mM3EmAA3Lv?=
 =?us-ascii?Q?hBCFEbY1HSEw59SMxi/8UNn+arvRmDujzSr63B5bB7Z+tZ7kxTD65/5BFzwP?=
 =?us-ascii?Q?h6my4DU2a6gqXyE8SrQ+6tz8qgWV2DyCSGhidlGMX73QCstiyXQe67wxfRvC?=
 =?us-ascii?Q?S/srf+huOt5tlq4YEHMtNMLK/GBmd9ztn8aA+Z+jASt8OAlZ2Te8jdOZWfBq?=
 =?us-ascii?Q?KmVyy4ProVv6emA9NAJNrt6TuhXnyzDaOwzpmENUKKqMCnh9RA6G1KS7jOAd?=
 =?us-ascii?Q?P3hubEDxR99HEzIqqhhngDyDmsL5030uRoYsqmzprgHjP+VtYoy0HVFIjvng?=
 =?us-ascii?Q?dvyUZQEwPrr9Ybdjv+1v/N9ERfSWZ59k3TIwplMnOTgznuC2+DKa3c6Nd3nb?=
 =?us-ascii?Q?deM57erIH4/TIl27051HkgKnFjHfNIsu1mYAYE5ts8jX5M9ewXLCOBvFwric?=
 =?us-ascii?Q?67qm5G4rfgyRljXDYSExJ6BdJy/wclyvPV2LWrkgP8QGv6m31gwJGiBCnZQP?=
 =?us-ascii?Q?c67zSdkWcR7aOJmY2r+EufxBPyAfxwhhmKZdXe3NR10gPqkKL7zxLOQ4gorn?=
 =?us-ascii?Q?p/Inc9K5UWos9Q2BLhfvX5TQ/VtPw16MG3X8Zogt0puTPOF8MAiDdXcPGcPT?=
 =?us-ascii?Q?w38rwbC39lifo5HhF/4m+qOOoK7NlE0lGfoCXsgWuCvEyIxEhyRy9VsXpgDk?=
 =?us-ascii?Q?o2TQQl7CJ+IELPtPuB7DnZI=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8f2ddd-db78-4eb9-4ae7-08dc8a4439e8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:28:01.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9PwHMXPkw6nRjOAwcpP0DzfD8sY3KkEObxz6kA2K46DzQySUUXB/TGghyLVTsiTMoIKKtZtxnvIejn7k5By8ThWnjjIA+gDZpgP4fX6evo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6105

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
index 07c571c7b6999..b59bb6e1475e2 100644
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


