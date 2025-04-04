Return-Path: <linux-rdma+bounces-9158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91775A7C056
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D0B171D52
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D691E5B86;
	Fri,  4 Apr 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jk0MeJEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CD1EFF9D;
	Fri,  4 Apr 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779634; cv=fail; b=j8zWIH95l7KeihabFqQhWJFLo17rotLSdkPb8tBEjarm0XM09sBQwuoX60lnhE5q4mJVNZDBRG8WYc+1ksFXayfatlTsqWadhCz1VPLWHL6y22vOJWkLDEoRBheEJTE1eCmrmDuaXVr3c3lBUF4WQCyHqOfgTnzv1pOxUDJDibo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779634; c=relaxed/simple;
	bh=ZcDzANfeCrgsavSnfCKQjT9Fac5E4T1vTthHMt+CcNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qTuib3FxOVteIYgPzVDVzZvWiiAKkLBazBuymGS6VY9lxbROn/7wq32JgNkZ4BMInH+30yOh5wFdc6vf6fSF1cPz7xUNxf98bkUbiPkf0R4uQdXCUmNx5sAdDekHv0n0O/PDUB8avJ11U9iovMnoSfi729FE8smd27nUjkekyEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jk0MeJEl; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj90e7352m3CtjAmKDAs4JGHiM71RZmhaiSWrEqFX4KYqDlOGOpkxWSp4lNy48ZsRu7UVOHnKm3WyF1n6YgXTGuutYC3UVXKKDbKQvP8ummDrOrjelHc6ogYNOAd6h4R7+FrmNHKSScwXQ8CRR8dr7JdRjVS+PcNCXzPx9UrIoGf/ICQyPahC/tNweLdqz6SwP2qh9UJFbBCgoEQCwoTRJA2swoxL5hBiteuQ/HcQZGK3wp2cJKPJv/t8o793963IgEf+wVbQhYVmWc9ZMEY75f1cdatZVrnODpKAdA+iyiwl5zP8UzfmxBiL5U9tojO/6r5igfBhFXKXCuHJKpw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV2Kx1xMgDNSUZ8v/sEbS8Mmx0zfX3Uz9IgmPJzFHyE=;
 b=G5aGPlpldG9tfiPWNuYboDHaMkgl9vN9YSKyxLi9Ccin7Y763FKxlAnusjdixUuA0s7lO6u1fTyaRu24XDL+bCiB5E9Dgm3MJzR60K/oepoZMQ+0zhZPtlsc8B1cevCOppRPqwCo+ydsszgdUWBLGIfE0ucnJw7KVk6dT+OSX3d/RtR30+iqNfXVE1rFrFXhPWSSP63G7Q+mjIbq3xfTYw2AUYIxCIJzKRNXENUVKmGJ2D+4XEzwOQNGDg4lOivudQB4PZpXXalxPMzCx5LOxmd5obTlinOZowulOtq3XKaxCkv38A5JzXFvX4drxJRtChgOVu7S4t8bkdTjiAj+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV2Kx1xMgDNSUZ8v/sEbS8Mmx0zfX3Uz9IgmPJzFHyE=;
 b=Jk0MeJElJGe/C+9/FLJdE3iQRlTJpWfC19YwLx3xPNqfDn/PqFwnOzFA7jDnJvcNHgSGhbEh0bhdPv6Cv3uNtP1KPi0jHm+8lXWqYTkBCfULr6FHlk5e/CA71LdSRWn+J8x4lxGOdRfy/CkmTfsVVSXWGJQF2/78DO5fIJl/Ss9P5cGrxsv8oNh55nr/rH4qSS5QrMWjHS+vIlR4JdP/KGOy4R2QKI0EnPbHJ3/qdc/HXdfv2Uo9trYx5ghlx/v3rI/PcWMCMD64JL8M+SrFRU/o1yxwJI9FK+LesGgVP4aLnyRo1pC8OVKuwWZIRC0tu5hKqFS/zzsoyZ+pNi30sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 15:13:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Fri, 4 Apr 2025
 15:13:49 +0000
