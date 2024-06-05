Return-Path: <linux-rdma+bounces-2908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A640B8FD287
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8131F2A550
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12194152DEB;
	Wed,  5 Jun 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqlYK8FE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A9D26D;
	Wed,  5 Jun 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603872; cv=fail; b=ABXgqJnvF8X+3+QU5bPCW0T2wBaQGGlGG/tO6CxRJukeIJ8/qa7W7SIYMkI+3F+Tx6EMxLYx+CbShfN7Wn5Gv4XwwembAsu62qAaqQyS34RIA/JNXwfNDBOmZ6GqFPYYk/QiXWyuVCTybIf51tXcx/LU6/rZQyefwTuDGK+XmRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603872; c=relaxed/simple;
	bh=1DdXKmoOguad06Zwx8wlMsiAlhQlDgRtXpkakUFiXdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iyDn+pt18XTD0qxziEBVOUAKKKn1mwY4NsV/A3qJr1BRftJUXx+vxc4MmhsMjYH/dGOvA9j0anBsEvuFYnwO8JQ27D2ZYCQNIpvso2BP/FB0MVJU0u6MOrivOANxy+1hNk7GOalQsdzRzy0AxBy2y8ztSsEaxDUfXQa+80hWy0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqlYK8FE; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfZdHtFqF5lUdAQNZ49ujIav/B4g5jb7TtzbRtInR+QZBLmSjlZfTjXdVXJsKvVeOlfz9g30oRj6VM6RqtKnYliRrpDdv7cwcMv5WOKRhnFjxkkhmkvMhnGg8xdslNY/uxbtxA0BC/OpjwG5GZtAXvvZmCb2yHsS/bSF6/9PKGcud3W9jmDnJodTfyf5MjIxuT0YokDRU7qhewFkEABy0O4U6pJkYwDLArwANjZjx2BlH4V8ikWyLkOb/cETA2WG3HZs0U605jSR55k+hgRhdxR+bRufSTqtoO5QP7Df1T+KLPkfNTz7KKjrpiipQC2LthwgzZZGC2R6qM5pGdwTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mk/3+IvVBi/dLDXZCwyNexdSwzfEbcSkEFS4gep09k=;
 b=j/gV7IjJI1DPbJ5Qk9xgNgpltUeVLqhs0KqJBok2Gj8zqsw7KHsAhN/7Af5M83p1s5L6J384ndwW5bbMmIjkXmG9n9eI1TDt6TTLGnC2KQ0lc8RujNHXVWE83xEON5h8BzHwsx9E2UspxOQu5bRR9oKMcJugtKgs7dqH/1YJnPLSu+erZAbG6gk2Sv51IAwgUqBU8bRrgeng9kX18o9XkNqZJturxMpDIdiELOlJrdimaukzlCY36OsQvOkx3aW4QGQE3FGtymZcydYK3kHm7AqAfqyBQjSQnveQSS/rypq8KVKgTeef64lcnboHI9Kcs0dDNL1704K+ocWRE5gDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mk/3+IvVBi/dLDXZCwyNexdSwzfEbcSkEFS4gep09k=;
 b=oqlYK8FEorXQ9iOJC6KswpSsAr5m4ytLikUNSQ2vbX4V1U5NW3L8lGcmfAGqkDq8gyzAQt0WkOVhwZvtXbM+J7IzhE/8Wkk56hwkvCOTNlXygJsBEdbDV2PN9six7/oDMfU2w4q9evYqYYIpE0lnBjwnrOVld45XpyfKjkhYruL7fUokkY2sbM/F8BvDOYvKhPnBAJQhBFP5SVfmnlCEJ038jZA23pQJAiRjgyeCgg21/YXFWDGodN4p6ZJC45GlNhNyLIrPeuXbpi+Zoy51YXRnTDvpIQi1KpXhYW/8+txXgMpRV29J6JY84vG5t0Ymk9cjWDRy0xE0lWU9wbmBRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 16:11:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 16:11:06 +0000
