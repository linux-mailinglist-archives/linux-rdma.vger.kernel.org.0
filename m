Return-Path: <linux-rdma+bounces-8802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF201A68024
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 23:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BF53AA48F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 22:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31452066D9;
	Tue, 18 Mar 2025 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KiT0EYWD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5385626;
	Tue, 18 Mar 2025 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338638; cv=fail; b=pqdKDbuXXSDbQMHagwVuPerepn1ozugXf1pWbaEdEw8lgsJ3sp0y5EDmPHzstYwfJPdfNbwweTDdU5ciRd7XXy21T1Fh/LTnau9iUw8l6FLIm3RDuhwABSDi9S5VV0Kr45MgH5G+6HfC2lp4oPHIsAP1NtTNLlA77sRIsYgozyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338638; c=relaxed/simple;
	bh=GiQ8TB/7sTthhyxTr5DJ8GNumi4p9V2sLYYDu0kJiWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQ0g6IJDtrU3EOxYviTGDYZ2WjorZ7Ko7WLF5sgdtNOjTiL3EhuQGa41gEQWghEAW3Gp+7ciHpbZycmFcd9lHs0aU0gDMAO4jRZlO2uvmUg1vLGYzyvhZ87/gVPnLI96QWT51OAjut2xKQfctUSBrxJg17Wm4OMvPo4HaXHzBlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KiT0EYWD; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX6N/UQT+9xlXx0J9iGXkDgb6CK9mV5wgosC78a6frGKCAUUiO7SUpSMLXr4nF+XD5EzyVMIXdv2OZ3AffkSHgGrL3+tPyhAKDBionmaA3V34ZzXaWmxcnxW2ja+15ZrjprcuRvNRBuhucg5iKqONiYURlDP6WxmfYL2YCNhSeshEJo7ntvuUuOO2gLBTdbCTxOLCwEgP4QhXjZ8YgXyU/toDADpY9fxmIY8Kq0EJXg4QL/aJbWwdbTOq9IOZujeoEbqzllHjO8IQW8eAULkPNP05U5ZbY+ZGPgznqOMGCSzT7YHcBbGxPGgRMzUcxjMMqQ8b4Y69y7zQwF8VkT7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N1AtE/OACFyxZ8+1WTiChYHMwSQha21wU/K2C078/E=;
 b=c8MPIIlsB90swsx+ffpoMs0yTiW7S/R5+PkRKA2U0EjeBjXoxnApC4/8JIcQqU24CU5oON+W4o5b+NEHlVXAz/z9yL1EufFivQc/lUJvBjp1N1i+hueLYJ8TJFBnT25BkSRXr3GW/7nUmD/RTdhDnBNFVFiy94z89zefDvLMmwARjhTLh3zVxp/Wa7eJQCeS6xMHtOQu8cO1r31ijDwaZ/Q6qVVejFvra+c9vFW04Fai8N8vaT4Ud8xYbTNY5XG0K4vCXT7jZllKBgSgjngiMnK+moQ4APChuPCBI3x5Guo6C0hHn06K5UkyLidPQRskvBNcxjEvhVKTeZ463hsJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3N1AtE/OACFyxZ8+1WTiChYHMwSQha21wU/K2C078/E=;
 b=KiT0EYWDxeC1DkTvSMShVyH3rrKmUVsl4S9ev6ImdD34SXrIlAAM8+VJNcKMX7Z/YvvzoqKL5obRqbjwz2wPvh91HODRjgNpuyYug/j5WMvqsmL/mP5W/A30rat4x2tKKgKZbF5mfKwIU8ZsO0IdmHGKJVOXEpGJxbpeFKjqpHWqpnzBjEKlw73YhFpw6ok4afNo9qOYM4NXhEM4zSnc8PFDLFWJJ2m086zr45twUmF5UDth9USGB3hVVpaBXeOiG2ayV4mC2YcV4agXUyTSClO9GdDK3NQqD3SKstnkedTtVSgyLlGpu8ZV2BGSToyd7zuLbZCkpbt8k9CAU0hnUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 22:57:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 22:57:10 +0000
