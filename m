Return-Path: <linux-rdma+bounces-4468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEA295A47F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2008BB22377
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D02B1B3B3B;
	Wed, 21 Aug 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QfNNBl4q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C21B3B0C;
	Wed, 21 Aug 2024 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263878; cv=fail; b=UegJ9wlkAPvmy7dlGth1717ixH/NF8Minijq+IVw/d2SB89+htXOGZ2t2ksnhzdTnYN8Qlmy6RQWClr+3uxjh/2BLLeKVv2P1RwzYIeLIVeA0PUUgsT6PdWwewOf92UAdyMdvg8AIvFWKqC+teF4DmjQodsRr4KCLv32HuOCV+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263878; c=relaxed/simple;
	bh=kLUzLkH95R8u6jiAYTNwyFM/hZ+OrydQJGwGoWGbzIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5YWdTuBfBtxFGlsRsjjmM7fmYvxWUfJIyC6q/ohyk6fyJInhq4su0XJKcNPHVg014CuQzFE7WVHCSIJxfwOUvuLNiytp5NxGR2JzfBM42xGB+dJ21i3Audb++ooKsFN4QOl/1pOwP1/MpBdpK8M3Cxs51VCLd2kS0G5X/lEj94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QfNNBl4q; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7pVkTdDnaAE0L+am8ZfhsDotJfzu7Wx7GwNKk+SP2b5VAHBZTR2c4KeFQ9Xu0LMSLlFT5GrBDus+jPYRzgiTtY8TjcuoEsL1m7VF8XP2V9NLrADYPIiQS8hf9whzyXvsybEqlX+FmeGAwjSeSSCryenxx2Aw4hnBQDXFnu0o6zdFmcp7Z8MzorMqqdvDBx10OK3fZxmwUYj2J92cM+OgPd9VmBvUCpAzQJ835Ga/H/XxU8jCdmbFvrhAeAqZhDpJtBPCinsVSqwSfIm1Qpfcm/VDfFGgfA5Hf+SQKZMP70Q+jd1J9yKqbViRrcaBjEMULm6Kea0nfCexJVSowfAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlwvV7JPcZ5PzT+sCSlNqDOsGIiFuX4/kKdMrdQQYGY=;
 b=R8LQhMr+sYIV7NCOPRZcg+O40hcWSb3CE73UrgSSyjaUXLT2z4fSGv5RKkedcXNXbGKcZocJRmxhW5znDjXOPyCfUHdsuCMjK8nI2/c/j9igLygL3ElATq8FRUQAQwIhyoUU9wxUrj2G+c4VorPQO3GP3edR7fES8of9/VpE9v2cJ5GL1WP4jeIbKOtYFXfZr0Wg+7XXfYglTErQhLcYqKNaMIu7PNKELGcaSwwbK+zQE3LSvYt5iveFaWr8il03vh8girbiZmWfqNgqk/211yXJPThytGrOyn/w5pqi66UMFs0kmir2Y53lJfqZGds4UrSMIYmTtCLcEP1PwcIGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlwvV7JPcZ5PzT+sCSlNqDOsGIiFuX4/kKdMrdQQYGY=;
 b=QfNNBl4qJze96BF4G2phVkG69ZaqQjEYpUdiqZZw1+Ra+7Tk+W1N3i/ZaqGqYzGJHc597QrJfv76zauTXXKV+5jI1pJmEz6VnNE+eNEEWjsf5zsIzbKjhYxx4pnVETqx9lxsTxijmLUuTbLDBP00KiSOwZvuGk0VfabmLx64B6oNzgVWTH2GDoVseUeiIWz9Q2yK/ND5ZzsekpIvVtf2e0Bax9ApD+ZzGP/foJJp5e607LbrPhH1vLLZqHKWuAKw6oDx/ShwC8h2kN+3X+sRuQbkjR7BXtn7AsSaUw59GmQR+Qzsk3qeiITYIyVyEpYZ8ci+g436x/p3OqrrV1xrJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:05 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH v3 07/10] fwctl/mlx5: Support for communicating with mlx5 fw
