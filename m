Return-Path: <linux-rdma+bounces-8070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21290A44091
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A672442F56
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FA26988A;
	Tue, 25 Feb 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ugg2uZBP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CF2561A9;
	Tue, 25 Feb 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489384; cv=fail; b=n6VFvlm9b0CSrpCLu/pInugp3cF2aCVBIwccwuueq/P1JGSitKS6ByodCd++XYFeghKSrOIusUcB1QC8+Lr6YbTnKo+Bdx0UpH4Zu2xLsVfC6URhJbe/X1p0Dxt6mvUesBDCzvm6rDyJUWeumA4kqVR9pNfLZakElvHStnAu82k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489384; c=relaxed/simple;
	bh=7QXjT42A4PydWQbXmt5K685SUNGb7F1MstaHakom/Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3PcO7eMzcYh0/alE5yNftmLkBhWqEy2+z99NTQBF5++6hm6hu7JeciFUGuwew8yE1npodbCVwrVq4PyxQTj2CShB+QfH5ogbSfIEyzCa4vamoEBPPoCs2vGfeh/6FOW15/V0DWO74Lvn4gTDDNwUwTNDxLCNONWdWGwiCVdpVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ugg2uZBP; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSJsA8EP2HiswOC5Ni3hJgmRwwct+6ReY0nJsjhojXKeDnDeAWLRBeAACDlL8IMJt6GfeRFWQpQMUciNTeIpT8e0iDKdXg9Y6x8mMVilitclUcDQeaVbxGAVBeanwJwtdKBPBaiiEU/XlYxq1rvqz3BDy0SGkn5ZSleNbze2Byoo8KNNOwloPdYhhIE72K72KssvMXKnGTFmZpUURAARV8M6iHFGWex2y8g8nuVSHkWdJWN/oz2kdj86cZ5A2xndk2LFEbTrvbBtOcqNXpUXryyPg9yvjAiDipEzp10HB+bjL73e1/M9fBN7VWkwAo+MBV2oMBEIXiSN7JaBpWswuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+ZYsHxlCS0huX6FePriubVzvID2XO1zOJ6fi7rVwuE=;
 b=rxcubyhKeXDj+xvKP3UXV8b6Qs/EmYPnwQTdkfR9ihovc+wQj+cc4tpb7DW3It9ycXwQR4J2rMCDoEPZjvAQO791vf05fPuTuJJpmBr3L3npUkoEyQCU7fHPobH+GI/W75gEaKuY2vmDd2hwwlecBe86WaL3hMQN55ar8dwskXW33DOvKKcn4gOq3Td5vEDY+9H7T04oOKjN+XLYjSzXH/K5sB2R3h2HAEy4Slzsfwu+YdNwS3W2FaiWg71+EmRNU8V/2R2QSBLIlbdomkZBeZzSt9YSb26b1UaWI4sVFnn4Eg/tzOfstF+cXTeXe8riab9BhVaE0LpG8GmmNv6Rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+ZYsHxlCS0huX6FePriubVzvID2XO1zOJ6fi7rVwuE=;
 b=ugg2uZBPf/e5YPG73+KYTEqqhqfMWtyWjpIjLBqDA2DPN0w/8SNE80jrur4Naa8PwWVEoBufZm4mKg3J/oidr7KSR/s/iYuevb99NSszgsKMQWH6amnhVrOoS+9BLaLUnaTfWXM6Xykd381QFnqTsqCm+tiVyDgV+5VNjn5i3NCkIlSMZP+NUHU7qIJRHgQlCSwQGMd8/Vi0H57s7Qr1Q8k54k2G3QCo8q0EoYdY5AXy5lxJIeIiN2wZVrVJ5W25mJa4RUsUoDjIEIEs+pt7iwhszuQlMuRpjASG1yblsEt560n4cGah2wQs0TVVFNQ1Y4l1P5cfYLTKXAYkTXQs9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 13:16:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:16:19 +0000
Date: Tue, 25 Feb 2025 09:16:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Parav Pandit <parav@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <20250225131618.GN520155@nvidia.com>
References: <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7z_NcGWIr3_Dxtt@google.com>
 <20250224233004.GD520155@nvidia.com>
 <Z708JNt6-vPIuDBm@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z708JNt6-vPIuDBm@google.com>
