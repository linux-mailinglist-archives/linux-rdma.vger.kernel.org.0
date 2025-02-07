Return-Path: <linux-rdma+bounces-7490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31AA2B6FE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EF618894CC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84B944E;
	Fri,  7 Feb 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8zQRaT9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967128FF;
	Fri,  7 Feb 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887226; cv=fail; b=mJTNZKxw0xs1rBPG4ECzlM16aKQVkj5wBhbce5pTMPidafOHnJ2sUs8zXV89gQa4BakjXDnwXtGhi0xctKAXKinU1rooy6zaxDNQ7O/YgStvaxT6UscOhvgqo6Tp3KuclQ3p+bpe4hiwWhE6ZlgnWUWAgsya088aGG0iTuFv84o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887226; c=relaxed/simple;
	bh=/bIQ9JCNzRm5c185xpE49RjExwCYcWIHYuD2iNmcN8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/M/LvWcC8xlaBf2xavVifKGt3CTnANiKD3DjuxD1AdTS3QrA/yP+ICppHJMuKdvpyEv1P/mSsEJj/wZONc43UF06wdDs4txW7tu5PMAw9qnuN9Ibz+muJfr2n0PGcN0qNZjxKq9ZYEYyGm7zk0ubhB0cvkWUOOaZyU+hEqFaAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8zQRaT9; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQQ1hCQaP9YIS+MoimGr9A3j+eTRrviGOx4keNfUsVrS4B0HzVQm01ulG8QJA78u7vsICRIQKu7KbpTF8IBR2xbZNSlsW0CqxuxnASNpxus/IqMsggwIZP+PzwREbTbaKwYtLj98/7VXEuHXIOB2afwk5qPkQoLB/DWYMKrDOIAYTvWhlA2ndho9IVDGQV/nGRrOYgK5/0YA0nJYszXqsjnTHhN5bzPPfiH6nTuIuFybm8IVIpUeOZOitz9KjIjqEKxI7ha/26rwAticnlkgndJi34MHQj7uJLsr7DjwR/VkF+KQUSd+7FLPviFmYWBggvM6QCFczM00PZrik0YGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exWw1AGLH6g/QggMnI/SJaD276Y8ZCBmxZ7/J3ow7Ms=;
 b=n7fdFJbgajZOnRSQJam1HBDEbf93wmuqzXgAMd5A9iiQNbvUFJSUvx9r7C5SKj8tWbpQv/AMt+ecHdbA8k4IddUD6srqHOtp637oIGLHRDsE4IkczJAyv8xQ6r8mkvZpPiIejsE4t9X0bsQ8NqjY+5IDqHbYnN5gmgo9dDQbWoRKMT/xVPo0h8vMafdzRDBU9PrYN6GF3IJd5khmC1B7a0aBGYT1qTMEhrWN1lvmJZp1M+Ss2EExGyiaHhBY1t1pJfi644WDWhopCLqSu96i+/Fw6B1/qLuwVJSECsuQqoRswuLT7UrgHq38KcyM+H0+fmtFH4LxLX3c6h/HfSvmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exWw1AGLH6g/QggMnI/SJaD276Y8ZCBmxZ7/J3ow7Ms=;
 b=V8zQRaT9PTGmi+MnUIxIr6ZAujzSI054WWAD1zE2JMAFEZno7HplMjBROmbVHKAL48G9A4MoB5ULkWrKa0F+uMUUlb5Bks/A+rX0LmKM2CnXQmS9cmLVjzqqHCg6dYkxjhIm9UOiajlv675iqI5sIOWB3iSUCHzDNkA1Gw2dt9f4Ja2+5R1RZpLzLF5+dobdmGF0om2e4E3TIvjSFjjdoImlGRnNMR0FKQ8QIMVmBOgBcX/b/rk2vpYx8L1ZLEYJIEUjvJE7iqkyyuwTm+kkWHrqxddNZLPFCBRfLQXXWts9/OYfyDKFj2McBFRXNNDq0ZTb3NUgiknV4znz6La3eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v4 09/10] fwctl/bnxt: Support communicating with bnxt fw
