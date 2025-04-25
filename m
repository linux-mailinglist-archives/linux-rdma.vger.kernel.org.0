Return-Path: <linux-rdma+bounces-9808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B2A9CDF1
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 18:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56F21BC7FB4
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FB419924E;
	Fri, 25 Apr 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qeygG6wc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D14A24;
	Fri, 25 Apr 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598069; cv=fail; b=oJc9WdN0xrEXIx7cvtzfsjwV7++fi8A1maqaCfPN6Pzg1k8uTbnxRcjhzOrXP75J2cZ3Ow8Fq011WrKYoPheFgco4f8xRNXIc4GGj942uR28rwZSNmxv4jsWlVVpgEbx3uj5MmyqshEVWtFt4VCojUzVl0mAhFMfF3dFIJ9+qbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598069; c=relaxed/simple;
	bh=IDKo1Y0pQv5/TNZH2uH/y3HaY+AtShwR+3yw2tKUG2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lK1nRI7U2RxeV5xbBygtlNYbix56ZZ/2hbJEfj7+1adYMpZvy22PIjfvJhQOZ77k26WQYUVhlCNgzwTJls9ygfuYx7NLkHlNsd2lMuMRKy04hVSh76dFuQAHttuManwPi7wBvOMru73O1rj3nhyh3kUDE3tiZ/62fTFjdBdHHaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qeygG6wc; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk8tn1WsiFZv6ZSNU3Xg/ueG8QX6iDiNEi8H3RwUr6VE5hNKsTJO8g1zbRUtZrKy/FaXqvZrKDg/ojV4v5f1HTtWRPXx+xY6oDZ04ScEMlhDg9aAIb3T8bSggCtEP4vUc0l4j6icI5BpQZefHvszN/frjOiwyisvsFcKVkpAyMZAQmnLr6v/Z7xlfuSF2EQ13gk6xZ2qZK1sc84BVDq5xPYZyt1mtEE2k8mjVdo1+MPo4DqGkdegO5013NGGgnCJXw+HMwBlLUOKvgxKz6r/AAyrLmEuBbIkcjRcxjCYi0KVfU6/Zp1R83pAa9DNboj438j0xIlZFpyvcFaAgVKspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93asZFUvB4vMD4KolQWuHJAmnwWyYdfNqtDx3ag3fR0=;
 b=a/unjfz6a15afvjcRlTZVNwYB6KQBBAJKpClvW+6kIyiU8N8w7RO07zef2zvJeuwB2LnwhhygeeO9f/CC2tKHIB3ARLNU+WdwOu8dEn1P5hqZOR4oRCnOtoa4tJaBeCkT7fl4JCoFE9HR1ewEgO9dYn+HbDAjUehvzYeiMZlGwzvqWbeFKy04BeXCG/2XrYFMwOKaI6Nd8DAAiVpNJP6+7o8reOcieryGttU2bouQOBu1BCQzW6BH3EOh24H8sGJ/jqUgpULpMtWCLHTPkn7r25rpe99myZYpvHzq5H4TS9U3bJI3RvZ7zOjHKkblWbz5CtInTI2J76zGr9LJHgudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93asZFUvB4vMD4KolQWuHJAmnwWyYdfNqtDx3ag3fR0=;
 b=qeygG6wcK4V5uo5rzGSDNpa25S8QfwB7Rov0T7saHykb+fL4qsKpV8m7aiK3XwqYsIyszG3X8g17b4VEGHZw1ziLJJehZtneNxVjLvuRQFiroZMwrdJWjD9lzR9Sy1GmSYc7mc+h71lRCszlMY2vczlMXtswLuBDA00AVA5YAouaa+sDCNI4LbmcyDCwK/q7gCSVNHmEZu4b8FNOSB8gLZhIgRRO9WCvMgfaZ4fWX2Df29J4Faxv/AkAUm7L3EfVEFxODCp+d9j6ieIp/z+4ZUX+GmJ4xvxF+BxG3jA0SNwzKLocPt7TcEruSh6s4011jfXBZuh1WnIFAWTERuxa7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 16:21:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:21:04 +0000
