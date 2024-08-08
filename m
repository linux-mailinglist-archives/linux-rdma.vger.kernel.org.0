Return-Path: <linux-rdma+bounces-4254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5494C467
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 20:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F195D288609
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132E153801;
	Thu,  8 Aug 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="RB8UnFDp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2130.outbound.protection.outlook.com [40.107.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF35149C41;
	Thu,  8 Aug 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142037; cv=fail; b=EP5hRPJNe99k3W137Chb6FCorsMngLH4COCsUW6RtUibWurrctCXu+YcIqMKzKJY8Craus5pM5etHMzFAOj9FiEMKRmnxhLvZT5zICnioON1K2GrKPoL1ZodytxYqtYoI6VgKGgk5XwUPFbhdRgxjamuNOuSrepxqNyneHkNe3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142037; c=relaxed/simple;
	bh=dJITM5iRkORZTtRo4geLShzgnFCU72cs+uqaIBmPhQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxKwynLx+T4q7FV2ZmdLsr2ufKIoUncV3w6Zu60SNYamFpt4OFjetgDzKSwTVpbaoYyxOdcFBjNsrsQqa/caIaHUKdEfLF0GujCPSGVo87lP5jCmNh040+jduXZuJ/qbeLysTHt1QGQRSqILvsmkdRF1K0WUU2XM2KXWtXjQeTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=RB8UnFDp; arc=fail smtp.client-ip=40.107.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb3gPNuFAKfM3kob2T7fs3Mg/zNlEz61+NUZl4pUxpqfvDQfcy6Y9ufdlV8Nyed5wcXnGPvSL/CHPtvooG/kmaU21gsVYIh3/+ewSKhVYiF+ItOt0N9/7DrwvjBNr0WYA/s4sGNjv0mUJtxfjoD2S9eni0o0Md/+qBjCtPXzMNH3OaZm1ryDjF7n45jiDYobB0dNUpbK4HCgLZg9iEw079KlHqwkuLGBCiJDIvJ7Zz1f7VQet5SrT84a5EvWk80pdpAdudyklLkxjVEBX/efjCMYC5zNho+hnwtAvsBcVoAWuKkpN+Iacd7ie4Eu182kA76vRdw7MyAoCozyg568pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRUDFAbvP4Wci+R7KuxCrccwPqV5quWpHJXtfd77Uvs=;
 b=kw9djgDsYwDoxd2C4VjVcqoMLa4iilRJAt2ATAU/qlIhgOzXhOX/z1tBKnImTlgXh2uNdU64MVYxVRRXn/Jszsp4rjWRbw7vILA6tBK/6bR2ga0CJ1g8WSruz612//R0hlDUnWF/JQcTUjd04lnyFnSM5AuuOMSSAav0hqYgu2aLcQYFcca/KT+L7ryseuljlZSNBFePCx9VuVukuW6N3n8EQmncZW+he7R6djcGaPmLdWlZSPhmIqPcTlj4IyX0MY5su79xzQ3lSNgVYj0ssAAxl9QGUKi69yqpfsCrU7IXRGJZblJlwE5nBCc4I1NV5bhgvLV/QK43HTvRSbfGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRUDFAbvP4Wci+R7KuxCrccwPqV5quWpHJXtfd77Uvs=;
 b=RB8UnFDpYGk4WIvEaZYq7Px6GoybhdhyGJDGWCjwLHew0koqhJzp3s/9NhISYYJPD8NmWmGAkblVgd8XsRG0CgwrZe9lVGAPlRJYUSfxm+ikjXc0dG4NizVkwoCr2zV4WqDRH9Vl8RJ9+zbeF0bHIwvrrGZeawnMwvYt2HylqKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from PH7PR19MB6828.namprd19.prod.outlook.com (2603:10b6:510:1ba::20)
 by IA1PR19MB6348.namprd19.prod.outlook.com (2603:10b6:208:3e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 18:33:53 +0000
Received: from PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849]) by PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:33:53 +0000
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
	Martin Oliveira <martin.oliveira@eideticom.com>