Date: Thu,  6 Feb 2025 20:13:31 -0400
Message-ID: <9-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:408:e4::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 107eaeb6-86bf-4b57-72e0-08dd470c42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?32qvCs7+DjqIrH0SBHDsSF2QjoLCEnF1364i0go5V/2HbyBgpirNAs+qokRJ?=
 =?us-ascii?Q?TyT3makMPG6fRaMoLAdKq3NlFH8qFvW8jp958qwGLrmzdy8odGT+X0DaQvJ8?=
 =?us-ascii?Q?5WRraM2rygWTlu988pUAFSXDuITaK7/qwCFG8gy5NHz4sVhurS5OSac9KdcV?=
 =?us-ascii?Q?Vo2c8EzPiGT32OKYvny/jlgCK5aqG8H5u2py+qRKqVu3ugBI1cZoaEJU+46J?=
 =?us-ascii?Q?Tsb/q6clJ2i+GRddxHY76ucVhY3VpUahyrP6qWv8XnZc+eq2K9eaoSkgvXRx?=
 =?us-ascii?Q?UTfBZJy6Mt9bmKJ8EMsaG8Rz0zlPlIES0bpJQjqPic5O0Zonf42duJqLRwvW?=
 =?us-ascii?Q?yl1gyq7D49Cqpn17q4sOv5NoeNf003P986LMPQa78YWAEBeO81/IjOQebztp?=
 =?us-ascii?Q?TjWDltQVJuGGYrLBrCQ9dbdcNi8jP6yMf5UDmEammyRyWldiiLlS8OPkeJKt?=
 =?us-ascii?Q?I5fz1X9hOMe4XxqNTd6qYj80jyc50ZK5wyekEhott2Y6S11nAbt94DvJPB/P?=
 =?us-ascii?Q?j7fgOwQ0kjksIl5gvjsq+DUgOpaO0Q7ZKMlbUHjC8GE8JtNmJ5+aXq2+kedG?=
 =?us-ascii?Q?cx9Vdo9Faoge08+mVecDyFvY4zucPWCAUuB0eeGJhYtS55RzqWnp02GwlVaC?=
 =?us-ascii?Q?Efxqx2FBv/bzJg2kJza97YVul02OMQ1WHTAbfMTKztnAIDiec7E8ZzhUGBXW?=
 =?us-ascii?Q?vu1MMxIoX4UwwoihhIxbdLjT1uXxTw8CwHnUsp7o3eZlazgTHpm7gDtGtdBM?=
 =?us-ascii?Q?Cd2RC/kwaSduJxc1nc3XaZQfIW0Cm03TSZpWmu4tcf3WfseAADdyIRYZD9P/?=
 =?us-ascii?Q?PYHBxp1iwxSMQswWJjE1FGW5FKxTTkLs1Vj5qodDZQrMrOKhVIG+NW46Y9he?=
 =?us-ascii?Q?tk5sT+1mCvlSLtp7nyvx/zcRlHpUefXnhdixFgeynXC/iAVgXgNNRHC6VqsL?=
 =?us-ascii?Q?m4hXgYmyTie8xve6D+HIRFmvQNKXWc0cvj2t48/Omh5uvnNQqzvx18efBAKE?=
 =?us-ascii?Q?Uu/c16s2AT17ZhSZEQHSd+1qjuUoZCPhlX+G6hvXx6QBieNqFfRODS4TvESK?=
 =?us-ascii?Q?kAHJISi2aob/cGEKe00ec+nCF/ndg97Obje75gORlFx1JydwM9RLvdJSTZTv?=
 =?us-ascii?Q?0KAFxk8cxC4y+p38P4jQUqxVWbKWqucooYXWyB/ZggoEaX+p9x01HD/Mt11K?=
 =?us-ascii?Q?5mtHyYSrqmfQdu4boClOHMxvnZRiVtfnprb53HBBWw0XlvBi2Icq2jFuAURB?=
 =?us-ascii?Q?KYoJgT90Qij1Tg92TBnkw5FzmYaxiotvc+xO3ogaNwxNfLA4k1HDX58RSKET?=
 =?us-ascii?Q?QvBjrMOleR6dKS37PtRkvbZphTYk5RyuUPJ1kByngqLQzf5IDDKhZ1VSUsts?=
 =?us-ascii?Q?5swzOAvjFbJFw36fW+Lbp+YhkUWz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MXhOj8zQQyLqg3rh+92OuZMrE42iz0j5a/xQ+XaRTQi0V74Jheu/H62VITRE?=
 =?us-ascii?Q?o9Ptru5cqfDvk6Ngvl9nc4mU+xgSzuTDd2LcLw+IGuw0o/u6Fhtl+0pIgYDq?=
 =?us-ascii?Q?Uyh11JEjq/3SI8TWncpCBE0Bc9EZZRq3iUoFQOG8ucga12ccugy/JyH9eUaH?=
 =?us-ascii?Q?NvXjOOAIsDaPgqk81moxyojykDnbfYvqS/SbiTqXfkHVv3xF+EwiWL/52+qe?=
 =?us-ascii?Q?SHei9JGEjf69bf4h4qOz6SzsEbP1n+ny3L3wy0weJl1s+dynzBsPahAgLZ1C?=
 =?us-ascii?Q?iy6SEyizg8UkriXk5qBT7VudhFMyuKmBOAm1PvNsPcxp96cN2/9fPklN9F7H?=
 =?us-ascii?Q?t8yUHWHxngr30EJ0EEn+8uHunSrIUc3umXN8V3u777w9Jl/5hdhjGkwL9gqc?=
 =?us-ascii?Q?dN8qW9L/ZATvmLjL0fqRhfcmX48nE+H4gubVfHBbpNqdDV7BX8YqbuFpKsMs?=
 =?us-ascii?Q?ryn6CMfreRb+HfV8+1d0LA9nRD7+YdWAMlam9tjbmMtQj9Gu3cjoC/r3IF/t?=
 =?us-ascii?Q?sNsSJuDWGwmzKFGE2ry/Q5LqKIfW2pm5Tyh1MyhUSKuCulfbB++A9lN31yaD?=
 =?us-ascii?Q?6Zp2qlDUBJlAJjiE3Tb5SyTGDDCk69SsHCvOsiyOk20yWahAfax6HCn4vnDg?=
 =?us-ascii?Q?MmdDv8J20MK3eLRu1r6b60OOWeYU0qKtQ8gXb3+eAV6DPKPZYisVkdrmfJU4?=
 =?us-ascii?Q?S4hhiIoQ0pIoYWGBPA+ThhsO/XeFrzzSir0r98GlgOGk69DhrixbbCupLwCo?=
 =?us-ascii?Q?EY2tjoOpt1zPzyFqnmwwG4hSR4FU9cpwxCD16Ip/zgB8hEsfr9c/XrEFBQmy?=
 =?us-ascii?Q?je0u728kA25qKaEWGOvklEE1k7yaF4v+fJXJwrQ2WjzWsdHP6tauRNRKSMiz?=
 =?us-ascii?Q?9U9noEySbVBtMxRKZQq1wsWlUhP8s/VU5CPgkrkb6huTMbD9xpMU7DFrdBso?=
 =?us-ascii?Q?m1uabD8OUcJTE2LyKfTbjZbOkkwPAj079XemBZzjjY2GyMJUYT0Jh4SLUFK4?=
 =?us-ascii?Q?Cq2hzG2R9VLFYHRMO+niyK3APAD3kBCOZSLfmRA8soAr57sZZDLMTHbPK+pQ?=
 =?us-ascii?Q?JEhXfqTKyO4doEvury2OFwQTUKt0Xt5i+0R49HIrPbBpqYvHSMgXW0fHy5ji?=
 =?us-ascii?Q?prex2JastL5aXB3xQ3NUuOkt6Ed/MRVs2irHdzf+IgtQXDEQVxqeyXsm87QW?=
 =?us-ascii?Q?ikbFkUTvZDFvT8f26spnnxwKlK/BOqdPljDlKsUVLM8DbxgX5jIdQL1LUf4W?=
 =?us-ascii?Q?T1+4GmvtJuUtLwYqc0Gyj+hSQehuWjCweCKtv0dj8lHkvuc6PWUu2Hf2+1ph?=
 =?us-ascii?Q?pnnTO7ZmlB+syMsux+1Hvm5+uHnFUsAB5Z2riLhuJ0OTnncKi13A8qj1eDQV?=
 =?us-ascii?Q?MDqL57wBxrtuMH7CZC7HZN6oOTx67ADZzckQmirQ0PiXs0ML3I2qpfNVpmAH?=
 =?us-ascii?Q?9D1KkupjtPWUXVDiy2Bp8rufq7dFjhEA5xBdDXl0syH/QUNz5GZ4zuoFtJQF?=
 =?us-ascii?Q?ht4Ey/WYpaKuI4tZlVht4VXPyrWyEyLHVov/ATvQAYr1riBeh4PqZHX58cml?=
 =?us-ascii?Q?FHZY/Kr1IYoXc9eFkkJmcazWRZK+V2Gl3PTlhdXo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107eaeb6-86bf-4b57-72e0-08dd470c42bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:34.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBwbxhGCmJdlViDncHGgmMAUI3Z7jP4LspXdkE66fHjTmZKgiNDbqGiqHhyBiwDY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

