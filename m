Return-Path: <linux-rdma+bounces-4252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289FA94C463
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 20:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5774C1C220EF
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D91465A0;
	Thu,  8 Aug 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="JHudj9wi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2119.outbound.protection.outlook.com [40.107.95.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238B13AD13;
	Thu,  8 Aug 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142034; cv=fail; b=KIB9KiHWZwC/nQMa+QC3deQOcN7pfz7kjAieR5FIzr6FZKt3EvJOw0uMpOu9anmfbtcOKXp5mpzua94C2nnY6npmw34Rsk4R94XA3ntaII3hEAlmn2Y3b8p40wSq3FrcH/wNVVFJfNbLRG2QyY1BU++1W1axV/Jl31Zaao5ez7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142034; c=relaxed/simple;
	bh=3XgpaDPLKKbYXLcaoXhriyWFux29zPoqI4H1FfG+Z7s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gofLo6O4XL4xX7ks+U4wTKemoS1awqnSv8MYHYw++H9DrYN4HKVolowou8CWMjlD3edLflZvaf7XFdR8FY4nrhwY5nBj8VIJSxRKvOZxYdLN+5Jd8fQx6QJxaEVp5wDo2jO4AAv4XqW9PLOPQBcxUyY0GnWsqO0WIZA/sXX/9cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=JHudj9wi; arc=fail smtp.client-ip=40.107.95.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxsKhHpuDY4YwDQ6o2dVIzJtQB6YaIjZwfoaQgj7MrFAa8OBtebDoe45MGwju8GdlRclnoefq+Ga5FKaFvTcQUBXyTJGTgmh5RFPMvrdg3460BzI4mi09SK7+jWqdMR9jblA4qlxk5OBmj45bnwDu6qysG18g9W+d3TCE6U9aqI/kvTrGycPkTsLNOYko8lFk9q/bp+bECEh08u9iAMJY5hBs6MPOpC6BXp15Q4FuhH+spE2ZIrAwHPOAsOw8pRrEwkuXfMO9Sa3P2z7LFZuj+4MDqyZph7rbjmcc3rTjM0OdIIEzKpNb8AdHRFrGbsaDwcvG28vmilsfIm2iwiiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E21BUy7gHwyM6Sc7f4tV0vSARFCIgfl8bfMG0roKu0c=;
 b=jDvWz2hgHG3gZ9TEIq1Uag3RISDWJPT+Ds/+OBkBmeoDaCfmUhEGKWK+BnLNlTQgQ/B7K9MoUt0fANPupFJ8VMgO7rtW3bBZLJ/hJ8EeMU+Mzie00Vw0cpkwJyFqNDqOswRAgqOQ5/VF3rZicbsUtx+STQyjOt9Wv/mn2YnTiFP9tgVLlmYXT8/lAhzwjPdgKguKU7wPy8nvARvssuTdPZD7gx9PJdQVqyJgzRr3NxB42LJg9kb6wnbOrofeZRL+lK7ZrAerQggUxVgflRovlWWFJp8J3l0Odc/2q+2GYvROQXC46qr8o0E4UdVGCZ41MXtlseGie9Xal+BeKLMP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E21BUy7gHwyM6Sc7f4tV0vSARFCIgfl8bfMG0roKu0c=;
 b=JHudj9wiAqGJdIbklR9vy7ilyM1a7cOqEt+7bcQNTGitosO6TCaC83IsKrVppNQKDg2jZ4nLHkTkmkPj6jsqDkQblXK9KxSk1sf1bkAJHirAZZ48R7BwpZOCz+pu5Qj/5xpT042NLYkgHDki2dR6LIoNeDUltD/SotmF7ZeEP0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from PH7PR19MB6828.namprd19.prod.outlook.com (2603:10b6:510:1ba::20)
 by PH0PR19MB5049.namprd19.prod.outlook.com (2603:10b6:510:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 8 Aug
 2024 18:33:50 +0000
Received: from PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849]) by PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:33:50 +0000
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
Subject: [PATCH v5 0/4] Enable P2PDMA in Userspace RDMA
Date: Thu,  8 Aug 2024 12:33:36 -0600
Message-ID: <20240808183340.483468-1-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: PH7PR19MB6828:EE_|PH0PR19MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: ff354e5f-c5fb-4be3-714e-08dcb7d8a5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2BuRgK+Ojocjm86OlCW9Ei/9gQXsI1wmmAh2CABhEjYfIzrT0Bw5bWRaj5tU?=
 =?us-ascii?Q?31SPl07GxW/E1BdiZRzK++ADRdmTrM+McXydGa9cZcvguQO3loOW9oY8YJu7?=
 =?us-ascii?Q?nvM4vBq6rnOJc3rHBk1/arCOyWiHs0UIsPehkXQ5lrdFK6bLIQPSGb9+CeCd?=
 =?us-ascii?Q?J4pmUR9BiOxy+X9mxc7eU1sCnUmsCFevNMRHmGuRfYbr73CpZCsxvJOs4TZQ?=
 =?us-ascii?Q?g+YEq7HDRXC+Nv2/2hQpvlf2MxKzRo8e4yfO8wwPqxZ9MKuYdoOkqVNvYt75?=
 =?us-ascii?Q?IchOopXfmF+PyOtH4iwqsIK5xpzLMT2oQkpKnOgTZNNQFWTL3bQSBkqQaQzx?=
 =?us-ascii?Q?1rUwKqnyDi77qpl4dIdU/lxaeW2RS/hROIXMm3d3SP1pV9gqqI5eE9z2Vfow?=
 =?us-ascii?Q?mcub8HvvSYoIZ7GLqx6orzXAXfx5SR08jYVJRtoKQC1Gib3wsO7gmzaWJXhi?=
 =?us-ascii?Q?CaRbnGmU7WwADD3LM7SoDcU5OxHElDvHUgObYSn0q/jKJLwivF9zZbU//Mio?=
 =?us-ascii?Q?obNonVpcKD0G7oqTyhOQmpB99nUKTBDvXfdh8sU9kfhGIP7qhGOGkvDnrb+t?=
 =?us-ascii?Q?uE9aF9H1QJUyzI59P6WkOgB2kI/RvjpdOvfk7ioPuAhZtp5WEbceSMfb5TbN?=
 =?us-ascii?Q?QKOw9BcncXBI77QNrc8NDmDu4f+bMUu70KEkpON+zt6bmUYlqPBrzXIDsMGf?=
 =?us-ascii?Q?0dnKH2k4v7OLoraxxBmwJB88v+2laRsJqsRAb4NUAxlJdKKKr7xwMnAuCh6b?=
 =?us-ascii?Q?I/YH1oDERiKTAgJnxL9TAxbPhknheoct9mEHQhU/9h/iUtWldDF7PFCgfxV1?=
 =?us-ascii?Q?CJ3i/2RKnE6A8NCaUCqaRqUlDrjbN3yKXirEgsJpLM4gqRggYNauUt52b4+o?=
 =?us-ascii?Q?NiOz5IicfM79K57CxX544AUXoPUiFUp5GXDjFtwF++UrsOl/7OsiD/B88uSj?=
 =?us-ascii?Q?HANRzN0DRYjmlHlz/HrdUd4FWEmDO9bl+CZmREHAPf2F1ncIyXDjJYY0jOM9?=
 =?us-ascii?Q?olqNDJI+RhxGYi+IwOxCD4ZF+LfrQrsCYoOsVnQkCIBJntLHrVIuf14zoveF?=
 =?us-ascii?Q?IC7sbKtPmKTmGYVNRh6EczPcn2sA4O5g/DpcUKnIv+Ux4ccogu9+TEy0aG7j?=
 =?us-ascii?Q?M2Q7ldiid94dtKSpw3fPhIdEMdaKeNuKwbjqKKAHaiApdqtnkDXy+nOZZN9H?=
 =?us-ascii?Q?leU4q10sDfeaE3IM+YHu7xioxDzX9m5PVOc/+wnH+oKKM5bK0tXXCMIRbg5U?=
 =?us-ascii?Q?xTJ4/qN/ClcsYfjSkO+jQPCUxxBusKMZ7HV3lHiv2/8xu61VB86ym6yGJPZN?=
 =?us-ascii?Q?HS+Wo+pd6pu5jVrmVRQf6zVMUkfrZ64ThJaF0bPeHVp5co1rOEA+EhVrGGbs?=
 =?us-ascii?Q?HiL4pc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6828.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOq7j0K8dPZAXX7WsTq+0h70Oj+621GFAdj65tTL6dsClaiwt2e5pO692FrB?=
 =?us-ascii?Q?H+yFaVzUDHsTVdMVlEXSlPd0WD01b7hZ9pjEs2PG5qyuqFRC7MUHd8Bqn+jH?=
 =?us-ascii?Q?N6Sg9fyTsvUGdEeAHqbBTLVoZngJzJykqmrUKDzlhLSFjPLGJs25iisJx+AN?=
 =?us-ascii?Q?TE7NgLCScLxWCdn9RWwTzyjrrpMJjkVRKg2aVANSXItNBrwVI/cmjTsr4X95?=
 =?us-ascii?Q?XDVEnGuXvAG7/w6mk6oGEeo+am2Goj1GdHkc5izvfaC7sozgVymnAsO/M1mS?=
 =?us-ascii?Q?v35CNwQMhAldKqomHanlHc3eNvEmtnfdBbuzA0kloo2I4sIN8lp7nJxauJeJ?=
 =?us-ascii?Q?JzLF8nu0cxXcjzgv5KggF+tAkYV5Ggxlf2aLh2Hrna+qonJkutdO0shq37yf?=
 =?us-ascii?Q?zn24LQSv/xBQzb2TU3pCdTIOuIID16ihxKgmRACkIQ0Iau/dY2VkaX0xFe+V?=
 =?us-ascii?Q?9aJtRs/IFMum0wLzMrLleaVo7bonHP5wE8qsVNhfzBkt944PJrAvJOG7Uxkx?=
 =?us-ascii?Q?OP19THVHNQ2pctLIIOFOlwXef+mrmXdUkMSOsfeHHm4vEo/WsaIu92MUGNXw?=
 =?us-ascii?Q?tot11T1yKEvBfvXorUZURn+LRDf9vWhqVFHUu5Awr+MxN4uBeT+37pUZej2e?=
 =?us-ascii?Q?6Pi7J4PZETi9qWvZKIF4vAYOsa/sHsActTN+CPDs4oXSGVBuCYwSxe3OrnvT?=
 =?us-ascii?Q?wru1jgcrp9RhWRC7v0gzdQlTpJcAm+FaNVu9qt5EHtpzcbfIsH1raBW0HEgm?=
 =?us-ascii?Q?Uw45x3OEoBn+3qmRMj5ycbYFedUN+6KbnN7YuFj2kE3RInAzW9TOxltonWmC?=
 =?us-ascii?Q?oYAdpwWWrUtC0NnChJFXDj6/qmiqbD0eDenNzc34pxbniT7wOlMmumvmN8Ob?=
 =?us-ascii?Q?zJ1mivAmUubzjRLYsf84M81UulpOB+4XFfH/8j8Ad28XyytYwg7zi0gEw76B?=
 =?us-ascii?Q?lDHFMG59Yp2KPbPum5ly4lvWFVXbMbhF0McAy4O48F17Eiq2Z57KblCS4dpv?=
 =?us-ascii?Q?NrZ379jS6GsIglopVyW/uzP2dUlRJzgAFxkzn+G0gvrMAg89IIgD1NfXZNkc?=
 =?us-ascii?Q?HQtmjb3basCrScXjCtDIS6x6GazYQ+FQi8RvPlT/D/MFCPbaQksZ6RWJksKH?=
 =?us-ascii?Q?vn+rIh3rJJUpiRk5BvNvB/VAbQgz6/Fz1Ebudu3EchDHE8zCyNb1r0fGYePs?=
 =?us-ascii?Q?zu+qQwBHfnhkcliMWhmSm8zwXE3Sy7xDRMN4sV7dYNVQVX7OL4A+sA12dIUf?=
 =?us-ascii?Q?pWosAcirXGkk71YmwBIi6CqsHmd1T/+h2yfTdrspLPAvxu1K703Ky8ipdh+8?=
 =?us-ascii?Q?VBzY0B4F/gZydN3P4fA24EDN1jj/ypxL2LL0OuKThRZKUPr4ac+LS/pBUExn?=
 =?us-ascii?Q?O/xHvHmg6ECeF90Czp5yQ5SCGFb8v6YzSbMm44ZuPV8dGIkTRuZM3XSeAazR?=
 =?us-ascii?Q?YmVswrUVOgmpbe6tMItIPvyr0od3D8Yi2SJOdfxG5upTMgy8PKrz8WK+CSq9?=
 =?us-ascii?Q?7bydbY09XPl28lWJR/0a60LXBIC5XenEv787hJlcANaP+CXY0qBQPqQwPkgs?=
 =?us-ascii?Q?z9my6w1T0qeBCRZ+K99l2mQQY08Acus0z5QDJaPaAhzosZWKeoYJjlSRooW3?=
 =?us-ascii?Q?IBViV4lbeE8/wEfRbG/Rp2w=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff354e5f-c5fb-4be3-714e-08dcb7d8a5a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6828.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:33:50.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efgq6txvKBCYq+Q0+xkLNkvvccB6KSx9cu3EMwaeKadJr/qAF/NwBP4YlJHCvBoyULjcWoMct2ik9rAXHxF/50MqJ4XuiU4gilYxSCjUwFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5049

