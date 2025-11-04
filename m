Return-Path: <linux-rdma+bounces-14242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182FC318ED
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 15:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BFBD4F72B7
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF0330D38;
	Tue,  4 Nov 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2ylYXlw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFC32ED59;
	Tue,  4 Nov 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266686; cv=fail; b=Pea8pykOOMoEu3HdFDeKcG6ZKmFuqB19MbUoWxPQlSChU0mp/o/tx9nr4Qto8+SNcP7rt3x5DhvETqAu4r3FKjmynWpNKIGsVK87IRjv5nH8bKMjvUp6auJD12DZe6mUjJ+XKdvcY9Qf18CbVEsMZsP9ZOzUSHVybmIbUxl0XPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266686; c=relaxed/simple;
	bh=l/6s8WSAz2xi0IAG1OBKMTt+ORFR/hz4Oh45ZjPkjDc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=H3/KHrcs9thb3N0PcHhNVj+VVcTSU+ivMBN32L278aItnOpzhSkwCtkVn+9IjV8CBX1HX3+By45erBwYxg6TgddIb8NH818lH8kluhQ9zMo2KOG2UE11ToxpmhNWh1sYMe9UoV74EN7OY2bvHOgFb4CAOSQVk/1u6CoxT0ZPxhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2ylYXlw; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HANKFNjGBfBtiqH4+nHwqgc6gs1e2uUSRtjYAKNRIeNry0huXxoqhClvs/qNyTtkKUJtgVbnyS2ETWH8ddmQrsf5qQhBoqQgHIouekwodTmfu/cLaT5BM3ubLzqlMYTNxPNfJZKDVMSNZu+6RdQpGr+G+8240JArbdi0u23cm7+0K+TBX5BcinbkaqMPsk6bPV+GvLOQ62Y/z6f245IBD0uteuXt0KOM5YpOG5qF2ytJPbvdR8GFhL9U9praW7cqvWwCYvzSsMIcPcSgCfaDD2/UpKUmK/stJwe7nRKFJfBpJ02U+0zKhL7NxOa4WKyY6TeYfU3ahBSbMpYT7vdJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5arSa1wHm3Mt8I3QRx/HZurwJAQrb2gpOlbYd3M19A=;
 b=fcWGLxn2tC36Zctb953XOZ15yqokNBntJgztePTZ9pKDhAb9lyQqyDsafGT1KsRvMR4hi9drkUfwNpyxMe9pRCOAdkEZLcRlZV1wQoLgrjkUMBgXqGy6QHIluklRXcWBbXyJSXgM03VWwIiJAWIRLvAMOO5rSF8MRU0x9ztw0TcoiN/fmumoRgH2BMMfOBXY1vO1XuaKeR3+zy9B8jt+t3QtptShnPSSxpgfAO9b7YVdYVFXPWF8Uku3LDNdE7w7Idz7tusmJDU61l5OxFcvzUJ7f62l3o5wmt01dlx7vVD9YB+HrETIHgN0o8QYRedYfnluGKXZWVTQqjyldf9XjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5arSa1wHm3Mt8I3QRx/HZurwJAQrb2gpOlbYd3M19A=;
 b=s2ylYXlw1EMHluklYT6305WHeIQp+uGOBvlv0iXB2N5nHEJJFVM6wnU3COjsCSeeCH94qMIYaZB8vUzLSkfGP7+az2xe1y5KWgoM+Onvm2cz7gO2Q3sPfUltqJrvhC0TMMfO57IhUZoT46DJZaS/hmsPbV/7GgWd5Fi91v4sJSCwtkzdxJkzDyRatUR+nBmSXMCml1F9kcTA3KwEeZvbB4u6RAbfy4+P4NIDKvdSYAwcbFx61n58C7XXqtqfjoMB7bBlMhXvvPn4mGXeaWHbtUBy0W+gjhYV/d8qnWmcrFb+wj5whLnfhFcd0EBm/klKbbtXebxHADKdvMejoue2RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 14:31:19 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 14:31:19 +0000
