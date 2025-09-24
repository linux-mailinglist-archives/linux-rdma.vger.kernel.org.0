Return-Path: <linux-rdma+bounces-13622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA31B9A21A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0AE321B12
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023A0305946;
	Wed, 24 Sep 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hctFHRlC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938A2E2657;
	Wed, 24 Sep 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722217; cv=fail; b=rkNMv9KxZrlYZrUqNY9PaP2/UtAZl0c+eUS/sMNHefdo6vzmOrUn5mFItZ0nQrEnOXNbnGgDlJs+atJ1+xfbatg2hCN4ucPEv/oLSBdFmzUh7J3TLw9dbYSAJLqdagYX05q6+S89qHVRLnbkiDwvQdbEfLr5tLIMmRFZu2BVAsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722217; c=relaxed/simple;
	bh=FEGdS5L8KOc1WH9B3FaxBaj95tFw/Nz6XbEDKDcMzW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pi9QJ5np8ibiO7zI9RvBJF+3op5qLIPc7UqLySgTbN9//q4PdBCAwKfySxRGaDxB21wExso+Xhp0wtw86IH6D6JrIkWCzVk3HhUn8BT1dkPwEyr9glhOScf8pBCAJdDXoWMWG7NFebe6+Bsoz+iB0Vovx3K0JI5XlHOBJ353aZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hctFHRlC; arc=fail smtp.client-ip=52.101.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqjUagQiY0X7Y4hve4JQnoct7W/qS8KMwBpB+VI2ZnPvtz0RhqqFo7NOxU6tY6wi8s3LXkwhqKz3asuiW79p0m8qAYrzYok+tTisPjwPYDHxayXeieAPkbUXkeb/SOLi5YR17wEIPIm9CIXgER4KLaxILU+HAFfUynyVPBLTm45r0Nm+irZ1Jy67WrwmyCzfWoCeu6AkhaOg11Rm/uYD816mVUAgZpqNJjS0EseSjQziKLYcmzubuVuugVEcQbiqoaiRZ/oyEt9BnLXeTTKVnhDvAajWP/uRSZhJeoInaXYS9UU0lqrTRDFcPpNwpp+gNf1Gl7dDVbBNz1nyIfFGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBlK/OZtDPVMOlt87CTorgcKJ4cmgalttRa7d9sHOpM=;
 b=X2sB+cgyBSXAHJf/EWh30DY0cYIPvTSA1Q9Ca7+Z/iALR/35OthGDxnSohzdrpNxdB1P5wq4QkaefDpTkgE7+0P8HGFjdLaCnqovtm9cOpZpquAPYJ2CcKoBQ6RMY0hX3BfnsTkaotAA4eTvJZ6aVaFggdvhurK8O72T3MPQDkQyETJc5Mip0Ku0DjOzeNdKib7IMnl2cGcx+hwgz0YY1g3ukC3Mv3ptGkGHOCqIldh9uxmgjL8Y43lOsWMwD3ApzUoUB8MATgWvdLZD2KluI0iBGajvW8M5+lpX6q9/E/3rbm2rmNvIQpRbDgF60jKHiVaJ4ILcQn3CPzjGfgMn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBlK/OZtDPVMOlt87CTorgcKJ4cmgalttRa7d9sHOpM=;
 b=hctFHRlCLT9+Qj4l6TGwmFRjJhtWYx6DRNa3L+irPlx0Ic3vPq0CEx2kBeFowvA5F5IqbPttZWcXXrIkNd74nn8jcZH/vEk8OIoMHIR5UO8qEkVvPGBSe/PClStM5LzXKKUcCBG+BszLVlreTQplrBPaXuTXDltAv8rl99JLtgTAUQzj0Ue88FHUDn2JS27/yPoFIyOFPruj305q+dFli0FvVN2Yo5Sl7UaX7AC3QVk/h3oN1aR1gnTxs6/pTRXlhDsOMvv+kBPXsYiW8nRsqO+O0UWR/pTJsIGQTjRrmE3j54egbaXv0oYUQsa6Nwab1K7poHJ1bSKDeenKNEmkOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 13:56:54 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 13:56:54 +0000
Date: Wed, 24 Sep 2025 10:56:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 rdma-next] RDMA/bnxt_re: improve clarity in ALLOC_PAGE
 handler