From: Andy Gospodarek <gospo@broadcom.com>

This patch adds basic support for the fwctl infrastructure.  With the
approriate tool, the most basic RPC to the bnxt_en firmware can be
called.

Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/Kconfig       |   9 ++
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/bnxt/Makefile |   4 +
 drivers/fwctl/bnxt/bnxt.c   | 167 ++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/bnxt.h   |  27 ++++++
 include/uapi/fwctl/fwctl.h  |   1 +
 6 files changed, 209 insertions(+)
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/bnxt.c
 create mode 100644 include/uapi/fwctl/bnxt.h

diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index f802cf5d4951e8..0a542a247303d7 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -9,6 +9,15 @@ menuconfig FWCTL
 	  fit neatly into an existing subsystem.
 
 if FWCTL
+config FWCTL_BNXT
+	tristate "bnxt control fwctl driver"
+	depends on BNXT
+	help
+	  BNXT provides interface for the user process to access the debug and
+	  configuration registers of the Broadcom NIC hardware family
+
+	  If you don't know what to do here, say N.
+
 config FWCTL_MLX5
 	tristate "mlx5 ConnectX control fwctl driver"
 	depends on MLX5_CORE
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 1c535f694d7fe4..5fb289243286ae 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
+obj-$(CONFIG_FWCTL_BNXT) += bnxt/
 obj-$(CONFIG_FWCTL_MLX5) += mlx5/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/bnxt/Makefile b/drivers/fwctl/bnxt/Makefile