Date: Wed, 5 Jun 2024 13:03:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 6/8] fwctl: Add documentation
Message-ID: <20240605160336.GA1760942@nvidia.com>
References: <6-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <7a28cd2c-b5a8-4c06-b9e2-9b390d8c96e4@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a28cd2c-b5a8-4c06-b9e2-9b390d8c96e4@infradead.org>
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f7a9d2-b246-405a-fd56-08dc857a1b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOdmNvEeJ3tZloNwBLt/LspqJWjPVdbu7lUHJJJq6kWA0du7vdoRXMWdi4Dt?=
 =?us-ascii?Q?2d+Y/ORUD0GQPJHE3NsuwnB1xRU8inVaILMfg+9+H66Sh/B7qRKJks5ZmisX?=
 =?us-ascii?Q?OiYrA6TvdOaswWtnPIWJqd9n3HJkHZ+g+X4x+w5JVVg3GFH1uu9PpzH4uKET?=
 =?us-ascii?Q?27XPd56l0/20W/Ks2CT5po+oyYr7St5at0kxS0Pblf2jwYlHv5BXSOe2jeqF?=
 =?us-ascii?Q?yCR05LYe9d4br7lzcpRRya8UWKbyojo4pKsvRYFz6GVtj3nq2PqAQNjLHktT?=
 =?us-ascii?Q?YfjEyH0fnvE6Z6O1rEZCqkj74YUZ8NPQQmYMtn4/kPbdkSwMgOvGdpqL4FpP?=
 =?us-ascii?Q?6GG9v/8Lc0fJi87BwA7e1AnCJaVFD6RsDCJcO13dW65lMtuQFkcNTjqTSD90?=
 =?us-ascii?Q?EtaDqY1XlZ7yWuPQnu4wlrEgxvAiA+JGmoFGVbmzlTQgdoNk9ViO3O0TLoTC?=
 =?us-ascii?Q?eavtEsy784GtHgEn/AeiXn6nUe3DL46nIXicii7XQlBJPAtm18I35vhIhbaI?=
 =?us-ascii?Q?tPsqLENnuG5tKmcVqWA7J4sCUiHsaK6BujK5gTKTvaauxVqJR/UYvpyPUtYX?=
 =?us-ascii?Q?2e1qL2PqpYav7wQn+OqAMNotLLGxW73qNau+KC1ROBhp/JF33XwkUUxQdp2O?=
 =?us-ascii?Q?2uxZA1hVGIQy0hKYtyeMMJw1GrOL19iJZeBKKEWAU2pK+7m4sp7BEWzUpmZK?=
 =?us-ascii?Q?mRu2cK1d2G0dW5lC+HFFMryJcTAnwbv773ilckQbIo6qE6nJztQVH7RnTsis?=
 =?us-ascii?Q?Pf0PO0YFFpeLs8wOgxg3YgG5Iy24QDgOwDii0chGJVqeRAx4dgtUg0+3mlfI?=
 =?us-ascii?Q?jt6foX6vGeHDWagufPSTJ0RfA/b+9UwXBD5zOU1BgfcbDXTJwrqyRhYR61gr?=
 =?us-ascii?Q?q5GKtn6DO9RJBoCE9nt4CUoM142SIYHSy021Ppqq2LBEKwbAEFqcz4WVzO3R?=
 =?us-ascii?Q?NY99jv8aYhEs4nB+wRKmTT3FgXd3k8PHzoxlQaBRmKsqWzZaL0ktO+ThxYOE?=
 =?us-ascii?Q?vaGGzpcrxhUucECk/kv1zTl7tvK4MlyDk/9qzMCpMK0pgPtMWe86sNKUQpR/?=
 =?us-ascii?Q?OUlyhDXrSffhbG/YBKFzl2A/PKsMb0tw4HXRW8zlZZB4kZHt1p95XISh+icQ?=
 =?us-ascii?Q?CA77FPyuLNWCc5dveEcR3JSdSIFB0hEreSD+85sTQF+ZP/NNri/vaMyaxs2P?=
 =?us-ascii?Q?CUfHljsaM8uAyqPHDqj/t6BVD363PfquNpNgfWkfUUcUf4lEURA3Mco0FWqB?=
 =?us-ascii?Q?cwjDdXKcYqJclahxvWxzmrWTQVhR2masKAgs/5qLyUuxEAHwL4U+erqQQOYh?=
 =?us-ascii?Q?OQJzKqI3isGPbqBjJCrKHbp6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/QDDqt7PHWdEGCD0glpumvdkNQrWWMDg9HBF/qhI77tp/vTD2FL21LC9NwGv?=
 =?us-ascii?Q?g868O5v4uqFSdlUiiTUDfoxjZ4nQb67bIxTNpCGoqxo0rtaMQGaPsCrzeprv?=
 =?us-ascii?Q?HwMAeuINlZUgrcSafug0qAW3ryYDEMxpdLZfpkQ5z3/rRh9yzHhpd2enXrh8?=
 =?us-ascii?Q?3VgAUBrOu8xoyJ3v0XLRjxri+0MV2sAyMQ4G51aCgvkGUmrMYtR9FBxnYGBq?=
 =?us-ascii?Q?sNh2W6pj7q8uQ3GmhRBTewBj+IEDvqRn0ophJ5N+rMUna1nSQnAmT2csNk5I?=
 =?us-ascii?Q?Y0hWQuny3dSLY4A/nKHoyJX33cIFSewdbAKYTMm6jYvCdxqQCAEkF+MZq/QV?=
 =?us-ascii?Q?sS875i8KWiTWm0SUgmn6xLWbYqnndAmLcgF5mhyG08ew3IVuACMIRls9noay?=
 =?us-ascii?Q?sJsRkTU7ZrqLGVsGEcnMAo7fkzd6/Qr1GmiVjW7LapQ5bkc49oSVTEc2ReVP?=
 =?us-ascii?Q?aP6ErsEKYcwg35gr/D3O8dQvK+L+67AigEBsiOetIAnbgG9xC+/ER/IPFNs+?=
 =?us-ascii?Q?M1PgyZLPeFjaBZADK5gcrxEoydneEsHWwxs+uLpYk0ZDoDtvO3GYxg90+AEG?=
 =?us-ascii?Q?jtJDf9w0HNihhGDA0nA1tv2l6XwX61hgK45G8qGlhRxnNcXaeDLBdXiqGykL?=
 =?us-ascii?Q?X4lrdiAk6OChKB39ib3R3KlwyhV0LwiYak4CC7ZEU03r19DZzcwPhlLjNiIK?=
 =?us-ascii?Q?6e/5m77yZP1BmJrlJZlRnfCTnHtoRurQMSQHgL749zGVUV8W7UN0Ov9+jS6P?=
 =?us-ascii?Q?JIHWlTls+HaH2W8EZi4X7r6n7Ae6XxQyYoNi4h9nuBRQSvtk2tpfP4CGSQYu?=
 =?us-ascii?Q?Fvax5Fwr05tBp21m4Xnv4CSJR1VDK52lq8znz9y5YZvwo1kCo1T8n+Agyypg?=
 =?us-ascii?Q?zFTj0WLNkUN7GY386Y1JH/bJzQFK/goEKZ4wk4szj8ZHchEABziKKn24Fi+D?=
 =?us-ascii?Q?AqFEIOSMVzxalKgi0w9WgftKRaqJtQcnwGfl7UO88qFdKR6BC2c2V2SXZ39Y?=
 =?us-ascii?Q?ysFIqIdmTWzz61QEaFtvHBPilAdF1tolju8/iohRX//wVuvj0DqcvuYLbQgs?=
 =?us-ascii?Q?QLAlZ5yWU4Iyz27AWuN3h7CzDXUvpM7A6btKe2BqWnSvsBwdZ9yYCDovOU1h?=
 =?us-ascii?Q?KpDn8CYnlmsp3437Zqp7SBz7Qg0ItJAfrESCJC4gHh8GEN4VpmjNo6VQ0KLk?=
 =?us-ascii?Q?oR3Xj+LAe+AyqpLw90nC8dxi/8ESLUSjMlXHLolLIsVlRJCJr+6dHBaOSgFg?=
 =?us-ascii?Q?7NyTOa0JsoTAFXK9Jqs4/rER1CZjSw6HKi5nKwnLCQlMwSSF/x8ovuUNeIRu?=
 =?us-ascii?Q?wqw/0FjISkhboFIZ4f53cuuIXHBJF6LVtOkfPPOmqUTcjaMWsUVXSqEV3ENo?=
 =?us-ascii?Q?YVq76witrloSYBfvelhEVVkDh9085QgLeB6ydfD6Ll0+0OYzbRsITLdDm/9k?=
 =?us-ascii?Q?HbeHEas0+klHnxutaKd0UlNKbs3/N4/vjdH+h9RVCMx+brUAja3+8xXBQwy1?=
 =?us-ascii?Q?PZcSOAOlrBBYidcDQCcnnfVAv+JeC7CqfTaSkWTZcXgD2XYyQY+QTBj+oIcp?=
 =?us-ascii?Q?rridnUPHeQBSPoWigZ3b9xSxiMHOAm6S72sFmocY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f7a9d2-b246-405a-fd56-08dc857a1b13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:11:06.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBPdOFLQEwvOacr9aQRGetntHKkOfRMZcIyjusKiCuX/KAOcI/8CD83EJeUvL0SP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

On Tue, Jun 04, 2024 at 07:31:10PM -0700, Randy Dunlap wrote:

> > +Modern devices contain extensive amounts of FW, and in many cases, are largely
> > +software defined pieces of hardware. The evolution of this approach is largely a
> 
>   software-defined

Thanks a lot Randy, I picked up all your notes.

> > +While the kernel can always directly parse and restrict RPCs, it is expected
> > +that the existing kernel pattern of allowing drivers to delegate validation to
> > +FW to be a useful design.
> 
> (and one that can be abused...)

I would really like to write a paragraph about this "abuse", Dan has
some good thoughts on this as well. Did you have a specific "abuse"
in your mind?

Thanks,
Jason

