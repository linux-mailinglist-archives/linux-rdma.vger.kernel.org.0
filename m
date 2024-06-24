Return-Path: <linux-rdma+bounces-3461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36865915A12
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21372834EA
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712A1A2FA5;
	Mon, 24 Jun 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+d0+vss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E61A2573;
	Mon, 24 Jun 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269268; cv=fail; b=QhMwph0wWZuE6z4+Weo853LYo5/nwoQ/SLvSBL7WhaJGqaS/PsWiUY55k6O9QlRLEpsoxGy8JOHojI197QQu7jQLLyug3y6JEQmSWeeWDN0G/szcUevdqMJ0oO1UwKm0F4zezZeTzdwOM0dwvbVo5fP1OkAGs8VB/PHd2jfyktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269268; c=relaxed/simple;
	bh=9LL8FTTeqBAcEeNsr/jEn26HrKYFsCnLecYZqYjqnAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTKcUiVXxYug6fXQoDgdfvyn71UUXHSkWV0UpK7CkT/j6/PdqPDbZl7zi4tA40zIMX4KBL2dY0LRQkJ0XzPjZNN40K6b5HlQQ1OAtY+Q50SEyNr4tda4b7YRbzysItbb011AWBdWsnSxSYPyRkTF3qBCzjvkg898s96QSSk7Qkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+d0+vss; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itYpGD7n8xVAiQO7sTGztQ6gs44qNEQmLskJ+bnjupWEBXsGfZHcoIzEHsZz0tiLoDRz+ciVo2An1Js//NYlEP3XG/hO+7KmW88iztqfggmajchBksVp3smFpVdUQPznfQ9IrMzsDDghsPbPxfJj3X+wcAmc2lbYnXTMwrVvcLuERpws4r9/gUhTqnFW7i2oz8MNgwveq1vJaa6kO+whTh9uoHllhrtPRAY7jD4untpZqAHlwwB627j7WrVHsKnUeuIwfdBOYyjufjEN3f9PvYXxr07gecsQbjhFtfP/g1a3cZmCt7udx91t/eScC2M3xASZeRmTtH4mgrYLQ55qRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TBNPrZNu2noX0hR3hUW2WU/nT7Y3Zwpb5vhJl0vwi0=;
 b=MCMsTexjxJ87Tg71WhlUvyHcMNREauVlSMB7kjkSDBntHO+jUGJAJ2TeIU91yN98dCi0T65XTRPVjPySEBH4QO0LEPu+CU3yZHXfjsLOzeN72pxkr2VKmhppfVqj0lnXlmUmRaA5sFFk4pkOp7AC13lEWi4S0YJuhpQ7As6nSvWvSZBtX6EB+trVII5Bm2Zql8WxgSdO7HTqrp5VIlEK629gm88BmKz5pQGxuTdyXu27+7welZvhKOQyCbN+2DpB26sZnqiJEKEB6iqdv1vCw8fP3fG/2Wj2bhnQc1cAinbgVwPAXeFQRWhUC3dRhpnF38QIGfWoZWI1pQBTnYELAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TBNPrZNu2noX0hR3hUW2WU/nT7Y3Zwpb5vhJl0vwi0=;
 b=R+d0+vsspCzKkhXkqiQwo86gNJ2Mw+fjvuUCXtEP1XKoTLJWn0Wj0DfkBsQdq8n/z5wnGE+PdEdd4Di8fnY5JOrp0PYeVYVrOTZ9dILDc2Z+UyBM8+6COOJFA6DoT6SjAUZqpzL+TDy+Cq0qTbW5MqnkbNVP++G1sXW8EsGCW1u1kKAlT1OMep1MZ8FU1AeicpXqLOWCyhs5C/iw7naWOWDCDPFfSewHOaYxjUYLtfwji/HWp/u/5qKKpd3eAODIh000+qXiL6Nkz8EAOmt4S5OvVuD5LVXFmgO1cM4opJWlOce/mYVel04eLhhQZk1IdKpi0ymC1SV6BZY7nmuqtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 22:47:41 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v2 2/8] fwctl: Basic ioctl dispatch for the character device