X-ClientProxiedBy: YQBPR0101CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 65591ffb-4352-4d5f-eb65-08dd559e9777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfyR1VQJnAePhLtdaFy1Hd/CWq+1ZaScuVqdz5P81a2Vmi28YAPUjdwscp44?=
 =?us-ascii?Q?2HiGVR72atWqqydxwijHOyrDxTa4lXSI14p49i/IcJM1rpLPn06EMvCDjzxX?=
 =?us-ascii?Q?Th2ma6hzoSRNVRD4QBrp/nEch+6QyWQ6wrmEwJrOtFFjCjoRqmIaOSnvm26K?=
 =?us-ascii?Q?UuTPAa0Pagfv5HJrgxEctyrI56QaNiekubVkTfXv28jHpLunaW7MXMuDgE7r?=
 =?us-ascii?Q?TEkiSp6/Wk9mQVyrgBW3uYEICd2HootSAuiRS8YJma0nNlgb8egkCn0mvpHP?=
 =?us-ascii?Q?D4iIgfFtOQBTIHgzAp9MOa+32SfJVP1mEEFBkMj6XzA1hQghW17Urz/a+csM?=
 =?us-ascii?Q?h9Ix1W3irCg8nRSwA5mu22q0dOgUnlL9H7IG//Xr8Aa1NvppyAmNl71/e4SA?=
 =?us-ascii?Q?kXqC2Q+E6fIDXqTx96cLxEYfbhveaCPbGGFA7wCi4PmKmNYwdJN2u/VuZtnO?=
 =?us-ascii?Q?9UFj3vE3SwTr7uy+y8gZzikSqOOrnlhEbBJQxnimKzK22fRwPhtvMcWzIyah?=
 =?us-ascii?Q?PhH5yOLVFI1eGe6DwjFapl2e9llfZ6Brg/manTebvtByYzSqrx3uDZlddIRI?=
 =?us-ascii?Q?lrTE5bDcli5ihqdVB5xQh3RzQnyq3SMJ7LMvuaMESqmrbPSqrHlKZxXYPehl?=
 =?us-ascii?Q?11zBvqAVgmMCvZJERX0dXc0G1x7ZE7re+yqc/g61U0FYbI7k+3tD/FVUVe3Q?=
 =?us-ascii?Q?FkVVk6ASMKcY1Yp1g3TPnRZWKLYe+VBYtl6IXz4MQIKvrJUozIQOxc3MhAK9?=
 =?us-ascii?Q?viO7Iq7GjlrKLJUEM7Q15/gzyau032el+dUtX0Tm6Zw49ctyHbYSiVsPW31d?=
 =?us-ascii?Q?AFP1O5PhRSUGJVIBU6QRM0Dm59X9ucq1gyzfdErDfYHdyrjdKS3TFMD4xPyq?=
 =?us-ascii?Q?PNOQzJEAU2C62YVLokpIjQAUSo5bRAo7KQv+TINqlX7cuNXha7qQ6E+zhpcT?=
 =?us-ascii?Q?5EwhGUEGC0sxG3F52ThLaAjTBQbtSw715Rhkbkj6tA9zO6H+zIP9fDzO9c4L?=
 =?us-ascii?Q?t+/3D7nmlSEIOpufwVU4jM6ydVQVy5CcbqIJDAUfYUaj895Pido0BKDx4R1H?=
 =?us-ascii?Q?kPupfyMnwsvSOoYrn/SCOtGel/V1R7hlzKZ32WJRpJdxF/3DeudAqruxRvzE?=
 =?us-ascii?Q?BLQDltYzJ/WlfjuHPWQFA5Y6zd63eP55k2T0r/2nJzqR1F3OLfJCD3/WOm63?=
 =?us-ascii?Q?QQJ3NodPkAOXShekr9o9g14jLBAScJKcH1vsdcji04rUBQALk20e8cQoBTwR?=
 =?us-ascii?Q?qc2vQwWVqcXsMe81DaOiqR3RzWggUGWZ67LG07ZyZ6Df+Mt0tMDm3FJ27LrU?=
 =?us-ascii?Q?iFpMBUa3cGzJgM06bnql+K/1o3Z6NbHIETLazHnYcaZg/MN6dNiEe3IEEDyL?=
 =?us-ascii?Q?z4m7qe7LP1qJ4IjztZxBjz6w3S87?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pI1kBPU05yM89vnd54mlC0VB0PTWgaUdM+y3rRD6t3UG1yPp6StJo5EPqWyx?=
 =?us-ascii?Q?TOf8F8Dh0Z1iaN2uRNu3obFFVw1yeUBfUMyluB0GGYyrYwcbuw/yILSpDlK9?=
 =?us-ascii?Q?sVy9RD3ILkiQas9k94+HpEQdz0PuhkEVgsuXllXlkY7URFipUBE9Hyx0vH24?=
 =?us-ascii?Q?9FD06oEHErBmJcknE4xgCZQBV9aJkSSRG7QTjIzYIO3SnJv8RER5esAx5Z4i?=
 =?us-ascii?Q?cxCjCFoDJpq7kGCD3jlxDL4OK5HiF8hm3tRn4E95M35WxDkgiG4m3SQZxkB6?=
 =?us-ascii?Q?p90kmOOc91+qOVUKH/odoBYwG/Se5gHR1EYvSJFz49+QRVRm3nb0Al5C4mkB?=
 =?us-ascii?Q?B2+07y0PoXfdwb0iad4rDMqC/jK2RpCkk8snMhT/NTRyNmNNRbOe/uNXyP/+?=
 =?us-ascii?Q?azuAiwna6RruQNaqt/ZOwhJm0RduFFgvqpT8n3NtkwFdgowZ6+3qCx4b8Cdk?=
 =?us-ascii?Q?Tu7SSu0xbYpjwDoOd9Ojh/OOUv6XFwRHQtsyPjE1PQEfHGkfo7PLjGcQPA6a?=
 =?us-ascii?Q?0lR4XyfALFeohbqMCiHjsmYFqR4NrGI9hcMval6IhzZ7KrRj2kGZrCVvUH3e?=
 =?us-ascii?Q?QBoQxtpoFcuCpQpfL08EAagn6I3yNAu0iYsGQOt6c+7bDUhB5xuYeIJR6nFw?=
 =?us-ascii?Q?ne47duO/9nUYh8u512+gzgpd8LxpTTZ0yihP5DFBQT5F59K2U6/ETBXjcN+4?=
 =?us-ascii?Q?mIqxN4jfYHzTDBn9oDiKUPkhFxPEhoTkGueRGt4efsqLbYElDHaT8YkIlzSq?=
 =?us-ascii?Q?SBagO4uH04WsRuAM+lG2epTMlTTIhsATUuLyLp/gfaf+umZLGj+Rejbu9Fd+?=
 =?us-ascii?Q?hGfL+9pbUoaYDpUDKW9VZxXnPe97LUu+3k1GAYdRuifEZFK/HZA6xbDXzKs/?=
 =?us-ascii?Q?d1E7NJ8UhIvbglwZhoCDsX63EV2L5iDEXf2s3PJWRyktClHHihoCxGOslAIP?=
 =?us-ascii?Q?/+ipgO+IieLMeVZtDNykClcJB6grVhFLG5NwyfXcazWAhsW19I4EkY/o4MRy?=
 =?us-ascii?Q?2nXd4g73NWzKjinVh0KrCiUxI48Gh5ACUrAJjF2Qm5W3ZEGowFbjobYg+X3w?=
 =?us-ascii?Q?wsrXcNu9J1IH4v909U+sDwItZdDn/wN2Du+FrE3ZVR6v9J4CStO6BrqWVoSP?=
 =?us-ascii?Q?Hko23rTIT1bJ00GTYqeu2SLrCMIjbMo5LUVX4WVQUUOJJFZ5UkdoXDIp08s8?=
 =?us-ascii?Q?Goev2SkFXwDnUBR61QYA4paVPqw/5pAysTwdkRiW0NFtGvATjclXxKK2+AzI?=
 =?us-ascii?Q?loYXwTicsllCMRv8vIh7CHYxg+b1VXCofpqL1E9TbO8oO3ReKI9KM0JICeTx?=
 =?us-ascii?Q?8FunbOV8/6qKPLt/Y8C0OoqSyl9Fn0ZQm+xjJB+zYNJob3ayfMX4kjvITCjE?=
 =?us-ascii?Q?Uk9cFK5aEEcm2U29jjeUKdEhnyGt4HB6JQhlvYEPfIUHaBdXQIgR7YzSOLHo?=
 =?us-ascii?Q?Qpx7tcP8HkATIyA/8zwyf3znaoBOPDdA414DQG3yc18ZWYcum78fl4xLP+p6?=
 =?us-ascii?Q?Q++qiAvJjsIcvsyQkCBWz3GWuklgHqXMbu8EUNjyyfqM27cMp0oHDhTLr4ak?=
 =?us-ascii?Q?QJMXk7PZj0JJkeGcJH0bQrA5xMymuvS8o+YxrqUm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65591ffb-4352-4d5f-eb65-08dd559e9777
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:16:19.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i17jD76kXKmSAVbF0Uzu3ffiafRPO2HZkVFFhL03DRnRC4ODic0S5Z+BX7nF1/IO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489

On Tue, Feb 25, 2025 at 03:42:28AM +0000, Roman Gushchin wrote:

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 0ded91f056f3..6998907fc779 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -956,6 +956,7 @@ static int add_one_compat_dev(struct ib_device *device,
>         ret = device_add(&cdev->dev);
>         if (ret)
>                 goto add_err;
> +       device->groups[2] = NULL;
>         ret = ib_setup_port_attrs(cdev);
>         if (ret)
>                 goto port_err;

That's horrible - but OK, maybe something like that..

Does it work? Or does the driver core need groups after the initial
setup?

Could we have two group lists and link them together? IIRC there was a
way to do that without creating a sub directory

Jason

