Return-Path: <linux-rdma+bounces-8744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE79A64EE1
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2931C17067F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F6023A563;
	Mon, 17 Mar 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ycl+Fh+E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B1238169;
	Mon, 17 Mar 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214666; cv=fail; b=CNVFkHRk2Cq5pJWyxhT3k1aTP5PG78sdtVWNXa0WbHnkPg/H+0I1iPiHnBfVuiKLousQC2ZltLIPSlVk15L3CG97unoXPcZpz9wCwXmSaKW/BE0qlgMMFQeNVmLZfJMvJirIad87k1n4D77uoHMnVDftmVMI3xwQqEtqCfMMoCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214666; c=relaxed/simple;
	bh=cZQzG7uuToqdlR1cqbRGvlbncwJdG/T2Wd2B5ykz7wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qjpkvzIh6Bp95Zb9gd5chCvg+5sujCeLOPXQLJdXS9qMZWJ8fGb5sGWrdwyHFEtctv7wJNE7EN+CEbhVtPDsD63CfAuqZOhO25P2A5S7wLHXEQIlg0nxBwrPRmognfihtG7OY1KDGc5rUa2MU+fOpJ4IYuJzYx3RndQnoKYveBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ycl+Fh+E; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3iiPnC+XAWonlCw7xO4nRg0l1xEAfLAE83LcGIhowr0KrWMx3gId+XRUQ170Nm6o1dXxS5xlhUmjyUtF6oEsZ490++GEfX0wKWJyZ/M18V+zIUzJDQIhHVjp+L+txhVTdmpJbuROcTeZ2GZv585jQBbFanU5muOH9G0zQgDCtlVjhPsVTPmn5Ix71X+7EiQQ5+Gskxrv5oStvusv5umwzgLvzo2Njvi9ZviPeENAa7YiaPqoHDdApgtLFzwB+WgbfOHNOreEmAD0cD3laDl6BI8M3mGeFXYKbWhxTyj8pqnCZPQlLOBeAcHaFG6inDNqT6qiNRbhkMq0u4Ol9sK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QVJ/luT8uvQridkD/SgSCcmCyrxwKxJM/NJ3IYNV/E=;
 b=goTio+Krn44N3/efQqCL5sXQPZ5Uizh90BL3kfpcOPXHsobycc3GfdPle8E1Ew592x7iT+LwQxOOUJs6xPAJlYzjd5suKZ66HBNDGvA0VseaUc57Gj0UmCpLzeb/hOnk368KUcdUAu26NU2r7ivAA0R95SNu/ZpoLdVao2XCHYZl9vebKzmz/fXxY60m+yKzJ6+ojHBTPgtgssBhK6sigC9Q7Q96MqMZvbl3byG5dgu19l0t4OIdlgyXg6lNffN4S232v/OVEudPofQYy2ua5B3Wy/Gb2GbCPczZqHVJV8w+VpnbPgN5Buhn4AbQ0B/Ji9Y1TWiDN+brwVDM2l7FJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QVJ/luT8uvQridkD/SgSCcmCyrxwKxJM/NJ3IYNV/E=;
 b=Ycl+Fh+E7sw504fuOe5DWpK//TsIDhVpfu8amTUgg3Xb0Wmqx2oga2Ik9MYVnEBtPeajyc5sYWnCa4+jWyTOI5D9093r1889PujkuqCVcg/sAxjsZtQgKr9Llhn9KXjeOplzzNyH8wmAjTY3bD2XJBh8anv6niq4+YlrN8UTti165ZM/BdCezHICVCYIdtGVJnCwSoaJRiXt30rkW2tVLVN99kr/ujynh6UAqkiGaJkauLwVCuwijf4WnKgk0CFR/CehQrbzPh06vNCH3pdeFp8szzQIFawWrs8W0COoVUSXVsSG+sYeRcWF/Lf3jL5Zv9FVzu9387lf3tz0Iw+Kag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:31:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:31:00 +0000
Date: Mon, 17 Mar 2025 09:30:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250317123059.GA9311@nvidia.com>
References: <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
 <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
 <20250311135921.GF7027@unreal>
 <4c55e1ae-8cc1-463e-b81f-2bbae4ae4eed@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c55e1ae-8cc1-463e-b81f-2bbae4ae4eed@kernel.org>
