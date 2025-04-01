Return-Path: <linux-rdma+bounces-9091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C85A78098
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831F81884D2B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC220DD51;
	Tue,  1 Apr 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTu4VesT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5B20F063
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525312; cv=fail; b=qhkml9oRg2W+rNx+lG3E43pGeooKI2Wt2yGAKQg4RcY+FAQusRsuajl4XpJFDZyHOXi52BAKY/QOmSPqwspENBxEkk+UE0yQN5Hg9mFwh78I6fAVRGVa/HRXY2Usbz9iJ96YMW8+hpP0y4+sLcJLhYE9Bhud/xKwC0OhLpj9/k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525312; c=relaxed/simple;
	bh=dT0eOAPrfzqk/IhDb9MqqF9J5+KYXPFqCqY6mMVWDR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=upYF31BbR8NduB0ZzseMVxO7sw1Ve1wo6txhx+PLaFDEvcMQ7Qabv1pM19QRqVb/r0sRubCYHloFK9B9HQwTETb75n5LQmQ5h7/TI225Qx5fftjGYRJqirLt9BpfpZ1ZmxFgBKSWeYOtWb0Q+3/4MLy/7Axl+8MiRFLhR20gfy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTu4VesT; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UR4sCIUF9OA1dHVApfnPrl3qER7jUu9/J9mW9K/fqACHOrTvPTzQD4piTrMjfTwGqu1zS361GXlSvD7NbcfhDv6fewXYzyGbaLhrRCycOKoMk+OEBvEv3yJFPCRfSkMTgXvmYO20YFj7LnJcPdmkP0SySl7BNL1YfuW5JQqLElQtkvKoyo6Hsjh3DSksfZe+Z1J4tggNY4jVR5qa7jKZjDeY137XZY3B26Gf7r4RSk6V/rGhWCQyfwA6mrA8ge9dZjO+40h2nrqGwJT8t4vBK7iPr/7TQhaNTVJAzLA9zTcWoe2nkYn3TZw/5aIh3pgEZTrXiE6juzHGsA09EFmMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQePf4Hfq9QXvz9r9bHKPh822pVlbBVgG7PJMJm9beU=;
 b=cvAw7cJNUmE8FcYIbbmZjQl+s4QVNMQUoMarIQQ9CQLh+BVLt3/jQ1mGlITFAwiur6ZMzHuAxq62hkLeQHHtU1MK9ZfBmoUfXhFcND/K32RDK626C+FUSUY3wsTcU7nuECvY74zm66kGwBEdNj2W3XiYfOFRcqpsGu31kye62k5pzixJvoRxjZVs5a9H0G7qKWMdlcF9ks1oPorpoMawwgNlDYvQFyRYjajncr0qUVH7a5Igi4TPZ7YSlRuTAslJCBh55U3RYeGhRrsYrdvF4sdZpp3PA1sZucs2tzQpn0KaN2ziLuOxID5H/N+d105rUIb7unGZrNK+rlpDh+VtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQePf4Hfq9QXvz9r9bHKPh822pVlbBVgG7PJMJm9beU=;
 b=RTu4VesTuUkmfXV1zrdBY7iYgoQUyvdhaIBgMVSqDTcgGA+IAH1dB7ZXTKOHtuBuyVXL7bUlnFbFP+Uf5ky0CBbxfMiP3MYGkhZavPWHSXXiGVLvpie+ECD6qb1XxZlFrHTuIPLCSUB+Cv1BAz3IrxxcKRmYd3vFoO5z58QTvCEj6SFoTgBiClIgcnQksfXKdRhzAQy5ej/2906OVtGwQx69GzQSZy8j1+Wsy1xl4MKc6WVCovqf8KN7FIqUkxeKIo9Ej2X+vht5qoeNCzQI2tD9KF1vrY+1lLRdnH6YnW+/yqkgkUAFQBnDq7Hf3jkjlJdrL8FKBs73faNUNXgVbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 16:35:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 16:35:05 +0000