Date: Mon, 24 Jun 2024 19:47:26 -0300
Message-ID: <2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 6209cb50-091b-4700-864d-08dc949fa417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|7416011|366013|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qDmf3lf+10UZtCJ0ONtxHIrKZN7VSX4I5g7rNvEYv/A7gWJVe+ezWGVdXQXe?=
 =?us-ascii?Q?/DnTVZ5Tjb9ehXXIpHth4RMHidEq9bYX1eElCrGIHcTLkiehhIxtB8QgOBYc?=
 =?us-ascii?Q?EBCFhsb8++r/KIokjdOGsoKWc3hDRHKn90VC2Vcio+JcGCu7meC/WGpbz2OF?=
 =?us-ascii?Q?PEBScUn4tWzkVoVkAkpaxLZUFwMPiOSqaWXRn0qdPvuOEb3tATjH3XYDFu+n?=
 =?us-ascii?Q?AQmxqUgf7N5XSSK8bHP6f98t8OjwAJeb7nt/qpKk9drV0bnczJttgV41LnzE?=
 =?us-ascii?Q?PVNi02Ea7r9wuQ8rgzbroYBPENeSYHkqYgJDpniszquLXQH/FaX4YvwC8VBe?=
 =?us-ascii?Q?gYt/BDgT8jlOPsZBfTQ0ihXwpQzhR5txomeahaPa6GkAZlD447pNtu6662gc?=
 =?us-ascii?Q?o3sMgtr6OcF+x5N/TZ8BH6bnOEJ1R19ZadjHztU1N6rUj5t4C1BOuwvQBLsU?=
 =?us-ascii?Q?m2mKZkHJobfjwJI81tQzcrzaw8652ntJ1ZxoflG/2yGZj6NrfmZWpr/u5pb9?=
 =?us-ascii?Q?2hT6HVao3ylaar84XC1A5EAIaRliiO2irAO3RLUw7SaDPlIvV75kRvniKbY3?=
 =?us-ascii?Q?3DNKlCZQLQC6tsHznoIqyF+qhq2ZcQ+WBvsv9fmuGBVrVYmJy8kh2fd0Jelp?=
 =?us-ascii?Q?ZaXBxXPhrg6Ub4NgE+rDPGxtTy7zm1fh2NXQ+zaTUHk6fxY9YWG1RM8PjvDH?=
 =?us-ascii?Q?7IzQQGywxT3mAW2ZuMj9nvmnGhZb28e4zszuVD5c78gO8luSoxPH+VXRHw+z?=
 =?us-ascii?Q?rxig9Ja3/TfBj9f/Nhmo+h1rYszQIguFRJUDxlzlBowAegqEAnZPxrs5KtXi?=
 =?us-ascii?Q?w8SdX6NQYva6Ayxi4ub1G1HstfXw/m2c3RNy+gY+dtqnBz31WQMVwZHV0CgH?=
 =?us-ascii?Q?xvzXi6TTQNH6caj+/6Q53qYl4ZDrftxr6GqJBQJIPoXQ6lJcMYXVtHe+NcKI?=
 =?us-ascii?Q?ZAW8GHrQqh7A8NkXMvUUTL6cbfyEcDvgl2yUpNa1cGiAKCVNvR97RBOgmlKX?=
 =?us-ascii?Q?q/EYoneSlR7IQZrYHIeCiD0bAyK/DmCeoKgCwD1a3t1R+hK/2PJTPf8L9pCO?=
 =?us-ascii?Q?dF/1ZYCz3wW2ZB5qiS6/l1/Z0Z7sfxub6bUOjAVzcfro10cpILC0dk2Qbn+u?=
 =?us-ascii?Q?sOZF+4HfVWbkm7hOIDQxs2CqpMY5vw/TDhCjwbfdjt1eGXScBj/gxhCufjcv?=
 =?us-ascii?Q?A33cumnyGerYq8gpmlD8hpV8MajZV4/jtazMt+BzYZh8x9DL1BfdX5usxZmL?=
 =?us-ascii?Q?PKIWSWpRWw2L4vVuvadyAQa79kdsaCKWSo31+uszI/UwFQX/MW4OeiWCdO75?=
 =?us-ascii?Q?8gOnYjsCcg5SdSzS3Kt3icY3rHXWoVW+O6fj4Sc2AVJSc33rR734HS52eBnk?=
 =?us-ascii?Q?HhLLUEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q35spNaUx0peN1n/MBRqDHbqecRYL+uYdakOKFwY6hFaMpo7CM9k5yMYlEEo?=
 =?us-ascii?Q?WA83PoXQJXT00Fn+DkIYeUxzsZJqkp2XlDHVZh0W5RpC8InDxTSt+ZEYxBhN?=
 =?us-ascii?Q?smtJ/4gHlV5BqOvrwKOWtARCjUAPI8l1yiP5ML+Lju4j+B3WKb6b+96WLB5j?=
 =?us-ascii?Q?CESMZK/HS0YI4Vgix+1MBB+zC4P7bwPmMwVt4Y8sEWYtilpAPGjqsrU2cTY+?=
 =?us-ascii?Q?oqPAEswNlYYIZxO//y1GMBBqwnIcAdv2VWjx1ghj7maDNse/t3IqENsMRpDw?=
 =?us-ascii?Q?PKoIaLl5VQx2WtvWLcnlZpCUu95cQ1dMz8usnv5/y2uOc6krK1VEbYiLgbPE?=
 =?us-ascii?Q?bVdO/08BO1M+QXE50NV4gQchtKo+Rx0nj9pvsZlSbDY3lfM3mLDLfqLcvQ94?=
 =?us-ascii?Q?hLtr4bD+cryZTHSHcuGDMp/HOCk1kSYBMf2HwT/32lYuiXKFcrhMUAoXCadE?=
 =?us-ascii?Q?78t5s7tx+EXLMCQ/VJeWgW8SjWSuI2zONgfVDfmBejzwCUjF9/oHW22ohzUv?=
 =?us-ascii?Q?0/MjjGSFgLwkR118axLfuC+ziV6T2J6DALwOKLpLVncM+DWyeC9x6CzJPIiM?=
 =?us-ascii?Q?ATo9k3hqWR9yz/Qj6r+T4jbKfqrowSWHATZ5qCRxfzAc5fb9Bp1aDi1qtnmA?=
 =?us-ascii?Q?cc+KAJOQq73EWuXWCipflU6FPXzw342hF2D/S5MHFByQhCpCi8/Z5HXFZxIq?=
 =?us-ascii?Q?Mmv0yqsrKnezWPMRCCbgZWQwYNtbYljS7U0V+m4Atqot3hMBV5TDOTa9NUuA?=
 =?us-ascii?Q?N7D/4O/Po8RmQ2EI65GuRdNmH2Xe0CbdC2KcdT/NiDEdvHkMLg0k/IVIgZIa?=
 =?us-ascii?Q?jYDJg2SamAXWm1d1nGRvvn032lOz5um/FqYzbbdqr6w5IaGrgh2oolmyKoOD?=
 =?us-ascii?Q?IAHNYXBCFmyqGo9gPZnhWRiPs2kS164ZG/jKNJ8MSoEq0uOdyzDxqVrrngx8?=
 =?us-ascii?Q?MIe47sc3lJDA/0IiWW2xQMY3/43/QD9BcwaMFQZjFzTKtgr3Fc9SYRGFixEq?=
 =?us-ascii?Q?qR+DPRBnm067wh6yRHs4LLxPb4IQz1i9UHAVT4q4mNbweUgvwYTajRvEzaEJ?=
 =?us-ascii?Q?fkJm0d9YONAVsL1MiuErpjQIk/nJzL8LkjgmcooemKzsRy6x2XKyuoJOCj7u?=
 =?us-ascii?Q?JE3pI35NDYAvgLgr7cZ4191Zkyc2S9YGXhe3gHRGhLZeTgdQ86ZRpx+r3Wrt?=
 =?us-ascii?Q?sdhnt3KRJBXghboTj4vkGC973mszzwdRR13JGaXdE2yEaGf8kicxbUzYtDw6?=
 =?us-ascii?Q?9WFMufDa5zT3F25Gvyz9gpthcgoLUI0jGlqgZBq6JiSY2N9SM4xOoreESksF?=
 =?us-ascii?Q?Dka3Pjf2jqKLIeckx4/5XWHtb4PrRLvnbI7+Rr+uhcpPwtXOidhLKBzRaJ8N?=
 =?us-ascii?Q?5NNcyQUUfBn4Kyr9q0PI39d7WWRP9DdS1Eb5GAKb5NMRCDB6/gHIFsB394iH?=
 =?us-ascii?Q?zC6f23nkEU0y9uWpBriSU2dMszqHVVnpDjUdzvVZLyia7AHWHpvtJMrKN+SA?=
 =?us-ascii?Q?B1S+SkDgVvv7BVnmge1Iyvdi+R9BHG5B/K74x5Q4W6jeYcokKGfWoqzfLHeY?=
 =?us-ascii?Q?ZEA0HC76Puz+xu4N5eIshiL/2xnBbZOmrFkxKZId?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6209cb50-091b-4700-864d-08dc949fa417
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:35.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLLIMgMBVmFM+eotuQP3yybmQXhwvuMv3p8z+zc8GO9gE8ws2omkC6snF1gzgOjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

