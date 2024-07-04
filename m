Return-Path: <linux-rdma+bounces-3648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8DD927B39
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 18:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20D11F23790
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF871B29C7;
	Thu,  4 Jul 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="U56ZMDkM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2103.outbound.protection.outlook.com [40.107.223.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4591AE859;
	Thu,  4 Jul 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111074; cv=fail; b=MGjIhRcjpgOVIAIhPn/Dm4fD85mo1Dv7/kHTj8Y37T5V86VsxGpj5JvPaCLffYI8jZRdj2CJqY/SSU6Gynfq/JxGG7Vo6fUA7t0aRBx/vvwjFnhXvMKJXlU+X7PYjgAGQn89W9vLHHv+eeFQJh9h0B0PU2MLezTsJ5ZLcDgEIi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111074; c=relaxed/simple;
	bh=JgyHo8hNnjs1c7rjF1ajWqoz0aQ78TXvjjLorDie3pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fJThLDCH2q4oSvY1BDhUAe4ceXaK3cvX9BETtzG3MTvQKZ1uNaDO5D8fUFs9fShfyE9KuN34QeZ5BN3IltFR9K4oG8UjzdEJI5ASYklZk5QpbLN3H4B0Rgo1XDReLEdftPXSL5inZ9GkTkQP+YnlTSjmEzpNX27ZHDMUC+NTM2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=U56ZMDkM; arc=fail smtp.client-ip=40.107.223.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfRZqjU+2/Jt26YHsGelClJdDZA/NRuxzL1BGxZMhnBb+aD8FuSyXfjvuWmt01ZZecxRSdmMZUMeRBJWWrUhiy/1mjzZ7Qoh3BzGgYTsfK0QptLZPRLliVUwaNrunpaW0ft+4H33JZnx5eB8jvCkWDN9bdOlPo0ldnurD3SVcmsRms03VPuOuPBL/xKFmTz36IrxFdosLS3Ud/qyZjk7ptEHabIx8FltOVOgjhrbL3yUIVrxEzbzcsZE7WNb5FnIME0wIiOwXIIoXVs1WpkX0sdfN/sdtUnlnUZrkNt5YnlaHvFOtDSOIeFfMMjI/Yw2Xz3ll8UIxF3k1mxVw9OQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6750ZTovsWA5UDdHdp05oHmxOloK2e78i5SNGDFn1GU=;
 b=SUgJUXm3Cqf4QzzKAcc3EOo2x0QIxAjkr+PMzYAUPH6o+hD+K09EiY/B+Ep35auRvxr4NXLbIrw7AHwxWh+U55xySdLUbhMzkgoUy1zQCJP5ggduKSYDSk4B+vQXsUtbdNWAJMAuKHgUdQl3dY5lp9QuLymnwbnUvX19ttEcTselQMf9eb8XMZlL5MhYkTKSIjTzI8YtTSeGkHKfbEJ/xv0yal47rOj5OxZRuKGPQFnnO4pmKFbEPs5gBdPoA4JtipwtP8TAC53hL7takhaio/DlVuhu1PRJkGtGCyfFzyKEUOn+NHCATKOak+dDi/sUzJOVsHE/F3Fa0vHTjZutHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6750ZTovsWA5UDdHdp05oHmxOloK2e78i5SNGDFn1GU=;
 b=U56ZMDkMgZ01Va/t88kQY1QalnAEK6+ipITrbKrM+cOdTi61UlUNpIdj+6qBw3yROb+ds7Bz6yfKzpXd/SCNggTjC6uvJxIYXoeMf5Pu4KYun+rlrcIjrA8QpkDJGGC2cj91foH6WsUfqSkkwvkNiZe+mxrYq1bVPV6oPec0/sM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by CH0PR19MB7850.namprd19.prod.outlook.com (2603:10b6:610:189::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 16:37:49 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%5]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 16:37:49 +0000
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
	David Sloan <david.sloan@eideticom.com>