In the last version of this series, there was a discrepancy on how
->close() and ->page_mkwrite() were handled, as just the latter had a
WARN. Matthew requested that they be the same, so this version adds an
extra patch to add a WARN to the ->close() handling. Everything else
remains the same.

On a different note, I was wondering which tree should take this series.

Thanks to everyone who has provided feedback!

Thanks,
Martin

Original cover letter:

This patch series enables P2PDMA memory to be used in userspace RDMA
transfers. With this series, P2PDMA memory mmaped into userspace (ie.
only NVMe CMBs, at the moment) can then be used with ibv_reg_mr() (or
similar) interfaces. This can be tested by passing a sysfs p2pmem
allocator to the --mmap flag of the perftest tools.

This requires addressing two issues:

* Stop exporting kernfs VMAs with page_mkwrite, which is incompatible
with FOLL_LONGTERM and is redudant since the default fault code has the
same behavior as kernfs_vma_page_mkwrite() (i.e., call
file_update_time()).

* Remove the restriction on FOLL_LONGTREM with FOLL_PCI_P2PDMA which was
initially put in place due to excessive caution with assuming P2PDMA
would have similar problems to fsdax with unmap_mapping_range(). Seeing
P2PDMA only uses unmap_mapping_range() on device unbind and immediately
waits for all page reference counts to go to zero after calling it, it
is actually believed to be safe from reuse and user access faults. See
[1] for more discussion.

This was tested using a Mellanox ConnectX-6 SmartNIC (MT28908 Family),
using the mlx5_core driver, as well as an NVMe CMB.

Thanks,
Martin

[1]: https://lore.kernel.org/linux-mm/87cypuvh2i.fsf@nvdebian.thelocal/T/

--

Changes in v5:
  - Add a WARN in the ->close() handling (per Matthew)

Changes in v4:
  - Actually handle the WARN if someone sets ->page_mkwrite

Changes in v3:
  - Change to WARN_ON() if an implementaion of kernfs sets
    .page_mkwrite() (Suggested by Christoph)
  - Removed fast-gup patch

Changes in v2:
  - Remove page_mkwrite() for all kernfs, instead of creating a
    different vm_ops for p2pdma.


Martin Oliveira (4):
  kernfs: upgrade ->close check on mmap to WARN
  kernfs: remove page_mkwrite() from vm_operations_struct
  mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
  RDMA/umem: add support for P2P RDMA

 drivers/infiniband/core/umem.c |  3 +++
 fs/kernfs/file.c               | 40 ++++++++++------------------------
 mm/gup.c                       |  5 -----
 3 files changed, 14 insertions(+), 34 deletions(-)

-- 
2.43.0


