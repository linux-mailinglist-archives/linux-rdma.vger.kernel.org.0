Return-Path: <linux-rdma+bounces-3563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633691C0E5
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 16:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253F61F221F7
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244F91BF334;
	Fri, 28 Jun 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJR7KDfb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83F14D718
	for <linux-rdma@vger.kernel.org>; Fri, 28 Jun 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584847; cv=fail; b=cgKkCuZokBDCCBSGq1Z5ATBLImNM9OZSgfVDAwvUQHeclGvhS8Zw2kiKOsFGr1ZIU8kBfBPlYW1GkwZ072rDguWK2kqAQV2wHgZ3ey/g2U5Qw2uv6wvrlGRs+SOzEqAv/Wi9E9TbIzA87dpE04DlbCgNbCKnRop1WJliyICfU1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584847; c=relaxed/simple;
	bh=9G7S1MH1IJkoyydBZmZmlofnxoz8MGtqSWa2eGLUtik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c12mj9mcgChj3QhD9eFIzjynt9bysQST35nkRGJ0hNd37BQ3QFgpc1t/JNJoavFFR3JldzZDwaUhapEccM8cSXPvJ2hAVvypm0YVVUgHMfw6G8hi4yz25Q7BXZ82DDKHzH7jQGSGWlY/Og/3kFQaEmI1E3TShbfuvmfTIOyARpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJR7KDfb; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY538bFnOnnF0DvafG2jPPmtCfnlV2xarvIdmRpupW6UuzRnaQDiGzXA6eVaXWpANd45FRN8mtbtoOOo3xUP6ZWXGjU22lxdIhrCu1mCTZ51Zx4/OnG2FfzxNvE8MWQmQxl7ZnizkAydBnsb6pwQT83obw4QryMnzp59rm3xM7JU1h9kOHFCoc45LcFrtuyRWSe7s1LNaCMMJyFZq2Vn5RFZFP9mqWJJHHyDmXokDf7MrxITThHlOyAurxNgcwWLeuwMI8nV/QR3fJYpC0fFI9hqtpe6fMFYXeXX+xRmUy6g3ihBEu0cwsm0lLHtJH3WeVd5RnWZbIFL4aqiqfZ+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1fl0EaFuNP6SREqYdpVfpJD6asxZhuJbON9q3GF4aQ=;
 b=eiPl18NLmLQW0N87dyxL6LzHdbvVryNW4g3nqrWL2uLDetYcGeCCtLXQxOYT6w5Uv1+/1rKkVmtjfqgcWIJ03ic3cOaGiGXpyi/7H+SMgONYeyxiyLqV/DU5oYgqKOmRsBBUn/9hTv6RXYQ0ZJ//UtvDzAjrth008PZtUKv8KnG8IC4Br56o3KiFDLwIUBwg/L3QTRINlcMebuaf9ibwyz2YSPOiUeKkZAhL4KjFeZDHOk286y8/ODyhgRIAC2BwHVXcFmDOYmp6vWemO1bNLFEQae1tEloAtlwTEZAWONqpZ5zj1V/L/X8iZgAVeOI+FA2RbBW//FuTUJe8bN4M3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1fl0EaFuNP6SREqYdpVfpJD6asxZhuJbON9q3GF4aQ=;
 b=LJR7KDfbIVBO+tc/DGSnT5XyWUV4iJaaKYxrfT/ieXo4JeDKWMzcRcdyWHuKOFNge9tPzqSELpZoakgbYaF68AETzxx9OdMZZ5zCSAu+c/vGP7kG0eyokFhB0WMdEB7JfS877MJoWG13TwjqrmnfO65JXtor4CXElF0CT+rupdZNBFnOj/VAt0yXQplxb64X50vXB+S8D7Gf+rV1fI4NSnQExXvY4q8wkQ/TG/A+hrO5uD02oXSm6pUIgzirIDgj9bDrxJ9zpt0QdlSnBMbTmqlHauyWPS9gedJrovP2poXjHzSLKZaEPi4cg6rOMsPOYeXUmu8kYNWGoEZz26FJUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 14:27:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:27:22 +0000
Date: Fri, 28 Jun 2024 11:27:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 5/5] RDMA/efa: Align private func names to a
 single convention
