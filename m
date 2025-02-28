Return-Path: <linux-rdma+bounces-8201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6588BA48D40
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CDB7A5CAF
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5B12CD8B;
	Fri, 28 Feb 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ltns9TMn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704634594A;
	Fri, 28 Feb 2025 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702412; cv=fail; b=qfVRfTAZQmOAgYO1n3f6rLL/SfkM2CYNZei+uFLN01LmDJRUPzVrr2dFb1vs1QFK3XvXbXZn+x2Uf8w+ydJLUsXtPs+GHY4yy4ToJW9DGaAd0ECQvbfzBNlN/iwzPTfd/7QfAvnPh2W0zcaVVeyFJOsCYUOmXmUsUlDsH6PvxfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702412; c=relaxed/simple;
	bh=zPDlt66290RQrsa07QpU4y1B92rNq3BfAjS8/p5Qkrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jvupSxqIpeHCSHZ8Adg8a9w+ZgTlgjObxzaKQz1wU7jmIzv3Cacm0czKQekLizD2K54f6edL0U76odnZCqZpVif6w9f0ZFFvaUmcbzrQo4Flar0xlZAj2iKvGMYoE3cISqFDoFbtsX/f0jJTDJ37scTRVSewBTQaeLsBtbvW1gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ltns9TMn; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQecEkZeeR2BhHbQI7p/bfWceVVPM3gUKTGttiDHh3cFm3YqAeUTmS//+GaFOqMPBqcxEhWAZDeIdaqYaoABsH1EWmjw/h4nnZnwiOpjpfGraD0xSFz2SbsGxBh6erBsVb5NItMhciHiwjfGFqj2+FzI+ZHnLRJnQ4fzZ/EETvqeKmlir5a0ivZOvmU9kw2rSECucb0FqcHsKO3f3zTEWmlroJ1RW5CcRr+mx1O2nPCsNsHuZ7ewyNURhSgahMNFLsHZmh/EESF5fUdjALoVGjmTe6VfKWyXDMG3wlpUEvOEhJFXPF86793p0/TJF7tC93J+0WbPqq5lt+ou7NhCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwrkauMdLyp+SEB8N1rLfRWdcPZN+EeY335rLBfeGm4=;
 b=rXCRbUoLNn76ujVQNHuO1dKOVLlEKTFE85EToHNGcGkbezwIhpWQNZ9TInQS151os72W75Lpr74up8F3Gc8wL2epKm1zsV3I+XHuidnI9XvLOCG4IfG1kJCTNTsOxdvGEabZP1q5LlN/di6d6bEYmvMAtvLArYlGZ4pX36JEfEC2U5Gk0aQn+SvOle2fhluhHP3QboU2wCssOvjGO/XcV3uvNUznDCT17VB+9MT1CkA4uFzMMwHqarsqB5Nbzgh93F2eS0K7E80PEDtnsq1JVyiSKNb8dCQsqn8IM7F9lbR+ReFowSkFBvEkHEZkbBqWFN3ICIjVXrLhhG7hQVAY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwrkauMdLyp+SEB8N1rLfRWdcPZN+EeY335rLBfeGm4=;
 b=Ltns9TMnVQFDDSr8TiY2ZsenxQs4O/zSXrP7gyLtwBpjaV5mQnXOxAnr8dwU6UwKLt8RV1WtePaMKZMPOa0c7v1tPHl+koKMQGHJXw7gYwaJp87KAYxaem0r/+dG0gr05KKkdcuCc17IUsURH9jby+Jf3O4n9I6KXapUBKyeH84UWupHIwZTV/c2x08HNIrmy7MY5O9QB7V6usavDBjmDdy7kPgev+zqo66AmOPKN7qh3zphsqtpPAhf+ZSV0imcrZqja+ZjaENHW2bmyXjQFKEF/S6R5ED+3L0NqO2bikzQBiA4Vjz829O+Lo/2DBEHalQgERwCd1/4/g8bmXjq5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 00:26:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:38 +0000
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v5 7/8] fwctl/mlx5: Support for communicating with mlx5 fw
Date: Thu, 27 Feb 2025 20:26:35 -0400
Message-ID: <7-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0132.namprd04.prod.outlook.com
 (2603:10b6:408:ed::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a1513f-42be-4dcb-d4b6-08dd578e906f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?warq1BruJPLMKhh7kZqsUr2z6+HUYBCqdjhQe6NbH9IPxQ6A5mk8ofiCZgvB?=
 =?us-ascii?Q?khWhHySPrxgo7QOZpHUeAPPo4F5u5s/c6JXcLUrVkEagtL1AAAY/06ziIPT7?=
 =?us-ascii?Q?HVGGBIcEmLq1IrS6WbpJZf5kZCXwv4BzFpZ5mfG2/sJeVd9qpBWjVOacWWVb?=
 =?us-ascii?Q?cKRlIlIeBkcHvzxGcDU/TXy7OlbsmRmtLPNDHR+nPCTGQbaLfWN9Beu1h69B?=
 =?us-ascii?Q?+t0gOZ+HQsizHAHci6ZyHDWXEHh45ZbNrqphBjpHVJTBKoCd8nNnRD+TX4/m?=
 =?us-ascii?Q?Vfc6w7HS5/Yj9xJMZtbTyAP7kCtxF85QfJx6Poyvnb1+Q2ShVNOfCL4dl4Zg?=
 =?us-ascii?Q?3WBpz0zvi9ApbuxtBvORt8o7c7XJJ0+9GRVJhin/1DELIg06gkvxFoY0fGUW?=
 =?us-ascii?Q?VJLxQzISCC8dwlgNZTjjxrLI5VxGsI3qcOuicwP8ySdeZ2qdotKiZ4cX8moK?=
 =?us-ascii?Q?3V5FtB2C52zBTJSK+wL3e0OiTz7227qW0ZxMcIgAXyp9T4/jlrdAR/h6oDZy?=
 =?us-ascii?Q?SbQ06pANgjWV0QI7jVrMScbe2dNzTRYXBQOZvNAm8uLBZcXOeFBgA33v25jQ?=
 =?us-ascii?Q?ibrF8geXyQsgsvd2IopTsNWBy7T/Wubp8tQTSTfNPRzgnlNxdgSLxoJJGILh?=
 =?us-ascii?Q?oi4cst8y+TIgvHwSt7yWmLBDdJTdve/je1dPByw6f1vse+6J4px0PUEKwVuy?=
 =?us-ascii?Q?jvQqHwIAOKw5d0SfVxG/oskvnSN3v0jje6jqU8LnrmkHW5nLRYme1D3ShDl4?=
 =?us-ascii?Q?eCHdLt2/wH7NcISVKF8SkcHl/iYeNJq1kj1dgcLVzNxVVFj3EXmbOW21IEuV?=
 =?us-ascii?Q?LhQJFjEQdRlEF63leKfXZ5ZiWuQOltPiDU/Aa55OcgUy7ZyFxl6wSK8lJXH+?=
 =?us-ascii?Q?DQqv3swlOQgb4f3e59sa50kFQclwIi6rS1mOMmMjcWb6+lpxoWHhqBlswJ8J?=
 =?us-ascii?Q?FeuqfYZyujyvMz3vVIk5LBzV9oKE/srWTJogVcRnojMLzrgDrb4pWWsldZe3?=
 =?us-ascii?Q?B0D7P9BcerjeVpzVF2stMpj7LuJsI5uRA1nNWKSCDrXIZTrLflWfNM5Titbh?=
 =?us-ascii?Q?1kTd2/IIVbPE+8YnL0Hr6NjV1VM7J+EWzdLjSCrxaw03n5uX6IfLQy06aJJa?=
 =?us-ascii?Q?S12JT1tUKC1d62VMOp+tiyBklZF2y2yeo+mn+d10/lSJ6is6XSfjpjwiWn+k?=
 =?us-ascii?Q?K4mMSNqpexwO9CpdNc4FYVgePsOKMBF2SFHD38BFfx+hP3LjKsD4dxw3Tfxh?=
 =?us-ascii?Q?qlK4zwJVJ1IiHdritF8S67QJVd1C8olgzeTAC+JiA1Oa6fQhmMOy7+Gd56RZ?=
 =?us-ascii?Q?UulguAinw0Q+m9lX9Cimx+i9zLmTZorO07Q/kuBhCGOvJ2YsZuPvEGXETAJ1?=
 =?us-ascii?Q?lwNDDYsrllI9H7y3eM9dP88eckSZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGU64VxmnVf8CVWzM8uPdGdsVEST2P+CkKm8kpbIZtzp48QgzyrRMUCNLwk7?=
 =?us-ascii?Q?3eSkZbpBj1o3PkLs2ymwbHrZH0XcPXKavjX3fT5jfD+RIrWCJ9NZ3y0du2cH?=
 =?us-ascii?Q?RK0aKHpmL/45N09kcp6QNJoehLSwcuwwyijIB9SPnh3WvqCpyStBDmyUj+xi?=
 =?us-ascii?Q?f23hGGKf70c03dLOBBWA5M/3y7My6ls2Pvm/FmaU/uBGb5znfDzYoPYJdgN+?=
 =?us-ascii?Q?R6AqcOZ3OQ2vyLgHjmvIZFMZqgO4zT55PY8+sPWDbC+Tz5sCcJYgjTr69AG6?=
 =?us-ascii?Q?oyHtHe8iN4fVJ7T7rHS78OhaXPelni/1OsD6dXJTzfhX5zMbYuXu5tRjRSfY?=
 =?us-ascii?Q?LHTYPzo7wMynpWV4QZY6t8Fhz4tI4/5hdmf6QatPJh9f3cWvmamrfjq1Y/rQ?=
 =?us-ascii?Q?z2w+1Q58gv9j5n/OMmlU9BHS6pDicH/kZnvRxjFJU4S8pyV6S3++U7+4vrr7?=
 =?us-ascii?Q?tFddhaHd9QA/iabV62Zicos4cyBxYjVAw0nO5Xu7nh+847eOpVVhF2ZG3QUJ?=
 =?us-ascii?Q?SJYERWHPHE/4Thrn8XNZ6ncrFFhyejv9TFlEBT788bvwitkenYHtI3KvHe06?=
 =?us-ascii?Q?VJ0HQRbeEFoBOwCWR3iwMKAt+ZIhTJ3yl3t3c5JT6alGjf842jFzfhABND14?=
 =?us-ascii?Q?JEQ3jXiHMJTe9vxL0/jj6oZYs0y8xFow7fjhxZHrRdpmtlqZyoeHER4iheZL?=
 =?us-ascii?Q?HQvnfgxKZlm+bYT121DKvt4QTovCmbzT34CQ+M4VKscKXzoOOefZwr7mLMWj?=
 =?us-ascii?Q?3512CWLjYHCfd1Gbr3UStrpS2lC4bNmswo3Vo1rFrT6i6AxUuhjQU9AnSo93?=
 =?us-ascii?Q?WSz8xzUJkAThqVdiqpQc7CsTL06VUhYhJY6lVfAKu37Pn8Web9HvlgsIXEOl?=
 =?us-ascii?Q?GSfIMULn4de4vm8xBpglQUS4vc/mbnm6AmybZ31oOqYdnG6ARt6FnrLXPLUe?=
 =?us-ascii?Q?Xm1xOgnbJgsHeADzhWqPFBKWbyHDxL1JytwINYvcZRDhWTxeOGlnsWz3fa42?=
 =?us-ascii?Q?toKsEFUo4UmBt4EXa3D5pYEOHmoBfdAjsF+PngoI+rkjEwHYPIPIMqXYFAI8?=
 =?us-ascii?Q?Ky0jgTTong0LKYGGW0ESZ3Tr1ueo7S8JpnebJb35NrXhiWlHP7VrhBMmEl+r?=
 =?us-ascii?Q?Q5awLEdZBaFfTYRLQupEl2uy0VimwrOUbBmPsmwcbaHkY3d0IxTRJKY+iO2L?=
 =?us-ascii?Q?HBssQKG/YRf3uLOjPhVYsMQEIjzSpqxx1a/IEmFj43v4zkIF2QC0wAl40HuQ?=
 =?us-ascii?Q?2gNOblO+7ZdNrW2WLvZ1kS72AtlefsFNUpMYpPGmCN6+hY1x35LI5aubdzGg?=
 =?us-ascii?Q?cusi4oNVSdVnR2BAIJCC82l/OmpU2onPn3DlfZpQ7KV/FiwM618GBwIpP51z?=
 =?us-ascii?Q?rqNP+FJu/QH/pT4KJYtLU4NXhqsIzfs8AdjSrD5UfW+DNzo3b3lKQvAYekV3?=
 =?us-ascii?Q?zr/KMKakT8cWHv0Zl6fSpO703aam6ImepCiJMhnbJMv/cd233VgNBcHFOjbq?=
 =?us-ascii?Q?AsAk1qXuwwKqaopi+jOtYjQTD8KtB8+JHkp5g6aQb+dZjCtnXlxupEMvrZw8?=
 =?us-ascii?Q?bZCTB44llEZlgh11u6XlKNdgOuBdU4NjkOZkyEOU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a1513f-42be-4dcb-d4b6-08dd578e906f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:37.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khG8AiIz/g++bQkjb3PwTeJ6AaJZjoMdRtoQflAqFw4Q14+TZzGvC4+0flgTOAuv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5 FW has a built in security context called UID. Each UID has a set of
permissions controlled by the kernel when it is created and every command
is tagged by the kernel with a particular UID. In general commands cannot
reach objects outside of their UID and commands cannot exceed their UID's
permissions. These restrictions are enforced by FW.

This mechanism has long been used in RDMA for the devx interface where
RDMA will sent commands directly to the FW and the UID limitations
restrict those commands to a ib_device/verbs security domain. For instance
commands that would effect other VFs, or global device resources. The
model is suitable for unprivileged userspace to operate the RDMA
functionality.

The UID has been extended with a "tools resources" permission which allows
additional commands and sub-commands that are intended to match with the
scope limitations set in FWCTL. This is an alternative design to the
"command intent log" where the FW does the enforcement rather than having
the FW report the enforcement the kernel should do.

Consistent with the fwctl definitions the "tools resources" security
context is limited to the FWCTL_RPC_CONFIGURATION,
FWCTL_RPC_DEBUG_READ_ONLY, FWCTL_RPC_DEBUG_WRITE, and
FWCTL_RPC_DEBUG_WRITE_FULL security scopes.

Like RDMA devx, each opened fwctl file descriptor will get a unique UID
associated with each file descriptor.

The fwctl driver is kept simple and we reject commands that can create
objects as the UID mechanism relies on the kernel to track and destroy
objects prior to detroying the UID. Filtering into fwctl sub scopes is
done inside the driver with a switch statement. This substantially limits
what is possible to primarily query functions ad a few limited set
operations.

mlx5 already has a robust infrastructure for delivering RPC messages to
fw. Trivially connect fwctl's RPC mechanism to mlx5_cmd_do(). Enforce the
User Context ID in every RPC header accepted from the FD so the FW knows
the security context of the issuing ID.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/fwctl/fwctl.rst |   1 +
 MAINTAINERS                                 |   9 +
 drivers/fwctl/Kconfig                       |  14 +
 drivers/fwctl/Makefile                      |   1 +
 drivers/fwctl/mlx5/Makefile                 |   4 +
 drivers/fwctl/mlx5/main.c                   | 411 ++++++++++++++++++++
 include/uapi/fwctl/fwctl.h                  |   1 +
 include/uapi/fwctl/mlx5.h                   |  36 ++
 8 files changed, 477 insertions(+)
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/uapi/fwctl/mlx5.h

diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
index 8c586a8f677d5b..04ad78a7cd48bb 100644
--- a/Documentation/userspace-api/fwctl/fwctl.rst
+++ b/Documentation/userspace-api/fwctl/fwctl.rst
@@ -149,6 +149,7 @@ fwctl User API
 ==============
 
 .. kernel-doc:: include/uapi/fwctl/fwctl.h
+.. kernel-doc:: include/uapi/fwctl/mlx5.h
 
 sysfs Class
 -----------
diff --git a/MAINTAINERS b/MAINTAINERS
index 319169f7cb7e1c..93e64a54c56f37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9558,14 +9558,23 @@ F:	tools/perf/bench/futex*
 F:	tools/testing/selftests/futex/
 
 FWCTL SUBSYSTEM
+M:	Dave Jiang <dave.jiang@intel.com>
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Saeed Mahameed <saeedm@nvidia.com>
+R:	Jonathan Cameron <Jonathan.Cameron@huawei.com>
 S:	Maintained
 F:	Documentation/userspace-api/fwctl/
 F:	drivers/fwctl/
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
index 37147a695add9a..f802cf5d4951e8 100644
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
+	  MLX5 provides interface for the user process to access the debug and
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
index 00000000000000..f93aa0cecdb978
--- /dev/null
+++ b/drivers/fwctl/mlx5/main.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
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
+	MLX5_CMD_OP_QUERY_DRIVER_VERSION = 0x10c,
+	MLX5_CMD_OP_QUERY_OTHER_HCA_CAP = 0x10e,
+	MLX5_CMD_OP_QUERY_RDB = 0x512,
+	MLX5_CMD_OP_QUERY_PSV = 0x602,
+	MLX5_CMD_OP_QUERY_DC_CNAK_TRACE = 0x716,
+	MLX5_CMD_OP_QUERY_NVMF_BACKEND_CONTROLLER = 0x722,
+	MLX5_CMD_OP_QUERY_NVMF_NAMESPACE_CONTEXT = 0x728,
+	MLX5_CMD_OP_QUERY_BURST_SIZE = 0x813,
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS = 0x819,
+	MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS = 0x820,
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS = 0x821,
+	MLX5_CMD_OP_QUERY_DELAY_DROP_PARAMS = 0x911,
+	MLX5_CMD_OP_QUERY_AFU = 0x971,
+	MLX5_CMD_OP_QUERY_CAPI_PEC = 0x981,
+	MLX5_CMD_OP_QUERY_UCTX = 0xa05,
+	MLX5_CMD_OP_QUERY_UMEM = 0xa09,
+	MLX5_CMD_OP_QUERY_NVMF_CC_RESPONSE = 0xb02,
+	MLX5_CMD_OP_QUERY_EMULATED_FUNCTIONS_INFO = 0xb03,
+	MLX5_CMD_OP_QUERY_REGEXP_PARAMS = 0xb05,
+	MLX5_CMD_OP_QUERY_REGEXP_REGISTER = 0xb07,
+	MLX5_CMD_OP_USER_QUERY_XRQ_DC_PARAMS_ENTRY = 0xb08,
+	MLX5_CMD_OP_USER_QUERY_XRQ_ERROR_PARAMS = 0xb0a,
+	MLX5_CMD_OP_ACCESS_REGISTER_USER = 0xb0c,
+	MLX5_CMD_OP_QUERY_EMULATION_DEVICE_EQ_MSIX_MAPPING = 0xb0f,
+	MLX5_CMD_OP_QUERY_MATCH_SAMPLE_INFO = 0xb13,
+	MLX5_CMD_OP_QUERY_CRYPTO_STATE = 0xb14,
+	MLX5_CMD_OP_QUERY_VUID = 0xb22,
+	MLX5_CMD_OP_QUERY_DPA_PARTITION = 0xb28,
+	MLX5_CMD_OP_QUERY_DPA_PARTITIONS = 0xb2a,
+	MLX5_CMD_OP_POSTPONE_CONNECTED_QP_TIMEOUT = 0xb2e,
+	MLX5_CMD_OP_QUERY_EMULATED_RESOURCES_INFO = 0xb2f,
+	MLX5_CMD_OP_QUERY_RSV_RESOURCES = 0x8000,
+	MLX5_CMD_OP_QUERY_MTT = 0x8001,
+	MLX5_CMD_OP_QUERY_SCHED_QUEUE = 0x8006,
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
+	u16 op_mod = MLX5_GET(mbox_in_hdr, in, op_mod);
+
+	/*
+	 * Currently the driver can't keep track of commands that allocate
+	 * objects in the FW, these commands are safe from a security
+	 * perspective but nothing will free the memory when the FD is closed.
+	 * For now permit only query commands and set commands that don't alter
+	 * objects. Also the caps for the scope have not been defined yet,
+	 * filter commands manually for now.
+	 */
+	switch (opcode) {
+	case MLX5_CMD_OP_POSTPONE_CONNECTED_QP_TIMEOUT:
+	case MLX5_CMD_OP_QUERY_ADAPTER:
+	case MLX5_CMD_OP_QUERY_ESW_FUNCTIONS:
+	case MLX5_CMD_OP_QUERY_HCA_CAP:
+	case MLX5_CMD_OP_QUERY_HCA_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_OTHER_HCA_CAP:
+	case MLX5_CMD_OP_QUERY_ROCE_ADDRESS:
+	case MLX5_CMD_OPCODE_QUERY_VUID:
+	/*
+	 * FW limits SET_HCA_CAP on the tools UID to only the other function
+	 * mode which is used for function pre-configuration
+	 */
+	case MLX5_CMD_OP_SET_HCA_CAP:
+		return true; /* scope >= FWCTL_RPC_CONFIGURATION; */
+
+	case MLX5_CMD_OP_FPGA_QUERY_QP_COUNTERS:
+	case MLX5_CMD_OP_FPGA_QUERY_QP:
+	case MLX5_CMD_OP_NOP:
+	case MLX5_CMD_OP_QUERY_AFU:
+	case MLX5_CMD_OP_QUERY_BURST_SIZE:
+	case MLX5_CMD_OP_QUERY_CAPI_PEC:
+	case MLX5_CMD_OP_QUERY_CONG_PARAMS:
+	case MLX5_CMD_OP_QUERY_CONG_STATISTICS:
+	case MLX5_CMD_OP_QUERY_CONG_STATUS:
+	case MLX5_CMD_OP_QUERY_CQ:
+	case MLX5_CMD_OP_QUERY_CRYPTO_STATE:
+	case MLX5_CMD_OP_QUERY_DC_CNAK_TRACE:
+	case MLX5_CMD_OP_QUERY_DCT:
+	case MLX5_CMD_OP_QUERY_DELAY_DROP_PARAMS:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS:
+	case MLX5_CMD_OP_QUERY_DPA_PARTITION:
+	case MLX5_CMD_OP_QUERY_DPA_PARTITIONS:
+	case MLX5_CMD_OP_QUERY_DRIVER_VERSION:
+	case MLX5_CMD_OP_QUERY_EMULATED_FUNCTIONS_INFO:
+	case MLX5_CMD_OP_QUERY_EMULATED_RESOURCES_INFO:
+	case MLX5_CMD_OP_QUERY_EMULATION_DEVICE_EQ_MSIX_MAPPING:
+	case MLX5_CMD_OP_QUERY_EQ:
+	case MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_FLOW_COUNTER:
+	case MLX5_CMD_OP_QUERY_FLOW_GROUP:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE:
+	case MLX5_CMD_OP_QUERY_GENERAL_OBJECT:
+	case MLX5_CMD_OP_QUERY_HCA_VPORT_GID:
+	case MLX5_CMD_OP_QUERY_HCA_VPORT_PKEY:
+	case MLX5_CMD_OP_QUERY_ISSI:
+	case MLX5_CMD_OP_QUERY_L2_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_LAG:
+	case MLX5_CMD_OP_QUERY_MAD_DEMUX:
+	case MLX5_CMD_OP_QUERY_MATCH_SAMPLE_INFO:
+	case MLX5_CMD_OP_QUERY_MKEY:
+	case MLX5_CMD_OP_QUERY_MODIFY_HEADER_CONTEXT:
+	case MLX5_CMD_OP_QUERY_MTT:
+	case MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_NVMF_BACKEND_CONTROLLER:
+	case MLX5_CMD_OP_QUERY_NVMF_CC_RESPONSE:
+	case MLX5_CMD_OP_QUERY_NVMF_NAMESPACE_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PACKET_REFORMAT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PAGES:
+	case MLX5_CMD_OP_QUERY_PSV:
+	case MLX5_CMD_OP_QUERY_Q_COUNTER:
+	case MLX5_CMD_OP_QUERY_QP:
+	case MLX5_CMD_OP_QUERY_RATE_LIMIT:
+	case MLX5_CMD_OP_QUERY_RDB:
+	case MLX5_CMD_OP_QUERY_REGEXP_PARAMS:
+	case MLX5_CMD_OP_QUERY_REGEXP_REGISTER:
+	case MLX5_CMD_OP_QUERY_RMP:
+	case MLX5_CMD_OP_QUERY_RQ:
+	case MLX5_CMD_OP_QUERY_RQT:
+	case MLX5_CMD_OP_QUERY_RSV_RESOURCES:
+	case MLX5_CMD_OP_QUERY_SCHED_QUEUE:
+	case MLX5_CMD_OP_QUERY_SCHEDULING_ELEMENT:
+	case MLX5_CMD_OP_QUERY_SF_PARTITION:
+	case MLX5_CMD_OP_QUERY_SPECIAL_CONTEXTS:
+	case MLX5_CMD_OP_QUERY_SQ:
+	case MLX5_CMD_OP_QUERY_SRQ:
+	case MLX5_CMD_OP_QUERY_TIR:
+	case MLX5_CMD_OP_QUERY_TIS:
+	case MLX5_CMD_OP_QUERY_UCTX:
+	case MLX5_CMD_OP_QUERY_UMEM:
+	case MLX5_CMD_OP_QUERY_VHCA_MIGRATION_STATE:
+	case MLX5_CMD_OP_QUERY_VHCA_STATE:
+	case MLX5_CMD_OP_QUERY_VNIC_ENV:
+	case MLX5_CMD_OP_QUERY_VPORT_COUNTER:
+	case MLX5_CMD_OP_QUERY_VPORT_STATE:
+	case MLX5_CMD_OP_QUERY_WOL_ROL:
+	case MLX5_CMD_OP_QUERY_XRC_SRQ:
+	case MLX5_CMD_OP_QUERY_XRQ_DC_PARAMS_ENTRY:
+	case MLX5_CMD_OP_QUERY_XRQ_ERROR_PARAMS:
+	case MLX5_CMD_OP_QUERY_XRQ:
+	case MLX5_CMD_OP_USER_QUERY_XRQ_DC_PARAMS_ENTRY:
+	case MLX5_CMD_OP_USER_QUERY_XRQ_ERROR_PARAMS:
+		return scope >= FWCTL_RPC_DEBUG_READ_ONLY;
+
+	case MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS:
+		return scope >= FWCTL_RPC_DEBUG_WRITE;
+
+	case MLX5_CMD_OP_ACCESS_REG:
+	case MLX5_CMD_OP_ACCESS_REGISTER_USER:
+		if (op_mod == 0) /* write */
+			return true; /* scope >= FWCTL_RPC_CONFIGURATION; */
+		return scope >= FWCTL_RPC_DEBUG_READ_ONLY;
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
+	void *rpc_out;
+	int ret;
+
+	if (in_len < MLX5_ST_SZ_BYTES(mbox_in_hdr) ||
+	    *out_len < MLX5_ST_SZ_BYTES(mbox_out_hdr))
+		return ERR_PTR(-EMSGSIZE);
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
+		rpc_out = kvzalloc(*out_len, GFP_KERNEL);
+		if (!rpc_out)
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
+	if (ret && ret != -EREMOTEIO) {
+		if (rpc_out != rpc_in)
+			kfree(rpc_out);
+		return ERR_PTR(ret);
+	}
+	return rpc_out;
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
+	struct mlx5ctl_dev *mcdev = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&mcdev->fwctl);
+	fwctl_put(&mcdev->fwctl);
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
+MODULE_IMPORT_NS("FWCTL");
+MODULE_DESCRIPTION("mlx5 ConnectX fwctl driver");
+MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 0bec798790a67a..584a5ea8ecee11 100644
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
index 00000000000000..625819180ac6b8
--- /dev/null
+++ b/include/uapi/fwctl/mlx5.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
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
2.43.0