Subject: [PATCH v5 2/4] kernfs: remove page_mkwrite() from vm_operations_struct
Date: Thu,  8 Aug 2024 12:33:38 -0600
Message-ID: <20240808183340.483468-3-martin.oliveira@eideticom.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8fe6235-4ead-4990-611e-08dcb7d8a767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/inA3VT/8mfOp8ld6nKLqNGAfmT2/ixqrT3JXm9HT54veh6XbiIINy7ywt2?=
 =?us-ascii?Q?BBxrLfOmbQqZra3Wig8Hjp0rCs+8UevX0MONWDEYlPOQSVtDTT5oqQ9z9Zkn?=
 =?us-ascii?Q?afUtWxGUdsunA1NWGjd0L+UmykvYU1zQeqSvK6KUtJfMkAA/9Od1ULsbqKh1?=
 =?us-ascii?Q?E+qWAPd47Yly0nZKes6HWrhXhRTBdy+fAf4BS/Mv0rXYdGTu1bjRLheZ2x5+?=
 =?us-ascii?Q?ybzPst1mL0OVdmSQYhx+3px6CpxFntXWs7IfVF4GMYF68pk4bbnsHGkGpd9Z?=
 =?us-ascii?Q?tZEULgBZKESKclQ3j3oejLIWGBeUt7W8xj7sm5ovBQSowf3AEnPg75KZ3PGH?=
 =?us-ascii?Q?QcHokncPhQCKIh4daoW55Pt9ctbAZCcXXWrLHKUWEKKcj/iJ43ylnU13ET23?=
 =?us-ascii?Q?s+EnTUR4EKHWsFpqm7F9zPz7g/S4R4FglL5p4/bweNAiHTVtP/CyCqD+QyDz?=
 =?us-ascii?Q?gFw0weXUOuBstPhNFWtclb/veEVcrPDImWonAk1RSo7c2IHwjtaRU8Y1dn2h?=
 =?us-ascii?Q?tfKJ8GnOm9tp4hJTitsHlsDF+Jo6zOMFWJWmR72zGOOFxsuXVpWc5mHAquQY?=
 =?us-ascii?Q?EJh+u9F8OhX8hTkjILQGHfqppqYZUSfd6mhq+1dtdOliBcb9GwWIjg3fTvtX?=
 =?us-ascii?Q?cCdmdrZge0BRlV8EsglApf5S6jJxhfSgXjKMDRw4GAhz/sYfx9TfIh5u4gZ1?=
 =?us-ascii?Q?CfLYt4x9vB/28aCJqV0AuwqtrjWwI2SvFN/Tr3SoriX89YI7FeJ5CSVMmnE7?=
 =?us-ascii?Q?vWqcGMOhsBVboBz1RxHmfJYsGGuWS0qjuqPbutaCpyqt4ILnVErprw0I22Vi?=
 =?us-ascii?Q?nk+DqSbIqgLa2KddOytj28npBUUN3yC/mhM56xPJ013HLlN7hYBrjxQ4pdfn?=
 =?us-ascii?Q?y6wmXszlNmyrhnGwJNCVFPo3B0YEnFhBJMI55vhdBXfdzJ5Uk0LKraIMac5/?=
 =?us-ascii?Q?DxDeVIuGGuQ1GNz3QNfbcHq3P1lWMTWoeuazn62Fze13nAUGwO+V+QyWNrU1?=
 =?us-ascii?Q?KRC0i5mhdYqsdvWE3OQ/KNOXS+2ESlsEBtTQGVfZoDx88TfyvDaCatS4fsrh?=
 =?us-ascii?Q?AqKGO2tCrOU2QlETf30DsHGMlaMaZ0vtlQEeW0WeFMhtP5VZs4y3BK1i9vX8?=
 =?us-ascii?Q?HyOVtPneW2stOpZ4jyRTQ30yI89eVxVsckVepBISgSSiUXBwnjjqcdZZiNS0?=
 =?us-ascii?Q?IxBRgmCQVbnn/cnW/m+eLOETTZfNM6LE10pQt+sMyXpNjM1ZqfWNCwtTG5KH?=
 =?us-ascii?Q?HGbKiFsODcsemcIpmEnL0VvMZajkiTno7mwLxYfgrl6VSj7W2tShXg24rzMR?=
 =?us-ascii?Q?AaQNVzupJ/F4QzMnc+Fvr1VQ9nwMidwaeWJ4Y2MzRXmzVXQgZhBEw/7VzEbI?=
 =?us-ascii?Q?OhmQmOCX1IKgKIuSUl4Q/ELuKBkFIJmF69jE1WRUOShf7zWAyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6828.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyf1WoVvEStKZSmkiXOYLR4Bd5OaDzNbJTkW/CdtySv9bR3pHgXjJgZDWZHz?=
 =?us-ascii?Q?YVEWzUKaTWIKNfJ/WZZcNfDIJ+F9nVmOAYNFW/H/3yzv+wMBsWkzuOC7YYx0?=
 =?us-ascii?Q?z7JYY668brQsWDeIprt5/awrMYC2qHuYJrHrT+enKPjlcg3yVPqrMojNNIa1?=
 =?us-ascii?Q?5bzbpgkky8jovGUY+nEjkAwh8xnts3LZxXPcpp1sERAz0tZHH+auaQhm+dIm?=
 =?us-ascii?Q?D/ocW86oceQxCc7EIKWLdKjIoWtLTe7jjRDauGb5V0Lmzv6EwR6saWfbCr8p?=
 =?us-ascii?Q?McKNBBGMfxx1+qLMJiklg6gJnfcu/mpz5s+OQczvU4+HZ/8jMDWnmmble8g7?=
 =?us-ascii?Q?eZslepeLBpqFV81zDb+wfgIwZzMrKO2jCiPgpaKdt93lXUbZiTVcLwYgFP0Y?=
 =?us-ascii?Q?P9sssAAR2RmbamzJSL9I6iev4g94KanGjzFfhLMSDjXnoJexABAATI+Hpk1R?=
 =?us-ascii?Q?KC3l7jVitNwWmjmkNN/nOMb37KJrZA7nnNbDX4Ok1FYR9uZ1Ixn7XGNvPqQD?=
 =?us-ascii?Q?hUC4JAdVbvq22EHcG3sPjkTM4uAE33ngyPfCF2uC+2d34RwwC86NSRiA67RC?=
 =?us-ascii?Q?H33U2v+HqP2t9qjAoUO0zr4Uv/o1X/o3My1ukhPrPIM/OyP/y8GsH0PeXpCb?=
 =?us-ascii?Q?5MIMf2uzQRJSvMIGeAx2n/6yjzuRU5P5dcSgIVubdLs+d8bA/gGRqv4UMWUq?=
 =?us-ascii?Q?hFSlPiEVZzGpt9c3aOD2Fsgba1Y68VaQ+M5Z2RepRmso7Wtc020oPYFCydsH?=
 =?us-ascii?Q?8e4tFHENK3xbf2pKq7fDuXtnJJdg/jbcSj8kcAnMe4O0MTIx/O+pyym3J+Lo?=
 =?us-ascii?Q?XgCP0pdfoxp6rBSascjKigtPNLwbJKKEL1SSLUqN3JqKPF0TWwVR3nxxXC5e?=
 =?us-ascii?Q?EC70r1XfJRBxIFSE+neuNAZG8eWMkIYh7+m51ny20q2Uxon2u8/k+5PctWKI?=
 =?us-ascii?Q?P7DgeoDBnoF8VzMdVPk3a2EFtiRwf7EwEORfAqpwR1N4cuRhkAR7uFSCGBoJ?=
 =?us-ascii?Q?Sh+/vAM+m5HndgWw6DGvJL6RzGFYgIiQ62WlV360PPEL2dca2rgiQRgJoyoC?=
 =?us-ascii?Q?mpJ5w02xti44ITil4DXVTgEBLU8apgW8g9XWpugsbl9MbC4DR1kWhTtTZndg?=
 =?us-ascii?Q?NJUuyDC9XHFyGxJOGXpJp5WpQNtJ9b3x/MLFs/YDMujzNEuDpGUqBKMb/7xI?=
 =?us-ascii?Q?E6QVdF12GMxQwQ3qQoB15zn7jEb4Z7HPdZdoBAAASHVj0KCE6BK1H1QzSyzp?=
 =?us-ascii?Q?91P8ooay4K5gmJP+0y21eDgU88zLuMdTplzKsUGsDDgyCC3AYTOZfRkTRNk+?=
 =?us-ascii?Q?aSU/+o/EBblbqfikuTr7ibp8ZUwXOq+C4c+zjhAMr7qtQaFmdzJc4zoW48tj?=
 =?us-ascii?Q?yszfpEsQPUoTC7yUhnPUWaXXloGAnCkeqZWYh2/xR5vde0knh8QiSucVaYqb?=
 =?us-ascii?Q?vO6W7fpSXXATqoJrtPO4FR+sRSzJkZlmjzmUH/xuvZtLyuZyfavF4ef4MWhC?=
 =?us-ascii?Q?m1ESWRoEFMnWHV0atzG3gMnAzOiXKWb4O8QKAbgXqDN8WOl/AWujk/HYxnBa?=
 =?us-ascii?Q?1uf16mFXev0AY56o8Sp/jkOYRbFwDcavncWmPSjRFIW4ZFW+TlyYoyDrgYft?=
 =?us-ascii?Q?4Yyp1M/Q4sUp4lBv6RJkNvg=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fe6235-4ead-4990-611e-08dcb7d8a767
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6828.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:33:53.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OckluIzi8BL2FY3s8sO/bhcIGAsU1YoquPX9U5CVsPL3KMM3n721vf8I9WeGgRy+MNXfjGWhL8JBpV2qsOs/o5a6Reqpv/n3qwmc0U4cyH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6348

