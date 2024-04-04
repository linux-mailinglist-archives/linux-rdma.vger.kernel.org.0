Return-Path: <linux-rdma+bounces-1780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D882B898971
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 16:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5FC2846AE
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B5129A99;
	Thu,  4 Apr 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QoWUm6vT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2127.outbound.protection.outlook.com [40.107.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475841272BB
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239287; cv=fail; b=oCPQ/B2d4ZR01KJPrOBqVr6COqhdMB/oS1lWYA+hawURxHOZIadtQpf31pczVIezA4q0jEnJ9XEtKK7SstZdwYmnNFnAIMqEg3Xas/om5Fu93XWx0dxoMQMJBgo8GPrLmPKu822PRJR4PU/fSkVydOrBoGwkicFi1zvyBI8jLoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239287; c=relaxed/simple;
	bh=Hyr1LbsefDpYin8ux8/uKNymn2OI93Od8DaY1VDUusM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NPevmxUphVahdJJsELcmDBzOalRSuDKJSDO3p0Vi2AbwuJxFl6KOsHl7cwWS/7eu5aRdgOfHiNiFWJbc8F3CqfZU3Pf/XZruaAHODmtj7VsKZZhGB26/kBEs5/dM9pj/RghquAC3X19OywozsbDqxJJtt7ALS20iitLGy7Nk1pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QoWUm6vT; arc=fail smtp.client-ip=40.107.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLyc3kN4oAmtsy2v82Cwq7uTHSip5RaCRZUsRYW5gx1l8qG6wAf6K8+/ApR3F51mSGSHk7ji4Ksv+xSupySqQgNcTH5LZU/RsuqObXUU/SiOnaBuFDsgUvARBMZBX9YcucrsAxO5wYr2TxFD7HAB3TvZWuUFNqmMgcTz87EdhO/emeZikfvO+5DF48gIo9mH2dUQm8Lk6Rz+Z9kmn0uji9nZhpGfBzRCKarAvVlr7lQDCsNI0sAlsiJUBCvMRqXS1OVyvIjhBsgXVBJOmTlJ3qbmSbk6FWUluU8cdyulLc+qZbtKxyrb+Xt91YO9gvpJiuxbeg5B2WusiKMUepIRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFn3gGn9cr9yaJ0/QC+rEbqWtWIN7+1z9FVVArDX7kA=;
 b=dt0z7vGt62tL+Zg8T0bk8gv1ZRaRLmKmYCwhhx8MsuEHAOP35PhTk4AqsUUNSl2HGlFxgd8SPCqUQ0HRVmCl6eq0Cgg/LtSHxys5DVEs8SMrFo62/kOuj4e1tERHwFEGbjB40KUdO60v72y2vgJ5EcPRBiBmnfHCaNdojDM4qoDigXaBRdQbTPyL6+k8A9myHEHH2ChzR4hCT7EIvnN8pPfzNG4SVYjGG8Ub/QSL011PoPnnCSBDistnp0mf4eho6upBU1SPlHgL99SMScu5oZMldHL5fH50VqreCPyt4J5PpE9VuJ6rDoxQpLvDKhp4MI9/TIb2TF5lGvGNMsjF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFn3gGn9cr9yaJ0/QC+rEbqWtWIN7+1z9FVVArDX7kA=;
 b=QoWUm6vTXtkUs2fNs6gRisxXxgI9aZT6dNCg8i+zR1FXfNfdekRaLsdG5HHhP7YrtjlFQrjGq8RVbL7OO+WEiKEVJVc7H4pc4VZfGOroH9ZI+3a/WlcvCAQaKpfY3euCf3fVGs5DUFhReQOBiaDDhBcFCk6L2KnxuICmnQTsaBBRgOKt0re+E20GdJEyFbElyIroAEeVxiVowDeWIUeXzAODuLjQzVYSbsyHiVPwm2vmwZ5tjpdmvB9QP3feFcp9ee/Q6bIkKootVOJJVYJYHm7hg2aM8G9JxWH+ZQp519o1tSzQv5Lpto6cDEzYAlcuTGBYnofJmZKwNwqjbS4FHw==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 14:01:14 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 14:01:14 +0000
Date: Thu, 4 Apr 2024 11:01:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Michael Guralnik <michaelgur@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/core: Add option to limit user mad receive
 list
Message-ID: <20240404140113.GJ1723999@nvidia.com>
References: <70029b5f256fbad6efbb98458deb9c46baa2c4b3.1712051390.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70029b5f256fbad6efbb98458deb9c46baa2c4b3.1712051390.git.leon@kernel.org>
X-ClientProxiedBy: SA0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:130::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ1PR12MB6362:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h4cdy+q5rafL1Mio4KD5RCj/EBro0MgJxlwwuhElcTZs9+c10JdQLKIfEs8KNx5U8sanj/dns+bRopxbKtJ3kJKe2w4EPK2rYpzNB6mocjIqTQig+Er7PvgVMBVf28xsv9NZUnAVZYx7IQNsKlHGBH1tF8T0D2z731SeDJvTlTkZB6fqHkluWHimVRcpU8pYyw+zfVcdk+ndeK4reoFor0I4N2a3mSJzEQMVEvMtSGrF5phsezmc+qGRYiO8ufTZ7E3RKVNqfzTJfZF4j0ndrxzEbspx9yLTfQ3jghaRYGJK1+Xawsc7vCeha2s8uRcyiN4iaX2TpVF9gyRUUwC40ROXjwNo2XQato5LdAv03hkLQ2MEzYfY/aKJzGY4pAvAv10g9EDr6FOVmYUJ3OrKEBAvUAarclXvZvmNAuoNf/f+cbrStUy/eksW2BTn4doIC6q+HOpTTp1ZypxEidufru5FTEot/6A4hr2YEIjESWxZPH53yk9pqrNiESrGKTB3LiCMXeDqefc+mhX92wpryU9rtbF7VK1m1oifmBL4JTSgez8ptWKd3d6yldSNY82Wa3Vl3THnk4w6wza9+vLaLN6rYBr5KDBzqj75OWHTTWdK3DD/ZPbX4udufQzP1lmVrJCfJrXgQ8WgJB6YoqzESyJUp0ae/plF+wbHkn6g5l0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gJisL/DjRS5kFX+95duYopLwb+0/EsWrkmy7pCgE7wAaE/0Vh31RY/8wTDAJ?=
 =?us-ascii?Q?T+iMBLtQ673rB81d1/liVIhs7OlqPX9rnrbT5ycA4jpSeCwns3M/vZ50D8D5?=
 =?us-ascii?Q?GapetChVwxcdfw7HdtlpNYAMMBNd259t9DefIEsv0xKjOmOF1Hxsvbodn4Lc?=
 =?us-ascii?Q?oaX7/LBw/tilxG3lnGeQ/Ic4QvVOYXMJ1nG25VZvmJkkAd7K/beiK911LnBX?=
 =?us-ascii?Q?Tjm1kWF8wFlUujz7eEyqp4ej0JGob+mitevO4gbLON4eoxFpDC4zFZCtiiyN?=
 =?us-ascii?Q?cG/N8KPqejUTbJyegEXiHDbW3hWo6zZF/NvcWVacR4nVbo9YgPWwDTxxvMuD?=
 =?us-ascii?Q?JVu9QfXP/1dAOMbLbjCwakm8wc0NoUSX5lpZ/cnRpErwQ4fUCCr5/oX7LaRL?=
 =?us-ascii?Q?qRRttSx7TAQSkZ60Urtov7AyNzYmUTQWQz4uixYeJBYQOjeE6Oh0FMOX7Hqe?=
 =?us-ascii?Q?PYLaftTgumK+2Sr1v6qswePN1IFt4gMxOoti20y/Azb/PZ7Z5lbx3LBH2gRc?=
 =?us-ascii?Q?mByvseGzpX0v3EBbbzCWNZhJK3XBli4zIiQY+hrYDkzndHHPr5dytyECLMbB?=
 =?us-ascii?Q?XqCqXPWkcNXNznvP0X6Xdba4O0JfNyzrVTisyTl5GYogqOCtcxiEd6rxoD6v?=
 =?us-ascii?Q?/0z3fhQkGLsx1uzwkEUeh1G+FwVEluMyPbmA+pj+luHkobCV1wrbqkMnKaBX?=
 =?us-ascii?Q?MTlUhGDkL3mM3EfeNaNy8pIE6wHWfmJMQRkCQTwmIEeCXRorlxaGrTUEZQ9x?=
 =?us-ascii?Q?8Au0MNp3cgnXef/rxMx8xyA1x0Hq8ze7ssX8C+rvLcMRCBCJfLJkavdGgr0f?=
 =?us-ascii?Q?0S0sLP8IaIXY95OpwxOIF9/GdVj5904hP1m+9leMREsnzMqlTBXF0dHLLTaA?=
 =?us-ascii?Q?/g5T0+fHgX2GkdSmZ0y7o53BGbVXG1PyW+GEbZbpi4V3P8XKuTB3985HO3ts?=
 =?us-ascii?Q?6f4DJZnkTTtMsZc5M+MboLtDm3Cvz9rdcbrqXbqVC6LaGD7NhKqYDKMCwq9R?=
 =?us-ascii?Q?m8XBNu96RWeSbSd50RHfW9hoo5c7FUnJXxQKaUcdjL2qpqDAVFKtb3gz1PqH?=
 =?us-ascii?Q?SvLQwJt6viXIxl45I9mjPuJwseOBoR8G2KMpDw//l6bB7uKQHar7sU3V1CJb?=
 =?us-ascii?Q?TmWIDnE0Bh0PqjiVbVxLpY0NFo3pbBFG4znO/DA4oYEeVC3tbeKPzAZ0pH4I?=
 =?us-ascii?Q?ZufSbIZJuBhBVX0FM47UhsEuh1B1NpX96sMwHgkQR3b5LL3rraGJv8BY2Nm+?=
 =?us-ascii?Q?C+phmHIuHGQT7NMBNa8187gGRGj4pF+Gfz+t4EYH95P5HuLBzrtaOihmiqFA?=
 =?us-ascii?Q?t1OAy3/og9A5EUYv2AIxn6uIwjWqRHe9tBscvUEAjX20DpOLxCmDqAr/uTiw?=
 =?us-ascii?Q?a2m/YADlN0xXTsQGoLbCW4d3dDmv2uy4QtcPLQZpOML1Ez+P63PXT2r2tI/Z?=
 =?us-ascii?Q?OJh1g59j2OWlK4KRBMHT1QCLaDrS78Z0UH9JiFF+56UKBeTTqDIh1xYkhADx?=
 =?us-ascii?Q?9TnO6Z5V5nMy+Jh7NVTTRDmJuUxniTEvI4+ZMvGDXdkpMBQyWxKa0URKilEe?=
 =?us-ascii?Q?agx3iNUQQrotMWSPXoBvwZTkzKfOk7+LuSUMvwlE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c6762e-0e8d-41f0-76c6-08dc54afb0ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 14:01:14.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX00fYDWm+qQ8KIZLAajHQ9PO7H2mnMR2dThNeXZSN0DIpXL2T8Zpo49MUDU8TPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362

On Tue, Apr 02, 2024 at 12:50:21PM +0300, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> ib_umad is keeping the received MAD packets in a list that is not
> limited in size. As the extraction of packets from this list is done
> from user-space application, there is no way to guarantee the extraction
> rate to be faster than the rate of incoming packets. This can cause to
> the list to grow uncontrollably.
> 
> As a solution, let's add new ysfs control knob for the users to limit
> the number of received MAD packets in the list.
> 
> Packets received when the list is full would be dropped. Sent packets
> that are queued on the receive list for whatever reason, like timed out
> sends, are not dropped even when the list is full.
> 
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  .../ABI/stable/sysfs-class-infiniband         | 12 ++++
>  drivers/infiniband/core/user_mad.c            | 63 ++++++++++++++++++-
>  2 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
> index 694f23a03a28..0ea9d590ab0e 100644
> --- a/Documentation/ABI/stable/sysfs-class-infiniband
> +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> @@ -275,6 +275,18 @@ Description:
>  		=============== ===========================================
>  
>  
> +What:		/sys/class/infiniband_mad/umad<N>/max_recv_list_size
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-rdma@vger.kernel.org
> +Description:
> +		(RW) Limit the size of the list of MAD packets waiting to be
> +		     read by the user-space agent.
> +		     The default value is 0, which means unlimited list size.
> +		     Packets received when the list is full will be silently
> +		     dropped.

I'm really not keen on this as a tunable, when we get to future
designs it may be hard to retain this specific behavior.

Why do we need a tunable? Can we just set it to something large and be
done with it?

Jason