Date: Fri, 4 Apr 2025 12:13:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"serge@hallyn.com" <serge@hallyn.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250404151347.GC1336818@nvidia.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:208:237::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fc191f-f955-4aed-5d0e-08dd738b4d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bWD+UcDFzbE/tgUfo/xDvS4kTBBLZzxnm+TJv2htvt1Ex8O3wsDioS0i/5D?=
 =?us-ascii?Q?g7dYlW0P88bZ6rRVnU+x8zvtw88BPNTeP0lGFcS2rzH9dShvyar68uS9uMRQ?=
 =?us-ascii?Q?jUa5u1cnS3qspOmUUN7ugKjRnEJI8wxREnJICLn19i5O7O1HGjN22QkzHY6s?=
 =?us-ascii?Q?7BVapFYZQXswQQThgEFE6o3n/JdVjhpBOt8h24CH0BDE80bsiLGe1axeRZUq?=
 =?us-ascii?Q?4OI+237j5hSIG/s2BnZt4BBQkrTc2WCEmh8hwE8LEbCMJljpBrZNmOcUcDtX?=
 =?us-ascii?Q?Oqbw/syK6Ds6jxc7YsZ7+S/SBZg4CL4MW93nnzq2Y5z/tGUf07glnSblpGXM?=
 =?us-ascii?Q?MWwdMPVdhb431HHysH+HXajU9Z2PK5GQnzHwJHO8v0VZRHWF3BjLAVXGAglq?=
 =?us-ascii?Q?kwOtn0GliydGzAVoxdptZsya4JchS2vbYFDxplXu7PxuPamWEXqC/qDlpYcQ?=
 =?us-ascii?Q?s2zlCOz7AezCuK91xUSPaY/P6XIz+TSayfAfD8CSaUnli8bM9YtHYXd8YYjl?=
 =?us-ascii?Q?llnTf48ZmtFR5OsgjaRIJ9WMbvMcfIJnAKOVD0YSbW5KNcam6sLbs9Ama0i3?=
 =?us-ascii?Q?j1Z45Zn0GQRXDiQxT894TOZhAx0k2/uE8T1XbM9XRAcJc8fjNnVlbfdN9t0g?=
 =?us-ascii?Q?HVosHhLSj4CSuLj8Q+zzcptjALngfFLXx4wtsVyUVYKJW04XVuT6afCGiOdO?=
 =?us-ascii?Q?aJgu83H+r239/ZOynGPitwgyh7Dc2vjNhc3A5MIyGXHc+CP2aJj9VbAVFv7H?=
 =?us-ascii?Q?dpBlrMmQlm0UHp4KIzNIrYoXrrJIJBPL9sI2H7OBZcrcCNnjUmt+UdF0bEJM?=
 =?us-ascii?Q?n1DgFiwur44ph8GGIgUYPMmX+h8Im92o8XwCnA/VxHxughCnvA49nNcthj9M?=
 =?us-ascii?Q?dFSd+3Do5Ceq/udQ6xaTbNm23dGe2AVsjgaL1YEi0WNHR7k6phcBchPzbenK?=
 =?us-ascii?Q?W9YFYYBnwjCl4ziZvS0a9tsjWWvrxQth+lLWxjMkfUb/fCo9gOwXTK25+ZPq?=
 =?us-ascii?Q?40PsM5neVZq9uqoDtZAekawQFy0qU96Ijf4PS6zDDmEjD8ySSQIdmtkl+oHn?=
 =?us-ascii?Q?MYg8zZYFtWAexIohCwPMYy6z6XGQmNZBQF+NSCQyooUnJeyU7tfz+rp/aACx?=
 =?us-ascii?Q?nAL4NXZSTmK/VywbEcNtRUCN++SDx/2setJ9Ex2nup6eU+dLxgW6/8Fw0YuQ?=
 =?us-ascii?Q?wWus+aUkg2WkHGnJad/e59jRGQkPOuJ3GyZbHFqaP7dDFE8WjtXKctcsMvYX?=
 =?us-ascii?Q?Hi0yAixPXwQ0iriCBdTqHwzAt6jK36EQYxy08nMLWNflrjLlwLpuRmXm0N1L?=
 =?us-ascii?Q?JMf/RdQoHLSeZiGm73gKKug6ccmATuv4HwhTbs779fPITOkbB/b8muHIC0AB?=
 =?us-ascii?Q?9Nar/n04mU+AiYDfYtn9ZtaHgjTb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0yOty5J7rUEV/50k/Y10RbeKwTnICEZ0g9cPLBLUHgj4KTOEHwmNfSvhq262?=
 =?us-ascii?Q?BJPfWzJ78v7GEGbOJq2ef+82cwo325O3kIeYUcc+lm7l2rmaje1W8no0m24M?=
 =?us-ascii?Q?XFsOoen0FWRWyj26nt1O1u9FvKw2sWwHmwt8sxByGdTISYcyDRkbkaug054S?=
 =?us-ascii?Q?ccxWuRyBvYFEmYMlN/y5xPlCitO2NYbYvx4QLg72v+beoOku1gi7MZNrZraZ?=
 =?us-ascii?Q?7sqQy10oMFfy2kMFItYGsfTmvpzMsLBugSNOFWFQwE4KZTO30Hhy/hlBRXq+?=
 =?us-ascii?Q?1mQ7Eqm1HuwWtTAbZryO4rjTSt1fKgCrOzsen2MIwszKkxP2ynO2sOv0S1Eb?=
 =?us-ascii?Q?SwCH719Pt0x5DZflYtX7Uy+T2gcGC71KZWQfADq63IJu7r9c96pZDNLngrz8?=
 =?us-ascii?Q?BO5WyycL1mdOL1lskq9jkKAnVNbwvGSF7n6BTt4VfbIdQQ9BPc7saSPeX+sv?=
 =?us-ascii?Q?2/B1vALfe+1sKAFCxdHOyQCTBE5j5UIZwTqEAYuzSDB40UxxXVOUnlTSVZYh?=
 =?us-ascii?Q?fBZFEccpFn4zxvojY/pzCdRFRJapp3do/widcRoBfbphraiqCSJzYZDpzili?=
 =?us-ascii?Q?zyL4tWuA7Bga7qeiBhW1vlHoGyMl0ETTOw0vX4iTFq2N5RPQ4qvrGrjTCLTu?=
 =?us-ascii?Q?lSgX5Ff0dYXNWfqXEPxU6IUu0/X3eSqd5/a3LBtcl+wKl4a4wKvm1DnZl3Oz?=
 =?us-ascii?Q?Vkucepgg8UXT1kRjrHH9eydrRWY2NbnzG4rQSilA5q6maSf5y6JHkug6kDv+?=
 =?us-ascii?Q?JiE2cDl2zUH4aIUqqd5Y4Klph6GjYNSdx2x2g+x4ewjwKjycezMVkhxO2ErK?=
 =?us-ascii?Q?wYHesk8FtTfc6Y5TPF0+xhGndgCYOINDC497JTU3foAn9Ayk2mVdYZIeUTi/?=
 =?us-ascii?Q?vJ9R5Pg7dSrA8MfGtCgzoTScIrRfwLsnmZn4YJTCyo2NHWT+blTSqKV98h+/?=
 =?us-ascii?Q?LANzc7uVAatLZKhHM94to/M3xlnAGxG1+d/rbsYgIQ8fuwlWIQBC+N6fhii9?=
 =?us-ascii?Q?iKPCSt/HJVNs4l4SNeqj59Lwr4JVDvfvgdyOISHR+p0hnAmpbyCZmou9efgW?=
 =?us-ascii?Q?Ajy8xNKXs1w9Fu/a2c8cXd1mrrumxY4fuWzuAqdHC7NxmwFciY+xON+ePdCV?=
 =?us-ascii?Q?ziwFUf2DoOhwj/o4XnggyTjgE1tX/o0Sy4CK3wuc53x7E/MTA9ZTPIcnhMG/?=
 =?us-ascii?Q?hmsgWMmpFBGLV+WuZJR+vLgLI/fSqrp3YhrX7gXbv0w8URNmnE/tDkgcoBi3?=
 =?us-ascii?Q?D2UImBVRIu32+ZXUUfVw2fhWj3XuMWYlyf0UtqzLEohs1exHFpj2/AI4JCO8?=
 =?us-ascii?Q?upsYqfkiUNOHk0sS/oj9n+rlrRTfqqPOFG9/UXpnQ0hncJTL4GvupMBRwRgi?=
 =?us-ascii?Q?hMCKMlRITM6kor58Inj+OY0I/Ef2ShfQmDmSK17DmuUIRoOMSVxC0UtzB3WI?=
 =?us-ascii?Q?7X05ujOzAbWaAeNv93c/tTTqIzkrOobKzdpYmDTKhcUfDULhIyVvOp94/Ge8?=
 =?us-ascii?Q?XDTktjKfcfobIbLFHqgS18WNunx6La1c45AAAPKsFizcQpFQwXHLkEmsw47E?=
 =?us-ascii?Q?LeluEH3UKWX7NlaPGb5a4YsqKuYk2ME4OsK0tpEk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fc191f-f955-4aed-5d0e-08dd738b4d11
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 15:13:49.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBs5gc6AT4rP946pr5rJZ5EluvrBJTeP4rTQaMkswhMhj98zS59yjeM9xLrF6SXP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> To summarize,
> 
> 1. A process can open an RDMA resource (such as a raw QP, raw flow entry, or similar 'raw' resource)
> through the fd using ioctl(), if it has the appropriate capability, which in this case is CAP_NET_RAW.
> This is similar to a process that opens a raw socket.
> 
> 2. Given that RDMA uses ioctl() for resource creation, there isn't a security concern surrounding
> the read()/write() system calls.
> 
> 3. If process A, which does not have CAP_NET_RAW, passes the opened fd to another privileged
> process B, which has CAP_NET_RAW, process B can open the raw RDMA resource.
> This is still within the kernel-defined security boundary, similar to a raw socket.
> 
> 4. If process A, which has the CAP_NET_RAW capability, passes the file descriptor to Process B, which does not have CAP_NET_RAW, Process B will not be able to open the raw RDMA resource.
> 
> Do we agree on this Eric?

This is our model, I consider it uAPI, so I don't belive we can change
it without an extreme reason..

> 5. the process's capability check should be done in the right user namespace.
> (instead of current in default user ns).
> The right user namespace is the one which created the net namespace.
> This is because rdma networking resources are governed by the net namespace.

This all makes my head hurt. The right user namespace is the one that
is currently active for the invoking process, I couldn't understand
why we have net namespaces refer to user namespaces :\
 
Jason