Date: Tue, 4 Nov 2025 10:31:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20251104143118.GA1641561@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KLaIEjiw9rkz0mzR"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7eec24-2df2-4ef3-ba79-08de1baed20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UmfLakPyg9GUtlMJDdjd5cIhrbzGzGnJ8YFLEhVSOT23tNh3wlhylueFgqA6?=
 =?us-ascii?Q?1kWWgwXiKXA1d3+MQL27n9XCoiUAS27vkzIsrcsSzxKWUF5nsJ+/cV9gzJD7?=
 =?us-ascii?Q?NC3ROSpRO1FqlGVnTGT2G+CxBlQUZ/jQoBG9VXBhv92gBt9zJB9gFjhbgzNf?=
 =?us-ascii?Q?fdhXEyKlStYuN2OQ8IlBW7yhKHcPlgIGXqfJB+///b3kpNOcRCCqEsGiCIYb?=
 =?us-ascii?Q?qz4XVXRcp9BPyeoF6NtIBr7pOv23fMJg/TTBD4FJ4yyTVRW8hW5BS8+VfqR+?=
 =?us-ascii?Q?rsSG/KxNklTX7X0LT1Xoe0HDXlVicKU/BadCty6SwagZDeqMqOjy0iHngES/?=
 =?us-ascii?Q?+qQaPShu4vsGTRVuYXW2mAGJOoMSLQJm9Bh6guflZNCfebxbLjVxZjR5SZ5J?=
 =?us-ascii?Q?EE61aJxvEqAN67+xY06b+VXU0sN+AM1U1A1A7OjGYdcns95bf234uc4CWfNp?=
 =?us-ascii?Q?RFBm0VfcNjYnkluvMCUJTe5TOGUTAG88Ot1MIQpR41+QYJvcLLLOsHlT4YEk?=
 =?us-ascii?Q?eIvGPD/I/smLt3D8I7JsPP7YpoaAN8aZfamhtv3qeyiz6B6hXgq5m02ZztT5?=
 =?us-ascii?Q?/1ChjI7L+Of9Yx3Rc862kVyQsCb4B1op822WEk842plmPb50dnzMcWaXWZ5k?=
 =?us-ascii?Q?cPO+kj0pR3gwEoIg8jcsk8VMDwBLUux+tvFIEw0ERPnwjiyR8bkq/Fcfa6/n?=
 =?us-ascii?Q?weKjT9LGnsoLFQkdkFgyA+HydnwAp7Hjpz71pevenMdTMtFzUe5D/9NXwB8o?=
 =?us-ascii?Q?3ekubxaiFPNm9BQes6mytnyvywtMPsiaww5++zj5gCnleCN47reC0Lhl/ucH?=
 =?us-ascii?Q?WJdE5URfQqLtOAeLZI3yqLd22+HqLlspO2yj46kjqXfrJe5V9RMSLAiQmaqh?=
 =?us-ascii?Q?5dDiTusUwJ+nBoAhmidSUIw/8dC5lWaiQlIARo3P7oG3tX/0CNp39l3e6Uus?=
 =?us-ascii?Q?dD40UINbMs9HtCSjg122RXLxGv6K0myvmSwzNC+RYOeSRuVy5cVZDZtLyS3a?=
 =?us-ascii?Q?yTefL3+sirsvcHGHb44IsqsupOqf3MyVxHmiLaJZ6PBdHn2XITNq6lg6LCBf?=
 =?us-ascii?Q?iUrYSOWMQwvk/cKEb25gQlXyqVyHxJEx+KJyThF/4yqxFpmRK9q07sAinQIr?=
 =?us-ascii?Q?8cBBVFhYtR/fKenNhg8Y5CTEDb/E1AC2FayBXJZIuMhd+oK8oxciFAQgwM7W?=
 =?us-ascii?Q?LnnkmsAkQpA+5ZRUeOZf9jvGaLEc+PXtDePb0f6chyFkUQn1YjB8dScn/4+r?=
 =?us-ascii?Q?wgG0VjNYfeUGApQFF3HVOnkVVdrFZSXEFwkAKztAcboD2QMsK9JQJXIxV/Hm?=
 =?us-ascii?Q?gr1Bwgo4w24LGyKlzlsqqGeCcIqzPb4tPjMIwrk3hMOAX8NHLXQPmTXO83zT?=
 =?us-ascii?Q?IIRivEM72Wf2tP5RjVsmVCHFImNDJlrxMxc6OZ8N4qAPTjDFG9uMBIpyFcK3?=
 =?us-ascii?Q?G1tfcqof6ogFSzR/O9xhn2gOvZdaHSNj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVrg0Xeq9hD+OAGB7lwCbI4aXBjSjlMkp+yK26P+SL35LwZTuqtIc4jSDEVI?=
 =?us-ascii?Q?9j0t8SRoGk7Ez6bpjOAhEMbXgwo+k3QDM3ePxe0gNsjuhwgiZSyevVVXU5GH?=
 =?us-ascii?Q?tpjX/QXqN/eZnDHV2LJXbL1H6Ad7h00YFiwEtKR+W1Ko8yl/tvJ0pAo1JDF5?=
 =?us-ascii?Q?wEByz/nAwF53y7vgLrx0jp2nG3e3IwlQ7Zr77ZImY2bTV9ZC9eaLHzrhtPNX?=
 =?us-ascii?Q?L3DUqpcDRDu+iMlTfNL7H51qEYZbGr0jkYOi3UQBntmExc4FHylfVV3y3R49?=
 =?us-ascii?Q?ueMEIU3ilyQmGpMsYzxXPhW4UGS/90/F6fd9oiwUDVbr6NF7nMAZ8TMEEhr6?=
 =?us-ascii?Q?PEz9QtbR79LJe3/oJv83/WHNwhppSIQ3oRUszXEIueOVgoLHQrBbynRYEJ1X?=
 =?us-ascii?Q?aSRzSkqAtZdcy+fiukRYscsZI4S2J77K1LSQwpg+rZndMHDruwP2micocQVa?=
 =?us-ascii?Q?OM/hdZ3ZVNGbuBnwXcg+k6GutRYgZ9XYjFiSLIeVZOdTCMy4uOk/rYjdVRiN?=
 =?us-ascii?Q?6ZyGIckfMujXapjWx3ewYcOH+mull/4kEoTWmxaNjBK4FjeWK2Q2oOV4Ov77?=
 =?us-ascii?Q?A54HhfMMJ78FQQYdTHDdxN+C9fSIHKmoGDbwUNM7b2gmmkrUkT7REPqUK0m5?=
 =?us-ascii?Q?xq1TiAW7dTJmTT/2cHzgByLYVigyEIs4os5vmepKVpY2P0GV1SJ8nkLJRQ7r?=
 =?us-ascii?Q?itYCTSKQBRW6A6EW4HJ6qjGbGFJd8/AJHtFEDsOcrQQ3846PALH22Ud+Gc/O?=
 =?us-ascii?Q?SKE1g7ZAuxAXfmDHJF7/2Z9ExaqW8Dn7VyjkOV0GW6gh7VUeWZyUeKLf1CCR?=
 =?us-ascii?Q?nqjBqvTmRwe4TkvNrSh0AdQk6PA66pCxvUzMGLGiC+LoNvb3iI1Y5aTQOsWV?=
 =?us-ascii?Q?EKwN0KAg6GUGjUXLu/ULu4Ygog84yv/aj7PNfPmX7weblKOi+/8pZzCX3Ejc?=
 =?us-ascii?Q?KVkzBtaV+mWXq3sL2M4VzUkvc4ZEGMGp6dKMTVQnlu1POkwiMAkO6t+kEP09?=
 =?us-ascii?Q?iq/ws+bldSkWGIcjPj3iPT4qEXxfEhmavyHUioKhAsdfNLfCTYZpMJEMbZAM?=
 =?us-ascii?Q?ty+ttofq30784HbKS5ZbcX+JTzWdrEWXXmucVCg7dwFPLwXdX1T4EPjwQmq+?=
 =?us-ascii?Q?O8jtWiguuQXCTiOjGSlRYtxlZUr4GoWU4P8qUEuv+4TP1Ry0dKUzcwKpOTNj?=
 =?us-ascii?Q?M4rv+AgVGx8LpJ9MX69PnXwJKcHqR+vMCZLqu13T6y95I8WPhdTHdhuFYURb?=
 =?us-ascii?Q?CMyKK369RWySuJhWF5lkf+Ji76oNC15itCcDfk15NV2MJXJaDRfbRr7FJbMI?=
 =?us-ascii?Q?jh0YTIMjIY+EKq4Ram5uO8pMJS3bSt4oju90XBoLMWsDntm/09i3vvYZAhQb?=
 =?us-ascii?Q?wrO0Hv+00n1tfkWe0fbG3LkjxKk/QRH/urf6LtGzhmKAi8KL523kJWX4lbKd?=
 =?us-ascii?Q?Jx3ik7cUWIGt9HjwHSCP4vcpGpcWruvZCyRcQphj0Nc8nW/eXF/bFsdlmri5?=
 =?us-ascii?Q?eVNkPojrc1sxojzO9N4f5KdH1XLjycT67/qCmTp/12vM9qhQpBiMLpWeVYr9?=
 =?us-ascii?Q?uJZlthkvrhjrdSbEy9o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7eec24-2df2-4ef3-ba79-08de1baed20c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:31:19.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kky47BsiLciJem8pF8Khk1TigA6hYEYtbyHr7Kag4K50+FCLjBJadDmxSduGRtBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

