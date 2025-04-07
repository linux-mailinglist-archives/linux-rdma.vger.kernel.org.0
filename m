Return-Path: <linux-rdma+bounces-9219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE9A7EC2F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 21:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC2F3BFD66
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E2221D9F;
	Mon,  7 Apr 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bvwMx/d1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29B221D92
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051005; cv=fail; b=jwkqXbbgU+Q7JujKZV3fMOL78A+OgXeTPOz0+4d1hxUv9OAmPT1hdXfPw7r2j1ndvd3S8ppVbEyO+NLgP23ktwQe0JQe1NQiGLr+bnLN5QET9CqVjV01+BcDf4fxWylP5o228Gx8MyBgfC0nSiCXpH6hpGOgGxYbcRCmZgeQZdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051005; c=relaxed/simple;
	bh=O0DM5MieWRiWZwzyquBTPMbCEcgLyPq18+x4IjHFDmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkar0FaXraY7RDFz0/yCj2vsiPhyCywWXxHogFZyYMgk/y4V2EunYubfO+crSkIswFKAmZzY5KPErls7xSweQCkKzOPIfEmBkCmH+blKD6whWqZufodrHdGAHoZQSX3FbtXzbqhhaNhzuz1wBuWWoCmM2Qo3K21YE1CccP1tNjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bvwMx/d1; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jcqs1FR1n90M3EYIqt2NWmvOGf/ROqQLl2tvJIgqh6VHdK+p6ICt47qpTFiaq+3DFqux3budVNYCaKv8505j+yX9G70fcFF6p7KS2BiXNByWaGTke5laHtks61W7zQx2wKIlOPw6ZtWryLxjRq14D12NpypX45ndxYvecEU0UqRkk6F01h8pL/2BoB1HR3AsMvoy9gxm7q1fE3jFaD9Sg7WmJChm2GA3/39P/3VP+EobGKfpC8tY4QfmGwNMSG613lgZ2sZq8RDhxw17q2Ao7rnwHkFekIwDE9AKZEidGZKNfL/Vc2m1Nr7eQc0PsKn5g/gmKJXQXnBVy9/6up4OhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvN9JhRKp3p08wqzeF4eDb2FbmfRn7+QfiJz6MEjxUk=;
 b=R27TXrW5lzTs/t/9bOzIUc0kYg7jRXK2bEL2tWJBnAKR2qo99/B4+WLvyFFo+qDxRYNTJzKstKBiuKn+PmXSvSXx5mBgekznZJh6o/YaswCxkWwWmv8U7u4noObrWEF5WQfPHJD0MLPhWMTBzBdX4Biuf9HHehIAik2gIiy/L5brjNd6pm+e3mRsuFzGNqy/quknIOU8wHtr86vQ7g/FNeD8NcEwpK0pNlbAfL4WLgix4F6Lff3rsUFeK/B+iTWwnHEdtiq4zKQp+srBDdHdKjmPCBcc45ueFO7MNH5YDHpnrPpPwH+DAtLReNYvBGNtnELFn28DcaJoMN0y5nwkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvN9JhRKp3p08wqzeF4eDb2FbmfRn7+QfiJz6MEjxUk=;
 b=bvwMx/d1rVq8WOm/D/WbqAmUgV565V/TvXTdVEXEIJVJxBVQ1TP0XIHsTA/MkHBY4935dRg1kzRq9y+eljo3HFfHXro9yHedobRFZosrEXhtvkMGCjIVR0+rmaNoqWl1EL6iefke6OaiHcDBWqmHI/pOLPbkrvPy//4vxzkGDNsIrgVIcANNDWHvZ6QlrUYWkAtHROxcbPzyijvP61IdxaoV2tDHaUVXLpg/MQw272bNFCPnCnA24dievnuqZzY2nafUNewNI6QmSeNuvRroDEIomNEz8pjEyxgVOcoAYW9H9wW6O3Jx+M9jRi8/ShQxSUA9sb7/WSgz1dg2tOiwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:36:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:36:37 +0000