Message-ID: <20240628142721.GP2494510@nvidia.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-6-mrgolin@amazon.com>
 <20240626153834.GA3233164@nvidia.com>
 <6310c5d0-e72d-4b4a-9b78-b19b622fdb92@amazon.com>
 <20240627184320.GT29266@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627184320.GT29266@unreal>
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbbe147-a19a-4918-64b9-08dc977e6c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IuVXkGpmLMG7MrPjgJ6OMMbWw2pGdOpBO+RUWMe7tlqPbXesc6fzPlmqq+VQ?=
 =?us-ascii?Q?D3Mf0vjzpO+q+V4pi+QnFvgwafqgsgE6Zma8+rqqXJtiOUpUhNvIGLSmVk3n?=
 =?us-ascii?Q?PvWsFl7fEfrujOnqwSyXKTaHbFX0iDgvnHQyrEObmVv0NNAqnxUq2uh8ZKSm?=
 =?us-ascii?Q?sBhte5L26Ecwyu6ZNuOIzXfhPKoAd3OgyoecIKtcaMx67fdDhcXsO892u6zK?=
 =?us-ascii?Q?d3dlLiVQPU5iEgeGHQ48AvdZHXZAuw79VtxLKy60V0NggLApz5bMbJwB8cqg?=
 =?us-ascii?Q?+9XzvlfGzzt7Jm0oLKgMRJepwwjbV0jrl8w9ZLSXayn8jMNvABVlAkCiSVjz?=
 =?us-ascii?Q?DIzrbTrYGzFoW3eCapeE3M96Nt8+X+JcFwjPSXAFB/y2TTKwGLN8Q/FjGsTg?=
 =?us-ascii?Q?hQbw6arblQOmiXScE1vbyh+WHbsAQcRsQSuIuRf5LCDw7RznF83dcLOmz8TU?=
 =?us-ascii?Q?iD4RqTJ4EeevzeJb26JWDhHGduOyAFizC/mLZT1OBJ7shsdSZpiuGGvwYOT9?=
 =?us-ascii?Q?IZ3l3WlHuI+pTX58cnMJf5VbjaP6MaQkWLxkJ4dEnWEZOGuU3V9q1GKpR/wm?=
 =?us-ascii?Q?jEXU4g1n3rvu2Qe3nIZS3mjALl7vUh9mDz3ZqzrMWKPtVyM0uBUe0kXPNdoZ?=
 =?us-ascii?Q?I+bif0FbYf4kyFhNQP0QMrRQs89g/Au+yka+1M/OBb3TeneQz0vntGZ/UXNE?=
 =?us-ascii?Q?vTxDUS5ga4hvlx+s5P9A5L4LrG73RO9HfsGcT0T8z8EmBcphEyCgGNWdMchE?=
 =?us-ascii?Q?ypAS/z34unnJ/U50r9ET/nbBctVq2sFEdIeO1UYqFaF1pLZNucMaCDZGdSke?=
 =?us-ascii?Q?E3oKAFBGCkNRgub/EBMzHk73Jl/rZA8eOYq+rsh7uKuN3MQPsiV8K1BmTpWN?=
 =?us-ascii?Q?5SLijo07MNlAamfnvjSABI+rJp/RtuiwC3VWUtK4w4AiBKzuWTdGoCsALbnh?=
 =?us-ascii?Q?88zrkMi0lSurupaYEVPhpYdTv04LY8Bq0duD/4kXCQBnpVYxvsBvOcQ2/zLR?=
 =?us-ascii?Q?0RXE5SG7rD9t8qAPFkTR8WQPjP5P02vEwQqTK0Jz6rghsUAbsNOLTTyhVwi+?=
 =?us-ascii?Q?t9S5ORRyiatUgVbc2EIZSr4UTg+fvCbb1fZ9itoQ441QyLngYIXg/w9IkcPz?=
 =?us-ascii?Q?OuaA7WFeVeSqA5NKkX54z70hx2Ubfnf7eB2AZZxD9AvRkejxxJAt3yDwhY0y?=
 =?us-ascii?Q?cbOqmcSpdHhbZ0kWEQIfiHLwx2bc1LCiPJCGXLN8nKHA8RlIlbcX2EmGEmi8?=
 =?us-ascii?Q?KswqWSW98yJwIXw9r3ys6fTY4rWV70GebOpRF74VP1dpdtWgqCMd67O+3ffT?=
 =?us-ascii?Q?QkZ9aEMWaO/0hQ2aX93FF29KuJ5zMV/hSXtJtWPB3jEA0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxElnesHmvSPmWGcYsSfc5gl+5MxPGk9j+mF3wJta5qOsjM8Enat1MPQVfdf?=
 =?us-ascii?Q?EbIL3am1mkqdfy8BigUmp+9H5XFx7TWWg01om1u96yD0nz5Gm+pIaVDcMgyo?=
 =?us-ascii?Q?11JxV4HVw1k0PHN/hyNRXyt4DZdCv0eL37fo9f6KT4Ib1i9QVdBVLrZ/Srou?=
 =?us-ascii?Q?HooXd9zwI6fYtRnNcdbNKhWomG+MuXrcRSkkJJAwQqvtemLn0uaDqjlj5u/e?=
 =?us-ascii?Q?AUVGVwCBDjKllynokjD2xpToZgHSv+EzwnRZW/Gao4qMUjR4jTHFNP4+a7hc?=
 =?us-ascii?Q?irOKvN7Gnr5fE4pAh2HnArOCnFStWXp5EXXoJGa4p2YrrFI9xs0r7E6DRANE?=
 =?us-ascii?Q?vef8VCmwY/d2N05P1JL9iO7z/k4DDlhkOSq3+XRs80CtjC87wzLrjyAKNe9/?=
 =?us-ascii?Q?bBAHVqs4VVjKt5+EBCoaT7WQpQPxtjIG5uHEFemhg6EF66sqBCjXdNsNVQ/N?=
 =?us-ascii?Q?TXvB9KXYvMm1guwPrhlPousGYR5SlknFJ9meCxPhmxINIMOva0FX4/JTY1rO?=
 =?us-ascii?Q?dknPEx0NyoVGbV7VSNYhcMrjIwwu3dF+/ObGBUar0oAx81q6KEnTsYWCH4XQ?=
 =?us-ascii?Q?IpO4XQCFqC8kPLnZJ4GbIm37KorTt8djOTSdYTAf4gidrv8eApPRhtadM96j?=
 =?us-ascii?Q?eTn4MgcrYhxHED3sPsUj141FkaguAqqXyiHgOsDPd+K39PxA/H8qCj+I/5Ur?=
 =?us-ascii?Q?nof8n806XBr59lEwrF5+vJUsDL0oAPY1kCuOuJmjJkisPqN8GriMzKFxW8ta?=
 =?us-ascii?Q?R/HmhcWPkTTaFJ+fBlu1ORGsf9AKcgN11p+i6sc08TCeVmOA6SxfsIhyjkFU?=
 =?us-ascii?Q?M+6Lyvy6qqqitLkgq0P/j44zCj/3SVfymHkP4EQJ3QZvWQ+CacefO3bx5GsX?=
 =?us-ascii?Q?0x+lqKncz1jrmaN32fEHOqJnlHl/DWIkzLoM+hcLnvRaVdj0xUe0+nTrMlCk?=
 =?us-ascii?Q?xfRD0aFUxGIJcK8qN/oPIroyBhmKFhuIR7w8XzU3Mqy0Cbhw2NxnoZyfNH2T?=
 =?us-ascii?Q?LfZwv9LM91j4bkXwu+bjj81i80hUFxrLXYMbUZILS0eyNSNFO2QzqWuqrm0M?=
 =?us-ascii?Q?0WhI+hhWCUXwPW/tM/lgqAJ//VhyXfvkSUlhL4opTYYho024b2sK7IqYMxIc?=
 =?us-ascii?Q?adY6+kHBkUb44UXce8ovln7/+NCRM/JgymBxr0P5LzZ3n8wfe4g+nyXsSHz8?=
 =?us-ascii?Q?ggDcb3ViVtb+L6p/FxAg2fkFdnkSI6/f1yfdseQ+EekcL4Lmjj185Np3+pOh?=
 =?us-ascii?Q?cpyHpmtWUGgP65hqt9jFsaHBem6Bw9Yq4RQ42FcZjPib1TBLt1xqMPcEbEpl?=
 =?us-ascii?Q?HtYa2tPfy/eHJCgclwsu1GM8p7mv3UhNzBnQamFiBF4xSZqf1wwWG1P4aUD9?=
 =?us-ascii?Q?IqxFAqagZUHZ10c8yGEYe4li2v/TjK8xTzIDW0QOjpBbqWUBg8RkuGoLFgR4?=
 =?us-ascii?Q?LV5J7WQ4XFGKkO9VIAJ15lsWpGmWedHjaUVxMEnPtRyyv4Quv5yNf0/g1IuK?=
 =?us-ascii?Q?EUWtmFdfDtmFKSGnXHL+55xy57SmBMDrtZ7yHRyoyp/7dG6caMtK26zdvPsc?=
 =?us-ascii?Q?xCRbwCl01TUDdA5HzA6/B7fNuGh+lgtwijib8M1+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbbe147-a19a-4918-64b9-08dc977e6c92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:27:22.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1s6s3AcdWbZlaD4wAlM2woTdXC3zoS2JlCoj+D1LhghYAwtQYA+tSK0JRr5dl61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

On Thu, Jun 27, 2024 at 09:43:20PM +0300, Leon Romanovsky wrote:
> On Thu, Jun 27, 2024 at 07:57:17PM +0300, Margolin, Michael wrote:
> > 
> > On 6/26/2024 6:38 PM, Jason Gunthorpe wrote:
> > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > 
> > > 
> > > 
> > > On Mon, Jun 24, 2024 at 04:09:18PM +0000, Michael Margolin wrote:
> > > > Name functions that aren't exposed outside of a file with '_' prefix and
> > > > make sure that all verbs ops' implementations are named according to the
> > > > op name with an additional 'efa_' prefix.
> > > That isn't the kernel convention, please don't use _ like this
> > > 
> > > Jason
> > 
> > AFAIK there is no single kernel convention for static functions naming and
> > it also seems that the underscore prefix isn't rare in the subsystem.
> 
> Underscore at the beginning of the function name is a common practice
> to mark that function as locked variant.

Yeah, it is not typical to mark static functions at all.

You might exclude the symbol prefix (like efa_) but even that is not
universal.

Jason