--KLaIEjiw9rkz0mzR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Few small bug fixes for the rc, nothing particularly major.

Thanks,
Jason

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to b8126205dbe01e22b0d10c8be132bb53bf3399c1:

  MAINTAINERS: Update irdma maintainers (2025-11-02 06:50:35 -0500)

----------------------------------------------------------------
RDMA v6.18 first rc pull request

Following fixes:

- Memory leak in bnxt GSI qp path

- Failure in irdma registering large MRs

- Failure to clean out the right CQ table entry in irdma

- Invalid vf_id in some cases

- Incorrect error unwind in EFA CQ create

- hns doesn't use the optimal cq/qp relationships for it's HW banks

- hns reports the wrong SGE size to userspace for its QPs

- Corruption of the hns work queue entries in some cases

----------------------------------------------------------------
Chengchang Tang (1):
      RDMA/hns: Fix recv CQ and QP cache affinity

Guofeng Yue (1):
      RDMA/hns: Remove an extra blank line

Jacob Moroni (2):
      RDMA/irdma: Fix SD index calculation
      RDMA/irdma: Set irdma_cq cq_num field during CQ create

Jay Bhat (1):
      RDMA/irdma: Fix vf_id size to u16 to avoid overflow

Junxian Huang (1):
      RDMA/hns: Fix wrong WQE data when QP wraps around