Date: Wed, 21 Aug 2024 15:10:59 -0300
Message-ID: <7-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:408:d4::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f921c07-f1fb-4cc4-c03d-08dcc20c9e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKiuPR215Ymf/PGSlzqCco1wyIV3peHrDHTMxK0ARR3obVMpcxXVn6hIGGUj?=
 =?us-ascii?Q?j/fiZZzJO85nESIg8H1rkCBfjWMHltNy2TJIaXFEtiD1DjBsd1/s2Rx15BxK?=
 =?us-ascii?Q?jIxlOtR/bLYG9WRsCyaT2l1DUlJjRinItiHaczJQnfVxI0TUuhNGoLjdCDI1?=
 =?us-ascii?Q?QoPYMCv16pTWcekzHOjZyyw3Qt6h/lNr9sxYi2VisyIYWnaEPl87pfOPiObs?=
 =?us-ascii?Q?FrXSYIDq5ny0x17zwTy/n2Wrd4BsQoBUnDcpyEkwa7XJ2kg3KyI7UKVfzhjA?=
 =?us-ascii?Q?Od0mxkbxr+pNDU2w7rVTaauDc6+FFFu+d4pod81Ww3U8g0KewS73sKpUyx7H?=
 =?us-ascii?Q?WYvUVUMU6D0moP1CvEjgxbWzfdBPbIWJfyIN1uvGxBJRT8s0m+3OFY0Ow/b+?=
 =?us-ascii?Q?yPBEDMl7gciA/SW31WQrN31xZIgAjC6HJ4PaieVsDv8G8E5x3c+gD164p9nc?=
 =?us-ascii?Q?YOotLZw/P4I7VTzRDx/SqcEiZH1+h6UQpQcxuirwF+YSb4pfw111aUDXYf0+?=
 =?us-ascii?Q?6LrdSftLwP3ZEU5TlmUg5LVtTYWR1qgUfB2g8kpOd2q80FCmSn99IkMstQEZ?=
 =?us-ascii?Q?uF4hl0r5WThW6DYCNsPD97rKNN00Q+ISDy8BEYJkDe+x97fqtcAlBLMa0AuS?=
 =?us-ascii?Q?1HeVtQ3HeZU3W4VeDAbxm9VbX8HSDlUa1e6dHAEE0sXDTcF9JAdcWCHfLpqO?=
 =?us-ascii?Q?dZraoxIvNC/4zHX0mGxM529o6DpxNVvYS/hlAsI+2ilBNVAk6B9o1KgAIQHJ?=
 =?us-ascii?Q?r+PBmyyA4RM6Fh6zAzBjr+ocKxl8oKLTpfuE76bdLfZ7fotg0t7YmjUaj+zC?=
 =?us-ascii?Q?nhY5VMMqkIMr/rTGD4FNdvUA1sPV+8vujB037biNQGajRR8JtMLeCleZOtYu?=
 =?us-ascii?Q?uuC+4eO8fYD1giG9rQSex0b0Z2cxXFnJNh7VScF5apiDxxEGI4BemC19uJ8Q?=
 =?us-ascii?Q?eaV72jMKqB3aCBqdOP4YiuSXcA8Mfzw9+eKgJJ51KpaEjvDyibUDcoL1tuBA?=
 =?us-ascii?Q?ndmSMTNMWHNVlk0CQdfAwloL5dUrglpTBn4g8i/2qauC9Q7eUKZAzhwYaISW?=
 =?us-ascii?Q?gDUVsiTyo1n2iAS4YE6PN7CQhHf6jAatR421Mngw2F8taqZSaikzON8WML6t?=
 =?us-ascii?Q?MH2IU6Rm53v6nXjveFxCvoyXA2BM2IQjOaSnmMBEh5KRJ5udvtU9qfvxUx/T?=
 =?us-ascii?Q?eaKyQFQwOCWLhbuJBZNCFSfWS7cXcLnn8sUdWRGnVoW9rW2e4Ds7HWrL0Lrk?=
 =?us-ascii?Q?hjCUvkVxZl/0xSZichG0qfD0FL1YbIKNip2Abc9GLKbU+3jjiqvopIAHnGWX?=
 =?us-ascii?Q?WgR7eZK85H5OGeIzf9vgiy66nwn+WSEN0xcLt3AwR8fOPdHimUXl9JRS4Rwf?=
 =?us-ascii?Q?xurGkD8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTbdb6wvyWOy0yBrnaMuXmYJaNmiwA2hur8mHI6iUGzU+rX+/9X9bmjXcPIR?=
 =?us-ascii?Q?25tBcc1c2R1+9BkzdxT5DSRcKqVnVvPnYXo7JTgmd+4mRj1JwkxcXvqgOcFo?=
 =?us-ascii?Q?FrVSgJw+ejk5DuPd+UUpw8i+shTIVzAxJ+0VjynCguZ/k8l4t0lV86AsC296?=
 =?us-ascii?Q?1jqF/kUMGNFNv1g3dJ7IsrnJMudW5jFQhEtD29K3Rtp4V2gMYdE7lqh8bBbE?=
 =?us-ascii?Q?T/usJy3g2PINwKnle0tlx9p7+Mi0BPnGCnVkQS1UFNO2XDe4ycP/cgy3pmyv?=
 =?us-ascii?Q?5FcY/SwmiI4nJtQD5AYEtHfX9WZLEF1K+TPB1edb72JAvZRvtKflOb8DdD0f?=
 =?us-ascii?Q?rCJJ9l5159qqck6RqORFXTgsimHlf+zdt9eppVBFNWL5bN7WrQCLu2v1CVwO?=
 =?us-ascii?Q?hVvCB0KkrMb4VbY0e7tmI5jR+8nhr3dVDPAo1wtV5rSLtHXRzHc80fI6qkKK?=
 =?us-ascii?Q?P5/6M3N3EjbDPuoGQTV8FQtZC7L7HJbtQ5fMO4GFiP6qopY6f209QGaaAHmm?=
 =?us-ascii?Q?+ZELx//77wGSl4sETh3kgwnJZbtLFeoZFjSbWrAxtseQfRrb1JEkuJIFgppM?=
 =?us-ascii?Q?pof4QuThMguG+wAkhMEugMMLrh6nEQsXjnocNRAyqXcks/RFRP4O0gKBg8KE?=
 =?us-ascii?Q?1gmRtJGBhT7MpES4rsQ0EOYdZ+fcqHUsKIWv3ifhy1T36srOEDKNZZfgp/O6?=
 =?us-ascii?Q?vydTvBCZ+jPS9oTkxzB/NUR6YpRb3qC2PZHmC3SWJlY/Qa90CTNjiCwR+0ff?=
 =?us-ascii?Q?TJHzUXf3/cLkWE7pD2PE7V7ZkfGEO0RrqQl+qWC4UDybBTbJVNj92BaC/uA2?=
 =?us-ascii?Q?I5WHju2z4DAPwhF5Rhquv+it4XO9G4uzI8sDJMF6xwmMGuM4RW9NQ7aDEcPr?=
 =?us-ascii?Q?6UDLoMR50/71Lu4Vvxn/tk/CKCXoJZzoV9hZ5q40RopWeobzbweIzF4BaFxU?=
 =?us-ascii?Q?yXzxVaMQPWzHRRlDkJyk12CLTMh4GUcHf5Nxm54ozp5J5vtImhy89OsB8y8S?=
 =?us-ascii?Q?wikvkMVr/XEjhqnIrLcFWsPYJe8Gd7MWp6aZc7dZVTpPIiwWwgJf+XkQ3spo?=
 =?us-ascii?Q?I6eWvnKftI9fBSsXAgkI7YJk8P9n1jfd2n8tdtmoK2OMK0ux3EcpWYxQppYJ?=
 =?us-ascii?Q?EOOTqPaqqaG/L3gf+Ekuv5uTHJ2HNYzNw/dsvCjnp30esovbjU4LH6m4hpwy?=
 =?us-ascii?Q?UNRsrfdSv9up/yKJkN0V9x8AUI+kN3Me4mzzkZ0qQn/KlBuSWrgCpxs9eXRK?=
 =?us-ascii?Q?3E8NyQEf5+zRO/BH1SN+aUybJI3wfXPVozml8nS5I2G/L2pp/g7LRpn5Fb/y?=
 =?us-ascii?Q?Olpli3LJ5BRcEbmfefLucfzBXEywhmn7YgzirAKYSFQnGrzGtYJKBZn9v6bp?=
 =?us-ascii?Q?yhoRxaxZPkp/1ZCmrXpx/wVByxPYUEKT4ZFR1kLDQqnzB9TMiEfa6xIyhXqz?=
 =?us-ascii?Q?isO+8f7gVYQ8tb+IFss373XpqVOYv/hIRyZlWVhrJS9JRZ63C67w6/TcmvgP?=
 =?us-ascii?Q?+J1DNMUS1cEO75PQQwz1HPx+EmGtufEegMYTD1Xo/Jg3FRcARDbQf4HvERDj?=
 =?us-ascii?Q?p5H0HZVDEqrVDVtcLlhYOGBHmfjtuhOxVFL/iUGV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f921c07-f1fb-4cc4-c03d-08dcc20c9e54
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:03.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQLq6joXTTQt61ANNtGzWAiSsfqBwCcI7WuC7cnLdmrjCrcZGLHCUxAWlt5Pt9Qm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5's fw has long provided a User Context concept. This has a long
history in RDMA as part of the devx extended verbs programming
interface. A User Context is a security envelope that contains objects and
controls access. It contains the Protection Domain object from the
InfiniBand Architecture and both togther provide the OS with the necessary
tools to bind a security context like a process to the device.

