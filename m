Return-Path: <linux-rdma+bounces-4471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE795A482
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0B5283BDF
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F81B530D;
	Wed, 21 Aug 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A121P8Vh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9901B3B1E;
	Wed, 21 Aug 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263882; cv=fail; b=odW/0LZoJVNqbTGb/+YrfOMXrbpmQows4i0xxwi69+EaQCuqHUE44ysJo/Qoh6isSsGngF0YeGClD6OQC6pAuYk3wawUe3YmPsLw/2frr7YOHPcC22KB82TU6jy0AAoZ8T3PdlgFY0655FjlkRnJEv9aoemK+BRRnYInPRkYyAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263882; c=relaxed/simple;
	bh=L1G3aY3SFzQaMWD4/RhS/G3jsSpf47QkdgNgdzKTBHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nL46lq47joaS+bQ+And41l2b+eumOP761XJst0Gi2PcfDngzyIs+PfY4AUqxOsc+Q932lsa4h8F8IiNIwx7BbPUCtvllxazcA9oDB2E8WLt67/CrpLElkZG0KtGMGxLpqm09I56K6Jqif+UrW9x3GW/PSUlhnZHlCkc/A4kq4OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A121P8Vh; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdotGlM/28nTaRgvGxd0lyWHftZkgeAoAtrvBG2wGVgYfNhnsZBYNlEQnteJZ1+WpA72TePD8KNGE87SC2tr0CewFsleFM/XkF8++t6xWh1rsRjiPrtPUgIAZh1CqOnQkeHVWOXpF2lLgvrDcZd5Fz7YoqTfcp6XNPm7fA+WqS65KqSoKIP6NX9gGC3kapwZUuPE3jEcdFqTjCYuCi7t1UGZWHpU3Xkwdydda7SiBdqD+YuqVQnEFKVj6+AXHHrapdCM7cse92T4O8GGa8wrFNzPzfRiOdNZxYoqfkiPQn+FYNgm7s/I0tQcUlmsfIqtrpn9oOkanIJvgVXGGEvnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdLpZJk2bwMP0v6fNqM3lYHDyXfOw0sr/41ozrvhJeU=;
 b=fnfLyGJuN9F0nkzCi8XHOx3CFX3LUoakQn72rlKj1+WTL2uL02q7NCbD/SpQRTaZ6Z/dC6e4uTalBx9Fdzcu9Ud0uahUKzp71qIs3qDojVj8pAsuTYbNRoMCaQmB3OxPsyog0xyrG6nQQNUWVvA/4lPHWfo7HhdUwaJviehimpeGl0pqH2II4YG0oIv77+R9NP9syIR5fOHaex65bX2kWcQer6Weo0nonLikgdM+h1gFqHSqSKyDC/GNET5MKr5fC/KcqCQrULMuoV8pVnN55p61p1+KSwSTPnZjdF/9ECub6RnXDa4Sno3T9rNRx7JQQpqHi6kbuKKuqwHvSEBSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdLpZJk2bwMP0v6fNqM3lYHDyXfOw0sr/41ozrvhJeU=;
 b=A121P8VhQZ7BjZPy/zaE8qBLfsBJ898raUxb2a9eubqPEniEgQYzo7IQNe1a1oKoyJpgyA/8EvOShVHsuqJP/RU8wzD/Vxo7uuNECD5WVfWwap097tBixvCt4vW56HfIJhf6FIYkLbZbxvK1xA8OLtNmTYLgnF32QMT+JuTO1xE8VfoXAvBu2L6IdHzJdMuG+swgCJwGpRMt5/nKi7ouzI77VTfu23hMRjjy6DJFChVo9bi/1SsE7F2PaXTutsv08wqPWYlyO3pNWPNGvZgC89XO+cquoQysH2t/pM7Gl3sSPfZyou76dna1kNa+cYBJeF1+wfPfu/qpEp1VnX6Mrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:09 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:08 +0000
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
Subject: [PATCH v3 09/10] fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands (RFC)
Date: Wed, 21 Aug 2024 15:11:01 -0300
Message-ID: <9-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:408:fb::10) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 15990304-603b-420a-6199-08dcc20c9efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f0Ve92lnhxgtTL97m/uB3DicjAl7EJYDINNGRksh01EE2yrfnO19zUMBpSWj?=
 =?us-ascii?Q?AbNKV9crXlNIqwVrpQTSR6JMmoA0AyRgS3nI6lduZ0NlP5qQEFW5nX4RYffM?=
 =?us-ascii?Q?SicdtzB0K3BNIv4eGrreWRcyH3XGSNOu7hjzYQZxsxV3iIZBIC2v0l4xsMXi?=
 =?us-ascii?Q?9TAPl54NpgSTQPYnQqOFU4NjMf0X46CKC1n/hOM2PzcGiNTIW8wJdlkYSMJY?=
 =?us-ascii?Q?0aat8aYjxZ3OOSGjGTgezwEdpe7QOCZP1uNAQBialzj+Kh4ZVKo+2efKG6uM?=
 =?us-ascii?Q?l3sZqzVf2v7CAfOEaOux+zw1X7w/btthIIFYbb1uo+Ewscrapm858jlPR048?=
 =?us-ascii?Q?oQU5PZzvDiZQD3m8c0LZjrTefucyysKZ6NnkBmk/gNh2a3fs7LIVNeyYogPz?=
 =?us-ascii?Q?eA3Me+XClhMyBRJmDeZkVYF0TVDiORqVWh8icDm8+D0dk6Nxal8xWT66t9Iw?=
 =?us-ascii?Q?6P/vGlHEtDfzSRWxj7zYhLCgNDEIm2AqtD4IUoewNX8c/7Jt1w+3bAlZfHkp?=
 =?us-ascii?Q?ECzzcG5RPxDHhIUGgk1Q8wVLo4f5ktm9jnu3DZPckyi2lWEQUEunN0wfK+RQ?=
 =?us-ascii?Q?8VOy9bm/CeJGTkxLN4J7oOtuq0fAj1P0koujdox3KlCbPnuJz+lpzevBmXlW?=
 =?us-ascii?Q?bmJtPUlgc9hUQPcL7LLN11HtkO0BXQ0YXG3vCiGM2lCJRlQC0tMS6CvQ46a5?=
 =?us-ascii?Q?6bTerfPqOPsVOgV0GBrWDIynYLY8kA94uORggMJQMe8aU3vkdnvsZ6h5/Qxa?=
 =?us-ascii?Q?uPyR3sqn2lU8RuNI6lNuAqXdEHfQt75LCTOpKLiTYFjTCAJxboIDIOsBTZcO?=
 =?us-ascii?Q?dsWJ6ErMZg/mh6U1Sh2lCHd/feEVQWtvOVyWkc7KSLlOsFpofqQWAYGDz5qT?=
 =?us-ascii?Q?QJB8dkvGiK3JLtvq8kgPNF/CPY+eoM0J7KOIdB8vi4ZROqRnRXbd3lf7232v?=
 =?us-ascii?Q?Q/LYrQ/VdH5tnjCyEpHCGcPKMuGvGUY2cmbtiSKcrG1E4t4FqFinN7ubyzA+?=
 =?us-ascii?Q?/wH/aL6Gezee7Qn0vdxvljjfjoVDf9OciPBQrrTC8FsWaegjT2/0TLV47IlY?=
 =?us-ascii?Q?IuwCd1BcXExNKD0nHxfdmpeT1dTp8AsZDYTF9e3f4+rwHpWUBD/cbVXyDTUi?=
 =?us-ascii?Q?wK3bG0qDglA1MfHZDs+EJTKMgfChlQ0rybCQcsvPijPjLfGiUHZKsio31hBn?=
 =?us-ascii?Q?8mPGIHGvuNPVi2SWuGK3m9K9fVQgapbdm1eHasLGm6g8Ess/6MiEN4pQ/GKx?=
 =?us-ascii?Q?RYxBXr3BrHbUTNdJeae+qOGC9OzHJ5H6CzLdfIfPCf5iG4pcs5FtvzCPZ16q?=
 =?us-ascii?Q?NdkVbLx7viByXDLZxDuW0rJhTBXybD5UVsbRsMpCUaw9Gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLWsmnclC+ybcx4mUGPPbUrdSN20IW3DdpOhCjpTkAx4a98whUmkq4EsZiPW?=
 =?us-ascii?Q?b38SrJT1YYEJtZ7gPJx4c9XEHGG21k+iR2tsottwf7GhKE4BgAeyGq9QvFhH?=
 =?us-ascii?Q?aUC9Tg+jJYUwlp0rsOCViYxt3Nn4dJBUjm7vl95JJqvpj05oI1nuHImaEbBj?=
 =?us-ascii?Q?5LRDZaTK3+DzSvAq0L2TQOjG+3P0LOaxhl3INJ5LVaqkf+oVpdmDTY4LN/+V?=
 =?us-ascii?Q?LARkodYhWHasqNEsrkYuZnOhGpdKE6p+RYkmT0Rm5rurZv1nqVd32UkEwUkt?=
 =?us-ascii?Q?9FbTdD3hxGhU27CzkAUWZElbeAxMUOUpVX+oob+vzlfvLuXEIt91QXMMTYz1?=
 =?us-ascii?Q?t5sx99DKsz1jNLdhntJyA8eByqt7l+jzdylzLGWXoGya8ezRk/s8vH1nJiYH?=
 =?us-ascii?Q?aQUl0uWfkThXwCEtV6HclmnuU7ZRwGLzilG7EwBQPqWN0z2E+SioKLoAaDDi?=
 =?us-ascii?Q?XRi7mCmCYb4RR+noFdj3wQvXawPwvQXTq1tYz1pjkz0YOI34O1vmib0tm00p?=
 =?us-ascii?Q?V9DmK0twg3MRY2a7ZAuDgL+RZmEwa5iXhcW/sOoXux8pOKEYVY6/dK5Xlf7V?=
 =?us-ascii?Q?UwoanmIa3kv8V8Xkbsr77tSRL5vvW2T2pFxh35+jXmRZL37igmeOn4bZsVSF?=
 =?us-ascii?Q?blPESjAUD+GIgznYsWqJ/IEeMox0PmL2z6fk+DepWxtHqf6Y98sKYGHi3ZA7?=
 =?us-ascii?Q?PEhDClsQVnbunDrao7z+lGwb3QTeba6G8gYs1dTlwGCo+Cn6DIfvFcvw0EZV?=
 =?us-ascii?Q?WgaUglUKlxlIywdx5f36hMHewiYOLNKY1Oz9G2jl4IvIbke7E6qJcvxGsvOd?=
 =?us-ascii?Q?bBBQUHWgqojPnw0zCWcKQcK7Jh10NJpwEe4p4fOvR85qL2sGyttvMkh7gD31?=
 =?us-ascii?Q?jZFtcBiZDbpaut9E0osTyKVSRMMaW4fc9UDwvXWpOrpWTlQIZDO5JxQ32ai1?=
 =?us-ascii?Q?DrA5Qye/dVnQjzPVZ+eDGWpm8FhIgETq3+5L8CkoedBQzTaUZfAQbKHIoyr1?=
 =?us-ascii?Q?DJWTtjjX0v/he+cMjzx34s+D9pMM4InZrVMDeXiqOS1TaDY2v+RXa8MJKg7g?=
 =?us-ascii?Q?Aiac02nVJohU1S+3QBCmGBpBt/fS6RrY1kwopBDjACQQ61J9r45coJYAKy68?=
 =?us-ascii?Q?N5AkR7Fet5LZfLqJ9QRdogMUkqbod8deXj1waO4E+sRfgrI4pC90PlCVvbyS?=
 =?us-ascii?Q?JeiGs3aP9a/uteoOgAjHB3VirJAHULuJLbd08660GiJW4ud52A4LoDTyWNL+?=
 =?us-ascii?Q?bLGOu/sXeQiMqr/4JEqeBotkMcj+tOEupx3eU5m2moi77V8jVuj2hyATpipR?=
 =?us-ascii?Q?M8OMG7jnm4/9CB6Gn5GFE+/0r8sh36rEQa0/Yq7F2Vq2bOOWuUHORU+hN+Cu?=
 =?us-ascii?Q?+Tlo7MQF7Fhs8CWS8ozzFyMHW44iaLaxKk2fUR5aVT24WTzO8GRVtniZxAQ4?=
 =?us-ascii?Q?5w1xf3gXL1ZzoOeSgKnR7PJN7ciig3dHFX4ZKs0b+OaZYyGU9HO4OZ3wzpDm?=
 =?us-ascii?Q?JBSahFP/ROp7r7RM12xvZlPaU6OcXR8JUeWadh8LB4E81OrA/zIEf6Bn1i9u?=
 =?us-ascii?Q?RPm+8sSNvONleIpkrRsYRp2x3FUrI0CdjUWvw4A4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15990304-603b-420a-6199-08dcc20c9efd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:04.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxbTS1GkfO98pSnqxtttc/wO0fyx8np2OUZ3tGkKepSuL5PiAbQkSPzCtHWjEOS4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

