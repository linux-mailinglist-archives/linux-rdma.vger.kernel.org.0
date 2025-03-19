Return-Path: <linux-rdma+bounces-8826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00EA68E66
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6A318998C8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941511531E3;
	Wed, 19 Mar 2025 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cv5IouSl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F014A09E;
	Wed, 19 Mar 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392365; cv=fail; b=hjSImW8xdJnhqc/ZVZNyvPdq6KeAOz+l6ep6BaGqLqq25BFMnLfrXxE+5UZHVdWiFtJeAB/CbKXY6EIM2m4MibS0XtigND+dt3mxkHqm7SFmpjNsgK6h1hH1dPrR6AO6Gb+svRj2BrzMwm4GR2YyRAoJNbPqjGwLHoOfJzOe2Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392365; c=relaxed/simple;
	bh=+cktCGgSwyDycq/r0Pfto5tIJ9MzEJ6mZUPdrbYXsFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aY4/4HMd2Q5yneGOKmDh8SJfaeBUl0qqNmXzQX5J/bTGMhM43cbysXuKqE4sDPTArzyNvA1JspeLFBHtHHUnVrFFSM5iWBpfL8DsnxxTkKkI3bZY3PNPYPucU6OxPVsg5k1GxF9fM56rzAAC2ca4y9DrzfS3OFf6EAAE3aIXnso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cv5IouSl; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5as9TuJe8et2+HdjL5SAqhfOjl+GCNxnZAhNOwcakXCyvvG5QKbEbzSaNWw2mf7Ww0yozGbXB04vsK0q3uc5LdfHSx71z1E/oxMVUdIQUdzri4exTtNnQ8WbFvlQx+hIV+BBvuCH3ZFSnqGaLP61fu2FpB4/h++b71tUZ+bgLIfPpLGvyN3NE7NEWiBQCaTcy8wyeQMqesyeQTXNUtj3dIf/R/gPpeuPbVttN/CHIn/ZtHRu85zbpBUQE51/NSl+trrVo2RHDvdLNSUSYPMYbxPG+uCS9LXJpzSBFHV3a9WlB40zFmyw/M4cP6e5p+eHvGu1DfFbUl3eioikVlHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cktCGgSwyDycq/r0Pfto5tIJ9MzEJ6mZUPdrbYXsFE=;
 b=G00kHyx8ekrR5J55iGQ+MfjpektQ96Xb6XLjyWNmsRB7oUbiUM54GselwD8dqIv/SOJwDC4oYGQA9J52zN69WgIuWqZMqMpRWRZzNXIF3k/Uf2SEsswntcpcbrKPQdnpAYhZdMpwqzMkwJmvPF/AJTCGREYLOLYTOY7Y8n2qWcjoZh+ne42nTKvuN5xRPJqL6Qa1j9hPyHRgSGImzYCaDRqn+IVcWop/H5zlqD23RGnWTlzX9ry5WtNDoNKRm8OhX8V/Rw2WzSV9IMSx+3rJLkxmsududLMeIWAbAioyImmYHQGlWZP8tAQwctVXRwKBdefKYn3A8NediI5Mgx3rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cktCGgSwyDycq/r0Pfto5tIJ9MzEJ6mZUPdrbYXsFE=;
 b=Cv5IouSlC0NXhTQNuZaCnXcH366UYqP8KhVinrZO/3TCuP5d+NcjTANFN7LXPNY7pZ7XBALzC2+h6ss/cy6Y7VOFmrSAOkhZ2DY3m1g32oREY0LhBY/btRitcXrC54rIyVG+k9s0cG8WSABzyViokyVMfNg4DHxpBjcUGiLx9RjFEOxbD9AK18lELMkRkSCFkOR8f7KmPJXmHqkY2GqVZnKvX/jfThN7blBuvQgiC/wPePMtVTUKG5YqXE/UrWKYJn+9xM4ERg3qbVSlnuesbE7A43C1dAHam4ep46cG5NPvA8/QfB2ZgnfhROHCasWpAWaTbvN3Tq/Ijcv0Glh+0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 13:52:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 13:52:41 +0000
