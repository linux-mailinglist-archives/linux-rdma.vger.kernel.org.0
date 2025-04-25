Return-Path: <linux-rdma+bounces-9800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C39A9CBA0
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 16:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6CB9A2D43
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45C255259;
	Fri, 25 Apr 2025 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H+WSkzj3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203242A96;
	Fri, 25 Apr 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591075; cv=fail; b=dihO/4Pu90Avl/KGuSz+x9O2sTdJq88DZN0Dyly65fsksSwg6kr5kMruJZU/Tw8gwYrRJ14/+784VbhRwd3BwNwIrFVMvMvqDdt3EAsXK3dtvc2KLd4pmbeZIKudQn8JyOLn11BRqkQ8zB0NWLL6AIHIS5rEksunBW1zN4bfrmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591075; c=relaxed/simple;
	bh=BPTIOaGbC4+GweoyFleZHSteuowuO5sspGt+S1Cyfzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXub8CcWVHZl8x/5Q0cZS2gdcSBGrBp5qusCCJI/1NHY2yHEtqGvHvS4+DVqQcReFseNv/kJhyAZXOIGYVKLA+gFCpYxYR05eA5x+e4i5oXrz/ZSl1uWwxyNKV+Z2WkcKcEOVaRQMUWMijSlsUvvsW3e1eR7Jd25k63GxV9L3VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H+WSkzj3; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+W/Pp3sVYFf6S9XPy1SmhAmklXdZvLxc8yk77EmCLSTFt4+o/UERGkSm9SUlPtOtY+i3Jyi2RFk0C559WCSOxG9hRCOc945e8E1a8xsKcvtS17n6pC5YVpV5UPRwnOypuqVgfqCac2rbjlvcZHv2R0acJ1RFXWfTKEpdFcU8oG8t4TDMFkWP9bBOaW65C4OE8P1x01hZdPsXbBfEmCzAx2bh0ZodVtfPSZif9YQwgg0K9s2P3AMvsAyUaZ9JkR1yth6gOJuAPdCT5R86m4xeOM92LnvmV6EO12EpqMgC1Z1UPqETq4zQqdX6cCSJaG8R8K2P0kQkkXBkXRJgw6btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axa5sITW6hjbCFf4RmwC3dnr7QAUlFGJni6Z4nwp7oc=;
 b=vOWxmkE8w56SSrYxqQbVI5vV9g0cX0Lsgyfev8ZsF+i3nsmnskxdDspWoKQLgKg88Y4NbmaxJ4iI71f/xzbxU79dMOeiPGoJkfVEC7jgYdJCY/DnZPFlhcR3cyxi6Yd9fSIuGMZcmlEfYCv4ZK4sfdiC6N6mB47O7ULcjYw8J+Fbf9EjnLo+rOig6SmOTcMUpXjqnP0/LTzVZSHMxyya+7I4V86pAUijb/TQQIOGxKePrlLNyMnlC+3nCoOJaQsp/eBN8zItekONup/PLXFmPm+ycIXAK1EcKaQ7xvC042C12JcJGnLZIIc1t7DdDniDe8+W/x2Jfnj39n/Ff0wD6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axa5sITW6hjbCFf4RmwC3dnr7QAUlFGJni6Z4nwp7oc=;
 b=H+WSkzj3SRjzk+ztcg4Fzm0KHCfS138htxPXOJJrjVMCfvXKRLRBESTfdmPtV4XxsBDKYWTER9zoCFqWlTMzOHSkPFDcKMHNz/UJ2zTPaKX/skIg1pOLAaRNK4UOjWbnp5B/d1RSxHQXGsOOnYPi/fglh2jmHZbv1keNRv248MUm70FBR9mCmykkJwF9QD5kRsP9eNNid8oq53Hh38w/C3DmfXWvs1E2hxNxmep44EJ8h+UvW+cVSoKfjzcsBqxvRt5y5mB8DZO8oXUanjkV1D2QkYpeV+cq3UUQsdvRTZicDCEXPT4KszNPiWhCNyfMxBRGfrtsvtu7yRYR96x7iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.48; Fri, 25 Apr
 2025 14:24:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 14:24:30 +0000