From: Dave Jiang <dave.jiang@intel.com>

Add an fwctl (auxiliary bus) driver to allow sending of CXL feature
commands from userspace through as ioctls. Create a driver skeleton for
initial setup.

FWCTL_INFO will return the commands supported by the fwctl char device as
a bitmap of enable commands.

fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls to
a device.

FWCTL_RPC will start by supporting the CXL feature commands: Get Supported
Features, Get Feature, and Set Feature.

FWCTL_RPC provides 'enum fwctl_rpc_scope' parameter where it indicates the
security scope of the call. The Get Supported Features and Get Feature
calls can be executed with the scope of FWCTL_RPC_DEBUG_READ_ONLY. The Set
Feature call is gated by the effects of the feature reported by Get
Supported Features call for the specific feature.

Add a software command through FWCTL_RPC in order for the user to retrieve
information about the commands that are supported. In this instance only 3
commands are supported: Get Supported Features, Get Feature, and Set
Feature.

The expected flow of operation is to send the call first with 0 set to the
n_commands parameter to indicate query of total commands available. And
then a second call provides the number of commands to retrieve with the
appropriate amount of memory allocated to store information about the
commands.

Link: https://patch.msgid.link/r/20240718213446.1750135-9-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS                 |   7 +
 drivers/fwctl/Kconfig       |   9 ++
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/cxl/Makefile  |   4 +
 drivers/fwctl/cxl/cxl.c     | 274 ++++++++++++++++++++++++++++++++++++
 include/linux/cxl/mailbox.h | 104 ++++++++++++++
 include/uapi/fwctl/cxl.h    |  94 +++++++++++++
 include/uapi/fwctl/fwctl.h  |   1 +
 8 files changed, 494 insertions(+)
 create mode 100644 drivers/fwctl/cxl/Makefile
 create mode 100644 drivers/fwctl/cxl/cxl.c
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d7d12adc521be1..9933c67303f0ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9257,6 +9257,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/fwctl/mlx5/
 