Date: Wed, 19 Mar 2025 10:52:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"roland@enfabrica.net" <roland@enfabrica.net>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250319135236.GJ9311@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <BN8PR15MB25133D6B2BC61C81408D6FE899D22@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB25133D6B2BC61C81408D6FE899D22@BN8PR15MB2513.namprd15.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:207:3d::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b900fca-3231-459d-e5c4-08dd66ed50f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Abb5fm7wWVNSoNr+3SWCLKscLuF0ukd1W0x2PXIlol6kJHTWY7jPtDPyxpa9?=
 =?us-ascii?Q?c/K97XV7Wy8XE2D2Yy+1wmc4VSE2ZfE/tWOiyvjIp8v0cm8baI8um76PK9ur?=
 =?us-ascii?Q?7A0BNePZs/5Qta9ivZj8gW/pQtwfODIh51rXygh1Qui3MURROODrr6yNKvU4?=
 =?us-ascii?Q?JoNbQbvhoo/fk2hY3/d4ZfajhHPfwXn5cs3ARVP2/rkCq2hyu8x09MXkYEYz?=
 =?us-ascii?Q?TJedulHqii7HtVtZjRmtc/ZU/dq3d26owj9kuEZc2gkJCjkgdeel0ej9/A+H?=
 =?us-ascii?Q?cZKRVCap8Vz2O2wGVThyWnJueFKk57cmGrMtgXbxCjlz887/M2ovyTh5/dxs?=
 =?us-ascii?Q?uWaMgrqh5L8j8WJvMVCHfryry1NQZvxD4rf5wslOisUX4OLVUjV7srQyFE3m?=
 =?us-ascii?Q?V0z4NfgQBzH6UXvsnk6UNQp61Gf039Oe/lowsofxAyK7ILOZWSOa7PEega4f?=
 =?us-ascii?Q?1lPC98zrKexZemna5t01OCz5mqJgZODriD+TlY4TAZdy+niuOk2Xs7B+3QiS?=
 =?us-ascii?Q?+9Kwlo0cJZakdEkjMBghx0X6yHQNDFQVfAcQscH8YMC8MeP0A8qCAI2NyZEM?=
 =?us-ascii?Q?Y7JyNGmQlFatKpbjkm/p482T9mZLb+ri5JVkkyuiV5LlG8PmDSMEWUfqsXXn?=
 =?us-ascii?Q?1NjLeyJNl+3eTzWSzEQhnEV8Vy3jjN7KM/rPyGcm3MZbMiiqgB9jzNMgZBfk?=
 =?us-ascii?Q?ykgsBuKpVxxotsJ5rvC5Xggt5mB699kKH68ugcLH0ZThYfjZ1vOT7IYGRgzp?=
 =?us-ascii?Q?xh1LqRYpe/ntYDN2exkoMM71wQ6W6GHg9BvPBxwmDBx/pwuo76hRURTQzuf+?=
 =?us-ascii?Q?PCp+EO7NGI8MmhLFvTBQUTtP+bCysYZ8DslacP51kxbzV30uKLPsxsFASblO?=
 =?us-ascii?Q?3BhgsfUfdjPIjV3+DEXx/epGyjJisc/czpPKJuW2w04cMnmavU7vstarrw0x?=
 =?us-ascii?Q?SkLEVWwnrvXi1O+G6nXTTOqfMrWnr71k3rhSOnO3QyNi9J3pkZQHf05c6pcI?=
 =?us-ascii?Q?4OOmoxFkmahTGFo8QqJryYAzK+kljNmaAU1xs49HBd/6OKhh5JxkzQKMmevc?=
 =?us-ascii?Q?NsUTUzG/fD6oqgJBMfWNah8UHWywcIlxBDBXQ2adO+tFZIajz4BQLvV0Zmhl?=
 =?us-ascii?Q?vsWb75sGPtLLeXcM9tBUONftCRufWWFbmpu9prtgmI9qEcaUi9RJ9rL4hEf3?=
 =?us-ascii?Q?4Jfeb3WOohP6Lwvc6BIjcfusmgIPV2roho5mMqZusFnAcbhGYHRz/KGFxL/b?=
 =?us-ascii?Q?BlBfM7oXjM2MB3XwRWmuhNsWxHF2UNuzK38Qay2dRIuE36UqO9hRsH29u/0G?=
 =?us-ascii?Q?jGYGPvamprUCXKWS1lAVwThViXLHYUPbnrt3o+P8AuILOTZxgMpHSLRL+8eS?=
 =?us-ascii?Q?BDY54ciIRg8nFI3uXsalxS/1ppPN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MOJLqErysOXAUkIOdjITSduz5uJNba09XGWMUS98faZLi745zEqL/dNREFt+?=
 =?us-ascii?Q?sWn0ZAeDD17hRRJr++3lNsKiB7mqdAUHtqDva5RvY1WYd53RrpXYGwdjb+iw?=
 =?us-ascii?Q?dMcsnPuXInYmmDzBSisccvMV6iCoU4rlxrbA1avTsWfqvXEKbVKzvtfyaebo?=
 =?us-ascii?Q?58aSQI5u8j6TOtPTzQKLS1O136C7D5xvf4x+vgM1MhNyQ+gBtqYx230NPDFc?=
 =?us-ascii?Q?5xG415dFjB0glZpSc7Yoiar3t3xy3UHS7GhibCc4A1DqagTTf2aw7wIQ/zrH?=
 =?us-ascii?Q?E0yg9D3vDG4/+ehGWDGp1jYvezv5fJCH77UPjkv8PB8SlJORRZh0k7J6XvbV?=
 =?us-ascii?Q?T8pY+DOVn3qhoK2FGCmorLnHk0PC6oAJM+z/EH7OFvkYIuzf/G22rchIJj1I?=
 =?us-ascii?Q?dGVeA2HsbQnC5vBZwlqWKKs8FLqfT1RHYpxZZyp/gdT01ngS5cDFL+VZJ4h6?=
 =?us-ascii?Q?zPt4EwI7TaoGiTVl+BfImdYr9oV6VK806wl1WAUxWTliAf09WFgk646eW9UN?=
 =?us-ascii?Q?XoZzhwEiSAymcqkKASs6cMIl0TDPe2d3O34VGkzKdzKnM9AtlpykGQb9ErOp?=
 =?us-ascii?Q?Z8RumW79xHvvR2TiO6zA4gjd+ZLaeLkf6har0DfAeDAX+MOKXewT6hQwDbaO?=
 =?us-ascii?Q?WLZdL9Zl+je+uiQfuDAcCN9nWXSHIjLmTCU6SgVkTdqUMYdJoZwWWMfSIvP6?=
 =?us-ascii?Q?dR0QIwKL5H7mc4Dzp2wBFLUsYTFkvJAXWUjoTrUoQACPYE6LankENl3UEpLE?=
 =?us-ascii?Q?06i59JbtuNt1xMF3b6/SE0dzxge5hkfvCzgHHEB1BUn6fQ/oD8OtNbn56UOx?=
 =?us-ascii?Q?M9v907MkmoZfXmGeiLsrcpHkPBOi3gvN7hIp6KplaC6e8bY0b9VKvynTKkbp?=
 =?us-ascii?Q?n8aGN9jB5bbFCc8Tim7ljjTwmK9GRMIjVE7sAcThLpVfL6cdtGxcVPP+JdAJ?=
 =?us-ascii?Q?4ZT92HqBXpGQE6ATx6W9iXDo/sIbxR5LRSodkYuLv4Yhh3MsybwBE0+T6mC7?=
 =?us-ascii?Q?CvS+qQ30ArhWFZENSjvQ+w7nCxWBSq4MmiazEwhgOxXOiMffzFCxgENaQoMy?=
 =?us-ascii?Q?XBWvuc97m4G59GBr26LvWA/bGaRDIxRjNcGqkNg0KN6/nmJmlGDi3cjasRQC?=
 =?us-ascii?Q?EFFjOE5FJwE6XWFEKOEf5ac7r3nntq12/X4FrVXK6cC09rwaONVRerUqLDeZ?=
 =?us-ascii?Q?sT6vZY/e+ZM68FJ64w2/cdDagCMYTVTPR6o7IjH6kyz9SlkM46qM4tKRuXdL?=
 =?us-ascii?Q?vWt+fPZAZbowZXI9tYMpEu9nkMEIaHWDrhfXU3MmXAjJkdogSVfBzfogigaY?=
 =?us-ascii?Q?pGvYE6sdX5UlhgV6RXYvhCT3kzWjDZxH/MsCTZM2Lg1glsQ/gqQ9AQmgoO34?=
 =?us-ascii?Q?JBuG2xGZ9ZlU9GyJDagO2Y/IeKfR7+enxmr0Qb9tXLfG3E3QpZ84YelxrIPQ?=
 =?us-ascii?Q?2QYtmB7diLNbi2830uDgox2zFY3MbLpK4PMdT6CJstLrp4GSilrYh5fpkV3v?=
 =?us-ascii?Q?ocwWMD3y+U6p7V7vQpgSKz1DrK8y3HlmeKcKeEjz6zQOR/RjBlnORz6DygCr?=
 =?us-ascii?Q?64kxbq7E7qDbqnNsKgo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b900fca-3231-459d-e5c4-08dd66ed50f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:52:41.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtFuG1b1M44euXfanY5S4Nad/vOcwLSemn2x1toy9nR9TlANOxQFV1J9ecMJc8/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585

