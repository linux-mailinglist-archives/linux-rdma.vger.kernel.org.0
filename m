Return-Path: <linux-rdma+bounces-15063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42FCCA12E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 03:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9929D301595A
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB542277CB8;
	Thu, 18 Dec 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dC0QS3Dl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD4125A9
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024386; cv=fail; b=MySRJe++YDmgfayJ9dpUu/PnQ6VTodWJvrKaVV7Dkz2YfefwDXTdsBiBP3N2uJLg1cCI7RJjx57nEpptL7I6I/CdgswUTfHGkneWhnN2+wcxbYMKHGGJhMPPw3mKhxsRCuv2hcgxslEfiTlxM3sVZPJauJ+yJjRjb9WEFWXkyps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024386; c=relaxed/simple;
	bh=QSb9wTFgdh830uanCD0fwl3JfQ8RcNV5Y5yV4jMsbso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C68Rx8AN01rAIwXGtrJa4Dnbty3zDb8arTw9/L4N/sWyoBTh4D45j9F2OvVvENoufj0xSey+9ktfHkrvd2DhpEv2wEPqCIHVnlvn3dd2LDJd1ZCLxKlfT6U/sD4R/knMSLGo4dSRaHLX/GXMPK4ndoOFHR40jeaRvN5+3+VwSB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dC0QS3Dl; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWdxkEyfMXR0wjv2AJESR/armEDYVMuptBvQ91926LddXhq1WjRHdiyp2rIZfqeCUim08XYi5N6OmCPSRpmFbtDDHMnt9Bi70BXkhoee6u6Xz0fFYLwsBoOKf6GG3I6FRGg3S8olNPiO1C9slI/Lc22OfjQrtB6gXtRCAVBisQ2zkByikMrtc/dwUQ2mZqmMNaxA4xw2apSceDY3I3RrsP+I7CtuNcWHKJTBX9L302BhH1WZRobEO8o/zSrc0q16ryv5qAcOy1En/2FeWuJVODXHPCd/utHMrgekHoor3/NoMQfJ/F90WT3NMZJcFXWYDYc6kIX5lOkalYGZAUXExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXd1Obbs8f/PoXbHLpae+IpZK4JN2tkNgn3grp74YbE=;
 b=P99svrnQsCsrqPa6337heEpIMgZJZ1cEiQRqO5SdMQPndrylEyOl5Wc/V2dZhaQ4oOMDWBnrMbYfVaDvcme3PqTfpOxvcnOPmlTCX04WWs7n+dFwiNLSRimvvlnLscZXcy+opMh67LL4MnK5DTt4udNjD9x4Ugazu7xYXztLjstAMbRIVCBkTL4dp/GIShf6NObuphayxCUTkpWm3X46tj9TZlfMqowKiL+tDjwicwAyu0Th4F6VDK1OQgZf6+0tWbDCPXYlYGKDhR/KotILp9Wtq9HoNw5n+Grrrc3OI6omqqaBaVZW4tpxR7N8jAp8FnWv9VMRbr/TvA4oUgU4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXd1Obbs8f/PoXbHLpae+IpZK4JN2tkNgn3grp74YbE=;
 b=dC0QS3Dlt99fsQHuiThIWY5r06evMICkgfrubfRlES4VvNMoxeufDJXIJqhGhLh4THzisMmV782nsKHX6EOTDcvEWJiIDiVnwDu/D1ZD5DVS19J3bF6nBXCoBWP5vATuf2ZKs4+/VmiY0UhhgWV/CxkFq2/bMVmeUkFpSFC+RdWu/uvXtsuPDQDFx6RlzTdycievSibZVItkcz4pW5AOkahofOe3DdK3sZcSjHO/00fUkCy5VP+TaGXi7AqjRceR+J8n8+61GOGWVYGETt9UVWdEHXsK24DfKU7f0LYOTeEaGwoQhZcxIR2kM4qZ4Zki/I8dFKtiDNuPRhRYnd7f/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 01:46:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 01:46:49 +0000