+FWCTL CXL DRIVER
+M:	Dave Jiang <dave.jiang@intel.com>
+R:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/cxl/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index e5ee2d46d43126..e49903a9d0d34f 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -19,5 +19,14 @@ config FWCTL_MLX5
 	  This will allow configuration and debug tools to work out of the box on
 	  mainstream kernel.
 
+	  If you don't know what to do here, say N.
+
+config FWCTL_CXL
+	tristate "CXL fwctl driver"
+	depends on CXL_BUS
+	help
+	  CXLCTL provides interface for the user process to access user allowed
+	  mailbox commands for CXL device.
+
 	  If you don't know what to do here, say N.
 endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 1c535f694d7fe4..bd356e6f2e5af1 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
 obj-$(CONFIG_FWCTL_MLX5) += mlx5/
+obj-$(CONFIG_FWCTL_CXL) += cxl/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/cxl/Makefile b/drivers/fwctl/cxl/Makefile
new file mode 100644
index 00000000000000..62319452157272
--- /dev/null
+++ b/drivers/fwctl/cxl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_CXL) += cxl_fwctl.o
+
+cxl_fwctl-y += cxl.o
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
new file mode 100644
index 00000000000000..8836a806763f54
--- /dev/null
+++ b/drivers/fwctl/cxl/cxl.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Intel Corporation
+ */
+#include <linux/fwctl.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/cxl/mailbox.h>
+#include <linux/auxiliary_bus.h>
+#include <uapi/fwctl/cxl.h>
+
+struct cxlctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+	u32 uctx_uid;
+};
+
+struct cxlctl_dev {
+	struct fwctl_device fwctl;
+	struct cxl_mailbox *mbox;
+};
+
+DEFINE_FREE(cxlctl, struct cxlctl_dev *, if (_T) fwctl_put(&_T->fwctl))
+
+static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct cxlctl_uctx *cxlctl_uctx =
+		container_of(uctx, struct cxlctl_uctx, uctx);
+
+	cxlctl_uctx->uctx_caps = BIT(FWCTL_CXL_QUERY_COMMANDS) |
+				 BIT(FWCTL_CXL_SEND_COMMAND);
+
+	return 0;
+}
+
+static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
+{
+}
+
+static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct cxlctl_uctx *cxlctl_uctx =
+		container_of(uctx, struct cxlctl_uctx, uctx);
+	struct fwctl_info_cxl *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uctx_caps = cxlctl_uctx->uctx_caps;
+
+	return info;
+}
+
+static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
+					 const struct fwctl_cxl_command *send_cmd,
+					 enum fwctl_rpc_scope scope)
+{
+	struct cxl_feat_entry *feat;
+	bool found = false;
+	uuid_t uuid;
+	u16 mask;
+
+	if (send_cmd->in.size < sizeof(struct set_feature_input))
+		return false;
+
+	if (copy_from_user(&uuid, u64_to_user_ptr(send_cmd->in.payload),
+			   sizeof(uuid)))
+		return false;
+
+	for (int i = 0; i < cxl_mbox->num_features; i++) {
+		feat = &cxl_mbox->entries[i];
+		if (uuid_equal(&uuid, &feat->uuid)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return false;
+
+	/* Currently no user background command support */
+	if (feat->effects & CXL_CMD_BACKGROUND)
+		return false;
+
+	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
+	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
+	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
+	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
+	if (feat->effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE)
+		return true;
+
+	/* These effects supported for all scope */
+	if ((feat->effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
+	     feat->effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET) &&
+	    scope >= FWCTL_RPC_DEBUG_READ_ONLY)
+		return true;
+
+	return false;
+}
+
+static bool cxlctl_validate_hw_cmds(struct cxl_mailbox *cxl_mbox,
+				    const struct fwctl_cxl_command *send_cmd,
+				    enum fwctl_rpc_scope scope)
+{
+	struct cxl_mem_command *cmd;
+
+	/*
+	 * Only supporting feature commands.
+	 */
+	if (!cxl_mbox->num_features)
+		return false;
+
+	cmd = cxl_get_mem_command(send_cmd->id);
+	if (!cmd)
+		return false;
+
+	if (test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
+		return false;
+
+	if (test_bit(cmd->info.id, cxl_mbox->exclusive_cmds))
+		return false;
+
+	switch (cmd->opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
+		if (scope >= FWCTL_RPC_DEBUG_READ_ONLY)
+			return true;
+		break;
+	case CXL_MBOX_OP_SET_FEATURE:
+		return cxlctl_validate_set_features(cxl_mbox, send_cmd, scope);
+	default:
+		return false;
+	};
+
+	return false;
+}
+
+static bool cxlctl_validate_query_commands(struct fwctl_rpc_cxl *rpc_in)
+{
+	int cmds;
+
+	if (rpc_in->payload_size < sizeof(rpc_in->query))
+		return false;
+
+	cmds = rpc_in->query.n_commands;
+	if (cmds) {
+		int cmds_size = rpc_in->payload_size - sizeof(rpc_in->query);
+
+		if (cmds != cmds_size / sizeof(struct cxl_command_info))
+			return false;
+	}
+
+	return true;
+}
+
+static bool cxlctl_validate_rpc(struct fwctl_uctx *uctx,
+				struct fwctl_rpc_cxl *rpc_in,
+				enum fwctl_rpc_scope scope)
+{
+	struct cxlctl_dev *cxlctl =
+		container_of(uctx->fwctl, struct cxlctl_dev, fwctl);
+
+	switch (rpc_in->rpc_cmd) {
+	case FWCTL_CXL_QUERY_COMMANDS:
+		return cxlctl_validate_query_commands(rpc_in);
+
+	case FWCTL_CXL_SEND_COMMAND:
+		return cxlctl_validate_hw_cmds(cxlctl->mbox,
+					       &rpc_in->send_cmd, scope);
+
+	default:
+		return false;
+	}
+}
+
+static void *send_cxl_command(struct cxl_mailbox *cxl_mbox,
+			      struct fwctl_cxl_command *send_cmd,
+			      size_t *out_len)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	rc = cxl_fwctl_send_cmd(cxl_mbox, send_cmd, &mbox_cmd, out_len);
+	if (rc)
+		return ERR_PTR(rc);
+
+	*out_len = mbox_cmd.size_out;
+
+	return mbox_cmd.payload_out;
+}
+
+static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			   void *in, size_t in_len, size_t *out_len)
+{
+	struct cxlctl_dev *cxlctl =
+		container_of(uctx->fwctl, struct cxlctl_dev, fwctl);
+	struct cxl_mailbox *cxl_mbox = cxlctl->mbox;
+	struct fwctl_rpc_cxl *rpc_in = in;
+
+	if (!cxlctl_validate_rpc(uctx, rpc_in, scope))
+		return ERR_PTR(-EPERM);
+
+	switch (rpc_in->rpc_cmd) {
+	case FWCTL_CXL_QUERY_COMMANDS:
+		return cxl_query_cmd_from_fwctl(cxl_mbox, &rpc_in->query,
+						out_len);
+
+	case FWCTL_CXL_SEND_COMMAND:
+		return send_cxl_command(cxl_mbox, &rpc_in->send_cmd, out_len);
+
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
+static const struct fwctl_ops cxlctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_CXL,
+	.uctx_size = sizeof(struct cxlctl_uctx),
+	.open_uctx = cxlctl_open_uctx,
+	.close_uctx = cxlctl_close_uctx,
+	.info = cxlctl_info,
+	.fw_rpc = cxlctl_fw_rpc,
+};
+
+static int cxlctl_probe(struct auxiliary_device *adev,
+			const struct auxiliary_device_id *id)
+{
+	struct cxl_mailbox *mbox = container_of(adev, struct cxl_mailbox, adev);
+	struct cxlctl_dev *cxlctl __free(cxlctl) =
+		fwctl_alloc_device(mbox->host, &cxlctl_ops,
+				   struct cxlctl_dev, fwctl);
+	int rc;
+
+	if (!cxlctl)
+		return -ENOMEM;
+
+	cxlctl->mbox = mbox;
+
+	rc = fwctl_register(&cxlctl->fwctl);
+	if (rc)
+		return rc;
+
+	auxiliary_set_drvdata(adev, no_free_ptr(cxlctl));
+
+	return 0;
+}
+
+static void cxlctl_remove(struct auxiliary_device *adev)
+{
+	struct cxlctl_dev *ctldev __free(cxlctl) = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&ctldev->fwctl);
+}
+
+static const struct auxiliary_device_id cxlctl_id_table[] = {
+	{ .name = "CXL.fwctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, cxlctl_id_table);
+
+static struct auxiliary_driver cxlctl_driver = {
+	.name = "cxl_fwctl",
+	.probe = cxlctl_probe,
+	.remove = cxlctl_remove,
+	.id_table = cxlctl_id_table,
+};
+
+module_auxiliary_driver(cxlctl_driver);
+
+MODULE_IMPORT_NS(CXL);
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("CXL fwctl driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
index 570864239b8f14..13b5bb6e5bc310 100644
--- a/include/linux/cxl/mailbox.h
+++ b/include/linux/cxl/mailbox.h
@@ -4,6 +4,7 @@
 #define __CXL_MBOX_H__
 
 #include <uapi/linux/cxl_mem.h>
+#include <uapi/fwctl/cxl.h>
 #include <linux/auxiliary_bus.h>
 
 /**
@@ -68,4 +69,107 @@ struct cxl_mailbox {
 	struct cxl_feat_entry *entries;
 };
 
+enum cxl_opcode {
+	CXL_MBOX_OP_INVALID		= 0x0000,
+	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
+	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
+	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
+	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
+	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
+	CXL_MBOX_OP_GET_TIMESTAMP	= 0x0300,
+	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
+	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
+	CXL_MBOX_OP_GET_LOG		= 0x0401,
+	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
+	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
+	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
+	CXL_MBOX_OP_IDENTIFY		= 0x4000,
+	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
+	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
+	CXL_MBOX_OP_GET_LSA		= 0x4102,
+	CXL_MBOX_OP_SET_LSA		= 0x4103,
+	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
+	CXL_MBOX_OP_GET_ALERT_CONFIG	= 0x4201,
+	CXL_MBOX_OP_SET_ALERT_CONFIG	= 0x4202,
+	CXL_MBOX_OP_GET_SHUTDOWN_STATE	= 0x4203,
+	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
+	CXL_MBOX_OP_GET_POISON		= 0x4300,
+	CXL_MBOX_OP_INJECT_POISON	= 0x4301,
+	CXL_MBOX_OP_CLEAR_POISON	= 0x4302,
+	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
+	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
+	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_SANITIZE		= 0x4400,
+	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
+	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
+	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
+	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
+	CXL_MBOX_OP_UNLOCK		= 0x4503,
+	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
+	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_MAX			= 0x10000
+};
+
+#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
+#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
+#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
+#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
+#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
+#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
+#define CXL_CMD_BACKGROUND			BIT(6)
+#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
+#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	(BIT(9) | BIT(10))
+#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		(BIT(9) | BIT(11))
+
+struct cxl_feat_entry {
+	uuid_t uuid;
+	__le16 id;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 flags;
+	u8 get_feat_ver;
+	u8 set_feat_ver;
+	__le16 effects;
+	u8 reserved[18];
+} __packed;
+
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ * @flags: Set of flags effecting driver behavior.
+ *
+ *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with this flag
+ *    will be enabled by the driver regardless of what hardware may have
+ *    advertised.
+ *
+ * The cxl_mem_command is the driver's internal representation of commands that
+ * are supported by the driver. Some of these commands may not be supported by
+ * the hardware. The driver will use @info to validate the fields passed in by
+ * the user then submit the @opcode to the hardware.
+ *
+ * See struct cxl_command_info.
+ */
+struct cxl_mem_command {
+	struct cxl_command_info info;
+	enum cxl_opcode opcode;
+	u32 flags;
+#define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
+};
+
+struct cxl_mem_command *cxl_get_mem_command(u32 id);
+int cxl_fwctl_send_cmd(struct cxl_mailbox *cxl_mbox,
+		       struct fwctl_cxl_command *fwctl_cmd,
+		       struct cxl_mbox_cmd *mbox_cmd,
+		       size_t *out_len);
+void *cxl_query_cmd_from_fwctl(struct cxl_mailbox *cxl_mbox,
+			       struct cxl_mem_query_commands *q,
+			       size_t *out_len);
+
 #endif
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
new file mode 100644
index 00000000000000..a3a96195f6da4c
--- /dev/null
+++ b/include/uapi/fwctl/cxl.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024, Intel Corporation
+ *
+ * These are definitions for the mailbox command interface of CXL subsystem.
+ */
+#ifndef _UAPI_FWCTL_CXL_H_
+#define _UAPI_FWCTL_CXL_H_
+
+#include <linux/types.h>
+
+enum fwctl_cxl_commands {
+	FWCTL_CXL_QUERY_COMMANDS = 0,
+	FWCTL_CXL_SEND_COMMAND,
+};
+
+/**
+ * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
+ * @uctx_caps: The command capabilities driver accepts.
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_cxl {
+	__u32 uctx_caps;
+};
+
+/*
+ * CXL spec r3.1 Table 8-101 Set Feature Input Payload
+ */
+struct set_feature_input {
+	__u8 uuid[16];
+	__u32 flags;
+	__u16 offset;
+	__u8 version;
+	__u8 reserved[9];
+	__u8 data[];
+} __packed;
+
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @raw: Special fields for raw commands
+ * @raw.opcode: Opcode passed to hardware when using the RAW command.
+ * @raw.rsvd: Must be zero.
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @in: Parameters associated with input payload.
+ * @in.size: Size of the payload to provide to the device (input).
+ * @in.rsvd: Must be zero.
+ * @in.payload: Pointer to memory for payload input, payload is little endian.
+ *
+ * Output payload is defined with 'struct fwctl_rpc' and is the hardware output
+ */
+struct fwctl_cxl_command {
+	__u32 id;
+	__u32 flags;
+	union {
+		struct {
+			__u16 opcode;
+			__u16 rsvd;
+		} raw;
+		__u32 rsvd;
+	};
+
+	struct {
+		__u32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} in;
+};
+
+/**
+ * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input
+ */
+struct fwctl_rpc_cxl {
+	__u32 rpc_cmd;
+	__u32 payload_size;
+	__u32 version;
+	__u32 rsvd;
+	union {
+		struct cxl_mem_query_commands query;
+		struct fwctl_cxl_command send_cmd;
+	};
+};
+
+struct fwctl_rpc_cxl_out {
+	__u32 retval;
+	__u32 rsvd;
+	__u8 payload[];
+};
+
+#endif
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index f9b27fb5c1618c..4e4d30104667c7 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -43,6 +43,7 @@ enum {
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
+	FWCTL_DEVICE_TYPE_CXL = 2,
 };
 
 /**
-- 
2.46.0