Subject: [PATCH v3 0/3] Enable P2PDMA in Userspace RDMA
Date: Thu,  4 Jul 2024 10:37:21 -0600
Message-Id: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 8deaa0c0-f4d6-4f05-e362-08dc9c47a47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YjfT08WkfVuzz2Rax4nEz/fGn/f2EfI/HH9lNUa9buSt/6sNn5zfmNoPsK5G?=
 =?us-ascii?Q?2zEBccvOQH5J4rWgLbYuEw2hjZLffjhhinlMFyMPRM4S7N/GC1PnHzXpYPLt?=
 =?us-ascii?Q?bdbwupoJ5krRvxp0Skh50S4PyBmdp0uysrtfElsyZFJKvyCfd/GCvjoyka23?=
 =?us-ascii?Q?rn1r3Kzq/928PCJPg41P1hiLpGYrmKF23PbPYZ3w0VDVuZZPNFTSlr2qc7tb?=
 =?us-ascii?Q?RoTL1KHzKowpxdASGEjXILCObViAyquVEsAYXlyqPdnpG7FXEXOwH30M/OHh?=
 =?us-ascii?Q?EIOEVK6vkMtjPfqZ++13c+CnLz5/aRYKhUV2BuIH1X0CCdxBENctwjDBsdBD?=
 =?us-ascii?Q?P2YMkFsReJfJBX41TecHz2374Ltu+UG+ZvegeFE6IedasA5CE/abzj95kRuF?=
 =?us-ascii?Q?pW6hb4v6FNlnz/32UZXdC+gdClrH0HUODrCIb/qtxx9i/JYSYiEQYOAJ8sH1?=
 =?us-ascii?Q?Rh50LeWPEI7f3f6EBhwShJspkSIUgTnR52pmG5ftb7oPdyEccBX6aKlFUD6j?=
 =?us-ascii?Q?REVDAikru6iq7Cp2ikEIgJzOQI8Fa0t3E592dqD/8LJebS41tLhGyWeji+Xq?=
 =?us-ascii?Q?o23oMryQsydnRzUpIJ4TG8zvo0+0rwftff3I6j02e9nH3esvsO2kG1VZHG4P?=
 =?us-ascii?Q?txoufssliISrC06QWFMIuDvY/m5LteVba1wF+WuluicC9kV+0lIbMFbQg0AU?=
 =?us-ascii?Q?QznwZ0iKaa3zi+A4zl20ZnE9EHiBGECdxEtPQcWVqPhJyG2vQBSRSXN+jq8h?=
 =?us-ascii?Q?e1Libl70L9MnNGKRSnpN1kgyNW1LF6F3rhArZr/PPtxHl5OdUNk6I1kZFVvK?=
 =?us-ascii?Q?KK/1L+9NQdz7WoK8qAWKpV6E0QMEa0ltsCoGgeDCTY1IKqUQw7LUv+5acOVz?=
 =?us-ascii?Q?RQHa1jENdnk220XGe5YLWvQRGk3J0w54dv/K/cltAvWa6FpUwPjsUdwXkhY7?=
 =?us-ascii?Q?Hq8lNX7VH8irUFa4RRWoc1/mGaRxRBgWzupRi46khIPIhRPIMiL4upy7XFs8?=
 =?us-ascii?Q?UOjVsk3VDb/LBJzS/7aBWK4ru/TwupWHYjevssgxFq0yz/Cb0dTrLGsg4xpo?=
 =?us-ascii?Q?qGPs3oz3L1cQ+1To3n9stIbMOK5LGqcjwmYNe5jjcWkCgE5/sO+7vgstmQzD?=
 =?us-ascii?Q?RiolEswBC0QGECeG3wS31XWPR7aZcOtrXHvtQmR4c1Gr+b3/RKMxYncZp1Tg?=
 =?us-ascii?Q?AV8Jxj3DUvyr/3ktk8Bu789MMzrmEpmusk1NfREULP54bx3hFUs5q5WoHrIU?=
 =?us-ascii?Q?3+1WIkXXCAM3hXgyspDfWQKhL/cN+r7weljgXo0z5oOCR2/6BTfzKm5Ge2BR?=
 =?us-ascii?Q?sbb7G5ayHVImZovZethPcRnK3tJGwXZxUqSMxf3Y3l3j6AbpWMLupjB/zVag?=
 =?us-ascii?Q?sbBbgjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXx05AiP//YxkaxzZUGspRbNj7pUQoSRgaIGnk49b8N47nzTyD2w2DHM85+H?=
 =?us-ascii?Q?9faHLhQ2QJWWk3+NbGiapGYhnQ7v1Um5tXtah/hVGiis7jlRlOK4fIQ/EeyN?=
 =?us-ascii?Q?zE1ubeMYm2CIVRTgTzAe9q8TIfRR88JrIYA8BQYm9mQyr8oXoTldfWQqwGPH?=
 =?us-ascii?Q?PMJpoKhVqE3s7UXEu8m2KVl0c4kOX7GbtkOATE/weKuNG/mkhqPrhK6RtdHV?=
 =?us-ascii?Q?E0lR7o1cCcgFUgMSBraqASfCjzg3Eaco/148PK3QxksbjCouiyNcULMShbuT?=
 =?us-ascii?Q?4M1jn7ai2QQlnJivJMVE4eDh4uwho+yjzzkidyX4D3Z0U6X0ugqUInHIyYsd?=
 =?us-ascii?Q?ybU09hatuX8Z4PGJJm5Lb93PDp66SrsJMJTAFVAjt2ymZUJLvF71TVoJjT98?=
 =?us-ascii?Q?68gKvWmQIrySXe26xOl8zir74OwDRB27jGMegMO20aswJ5kxEz6/zBQ/Ln4n?=
 =?us-ascii?Q?//voEQxUDWhvrinZzUkxmh6OZWFe8cbe+YOlPwn6UWke9x6Cqs1qjXQUPnYL?=
 =?us-ascii?Q?hy7bqDleLoz1GINhhvYm872rYHePflQNtoSskchpA1ZxGUW7Rl60fnqB1G86?=
 =?us-ascii?Q?IeR6reJN654WfzI2yA8rhpi4RvTRT1Qhvu51DgBVE/i3swpbgo1zRPX+GT3x?=
 =?us-ascii?Q?ucX59F3Lv3fP8VYRXKvjyWG/jRmyAerMo/+CfPVuRbX9OSP3YTNvMa4/krTc?=
 =?us-ascii?Q?5PKjRF2hZeE+uCIy7Bwnrj/xyYMwJgz2ew3pC6FRgb8jtaSpteCsM83xYyYd?=
 =?us-ascii?Q?6nPBBfjIXkwFweniRuAalDuNNdayrnsQOwQIJcOmbStfeQwNg8uDI6d+jF2E?=
 =?us-ascii?Q?C0eGdeig5BQAA2G2zNmWBgFURYaZZtiILRfqIULLq+RyNUD6Tg8RsilibGc6?=
 =?us-ascii?Q?3eFHhGFYZB380NpkpLkajMgRYCsSCPlIQlwCs8GYs29F4YyiteVB8YfAV/Q8?=
 =?us-ascii?Q?/JB6OKox0O86D3vBT15yZf/qn1NRDpoMc1VcaEs2bAy2TdVNsWIBbxvsNGy8?=
 =?us-ascii?Q?UgIlpAw7G2iIBvdwFLWMumQSdBgZ1p6enwvLP/TDMopFBGYU9w94A9HV1rhn?=
 =?us-ascii?Q?aQvnTKjDLEP4pRa4cs0p+nE9uiMTHy529P+zx8cVfhzhvkTACUFhhb6tuqk/?=
 =?us-ascii?Q?Z0w29UT7PKCBllai7fKf+oG7Vt6EP84D0ckSfWgYc94X3OMUWD0Wj2AVft9l?=
 =?us-ascii?Q?BT/mMvm85nf6Oj2ltIfyZ+F7hB03nZZ7f9yGVjxiLOEvsFPKeU36NU194nst?=
 =?us-ascii?Q?xNTICekVycnMHeIZEsbXKxm/1TzMOXGBdIOCGjgRi4iBr1uE2pWPTbTi6NVr?=
 =?us-ascii?Q?zzmmiiPBjInLb12+sP9qnp3FgZ/uvypR7QN+WOJgjY+Uwtqrpshh5uPnc348?=
 =?us-ascii?Q?8pmkyz81ELyYNojF/olWs81Qi8KCRB8Y24iv5Dpp4sI4QgNnjFG0QA5E+zPq?=
 =?us-ascii?Q?loQcUEJz9c0wHNqtzpK9Yd+qaxmznG1CJnpmbJmpn2VV4NQt4m8g1M3L14/1?=
 =?us-ascii?Q?ri4gK75Qlp0WiYEAU//1rXkqADo/IYgcdkl1poC78FeeQv+nOWCP3T7RZVxK?=
 =?us-ascii?Q?UlGNjtSAYQeMTtkjMvYESz1nyFqPk2j+xnyE73YPGDTICAuieFwKK2jrWe+F?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deaa0c0-f4d6-4f05-e362-08dc9c47a47b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:37:49.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6S0oW60YliAx9qtCkIBepUKKMdabyVVTVQhIjdDRmdvVJpEA9F4JIKbN/HhGOvXpx0PrQFc6hWGF7MAOdN0mOXk7cUZpBdf0BlL8D3vult0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7850

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

Changes in v3:
  - Change to WARN_ON() if an implementaion of kernfs sets
    .page_mkwrite() (Suggested by Christoph)
  - Removed fast-gup patch

Changes in v2:
  - Remove page_mkwrite() for all kernfs, instead of creating a
    different vm_ops for p2pdma.

Martin Oliveira (3):
  kernfs: remove page_mkwrite() from vm_operations_struct
  mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
  RDMA/umem: add support for P2P RDMA

 drivers/infiniband/core/umem.c |  3 +++
 fs/kernfs/file.c               | 25 ++-----------------------
 mm/gup.c                       |  5 -----
 3 files changed, 5 insertions(+), 28 deletions(-)


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.34.1