Date: Tue, 1 Apr 2025 13:35:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc() warning
Message-ID: <20250401163504.GA325092@nvidia.com>
References: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
 <20250319172349.GM9311@nvidia.com>
 <20250326105854.GB4558@unreal>
 <20250331174524.GA291154@nvidia.com>
 <a066aa6e-ff4d-4043-a963-52ce83aaf111@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a066aa6e-ff4d-4043-a963-52ce83aaf111@app.fastmail.com>
X-ClientProxiedBy: BL1PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: d735e322-411d-457d-199b-08dd713b28a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FFPQGPmGXC8FSlurQHgnDLnzksVy/HO0BcKejAk75njaT8NjYJrglEESt7p7?=
 =?us-ascii?Q?A6pdWWUiT8i7SgEmmpWEgW7PXE6ZHBE6ebLHnOAaBLBn137skPQ9vHgi4wPn?=
 =?us-ascii?Q?EnBTmx7ztQZ+IO3AXH/NWWIq8zbYaffTOgXThiE3Y/4BPWVldUfoAR6wq4Ha?=
 =?us-ascii?Q?f3zM1O7X8Mcw61i/+BMzJhDFmnQDFeGYUFNt0OwfARIu3RA0VsaC/Qqk3byT?=
 =?us-ascii?Q?kbLLNrAZYEtc1pH/jJ/qPEcEogUEkd8p9vUgyp7T5UXWqnJ+GRpGt4fZ+9q8?=
 =?us-ascii?Q?+0GXnYW24oMByGqBTsMD6pmISPChc61OGiIkG6O96gR9qPDdpjWd3oOfpfUi?=
 =?us-ascii?Q?i9zA0uCUGtqaEPLv9l/t8awI5CGT5JHFQ75Mm7CVPD+00pqtuONxqEJ9itWR?=
 =?us-ascii?Q?DoXis3RlT9SQ0ge55E2hS+o4TiklXdQBfBGH2GMKSrcD2UXsPLow8XsDK9kh?=
 =?us-ascii?Q?6cfHrSD+qEwz591nPkrCg39D+fBwJIXAw4cxT1Y7CINlxmdmgDnhv1yND1f4?=
 =?us-ascii?Q?XIZi1hJ3v5AwmOvjiZy1h49V+SNgh3S+ciUIxQVIbQbZN4OQ6WNDLYwTjz/9?=
 =?us-ascii?Q?iqPMLHWG43ezwOAaNv949HRN7G2LKJGfvlEE/PmY51HX8vVraj2x2OOfXdYV?=
 =?us-ascii?Q?TWja+IR4+Wdg3RCyPDwSH6gSZWC0NmirJT7CJj/bRgYZUrE5dEW0FJHxmGnn?=
 =?us-ascii?Q?krcROp91BT9I8975+GmizUHwIeKY+snvfgbm9ZC1UImKqum586Rs6ZmPCU4r?=
 =?us-ascii?Q?MJu59g0OB2x2qrduglbmmyUFQHPpHRIj+rerqxikzLAI/40WkM/e8pjo+9N2?=
 =?us-ascii?Q?xZzWKHhNo9oLiBdM2ri3/HXH7wP0IdVWcr93FL70+i9yk+NVtOctbgABXpSG?=
 =?us-ascii?Q?v3Je2IaAUSlXkxorZnq4Dczb9wCQZxVV8P7KUidvT/IjeGJTShZUS3TeWX+5?=
 =?us-ascii?Q?nQ5oTl8Afz9n71InFJ6ZG5QQEPMtIQ4gIB81V3W7uD8xai6CU8DbEJJ03XHI?=
 =?us-ascii?Q?zxOoOFq7ide5Y5R1VbjzKmx5203baaNWOWgXKzMP4RoaOlrUhEOPuOgdAV2Q?=
 =?us-ascii?Q?QATWjiYH5MErQ3V97M6w58i2CKDWSrskNrRJHS1NbPN2Elrm/NwXC+7FWbP3?=
 =?us-ascii?Q?KFOEzC0zM4RLfIuJTtOsq5q30NdBle3gRC4GAWexj9m/Cnb2aE/LeTc4yZb1?=
 =?us-ascii?Q?gHlLQmfE1/byNSVWMk7kmEXoIfl3VzVMxwAzXjtwHuVDSupp/Ak6pV+7y0Yh?=
 =?us-ascii?Q?v1WEEf59229TZ4iAFUDzuO2CNh9BuFXrcrG9WtYgB53RfDDSfuVbc1Lwrywa?=
 =?us-ascii?Q?vz0fbhnwRVegzZBPLTnymT6wqQnh5/2IRkbRt5ISFc7/4VfrGbcw9dj0Sq4N?=
 =?us-ascii?Q?uk9n0JjF76LRkpodg+sqUQ6+WqXK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1ksOA23ZlurvrEB94rTCtEXT09y30bvUy+2hQU9C+PPBdjvE56mxSfIDthJ?=
 =?us-ascii?Q?xNBNFRqDSGYUPB8myKzdJeeaxulcfSHDJq5AmDt7Q4tTxewYvmOEY+Vbvc73?=
 =?us-ascii?Q?pzcvgrBpbf6DzDdn+HuA7hmFE1s8FGXRSoTzpxFNItuII2rHDri/vN2ZsA6W?=
 =?us-ascii?Q?sIeBQX7RKENJ2Eae6CIueEExEKId0KZuqidiMO4jTtWCRJWFVo4htuZGrM89?=
 =?us-ascii?Q?E3WN7/gV3ObfVks9FqUHulyxbIXsvBPJjS699REiW2Lz8me2yKQVdNQ4mo+B?=
 =?us-ascii?Q?6o04PtoLbG0XgvS5p6C51kCYD9R1+QtmXWF/y/JZcLWl8LARY53wKsSLIGuK?=
 =?us-ascii?Q?ot0R16eZf3ByDa+gS/G39u8w/cbRxTxnO9so3JYGP3Jr4YtgYbP3ttpWR614?=
 =?us-ascii?Q?b2GJYBJoRuB0f9Gmj91tQmOi6kqd1QrG7fNAsvzGfSgrz7cHCcTmJ5i9JtlO?=
 =?us-ascii?Q?0IrQXMTPfOdmSdnJL6IomZRKKUUAGWSWRgU4JWIAYxYpMIpjbj5ccmjNTkb7?=
 =?us-ascii?Q?45e7HbNTEKFw6LHTnBceh8Iof+DoJ57/nQAHYKNR6GstE53CNgomZrySgP9N?=
 =?us-ascii?Q?dcl5lrUtmy+uXnWw9stlUptKWG6sACRpw8PO2LtDf/MeIdYkyKWtlOGLTefZ?=
 =?us-ascii?Q?XRh4mtGfRc827tHSKXmU5/j9jOQ+SpmX1XKE2FPtSFKQrTprNZbcEq6ca5Xy?=
 =?us-ascii?Q?CT5mx9mqYtZTBWEMc97/ZGSGyaKDLx0cqZgzo3Y/T1SdZnjCN3BqaeyiT6bw?=
 =?us-ascii?Q?MTWfbgMwBmQpuizJdBFoDDVOJ24Z4hfLtuNl+FySKSGa9DokIzQcAFPKbdwo?=
 =?us-ascii?Q?iO09rS89rSrqzn/4jEvDPDCud1ndrJvHXzB+xFNh1sthQE7/Z5t+FeYx5kxb?=
 =?us-ascii?Q?Yv8Cy7tk+vVQhOU4J9fnR4+6VE1hZNRgOlfBPahiyHcnc2NPmOpjcItN2oZw?=
 =?us-ascii?Q?H3LtxAiAUUsy2y8xKl/ROMJvvDPok9miJZu3FkvOaFZTWIT9/+8MF9zcj8D8?=
 =?us-ascii?Q?Awv2XnDxySrUEda+gzQqONtJv10cCTAw+NiEEVK2RBINooQH6W1ITuk4zQLE?=
 =?us-ascii?Q?4yg3KCFWPY2hMG/B9DxQQvrkAuIhoWqaIRqn4rtcYTHi2nrukvG+eNPuKGq1?=
 =?us-ascii?Q?PRC91BUiXXm1X12c/nx3530FEBmLNMKzr/YCBhfTvExRCx6WAqqes0J7PHKn?=
 =?us-ascii?Q?/Hvt3Yfwns3pPQXxeSZPNmhD6si7PWjbPF9TXWJDsoYmFBFThL/joQe9F3LS?=
 =?us-ascii?Q?9zJwTMakY8B4tF9mU47V9glgwpVAzdOWFJeUYfzVGYAKxE63LHoMVSV7buQ6?=
 =?us-ascii?Q?q32XDoRPbJMAXsBMB0PxFRCJoiMuKlyg56OMSL5L0xKZzmd5QRaoW+uCtE4d?=
 =?us-ascii?Q?hB0SJi8lhgrr+7IshWwL2aeaAmUAq58AB3ELnBeC3jNQma8MLboh9ceUXXRA?=
 =?us-ascii?Q?hf+bEljCb3Ylpj4+KrR3emCbX8UbGjKlf35uL95vRY1amm5w3fhywt8ONqsR?=
 =?us-ascii?Q?sLMVLAOuxZSInU0AxRAlq9drWxUqVzMvrc3LhVITxfGWLMysmXzza7j2AItY?=
 =?us-ascii?Q?+xaCWsiXyH+wWG6ZBoF5TkCiE3bQzuCpeXd5T9mC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d735e322-411d-457d-199b-08dd713b28a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 16:35:05.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvVGs69yEx7wvuHu0oVnkAGMa2RNoxlSMxRUMY/18a0xOIiRQy85nlbk4Pt//jKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867

