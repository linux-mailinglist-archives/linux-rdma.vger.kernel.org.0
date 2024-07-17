Return-Path: <linux-rdma+bounces-3896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8E993408B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 18:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1291C22CB8
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD82181BBA;
	Wed, 17 Jul 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/X2U/P2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8A1E4B0;
	Wed, 17 Jul 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234083; cv=fail; b=cFNtRmiiOrW8YvbC84VGsqA+1qlirDHEH1OqnnIhXHLpK6Ra8liic1XRr6lkcQHgXgLVwwe/v171I5EGYwnZTvfJOvmwMdHqEINwowlqabaulf2ZRux7olg9vuKF6YkaWDWiVR3cG1Zv6Ios+d+tRtCQ1danV/ct0AiAvWtar4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234083; c=relaxed/simple;
	bh=xkUO8PHsOaRIwgIzlHcTMmmguTr+CkL/I3WTaNNWU80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UKGmAM0VXYGIJWlGregRERBO6PaNk17065o4/uhWAUrnHsVEpDSiXQs1XIU0AMMNd5jcCH8JIab44Umt3pS827YObAm8C9Q0OPIytCa+BWM79NJOsj/CyyBH0itq77A6ckZVn+dMK287FHNum+dmZSV6/GktsLOGNRTnaStgTtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/X2U/P2; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTdoBkljhhscqoGP325ueFjUntIpS/4oU6I+Qh/jvL05okv/CyMhI23zms38spDhguud7g+mshKMI32CnfhHh9AN5kVyQ2Sbr0OwaVAGgVPSGtEU8ZZY8xgBPvLX8EJze3HlPc8PC1nq1nUbQXPU4/hnIqlQCSm95IhMJxRp4GyEeG5axcbadQasAGPNum81Yc8WdxuN9VBIdz+77QgQhBkX89C3HxhhYkUq9Z8Ie6vL0CZ7RYynrHxiVIZBamjVHwYhNlgsM4NEg9+xYzV/t8XeHx5+MMf0fKD401oI/ylN8D6C8sRpmdHtFZYhxBPgfCa6yGYKb9417UTbPw27lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBQBLVz2wpPiL3fxWYa0mm5nnuV3oyJFn+TYpk7f4P0=;
 b=FBx+IThLV/a9Ur0CJlsKcZkE5iFKw1eXW2GKcf1t2FMBZW1/J7oWdSjWOxqDEBPZ+oGRKratFXweI9ItQlTYrMJSyV+INnL6aRUQHMMtRIDrbxJagnJJ8TVYlGZvxDL4iUxkVB6bV+lzAwnM1QWsHdsdrpun4cY6oWRskcrzlyy3FRZlMtHKZlkX608v4IYVq9HDonHn3csf6PIV02BlQJXus9Hv0vw29lFCzbYnfHWmoA0RH2CKhew2svNMLE/P6FAk4c3OWWaKitUPR9U3gymmNBdMvavejwySqW0buepAowpBQvOg8VF6z2uOzbR6OrDzzpYK9mdWNjjscjDxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBQBLVz2wpPiL3fxWYa0mm5nnuV3oyJFn+TYpk7f4P0=;
 b=H/X2U/P2MNzmvmyiaRwOfjLHABy8Z8zYWm8yG5CZiZx0SiZXgQCon0Z9IdkbCwO200I+ehD0NZ12zsXfbOIEfSZJG5Ag6SD9ku50hnoFsUOeZCyuj1pX/Q0IIXnoewngkgZiM9DOc+jDyK2BDbuBlmSn19ZGBqskSl6ph8vDMQsu4Mn6PRayUu89RdQug3gGxrVUNZZ5pkBjjrn1f978n3Rr/Hoi1k4eiThFztrZaetuuYwT6bGa7rVCtI0SpH+Ac3pChfbbbdaQNlklYREp19C4NmxQVYyHbC3IIjnC7zBjdzF/yq2zpI/Q29pJDTpaSJrKoQd1cVBadJ5hNUQMrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 16:34:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 16:34:38 +0000
