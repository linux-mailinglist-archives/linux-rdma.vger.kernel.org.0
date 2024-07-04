Return-Path: <linux-rdma+bounces-3650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB2927B3D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4BF283A37
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066E1B3F0B;
	Thu,  4 Jul 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="Vx4Dct8V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2103.outbound.protection.outlook.com [40.107.223.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42481B3743;
	Thu,  4 Jul 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111077; cv=fail; b=Dp+xfCO3CMfBrKsxcPytiEn1NSZSx50iIJvjLjjyQIeJOsmp3PCkZJPjtAmR423t+jGVyLlCBNbkZsj+9871d7aeLSidzZLlJAcwhkJ6TK0c5Dr4+MjzWUgxEaBTG2/Q8G2HTWrZi3kF5+mmnm0aBTbr8MJ9rqTWkAEcoUr827c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111077; c=relaxed/simple;
	bh=kDA9NQkwJqypp5SvEFRbIhfkySmnnatjHvbHY9f7zfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRjMjA7D3A3s1MynJRgzCFOOmN4xUhv5WnsbqMT8ZlkmPRQSW5eoYWSf/5qimB1wQoTAKo0YC4NOMd9gHIXyYyVAx1sKZktlKUbwAGLaCaS7jkcv/HL7qTvTSr/12Bj3KcEw86rf6xxFuohIgSXJ+w0phlWKXKK4Vyu5oBt27IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=Vx4Dct8V; arc=fail smtp.client-ip=40.107.223.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7sehZwTuEVzuxEF1FDl1BlUS4k8w9hK5kC1bhYZOsG+jZAfGF3p2cGTjCOfknnOqwxlphVi792yP941MkxFX9aC6kSAy1xqVW1gCwMdT4P7w31OFNz0J1EZCqke7bquJfdk/SQWWuI9j1Yo2ZvfX0t3oqDMNFrKbiDzZ+LhBrV7b6XohBjsOks6UMuMWSJ5d+zT45El+ooGIgqoBTol5tSUBCnBepmRRvK6iiURkl2tcPFtCy+91NfNHQrAFHihlKCaVt9EghdeAd7KOVBA/lZflQ4Kd2UUY0xvdp+eHzNlBqdpSPiz8nEJICYb5SeC/xyPMpP8qA/IImuNdLQQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGCtZ5R+9+ggT5pXZCULkbLLO7rsRu7vy0kuObEqwzc=;
 b=KZKeCHPGyj8jJDTi4STErX8GhEgYb6t+w5hmKI2WsunpgVW7G4gTX3l7wxwwhToS8Au9+jMPRyT2OzdX2KiHrjtX+CxQ/uJ246JNMvomNwIItLWAd9XWKDba8xZDtOIaSvogedtyFGvUk7vCkxy4R9XE4dg9zENIN1lXrmi4l+VDSJtuVJf8tZBgfM+4HswEYd0Y8lDUZ959gPfQf9KBnHgr52/C/1TWDcAOUnXv6zYZLdTRsXpO5DoIWTE1uDqVYbyrKC9qwEf2+GlnFDgt6EoIY5bZ8A4sbc/yQMVb67dP34PZbiY7ifjDJwf0m/HJHzDdck+cw6rHjU46TqdRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGCtZ5R+9+ggT5pXZCULkbLLO7rsRu7vy0kuObEqwzc=;
 b=Vx4Dct8VhisCvg30GSDzRB6egUd+/0ohMKwsVu0mj/OI6LmRQBj5JxeCZ0oK4WeRZho4zzZ1o72bwm5rM4nf6aS7GWFzFEWATGM8J3WjX1GCiYtkMzTcDwCMjgR3lWGt7uYp4fd6EcoR/H8vewQ+lwMDZKkKu92eFDFBcMq6aus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by CH0PR19MB7850.namprd19.prod.outlook.com (2603:10b6:610:189::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 16:37:51 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%5]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 16:37:51 +0000
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
Subject: [PATCH v3 2/3] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Date: Thu,  4 Jul 2024 10:37:23 -0600
Message-Id: <20240704163724.2462161-3-martin.oliveira@eideticom.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef476c93-f2b4-4e91-ae84-08dc9c47a55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N09VhjWJpxlEuLqzrjKFshGZlVd5iqV7U9j0qpeXCEoClv1dbtaICSsZ/VOk?=
 =?us-ascii?Q?zp2quvD34QHrpFPlm2cZ9+/hnsNjMsF/ix9dRRI9CRXkfiUh1Ro8Y/nXMKL5?=
 =?us-ascii?Q?I7+1GxRdjF+7tKEtIsa+dPrjbIEGkLjELbLqnyF1epjAjmjvDFV0fghROlmr?=
 =?us-ascii?Q?vjb/lHUcz5gVBpvwuE3k8oo8c7VoBAxOIz/vAD2NYlTl5VdDRxKaJ33XToF6?=
 =?us-ascii?Q?I+yxxRVTXGYqE16ArI0cxhIpvD3E6VE40fRztdX8gR7YnQulhQdVJmGRIWsS?=
 =?us-ascii?Q?JcbkxikgsV5NoVTtIu8k0Jz1wl2UswjpFZnNRf1VuPbYB5JIen+BmaA+a45n?=
 =?us-ascii?Q?Vs2yGOCchqN7I03ybs3ds8+uW3sJZYezNlks2wb4MBSX6FB26bKkJNexpQ70?=
 =?us-ascii?Q?qb7DMkhNd1ILA5i3ursxFuGP1ACEPFfAlHhHbDZWmjI4IAI+JK4U0FjFNJhj?=
 =?us-ascii?Q?dBqT4eNhQ901B20XVbst1oGCfZ8RyXIOuoYaYRkKXK20sibEj5YQadE2kOap?=
 =?us-ascii?Q?9bvZfpgUynrG4k2TtdQn0m4+oGlYq0uX5zFJgGUS8KmNqEJ7Q/zevPA/ICVP?=
 =?us-ascii?Q?hDwYVfRLxF8FG+YKlyjyY3xv8NlbWdWG5lj0vZcasDf3GwSGJ1n1xum1avpl?=
 =?us-ascii?Q?0aEqG50RRGwZLVbj/h+Upz8lrtC3HBBLp5YdyUJcAm6OIqchVG1ommVBWKHI?=
 =?us-ascii?Q?mtviQH6f1sxDlply4Hw2RNeGy/wIT/x5saQsO1lrH7p7Fo5aUHA9rnM+2FxN?=
 =?us-ascii?Q?V8WNvf5X3NvNEfpyeKzTkSTg99DIzFmu2er6lTgd5fo8UT0HGvqCQDLgDpuq?=
 =?us-ascii?Q?ycfXv9s42kRJ4fLiEGcsNiDTAGHgZSS4IJaxm8JiY/nqynfAA33trFBNGHpV?=
 =?us-ascii?Q?+UXkPIdYSV45+YCjm+8IPjnJXNsScRZRtAzmQGK46vj8ynz7QmTAm7nIlqW1?=
 =?us-ascii?Q?0xxqvTUu4strJox/T+Z9Qy4UJJa9OyTWP42wseCuo1Jfr/ZNXS5t/VHTKE8r?=
 =?us-ascii?Q?/TGtK7ruI3zrPHQXliA0cX+qKnKAfSXWmCIkTUvM0HrwpEUuZyRhKPt3GXVa?=
 =?us-ascii?Q?Z/aQlyF/fF89AQEK9+MSHZKDZDY1OhKfS4Lf4POShTn4/JX8jfmy3UZ38K//?=
 =?us-ascii?Q?IplBLfxvA6Zx29Ocv+ih7GB7Sf6aUuMLT4zPfXTISHdTlRztu0wxZcvBuy81?=
 =?us-ascii?Q?2YFdDxiIfIY3BYk6kMbffVO1Ft3umfezM9S2PPLL+NjrL4UGb2eGyZPQ2uzt?=
 =?us-ascii?Q?oQ0dx30gqZgRQduAEVcgch23D3vmabuABF9XLWC/I33vgRJm8MM++qv0PTPi?=
 =?us-ascii?Q?ZH5e6Zfxd7q+7Sb7NcTgVIzCwP/ERKCPRsEpPAdId2VtMyEeTtSWdEPpcFX4?=
 =?us-ascii?Q?vRaLf0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdPtpFYAHspmw8PCldOIHVslqjtH2ofQFzZKB4uCuH4P65d8/Ht5//Wjbqa9?=
 =?us-ascii?Q?VlUI8OZWo5Vwf6brHu7f7YR13Pv5c6gmPbFLIDStLmk7WM7sROo0Oqe5SzSY?=
 =?us-ascii?Q?cln5BPD5gO5Q3vfQI46bzSykCATWVqPccuFjybsFhDhZcXJ+CTQSX8kanoPI?=
 =?us-ascii?Q?jzxSecx5Hn+gPGLM6rsxjHBM+bIrtscI0X1/cVJ6tx2CDk/GwDzLNmcX/ddB?=
 =?us-ascii?Q?cX3F7MITzpCPBw00UbYIGfBlXjkdP5O2XJdm6MIzqNZhJbg0MoWmVZmSM47c?=
 =?us-ascii?Q?4XR/rGMBtDOCYyAJKhaXI+1+KfJbgAaUSShaPI5w+CLHIq62WQoRTOhgYY10?=
 =?us-ascii?Q?KF5/TG2Ixgc+7PzjK+yQYzvA+H61GdOgK2INypIpFFVySOr+T3lKlB24+opJ?=
 =?us-ascii?Q?XN/t/7g93BugLIobzTZ2MgbAQdY4WW76GuXPUbZsrO7VXqNRCbUeCWP/kCXp?=
 =?us-ascii?Q?Uv3YKWZLuFFUdBBLehUtt6VPSukp3vaFUwvf3PlCcqVltQGooaEUikK+ralm?=
 =?us-ascii?Q?pEbzHRmOlHPL2QezryZy1eL0RZ8hd+0Q2YJFK8n68gFxCSlYHWJearyBKWkq?=
 =?us-ascii?Q?Dgn+i4ZvzO+Tc7DhTAm00Nv8enAy4xVA+vLkPYh71bU9T7IXl5x4c7q+fW3R?=
 =?us-ascii?Q?urJ2CWVHTyQ09DLnFG8iD2V6uD0sEIcdQIJwCnNDYls5tVJUyC3QwIuzcWiW?=
 =?us-ascii?Q?NsV4ByMvOtC7lKoZqPpcRrEszSkP26tCb5eqJAqv6yg3zb8O4IRv7gB06ev2?=
 =?us-ascii?Q?ORCiHfhS+4VoyJz79Uqnqux6ubw84SP8dHB/uPaQhajbsCIX1jk9DoffpAlU?=
 =?us-ascii?Q?QNk9RT2+wC5v10pJ5i+gNOsiu2pVa3qMUygWmJxaqylIBNv6twlodJnHCtFx?=
 =?us-ascii?Q?6WHSRnLWHz/xEmsVdmgjkp7cpDIkkgYwI7qGgEl62PpeqrPE1Db1/Ztri5O6?=
 =?us-ascii?Q?AL73fdiJKBLCcE+Cf9VK7Rei2cE4KhVMFxE+pr0d6NtUXCelyGeLx+upuqwN?=
 =?us-ascii?Q?TTI9a//ZJUXhSo8+PVximOEQYzXgcWdX1GATV8+3Xz1pUzbJS5dSrVqe8sFc?=
 =?us-ascii?Q?oAjrRm0jFfG9xlzTjfjGtLbjVm8AQzvRLkkJigoGM7kBLPgHf8vvDP2uzbrB?=
 =?us-ascii?Q?XZSOFJrEe454mJRu4oTPB/31R1SZ0i3oM7qp+UtA43fjrqlkWeqKZglk6jay?=
 =?us-ascii?Q?iNC0lycRObMHMkowBIO/55PgAfdvDUQ/sJ4u+qzkPWCSO5At81CV4uY+ouCm?=
 =?us-ascii?Q?k4P9mHIx1Z/tnXPnCo13wGAuXRudLGm3UBbn/OEQdpO5xBg7qKVR2c4tJf8b?=
 =?us-ascii?Q?d7M3ViOrNoM//WMXg/w8wuvhF4cM38IRzVAdRvkmonkWZHv7iJTicGaE1k1L?=
 =?us-ascii?Q?L6mm9oiFgrfJkidaZd3b2KIV3htB3n4QNlwtOGpYCuUbr9A9RvquXTvFVz1s?=
 =?us-ascii?Q?XjuN3xQL/ZCqhlZImWpRcKL/CPj+qiBnMqwMDUljFYeU8InPToxQ0jss8mli?=
 =?us-ascii?Q?bA4rvgfxPMa+GDU2cGCzPLGh/Anw84/46t9EuacGdauVBkoJpXJXOOC5ocrj?=
 =?us-ascii?Q?PfFOaIFJY6e65eGU2JgFMBEC8UN5Gh40RuxAIasFoEHUWICD5kbMnSE+whhX?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef476c93-f2b4-4e91-ae84-08dc9c47a55d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:37:51.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEqVqtbDblHl2Gk8ZWGKWlWKjXH/u8A/C4OKC/Y15ZtT8rEEQJw/OTfLdzqdMHxnDS8bfaBoS6+SemUIkMDD+z7Ho2Ua9b77QX6+v6DVNGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7850

This check existed originally due to concerns that P2PDMA needed to copy
fsdax until pgmap refcounts were fixed (see [1]).

The P2PDMA infrastructure will only call unmap_mapping_range() when the
underlying device is unbound, and immediately after unmapping it waits
for the reference of all ZONE_DEVICE pages to be released before
continuing. This does not allow for a page to be reused and no user
access fault is therefore possible. It does not have the same problem as
fsdax.

The one minor concern with FOLL_LONGTERM pins is they will block device
unbind until userspace releases them all.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>

[1]: https://lkml.kernel.org/r/Yy4Ot5MoOhsgYLTQ@ziepe.ca
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..6922e1c38d75 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2614,11 +2614,6 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 	if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !pages))
 		return false;
 
-	/* We want to allow the pgmap to be hot-unplugged at all times */
-	if (WARN_ON_ONCE((gup_flags & FOLL_LONGTERM) &&
-			 (gup_flags & FOLL_PCI_P2PDMA)))
-		return false;
-
 	*gup_flags_p = gup_flags;
 	return true;
 }
-- 
2.34.1