On Fri, Mar 14, 2025 at 02:53:40PM +0000, Bernard Metzler wrote:

> I assume the correct way forward is to first clarify the
> structure of all user-visible objects that need to be
> created/controlled/destroyed, and to route them through
> this interface. Some will require extensions to given objects,
> some may be new, some will be as-is. rdma_netlink will probably
> be the right interface to look at for job control.

As I understand the job ID model you will need to have some privileged
entity to create a "job ID file descriptor" that can be passed around
to unprivileged processes to grant them access to the job ID. This is
necessary since the Job ID becomes part of the packet headers and we
must secure userspace to prevent a hijack or spoof these values on the
wire.

Netlink has a major downside that you can't use filesystem ACL
permissions to control access, so building a low privilege daemon just
to do job id management seems to me to be more difficult.

As an example, I would imagine having a job management char device
with a filesystem ACL that only allows something like SLRUM's
privileged orchestrator to talk to it. SLURM wouldn't have something
like CAP_NET_ADMIN. SLURM would setup the job ID and pass the "Job ID
FD" to the actual MPI workload processes to grant them permission to
use those network headers.

Nobody else in the system can create Job ID's besides SLURM, and in a
multi-user environment one user cannot reach into the other and hijack
their job ID because the FD does not leak outside the MPI process
tree.

This RFC doesn't describe the intended security model, but I'm very
surprised to see ultraeth_nl_job_new_doit() not do any capability
checks, or any security what so ever around access to the job.

It should be obvious that this would be a fairly trivial add on to
rdma, a new char dev, some rdma netlink to report and inspect the
global job list, and a little driver helper to associate job FDs with
uverbs objects and retrieve the job id. In fact we just did something
similar with the UCAP system..

Further, jobs are not a concept unique to UE, I am seeing other RDMA
scenarios talk about jobs now, perhaps inspired by UE. There is zero
reason to make jobs a UE specific concept and not a general RDMA
concept.

Jason