Date: Wed, 17 Jul 2024 13:34:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that
 inline data is not supported
Message-ID: <20240717163437.GG1482543@nvidia.com>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716170608.GD5630@unreal>
 <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240717062250.GE5630@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717062250.GE5630@unreal>
X-ClientProxiedBy: MN2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:fc::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: f52536c0-96f4-45b7-d818-08dca67e5a1e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EvxNoiaJFkI4aIsJkAhW2zs14gfIa28wtqYMpjDu5BwJvmooE3TXObfXGCyU?=
 =?us-ascii?Q?9ovDCYzStjrmJ6IQs3K6OJfGc9TuvnWtZDYGY75JsBA2hj42JQQkSMsKiZc9?=
 =?us-ascii?Q?CvxOYBiEsWSpHb6n86cS639VN0pqTbbFTg7uXLNl19tN5KxmDgIrpMRk1es0?=
 =?us-ascii?Q?G1orfHVxb9yEQD/ChjuQUJPI1jvD7gVFQtb14rUKC5T1kU5EM/I/Cm9RguZ2?=
 =?us-ascii?Q?pR3GN3qBSDuAXfHk31n+aV5WtzBV0YUn0UH6pwzVlsuHbrWhNUH9/FkFxknt?=
 =?us-ascii?Q?zS9lwmfiTe3OrEvPRny5eeo8p7Yg7xLOAxEpTPzpzTGZwyTxpXIgzdkEsnjG?=
 =?us-ascii?Q?4LB47+oXhlcWNeGJtDop2zEsBfYuGqljqaQ261eaUjgwu0tda+xGhZ4aVZ4G?=
 =?us-ascii?Q?c0CLHdQ+yA+cCkI1/6LJhyDN59YabReIiIENbh9rN9EMBhL7/HR7+gnFzvyg?=
 =?us-ascii?Q?VBeq5T/m0BTHJnAIMCsEuHWFmoUBdQd4oEiGHYvASzQ1eo5mIMr51Hfni/uM?=
 =?us-ascii?Q?uP0MrYUWpOITo990uMXpn7RRHhS8yW83WcYeaYrIFCg3rwSGSEPSO56aihCr?=
 =?us-ascii?Q?cDLzY+5zjqfsc7R8MP5FlLKxBYTSt7drJX1lkKcKrx4R1ed2YMSuybwmtavz?=
 =?us-ascii?Q?Nj57fb++Dw7zaKhMBYr7iRE41u5Du8ax+MT3gs+BMeEPs5KZkEPXCkxWd4Gn?=
 =?us-ascii?Q?+9YpK29bqrI+dNmwQq75YXHDMmalcZ5CLY+e+RDVGGVsJiWR+BWQJ8HewVpr?=
 =?us-ascii?Q?9SnFeT3ZcyhG57KEruVTDinmqonD1Q50c8RvdIYLOOpu+egoE0SSTlFotQR5?=
 =?us-ascii?Q?FhHPG2IVMbrRdjIWEwGq2QBo2ZoDFgaS7W4LmctLbdcOYaebPFP4lsYsUkBN?=
 =?us-ascii?Q?eU0ucJS1SSmfRtO//E3VZiGLYXxuKIM+kgcVyMLQWil0TQMOTaQpeVBCwgU7?=
 =?us-ascii?Q?r+5HDDa25Ly6SgjHzVhVteYhliWb0lteJOsjUPixb2vyUmpuZQfrOo0PPIho?=
 =?us-ascii?Q?igbIP/jtPlw5Vll1O+l28OxQy8OyWCMqYTwQXqCRVgRz/s31NejqaeVMfKPi?=
 =?us-ascii?Q?bauy6uXv7bdTEX07wnr94y/6l77//O6RHko/Sx2krl0Wlh+2usrfGUcSIayo?=
 =?us-ascii?Q?ebMOZs66bs3nHfhdL0qIVcPxZkOosDmtjg30+nQRBv4fgiUjHjVTIf2d0rXG?=
 =?us-ascii?Q?xO0TyOVYpMX8x8PJgD/FyeBHSlOj0TlJQvhrRZcPdQy2WMLCPqV1iua1mlYy?=
 =?us-ascii?Q?BAZp/WtlbS17494ERFjLqGohpe51EJijC1wxXBxLKHthROfnTe6fhok0kd7O?=
 =?us-ascii?Q?S1rY4BQTpaAzWrc3QSAdqVv21VJzib4F/KpbJt5fCDR4uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MtiQj3znbnF8quY0SsuIwREFG9jGQ4nAqCuXbbpIUq1PE7ZJsB8qr91Mw+sX?=
 =?us-ascii?Q?JHe0dZNdDPCsMvapn7wWqnmxYtWkQ/JRlI4iycmqPCREqeNfeMFwTL1A+bNh?=
 =?us-ascii?Q?M0brRxWtqIlhyRqzXIh6wOHN0DW03y2WNKGii5fs41FRsOKE0jI42CUPYma8?=
 =?us-ascii?Q?tbnBFuyE5A7M8bLC5xJjIHUjGZ8uCG7Lwfml9Ik8b0nDEsRiumbUvjeTmbNO?=
 =?us-ascii?Q?S/SN+B1J5F6p+ZL4V9p308ezw+CZq9QdBaZ/TTTDx5iIA345CSjuk+LD7s/s?=
 =?us-ascii?Q?J77G7+e30/EgZTbP94vYOvjnM6KGIcjwQkPRff3jSN/iudwtQJ/JskppPN+5?=
 =?us-ascii?Q?7IALjY7G+1X9oMuC2iLyIoVXVKmKryYXM5DsJedX/kOaAXYx5Kcez/DQjEkX?=
 =?us-ascii?Q?S+UGrLLPJX/slcQFYqLJqIAVZyvrElQbDRNWd4tMrFPLtT64e1d7khCqNvg9?=
 =?us-ascii?Q?ZZ+0vNbWpb9FEnEqK7DEUSx5faEUS1oMwwQvUFpu72DTO40HkSFTxo5msDKM?=
 =?us-ascii?Q?qbNfvL0CJbuyYoo81JVcceX+hZeQJ3eG4dTpStRpDdgaDU38xfJhxQ2XYCF2?=
 =?us-ascii?Q?b8aM1GF6okX8oRTz6dCN7tblLS7X6jx1ivWk08JyRcnT7Qvd/KdiK193aGvf?=
 =?us-ascii?Q?jPT7fSyZbtwgUijBRnWGomTJrRyEeMB8s3B/hf9BBIDHWFen7SicMC6iHlHV?=
 =?us-ascii?Q?I2hxZp7ORAEXwPQwVFCrU97O1sueMBLD+uLTHRs499GEKbnY8qjglCywONmZ?=
 =?us-ascii?Q?r2WI5c/lPkWcCIko2N4Aj2iGqQMLQjjyQSsylFfGCUDcvNgdy4y5AU8I4yZb?=
 =?us-ascii?Q?M5tFVzPcEL8dvfBmJmhs3Ctb11tEXFvXCn4lvMbEL58wZRXU/2/X/E+hyBi3?=
 =?us-ascii?Q?TCSVb/nhpi9TesSndIl2ZVD7pTRq97eitLVgoYkFtwJoQhyzG2wBnPHtjjsy?=
 =?us-ascii?Q?vnVrXFYNxVwKhS81CWklY1HRs3DOojgYLiuGgIk3bgOJILHl4/jjsRQgpenY?=
 =?us-ascii?Q?+2fN+bd6euADo6gCdnf6/aG2Lafn9wpyQxtFHzVr1UbIhVYQmBOCsFB2pmZO?=
 =?us-ascii?Q?65PQ6rzxBWbQcCQEz0Mb/kCetSUr7JY89BIUm2XrGgwyIJKHnM1voptdlat0?=
 =?us-ascii?Q?H6JUfB1JhWOm5upp3g+ROw3xozLrpovtLwJqZ0yqgtwG5UBu900SAktkmfzq?=
 =?us-ascii?Q?+hXTu+xBxzkmXomymLtXwwaQczSIHsLDU6n/kfowj/om0Rggx9hkcnx7y3fB?=
 =?us-ascii?Q?Z4foIHV4X0lXJaC8rJ31ST7YEzLygCF9QiSmdyTt989mk/NaJFnX2VYK+CxK?=
 =?us-ascii?Q?nGzWuOtQowZE27GhRQjL/K1cI0DoHjKS4nfHqIPqMhfZW2c1TcoEZD1zIdSF?=
 =?us-ascii?Q?3XxpLXQQ9eeXbT0mTdkzMPkFSWM49m/0x3msrz6oq3jFw+G7sJNnwdkZ9tQK?=
 =?us-ascii?Q?oM0M0iAPugizE4dTNfekaFRwCBeHzGvovYgkUWwxKUoQNVieUuohW0loWSdT?=
 =?us-ascii?Q?SRlqUROBchCazqik7JZQNFE4MQzXjrqgwIYNh3iz1jsL+fL7p63SbLK79zpZ?=
 =?us-ascii?Q?xPHpAzxYEFgJy5CZhjBQgHUGh5J0njL480joTJAn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52536c0-96f4-45b7-d818-08dca67e5a1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 16:34:38.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lx12Sx6wWu3TAtN8aYRJj8e16f0XteJqmB5OPWfcVdh1iI92UCw1dbabVRhZpHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