Each file descriptor gets a chunk of per-FD driver specific context that
allows the driver to attach a device specific struct to. The core code
takes care of the memory lifetime for this structure.

The ioctl dispatch and design is based on what was built for iommufd. The
ioctls have a struct which has a combined in/out behavior with a typical
'zero pad' scheme for future extension and backwards compatibility.

Like iommufd some shared logic does most of the ioctl marshalling and
compatibility work and tables diatches to some function pointers for
each unique iotcl.

This approach has proven to work quite well in the iommufd and rdma
subsystems.

Allocate an ioctl number space for the subsystem.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/fwctl/main.c                          | 124 +++++++++++++++++-
 include/linux/fwctl.h                         |  31 +++++
 include/uapi/fwctl/fwctl.h                    |  41 ++++++
 5 files changed, 196 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/fwctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d3a..4d91c5a20b98c8 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -324,6 +324,7 @@ Code  Seq#    Include File                                           Comments
 0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
 0x99  00-0F                                                          537-Addinboard driver
                                                                      <mailto:buk@buks.ipn.de>
+0x9A  00-0F  include/uapi/fwctl/fwctl.h
 0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
                                                                      <mailto:kenji@bitgate.com>
 0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
diff --git a/MAINTAINERS b/MAINTAINERS
index aa7a760d12f8ef..2090009a6ae98a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9083,6 +9083,7 @@ S:	Maintained
 F:	Documentation/userspace-api/fwctl.rst
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
+F:	include/uapi/fwctl/
 
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 6e9bf15c743b5c..6872c01d5c62e8 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -9,26 +9,131 @@
 #include <linux/container_of.h>
 #include <linux/fs.h>
 
