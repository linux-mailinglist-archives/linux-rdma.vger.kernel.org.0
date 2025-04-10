Return-Path: <linux-rdma+bounces-9337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB64A84858
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 17:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D743AFE28
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9681EDA3C;
	Thu, 10 Apr 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rsYzS0o4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85381DC9B3;
	Thu, 10 Apr 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299959; cv=fail; b=upNF0i8kpyHjABvDJm3lp8f10aqyjHR73eDJHdODJow42dcu812DA0XsI/0C0/NjsAgVaLyDKYkwP6RFtn5fe7ZW+T3YGE9PY55GgTLiiIEIwH0WkTJ8lqXgAZHxPdVLfx4x6RjWamqtFmEvD9t0bg84G4w8ZhiipKXmCbqRS3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299959; c=relaxed/simple;
	bh=qsbx4yFq884/P/X4ItSbm20VC/tLbtjijiBNd0Z6XgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GypZiAfpXuDiFpEpY9tyJ4irlqQA5Vkh4gt7OoBllYoMxb2/2DORn1LmQYChkYLmL7IIA+e0VLjF7DrqAFWEsw4YTOX5FTJd2URzwymfy5GbPMB4AH1Dh8tLXuO5q3CIxDADXS3gqTbYKixVt4qaqrEOQdUABAYZ6Xwn2lqm6lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rsYzS0o4; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTFwyFJBIkhOR4yME0gbAecR1P/Wsnng0komKi6HzbVro/ZeSYy5l+740A5PfGDbSF2C1osA2IoPT27b5ke6jv4LNROgRxr2R8+agHAvi/aismbNKkotpHRrvuzMcvdzxBOx2BuGpPfLz2syI3E94zV78o9BFFOkF3vXKGzLqp17igy4sU4ReqcQbcuPXmjlyTK1jZHyZbxZbWdsXsh4w9THzAE4hiLIj3bt0Vr/Z99Rzmoim+B83VP9rLRLP8txHcxtUdzewHMnfeAAHRg0SxkG6eIMpy5zoDmhRg5UjQUcf/SyzMLKhtoQUdBRUakn9yaVZgYw7L2ikeSvrFbmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bItuamAxXUKmDMxMZqfzkQceV+IkqtTaGh72fDG1ceo=;
 b=O880NRUy2QXDL+LVenGN75+2cxMuhJz3FzSoegzGuvCdj12luXb1cOQkJjyPhyjYR8nynNtRQYUPvodHaxw5wvdnECPJltd93cHs9aSp8jCDpg7/aQg4MHwfx79uQ1rWvvSz/WykTBHxpwQfxpSDC/r4EjLGrfn9OtGdYgXJvtnxA3RTt2TCFHBURxoBKO2xGYzR3A2Ji7vG8OobaNuwyNAfevUmTFC7Pm0+OK+SbbJt+D7kYiG4T3AkiAmUuiHyCBkPOHefvaOxMchPDQHvOt4ILPBi0KhMrR1bX6bw0AzmC8etKSlTlyklHdVHDyQQHX+vvxVqx994Ndw363qPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bItuamAxXUKmDMxMZqfzkQceV+IkqtTaGh72fDG1ceo=;
 b=rsYzS0o4Gcnfmq+Kx0EHrPTL0oAsIgRVsh+k7Hgqx5c3VdpozOwWYHSo+xDkoz0z4nWVxEpEpsQJaP59D6fK4cqcm0mvnSfzTKmvrWJQ8sGHqN+tFHsMCEq3C2CA1gnbWoot3hVcQccEY6+aTM6vL9LE7sc3tEBAC9FzOXr00c74DPc8ltYGR5m61euILRk7ni3i3ZxM8ECz3Z55oLC4Ioa4+N3fonaizrj3ADgrOjIx9TTSLCdrCzH14Cks5zCegGU3ujAdFSN4QivGcmF74q+Ed7J5T+NkRYlNj4zyC28LX80lbfyPqlmvoXtHGAHGCBHjtSAQ3qgIQSGAXkzpAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 15:45:52 +0000