Date: Fri, 25 Apr 2025 11:24:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425142429.GC1804142@nvidia.com>
References: <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <20250425140144.GB610516@mail.hallyn.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425140144.GB610516@mail.hallyn.com>
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: cc78ef16-a0e3-4742-3bb6-08dd8404e41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrU/zM4yWE4T7LVpKty3dxkUEo+WKXXQ7cR/6c3oZNgJ1d1xcN4sC55grtvT?=
 =?us-ascii?Q?pzQ1FHLCf1AWXXot5n3XhOGJWjZdPZINzM/KCx+hlLg8pwLraqS80KtgCo8U?=
 =?us-ascii?Q?JOZDqwI1f873LdKq414hgM8ADqtwvIOUG/8H6pklnZf0GYpY4TNJcwlNlcRw?=
 =?us-ascii?Q?bgdUwQ+8nRKvkY4OiB/Rdkl45KMnYHyfxgF1ZZV54yJiw1zAG1aniZYx8Vz5?=
 =?us-ascii?Q?sNklRaaIvN17DuQpRXL39qqE8Bn+lSGpdffa/vDghl0K6fRQ+gMS6nKmcNGT?=
 =?us-ascii?Q?d0hIqt1zouWK+0Y0Xdt4aSAuHilcB8Soo5KFW2/DRiubTI3qba8gunXSag/1?=
 =?us-ascii?Q?XHGNiju6bzWm6IjIKMmnbg2hH1SBr2Jq+ULBs8Y9h3At6z7gNnqQC0Y8eLRw?=
 =?us-ascii?Q?X03D9KZFw/96m72lcR2aAggQ/2d9qG9iwsOlu6KFx3RzCT/pMVZLcSW/LWDG?=
 =?us-ascii?Q?aT728QEGx4jpdzm49nxIAdYqZKbDNTyhPR45cVIf35GS78MHYKUrOj9WnkrQ?=
 =?us-ascii?Q?dBkP7oStZLYl3pME05FqPFD6cD7IeIOVSPBPi2WoyufK7gXEDVmwLBykdq7x?=
 =?us-ascii?Q?phYq2rw8Jfb4mYMOFvpy1slX5calZaGFRHL7FPUKKAMdVU3dy+C84uQ2tySW?=
 =?us-ascii?Q?EjXh3wtvyfqXFRlR4WaflqPNPBkDVJyfOphcL71P8er67KQCpdA9LpxiofC6?=
 =?us-ascii?Q?0vBcbI83xIzBZMcmQTE+0sKIHJQ6GrAiP0V4S91+gBdWQmKW6bE7QF/0tzdC?=
 =?us-ascii?Q?ZDfk4KZxdFhDEweDR8yOBu6AXKoZs5cyCnDZ6ffKD+6nyEgjRP4RyAlcb2qI?=
 =?us-ascii?Q?E2NvlT7idEWd961Yd362vFW+NiiCBJsOuN10vXoheqlflaTG6wqyk0Btuy+w?=
 =?us-ascii?Q?8LcE4Wa8jYHzHa/TLpvN5MCD0yz8d/dyaTFfmMnksdSy6m7gMhLwuY9RwQyz?=
 =?us-ascii?Q?bOp2IweuPSJ5ahP6vVJmsBHdgO5dcKDmQe7uQYeiPBF6pfzOYASes7kEcS+M?=
 =?us-ascii?Q?mqwS9Tk9k9qwRQLm0bHdZmjRQME9QLP3cywQf5CfOO55cXygjbC03JmFToa0?=
 =?us-ascii?Q?wZru23UUOqIwDVt2Pw6YKW4toEgowHs77PEKw5M64Iww8Qnq82GrhMHTuWph?=
 =?us-ascii?Q?Kg4vWXdtcPClTKr7YDyKmWXKdSh7Nw1BT7bh8eRLWQKG9rv+id7MGJ8c/BxS?=
 =?us-ascii?Q?0WzbrdpPwlBme65bpkJ8dPN4mx/MdXMZM/mfD5TcLNpEz7tABcnPsvIXnfBC?=
 =?us-ascii?Q?tSi7GSQa+2/jB6n5u5/GG/DH1W/eQFp+Kd7OBwONXk6Hm99z+mQnRbnpk+Tp?=
 =?us-ascii?Q?U0Tiej3Zn1o2aOpEPLUlZMMKPciM/pd6AQxtZ2TCES6px7qUa1nobNsxkth4?=
 =?us-ascii?Q?8VpFGE6KmFiOXfEImQjOpw8k41ouh7EpqItyoMEmceZwOlzlxWA2z+vU2XfE?=
 =?us-ascii?Q?/I9H/ungptE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p3wbo8loA39KTTaFedKH84ASlqnRxXcbEVBvye0HqMGQ+WoydRGk51n+AnzG?=
 =?us-ascii?Q?HP9kUJ4Ej/n/f6VrqI4RGHZ8eRobkmXMrB6k71k7LrM2YGd6FHdVjdvElxkv?=
 =?us-ascii?Q?Cz/iYeBDknT1k4wCf+dOsYTNgtrw13njRLdg6xe7UpmV7p3oBZTFaw7tMc7m?=
 =?us-ascii?Q?wgb6fNqo5XDndo10un4Sp88ddkSAV38GUQl6mvhfoUDK/WRO/as7VeIy+vOy?=
 =?us-ascii?Q?+hp7CZKgHZYFn2FLXrAYqCErDEMJ8COYix3eoISWCOo25sq/RAICiMoElSos?=
 =?us-ascii?Q?CQyx0nUOuON4n9Yx11qMoadMHL/FfanInkzhxJFsvuwPS8+OAQr/Aj9Sw1rT?=
 =?us-ascii?Q?VTpHoJ/mBYCpJVfnUqfIFbeza7C8XDj7Qxje/ILoN2cikxJuRtZjN7bpC+iA?=
 =?us-ascii?Q?UdI7ZGjt95ukV9rBzoeeNqMhfNMRuu8GMwdJFY32oI7gFnH/hO3DMDOZmiaI?=
 =?us-ascii?Q?1C49ySfpG9x9U2zACU6cKBQcXjGNbHNKXnkQvK9eliG/bpLJ057mwGUPdIok?=
 =?us-ascii?Q?7Z5fpEgZpHYPpm3d97fiGP+Nol3E9aKTfUqJnfToB+N7FsHZ3k0RNxT/YgHW?=
 =?us-ascii?Q?zLWhHJpG9vaX5WjGtnQ4IJ5EQjqgsQ6M0SyG/cZ0VOoy78t1BZlvWwUvt0zi?=
 =?us-ascii?Q?vdIDV+ZuUFwlr+UAZyod6YHcZ9EikIBrr9A1yIUUJneBN5qI3qaGsiGKWA0j?=
 =?us-ascii?Q?uhlNmMghSnmNdGrxJ5BbCepa4RJP+tZ2hTvzuBXscWUg6EsNTRIqh9DpKB7T?=
 =?us-ascii?Q?qS9+ScuZw9w6uvaaqlMzAqHqB6Mymdp/lduILm5wrTWDGeXzI+xleIdnr+z/?=
 =?us-ascii?Q?NMojnL4xZkPn4buDYbRuPc3NWxlZ78FEck6Edbq19JFjc0HsZV47kVD8GKm3?=
 =?us-ascii?Q?DPA/HLPgLy/Aa/0ZsKM4q2SaBE8cHWbs3RoEFedPvZJrCuWgsv620xE+PABi?=
 =?us-ascii?Q?27DflLEDmKrqsFhp6JVVNu+9bXn1xD48nYskhYJ818CiIMn320iUpMwvQcgX?=
 =?us-ascii?Q?unSYSBcqE8gBicfFKfv3BP9/rUhMPlf1e9IreOCRdV/BdM4G3Kg0mSjmwGFD?=
 =?us-ascii?Q?1U9fy+bpsWEuaoem2HBMJe4/QPE/CgzgQEPu0PeMLqgN1gSQa8k20UcR5+Pz?=
 =?us-ascii?Q?/lBohtUdLyI+7w2k8S3mlyquS3zm9tSGyaMli2yRRKCv/pF40KW63uKMBdQS?=
 =?us-ascii?Q?h012LI0MiBrJdLRr5zQoB/Qlz5gZfzpfRI77o669ptXHEyJ7kdjRbVih6sip?=
 =?us-ascii?Q?e87Dr3yJ42wVcVRKu/hmyfipaX+phC9ex5KZktjWoXKXjV0QNxPddy7z6x1H?=
 =?us-ascii?Q?63U5jo87OFOYw5/A7eSt9P2TOUFr8moWj7Mvdgi+5sy1BOZKbRqfkW8m39LO?=
 =?us-ascii?Q?t3uU9nzRz9MySJGLudIo9AWAfWhEwxvu3fY7VBlTe2g+OFgZ7a9ibO8DPwJ6?=
 =?us-ascii?Q?rOoOc5ND3jQrUJAl3V8uQDJUAhTlXLUbZ78YjVNCZApg7NPjzFckcIqRAMGR?=
 =?us-ascii?Q?8jcz1kVuP4fNIj1foQ2e0YGbLwXTCdBpmawGNi3Bz4BklULEJDXaCUm0Gfrb?=
 =?us-ascii?Q?wd5eq/rMT0jgxhZkVJhMtx5Js84wykFXXWQC58qw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc78ef16-a0e3-4742-3bb6-08dd8404e41d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:24:30.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI9p0E07xTAuis0Mwb+4+cqGBXxaH38xwpzZKm4e4rU0V/SwazK0tRCC96nXkVIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

On Fri, Apr 25, 2025 at 09:01:44AM -0500, Serge E. Hallyn wrote:
> On Fri, Apr 25, 2025 at 10:29:30AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> > 
> > > 1. In uobject creation syscall, I will add the check current->nsproxy->net->user_ns capability using ns_capable().
> > > And we don't hold any reference for user ns.
> > 
> > This is the thing that makes my head ache.. Is that really the right
> > way to get the user_ns of current? Is it possible that current has
> > multiple user_ns's? We are picking nsproxy because ib_dev has a net
> > namespace affiliation?
> 
> It's not that "current has multiple user_ns's", it's that the various
> resources, including other namespaces, which current has or belongs
> to have associated namespaces.

That seems like splitting nits. Can I do current->XXX->user_ns and get
different answers? Sounds like yes?

> current_user_ns() is the user namespace to which current belongs.
> But if you want to check if it can have privilege over a resource,
> you have to check whether current has ns_capable(resource->userns, CAP_X).

So what is the resource here?

It is definitely not the file descriptor.

Is it the kernel's struct ib_device? It has a netns that is captured
at its creation time.

Jason