On Wed, Jul 17, 2024 at 09:22:50AM +0300, Leon Romanovsky wrote:
> On Tue, Jul 16, 2024 at 05:25:22PM +0000, Konstantin Taranov wrote:
> > > 
> > > Yes, you are. If user asked for specific functionality (max_inline_data != 0) and
> > > your device doesn't support it, you should return an error.
> > > 
> > > pvrdma, mlx4 and rvt are not good examples, they should return an error as
> > > well, but because of being legacy code, we won't change them.
> > > 
> > > Thanks
> > > 
> > 
> > I see. So I guess we can return a larger value, but not smaller. Right?
> > I will send v2 that fails QP creation then.
> > 
> > In this case, may I submit a patch to rdma-core that queries device caps before
> > trying to create a qp in rdma_client.c and rdma_server.c? As that code violates
> > what you described.
> 
> Let's ask Jason, why is that? Do we allow to ignore max_inline_data?
> 
> librdmacm/examples/rdma_client.c
>   63         memset(&attr, 0, sizeof attr);
>   64         attr.cap.max_send_wr = attr.cap.max_recv_wr = 1;
>   65         attr.cap.max_send_sge = attr.cap.max_recv_sge = 1;
>   66         attr.cap.max_inline_data = 16;
>   67         attr.qp_context = id;
>   68         attr.sq_sig_all = 1;
>   69         ret = rdma_create_ep(&id, res, NULL, &attr);
>   70         // Check to see if we got inline data allowed or not
>   71         if (attr.cap.max_inline_data >= 16)
>   72                 send_flags = IBV_SEND_INLINE;
>   73         else
>   74                 printf("rdma_client: device doesn't support IBV_SEND_INLINE, "
>   75                        "using sge sends\n");

I think the idea expressed in this code is that if max_inline_data
requested too much it would be limited to the device capability.

ie qp creation should limit the requests values to what the HW can do,
similar to how entries and other work.

If the HW has no support it should return - for max_inline_data not an
error, I guess?

Jason

