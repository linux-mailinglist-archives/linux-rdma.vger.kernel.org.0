Return-Path: <linux-rdma+bounces-5237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D3991045
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7BA281EAF
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39B1DDC23;
	Fri,  4 Oct 2024 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E5a/OHmC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D51DDC1B
	for <linux-rdma@vger.kernel.org>; Fri,  4 Oct 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072333; cv=fail; b=qCGUAww0FR3d3/KpFUNZDrRQ872ZmNuckYdmuh0FP0QEjl6wCjh3JtOeqQSoDcd2ZuSH1xIK6d1i3bQ27KMwrEwaJLh6ZrwdkpHINn6RWCMmaVmiGEw7pCEXJeNdYYUXkLjSV7zzWrS3NVDvoTnP9nK2yZDlV6l/BVgAnHVCyHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072333; c=relaxed/simple;
	bh=sFR11XRDAL3LSKyJMzzxamJ7MK6lDWMr1wheDvqhzXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XkUT+TzPOCk7nd6ni9BDXihpRIsSlof/2H+KvxJAQBZxrnBqn+ajX2HtyQioI7LQEI4jmnr2wCs9agkG7rRMPSlg6mY7KLEH+4zZMbvikANEtNfX0eHje76Cfq1bWVPBZRv/09WMGCj5qR3jGIjQ5RaLKMwiMuURysb3TQcaznA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E5a/OHmC; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3h+hhHujqRm/qIdHqFmWPld3ftJJFHKv1M8tnDtGBD5T/589rHrhE+zw3yVjPOSOAVGzwABDi3XQ2fBckwVh/RPnWN55eCdZOXGJgw5BmywSnZmhuPVlyss3CMBfRSoU9bPqGaFDty0JA46t7jGkWGKmvKZNMcDz4Ue0wyRVGLU/KwRb1zD4/2HWX9bp1mh00d4ERfWK1srh5LwLFePg2M7GkuxUWrwUBz64wwt5DjaEXOsrAV6bIGZNdEH//HgmycIflS5ktZCeAihIfZWNskehQtykLVVstd+ftKDp/yxYksbJoOb0JBtory2eFNuLOXjGV5NKcmLDt8GR68j5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRWgwHwONYDDPMtrJJGoaLeuphogdmfdchjKNwPpRYM=;
 b=tJUu0nx+jcQbDxjXDgKbW/S0SHMuBblyiEUiQPQGEFR41u5iFD7MUUWzkhtF2B/sNRt7Tdfg4NdVUT13Iwaoufu72xxo5nlgeO29AKRLc8ir56cF2OfoBpmIRcp9xcKPxaXn1KGZe83e3kRvnvSykZ4axcjlu+H2pS4CBmCopNmK1CHgn0x3fUnN36gs3KotDXB82LZT4NgSe/pLuCChWnwpNjQ/Rw7aZIiCeZT/ZMM6zFRqqxAibmiGBiJP8CdOS81CJIntncRIAs5aJOchYc1b8OXHqZf1gKp1fTBo0bRpOGkuEd5IFdR9gepgPmxQc0wHOrj0DJaYfQIWmjADcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRWgwHwONYDDPMtrJJGoaLeuphogdmfdchjKNwPpRYM=;
 b=E5a/OHmC9rNsg6nz5VVjnI5k4RCGDYVAfhiW7LbBxiTb1mE0cxljVaSVWB0B+OUvGu4w6dhwrHQheoZSyNcpl1xTL84ZMcTD4dmodzO+kqQaWqFRJwbgts8cOlgE8hjNqribIGZcV2BTZHE90zI5INnF18IjPlPuP9Fv6r+oPh0YqzUOR9bdkusweG5hrJNcsn4rtiM/cZfhxlbsOPk5bBWKg9Aq6zA6pQytnhggm6F55JAhxpCbcv1QACq0QIxhCrAS0qDNcYghcXFVhrp6HIXpaI7jKiwsmsgKc9ACNMwRLMZGCBrL0M738jN3fKtfdUDRKJ6OWjJHLa9ZFCJgRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 20:05:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 20:05:28 +0000