Date: Tue, 18 Mar 2025 19:57:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"serge@hallyn.com" <serge@hallyn.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250318225709.GC9311@nvidia.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
X-ClientProxiedBy: BN9PR03CA0778.namprd03.prod.outlook.com
 (2603:10b6:408:13a::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce30eb1-96eb-436b-a8e9-08dd66703744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/pLkSv7BjQtAZ9TbFwhVq5OTlVtE5emp4AujVir+jKKHJLMvsK9Kt4AA8o5n?=
 =?us-ascii?Q?vxeyyNq3PV799TkLmkeny+iEXKDq1mv9ynh5MPlX3kIuh3J6ePo/ig17N2CG?=
 =?us-ascii?Q?BIusK8o29Nht0S0hstl0YBoE5mI1lBxDi5afS/RKuUFJLbla3+aJi4NGBfv8?=
 =?us-ascii?Q?aKVal3ZEWLeGCUSjfNvwI9CYO2YMfiTNPnYSYw2TYxmjIETKFM7KfPLD8mxm?=
 =?us-ascii?Q?3EmKZK8TzMsGEa+AR8PqifE7c1o3OIVbezaseznLlhhGL6Bbd2dcObsdMdF4?=
 =?us-ascii?Q?Y0GA+4a8Nka5XKw40LI8R6OCGPcEdsuat0uhkdaQUCDZKHLFN6z6CxKUmVfU?=
 =?us-ascii?Q?yVBoOIhAlPVA8AhOVZ9V9NqgaI0S/dWlAzQIemcDPJO2+xQY8JW0AfSkdKay?=
 =?us-ascii?Q?iEIvT2z3MvskI5SUZ58Fbn8As+XrknYCPYgUNUot/ZVOP85LQvnQ2K8Zh4bt?=
 =?us-ascii?Q?5HxG63jwkOOAbmWpP3ss/bjdNrcE4FoGTfqjGugOjXJqPipQYWeERoifNPOX?=
 =?us-ascii?Q?93JId4p8L1oZVlQEmP7cUQBhBHsJMIA7aUARa4+WozlzjWYUawNe+iynpTVn?=
 =?us-ascii?Q?+NDiBcoPh7deYOqLGZq555bJ9ovmffR/ohBqHcWKCq+p51soXhgyAaila5re?=
 =?us-ascii?Q?I3T583nwPsG1fj7X9ZWYfCWkEivUIGPTSsdoEkuBD9idt8TmjebpU7+9fh1F?=
 =?us-ascii?Q?O+7udXjm25n55odrADv+/Cxoa9alydHyPlIZX6iaBFkzc+RpvrK5Pzfg0eMV?=
 =?us-ascii?Q?wcYbvwR+sVOdDhWO6aLkBLqX/pm08P+GybtUbzMp4ysNvB+ioQ4Umcq5kK4n?=
 =?us-ascii?Q?NrBIDa2tguXs06mpS0xGli5R3V5m14y9Ec8GL5Nm7ZNH/A6b68GW6VM5Npsj?=
 =?us-ascii?Q?a0v9FBUmQpvLFkAPOBMJyQPiu8Q1VmXSX//Iffkp+RdwQcXSSoqCoNCUqgOe?=
 =?us-ascii?Q?qxxrYhV5g1nIIfUJyz5t2ZyG3qjURkwU3bVzPoj0IMXyHvJmMkpia2UGkUxu?=
 =?us-ascii?Q?dhC24J1qpX/w01vBIR/wJJ45dSg+1iTAcfeEUIqBkcxLgYbbquDmJq6YYzwf?=
 =?us-ascii?Q?BIaX+jvy1jXDiEhR9fDfwluiBLma0qa32rDN1TDogy5gXS3FR7BtbFJB47IH?=
 =?us-ascii?Q?IjaiuoSs7PkYON7GaOZdBIM2kkG+hsFvLHw98wR072BidKMBt2i3/+e9ybMT?=
 =?us-ascii?Q?+aWtO+QnygbTqGzIv9Z0NUOXz9Y2mpSYCu95BV1gWtlGCw3QLRLEisq+KAjx?=
 =?us-ascii?Q?l19JcGkPuRHm1T5Q7OVxs6OdRIKkproYdWNVtKiJjuxZJNMGj5N0bPyUpuqy?=
 =?us-ascii?Q?ZcwiRKEl0sYFb+EIIfODfKg1BF+ZZ+Qo+XqS62Zbx3nWv3bBHYvrX2TZKyQE?=
 =?us-ascii?Q?x4LbBTqFC7u5Ot90QqjeMq/lXpwi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdnVjvqRbrz0Jj6IP85g9qaDPWZZPfUSPzvmDX91MYizfjeFXeB4spVGhs1o?=
 =?us-ascii?Q?UBySLcYNDWC/9RtNrZE5P47vTEkUVD6S5u16hFc4ujBV7PAHyvaQRoRODrzn?=
 =?us-ascii?Q?diiiGQkZpPfkFkBdVXp4QvwiqRMgBa3a10BPKu1aS3OH5PTPCdEpkQxaA5Xc?=
 =?us-ascii?Q?ZKCt8sY8zFCw/r1xfd9+MF+VSTEL3sWr3qp/mBjFvCVI7zgY3/oCmULUBggm?=
 =?us-ascii?Q?5ld1UsPjbVI3zTeVuQ4dp8g+VWVvwkQifbHwKk7Wovx+0V5i+28Fyx5U+Ghb?=
 =?us-ascii?Q?Q2FREA1jg0go+VP3rGJ2mGea3cDJw/Yj3fjZ26O8gnY6qvO/EESvDmY8aZRF?=
 =?us-ascii?Q?5oJ+fofZZ5yle3Y8+7aP1ouSuJjdwVsSkrw6B2yzlm+87gugDHoEtG4IOGU1?=
 =?us-ascii?Q?7HbXf/Wl0nHgxDXJJnq3NNFuKTb7sL2Y3lDdp91iReSuMbaHA3yeCATztynb?=
 =?us-ascii?Q?m3hlxN8mXlCDMQydegO6xos6D5c7Aw1El2Eym8XvSgN5qdzMbcoKch5FcydK?=
 =?us-ascii?Q?q3aWMt6ciUYQ9mAigCeNHCpxfv6FKyXuSc/sgTRAn4H0mzTtMJufybJ+2M9Z?=
 =?us-ascii?Q?/ArVjEmDT9FWuBmliXKtTp08zQdnaCQjo2V9xmC8BOf5gfXCjqJLjsihWiEI?=
 =?us-ascii?Q?H7bRENw6Thx+oJjrWRjgxeeR0vOo165FPafakwsq4fd3QcIlt2ni2gY+YzRl?=
 =?us-ascii?Q?iBknzbsmTd/sTSE6/8nzMKrL64gyB4Yi6dRJh2BBlgPnqMnFDmIswApffh+K?=
 =?us-ascii?Q?Bv54IA9jfqmwiU5AdkTsGvcNKCOsFf2H+dJ/yjPiDyg2HP9eiDTZu6UnnGRF?=
 =?us-ascii?Q?8qhtdG3+aM4jk64obk/eL7n/U2JJGgsJWzOJihLNqvju6Wyx/xIS2DXZ0NQ+?=
 =?us-ascii?Q?qXxGJ6O0XH5fwVHszYWvl+DfYeEhJrZLLP7E58N92KyhEPiU/gVC950An7zI?=
 =?us-ascii?Q?hyKdn5SORN7TwJQkoqPIZpNz4VYR9T+2zEYLKyb5AI2PhpbiDyEr235yyib1?=
 =?us-ascii?Q?d45eN8lDZUnAIuREymRmnhfMcLNwyhf50TRqaI9bR9gIIczcShw11ARZstYg?=
 =?us-ascii?Q?z9LnNDycJPldhKB3dBnyZJDrtSaY5NlWqdcxCoc0RXEIM0N6ZXlSJp31QvSh?=
 =?us-ascii?Q?Te+dri6pquxsJ/fSJEjCOzj9fSq1hxqt4vz/TFXckWxCScGAtm5bkjHQo+Je?=
 =?us-ascii?Q?ayrboRxB+dPnoZWeyS9939d+HxdrUsV4AzyOkr6kRa1nqJm1D2okz2P0aExg?=
 =?us-ascii?Q?b76L1lBdlfIosHzmc1GwInc/gMG8JaPV1ki+Sk7L2DQgnTED+tG1cj0K932s?=
 =?us-ascii?Q?xuoU+8xweR0chkYK8M5n2FUzcE0oCq6VLQV9xIC1WQlOw0eWU9OZc71oZDmz?=
 =?us-ascii?Q?ilEPK2wIK6s5aGcpUwS09AOe1cFgSxFH2NPlCPo0rOETZup/LBWgu1h1+wF1?=
 =?us-ascii?Q?WPv3I7PDOvScrY4CmX/Jmd3xvx7FQ6bb1sNw7TeJsLN0H1lx26f1Nfz6R4gd?=
 =?us-ascii?Q?cmHEgRnnPK0WjiO7jfeN3y62DaVNQtmbSRPMg7HeeYyNl2Dm6ZnXOWqgHY4C?=
 =?us-ascii?Q?UcGomLhaEO8xclhQsGc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce30eb1-96eb-436b-a8e9-08dd66703744
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:57:10.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkvQ5rIbdxdiw8BsGSqSRYbzhqE3v+1lGXnvp9XuraIyG6LsNRWrJomOWZBCz1UB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

On Tue, Mar 18, 2025 at 03:00:15PM -0500, Eric W. Biederman wrote:

> There are also a lot of places where inifinband uses raw read/write on
> file descriptors.  I think last time I looked infiniband wasn't even using
> ioctl.

Yeah, that's all deprecated now, and it had some major security issue
with the 'setuid cat' attack. IIRC it was mitigated by disallowing
read/write from a process with different credentials than the process
that opened the FD. This caused regressions which were resolved by
moving to ioctl.

Today you can compile the read/write interface out of the kernel - for
the last uh 6 years or so the userspace has exclusively used ioctl.

> > You would not say that if process B creates a CAP_NET_RAW socket FD
> > and passes it to process A without CAP_NET_RAW then A should not be
> > able to use the FD.
> 
> But that is exactly what the infiniband security check were are talking
> about appears to be doing.  It is using the credentials of process A
> and failing after it was passed by process B.

I'm not sure what you are refering too? The model should be that the
process invoking the system call is the one that provides the
capability set.

It is entirely possible that the code is wrong, but the above was the
intention.

> Taking from your example above.  If process B with CAP_NET_RAW creates a
> FD for opening queue pairs and passes it to process A without
> CAP_NET_RAW then A is not able to create queue pairs.

Yes that's right, because the FD itself has no security properties at
all, it is just a conduit for calling into the kernel.

Process A cannot create raw queue pairs in the same way that Process A
cannot create raw sockets, it doesn't matter what where the FD came
from.

> That is what the code in
> drivers/infiniband/core/ubvers_cmd.c:create_qp() currenty says.

I'm not sure what you are referring to here? That function is called
on the system call path, and at least the intention was that this:

        case IB_QPT_RAW_PACKET:
                if (!capable(CAP_NET_RAW))
                        return -EPERM;
                break;

Would check the current task invoking the system call to see if that
task has the required capability.

Jason

