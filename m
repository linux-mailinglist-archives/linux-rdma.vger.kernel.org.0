Return-Path: <linux-rdma+bounces-7735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D06A34C6C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22C5188C359
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B323A9AB;
	Thu, 13 Feb 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvHwjup7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B028A2D6;
	Thu, 13 Feb 2025 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469173; cv=fail; b=HrTbWkL+yopxTSQjfhNAYCfbEb/NKDLwjgUdI6LtSRYp2c2PEiZo+0GUuGN1H+e2NQbWQ5olAQXhAqy0JO4N5jukXct4RzS8ulGHDJDu8dW++jZayLdcsTVqE21WTwXEVMImut5HYh+8uY4H7hYbIHQVQDiEgePmqvl3R3AXUAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469173; c=relaxed/simple;
	bh=HLHxd09f/E96ot6eYePeHDngDMv18lMcFwU6IYWLrfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUx+rz5FATxgXdxMv6ZUzzs4FU77k1PU0Avabf4NwD547QYLVlpMf8iZI2bJbx8QT9VzQ7TeSSRvoQjyh3zD6dTxVD4qkYpowpQnht41NXjvufXH0l5DZOe+aLqHu/yGz3vVb5am3yck3GZ3TmgOBjtELz1f2O/EfSJw6rLKMNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rvHwjup7; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMRpuFmYLNn06rD5MmDBezsbdaRDYx/7y2JIXI2Es3V1AkX77pBdTpcjsVZ/kHP7XsvEuvRc5tjYMST9TpduJXHmdhrtn/mx1Qaoo40uComiLWzyDPaO6geF4mivre0pzZWqs9RrbH7/qST3C/zzMc5AOvYaeBiaBD5ou4LVK9DVwpT/VmR6KW1JqfIvjSuqV0F3m+KwVU5/LlxpOUWvHAuU891EUBdw8hNcspVg/5bok2yN4L6yifcggKydIs4UNQrQ3BgXouBbyKUUFqV1+NO5rbZuSbonE0p4AmunB6SPsFY3G7FWSreBSYPgRmck/pdM0NxDZqFLhl1Xb8GiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eY/RdUiGWIMAIm9MHExtDeqtA/BLuX6+CxUznSWFAQ=;
 b=vn27r/NUuLq88UeJ+/LTgYj0HYMrc9kP3ebpG/y4HoPytIKWbt2DIaZeTCFyya9qG0iNrMbhhDDzrXpuKoFZTi7W7X3JFa92LGBvVkQVANievhfCfw3MWjxs4x30ajvcUGAEU4s3S28dbMeyAaKxlZP0AtbURqGdNat38bw38jKCLjzPylV1LJ1zpMQ36hBMii3hTaEpqRUMqNBE/YvdhsTx8EaV3N1a5YGNq7saT3K889FZLHtF9qzFu+4souhJu4iQIFkdFp0CTfpBgowD+wMG9umpQn8R+ncQWZUHKOgF2Uu+bm1DuhCrYaFYkaT8imjnlQjH4SN+e7B4UKRf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eY/RdUiGWIMAIm9MHExtDeqtA/BLuX6+CxUznSWFAQ=;
 b=rvHwjup7tGsp7mZnz5wL304LNR5RHo29/Dw4ry7d+w4HhmW2EHAru3InaoLGyrznwq9Faq9A993h9NWljRzGDYdTn6/+aKciBdkk0nhnydGVVFrf9COBIPQB0Hp1SYZHPUhNMKcBFlkfw+fEaDiEMvlDEQfUg69+yTdyK9Q+55ftc0m+xNPB898QUm84LbLu8A4AdPNDW2B7WMJdZEZAXfJgJ1lZgluRnOy2WFTESfHqjRPjlHSTFNErA1C3HqssVpTTiriRf+WbwAFutMfX5ZtIp6SzAnEvIz2gl5Gt15jK6zLGbSwY02KuZS8H9IeqbmsH7x3TxVCHEvJ8m2v2/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 17:52:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 17:52:48 +0000