+#include <uapi/fwctl/fwctl.h>
+
 enum {
 	FWCTL_MAX_DEVICES = 256,
 };
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
 
+struct fwctl_ucmd {
+	struct fwctl_uctx *uctx;
+	void __user *ubuffer;
+	void *cmd;
+	u32 user_size;
+};
+
+/* On stack memory for the ioctl structs */
+union ucmd_buffer {
+};
+
+struct fwctl_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct fwctl_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                         \
+	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                        \
+		.size = sizeof(_struct) +                             \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) < \
+					  sizeof(_struct)),           \
+		.min_size = offsetofend(_struct, _last),              \
+		.ioctl_num = _ioctl,                                  \
+		.execute = _fn,                                       \
+	}
+static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+};
+
+static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct fwctl_uctx *uctx = filp->private_data;
+	const struct fwctl_ioctl_op *op;
+	struct fwctl_ucmd ucmd = {};
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int ret;
+
+	nr = _IOC_NR(cmd);
+	if ((nr - FWCTL_CMD_BASE) >= ARRAY_SIZE(fwctl_ioctl_ops))
+		return -ENOIOCTLCMD;
+	op = &fwctl_ioctl_ops[nr - FWCTL_CMD_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+
+	ucmd.uctx = uctx;
+	ucmd.cmd = &buf;
+	ucmd.ubuffer = (void __user *)arg;
+	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (ret)
+		return ret;
+
+	if (ucmd.user_size < op->min_size)
+		return -EINVAL;
+
+	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (ret)
+		return ret;
+
+	guard(rwsem_read)(&uctx->fwctl->registration_lock);
+	if (!uctx->fwctl->ops)
+		return -ENODEV;
+	return op->execute(&ucmd);
+}
+
 static int fwctl_fops_open(struct inode *inode, struct file *filp)
 {
 	struct fwctl_device *fwctl =
 		container_of(inode->i_cdev, struct fwctl_device, cdev);
+	int ret;
+
+	guard(rwsem_read)(&fwctl->registration_lock);
+	if (!fwctl->ops)
+		return -ENODEV;
+
+	struct fwctl_uctx *uctx __free(kfree) =
+		kzalloc(fwctl->ops->uctx_size, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
+	if (!uctx)
+		return -ENOMEM;
+
+	uctx->fwctl = fwctl;
+	ret = fwctl->ops->open_uctx(uctx);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &fwctl->uctx_list_lock) {
+		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
+	}
 
 	get_device(&fwctl->dev);
-	filp->private_data = fwctl;
+	filp->private_data = no_free_ptr(uctx);
 	return 0;
 }
 