Received: from BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f]) by BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:45:51 +0000
Date: Thu, 10 Apr 2025 17:45:44 +0200
From: Vlad Dogaru <vdogaru@nvidia.com>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 07/12] net/mlx5: HWS, Fix pool size optimization
Message-ID: <Z_fnqEWpLeT9DznM@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-8-git-send-email-tariqt@nvidia.com>
 <Z/e3wc7q3uGQvwVC@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/e3wc7q3uGQvwVC@localhost.localdomain>
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To BY5PR12MB3953.namprd12.prod.outlook.com
 (2603:10b6:a03:194::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d6a334-7ae3-4722-068e-08dd7846c5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24cljgscIB8oLLUNYfaUHzbYN7z6nSMmNQ7k0cqhOtUqC2YZH+BfnhX6qyGB?=
 =?us-ascii?Q?D4sB2gD1DGzVsNY9Y1QzJDjpSo2VIZLzdO6JtmBBWxbq3dFaEnyILTf6P6wi?=
 =?us-ascii?Q?fKD3tWqqJqIrIURoCKbfExQ2UDX0YAwZOYSglcmZghUlprU0ehcTFhPKthx0?=
 =?us-ascii?Q?SGiN97uR5UH4AaLCD3yhZywoINk6rtT1Hz6alv7LlTFaL4VfdsfdYM/yYU/q?=
 =?us-ascii?Q?YqCXSrraHs1LljLk7viLNVOc1vow2NKqkHWT60ymn3w9RiOLLoKeWgJ3VheL?=
 =?us-ascii?Q?lC+DxMrAydvbmrYcJA/VWcJjLl26CWlDrHi0cBzcuuf4CB7JQjCY2NkJTaLi?=
 =?us-ascii?Q?bZmQKnVQ3TtRBS1+7fixWjpJ6VqY44op+xMpLgy35gzwTAut8CPUiOT1HO8d?=
 =?us-ascii?Q?IchSj1keFBxxWHQyFUg8z1y6anmyfTMueF6xKibJGu5+RyR8KpsTekhUCuJu?=
 =?us-ascii?Q?cdoQaoWaCqOtY6MmwiXw7/687tScTh024romJF5njBQyNpKBxSQS7GQ087jf?=
 =?us-ascii?Q?qrszILDtgq16ve2SWnhD8WadUXRGtKfA1LupCOx3ZiPsJ7yHqBwjK6GCmPJj?=
 =?us-ascii?Q?isbHEb8HXHSRkvSnFXpGlJDaLw8+eyJjrLysr4GsH+wVe7VasZPCOp3H4WxL?=
 =?us-ascii?Q?ok+cQJPteo6l0ug6fsxR6D7/urc1q0tPWaCq6eP1NZeWeIdi4W8MnzJ6gqAq?=
 =?us-ascii?Q?W2/7h3Y4pYzfSsAOpzqNUWPKJuP4YVqpyr/V3818J/xHGwoq+28IYxtvivd9?=
 =?us-ascii?Q?hKiWHU3QxTPG2/gdI+J227PcKkAtpuhMJ2yPUnbRsFn/HJ+cME44VolEIZG7?=
 =?us-ascii?Q?QALBxOmmBesQKOGjE6nGjmjZ4Uw4k+PyiNfcnRnTcZH0qLhWRk0V8jDT7udP?=
 =?us-ascii?Q?GLu/MeC5BqryTVjvFFuSrvsm9ZvG1LGnMU8A71bbcZEA0VTw+GY9ahy3cgDq?=
 =?us-ascii?Q?JWw8/oI5bQ3Mdp7PImUkLbpYRj9NQWGW/ltHjnIGQwGrYTf/EP0b2I7B0fyR?=
 =?us-ascii?Q?tFR6VpdB9PymOwaTEuMucG+PEePCSCueqW0iVWt46dWVxNruM27t0M4OyT4z?=
 =?us-ascii?Q?N7xRrwMoM7jq6ngQIziG64di0Gv7Eok8/ftGw351qkxn7GWiXoOSqCxUR5cj?=
 =?us-ascii?Q?TR069x3g7NUXx7r/pOBxdXaOMKUHmd2wX2v014FVq5mByRLET0d87guvovP5?=
 =?us-ascii?Q?6e3yGD5KIc2D2fPAk7knAQ9F00YsxqDjx4OIvTJFVHCpC17OBQBIOdjU9jov?=
 =?us-ascii?Q?J/JMr5Ws/ECDIgXFZWKft4UwqWvyaB2vbIY8U4vW2wrwi6fIdT+VmM+iR4aE?=
 =?us-ascii?Q?UpxbqNUcjZy1uBNgwHEIZ4oyq/l2/PgPA/nHLyW8tpB/CkRiRMrumSDLSflv?=
 =?us-ascii?Q?uaGZ/rU2YnjXF96d8rqhpNWbre2U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?51/fZHwT/8wF3tyK/EtnBq7if7+QrXrVmnIZ8WLfHdajgtI9fZ6DHUbyv56r?=
 =?us-ascii?Q?TiAh/kyqZ6VviOcTScru88Jdyj7fwAL6xAzmCeyGs6WrymcbyjSmCXJ7I6IC?=
 =?us-ascii?Q?MWfZr64p/kf92ZibRKILFmiWeNiZJNFL1rTFnzpGl67SvKIRk9O3BVgL0xUI?=
 =?us-ascii?Q?lj+QP3kjFs9r0e1uH9JKjXZOAxBzMAIW+dbR7jHI2aoFt4EjzBBm8CrASOWF?=
 =?us-ascii?Q?A6u3n35WyKs2L1Nprt4ASs7VAzM3fx2/79mO4ljTMhNfXI4jWgs6RFUpNgAX?=
 =?us-ascii?Q?FLkxvhPGaDhPvQCEsqEV0DgoEWP1GdGIFB8/aLvj0TO/mzZc16+sZb0PGakB?=
 =?us-ascii?Q?lCJ9bsWWPki7xGm0oH/frrsi9VWFWsk5pYPsgXPsf5eX2XhXZrtRGyi5MOVX?=
 =?us-ascii?Q?Et9qHbSWSjngYQEOzaUiVTMf68H/racoGJSU+GFvbD3321uW9mkTS8eNU+PY?=
 =?us-ascii?Q?tRPuM76kVvUggLOYKYFwY9qP+80Kz5Q5vs/7PK8X/We7iHcf2dlyUO0DbFUB?=
 =?us-ascii?Q?r3nC4VsxY0U2M6ieyA40wWt3HKdWJTJyIK6LOGVRcejyDrreNHEqMnPGhTfA?=
 =?us-ascii?Q?f9QZf3tSFZEOgKZhJt5f+48aS3dOkcIiUu7vOshBGXUjk1WNIPx4C2LTd/58?=
 =?us-ascii?Q?j8T3WPSIzBbFI8uPRL9F4pCiorDbSsto4lN3vb6hTKUEJ78AlTX2/mNB3FPX?=
 =?us-ascii?Q?EGbtz5P2VcxJ1gjg7m3ADmcBxWE2juv7ijT7rKXV3XIvPHDZGxFMpvtyaXsk?=
 =?us-ascii?Q?YuNmsbKEgFeFb9jUvrIYh54bHpoz2ulms/u+FeVTVnj8G7VOABvuLQeWh8xr?=
 =?us-ascii?Q?woNf63erJJ0t+EpylZ75MReKeGhxjTpv0WQPRE2Fx/Olw6rX60WPWPylvL4L?=
 =?us-ascii?Q?rJQxbuOlW+wjkKAbnUxH9BTgHMN1ZF4jX2fnJW16ACEBf2uuyzWRcQcS6y3X?=
 =?us-ascii?Q?S+C2Sdyuz1ehHyW8e6U+RRcqBsP3MRYfioKh4wRXWh0zMaavkf6jHjSrxipt?=
 =?us-ascii?Q?DdiUuIt4vEtki7Lu+I9NCZ+2rpEkniBeu0gA8RrW2yQS8lnPqYffhWH75/y9?=
 =?us-ascii?Q?+bL4NT0+M5KELiy3JLrs1qeg0q6sCer7Fqm/dwMyIaav8qG9iM25v/9wVoRA?=
 =?us-ascii?Q?81jp2fgt4im1J7ZatCRnwD9+cEUvAyUYOsJUvS067s4NypnzoGw/3uAJHB6e?=
 =?us-ascii?Q?A1FUMiGIDVJMSQ1eaBAU8XwF1Q9j9FfmV/DYdG9RbClSsoIkMVuHWRYmOz/t?=
 =?us-ascii?Q?hURpOxwUGXAyiLftfcLlkeKWXfF3QiX5ANQZTCFEViz094x5yUaJ8/7n0nbD?=
 =?us-ascii?Q?d0u3+hcZ3Cj5EIBATHfMy0eIbO6UIAjRbru1OuUHvQ15F6In248Mj2LRj9tR?=
 =?us-ascii?Q?a1yG1itF3IWPF5EmJi8UdpPYkpJi7+SDtmHGvYRiFORR7Oew1Az3Rab7gYar?=
 =?us-ascii?Q?fwmm2RsQi2KconYO/qcevQLbyB49pvY5A64KxuzQ4fy3Y7HcsX6th/t9OJgo?=
 =?us-ascii?Q?dz4esNRTxNuoc+z3PADklarFOvCm4hfRGavoYYsANUpOZZMTCCL1oYcsEbm0?=
 =?us-ascii?Q?QpWvp2w2oNdZyU54VOVZY3pHILHswbRu1+jdTSA0+vo6wn9Ikv3GtYJLh3pq?=
 =?us-ascii?Q?eegW0p49M2iN4nr35crVV+xjaxd0BV0tnwpeLKZQT7NL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d6a334-7ae3-4722-068e-08dd7846c5a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:45:51.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZUIw7DHrij+g9iyb4oz6E+zubELgtRMLoSaAoQdbeMSA+uK9TbANQn70rElJvokmdEpLgHiG35/fKQPAYyg8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

On Thu, Apr 10, 2025 at 02:21:21PM +0200, Michal Kubiak wrote:
> On Tue, Apr 08, 2025 at 05:00:51PM +0300, Tariq Toukan wrote:
> > From: Vlad Dogaru <vdogaru@nvidia.com>
> > 
> > The optimization to create a size-one STE range for the unused direction
> > was broken. The hardware prevents us from creating RTCs over unallocated
> > STE space, so the only reason this has worked so far is because the
> > optimization was never used.
> > 
> 
> Is there any chance that the optimization can be used (enabled) by
> someone on previous kernels? If so, maybe the patch is a better candidate
> for the "net" tree?

I strongly doubt it. Hardware steering has only been in the kernel since
6.14 and we are not aware of any users. The default is still to use the
older generation software steering, AFAIK.

Thanks,
Vlad