Date: Mon, 7 Apr 2025 15:36:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Cleanup and Bugfix
Message-ID: <20250407183636.GA1775642@nvidia.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eb851d-35e4-4812-2f5e-08dd7603217e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?940RSvLf9zsj1OePnMDH1+wUnpK7WXka9m8pkE7hZxwVzpDTF3WNdiGpHWKZ?=
 =?us-ascii?Q?1BKjKSr+yXJZItBvM8ztEZT3gPy33/BCs/V7/pmvSAbkhPbZYD/mHEATMrL4?=
 =?us-ascii?Q?WBhWPvPxkZRG6mFdY1PBBUp2DQoGvtT/JNRU+wPdXwkOnIz9Om+etax5moUx?=
 =?us-ascii?Q?kjr+Cwi3Mcy/g1WLmznJFrrPg5b1fL0whYSmugqy3jE0WNmXA6zQ+vJMn5/2?=
 =?us-ascii?Q?CZHHvVOvnvAV96zgNlb4OXQuEFFeiPWLmRiR8rfQBEm7N3kxL0K/u3NqlLUS?=
 =?us-ascii?Q?LQ4Ky2G6xIQLKnTJlBq+T8mVA9+qD1wLgTQZTz4Kj0zJYvllCe4yoDpZ8vcn?=
 =?us-ascii?Q?9XML+cAj+PfXRB0Gnq7QBitc+SZmodCezjG7HsTGhgA/ieoTOl9ltA1flZLQ?=
 =?us-ascii?Q?ZCgnd5hUYV5IG/MOMX+GWNRfJUhV92Qi+59OMKfqPCFUBS0gwo0VXTBnAbkh?=
 =?us-ascii?Q?dk5f+GlElDJo+d1oVHh3dxXNm5RNkCwIy8O/cRo3HDxuZ48IoClYc56jc0C1?=
 =?us-ascii?Q?RibKN4jeKe2UurLpXw9M5Dqi7NYnIiiJ+rkpXIgPczvTSGyHNg4wQf5TA338?=
 =?us-ascii?Q?S68Ru/jMclV4qc+fhQSsDHJ1IbNbMJwpOZB91Rm8qmctaUeH7tPIcFoYvwXZ?=
 =?us-ascii?Q?C2tYufbj8t8BQ976GCWuo+HFb7iC3n3nl3O8yLUy/2YATJfZAfYdgO+ynhle?=
 =?us-ascii?Q?DjD6CD/IkbZW/rJJTapAiktoRRxDSPcKsye7f1YGVUPSLgxSKk8VM2hWe+9b?=
 =?us-ascii?Q?8IkcJHDWPU5ABbBXOpaaQTyi/KDpU+n16cZ16GB6/TNo6nDhfyY1Hh5iFSuj?=
 =?us-ascii?Q?aMmTBZF9NCBGMxcFEhOCed6gVitG0sp8YwTioHaxsWpa8REcyvDU9nN98ber?=
 =?us-ascii?Q?mkSYsghVy4OpBK0mYpC1l7D6p6DREByl7QD/zEdyRa2R+qvkf37/PF1TyUHG?=
 =?us-ascii?Q?U8ksCfwaA4FBEYQxpJWIxk3pNLBnVRNDeDeAEcd9y2XiiBxmaedniQjVfBBb?=
 =?us-ascii?Q?85f02r2PaThjYr0jfH2uDJhmXjwf45N0fQT6JqnOJAfOOeu5xLQWcAP44SIk?=
 =?us-ascii?Q?Q5VCnJxRDJmurW+bnbbdEZn5Y533IUM8rq7aG0/th2ymR+EnM6Njh8eCYRLl?=
 =?us-ascii?Q?aaPIGggl8GHS9YJ1TX9JOi9Kd91/nPM27yQu4Kz8G/G5L0hVITsHlOKoAETj?=
 =?us-ascii?Q?7bzoaiD6L36SZh3J9gEnFrrP8G3QX+5W1+4mmhsXq8b+bRvIonm9eA/uFxD4?=
 =?us-ascii?Q?Z+tp0geMAD27lHa+8YBNhwiRcXgfXx170PhHg7kxZ2ghbcXrBovWJ9BTDwa8?=
 =?us-ascii?Q?pxZTYo3hmcAD02xVz41+Gm6CA7lzUjYL6znQcMi8wBDpejhSv1N+H0EReNsi?=
 =?us-ascii?Q?Mv4JgQcFNkbMHDCDpofkWDcLumGh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YS2Hksil1Exp+LnKA7KgPqOkohQ4qGVMdaI/giXLwUl8JpjbSD2SyIyBguDx?=
 =?us-ascii?Q?mNECH3LShLdkdy+mcYtjsVs77tO+ADtmpyIHlNMvzHNIwRXMZJoqa/Ix1mjY?=
 =?us-ascii?Q?lW/o+oi4QkosX5Gad1LNmkOHRxRHxIT+NYGGa1FDb+6mt3WSga7VGPfQjQjx?=
 =?us-ascii?Q?sH9Eh5/nNMw6W11IMBHSbNLipmxaahYH6W/fxrERAYYmRl2hd+IpspB+f4/W?=
 =?us-ascii?Q?YByeyGyn6BmYtY4it/ggzoXKjMnxoCjElFupRpqKDCUS/zBSnaUF80h0hqOj?=
 =?us-ascii?Q?WFzneXuYcbJ7/pK9naWPCSYzVX3ioxCQEiwj7lke8lolrz5VEvW0ouDaN7Yz?=
 =?us-ascii?Q?Ypudg9TcsDYF6TfY7dVXqKcS9oGwngm80M4uPm2pwpzZ5x7zT37/2Yd+NRVw?=
 =?us-ascii?Q?rUfSohjaU+OJUVdkNVOZS5b8yqYA65q5xZqi2innPqYktmrkJkMShfKypjtw?=
 =?us-ascii?Q?NwJJ+5Zzt+g1WsYiGFw+TkyUvvG9k3jnKMeTJnh3x4wdb+L6zQRWM2GXj9BT?=
 =?us-ascii?Q?Fz/Pzb+mYk5KmqSKPJB7j16OlVpKlsDgi3nf5vtNJDPgIklTsPcZWpgenYiF?=
 =?us-ascii?Q?oYvModbOR8xUiybRcMDZuq0MMWw04c3V3KWnwX/jhZzTovmVaxiZ1EDB04hI?=
 =?us-ascii?Q?TnvNEarhBxwdglhRDi7AszDDvNe8wV6wDoOy8Hzf2WCknoaGO7vPkyEfjJEJ?=
 =?us-ascii?Q?ft5Mv35skej28Kdk8BcCMRU1gzpuKGjjjgbcLJnx2QIvmhkqHPbuQSGOQ6J4?=
 =?us-ascii?Q?Y0OfeiJRuZZwExAgpRLl4d1yymKXcBnyqw69VgnKvve2I0vSm9L8IuaRVATn?=
 =?us-ascii?Q?qMzt6Torj0qJxOZuBJ29AXFp0wJmDn1sNk3sCdmpUUrQzb7QSfYuL8qxqo03?=
 =?us-ascii?Q?Lhf3kn1oIpYdt6he9x7AzLO24BFK/YMcPrSXJmNxmHZWVYvWvkMmNpGLOem5?=
 =?us-ascii?Q?7EWPjcT6GUIKd+mP9RrtGzNqKfRLKzdVX0O/Cc6QC6IMWWKDT/g1O57WPA10?=
 =?us-ascii?Q?57oM+RYonzxlUoW9P+mLORU8KpbD+q7qdB3F+jxW9QSHNCQmG3UznSwWmFZg?=
 =?us-ascii?Q?0omEOTzuxmMlm3HC9Qr+WHHH8m2YdXHJ4nFwxZG4sXeHWCVusQgqw/GcMD0R?=
 =?us-ascii?Q?nevSD/7UoFvgktGeeOi3guJu8WBA14qqPZI/ww+lFK23xdWPX36UD+B4IeUn?=
 =?us-ascii?Q?/bm9+dhijPKgMnBzXviMxzL8XsKfMLGZkl9s4mnEJHXROrNkztHPWBpUegna?=
 =?us-ascii?Q?WFt8WR0Iv59vwnOJuF+6hfpv4kjswQR8YlhAHzGQzS1WYCCljRKbHt+kP/Vc?=
 =?us-ascii?Q?7qI9hKbH5N9b1TwgWsPKjW11nd0qWZ/zCa5FjXoTiKi+8YV3jazjOReWC/of?=
 =?us-ascii?Q?JUp18/RDS7h+cNLaHwP9UIN7faV4DSN+BZzRWd2qr0cx+46L1i/3PwNeb4e+?=
 =?us-ascii?Q?rpdMp0iOeGDWI6Jy/0iItsGGPOHX8JBywYv/R1MfhcVlZVCrnKtZxsgB2HoV?=
 =?us-ascii?Q?NZxqsdOQjEGMvi675xfLWHH3ENSxj+bpviRmsbBaP8KgMJC5cobqsky/vSR8?=
 =?us-ascii?Q?2i2rQXRJiva2VsXB6U45cQCnr46U+pKZ6hjpBBGV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eb851d-35e4-4812-2f5e-08dd7603217e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:36:37.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sPXXbCZfhZCd6mXfNXqfW3lm4UNpVblYdHxkADVEFuf/L0j/0fEUJPbw/IIjPtS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082

On Thu, Mar 27, 2025 at 07:47:22PM +0800, Junxian Huang wrote:
> These are two simple patches, one for cleanup, the other for a HW
> limit fix.
> 
> Chengchang Tang (2):
>   RDMA/hns: Remove unused parameters
>   RDMA/hns: Fix wrong maximum DMA segment size

Applied both, the first to -next and the second to -rc

Thanks,
Jason