Message-ID: <20250924135652.GC2674496@nvidia.com>
References: <20250924110130.340195-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924110130.340195-1-alok.a.tiwari@oracle.com>
X-ClientProxiedBy: BLAPR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:208:32f::14) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: b218b12d-9a11-4d57-ba08-08ddfb7237cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OaLvVPCT9G7sJQiAmX3/OW9Ut6i/Z4orGT1CnT+sMXMBa/ut21HyrkHNGlWV?=
 =?us-ascii?Q?gghjriTfuncHxxfKz34U9j7hXpZjpixJvILqAb/1Pouk+bPvR+uaHwjr8b61?=
 =?us-ascii?Q?BAGL2+16oGNhKxwHCsKYb4hjZa6PK1SCTazc3/8pkxSkTNndKlO9r+c38QCU?=
 =?us-ascii?Q?qL/QQFt94+RCbL7gu+/LnP1OCOAdIShlE2zd9bNIEKkZQDj6heYYkT9sWvvm?=
 =?us-ascii?Q?RF7X5PlbIYG6h8AELW9RPbwcz74im9PI5YvHTGVibFyJKTqmFZj4+S2OJJI9?=
 =?us-ascii?Q?7wXfpnxcTC/aE5T/2GJW4tlASp1F0LSZEyzMfYn6CE38GKExhLSbmM6AknAs?=
 =?us-ascii?Q?rQkS5wcbn0t+Guuw/Q1J7mRnSO7k7817QH0nGGKke1QmITr1EuJ+/50ZcsHV?=
 =?us-ascii?Q?ycbqFPR+owDDHFP5kn2fRCoJzp9Dhp3MVO0Ba7NHmai1+53B16sOOolPZ2dE?=
 =?us-ascii?Q?K8E1jh31dksY42iXErLfiQ21/bJftdymT8U/urz3n/QW68vhZS9MmR8bJL2w?=
 =?us-ascii?Q?MzD/ooQwk/femx+prmrFDA35EkBd1HgH1UrDU1ysohoxahaK/fDnMA2lg/wO?=
 =?us-ascii?Q?jsDaEGoBzD5sgE9yElNglGCOrty2vs3spJc4doX0FlqmYtRU6BImmFyLxHh/?=
 =?us-ascii?Q?5/2BB1nbwFnwAjRxCe/OeL/mG62LeUH+ePr4tvZJM7rg1dTtoJANqELrmLlk?=
 =?us-ascii?Q?Hk0N8o8Osnfzi4WQkabk4qa5/8Na+wueYiZsjIfBGdWlOmM+3YUissx+1vdi?=
 =?us-ascii?Q?9Avp95YbyuzfOkznSfhBDnkbIb833jJnYMNG+uJ9tparg2d2y9fqNez3mHyF?=
 =?us-ascii?Q?tv/a/ehIECd9PsrL+STdVmzoEri1qzLVfgMhYn5AsMYZdlbzecAefT67Wn9+?=
 =?us-ascii?Q?fvt9engXGhHMcRzELCXH76oURW9TauPOv3Sj5wMTOqVFELq+3Ef+r3b7Pi59?=
 =?us-ascii?Q?BSw3XwkznmTX7me0pVH22zedSED5zQTw0LxFmAgxD1T34+zSyLRPzXCYX7F0?=
 =?us-ascii?Q?I+VSVefI+ZMNDkJbNdggDsL7O4GVdKgDaXLhDbsHu+SbA7JxoQjsGDTgsmu/?=
 =?us-ascii?Q?Clf3brcx2oFS/e7GQLiJj0OasOxmczDKT76dvLJ1awS6EFHHrPhFz27Vn/5Y?=
 =?us-ascii?Q?i46Pq5bucVpIME1bd6+JP1ySPRGxSBYt4vS8BgtEiKxrWvHIRJRSONFkcfk6?=
 =?us-ascii?Q?6QPpvmTD3MzLEfGhhHbRjEpIe8loaPR4/HPBGmt3mvHca8j/yZafvQ+WXiH5?=
 =?us-ascii?Q?eoxscNkGwmaBbM5q1i5v2xzOnd1NiYKHP0y6S5xhtbeL8g47dJ7e9L1OQ4tJ?=
 =?us-ascii?Q?5xwxonev2fizOuUOXbiuUhnIFROJeKv51he6Y/S9z6nTr+aVso+CzZOHNaX6?=
 =?us-ascii?Q?Pp812MlTShKqkIi/i8S32hIyuVHoZVjikTKVZv6KUUB+JtBApRKaB8HklVx8?=
 =?us-ascii?Q?TJpKihGnwtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CTqS38Guu0lbhs/6vC+AfpzH38qsj4BUJYNqALAVbyQyJ0caZY1R9vb27MOh?=
 =?us-ascii?Q?ToFN1TEhkkz5UUhRRhqRXlEi5bYTmPQlc1HKoF3DGtR+f4x8RKOeZFQk5Kis?=
 =?us-ascii?Q?HXuFb5FfoqoMR/D8FYS3RXiqOw6q9k79i5zCG3oeh0IapIJbVVLDNipo0nJ9?=
 =?us-ascii?Q?Tk3j8mUs3barekuXXudfeiuJM0CF7pjF2RuPTAYAdu1+tN9Fe/vMXmscipli?=
 =?us-ascii?Q?7pogLJ0C+CnuW+J11Km1qX/djpibYieUqxgLyknZ44DVUGQdgxgPHH709Km9?=
 =?us-ascii?Q?+OQQa/AScQUk8cOptCueO/UbUL/lL/AqJDJgMADw/j6CH/XLctKxIa9PpEtk?=
 =?us-ascii?Q?GxQXeb6D9Z1KD1TQbhajENx2ZIZYkVL4K0dFCmjaDpfDoIWbPRYsHU67ffpu?=
 =?us-ascii?Q?08VPgUF/8VvxYEFeD7cYlwiz2QKXM/3ulX+1AaHEN7d6G26YumSZ1FaA0kwE?=
 =?us-ascii?Q?ZfsSvUZorbzOFaimBPjWTum7jpYrrkWMqGB6zIYCsi42bWaAAviUmOH81dfu?=
 =?us-ascii?Q?1c0BEn4z1i7S+UDwbaW7kcUkZIJ7xXrX+/hyobD8gy+sJES8un6V40rsRXTS?=
 =?us-ascii?Q?nt2bKLCG8PuxqOnqs11LalHIpQAR2MiVfn1mcNzMqeQoaYhDAd7WLmshSJZ5?=
 =?us-ascii?Q?/RfUHo/amxb+ceQNp9t7ZKdj8PJJGWvotOJgXVBGviNV6l+dH9cepsDv6MXx?=
 =?us-ascii?Q?jIG5a3oCoj67g2UVSZA2LKM1NrY7WYWxOB0fhs1F2/SIBqIFkqlae4ngm60x?=
 =?us-ascii?Q?N9FTQuRYXW+vUOdvquTLidiTZINydWPCyWZlUNzXJcwVgWoU4rZN7cE//Zhr?=
 =?us-ascii?Q?SbDt6qEWja6EbQKJAJ7YGaT2YIUH8uKSjTR/ROt+raedSn1Kcpb9/hidgCtV?=
 =?us-ascii?Q?yhzrsefQyfD90S3s/EgxY9MQR87TNBQ+8oQvkva4tgfdDRmYxIBS+GbQCEzL?=
 =?us-ascii?Q?E7OPkTXELJtg/xjLTR+I5lpstJg+eznM/mbzfMfH3aeoRCnNTyBNNFvmc+QJ?=
 =?us-ascii?Q?eXd5Gsc9TIumUuooka/q6blCt9crMIyvRL+g2HnE1y/Pfqxt3m4w6J19KxGR?=
 =?us-ascii?Q?Pi3xHG4bSNY4uwAPrebcWFwROLuz0CjtVpAQhRuhLNcap/0OzIpVL8bqWUZl?=
 =?us-ascii?Q?OkUu28oRCwDZbkNup82pQVxjytku6MNEZ3ZQF0+kxZa7XASRhiJRFDnxEOJk?=
 =?us-ascii?Q?C6BqFvayxj8P7DXjM3nnP6uGSrkRGrTrjwtWVm4Iw/SA1Q9GlNYWWDewL6D9?=
 =?us-ascii?Q?CdjtMvM9fWU2+ynbLbYYvXc+jM3/cojs22Wwmq5sXxWILR1kbpsd/nncT9VW?=
 =?us-ascii?Q?4f7oD0HI1afTF6cD6UCE28JWxzDRqf6Lzhgj0OmaIiNpqiQ+5O1NK0RQhUtN?=
 =?us-ascii?Q?GvcJOXeO8SltKuODaEtnIwDUJrCTPMj1AYDmPbmjt/d4GOjexJgl5hyrWxUw?=
 =?us-ascii?Q?c9gAkQctOVjhB5LcmWGKRiaR6t68UOrkoMHgcXmR+12YstYIKB3dyAmF76Vo?=
 =?us-ascii?Q?8L6yEiVOpaHyGCz/KBDdI6DM9SsVsbylCiIy1P12IlOZ/pLS8DLf6TTc9gBy?=
 =?us-ascii?Q?U13vvc0xM0I/eiRPKzqUfn4y0JFc+FTXDeU8RDEB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b218b12d-9a11-4d57-ba08-08ddfb7237cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:56:53.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsNCy5h65G1JIYDpShLgIEDfTKROKkgwsiiadwL1Pi29Xx/FzaWURCvfyKIrGtZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

On Wed, Sep 24, 2025 at 04:01:27AM -0700, Alok Tiwari wrote:
> Update uverbs_copy_to call to use sizeof(dpi) instead of sizeof(length)
> when copying the device page index (DPI) back to user space. Both dpi
> and length are declared as u32, so this change has no functional impact
> but makes the code clearer.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> v1 ->  v2
> added Reviewed-by: Kalesh AP
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