Date: Wed, 17 Dec 2025 21:46:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v5 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20251218014648.GE243690@nvidia.com>
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
 <20251129165441.75274-5-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129165441.75274-5-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8387783a-6d04-4bb2-531a-08de3dd74f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?NoWWSs6uEQdHJzH+Bv71bCL1NXbiPMlyGhJobcqIUiBn2QhO3tH4RX14AUh+?=
 =?us-ascii?Q?eC8SZy+WEpqCZvTSMVQpWnt610a1rNJtWs0EOLtuwInDYITjEPYbd4IWTSb9?=
 =?us-ascii?Q?OlTyEIkmH0osSm//XUr8U8Tg2/EyuhRpMIr3m1UK0NJ6sylq81f8Tv59qqF/?=
 =?us-ascii?Q?UNTguNq0rtaNmAwz5kpH6bri/hdohalG3y3sNEp5kJFZpvMyuEHhSjUotPBE?=
 =?us-ascii?Q?dwaER1uiO6W8X98+NKgC4V91MSeXrXaPIk9LbAluhl+z3iKHYGkhnxyDM3Hl?=
 =?us-ascii?Q?Yk7CwbxnXIhCR90SMGYvE4e8+9uEsnPSszWAi5j8kqcIzGldf6jVQlgSsRwI?=
 =?us-ascii?Q?xUW8COvhym7aH2ls8amtkmHqMWLDHnJ7ltvS2NKB//ktYVAO7wsKgZRwJ2Xf?=
 =?us-ascii?Q?pQKNEsn/OKQCwlbdYx9boeTcBYKn8CrmltSmkUmluC1ra/TeNzZp9AUxVyEo?=
 =?us-ascii?Q?myNRPu+ZidxGa5pZrKV0XHXxcUeVD35Yn1RGuDO+mAUfvSaSbyIJKYTaZkA2?=
 =?us-ascii?Q?b5qw3lR7uteMJnGiNe0lJy4y1Lc4/mbqFvpqf19FXo2+m/0YJKuLlp1+IiXM?=
 =?us-ascii?Q?htd5P6WLjCRBgSFVketbvWj7o467VrCd44eZRVh3vePmqxz+NLN46MtrSMCa?=
 =?us-ascii?Q?B9TJgftf50g9+Yc1x547ncvArT/Yev4F3dD9XkUdUiAKn50xbTiuMLVjD4ad?=
 =?us-ascii?Q?0EGHbVaLK6l5S1Zz3bZxLfN94Wqwbf937+B+WJpKebSAXL9VByHcnWiXt5U5?=
 =?us-ascii?Q?b1AE4MceyPkCJjc1EqYeKe19ArsEtzRppUHzjK67CQdI5aRdDL8MPQNnFDHv?=
 =?us-ascii?Q?Fjt3AJm82AcQrfdVVT/UGXtw9bOzcG8smkDpl9SlaUzO3/QtADEp044DMIIH?=
 =?us-ascii?Q?HiRUjdl6ihVfvGmSge8NhBCJdgl5NLnwoDkntY3jMO4cTPJN7NgosNsC1QQu?=
 =?us-ascii?Q?7rBahsfWMjm/sy8YnMMLlvOaLyk417A9T1PzYgInJHUDXCk8Y/OUTactS59t?=
 =?us-ascii?Q?wtIieBH60RRdP7yDYHPdq78dW126ZuqhJ4FCXVJ4iEJeHq6d51H8bdUmN+He?=
 =?us-ascii?Q?/dpuTWwWpEP5wB1zxK9wBsXYVVHxrHdEBPKjEE1kIjCJmw/Vox9BBDz65+lE?=
 =?us-ascii?Q?M20fV7yc6TmOMydyF+3ktZdRiKlEwBHUxE7Ysbnv7gvdmChTTtmWDMH0OZ8B?=
 =?us-ascii?Q?SsnJpO42JSsbMAw8kmjxhh2HR/gbjOencZ8cBZXcVepKN8eiVKQExJsxPv/k?=
 =?us-ascii?Q?dBfrTOGg71P2fJGH0PdRez3RggX4ah/95Fr1WGLQphwwESbBbES3Ac5IvGSu?=
 =?us-ascii?Q?6jNFtCbxqWiQU3LxGK4vNglTUoZYsUTAeJ3gJxWDopGYNJVVXG0qW833vdzu?=
 =?us-ascii?Q?2nafoAiv97tqP1AyO0YF8k1c++d8ugYx53nO0cdJqpxYjRVx27jwY8u136vC?=
 =?us-ascii?Q?pVCdwkPey37Xzsaa1ftUkkEwST2X0MBR?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?fQuFVrjXCd6L33OM9ttETDsAZTUzow8BbcyoBveyjsXjWs5yNVJiUGrSj61H?=
 =?us-ascii?Q?ik+ElCudFi2enmv+O+2SvQu79UFiNiUnrksFJMNZ7+P9mf6xwW9XrZjh8/aA?=
 =?us-ascii?Q?pQc02Av9ffRC/tSybfu3Bjdra8JwypN6g2l/c1PfIpSEE8GpeaoS+e2UvqkA?=
 =?us-ascii?Q?1vgPakGeJEACZ3oqcWYSdFW5vabO1SVMp+EAH3QV7vw6m/YW/IwMqoNcutWD?=
 =?us-ascii?Q?X4jmvvN1Wikxp/5eeplfKtFp9hED4biDK+H4LzyGhvbz7nnXkQCVxORWiHl7?=
 =?us-ascii?Q?VNItpyEsK1SVkq3/DGTr0Q9cKqadJ4zgGemdgpkh2wBo5nirNaG9eE69q7qo?=
 =?us-ascii?Q?UDAOrgj3MoQd8XuxZ2uHrtR20eY1QqnB3u3k+pleuFCRBtRiqQ7GoNv/Gabh?=
 =?us-ascii?Q?eA9yzywXJ4u9RNd+qs1DMQwVJC7WkRC1nHx3uBz4zvCSOESbdo15J0G+JVOt?=
 =?us-ascii?Q?p8sGYdeCIR/lRaHYtYdlGUzqiCClyobrsxznqYmOHV364dRD9S3xW4lhQohZ?=
 =?us-ascii?Q?MyYnI5GnvrmYcN0v5UUtqLeM9HU+v4vXhEDoi99xqK6HMWBOu8QVsbKvkmUP?=
 =?us-ascii?Q?dkQbBkrRYoVc18Nf8Ai2Goo+ZA3qaA01dq0sSERRN2PkylajXnB+Ud1ttjPk?=
 =?us-ascii?Q?1OfrDqbXC6fcYdm87jKu6/gP+py7X6RkS0hKfrcm0gm3TgmowU70lPitkonj?=
 =?us-ascii?Q?/cPDCWaaD927NYzf33OocXszq/bYPnA5ibzPdL4L1JwMmkHPMqXYvYEUqWV7?=
 =?us-ascii?Q?qetIoIJDoV3f07dCFaoZslktpybZuF7ilojfsI2+/U+R1pYfHPqsJ/1REoLd?=
 =?us-ascii?Q?8RYhTofhPQ3CVr2Tdy6qtq+EIaKSAxImIeEK5IIg/gt3xdySHFPtk8q9YjwQ?=
 =?us-ascii?Q?1lXZoYqcZ/Bo1yo5Vw4gsryMArjkIloyCH/rEl7gdvU9VJzmK3ONlf/YnCwJ?=
 =?us-ascii?Q?PViKGWswm6UTzr8Wn6SfywcM4qIH48BHaxjMiSJ1RljB10VdCHZiROpRrhBP?=
 =?us-ascii?Q?SHQ8CFJAX3oZh7piX4mT5GrlYsGHV4ulWzrfTf5IhJfi5IB/foYXxcDMipQJ?=
 =?us-ascii?Q?awugXzZDlu8JZtyIKc2EdG75IJ6YlX6eKmY1Zzq+0ewUY9aly0w4pBqeQjpY?=
 =?us-ascii?Q?SULVIFhhWI8NDonb6TVrvDWXdpoWYM76CrVF5pzDxG5wnfA+LKpZimxQ4E8K?=
 =?us-ascii?Q?0KgzrxHBvF0DyvWNdaAT71LxWEUtIjAAMKTzRYIS4Dp1oLPfiZ56WMtdohtQ?=
 =?us-ascii?Q?5iEP5Drm2WNxvjZ86x3NHbh86nQMvnRq2KNwh0CekhfKYhWzGw3rE2Pbx6ro?=
 =?us-ascii?Q?XolUk1sRZhRi7QApMNfZjEgw70tI0j9jqiGGWiOFasxQM50c4vYvZz1Z8IKZ?=
 =?us-ascii?Q?EiBlIw5+JEnLVhp8dzeUxcUgZSbLeRpDKcbdH+tM+lAY35RL2T6ROJskOSMP?=
 =?us-ascii?Q?uss5gAScs8aqLo81Nep7TdWHGwwolPZM/t79GEvtFEPsuGPEWaw0Gej70HlX?=
 =?us-ascii?Q?tuJSARjYIJAK4SooX+mn4T4DRqicGcmL3cb7b+OuXx32Kj0G1bsklbabpvpm?=
 =?us-ascii?Q?Uv6pWL9LVu5TYUT+e9o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8387783a-6d04-4bb2-531a-08de3dd74f23
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 01:46:48.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dprscIwKP7ovmUjq5wgAZaqx5xtGmGZIYMJJQ6ApgHqQkptyeq17F/zaTfUYhJpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On Sat, Nov 29, 2025 at 10:24:41PM +0530, Sriharsha Basavapatna wrote:
> +struct bnxt_re_dv_umem {
> +	struct bnxt_re_dev *rdev;
> +	struct ib_umem *umem;
> +	__u64 addr;
> +	size_t size;
> +	__u32 access;
> +	int dmabuf_fd;

It doesn't make sense to store a user fd # in memory like this, nor
does anything ever read it - thankfully. I'm getting tired of this,
please have someone else review this for all this leftover/unsued junk
before you resend it.

Jason