Date: Thu, 13 Feb 2025 13:52:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 00/10] Introduce fwctl subystem
Message-ID: <20250213175246.GA3885104@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <a0f1648f-eefb-455c-b264-169cb67a7486@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f1648f-eefb-455c-b264-169cb67a7486@intel.com>
X-ClientProxiedBy: BN9PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:408:ff::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b193a86-b820-44aa-7c50-08dd4c573a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JkUo+yLHZn0pjr7WwWrqxLUPyIOYKd92Lrpg8NP/p2F5HXHv2++YAZn3HM2Z?=
 =?us-ascii?Q?J5xnpaQCI7iJchsRiOPMHCaBTpe9up0ugr5+fsObmKtlMp4/cGXYZ3KH8YUy?=
 =?us-ascii?Q?63BUCqY3pYTOQO6lqGjBvzgDuW7zu1Rvqw1Be8DeR9h41PiiHwFDl/wn+2i9?=
 =?us-ascii?Q?L/66Jb0m4t0q+fyGLck87XmM9aFs+1N+nmSMaY18hy2hyu7WtXRL0tIlRNN9?=
 =?us-ascii?Q?fgRWfsC1YSPMapr7jiQD4JZcfBCeIU/ZSDMt1knRWHQPNB+gfoqEvS6QrljG?=
 =?us-ascii?Q?hf5B3dci9lFYnvTjsXomb8Z40fNsIYXndU5yhE5rt8oZRGdlV14RfoxHiPK3?=
 =?us-ascii?Q?W4r6Tr16XdKVsg46nXmP0OI1ytG19NsmP/hO3ZfJidfJMXSkCrdAZLoxbvpB?=
 =?us-ascii?Q?HpoYvWDYOxhvSITq0sQSgtA4Tn6VD1xFJejwS7kK8EMi3hkzaFClCqP4UMx5?=
 =?us-ascii?Q?3TeNKqsSXdR+zZ1pXzULnkcYeJ0TpwL0jh7gctBeMSyRK6IO9/lZw49M0/ig?=
 =?us-ascii?Q?zU2QLnYUNO52FEFN1JYVjXpe/zyYT/fO7jJCzyWsPpjSD/SLn9DPuJprZlSS?=
 =?us-ascii?Q?Pnuxr1Sb2nashinHtg6jqETdTunOan8aZYJGZLi/OffagGOxeTpYwxqZAqC1?=
 =?us-ascii?Q?4orYbCNe9OgAC0nevl70fkGS1wui3ygDajP10Afpc3z7BElEcYmCBwV2MFXD?=
 =?us-ascii?Q?cqmIvmvv32+3f6nrmMEWmorl0DIUni2PExvNBti9fQaudShrY+wX/ETul6XM?=
 =?us-ascii?Q?yYNRbZ3uI1bMPbfQj5hvPNElxg67cSmJUlvmoTAefb/UbtJwd/vsV6iQnfNJ?=
 =?us-ascii?Q?HLXiRj30TBTkePFGM5lWpwsuQmkSBnbslem0c/Be2Slnpzi5tbmzPWfTW6ze?=
 =?us-ascii?Q?kChgnGn4kd2wN1znHckdEY5JxVopwFXC7eeNDx44/Ll3XzONQWPzOfMZv9Im?=
 =?us-ascii?Q?lDuUGCnbHXFJYUGwukODj/EJV883XAfVhopF8ZNxjqhRW6WlJKXY07NDk34L?=
 =?us-ascii?Q?Fw+810Ac8JY+LxSx9TQHpIFb+jngNmzQQFKAX5F/xz+K4zxkA3H2Wz4sgsm8?=
 =?us-ascii?Q?ziey3Tol3SzzQDoERDJ08b848Q1bFIY1kZqSN7Xeul/NM4GaQ2RWMGhGfCtS?=
 =?us-ascii?Q?d5qvbMc1Zd4oz7BCNdNm5izfKCzFMesZa7GK1uIKazBOaPyOEef5oYQSt8W/?=
 =?us-ascii?Q?+HzZZlXQyGu2rDWd5WiWuv2D1R3+TROsXg0N9zGuf3yps9J/5JV24BpEjwBF?=
 =?us-ascii?Q?28OZrFzJwKzKGzelleuf1b5vkrmihesA8yQwpgHoP6EWLzjmu4c9Y67qBlRU?=
 =?us-ascii?Q?bPpNV7gTdSOuL6Mv4hQEz5jt/PFzmkuJ+FK94MVqauMHqgaHjt5IBwBIAfeu?=
 =?us-ascii?Q?DzdYVUgKeR4lsGXT1DcmWcQZ6Lug?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7750489WrLEx+ZTnzzWI58DfSV3Lx1tDEEzLjeQesJ0aQJnGpOCU8zCm5qP?=
 =?us-ascii?Q?oiOWXExYEYVm2kLiptHtdbUosolcIu1NdC4xVxInDqahCvebvU1U91JK4+aL?=
 =?us-ascii?Q?JtWRl4ri3k5CUN2dzMj1mw9a5r0gog9RfUNa1Ey6pK2UDbOACtURs+ghMF/U?=
 =?us-ascii?Q?ARJP//nJpejuDw06H/SSeQM2y/gE7pKCMw7A4Xu1B4OKU26W03kdP8FzExLt?=
 =?us-ascii?Q?9i1DFgcQYhvtm+GaUO4GPOaXJ+FKUywUP5s4Lc+lTq7fkEreMeyB8gwuQuWW?=
 =?us-ascii?Q?JoXnmQbmVGGNhdzPP6VAoJ0DsD9u+Ef59NeMYXu/KJuE6QftdxgKoGnevFmp?=
 =?us-ascii?Q?H4M3o2RqILbGT+uRuHvJuSJDyzBtorsK1jEhKGx+K4aN12Hj7RH1O5Z1IY4H?=
 =?us-ascii?Q?DWzyEqdM/BfzUgrl1yOnXWO7m6wRXXpEWTfQFzoJyePPq9huH72IKqEG6Q3W?=
 =?us-ascii?Q?anTxBaYIYVSv4rjR5qUNYdfnZL74l73KE1s0gmKecspk6tuyqkygXTG4/VcY?=
 =?us-ascii?Q?DSuRKfgY925b/eSA4iLzi4/JjYHpy0RBkmB1Jtzqd18bI+lejD3npcmxIChB?=
 =?us-ascii?Q?fVOVNw0Yi4kHOawK/vMnETFCfApNCkiwm0QMFth5fCapi9rTSxKuHQQGMkFf?=
 =?us-ascii?Q?J5X2d+1STXBamE1R9yIcY5JC+Y5kvNj/IYAD6p9P0SHqYsDqT1SwSoGyWmOj?=
 =?us-ascii?Q?C/03F3rlRPwbLoA0z+4XTmwgDG18svym30hyZgDckunR1OMuH+2XdEoOBnFz?=
 =?us-ascii?Q?5gIQXx0K8YZqeJWMyjdIg925rLh7wRv51C/4CNcpoCEni+86UDx7+1HMi7FE?=
 =?us-ascii?Q?xn9mW+FxbeQaFoS9Z98NvDo4SyjRQA3wHbP3uPVHREOVFKi4E0yamrAV3Zgf?=
 =?us-ascii?Q?qoDishyWB68ex5jKpS39hzLjl7cqLMyk6AsteSGt0Ss8Dyt3qnNySCgcbnwC?=
 =?us-ascii?Q?ThI/OjvE3991egsAf/+esSmqPc0Peobn8QCZ3297wyc8tdw8XWzF/tEgQkRe?=
 =?us-ascii?Q?YbycEcfEbpfarrTXGhPatNrbbxXHWKl8me4Aak1afRE7rbSsO8cyxs8GRbw6?=
 =?us-ascii?Q?85637UtepLMX3wfWyP9xs/M05RL2CDJnuwv9HI+Crk4TqS/tIFgT8iUf0iNV?=
 =?us-ascii?Q?YnzPP8xeeBq7+mvsl63dDdQ5ovt03wSREtH6j3N/LUiIuMoEUW60WSjAsWAA?=
 =?us-ascii?Q?qevlskzZVC9Jej3tfnE/+2uvFugceYQ+y9MMoTDmYlL366kKcL35pKDPZ8gq?=
 =?us-ascii?Q?+/ErAzv5gQ3++IIZZQtGR9sO72ebEWl6w9dSaGoklSvQ8GGho0OtfBmZ3kxq?=
 =?us-ascii?Q?swR70bUAPSdQYOZe1T6fiLlpRWUuZ3IJbIdfA0qOfA0i9BdGUcYRNK5gPTOf?=
 =?us-ascii?Q?GfjbpaBviJUcu8qtB3umKqhh/QZ+FGPjYAssX+rNVyhSMovHkKvrvQgTcAc1?=
 =?us-ascii?Q?O670nAe1LkDQrwtg1VkL0R7wACodSvzEC/yo/SWWmowjaZUL7BrqzRPcxYcD?=
 =?us-ascii?Q?9Xg3JAcJzfxE9Z4GJntp4Gb2LCLdBFXoCs1LnucdZI29H6EcZIIZR8AvNarw?=
 =?us-ascii?Q?iCnpwPofAAjW1TzV/1IIxSynynlHT5axmUJnptQ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b193a86-b820-44aa-7c50-08dd4c573a2a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:52:47.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPMHVKms/iWCnYk3RJBal9vOP/QSQ2WX3IsDM9iTZ5T0PbMi/J/dZkzNTlNbmBaw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545

On Fri, Feb 07, 2025 at 02:58:51PM -0700, Dave Jiang wrote:
> > There are couple open notes
> >  - Greg was interested in a new name, but nobody offered any bikesheds
> >  - I would like a co-maintainer
> 
> I volunteer as tribute. :) 

Excellent choice of word, into the volcano with you!

> I got the CXL series rebased and tested on top of this series. So you can add
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> for the core FWCTL bits in the series.

Got it

Thanks,
Jason