Date: Fri, 4 Oct 2024 17:05:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH v2 for-rc 0/6] RDMA/bnxt_re: Bug fixes for 6.12 kernel
Message-ID: <20241004200526.GA3293872@nvidia.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BLAPR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:208:32f::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 414cd1e4-200a-4e55-08cc-08dce4afe42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efWSjYnlDVvK6MkpYtIBCxrrP1ibz8uN4H9jDSzHdcazulzd9TWRV+7GEs1N?=
 =?us-ascii?Q?1jOfnbtU9yNJ4dZztgHWJBilAYypW1V4+Qb/z9PNtRiUp3UrYHoVDxVs0oDG?=
 =?us-ascii?Q?6WCXnhwMv+18vQcvqBDi+tXxWJuIoakP5S9LrByflIrqxKujQmETj5GxFrwL?=
 =?us-ascii?Q?1z5xcR1cFwo1TCKu5vwdR7ZIU6X5EjCUKI7XqCIdeX8mh1ma7EKJmLlvwz/J?=
 =?us-ascii?Q?RhW1lgH4pSEH2/4pPB+d8vkZZH4lxNdGe6DEMu4+z8sAGvYQnpPHMCqaNVxY?=
 =?us-ascii?Q?ybjdkQhumipl646OmuMxRuDNbINxrFp8ExQ5zI3T2yQ6BNpc6Y1Y94C50NHM?=
 =?us-ascii?Q?dojy9tAyEYzMfIXyYoiTCNVQXQ3O0UOA4oIGBVGD8fIyJNofF/VwWjC2s7Bm?=
 =?us-ascii?Q?iHhWpyMehAy8eBFJ4R0rtBUhI8YA7JfuZkEXNlVN+mbMD+r09JeLa+Bkn2wY?=
 =?us-ascii?Q?0/H60ebqubYI9km/sDb10wp1YZ4ywRB3WrZ/MVGF+eQFiC1JJHnZ/hmrUjDW?=
 =?us-ascii?Q?+bJCe0wZcXDpteEKpjAicE0OwXhCQ666Z+Q50O5wBgo4o+pBHNyfvUS8jXnj?=
 =?us-ascii?Q?g61/wVQFDyUbW3Dyj9rEtvYznYpnPBMQhiEawq9z4c+g7KrV77HZ9AQ3egcu?=
 =?us-ascii?Q?5Sj/LjJuYQ7MJhJCSKVP6Z2RkBY0/gCZfa+gaU1nyDnUvV7ZromqaL6wIf8q?=
 =?us-ascii?Q?vM6zKr+x0b7PTm+sMM6bBpMqibEY4DXfmpRi9sH6zNTZMWyW7IwpXKDJ7OfT?=
 =?us-ascii?Q?+z+JSEGMGv2lmdYUlQEVucYF2hvD3rDV9L6utAyxIzowMoIQVERgPa/IpHZW?=
 =?us-ascii?Q?2bSSkw/eKAG2iofDBaAfumjEZh25MzZqYn3YAtcbYo8g2UfFFbf6qQs4zTOK?=
 =?us-ascii?Q?sXde8RitzwWw1JBWlairaAfgUYan+HMH3xxlgVTPu8uUp2TcNuWnRWE8Dmwb?=
 =?us-ascii?Q?wnYFolby7AqaAW3dUYUfv97ruy3b+VvmFXyd8EzdInCl+7T3tBuEagDthK5z?=
 =?us-ascii?Q?bSh8q2A+0HeTDETbREXE6IKkAvpr8Oa25JHISNf4ntIvwJAKkp7WTtyJBZNo?=
 =?us-ascii?Q?w9JhVDqhAgqPAGc7bLaJ8snVVT3GypiC3GYiEcAp0VdNGb8NlqwCkrLRhOaN?=
 =?us-ascii?Q?UM2Bkg2VJpYcnfJqP+cBLY38TVUDX5voJYDdYBNMMOE+LtOBnUK91WFr+DrK?=
 =?us-ascii?Q?DJmNu2EL2y0dn58JoKQTzOEmN1GQy07xYuhsP8ayyvZldtKZOwX1xFYKrrl4?=
 =?us-ascii?Q?9+MWxp3OBLLwMD49NJYNffYWuhCOyBsDQ+CPtytwQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3ZgrtrQA4RO2+IkeGco5CQ+N871ZqLdNk1bUXRg91y9NdqigmvRa+Bag3NC?=
 =?us-ascii?Q?Eg7gMBQlWn+lIbHFJwTQeqGnbeE1V0k4YZ6yO6bLlhK+tE4rzqMRuu5+X/4W?=
 =?us-ascii?Q?tW1viA76cUiEnbgVHZ4N/zCX/7MQMkJU2bdOX7vPOHJAf6HmIvOoH2fU4FTO?=
 =?us-ascii?Q?6v49xXyyGrUCkeopA0BJFVq2Tv41pHAENiTxB0ObMMA7MqiiYphtvLu/YgIl?=
 =?us-ascii?Q?kFgXZjV680veUQ71LdxVR96IaTcRKpuxX5nZZMEQt2xe6kbpfKKRv+8Eafrg?=
 =?us-ascii?Q?C+MXSqV2PN5qq46W8pck/7CyrSZvCz8665RbzHewhX8NrSUMWqJgE2zWVZpB?=
 =?us-ascii?Q?jvzp10x8YYF8pxnsUOklarDZTuIZn4CX1MCGDNMG+oKhZi8oO07YpcyAJdD5?=
 =?us-ascii?Q?LUklD0DVqh0VTRm9YHW7pfUFU77jfWxUxpOJpjCr4z0V5upjPxdR5SmmchVc?=
 =?us-ascii?Q?RLBuur22RDR47HHMuDPFHywk2Iegb+ptjF9pgnitkmbx0BzBDXCwxFskc95Q?=
 =?us-ascii?Q?H2zbMf77tooYYwNAUcdJOWt//HWGmaCdb9wiZO9RuH/9H/wC8QUsLaHpegzS?=
 =?us-ascii?Q?/wOOCU8+GZs3DBw/1ITYECBLgp2Eiy+9/9NierdzAencvF9l65L5bCy5ENM2?=
 =?us-ascii?Q?+bktp0HBJWARKtlasyAdiq0kfEWYYQXGIwct5SJathJxP6W71/GXuCLP+2Aw?=
 =?us-ascii?Q?uUnPY5Xq50VlmQrJfpYCVAj2x4TDnDhWzXiwYCL/8uchazrlZdU2hX1D4ly/?=
 =?us-ascii?Q?O5tJ0ndqVOwmAj8W21RZ+QYgsZMbV76WD4r9q0cSwmnoMST3tpEM2h7cFbt/?=
 =?us-ascii?Q?iHiH0wWioh/14N8BhTrDovR5ImSLGfBosf/rcvvL3RftUCZhGkqh6s6XIZYY?=
 =?us-ascii?Q?Xu+M+hP/yFRpJ2T7FkWiKHCWZUa22co7Ok55RVu+ymhsLKP1pKn41XqXT8GN?=
 =?us-ascii?Q?ZWQLfZnUmALMp98syKNMIxKyB9qr8gK+uInVw7+werJoQJoXE0nlNpVXU/Id?=
 =?us-ascii?Q?b86JDLH3TRWmFx73SOuKm5S2tVi40D3Fg75+BoNwyZy7OmYeWrlvQNYeTewg?=
 =?us-ascii?Q?0QELpTTgWghxfq7JuWd5KbJ4c2h0dYKEzi/l2wpv4jHmz2LTRWO4WymvfIYb?=
 =?us-ascii?Q?J2hosidshKRLLkFgPe+qcKy3UkofkrnOV0puBcgRzE7zbRpL+hxRYdh7FOTj?=
 =?us-ascii?Q?PAOwj8JbDJbmwVJZF1abMG/OCYg24pyoeUhuJpPolnzglqmSN7AjXH7X6o2b?=
 =?us-ascii?Q?Nis42L2zq2xEPD0rthPm7zJGsS1zqE3bRelHbIZAcFX/hj+UxLjSH5UN5YLw?=
 =?us-ascii?Q?9fsC0ZacN5VD3DXt9y8hE4uSX0paUAZhN9GUFdVTdA8bj+y6jm3+1eDuzPFo?=
 =?us-ascii?Q?93Mbo9CTXUT9mJplw1PRGmksA5+fdW0Q7+9kHHBE0yC92FcoQ5UlNKK0kmck?=
 =?us-ascii?Q?uhgj/E9QLmi1BfhKQnvGUwfxvUHrExgVjYXfW4jbEHveU6U0Nokw4/QxJMli?=
 =?us-ascii?Q?P6VZLqMYQKqfP/CGPbJNE6JOKOFwp+aUiq/Z8ADKJl5CBnMR3UGQKbx4E+QV?=
 =?us-ascii?Q?+aVU15C6D9UwJLVzQHY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414cd1e4-200a-4e55-08cc-08dce4afe42b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:05:28.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1plkJbi5mFX6VmD0O57OyFfUXIMOd90J6Mx86kQUD8BHYTRmjwdVd0KYkBATer5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528

On Wed, Sep 18, 2024 at 08:05:55PM -0700, Selvin Xavier wrote:
> Few generic fixes in bnxt_re driver for 6.12 kernel.
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> v1 - v2: 
> 	- Add a patch that removes irq variant of spinlock and use
> 	  spin_lock_bh as the control path processing happens from
> 	  tasklet context
> 	- Address the comments from Zhu Yanjun by initializing the
> 	  newly added spin lock.
> 	- One more fix included in the series
> 
> Kalesh AP (2):
>   RDMA/bnxt_re: Fix a possible memory leak
>   RDMA/bnxt_re: Add a check for memory allocation
> 
> Saravanan Vajravel (1):
>   RDMA/bnxt_re: Fix incorrect AVID type in WQE structure
> 
> Selvin Xavier (3):
>   RDMA/bnxt_re: Fix the max WQEs used in Static WQE mode

Applied to for-rc

>   RDMA/bnxt_re: Fix the usage of control path spin locks
>   RDMA/bnxt_re: synchronize the qp-handle table array

I deferred these two with remarks

Thanks,
Jason

