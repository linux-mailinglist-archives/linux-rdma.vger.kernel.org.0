Return-Path: <linux-rdma+bounces-7493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AB4A2B702
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D531889A37
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7B17C98;
	Fri,  7 Feb 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hYibpmay"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50224946C;
	Fri,  7 Feb 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887228; cv=fail; b=qL0LoR/TXITgJPzm2rrRrM5umXExXTf56Rfed5E56uqwSz19rEYmCXXgQzR811WwmDLixUWP8cu3IaU4p7ridYCrmYjIfDBovtFwGEbYUanH4U3uqm5oQceRjlMconJJboJsKTHgjCwSWGVpLuXurUmUPzJ0W8rgDIn1ARZEfF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887228; c=relaxed/simple;
	bh=aDrk1SaJR7KL8I6U8EJGqJZMhdi0Cb0i4GsGerjDyPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQHnvPnvOpvKN0bnirwqo1F+WVL1ARCCO5rCO+Z07K+sawmgGrcNrIP6L2zr7loyyvyIE4kJM5MhmHUBRXllqHSh38XQ729fW5aIYEIocONu79MtuvMPyt1ZXXFguHgB42rCdjAfwKg0/IkEJW9abNkB018fCLebJLdYNLnitvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hYibpmay; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByNqjGeHfWkxBiwdM+L8uL17QymLQK4i9RS65ZgMu9utNS18rMH5vEKlPDYowwfL8I5CZ8l5V2ryInNZcHAD6nsaJQznC4QcWu6QhBbIq89bTmHxK6SW8WaJbZehaFx5jT6WLNSAF/p1vHAIY/YTxhsVzGdEM2ZmEzjvxKLJtZpPcVsg4a0njhVD8C4eaI/XLG/bkrMgYaYKOjWloEbX07RK1/ry3L49TXWe7plhhM+TWx5pHe3SLYLj2xGBCOXr8Y1btSWONSa4HH+r8QWdMXjH69Qk/iiopChC+qX2dBybA/Twk4xctvXVK5j3utkNsnKTtePHYY4imlqt8HyPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DRzcY/eV1Kr5v3NGIt7skRt/jpJjZ/tcomYqFv+Npg=;
 b=FWlz2PvgQrALqwb3KY4v+F9LuuwJBfatgMPk6MiF++lNV/KQESi/IanI8LhSQGkIAVs8WJBp939+Pqx+SB+Z+aACSssp4PlaQhi46i4Ba0X+KtXQ5/bCDgRkaw4dKTkDdXfU+1UISG6WIkq0TIAuObu3twRijsxtE2YbU+3vlaV2HQRVs1DqSvqp+05EwR/QlNk+8fTZKqMY60R24m91wp2eGsUEMFD/YEvgICmhS9rBZ7okHTiExtbac1TlgT5M9S0zzVqeTYjdEAnrcdZTuz4VEMEidto7u63f9xk/3o7SEsv1HhU7lVtfp0VBFPlQ1v/qeb1NNoNolh+QIqcXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DRzcY/eV1Kr5v3NGIt7skRt/jpJjZ/tcomYqFv+Npg=;
 b=hYibpmay5EmWA07Eq8ZS5W/2FoPwwagl5Pcwl/Kj4F4evY4kNdYTtKDTwsDZ1iNv/hwLCiZVKEx/i2A7tCsBFbDwvz0EE0NdUW8jXE2tqzl07itDU6bjUIwp+Q33QqHgVOLqo8P7GGX1SWW8baFIFqxxKxwUAZpKasRtWD398xj8+2NH2NFTCFGKtQmg0HPB4LSPnQOpLPjCL8jawB50NtgynU3Fbt18rlDtuRy7lF8rRrbgzweXqha8OtN1UNhAE3Wj8SEmI/I2kkb4X94ADL88ZIn9+mkQtHMeFyD9KDHxUYgQs0K1hUwwNTD6oWmLLDOt4VsKzRRUsc0f4EZSBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:36 +0000
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
Subject: [PATCH v4 07/10] fwctl/mlx5: Support for communicating with mlx5 fw
Date: Thu,  6 Feb 2025 20:13:29 -0400
Message-ID: <7-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 713b4436-cc91-43c9-b0bd-08dd470c42cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pFezowcJwYaAfnudokNA+r6/0l2aFgyQxl5uqsAProIeV4NepBJcZbu1k3m8?=
 =?us-ascii?Q?3hV7lbrKn7SFh0dUlwmiGe7IMyNE/vXzDp/7thX8Clnn4HrPoFYVF6A1rMJf?=
 =?us-ascii?Q?FvYDvdAb3+W37P65z2+240csL/Thr78wozIBaf2EawyBtQFpbm6mE2D5sVr4?=
 =?us-ascii?Q?wqMQVwzh9G2uP9/XXkd/e2DEPBMd41FmjY6GmAj7bQGeyYgbqY+BE8ytacpe?=
 =?us-ascii?Q?N9UEzVyV026G+KOWoPXZ5ca/ostxyzI11tblXzKowHW7ZjJHB1IC8jKbejZI?=
 =?us-ascii?Q?BORz6gzDYSkXbVh53bA0DzNLETDLDFDF3CbEUvyYB8F30ZabArCpMjrrHV29?=
 =?us-ascii?Q?al7NAJTVxTxQY9TOBFnhwZ58I+R/2mtAJOQ672qjoNHyPuqvHZUPIhrfDpSh?=
 =?us-ascii?Q?6M61oqkNLfasDOVkZ+Qn8QH0dElOSflpYMDEOop/itlK6p1tH1ecTq6wpBZO?=
 =?us-ascii?Q?Wgjot6A6jkdd02elevEVHmSXLkBRGvIMZYrxw9afUhXxUdWWpzibSl8O1HxF?=
 =?us-ascii?Q?Gt31PuRz1vUUhM6LDPgkyl9EiBMF6SF9NtCkV/cPKRlkRLe3pM8OB3n8AvrG?=
 =?us-ascii?Q?wOiHDWthnD7FBUY64Dvy0QzpIokIdGjGbPxZP7V36qhCRwT6Y7arpMhHAWFi?=
 =?us-ascii?Q?a2VkbMZdiRzRk5bqJ9CJjVGeBP0Vkk9w3VXoBHjpGoMIY6N73N2HASYYBCOJ?=
 =?us-ascii?Q?uNnYluGxOshXbhqP0vuoqH60uzhUj+lqkmQLK1uNIVNiMcMiKUChsd5UHNze?=
 =?us-ascii?Q?1tdsu8y4cWvnTNCp2bwCbBS7VJQpqS63DUTUVTAvpEMUFPFnDeZrRLsQXT+h?=
 =?us-ascii?Q?DzGdlwmuYIh6qraxpIkxMX07Fg6E3M2MQNbKplAAAsO8Q3L/aRF3cEEUNxry?=
 =?us-ascii?Q?vqG5S6P2YKkxG/wfth4Kyd0pey8SWRqXPZ95KQZVv5/ZiFVmELx8mPJu077D?=
 =?us-ascii?Q?5Eg8e3pKtBg7aqu69fuL88VRV+Z8aNsLWOvcZXZzxvU6pgoa+Kg48CHH3g+W?=
 =?us-ascii?Q?pDYls7Rh55bSu1OWkLq8izKAWPGNg0M6e7GGITsn5K92lLJf0O+mrALDMMs3?=
 =?us-ascii?Q?hB5yMhZQFuk4BILh9BEWVZPHM8orqmmfDSfKxZks+dwKs3EPyUaKKdP9MFBt?=
 =?us-ascii?Q?qYUDdppWHTHOb8Y2Ad8r8XM1hk13OHZgcZKyW5cV+48wL3kdw3MpS+ojQdyB?=
 =?us-ascii?Q?5NU379WZ7UG3RKnJAALvlkYuTfoViWjyAzH2nlUdQImj/bOX3Z9GkvzWZh3u?=
 =?us-ascii?Q?9w9eMEy3GVqYP6TLhG9DRjvIXiGCnQ2lFxo+/HuURBkviAKsVicJ6dOVKGyx?=
 =?us-ascii?Q?d0OvBgNtLysUqBVnO+g8KDWvD6p5NHqLCmysPw9U9jA6WvfS8vqepGPETk5w?=
 =?us-ascii?Q?YCIeH3wpr5Q3yEx7Qt1eeWM6XQxr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wVLRoQrqHXiQVs9S66miJBKufN/qiFLaMzr/O7loVkxRHRRt9/A9Bx1x/Qf3?=
 =?us-ascii?Q?krQY4VCRz/vPLIDSHDZpMoaP4+iKYASD+lA9eKj809EILdfEY/ftuHNC/2Ff?=
 =?us-ascii?Q?LHDKci9gOoDNwC95R07DK9QbT09/YRchIX8S0UP9os2EVB2jHZrHkJ6Kt38q?=
 =?us-ascii?Q?iQaKmb31coUN/0hsCO3hCJgvthDbmd3GeSKc0KGjK2yY9mAUZl3wkiP3ywOM?=
 =?us-ascii?Q?wuyz6zaHg+iGDUipVjSUXbbyHRulpcbyV21qMTr3fVAA5wIAG4UBdk8IACzO?=
 =?us-ascii?Q?C77WLecpQkXX0F++tR18UhQOPC7QROF3i56dgZKSj1WZJVUDaUfQyNuIoJBX?=
 =?us-ascii?Q?dbgAqoAldV3yUMsQYWPPv6WolcTwYX5LV3MJZtjgJ/YtgNLY9Gkx6ftWBPQg?=
 =?us-ascii?Q?6MvRJqkvBh2fBxBdEUbTmeqmGDfedfE6B8dRBzaVZyQbjeTGOkT7gfWLjVAW?=
 =?us-ascii?Q?r8P2q5TCbmWIkqvDNDdNoKOTO3x6d+fyUJFN+koDd1Bmk8lZhFKdyEQzh3WG?=
 =?us-ascii?Q?y1YALmpWWtewkRSH23sjQQ+RdOIRyF+vIwNxC7mjEW8Zxisn8/FemtHR1kb9?=
 =?us-ascii?Q?CR/OMvaJpj6PNQMRsz2CfRWJ7g60LwdMK0u9P/3MA0RMAcwxhwKcGs48yprF?=
 =?us-ascii?Q?zmvgVAPayax6/QjIijD4Wvk/v5zNs55vRIxEDMjlcNBMZyoDw5d6u4oEDWD0?=
 =?us-ascii?Q?W8HSe+sn2C6Pd2WA2nrbSAmaDGbH8HRPGpFWI0YOt4vP3YLvm/LNgLOo3Kug?=
 =?us-ascii?Q?7+wL9CGReERWYMT55QX6fC6EgFIvTNVjQ5Gyd6NzSZc1pPFV+QXkjAW6Wg/v?=
 =?us-ascii?Q?XaVz+dsJycdRZP/2gn111+JiyGrCSN0MLxYr2rGozc1Xyx9pjNEMYOlpbdY6?=
 =?us-ascii?Q?AlVa1uXg+LPx6bolN2LZE8ftD0514UL2HjVCeWiL1GXDPiBsgONQ83GmX4Ao?=
 =?us-ascii?Q?LXBklh3ODW+AlrpwlgOD6d7eBFYk9SQcyU4SDiDdKvh6xaM+uLu/1QONjypF?=
 =?us-ascii?Q?/60fLnmOk4OIrY+N8xsw8wTJ6ppSP8pkJ1zA52+yAmoH/26GrwR3py6NMah2?=
 =?us-ascii?Q?w/++CtgHldIZBaZ1qJH9yd0z9jyvEskp+rv389WwnDSvDrbJAvnvijaofBKW?=
 =?us-ascii?Q?QwBB+fbxrd7lxXipG4n67ciNSYxgnlFI2hXVRSNiddD34yhIq4SMAeuUzx9U?=
 =?us-ascii?Q?QYPyQ4CxpWjOIXTGAV1PZchfmbY+OHtJDUaS2WwJbuoSnswIwIJIeInNCO6R?=
 =?us-ascii?Q?uflQk/l5mVjJ8ceS/Cjwx4NZmw6R/SpS6qXZCItMycsIa0ujTrc8tA9WhX7T?=
 =?us-ascii?Q?HRx+KKv1CxJz7L1WM3Sxc+0iAZEkr8ol8pMeLofbYeeV/DgI58M1xjeKYQ7k?=
 =?us-ascii?Q?6lPf/zRzajZgsm9vmqHGw+NVy+zsAa+AL6+l5B1ET727RJ9YjMpIGemJgE1Z?=
 =?us-ascii?Q?HN/0RrmQhSyhgLIyOQ3liubbDwePrNFsbeAALuOekk4WOOYSSiInJnhvt3Tb?=
 =?us-ascii?Q?y3U+917OZX5HRFa3FgKOrY5UM4hUBs3NY7ck/veq49xTGWdisY8ntXk4lbf4?=
 =?us-ascii?Q?lb0GSRsaihYw+8uzOzfLNlW8JV8GANydWOeXjBp2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713b4436-cc91-43c9-b0bd-08dd470c42cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:34.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OdCDkScXzzjRW/Uet+nZZl6R/jeNBnDR0rq5HEtDP1m7btvHBCcNJq1xk8WlpUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

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
 MAINTAINERS                 |   7 +
 drivers/fwctl/Kconfig       |  14 ++
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/mlx5/Makefile |   4 +
 drivers/fwctl/mlx5/main.c   | 340 ++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/fwctl.h  |   1 +
 include/uapi/fwctl/mlx5.h   |  36 ++++
 7 files changed, 403 insertions(+)
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/uapi/fwctl/mlx5.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 319169f7cb7e1c..413ab79bf2f43a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9566,6 +9566,13 @@ F:	drivers/fwctl/
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
index 00000000000000..a8564bac27b5c1
--- /dev/null
+++ b/drivers/fwctl/mlx5/main.c
@@ -0,0 +1,340 @@
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
+	case MLX5_CMD_OP_QUERY_ROCE_ADDRESS:
+	case MLX5_CMD_OPCODE_QUERY_VUID:
+	/*
+	 * FW limits SET_HCA_CAP on the tools UID to only the other function
+	 * mode which is used for function pre-configuration
+	 */
+	case MLX5_CMD_OP_SET_HCA_CAP:
+		return true; /* scope >= FWCTL_RPC_CONFIGURATION; */
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
+		return scope >= FWCTL_RPC_DEBUG_READ_ONLY;
+
+	case MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS:
+		return scope >= FWCTL_RPC_DEBUG_WRITE;
+
+	case MLX5_CMD_OP_ACCESS_REG:
+		return scope >= FWCTL_RPC_DEBUG_WRITE_FULL;
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
index 7a21f2f011917a..0790b8291ee1bd 100644
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
2.43.0