new file mode 100644
index 00000000000000..57c76e0e0c9ca7
--- /dev/null
+++ b/drivers/fwctl/bnxt/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_BNXT) += bnxt_fwctl.o
+
+bnxt_fwctl-y += bnxt.o
diff --git a/drivers/fwctl/bnxt/bnxt.c b/drivers/fwctl/bnxt/bnxt.c
new file mode 100644
index 00000000000000..d2b9a64a1402bf
--- /dev/null
+++ b/drivers/fwctl/bnxt/bnxt.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Broadcom Corporation
+ */
+#include <linux/fwctl.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <uapi/fwctl/bnxt.h>
+
+/* FIXME need a include/linux header for the aux related definitions */
+#include <../../../drivers/net/ethernet/broadcom/bnxt/bnxt.h>
+#include <../../../drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h>
+
+struct bnxtctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+};
+
+struct bnxtctl_dev {
+	struct fwctl_device fwctl;
+	struct bnxt_aux_priv *aux_priv;
+};
+
+DEFINE_FREE(bnxtctl, struct bnxtctl_dev *, if (_T) fwctl_put(&_T->fwctl))
+
+static int bnxtctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct bnxtctl_uctx *bnxtctl_uctx =
+		container_of(uctx, struct bnxtctl_uctx, uctx);
+
+	bnxtctl_uctx->uctx_caps = BIT(FWCTL_BNXT_QUERY_COMMANDS) |
+				  BIT(FWCTL_BNXT_SEND_COMMAND);
+	return 0;
+}
+
+static void bnxtctl_close_uctx(struct fwctl_uctx *uctx)
+{
+}
+
+static void *bnxtctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct bnxtctl_uctx *bnxtctl_uctx =
+		container_of(uctx, struct bnxtctl_uctx, uctx);
+	struct fwctl_info_bnxt *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uctx_caps = bnxtctl_uctx->uctx_caps;
+
+	*length = sizeof(*info);
+	return info;
+}
+
+/*
+ * bnxt_fw_msg->msg has the whole command
+ * the start of message is of type struct input
+ * struct input {
+ *         __le16  req_type;
+ *         __le16  cmpl_ring;
+ *         __le16  seq_id;
+ *         __le16  target_id;
+ *         __le64  resp_addr;
+ * };
+ * so the hwrm op should be (struct input *)(hwrm_in->msg)->req_type
+ */
+static bool bnxtctl_validate_rpc(struct fwctl_uctx *uctx,
+				 struct bnxt_fw_msg *hwrm_in)
+{
+	struct input *req = (struct input *)hwrm_in->msg;
+
+	switch (req->req_type) {
+	case HWRM_VER_GET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			    void *in, size_t in_len, size_t *out_len)
+{
+	struct bnxtctl_dev *bnxtctl =
+		container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
+	struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
+	/* FIXME: Check me */
+	struct bnxt_fw_msg rpc_in = {
+		// FIXME: does bnxt_send_msg() copy?
+		.msg = in,
+		.msg_len = in_len,
+		.resp = in,
+		// FIXME: Dynamic memory for out_len
+		.resp_max_len = in_len,
+	};
+	int rc;
+
+	if (!bnxtctl_validate_rpc(uctx, &rpc_in))
+		return ERR_PTR(-EPERM);
+
+	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
+	if (!rc)
+		return ERR_PTR(-EOPNOTSUPP);
+	return in;
+}
+
+static const struct fwctl_ops bnxtctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_BNXT,
+	.uctx_size = sizeof(struct bnxtctl_uctx),
+	.open_uctx = bnxtctl_open_uctx,
+	.close_uctx = bnxtctl_close_uctx,
+	.info = bnxtctl_info,
+	.fw_rpc = bnxtctl_fw_rpc,
+};
+
+static int bnxtctl_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
+{
+	struct bnxt_aux_priv *aux_priv =
+		container_of(adev, struct bnxt_aux_priv, aux_dev);
+	struct bnxtctl_dev *bnxtctl __free(bnxtctl) =
+		fwctl_alloc_device(&aux_priv->edev->pdev->dev, &bnxtctl_ops,
+				   struct bnxtctl_dev, fwctl);
+	int rc;
+
+	if (!bnxtctl)
+		return -ENOMEM;
+
+	bnxtctl->aux_priv = aux_priv;
+
+	rc = fwctl_register(&bnxtctl->fwctl);
+	if (rc)
+		return rc;
+
+	auxiliary_set_drvdata(adev, no_free_ptr(bnxtctl));
+	return 0;
+}
+
+static void bnxtctl_remove(struct auxiliary_device *adev)
+{
+	struct bnxtctl_dev *ctldev = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&ctldev->fwctl);
+	fwctl_put(&ctldev->fwctl);
+}
+
+static const struct auxiliary_device_id bnxtctl_id_table[] = {
+	{ .name = "bnxt_en.fwctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, bnxtctl_id_table);
+
+static struct auxiliary_driver bnxtctl_driver = {
+	.name = "bnxt_fwctl",
+	.probe = bnxtctl_probe,
+	.remove = bnxtctl_remove,
+	.id_table = bnxtctl_id_table,
+};
+
+module_auxiliary_driver(bnxtctl_driver);
+
+MODULE_IMPORT_NS(BNXT);
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("BNXT fwctl driver");
+MODULE_AUTHOR("Broadcom Corporation");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/fwctl/bnxt.h b/include/uapi/fwctl/bnxt.h
new file mode 100644
index 00000000000000..ea47fdbbf6ea3e
--- /dev/null
+++ b/include/uapi/fwctl/bnxt.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024, Broadcom Corporation
+ *
+ */
+#ifndef _UAPI_FWCTL_BNXT_H_
+#define _UAPI_FWCTL_BNXT_H_
+
+#include <linux/types.h>
+
+enum fwctl_bnxt_commands {
+	FWCTL_BNXT_QUERY_COMMANDS = 0,
+	FWCTL_BNXT_SEND_COMMAND,
+};
+
+/**
+ * struct fwctl_info_bnxt - ioctl(FWCTL_INFO) out_device_data
+ * @uctx_caps: The command capabilities driver accepts.
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_bnxt {
+	__u32 uctx_caps;
+	__u32 reserved;
+};
+
+#endif
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 0790b8291ee1bd..518f054f02d2d8 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -43,6 +43,7 @@ enum {
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
+	FWCTL_DEVICE_TYPE_BNXT = 3,
 };
 
 /**
-- 
2.43.0