+static void fwctl_destroy_uctx(struct fwctl_uctx *uctx)
+{
+	lockdep_assert_held(&uctx->fwctl->uctx_list_lock);
+	list_del(&uctx->uctx_list_entry);
+	uctx->fwctl->ops->close_uctx(uctx);
+}
+
 static int fwctl_fops_release(struct inode *inode, struct file *filp)
 {
-	struct fwctl_device *fwctl = filp->private_data;
+	struct fwctl_uctx *uctx = filp->private_data;
+	struct fwctl_device *fwctl = uctx->fwctl;
 
+	scoped_guard(rwsem_read, &fwctl->registration_lock) {
+		if (fwctl->ops) {
+			guard(mutex)(&fwctl->uctx_list_lock);
+			fwctl_destroy_uctx(uctx);
+		}
+	}
+
+	kfree(uctx);
 	fwctl_put(fwctl);
 	return 0;
 }
@@ -37,6 +142,7 @@ static const struct file_operations fwctl_fops = {
 	.owner = THIS_MODULE,
 	.open = fwctl_fops_open,
 	.release = fwctl_fops_release,
+	.unlocked_ioctl = fwctl_fops_ioctl,
 };
 
 static void fwctl_device_release(struct device *device)
@@ -45,6 +151,7 @@ static void fwctl_device_release(struct device *device)
 		container_of(device, struct fwctl_device, dev);
 
 	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	mutex_destroy(&fwctl->uctx_list_lock);
 	kfree(fwctl);
 }
 
@@ -69,6 +176,9 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 		return NULL;
 	fwctl->dev.class = &fwctl_class;
 	fwctl->dev.parent = parent;
+	init_rwsem(&fwctl->registration_lock);
+	mutex_init(&fwctl->uctx_list_lock);
+	INIT_LIST_HEAD(&fwctl->uctx_list);
 
 	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
 	if (devnum < 0)