Krzysztof Czurylo (1):
      MAINTAINERS: Update irdma maintainers

Shuhao Fu (1):
      RDMA/uverbs: Fix umem release in UVERBS_METHOD_CQ_CREATE

YanLong Dai (1):
      RDMA/bnxt_re: Fix a potential memory leak in destroy_gsi_sqp

wenglianfa (1):
      RDMA/hns: Fix the modification of max_send_sge

 MAINTAINERS                                   |  1 +
 drivers/infiniband/core/uverbs_std_types_cq.c |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 11 ++---
 drivers/infiniband/hw/efa/efa_verbs.c         | 16 ++++----
 drivers/infiniband/hw/hns/hns_roce_cq.c       | 58 +++++++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_device.h   |  4 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 12 ++++--
 drivers/infiniband/hw/hns/hns_roce_main.c     |  4 ++
 drivers/infiniband/hw/hns/hns_roce_qp.c       |  2 -
 drivers/infiniband/hw/irdma/pble.c            |  2 +-
 drivers/infiniband/hw/irdma/type.h            |  2 +-
 drivers/infiniband/hw/irdma/verbs.c           |  1 +
 drivers/infiniband/hw/irdma/verbs.h           |  2 +-
 13 files changed, 87 insertions(+), 29 deletions(-)

--KLaIEjiw9rkz0mzR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaQoONQAKCRCFwuHvBreF
YY1IAQDCKn84u0ZWoNUta+OKggdOISmFfwRh6OeFtT6k4bd/qQEA+uY51LCXBt0G
GdeDowgyjP0R/0fI0kL7J8rMWJRY3Qg=
=J54l
-----END PGP SIGNATURE-----

--KLaIEjiw9rkz0mzR--