The .page_mkwrite operator of kernfs just calls file_update_time().
This is the same behaviour that the fault code does if .page_mkwrite is
not set.

Furthermore, having the page_mkwrite() operator causes
writable_file_mapping_allowed() to fail due to
vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
enabling P2PDMA over RDMA.

There are no users of .page_mkwrite and no known valid use cases, so
just remove the .page_mkwrite from kernfs_ops and WARN if an mmap()
implementation sets .page_mkwrite.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 fs/kernfs/file.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 72cc51dcf870..a747ed95063f 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -386,28 +386,6 @@ static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
-{
-	struct file *file = vmf->vma->vm_file;
-	struct kernfs_open_file *of = kernfs_of(file);
-	vm_fault_t ret;
-
-	if (!of->vm_ops)
-		return VM_FAULT_SIGBUS;
-
-	if (!kernfs_get_active(of->kn))
-		return VM_FAULT_SIGBUS;
-
-	ret = 0;
-	if (of->vm_ops->page_mkwrite)
-		ret = of->vm_ops->page_mkwrite(vmf);
-	else
-		file_update_time(file);
-
-	kernfs_put_active(of->kn);
-	return ret;
-}
-
 static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 			     void *buf, int len, int write)
 {
@@ -432,7 +410,6 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 static const struct vm_operations_struct kernfs_vm_ops = {
 	.open		= kernfs_vma_open,
 	.fault		= kernfs_vma_fault,
-	.page_mkwrite	= kernfs_vma_page_mkwrite,
 	.access		= kernfs_vma_access,
 };
 
@@ -475,12 +452,17 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	if (of->mmapped && of->vm_ops != vma->vm_ops)
 		goto out_put;
 
-	/*
-	 * It is not possible to successfully wrap close.
-	 * So error if someone is trying to use close.
-	 */
-	if (WARN_ON_ONCE(vma->vm_ops && vma->vm_ops->close))
-		goto out_put;
+	if (vma->vm_ops) {
+		/*
+		 * It is not possible to successfully wrap close.
+		 * So error if someone is trying to use close.
+		 */
+		if (WARN_ON_ONCE(vma->vm_ops->close))
+			goto out_put;
+
+		if (WARN_ON_ONCE(vma->vm_ops->page_mkwrite))
+			goto out_put;
+	}
 
 	rc = 0;
 	if (!of->mmapped) {
-- 
2.43.0


