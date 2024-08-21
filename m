Return-Path: <linux-rdma+bounces-4466-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A395A47D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE5283645
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440881B2EEE;
	Wed, 21 Aug 2024 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U468kwG8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881511B3B11;
	Wed, 21 Aug 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263876; cv=fail; b=LFNz5BaBwFhnYMRdfLDCAFrr7LB/MEIW4vIfudJ3lJ/yXQ4ZB29dhivyFstemxpxM7V6NcohtiUqTbgALios0MN6FTBn25cqqNcJZpM69dm77LwoEeiFb1TTZIfM68lMhsO8V14YPeCb25FVlDp+3bLMZ+A3llyrrAvr6fG0Dp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263876; c=relaxed/simple;
	bh=suCgcmNktUvgJaB5zPvYDmKarrXp48jh0gfh8cQalx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ji1XQKKS/Ur55QlA+yYkV8whIkotPQC2yimOPnhBwF/hbalBkg9tA0Wzf/izSUp9hPHGGTNu5oAW12xb65ApfYSPqS+AxqEZfoZ1qlh972c5FNH5hke2UfA3mkgcAT3rrluaqX6HAVlObb4rGr9uW6Z0Si9ZggWEvJSp5ZKZitU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U468kwG8; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUctp0wBe7IfY+b6D71ksBxrjuxJA5b5Hi/i8e9/tYAzDnrI7hGaljc+5HWZzDkbMA2NHu7skLMBSAlGj16N0WYqgiLcgLhfaVtCdkR2HvpAbSYe9zQ2f0YsMhHsPCi3anCAGiZaJDtETlxWQOWfNs0qYWqpY2xygg/Fw363CcPJ0+Zc79yV6DBM7w8tddrNgjJGbWN+Pn2BKR5TNNzNnIBoJSGfvmDCRYM6WsxTn2T/n786p4EsYjUJWhPzWc1C4iu23hNcI2hYVmvi9CE0ImN4LAFFAqz2pxWsSglcO8qvfhAczRMnYjJeUua1jYX36ZglRFgL42EMGNUQIa1AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoEUo796KhnBL7/w2VPe8nzAdv2FMhK/MN5+Z4HN6DY=;
 b=k+gPXatbRRy0G/rA4mLlIcOEscFZr+ldYyrr31N+B8Jsq3PVUUKwNQP4wHue92xLPRavNtXrnuUTfRKtHERwsGYuimZcPylL0lTnPDkw90WwYWMUGsBWx7TUzrbG52LHhJdopvUktYjC7/lHixagQr3KaBcVX8OHbSMP5u4sjJIQRH7kqrvkGm8H+DU/xdWgRlPqnq8+XoZ0A6Sripe1qvt8Ulaf233T6SwbHXkxSHghsvUg8iHEcx8Fgl0gPl62bdEDYk5Xf7EOQqzAU3iFx06ERg+bxA+WjQY0plH+oj9zKe0iJ6zw6ZlxymSsgiT5SbRbtDY2Z75pEL/I9xpf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoEUo796KhnBL7/w2VPe8nzAdv2FMhK/MN5+Z4HN6DY=;
 b=U468kwG8hsRKZ28Jr6d+GUIsF9XtWEw9XiEguMJMV8rdbUk4RQSV/UtSJ/onDWU+irzmMGo+2BHuviUxCuPrSLyCGMROIvEIMVZgmLOZDy+uvRNEmZ2hile11HzB3/VxQ+oygKPlMjV4tlc6mGhW8Sp80ilVJZUcS+mPx2HOr6248q+HCWe1Fh7cGX1dmfO8FOH6EDBB3ZXolam/ov//LWbaG3Pk1I+1C6Imr/SJflNlhoZGbEHv/Ot1GHd/ovIGR9YjmbWuOShFDiBU+Z1mLG7wUjuLjHOB0bJ3pMWj7oIJpu58a5QNKSw6TYtA3OPbRRnh1WCiRKyjwAo8SDBymQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:04 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:04 +0000
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
Subject: [PATCH v3 08/10] mlx5: Create an auxiliary device for fwctl_mlx5
Date: Wed, 21 Aug 2024 15:11:00 -0300
Message-ID: <8-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:408:d4::24) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 684a2ad1-1f08-4053-23a3-08dcc20c9e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xv6LOO+8cqxZs62bItCytTJQ/14m2DQvhUz6phJ1f7JUFZYb8it53wy+WG04?=
 =?us-ascii?Q?O1GgibGOEmytcIKGPfJddKk9Z7AnkKORKKgk9KbL8Nim2PdNKYb/Nh8l/Ez0?=
 =?us-ascii?Q?bddsXV6ZgION4rV8to95mQWF6f2DhE9aeMA2Lp3EZiNBwrcaLWb0GQ2gd8ix?=
 =?us-ascii?Q?LncIyaFHv0clgvCCjJjAWhGPXEzmmrlJ/AeY+JfgLfxBEoW3WhZNzXS8GDK+?=
 =?us-ascii?Q?VChuFjxtxFlvDs9b/eaa34VMRGDwBM2v954paddbHnLgz0dYbR2+bLufbiBt?=
 =?us-ascii?Q?bROjA+/HQ2jHKufhOCLTSCmG3DQuCBzBZshGTs9B/EynSFRY2KTOiYjzz7La?=
 =?us-ascii?Q?ubltlswkBUCHb6Xc6b695nLuya9ggIUh6uY7kECyJIxKvNTazGgPh2nongLh?=
 =?us-ascii?Q?MbAafx3kEr2xDA3JaXXnY6NF+oaXhttlVOZZVat9nIGW9v90Apn7va2K0ZiG?=
 =?us-ascii?Q?jw1MaHQTUaBnjP3vJ1ikb+jyA5ST9eWc8BqUjxzTPqy1rwzGgZkicCl6SBLe?=
 =?us-ascii?Q?6fsB+N1yBh9gxsbf/jih64afeT3iJA/F7BstVfjxYXJOaGzDcuob6QnH65bz?=
 =?us-ascii?Q?FiRTZW4JnPe7oLsmenqAT65SvBix5w4Ae3jwI6/wDIJaztrf3cHFxalhl9wJ?=
 =?us-ascii?Q?Lv6C0X8dzXxrjFTkyZ38aLgqoL+uOlpmKmh2V9YWfW6bk+TqQlj8LOjP0N0p?=
 =?us-ascii?Q?SXYngiJKQEtgq7Ae22Y1lylqrAGM6HnmkM3eno7EiPciJq9k2vSlSo2eJufu?=
 =?us-ascii?Q?Y/kYURwGoFRvBIGDoh31YJ3oTXV0IeoymK112ZIfAuEon0P/BVjwWWOeu1bG?=
 =?us-ascii?Q?TwoXY2M6Ya+NR1c7QWDUSkje3eHw2W96m2mRInAA3PSaJN2hbSSxj+3znDDf?=
 =?us-ascii?Q?jRVY020VoS95qq3gnx14Hm5LX+4f54wIGSsPr+iqrjj+qdhRxT4QBzO/uo2m?=
 =?us-ascii?Q?qX19Utrl4oO5Uq6eA/n1bMm7hpXTktV7X9sFPs5Dbq0xAfMX6OhisRCg094N?=
 =?us-ascii?Q?oZtn4uN/+v72lH1g28xJ/X08l2lmmTL5cRi6IZ/Jy4qw/myrMvij4Q1CZ3qc?=
 =?us-ascii?Q?DKEacNZ/7SFLMmptKXtNbMPKB1rkYqEZomAhmrXjpKBv7NEMgqvFF2LCzoAQ?=
 =?us-ascii?Q?KIvjaC9hlrqKL9Kw1+zolAvM3JDiGG7be+ktEODSvur3hmdl4iOUNlNEO/OR?=
 =?us-ascii?Q?RTYBGjeas9SQx4rO7YjCJSbaMZ7+eBy1aLz1u49NRTXuXUt+VCAu8DwzookE?=
 =?us-ascii?Q?mVyzUXoQCFZrzso9+Ze6nLaaaZ+j3L9WBzexwfDTSHp5pNxe8nhqtdF+7kWP?=
 =?us-ascii?Q?uvRtBj8JEOo4QJU5s7JtHsD/WBZUNQbrcUOOWVL8z6+K1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oxkCEx+OSd+sznIaTtOBcpAlxMWOEwjVC2fguXI+GUKNdFXtt2LrP2+8LKrz?=
 =?us-ascii?Q?2+ei1yNpmulwH233uZCGF+A6VhU34GZMGBZxR+IQkZYXv7UgO0zGLHcHvpOa?=
 =?us-ascii?Q?DoN0eFrwQznxu0vw1kPeyF30fHEqPuTWpmlypGYwBlqrlG0INACIB0iDG4lF?=
 =?us-ascii?Q?3sf0IBZe2hksl1hGtaPcxBILN5IaTjr/b5D54R4q8fdNYgJ5H4v3A/eeIOkn?=
 =?us-ascii?Q?1w8QHgozQLKQW2HDLTqsnBPnNu5oVJse4xwej+JBOO7HBPhtEOqZP2ifCF8x?=
 =?us-ascii?Q?h6E8tKLbn0ckuB/x29rePCFatXzNDLVbcAoGXKIbWur9RqjwYhdfY6ftUEs+?=
 =?us-ascii?Q?Fgh9BS7ADxn6SQX4pwSaYRobDse4NgVWq0PN3bjkrqX7irmASY682Iy8MCvr?=
 =?us-ascii?Q?6MnJxYJnpCro8f+YT6TDviPSnO7ZgsQm7IymwKzBFlZwRpIc5GQVKM7XEv/6?=
 =?us-ascii?Q?QwgrLycXBTQQMCGzcC7xiAlo5ftKlu/03IKovnvtvksjmJN30bTNr0mH8Leu?=
 =?us-ascii?Q?U3vaNDiNRrvBS9NQTRi6rQraRNgu4zN9MSkbqy08+KlTsyUiVpubZbHi34sK?=
 =?us-ascii?Q?tJ+kZzJuq6MPmbli64gIme2+praxGPK4U0v7hP4HY+XtR9FoRyIYHSn1Hler?=
 =?us-ascii?Q?gCAK9/zGoJKlstPzG6lzfC3L188JD69mKvGN6RJqvGDv6ryz+tXhfw0JqE8a?=
 =?us-ascii?Q?hRHdG0h2kw59FuT846P2o2vpIRAHqf93yRbi4Q4lDSXzwJJ5sNiFOQgNsSQP?=
 =?us-ascii?Q?kJ1tE6zGIUfuNYvw7KFXPHafbugHboJM8+Lu15MPniAiRdlHBdeQPBcGNFJe?=
 =?us-ascii?Q?+q9V04BrnbnFBkXZGU0m70fXExJcUfVSwKKk7SF1atMr7bwIuOQHO4saHY+X?=
 =?us-ascii?Q?dJPftGGY8o3jKblklwYw4LR/l2OLgvNACcr+HZ5Lv9TS6qdeLdsGshMZLpFp?=
 =?us-ascii?Q?8r+xshF5MlZixlFT26lj5aufCVKAzOtfNajAHyazx8FaQMq+VEa0P2hw9dcO?=
 =?us-ascii?Q?fk9taXFRhwD6zHXds+XpMCDpa+Ge16evRAPhdQHaeFKFfIXfmQ6e8z1bYI2u?=
 =?us-ascii?Q?vmj3zTePW1E48uhhN4gXcAPWcFzEvLuYNcTyO/1v5Rtg5YexooWu3AVVFm60?=
 =?us-ascii?Q?UYtVawmqFaXfAKk9vr/05TwWaDmYHGxtO0zEb6DS1fZ8Emk4eYWWX7G/XFbu?=
 =?us-ascii?Q?3Gqjd7sNDXQHWJnTw3yB+sBXtfQDHTAOlnwWiTq9MLn6OwCRQC2KREj/AwKN?=
 =?us-ascii?Q?CDUI9babL115HEd1wm89LDItchuCadC21yPwEr0MqqhMiMmiAKzaM7unuxWF?=
 =?us-ascii?Q?R5Ojc0s42NECeoSKkP1Q6yzurt+mO1R9A39J8zGqDpdmLLZP6WDenJvIg9Z5?=
 =?us-ascii?Q?wr1R/HLlPJrbIyFmQm/y0SK647nk9tgqLCJTF2FAXpqIKUgi2XzMOznG9pTW?=
 =?us-ascii?Q?Wgcw/vy8Nfp7w/JCTdD6gFXvI3d1rabEWzVwRLqE0PKGeCQdktd7qQyl3nSX?=
 =?us-ascii?Q?LZv3N02UyrvLMQIQBemunOAF7EzoPloiJ7uq8cmop9ozUwyFOCfNF9jLikxa?=
 =?us-ascii?Q?cKFcGflwONOZcIIL8yI3BIYDuxW3EBi09aw2SiFe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684a2ad1-1f08-4053-23a3-08dcc20c9e5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:03.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6ozlKcRXosnAaAVxNekEYJs+emaRh5GnzGzetsE5wYuIDykJ/QpuEMhgSKsaX1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

From: Saeed Mahameed <saeedm@nvidia.com>

If the device supports User Context then it can support fwctl. Create an
auxiliary device to allow fwctl to bind to it.

Create a sysfs like:

$ ls /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -l
lrwxrwxrwx 1 root root 0 Apr 25 19:46 /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -> ../../../../bus/auxiliary/drivers/mlx5_fwctl.mlx5_fwctl

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 9a79674d27f15a..0786b011a8bc29 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -228,8 +228,14 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_VNET,
 
 	MLX5_INTERFACE_PROTOCOL_DPLL,
+	MLX5_INTERFACE_PROTOCOL_FWCTL,
 };
 
+static bool is_fwctl_supported(struct mlx5_core_dev *dev)
+{
+	return MLX5_CAP_GEN(dev, uctx_cap);
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
@@ -252,6 +258,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_mp_supported },
 	[MLX5_INTERFACE_PROTOCOL_DPLL] = { .suffix = "dpll",
 					   .is_supported = &is_dpll_supported },
+	[MLX5_INTERFACE_PROTOCOL_FWCTL] = { .suffix = "fwctl",
+					    .is_supported = &is_fwctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.46.0


