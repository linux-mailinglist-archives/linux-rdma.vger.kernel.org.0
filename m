Return-Path: <linux-rdma+bounces-2910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC18FD677
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8961F2493C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5171514E7;
	Wed,  5 Jun 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="a8UQ/Jos"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618214F119;
	Wed,  5 Jun 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615816; cv=fail; b=R3HdQUFcfUwUXNXu5jc2or4fplidTL4+t9k2WhvD9RpS8gawX3BNeiYjUOq0BT2OqsDBaGyRPtuuijkley7zcHsLvSxdxuytLvTRlfGhaqQciaxHnb/8QxGdCwa1M+qm95xH5oJaP2H5AHQgWYU9eEmi7e7wadxriOK7jaA633c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615816; c=relaxed/simple;
	bh=43Vdez8n5pELd3EKIEk5QRDl2Mfq6M7jX+2m3r9PJTA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=luMWR1x9sSv3g8SkvGQkDCEn5TWOq3NzLrptSTUEFQZAfm2WvgtcGwmAHqp9DwZwpmzKZZV1Q5JmW+k0WX7XQ4+0E6JcXVqumCQWXv+ntbILZsmC2rhQHRek86OPeHkf3w/brSRWpF1KOeNSpPEzvIIIk310B8n5Ji9ZLoeTMQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=a8UQ/Jos; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkvlAW1EXTA4C05j+iPYYDpt3nQnjh/Q0in2Du9xefr0+F3eBqVBW/g4+6XOzg4/xcQP1JW9TSqBGsYJXAM8viHiqxpBJygYFTqN7aW0PfCbNGVNuN9n5dkS4qdJbqn78WovDU/FBWmsceZTaRSXHOTgkztR3IVdKegVcNcYSmMvRF3G80tZ1hBO1UYKBK8MjPMdbVy6L6osjnMBfSaKJy+9qK1STANR69E6Ndz5PWovtbS3GffMVPTgru/XuOA0niU2r5R7ogPQcLeq1nw1/uw/Dcc/nru2E2wr2zyGg+/vH5Uhae3i/8EyHYu/5S9hyhiMam/TZRnDHh6QCnbQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIe0PRGMhSUCv0s2EUxxu78eE4q16NkHsAtEFa7tqMs=;
 b=L8eUAYiqNXmwgz+ueCgnROkdGv7zCVVqIkqPZ/qA9C1HP1EdSqOgQRV/db2S8mhEAzeA+ROZpN5Or2WAQ7jCKO1wf1++pL6/pok4wLxfoW5Kx/U2+u7v5zGYDvDvldK/EZkeoPqFPwNFH3qtJHeTCyxipGCe62MuLtUua71TnLVYPFHXSWfB56p9auFRZl8wAG7t5lTcYBVDJBTPb1wz9QQwd55thydSLBQLlPr1UCwqqyOlo/VwPtjel0MqTNzJ/u/mNCdqY485Klf+WrfLYKqYsi2Rvqk7q7sLdJOuYov2hgW1A//gElkc8D3w3v5Bzu4ZHHTwGfJL/q1L0n7oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIe0PRGMhSUCv0s2EUxxu78eE4q16NkHsAtEFa7tqMs=;
 b=a8UQ/Josy0g1lpfJ4mdW57U0DkB/iudTDse6p/23yRlQJAcYunF/xL4koCs8Z5QgCsivBmKRQAnyE9m+RuvBFtZCT7eo2Wxh+5efCkgbf43fsS166xc5G46S16eFJpzIi2uJo4pBppeZeaPHO9GGDWWZKfvtOIGw75ag+mmzfg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by PH8PR19MB7093.namprd19.prod.outlook.com (2603:10b6:510:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 19:30:07 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 19:30:05 +0000
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
Subject: [PATCH 0/6] Enable P2PDMA in Userspace RDMA
Date: Wed,  5 Jun 2024 13:29:28 -0600
Message-Id: <20240605192934.742369-1-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 48b86261-45e5-4e55-5546-08dc8595e6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gw8J4P+lOGiECPnQ5DZTkHBBzsceQiyloW8KnXdJe70o19m1nz93UeTqQuSE?=
 =?us-ascii?Q?AG36sBVD2T3p3KJcs9jrWQTBir+hh5Ujf0khP+cy9g0rAOrw8zopio2hzZpR?=
 =?us-ascii?Q?0fqECgYFbdU02WsdJp1UpFGNIOhUudB5MVywlkl4U53fMzVlrb8dL0koKMCl?=
 =?us-ascii?Q?hO0QPkpdsAkDz67zOBZL3akf9BiswPDPkjjeexSiQziOJ+2X9VTzyyrdUtAi?=
 =?us-ascii?Q?ZSdsmTm0Z53kJFPx/aWFKiQpyxNO+0o90LghVb8fKJQg+9hSx8eg7ABaJPxy?=
 =?us-ascii?Q?8yXXDa06jion2TlmeXSKLSJZFLwtjrLgYZ1VLGI+3kGTjqPIpMdS4dWoUofz?=
 =?us-ascii?Q?Cf4hYLButwbet4+DoGa3+UBfMqOcBdeI8nPjDS8gR6qOZ7Ao1oJBAs7ZOEP8?=
 =?us-ascii?Q?/cmBUP5fxyN8LXQVjI/6WiInuLOuUVQhHbwLw/7R65Ir/OIZ5FP5f8jLdE2i?=
 =?us-ascii?Q?Btg+Ph5Cp6xMHJvkIU36vS9MnDDozs9TQ/q2WASvRu/4FeK8rcmgQdYR3/Eb?=
 =?us-ascii?Q?QucjvN22bOXVhYyfYLoe+9/Orb6QbStx1b4QgV62nnUKW7iXFyWreQdCP84R?=
 =?us-ascii?Q?Itx24ZhgEcM0VD5VCsnDzUy6RDwI2JjpmYBoQ+l07Ldhkf8Au4eqgkGG+owc?=
 =?us-ascii?Q?9szOXdNtZs4YpjSD6Q7kmbfeUjW1ZIn+7IYU+yPQMTmlWgMwVPLWfCnYwlfx?=
 =?us-ascii?Q?uLyBNdcQBLav9jcttfUWoO+DevLhLZWaIWgcLWr+hV+gbOCRjib6OYWEEK9m?=
 =?us-ascii?Q?rf0LPmfvSmSRNHbFTA3IRpn3ZSGwlqeLhZbn14mUgEYS+xombKpp0tM84dfC?=
 =?us-ascii?Q?p3zJwIVev4o3tryY7CvoJGcYf72Z0DGB+w23BXt8R+FeAW2j9qEwkGUK/GBq?=
 =?us-ascii?Q?5CnxSZhlSSUV0FjZsHrOFKXnztSShHWCAUtjWKkqh9mMQZk3LQpajBql2I8x?=
 =?us-ascii?Q?41KB39xcWCMhZ6gnf/wJIUSR1lmXxR7bCXsmDsJ4luUonGCsWhoOMs0Rj/tP?=
 =?us-ascii?Q?vHIP0RBIhdHnd0DivIIIViePJHZqpZMovu04ZfsfHfANx21ebn0URL0fOzoY?=
 =?us-ascii?Q?Zu8pEMSCUgOYATaZ8/5PGWFOPpO6AD0+C1a9p5V+M9vy7LoexL3eKynSAJ9T?=
 =?us-ascii?Q?nJlHh5cPmrGs5SV6tSFng2xfmafMy452eOFF4+9J+TA6xJx5hq4DRbHHSXgo?=
 =?us-ascii?Q?Q+yGlPXvP+IwrWZXJqGDGoB+u6tSq57F4cEmviaPCVJkJcQKqpYOuXm2PqrM?=
 =?us-ascii?Q?DQwX/wFqkLjl9lM8A3nsApbjR1OwWR2jC/IBShG7qliHUkQ3ubbMG7khd1LA?=
 =?us-ascii?Q?Es44Nz9BHGb4X8zIOQmpoG6ctBv/ccfvpAhNnLgleY+AZsfYrZGd4xoinFrO?=
 =?us-ascii?Q?cNsysOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NfAlDP+QdePrynhmfTr9zTOJJlcnAZ2KfM0R11/QIrLHR/aruq0k2bj1BSan?=
 =?us-ascii?Q?PxtGGmWKE4J5CdtOxVpyJ9aWZsMZ0d5elaeQqVHM8b3ZB8ETGM2u18veDyR/?=
 =?us-ascii?Q?DFPfEO07JpPtoNbFcfp7CNOqW93jUeXIg1c11EOqoDN70H/jhhllboRmy+to?=
 =?us-ascii?Q?w1HCvjZCqP0NkdRFv9kS+i3dHrHSOvQF1tf/tLUeC6wKG4GrqiYkXmCguN0W?=
 =?us-ascii?Q?88k07D0DBhpPR4B6bnpOFOxp4lNvFVMZuiCV/VDKLkJwRr609nkdMXS9sGdE?=
 =?us-ascii?Q?isr5TtjRaftC+Y1EVtK7r8ntaD3sL/W/HA0Nuk4V8Yict4n0nQDGa2gfCFNe?=
 =?us-ascii?Q?V/VUsa/ZrtHolrGaU/qyqBpEyMPUP0wewN2p0N+so/RwfE585s5cj+RM/mB1?=
 =?us-ascii?Q?wkv+OTacuX+zpZNePoGs2J6ZAGg8mFp6nbNxJF1LWjGVRPHTxsqJlTak1tqG?=
 =?us-ascii?Q?giSQwDHLHXje1RPc0cfKMbyY5Tk/33Mq7xLIXgkxrsa6gs+Gbx25GQkqxfAs?=
 =?us-ascii?Q?w7mEZKqSZKlQqX9lKT8uj/kuJbv2jDf3ajRUAMKxBbYnCnWttrnXJJJ3QpOO?=
 =?us-ascii?Q?8s0vuAPPdByCGOP9PBBfM5zm6I/C9l4kc702PVboBQ/doLosq0DbgT7pU1E2?=
 =?us-ascii?Q?Hi9tgfOSGfYug5yBhb41uWIgdRdfp+h/LSvqSjiU4M7q2JG+5IgMfrdhw6wa?=
 =?us-ascii?Q?FDbJLbmrGKw3ZTmrAryR6ajMtCEbndo8b6CyfObPDqQe5OSiaIJP6QutXLtf?=
 =?us-ascii?Q?aFVrq/j9ZvK/ZTFgjjKUbTkfH/xfMJ4TljW4/e4eJHr6walzPYJzWHWHVtN/?=
 =?us-ascii?Q?R+oVy2pm4YGA2maSgpQBVWIop3aLc2RyevURvGFjLkZ1ul6vuGphdvasaw/N?=
 =?us-ascii?Q?t8cZzPXgIZDAaMpvlBLEBsLytM7SGxKPHx2xpr2J4Yb9j20G7f04yimc7t9M?=
 =?us-ascii?Q?AKya56vZ7DfM5W1gwLUBQQ7ymngOPotdeBKGLK/QaUI7cenn5hrowfV81H74?=
 =?us-ascii?Q?Q//uXuQShN5oQQBdv+ht1PAoKDJqvMqVDl1Dnen8IJVDC+X7JYbLNXLlVy4B?=
 =?us-ascii?Q?iFRX+d8jXJk7MzQUSr1W84Xb2jxlNTYmRQ9yzNFW4bVb8UkiWSXso0ifUOpw?=
 =?us-ascii?Q?BAEWcd8Peqr3SdxF18v9aqdYU1gXIggCncF36vWvm7JBwlkjYaSuuCmQaxRv?=
 =?us-ascii?Q?ycctx7B0JXIIax41XFNyTysyg6yM/wVEfXadreutMgsxCLwM2OiElQ9rVS2G?=
 =?us-ascii?Q?+CSSU6Tf0/XyUqUbwyem/QLYqNP7Mbo7V3EeHberICuUwwdKLZ73PHFDXlLq?=
 =?us-ascii?Q?SDH6HOF/Jg+3xxuyXHqTUSfRaNszTd8azY52XEjCqLCU9VsBSeQSq05m6p4F?=
 =?us-ascii?Q?+dbPfjZqC0a42t35p4cixXpxSec2z8iMBlE8h81LejxLuwCQ5rg+UUiA6AgZ?=
 =?us-ascii?Q?YcWmz7o7tzzML5cgFaPDVyeaxmQazV3rUUabjFBhjaggy1Y0RRET2v1VDh57?=
 =?us-ascii?Q?4IAUVkqxUS9KGXekPe7zNwwnzWwtCHZUCfud/5daWkP44G8JvFUDTPlmIufp?=
 =?us-ascii?Q?g//7ci7rim3+X/MBTp7nN3mly6IaL9o15wpZkPzwiMSONVDhsnhhFDX51V+y?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b86261-45e5-4e55-5546-08dc8595e6f6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:30:05.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k3er67CFE4N2MmJR94CeHeDErKUJM5IfRvkbhinqgElgDFvNRcukJxSztK4wRJG07Mu6BWjSEAxC6iWGdmQJJPnh8aq2Q8syY717iOOUKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7093

This patch series enables P2PDMA memory to be used in userspace RDMA
transfers. With this series, P2PDMA memory mmaped into userspace (ie.
only NVMe CMBs, at the moment) can then be used with ibv_reg_mr() (or
similar) interfaces. This can be tested by passing a sysfs p2pmem
allocator to the --mmap flag of the perftest tools.

This requires addressing three issues:

* Stop exporting the P2PDMA VMAs with page_mkwrite which is incompatible
with FOLL_LONGTERM

* Fix folio_fast_pin_allowed() path to take into account ZONE_DEVICE pages.

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

Martin Oliveira (6):
  kernfs: create vm_operations_struct without page_mkwrite()
  sysfs: add mmap_allocates parameter to struct bin_attribute
  PCI/P2PDMA: create VMA without page_mkwrite() operator
  mm/gup: handle ZONE_DEVICE pages in folio_fast_pin_allowed()
  mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
  RDMA/umem: add support for P2P RDMA

 drivers/infiniband/core/umem.c |  3 +++
 drivers/pci/p2pdma.c           |  1 +
 fs/kernfs/file.c               | 15 ++++++++++++++-
 fs/sysfs/file.c                | 25 +++++++++++++++++++------
 include/linux/kernfs.h         |  7 +++++++
 include/linux/sysfs.h          |  1 +
 mm/gup.c                       |  9 ++++-----
 7 files changed, 49 insertions(+), 12 deletions(-)


base-commit: c3f38fa61af77b49866b006939479069cd451173
-- 
2.34.1