The security context is restricted to not be able to touch the kernel or
other processes. In the RDMA verbs case it is also restricted to not touch
global device resources.

The fwctl_mlx5 takes this approach and builds a User Context per fwctl
file descriptor and uses a FW security capability on the User Context to
enable access to global device resources. This makes the context useful
for provisioning and debugging the global device state.

mlx5 already has a robust infrastructure for delivering RPC messages to
fw. Trivially connect fwctl's RPC mechanism to mlx5_cmd_do(). Enforce the
User Context ID in every RPC header so the FW knows the security context
of the issuing ID.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS                 |   7 +
 drivers/fwctl/Kconfig       |  14 ++
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/mlx5/Makefile |   4 +
 drivers/fwctl/mlx5/main.c   | 337 ++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/fwctl.h  |   1 +
 include/uapi/fwctl/mlx5.h   |  36 ++++
 7 files changed, 400 insertions(+)
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/uapi/fwctl/mlx5.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97945ca04b1108..d7d12adc521be1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9250,6 +9250,13 @@ F:	drivers/fwctl/
 F:	include/linux/fwctl.h
 F:	include/uapi/fwctl/
 
+FWCTL MLX5 DRIVER
+M:	Saeed Mahameed <saeedm@nvidia.com>
+R:	Itay Avraham <itayavr@nvidia.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/mlx5/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index 37147a695add9a..e5ee2d46d43126 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -7,3 +7,17 @@ menuconfig FWCTL
 	  support a wide range of lockdown compatible device behaviors including
 	  manipulating device FLASH, debugging, and other activities that don't
 	  fit neatly into an existing subsystem.