Date: Fri, 25 Apr 2025 13:21:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Parav Pandit <parav@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425162102.GA2012301@nvidia.com>
References: <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <20250425140144.GB610516@mail.hallyn.com>
 <20250425142429.GC1804142@nvidia.com>
 <87h62ci7ec.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h62ci7ec.fsf@email.froward.int.ebiederm.org>
X-ClientProxiedBy: BN9PR03CA0723.namprd03.prod.outlook.com
 (2603:10b6:408:110::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 344e7d66-8219-4e67-3127-08dd84152cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9g8javZOOwv82E8jIeaczJDSe4Y0FfjblBeCuArNKd79H0YgofCsKTY43MI?=
 =?us-ascii?Q?0D3ZfdiCGqkop8gQzsYpTB8ijeJA4Q1G5kg3+pcgam2D5ynI0wugOZH7w+P3?=
 =?us-ascii?Q?yylKBcHBoKmW3qGXpMC3GqSOZG6UYTJGs0two2clWU2e+kukLa6G4VNWCsAb?=
 =?us-ascii?Q?iTG4Yq0JJXJongER0d1ZeUcoIHj3FiKMaxkBlcpKRjDSEe7+LfKccDxs6Esk?=
 =?us-ascii?Q?qjx2+v+WGwkrevOX4cYbAA+p5c3eWFvemVYtkCrahElpzsm0QsIhmBefpjGs?=
 =?us-ascii?Q?+zcmBe4RAIyddROlQcfuITjnhKu6SacJ8wDLs++TpPNLxXu3Coxk8OrP47JZ?=
 =?us-ascii?Q?44kgIwyWiOQl/4tYlrgiss+7XHgKd4eDnjBn7hqYZd6YMNd6IQrrwGxBVd+g?=
 =?us-ascii?Q?YRVcK23pP3QIIjlZBXcvzs+iwfrxBJ43zDL3hvHmAt3iEnS7VBMpiXbAQbVJ?=
 =?us-ascii?Q?zrah/e3OtJYywr1OoiKJ0uLJJ8HEcpnq4FXaxiwzKrBaka5zFRoecF/eR2OV?=
 =?us-ascii?Q?rP3TNfg1xKKrGN0EAFaedIh2uoWR3DdGiLkRZrfP3fZ44zOqC2aF5mwueQMW?=
 =?us-ascii?Q?HDUwwuBKw2QHPQM1UrgHRm3EsDnqUcVGtoLLNDjvkP5dCsuOI97HjikOm7ya?=
 =?us-ascii?Q?y3fI7c6Bt1hF1nVxNL/9buGIAoDIYjKj5ixOcvzzzjHI+tJ7Npa0mKtiVUgQ?=
 =?us-ascii?Q?mBP/5kkPSHcBLlJNOy6+GclQDdkd+E/ithJkXjhpKo4a0ejZb9Kw/8k20HN/?=
 =?us-ascii?Q?FokDPyXz65ahO6SuoaPBg1L05tpMLJrcn+qtCw/egxWZEI7e0f7JrWK6Tf2u?=
 =?us-ascii?Q?FOHlv2+Wv6zkdfJ7wDayLVakRu61R2zH88L4oTLTVfcC9zV0nXUhot+42eYb?=
 =?us-ascii?Q?sglazHCR3vPsEHsp0aFZVaS/mri/pJFPmKqsE1Pf4wb23QNJDQEakOkrr1Tp?=
 =?us-ascii?Q?eNUpPH+hr2U4YsGTcASllkCFECFJLGEQFVuluv1+GMf5I7l3AIrufcSWVZRH?=
 =?us-ascii?Q?NThp0hH+coLDGw/QJZbp1d3Sjwi1hFV8QYQk7PX74kOWMy9QH7C+lNLwC8xm?=
 =?us-ascii?Q?Tt41o+YqBn9NxA4wVApD6nHzTBe32FmK3ZB+M/PF6Fp44CsiLVCC4BpP1u/6?=
 =?us-ascii?Q?usJy53mRdGsG6pdBuKwc1FcDk/FvDxZFEMzo9yhlmjogvGitrf/G/ZoIyCqc?=
 =?us-ascii?Q?u5PkvNsjnpXkqHgV9t1JRDXfXY+pbJdYpkAS5yWGoReElubFpJVHbM0ZMFiz?=
 =?us-ascii?Q?1i8tlha3UNkUzPKlhYv6Fz/ImvrKcG5Xfxa22rjBYKfQc4aJIeTMLxmytAv7?=
 =?us-ascii?Q?ZmudRqPn7/Bo7AKZy1z1cpLWp5RrxCQZIytUuWwFt4a0zt/CsZbz8qfMn0XH?=
 =?us-ascii?Q?qGTbanU/c6eUeY/9TfnyAmf4LFejjdnb5a2Xg8835efdkqlipoPMrtOsIrGT?=
 =?us-ascii?Q?IjTD5js1zjw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9Um079yj23S6c+njUvGOn1m8oil/ymb+GRQEMBQQQHBdWX6rEwaAoYNBKwy?=
 =?us-ascii?Q?EBMWE9fDETuvmOItcQa/GB/5IuR8OlP8e7ki+83J75ZispgSYPA6X44vVg4O?=
 =?us-ascii?Q?fSxMsGjMNaSWHY/epXeA1jY6T6r8KoJ9dbgMx+rWQq+j7nicyQoqloMJot6Y?=
 =?us-ascii?Q?j5lHoW3WEjebo3L2m/JaHOaXblhOK29GS1eSnJ+Yj1JpJQcaTGxEP2kDWrYu?=
 =?us-ascii?Q?1lEyGQx07BRFrSB0iqRlk0MdmwpmBv55/jmbYliQdx2KxCdxYl1rPTFYJUJ5?=
 =?us-ascii?Q?nU1/Q6j6veUqR5kTiXFNGC74vSKwcaE21FyLiqgWHqlEMaGYoYlfjGRhLrlA?=
 =?us-ascii?Q?IYYZyNowHIbafRT21QkaqqwNBRCKzswk08CN+vhUDGnXnmUqdNRD7xQiezLi?=
 =?us-ascii?Q?bzlR3x/LF2swHFd6XRuJsIZQ8zA5a8twAJgLsRog9P7ePUgYcoxPBrwkWjaD?=
 =?us-ascii?Q?HylxLZVKJ50iqKVXeMLUfD24lOpF8nWpu1U2VOzTCVxckSLLuXv2sNF96uGw?=
 =?us-ascii?Q?QGl9KVAdJHl/tinTTa81x4ULyLgZpWxUSmNG75IJXlT3WL2nGOs6MLlm18IU?=
 =?us-ascii?Q?mFyUHZSrNR+88fgBgIvdrBTmht/5zfP4XB4lBXUajgstifpDGvsmUTv1t9m/?=
 =?us-ascii?Q?Wk8CrQM5UTkyQHyu3nBXOpWPLRxzOZY5nF6V4F/zI+w5xJQG14CrEIbMFNJv?=
 =?us-ascii?Q?NThnBawc8pxYnqPmX7SZ0OYTZwBpmOLmk20b1rgzLhPwLR9saXrzL7kVrXsg?=
 =?us-ascii?Q?N+PcfJivKD7KrVQUErbbz6dmHC9BQsP1P0/PGWYDQOXaUGCoV5eF2x+ZUfHr?=
 =?us-ascii?Q?DGSeC+ktsb68cCaqS1y6z9ox0gqcLpWlag00wHFVvjwFj69dFPwVlr6tOctX?=
 =?us-ascii?Q?WPSGi/cJgDaHRAQGOvJV4UhzMEHkn4BQ5Qq3Fw7iD8dVDc/clGf3uI0YNRYT?=
 =?us-ascii?Q?H3m/SeG/nvQmDx7lbVTTdFI+4fTUYrVzVYi18Z6YRkqWpK0R1HXbFXrprA27?=
 =?us-ascii?Q?v5+jUkN8HRVZt8SbSbDd1YnaEs1SHfpNFad38ToBZoPRPria1ROn+NE9mikb?=
 =?us-ascii?Q?Xl1LOgoDpxy6zTjtgZF2bjwJsEpIbbSKNRyo1U/pxW+T1I5AqVw2+Cmjnb1z?=
 =?us-ascii?Q?JGxaKgZ6oT23m0GOECy+8wUj7sNb9ITBpKLP0xhFS0xOLLysEaroJiuKg/B5?=
 =?us-ascii?Q?RRJd9vGAkdq7wPf6wpr8xY5zOt+ubbg7ZpWG8DK8iS155rRTyxnvXF2y73mx?=
 =?us-ascii?Q?zFofB5sn5MPFaKG82Y6ji9r2D19etcOqp6DQx3YyIxP9ZRa9r3JTdgWUqXgs?=
 =?us-ascii?Q?eJxciMKXvq0XxzDg0B7Vf3spgmO5XMVfEGfR/aalTbcswVPZFEhayUZenaOM?=
 =?us-ascii?Q?9iXsDkAy9XrkmtPiShSvXnA8CvWEbRw3b87d5cDjdChX3EOlDXk9cynUr8Vs?=
 =?us-ascii?Q?wBUx5pzH6qhsAeH+60eZM4pmp/zmwkH2cCWgmDMtUhfTssdeJY8syvoqe73s?=
 =?us-ascii?Q?4tw1bs5qqpnz8cMiJW4NIJZQhtbztkRqvCBtgNLQtbcLol7X1/S+BfLK6xfn?=
 =?us-ascii?Q?ISdRS1UtO5jTRhYpHIGoMKPZDyr130jYLu6Dwexz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344e7d66-8219-4e67-3127-08dd84152cfc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:21:04.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lMYBadg3GWxIS+PeKzt1JmSh6521Ngy55/JgXCZj3A6bRczhcRSxdpFb9Ntr1n+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241

On Fri, Apr 25, 2025 at 10:32:27AM -0500, Eric W. Biederman wrote:
> > That seems like splitting nits. Can I do current->XXX->user_ns and get
> > different answers? Sounds like yes?
> 
> Totally.
> 
> current->cred->user_ns (aka current_user_ns) is the what the process
> has.

Well, this is the head hurty bit. "cred->user_ns" is not what the
process "has" if the kernel is checking resource->netns->user_ns for
the capability checks and ignores cred->user_ns?

How does a userspace process actually know what its current
capabilties are? Like how does it tell if CAP_NET_XX is actually
available?

What about something like CAP_SYS_RAWIO? I don't think we would ever
make that a per-userns thing, but as a thought experiment, do we check
current->XXX->user_ns or still check ibdev->netns->XX->user_ns?

> > Is it the kernel's struct ib_device? It has a netns that is captured
> > at its creation time.
> 
> Yes.  Very much so.

Okay.. And looking at this more we actually check that the process
that opens /dev/../uverbsX has the same net_ns as the ib_device:

static int ib_uverbs_open(struct inode *inode, struct file *filp)
{
	if (!rdma_dev_access_netns(ib_dev, current->nsproxy->net_ns)) {
		ret = -EPERM;

bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
{
	return (ib_devices_shared_netns ||
		net_eq(read_pnet(&dev->coredev.rdma_net), net));

So you can say we 'captured' the net_ns into the FD as there is some
struct file->....->ib_dev->..->net_ns that does not change

Thus ib_dev->...->user_ns is going to always be the user_ns of the
netns of the process that opened the FD.

So.. hopefully final question.. When we are in a system call context
and want to check CAP_NET_XX should we also require that the current
process has the same net ns as the ib_dev?

Jason