X-ClientProxiedBy: BN0PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:408:eb::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b2387c-813d-407e-6fd7-08dd654f933b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6otd8odOiEbf0bvecHRxVigb1agG3zAvckjRu/7xHmKiySst7qT3ZHVD/Pv?=
 =?us-ascii?Q?8AnI/qpMX0db5eoq76Uwf2L2x0LGGgOKqX5TB2E9JM6/H3lXvYUABBVgxseL?=
 =?us-ascii?Q?bc+YPSi0Zsw+UJr9kkxStM3FRisB8nEVoFj/h8J5e+5zqX1NBh5kd2g57fe1?=
 =?us-ascii?Q?FguEEXVaGgE75SLNQcUHy6L4xTXnYT+MT4imyFNY6T3JAbxoSKWn8FGs8iKM?=
 =?us-ascii?Q?dpSyEjiPPMAof1m5ro/PSqm+UV6SqjXo+I/8st93i/uCbJHb/pjy8b4Qz7cC?=
 =?us-ascii?Q?WY9hUGAv1724+4E+t97tsQoN8GvlHAvvwR7K40HlWh+DtJHi1S20DxVdAVDB?=
 =?us-ascii?Q?DCd968cqI4xllXVUR9C/maL5aknM6Obol0Kw0eQIbIIr6jR8CSycRbkLHFCA?=
 =?us-ascii?Q?qrC+89Fned4OmXUDqGu6miLbLh/REL4Cr9EVvFpz/3EyuwAAxstpReXsBb+u?=
 =?us-ascii?Q?/MQZX1zGFQ4K6GBftLvIrdqVrjj4XnhcPhjQHEv1JUezFpQ+dZ+XvO923Ii7?=
 =?us-ascii?Q?Whr6OkhBSJ6KZmqUDepHwNE2LYSL3yVI+zfJZvudoMxuscmMpsHIhU3T+No+?=
 =?us-ascii?Q?DwuQ3i07O9Vrckkz6Hhaih/O4ZMn7pW0KhmEo/F6ZlNMqPXWazUavx/r7YWx?=
 =?us-ascii?Q?uhd+eFWR9l+vnFzDjpVK2H5BcupfJFzmUS1+ETOls+sk+lc2POTmqKVmd9P6?=
 =?us-ascii?Q?a01Dbdm4e4DmeMaTo8H5XZdWXj1Aj49B4p49V3z0qzszYhXozM6+QaSO416q?=
 =?us-ascii?Q?JAAj4/V87VAXcbqSEO4elybw34Mb4LJW1mX64mO5mCY5wMZUBDXN7fO1Hx/s?=
 =?us-ascii?Q?M+2cNq53am7QL8yidXZK8V/jS0jaS56OTfJwpESQHjsvGbn1bIJM8NkYglhu?=
 =?us-ascii?Q?BN+2Bjo9kkg0KvN2xNDeqMoXurrxX5bUDKQI0tP5G+VIh4Z43SvsaPXpwr9l?=
 =?us-ascii?Q?0DsvJdN1+VD/In4t7evBdgwAmhvIthRL392vifyDfaG2ILGYQWMgpbj8/V6q?=
 =?us-ascii?Q?qcHvN/6N4mD2CjpBrtWnWh4QSHb4DJVO3S+msIuosflsbW5WvSrGGBWU9jOi?=
 =?us-ascii?Q?CdhLzqSKnGTrxMiEznhhhl10gblsN+ousgD/ZF9nDudVow2xTjbrM/4/9ZNm?=
 =?us-ascii?Q?SqE6AEv7+9QB5rMxvbgXJq7wihy0tXFvOVDo1RSG/tG60NerE3VoVWqzf+Zr?=
 =?us-ascii?Q?oJK5/wZoofFtyba169R7ENoMY+KPcGK3eYI+oWknvT2v1UgD3gLdQTsXM3JZ?=
 =?us-ascii?Q?0fRJB7yof/STq9NQhcX1RQQp5y3aP9EhGqfqbrVjedXN2C7JMRu/LrL5k6T5?=
 =?us-ascii?Q?RrisVRiB7vnLP7QJQptMY4Kyi3odzwlWo+w7THkyaDCLPgwLIXuswGV6XrlA?=
 =?us-ascii?Q?aYM3OZpYG4bFdbRSTzN3NxOOGflw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVDICCrmu+/PwBMPaT56Vom8O8vl7rIoVXZu93lQ2zczo2sJQwEO0REu+9em?=
 =?us-ascii?Q?XYWOXY4SDE/YC+c9BHw3B5kgoKH+1g4v/5oJ6q2tmPjvUOzNiNk95qMIkZL8?=
 =?us-ascii?Q?pLf0AWcIJHzg2td+wYjDcH/9PpJ5ueBqLQGRrv2r97LlMKLVbtfT6iDfibIw?=
 =?us-ascii?Q?XkrLDOPdMajCkA2nbjEjnoVfwuq9AbLNzVK5kuZb8cuea/tOecNPt1epoGRX?=
 =?us-ascii?Q?FApuZRal60VVugRETQIOfzcJtPEJ94bJwOv8pgHZ75CFcftfGDZj82+rViUl?=
 =?us-ascii?Q?z0pIWrTmbnqjTGIcnxREHtpovLx6KPmjxCLZmtLMvO+4sYIxioyMmqa2a0//?=
 =?us-ascii?Q?lJCnBbCHUsS3KqVYL62pSFGTbnRmjOdbz0HjI3lMRqaTiPf5hG9nLzKck+5W?=
 =?us-ascii?Q?xJPfvJzs/6NFHFIfR2dGpOOLd7aunpSjfvUID2MIcdHugrS0vXQOhmhuJEmw?=
 =?us-ascii?Q?CFSfvXFspmNrpgQ3bh/18HctSO+hLDsdR2c5HHQ9EQSaxI0vikwSJ07R+oyY?=
 =?us-ascii?Q?EHMNeAvECNw6HBLLEpWvD72b1EOR7UKC1GxPazU+fN6wG2SBu78dBkPHsJZX?=
 =?us-ascii?Q?o3AE0GrVVgZ6KMzPmSYiuTfy07o87GwG6MDTDW2OaPj9/YePsCi88AV+3TG/?=
 =?us-ascii?Q?PLqsxng+CKGIOFKe2TuSCLqJSaYiAoVwTpd4BaTnhu1WjjGJdE2KPx8TyeBX?=
 =?us-ascii?Q?Uel7AeIFuKN24RJkER6ZmEMrY6KI1jmoQoJKW2oG4vn/QABqya5pygBIn7l0?=
 =?us-ascii?Q?tNTI+VPHQKPFzHRgZ2E5sV+zaFl5uczaulEFh6KJ0E7H1mseXVY27FNsutqI?=
 =?us-ascii?Q?6v/2StIo88BrOFcf8CfCDclrW3FW7QNBHYbDSDPkVoyY2RebmUf2sEdBMv36?=
 =?us-ascii?Q?1PgWkGfy9/uWFpIfyrPa4W8LEWtY8f53nyEKas15k27pGsV+eKooGciVo30j?=
 =?us-ascii?Q?jeKMQnc/Qwmsdquk0fH20TgM0hPO8LevzaCn8HiFcc9RUgfLXnpMqcP5ClMU?=
 =?us-ascii?Q?ZmQAZ13QA5995bTbYj8Ki1esm0NAqod2DptXm+grpyIJW921WEOUIE8rPSX1?=
 =?us-ascii?Q?+RqPGCjUeexHELQalxpNhdI48ZmPV4n8Ks6lvLSkzyIrfgoZYfKoetn6k7bS?=
 =?us-ascii?Q?XMX7QoH25CJBuTTFxTXqVvtf+fC4pOXbrGOLTSh0J2Wiry2BcuIKlQdlc30m?=
 =?us-ascii?Q?QqYXY2sPlPZh8+R40QTEw7NEkJNvqRPf5W8UCCPFjiYaV6tIpi6Txj9HxsQ/?=
 =?us-ascii?Q?SklBtZu+Uo/18hL7K6nb4ODEAZi80RhGVs2C3bDXaPyFzBcEQlbVHoYo8YnK?=
 =?us-ascii?Q?ViuJzF5Bg9z+KAjLRRuNKuLLXVKeLAfw/bN5oYgNNKw+E41EBMTUz6u0h/Ri?=
 =?us-ascii?Q?f3k1+UQcY2zlAnZ4HCubPmzUZ9db3XEJD2svyHjRHkyiszxYUKDhzG3VSKdX?=
 =?us-ascii?Q?RMyvbQHDYrKoRvmTLHPN3P52NJjZbnj/RuqDV2NFa7Q+W50owyKK/jOBVa/P?=
 =?us-ascii?Q?NzwWOpiVNqCS0HueCzIkyHTsoE0QhhNih3s3Exwm9fSWxOpzPT0EyP4dhg3p?=
 =?us-ascii?Q?1Kd/1Z5H0vMEPdwDhvs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b2387c-813d-407e-6fd7-08dd654f933b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:31:00.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFEtF4wmK+iSCyRfnPe0iyBd4D9LQ9gT+Y2vkT9/rVp85UNG6pCGeZMnBjKHaB4o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

On Wed, Mar 12, 2025 at 10:31:51AM +0100, David Ahern wrote:

> I hope there will be an open mind on get / dump style introspection apis
> here. Devices can work support and work within limited subsystem APIs
> and also allow the dumping of full essential and relevant contexts for a
> device.

We have three places to put dumpables like you are talking about,
fwctl, netdev and rdma

rdma already has a robust dumper for these kinds of objects.

netdev drivers have a few options, and people use debugfs there.

fwctl is supposed to let you dump the FW side view of the sytem.

Do you *really* need another one? It sounds excessive to me.

> More specifically, I do not see netdev APIs ever recognizing RDMA
> concepts like domains and memory regions. 

Why not? If netdev is going to provide the same detailed view of the
HW state we expect from fwctl it will need to provide ways to dump
the actualy underlying HW objects, whatever they may be.

It is not like building a netdev driver on top of RDMA is anything
new, mlx5 does it as well.

> For us, everything is relative to a domain and a region - e.g.,
> whether a queue is created for a netdev device or an IB QP both use
> the same common internal APIs.  I would prefer not to use fwctl for
> something so basic.

It is probably the right answer though.

Jason