+
+if FWCTL
+config FWCTL_MLX5
+	tristate "mlx5 ConnectX control fwctl driver"
+	depends on MLX5_CORE
+	help
+	  MLX5CTL provides interface for the user process to access the debug and
+	  configuration registers of the ConnectX hardware family
+	  (NICs, PCI switches and SmartNIC SoCs).
+	  This will allow configuration and debug tools to work out of the box on
+	  mainstream kernel.
+
+	  If you don't know what to do here, say N.
+endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 1cad210f6ba580..1c535f694d7fe4 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
+obj-$(CONFIG_FWCTL_MLX5) += mlx5/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/mlx5/Makefile b/drivers/fwctl/mlx5/Makefile
new file mode 100644
index 00000000000000..139a23e3c7c517
--- /dev/null
+++ b/drivers/fwctl/mlx5/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_MLX5) += mlx5_fwctl.o
+
+mlx5_fwctl-y += main.o
diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
new file mode 100644
index 00000000000000..8839770fbe7ba5
--- /dev/null
+++ b/drivers/fwctl/mlx5/main.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/fwctl.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/mlx5/device.h>
+#include <linux/mlx5/driver.h>
+#include <uapi/fwctl/mlx5.h>
+
+#define mlx5ctl_err(mcdev, format, ...) \
+	dev_err(&mcdev->fwctl.dev, format, ##__VA_ARGS__)
+
+#define mlx5ctl_dbg(mcdev, format, ...)                             \
+	dev_dbg(&mcdev->fwctl.dev, "PID %u: " format, current->pid, \
+		##__VA_ARGS__)
+
+struct mlx5ctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+	u32 uctx_uid;
+};
+
+struct mlx5ctl_dev {
+	struct fwctl_device fwctl;
+	struct mlx5_core_dev *mdev;
+};
+DEFINE_FREE(mlx5ctl, struct mlx5ctl_dev *, if (_T) fwctl_put(&_T->fwctl));
+
+struct mlx5_ifc_mbox_in_hdr_bits {
+	u8 opcode[0x10];
+	u8 uid[0x10];
+
+	u8 reserved_at_20[0x10];
+	u8 op_mod[0x10];
+
+	u8 reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_mbox_out_hdr_bits {
+	u8 status[0x8];
+	u8 reserved_at_8[0x18];
+
+	u8 syndrome[0x20];
+
+	u8 reserved_at_40[0x40];
+};
+
+enum {
+	MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES = 0x4,
+};
+
+enum {
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS = 0x819,
+	MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS = 0x820,
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS = 0x821,
+	MLX5_CMD_OP_POSTPONE_CONNECTED_QP_TIMEOUT = 0xb2e,
+};
+
+static int mlx5ctl_alloc_uid(struct mlx5ctl_dev *mcdev, u32 cap)
+{
+	u32 out[MLX5_ST_SZ_DW(create_uctx_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_uctx_in)] = {};
+	void *uctx;
+	int ret;
+	u16 uid;
+
+	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
+
+	mlx5ctl_dbg(mcdev, "%s: caps 0x%x\n", __func__, cap);
+	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
+	MLX5_SET(uctx, uctx, cap, cap);
+
+	ret = mlx5_cmd_exec(mcdev->mdev, in, sizeof(in), out, sizeof(out));
+	if (ret)
+		return ret;
+
+	uid = MLX5_GET(create_uctx_out, out, uid);
+	mlx5ctl_dbg(mcdev, "allocated uid %u with caps 0x%x\n", uid, cap);
+	return uid;
+}
+
+static void mlx5ctl_release_uid(struct mlx5ctl_dev *mcdev, u16 uid)
+{
+	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
+	struct mlx5_core_dev *mdev = mcdev->mdev;
+	int ret;
+
+	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
+	MLX5_SET(destroy_uctx_in, in, uid, uid);
+
+	ret = mlx5_cmd_exec_in(mdev, destroy_uctx, in);
+	mlx5ctl_dbg(mcdev, "released uid %u %pe\n", uid, ERR_PTR(ret));
+}
+
+static int mlx5ctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	int uid;
+
+	/*
+	 * New FW supports the TOOLS_RESOURCES uid security label
+	 * which allows commands to manipulate the global device state.
+	 * Otherwise only basic existing RDMA devx privilege are allowed.
+	 */
+	if (MLX5_CAP_GEN(mcdev->mdev, uctx_cap) &
+	    MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES)
+		mfd->uctx_caps |= MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES;
+
+	uid = mlx5ctl_alloc_uid(mcdev, mfd->uctx_caps);
+	if (uid < 0)
+		return uid;
+
+	mfd->uctx_uid = uid;
+	return 0;
+}
+
+static void mlx5ctl_close_uctx(struct fwctl_uctx *uctx)
+{
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+
+	mlx5ctl_release_uid(mcdev, mfd->uctx_uid);
+}
+
+static void *mlx5ctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	struct fwctl_info_mlx5 *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uid = mfd->uctx_uid;
+	info->uctx_caps = mfd->uctx_caps;
+	*length = sizeof(*info);
+	return info;
+}
+
+static bool mlx5ctl_validate_rpc(const void *in, enum fwctl_rpc_scope scope)
+{
+	u16 opcode = MLX5_GET(mbox_in_hdr, in, opcode);
+
+	/*
+	 * Currently the driver can't keep track of commands that allocate
+	 * objects in the FW, these commands are safe from a security
+	 * perspective but nothing will free the memory when the FD is closed.
+	 * For now permit only query commands. Also the caps for the scope have
+	 * not been defined yet, filter commands manually for now.
+	 */
+	switch (opcode) {
+	case MLX5_CMD_OP_POSTPONE_CONNECTED_QP_TIMEOUT:
+	case MLX5_CMD_OP_QUERY_ADAPTER:
+	case MLX5_CMD_OP_QUERY_ESW_FUNCTIONS:
+	case MLX5_CMD_OP_QUERY_HCA_CAP:
+	case MLX5_CMD_OP_QUERY_HCA_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_ROCE_ADDRESS:
+		return scope <= FWCTL_RPC_CONFIGURATION;
+
+	case MLX5_CMD_OP_QUERY_CONG_PARAMS:
+	case MLX5_CMD_OP_QUERY_CONG_STATISTICS:
+	case MLX5_CMD_OP_QUERY_CONG_STATUS:
+	case MLX5_CMD_OP_QUERY_CQ:
+	case MLX5_CMD_OP_QUERY_DCT:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS:
+	case MLX5_CMD_OP_QUERY_EQ:
+	case MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_FLOW_COUNTER:
+	case MLX5_CMD_OP_QUERY_FLOW_GROUP:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE:
+	case MLX5_CMD_OP_QUERY_GENERAL_OBJECT:
+	case MLX5_CMD_OP_QUERY_ISSI:
+	case MLX5_CMD_OP_QUERY_L2_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_LAG:
+	case MLX5_CMD_OP_QUERY_MAD_DEMUX:
+	case MLX5_CMD_OP_QUERY_MKEY:
+	case MLX5_CMD_OP_QUERY_MODIFY_HEADER_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PACKET_REFORMAT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PAGES:
+	case MLX5_CMD_OP_QUERY_Q_COUNTER:
+	case MLX5_CMD_OP_QUERY_QP:
+	case MLX5_CMD_OP_QUERY_RMP:
+	case MLX5_CMD_OP_QUERY_RQ:
+	case MLX5_CMD_OP_QUERY_RQT:
+	case MLX5_CMD_OP_QUERY_SCHEDULING_ELEMENT:
+	case MLX5_CMD_OP_QUERY_SPECIAL_CONTEXTS:
+	case MLX5_CMD_OP_QUERY_SQ:
+	case MLX5_CMD_OP_QUERY_SRQ:
+	case MLX5_CMD_OP_QUERY_TIR:
+	case MLX5_CMD_OP_QUERY_TIS:
+	case MLX5_CMD_OP_QUERY_VHCA_MIGRATION_STATE:
+	case MLX5_CMD_OP_QUERY_VNIC_ENV:
+	case MLX5_CMD_OP_QUERY_VPORT_COUNTER:
+	case MLX5_CMD_OP_QUERY_VPORT_STATE:
+	case MLX5_CMD_OP_QUERY_WOL_ROL:
+	case MLX5_CMD_OP_QUERY_XRC_SRQ:
+	case MLX5_CMD_OP_QUERY_XRQ_DC_PARAMS_ENTRY:
+	case MLX5_CMD_OP_QUERY_XRQ_ERROR_PARAMS:
+	case MLX5_CMD_OP_QUERY_XRQ:
+		return scope <= FWCTL_RPC_DEBUG_READ_ONLY;
+
+	case MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS:
+		return scope <= FWCTL_RPC_DEBUG_WRITE;
+
+	case MLX5_CMD_OP_ACCESS_REG:
+		return scope <= FWCTL_RPC_DEBUG_WRITE_FULL;
+	default:
+		return false;
+	}
+}
+
+static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			    void *rpc_in, size_t in_len, size_t *out_len)
+{
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	void *rpc_alloc __free(kvfree) = NULL;
+	void *rpc_out;
+	int ret;
+
+	if (in_len < MLX5_ST_SZ_BYTES(mbox_in_hdr) ||
+	    *out_len < MLX5_ST_SZ_BYTES(mbox_out_hdr))
+		return ERR_PTR(-EMSGSIZE);
+
+	/* FIXME: Requires device support for more scopes */
+	if (scope != FWCTL_RPC_CONFIGURATION &&
+	    scope != FWCTL_RPC_DEBUG_READ_ONLY)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x inlen %zu outlen %zu\n",
+		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
+		    in_len, *out_len);
+
+	if (!mlx5ctl_validate_rpc(rpc_in, scope))
+		return ERR_PTR(-EBADMSG);
+
+	/*
+	 * mlx5_cmd_do() copies the input message to its own buffer before
+	 * executing it, so we can reuse the allocation for the output.
+	 */
+	if (*out_len <= in_len) {
+		rpc_out = rpc_in;
+	} else {
+		rpc_out = rpc_alloc = kvzalloc(*out_len, GFP_KERNEL);
+		if (!rpc_alloc)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	/* Enforce the user context for the command */
+	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
+	ret = mlx5_cmd_do(mcdev->mdev, rpc_in, in_len, rpc_out, *out_len);
+
+	mlx5ctl_dbg(mcdev,
+		    "[UID %d] cmdif: opcode 0x%x status 0x%x retval %pe\n",
+		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
+		    MLX5_GET(mbox_out_hdr, rpc_out, status), ERR_PTR(ret));
+
+	/*
+	 * -EREMOTEIO means execution succeeded and the out is valid,
+	 * but an error code was returned inside out. Everything else
+	 * means the RPC did not make it to the device.
+	 */
+	if (ret && ret != -EREMOTEIO)
+		return ERR_PTR(ret);
+	if (rpc_out == rpc_in)
+		return rpc_in;
+	return_ptr(rpc_alloc);
+}
+
+static const struct fwctl_ops mlx5ctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_MLX5,
+	.uctx_size = sizeof(struct mlx5ctl_uctx),
+	.open_uctx = mlx5ctl_open_uctx,
+	.close_uctx = mlx5ctl_close_uctx,
+	.info = mlx5ctl_info,
+	.fw_rpc = mlx5ctl_fw_rpc,
+};
+
+static int mlx5ctl_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
+
+{
+	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = madev->mdev;
+	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = fwctl_alloc_device(
+		&mdev->pdev->dev, &mlx5ctl_ops, struct mlx5ctl_dev, fwctl);
+	int ret;
+
+	if (!mcdev)
+		return -ENOMEM;
+
+	mcdev->mdev = mdev;
+
+	ret = fwctl_register(&mcdev->fwctl);
+	if (ret)
+		return ret;
+	auxiliary_set_drvdata(adev, no_free_ptr(mcdev));
+	return 0;
+}
+
+static void mlx5ctl_remove(struct auxiliary_device *adev)
+{
+	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&mcdev->fwctl);
+}
+
+static const struct auxiliary_device_id mlx5ctl_id_table[] = {
+	{.name = MLX5_ADEV_NAME ".fwctl",},
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, mlx5ctl_id_table);
+
+static struct auxiliary_driver mlx5ctl_driver = {
+	.name = "mlx5_fwctl",
+	.probe = mlx5ctl_probe,
+	.remove = mlx5ctl_remove,
+	.id_table = mlx5ctl_id_table,
+};
+
+module_auxiliary_driver(mlx5ctl_driver);
+
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("mlx5 ConnectX fwctl driver");
+MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 3af9f9eb9b1878..f9b27fb5c1618c 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -42,6 +42,7 @@ enum {
 
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
+	FWCTL_DEVICE_TYPE_MLX5 = 1,
 };
 
 /**
diff --git a/include/uapi/fwctl/mlx5.h b/include/uapi/fwctl/mlx5.h
new file mode 100644
index 00000000000000..bcb4602ffdeee4
--- /dev/null
+++ b/include/uapi/fwctl/mlx5.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ *
+ * These are definitions for the command interface for mlx5 HW. mlx5 FW has a
+ * User Context mechanism which allows the FW to understand a security scope.
+ * FWCTL binds each FD to a FW user context and then places the User Context ID
+ * (UID) in each command header. The created User Context has a capability set
+ * that is appropriate for FWCTL's security model.
+ *
+ * Command formation should use a copy of the structs in mlx5_ifc.h following
+ * the Programmers Reference Manual. A open release is available here:
+ *
+ *  https://network.nvidia.com/files/doc-2020/ethernet-adapters-programming-manual.pdf
+ *
+ * The device_type for this file is FWCTL_DEVICE_TYPE_MLX5.
+ */
+#ifndef _UAPI_FWCTL_MLX5_H
+#define _UAPI_FWCTL_MLX5_H
+
+#include <linux/types.h>
+
+/**
+ * struct fwctl_info_mlx5 - ioctl(FWCTL_INFO) out_device_data
+ * @uid: The FW UID this FD is bound to. Each command header will force
+ *	this value.
+ * @uctx_caps: The FW capabilities that are enabled for the uid.
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_mlx5 {
+	__u32 uid;
+	__u32 uctx_caps;
+};
+
+#endif
-- 
2.46.0