@@ -137,8 +247,18 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
  */
 void fwctl_unregister(struct fwctl_device *fwctl)
 {
+	struct fwctl_uctx *uctx;
+
 	cdev_device_del(&fwctl->cdev, &fwctl->dev);
 
+	/* Disable and free the driver's resources for any still open FDs. */
+	guard(rwsem_write)(&fwctl->registration_lock);
+	guard(mutex)(&fwctl->uctx_list_lock);
+	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
+						struct fwctl_uctx,
+						uctx_list_entry)))
+		fwctl_destroy_uctx(uctx);
+
 	/*
 	 * The driver module may unload after this returns, the op pointer will
 	 * not be valid.
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index ef4eaa87c945e4..1d9651de92fc19 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -11,7 +11,20 @@
 struct fwctl_device;
 struct fwctl_uctx;
 
+/**
+ * struct fwctl_ops - Driver provided operations
+ * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
+ *	bytes of this memory will be a fwctl_uctx. The driver can use the
+ *	remaining bytes as its private memory.
+ * @open_uctx: Called when a file descriptor is opened before the uctx is ever
+ *	used.
+ * @close_uctx: Called when the uctx is destroyed, usually when the FD is
+ *	closed.
+ */
 struct fwctl_ops {
+	size_t uctx_size;
+	int (*open_uctx)(struct fwctl_uctx *uctx);
+	void (*close_uctx)(struct fwctl_uctx *uctx);
 };
 
 /**
@@ -26,6 +39,10 @@ struct fwctl_device {
 	struct device dev;
 	/* private: */
 	struct cdev cdev;
+
+	struct rw_semaphore registration_lock;
+	struct mutex uctx_list_lock;
+	struct list_head uctx_list;
 	const struct fwctl_ops *ops;
 };
 
@@ -65,4 +82,18 @@ DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
 int fwctl_register(struct fwctl_device *fwctl);
 void fwctl_unregister(struct fwctl_device *fwctl);
 
+/**
+ * struct fwctl_uctx - Per user FD context
+ * @fwctl: fwctl instance that owns the context
+ *
+ * Every FD opened by userspace will get a unique context allocation. Any driver
+ * private data will follow immediately after.
+ */
+struct fwctl_uctx {
+	struct fwctl_device *fwctl;
+	/* private: */
+	/* Head at fwctl_device::uctx_list */
+	struct list_head uctx_list_entry;
+};
+
 #endif
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
new file mode 100644
index 00000000000000..0bdce95b6d69d9
--- /dev/null
+++ b/include/uapi/fwctl/fwctl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
+ */
+#ifndef _UAPI_FWCTL_H
+#define _UAPI_FWCTL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define FWCTL_TYPE 0x9A
+
+/**
+ * DOC: General ioctl format
+ *
+ * The ioctl interface follows a general format to allow for extensibility. Each
+ * ioctl is passed in a structure pointer as the argument providing the size of
+ * the structure in the first u32. The kernel checks that any structure space
+ * beyond what it understands is 0. This allows userspace to use the backward
+ * compatible portion while consistently using the newer, larger, structures.
+ *
+ * ioctls use a standard meaning for common errnos:
+ *
+ *  - ENOTTY: The IOCTL number itself is not supported at all
+ *  - E2BIG: The IOCTL number is supported, but the provided structure has
+ *    non-zero in a part the kernel does not understand.
+ *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
+ *    understood, however a known field has a value the kernel does not
+ *    understand or support.
+ *  - EINVAL: Everything about the IOCTL was understood, but a field is not
+ *    correct.
+ *  - ENOMEM: Out of memory.
+ *  - ENODEV: The underlying device has been hot-unplugged and the FD is
+ *            orphaned.
+ *
+ * As well as additional errnos, within specific ioctls.
+ */
+enum {
+	FWCTL_CMD_BASE = 0,
+};
+
+#endif
-- 
2.45.2