On Mon, Mar 31, 2025 at 10:04:05PM +0300, Leon Romanovsky wrote:
> 
> 
> On Mon, Mar 31, 2025, at 20:45, Jason Gunthorpe wrote:
> > On Wed, Mar 26, 2025 at 12:58:54PM +0200, Leon Romanovsky wrote:
> >> On Wed, Mar 19, 2025 at 02:23:49PM -0300, Jason Gunthorpe wrote:
> >> > On Wed, Mar 19, 2025 at 02:42:21PM +0200, Leon Romanovsky wrote:
> >> > > From: Shay Drory <shayd@nvidia.com>
> >> > > 
> >> > > syzkaller triggered an oversized kvmalloc() warning.
> >> > > Silence it by adding __GFP_NOWARN.
> >> > 
> >> > I don't think GFP_NOWARN is the right thing..
> >> > 
> >> > We've hit this before and I think we ended up adding a size limit
> >> > check prior to the kvmalloc to prevent the overflow triggered warning.
> >> 
> >> The size check was needed before this commit was merged:
> >> 0708a0afe291 ("mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls")
> >> 
> >> From that point, the correct solution is simply provide __GFP_NOWARN flag.
> >
> > I'm not sure, NOWARN removes all warnings, even normal OOM warnings
> > from regually sized allocations which we don't want to remove.
> 
> I disagree, this allocation is called from user space. We can safely
> skip OOM messages and error here will be enough.

That is not the standard, we OOM splat on all userspace allocations
too.

GFP_NOWARN is supposed to be used in cases where the OOM has a
recovery and nothing will fail.

I think the right thing here is to limit the size, though I'm not
really sure what the limit should be.

Jason

