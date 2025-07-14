Return-Path: <linux-rdma+bounces-12145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA54B045B4
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A47AEFDD
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1F23D29D;
	Mon, 14 Jul 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTP3lxP+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D727262A
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511172; cv=fail; b=dmxsNIfvdT998nwIypeyzOtIgbBYLe4rYnWcXR5lH3EXi+pe3r8Ua96+HukPm3ZnB3j6aMp6oyIZQnrqscdfiywJIbLUq5WNQADK3c0uVm1kdMHMASKKBh+6dEiLHic1dsAFIPyXhVzlI33SGJ0z1HBZAdTFdGOJCzIIDd4eoqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511172; c=relaxed/simple;
	bh=27WbJRTseD/lX9hwNkXhQCO7Jww5dw6FoKhzsBDQDyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbuIDenLTUhchEsUY7a8YfFqamxSbDerGRZTCJBLMEpm+lqwgBIhCzRjC4onKTGWPSQqWbeWA5iCy+vCMMVmXyUls+P/DCf9AbOBxGjvDG7NLY3e6bNIkUjyg1mnfHz1quI/UZpHnRP2nYuyN156PmgpBct92+MODNPD0VVFbMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTP3lxP+; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmJd6eDfW6VxL7JAc71+C4zd0kfCK1XJ+gdSMUu7ota4u9fhdwRjkynIsEPrg8lGKL8xmapRS47gyGiKh5c5n/Hh8GMNj/DqS8RnwAg2RnVdpJblw0Pt1FM2QkGQqbRv3yfYv54tq2DfzvLN/RDsQNdswv/Kdfu2x7v5mOzXSP5laaZjNhd96TihJylFqhh1uSaZkJihxyeP4L7MPMEebADsjX23OLxc6aJM3s7EK9i5PxnvqH8+IcRB2i1gx4brC1cvnU+IrauUY1HWLKl1HjxQnT57DEVnGTVUlVfMK+urAIH1gMBceBu5teC8OdlfETY1PvIw/7yjqn+NEgxW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBsZYT//1DsfmC3fEefRFZJBXR3ltEIZyIEVXx1Ygqk=;
 b=hh5Cbwy3t/6tcnOIcRu5uFvs8mCBKS/UJmMOSKMkLiSC7I6Fuya6iCexIB+fi2/hhsqF61g3A/76hGNFXzigfJMHs0lvkcHWWEQVk+5nTSTkMx68J9UiMjHmNNkmQPUMxPPRCqD1Yj8wZrLSzsI6mMEoOUiB6D27RU1JKf8KJ+23xTo7s5h3l4YkjDyHW0vusqLxEr1mawSJ4KO8jPi1Udxu/h9f7xA9rKwgQ3FaZ1dl2IL8zeJwv1nZRtlB3QLpBxlof9CeXhPECZSpAsXaZAnVofDWYgjJrUcKn+EX5gv5P4r1bn4M6QyhUPLNR5Cy9dls4Rwr5C7jq2u027MjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBsZYT//1DsfmC3fEefRFZJBXR3ltEIZyIEVXx1Ygqk=;
 b=DTP3lxP+m5eSkUF/zqZG+RaGP1UUUq0SLO4psC9nqmNUIroM5PSxUcSBLGmOD5H1t04TrkopNxq389T/QbR0oE0twfpNxk54/ZgM2UZlDNfQjh2UEq1L0912ZMyrbiXM8o/L+eNbpJSGfA0GwQR3Wzi42A+kyYuyTmZPZrB8I7kRu/Fh+HYtX/eaFzW4+gYcCm7d1oqOt79HJt3qdG0sV2EMZhjPhuS4BBEyGsbyz/2bxzapwf1QoaYqORUOOonTRG9MCVtWopm/2AzRsevfexOsrVVUYgWo1+nYU6N7lKvBq8eBX3NrYa/ZvExED3bzB6brIVbJEla61r/errQiQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 14 Jul
 2025 16:39:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 16:39:27 +0000
Date: Mon, 14 Jul 2025 13:39:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
Message-ID: <20250714163925.GF2067380@nvidia.com>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:208:178::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9697fda8-f4b9-4651-4eb9-08ddc2f4ff4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9u9L0zM3aUob/8GD0iYU+ExSHUmzPYCxFATz3Ghd8cD9/2hUnKWR0Isw4xxk?=
 =?us-ascii?Q?eLfqS/7As749ZiiEU/3CwjKKcSGf5+1YWPx58jpEBRDi0LCcrGn5yv7P4zNO?=
 =?us-ascii?Q?DdqUVGR2tBSKriryxt/IB4/iSA0YOSf5x+k+3NMl1pWutVfBbObci0FJuNgA?=
 =?us-ascii?Q?WAvDTK1r+ngQhhEB6Uxv3UZjLiHcEFnmwpgFNvAET6V+Es567cckfql+qTs6?=
 =?us-ascii?Q?53ArYY5qO3CY1xyOIPSGQILJVN1wgkekJyP+j/fh2mYqYolA0cgvOqy9QRKt?=
 =?us-ascii?Q?Q7mFyUATC+9nFGWloWUmhU1Y6sacZJdMH88N5dIb7rDfLMlQQydzWOPVvjHt?=
 =?us-ascii?Q?/KXyD6h8Qoxq3YHzpovt/F8WV4lRrFm+0WmnEY1owpecJW4PjBAp/Caqu6Qh?=
 =?us-ascii?Q?K6iiYa03bhg1Q5HSWM71oniRhClS/cWD+sNblZn4rvws04SWrOVSiIeHX4x0?=
 =?us-ascii?Q?XgmzonkTEhZR7gXHWDpPF0bWdQq7y2FKbCCSlKmvbP5AuAL+bTRGFemLzBbL?=
 =?us-ascii?Q?WrEuTUE4e9g1wuoHltAo/FPOhtlTRQqNLLEkfCI0Jxpi06inds7wwluH8B1c?=
 =?us-ascii?Q?Iq/RWSQxXuzD+ZOvyjE8SFQhglLJza8GIk006qIfUsjzm0+Pz03OT9f+j68t?=
 =?us-ascii?Q?32iV/KW5Rw/QrLL6XIHeGKsoy3QftobuEu0EVEdbeZrFkCk1GggKil6bhdfy?=
 =?us-ascii?Q?O8jk73lzGEUC7ay5dimJ34oon9kvvqnsLqP++NgSnpmmxiDxdim3eH3wrtSB?=
 =?us-ascii?Q?A2Ynrlo2VtcgA/5kfQBxFwSHj9DNOC5eXriowM/KDRV7pB7qkSQSxkg7prVd?=
 =?us-ascii?Q?K2tkJnwZ8pvw7uKtTHkRFrqft5Ey7m+R4znTsp+NlcBWTi3lfbZ7iNi7yiTT?=
 =?us-ascii?Q?NCOCqJB6Jz8s8MtmoRsF6GawB+CTpuJVEwd3zcElzW3iru6BunmkYnjlvaEM?=
 =?us-ascii?Q?5VxAzd5Fy6Ipm7iaw1jARHrWw7uNQHHGPUEVueOiXTTwWB0yeuPrzEdInLJO?=
 =?us-ascii?Q?svNXYxgm84w0uxLJkRCt5WIhGtHAl9+yNUu9LKQ3g4K4L5MMNvGR2vIc3Hh7?=
 =?us-ascii?Q?fNqhp0GMQmPAOkrYu2kTu9OU8MP9y1zHz94/gf8thwIQiDGyi07EAgQ67pQL?=
 =?us-ascii?Q?NMj65IUGIxj0uk5TsW0ONPUpk20BWLaqdS0jpat74t8bI+CVlqqiqkpv8Xkf?=
 =?us-ascii?Q?58bR9gvr3hO86tm+zuImj4dAQVoHHDkiHCfRQ71cKGSGyJ030bW0CLIVpmDg?=
 =?us-ascii?Q?lp2VK6Iqf48TVtYvJD62zzTxMtqhi5OUa3rY7n//vrpY9jKglG4Q0+1yHIfR?=
 =?us-ascii?Q?mX0iI7AcG2JSUhywNYngoo4eDqqHXdI1SopNyN+p6UnooFNg6Ff/aZHffW0W?=
 =?us-ascii?Q?5AXVQ5YxXmoQESfYI6Wze63Rf92/SXXfaxQvJp3OvUr3hvZ4QDdpfSHIBkjx?=
 =?us-ascii?Q?tl7nW010cSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mfa2npJchMB3goGKPFedzJCZwHT4pVmePaqnInieuzP7tm+lVtqOC4A+ntZV?=
 =?us-ascii?Q?fwxKIIi3jc0/foqB7bn7cDZgeGlze09FQpA0czyYlIkZM22wJj2y8IYUqiKi?=
 =?us-ascii?Q?2V2tElScb3CB3vhK/3zfVCBj6kV0VmVxSSx8MRcFOaKi5c3VBEYhW9XSZ1/q?=
 =?us-ascii?Q?+XxW2CYB+PZz2kAeT3xvBaF5F9a6XsyT9YBnPiNNeJJB3KXW4+QDPTEHwqzH?=
 =?us-ascii?Q?VnGVpKfYZRHKCzCHf29EHUmM0SgW3CQZCXCCQIb36mtJECxcL5MEw7LOnz3r?=
 =?us-ascii?Q?aSgwAYsbNJSW2DHrwP//TIP5mLT8efiZEyg47+kcZHTvwgR/68wouHQ3eSSv?=
 =?us-ascii?Q?3l0tJR13FxPEWvwZ4ZXj3M6fzHjBtqxM2mgsss6VVCErs7U9B7a6LsNM8NRL?=
 =?us-ascii?Q?K8dOMqTZamtXbxErpNCUQOj2c9T1Da30DD6mvbe9rny+Lz4p7tAIKuFRMNTu?=
 =?us-ascii?Q?mcKilu5KNNEVVHObKBz/ux9wjm1QpDeOTQrJsKJR3WpANOlnXRdA0voEfVlL?=
 =?us-ascii?Q?QuDsXf0Etw+gYYuaOCjGThB/BVtV6f5oRvqYAIL7MafyIfiaQaCu5I8lSbVp?=
 =?us-ascii?Q?rWyGbijsT491eslP3X1+hNZ1URdT279bATozrrWc9fr4WTW0sSQquBOLSFzH?=
 =?us-ascii?Q?sdUXpptNZNOtZ5CsxkkwGfGNDd+naPtws5O602D6b5K7oWzujoR//SQh9ZvT?=
 =?us-ascii?Q?hm5+T9d9ft23DhIOQReXgQa3foVmItswjeXn1lWketpGrj9rNfaEin0PpV0B?=
 =?us-ascii?Q?jxoNoEYcPdgt2ky4KdzNX2pwttzXMj0K8o6oZ+uINKAfWmHW3FcpcUSu0H87?=
 =?us-ascii?Q?2z/OEfnA9mCzVRBIXGJcjHRzx7YWPO86/XFn9hUtY8urIGV1HAM+/JNWTwvh?=
 =?us-ascii?Q?xI4If1Vbdl7f+Xf4CSIqFCA9dkEkN73u3YPe7mggC8VBVZMPE7A8hErQcafu?=
 =?us-ascii?Q?mZPtMyqKJVUgM/TSQe/nZH8Tqey/E7PaHmtGkGZp/ZP8oyGHk3rllcklkkKE?=
 =?us-ascii?Q?pNZWeF68/dzuk3hng60SfSqP4HpPc/KpgSiQ0Zt4CAKNJ364Pv7HCgXRiakg?=
 =?us-ascii?Q?bKYNiucxOFM143kuSgAoq7xjiBRjJFpi0Sr6jbZqnQ8H9SbHb3uCpq4l8tH/?=
 =?us-ascii?Q?UOolWtZ3Z6a6YMBt+QaZHAsadPRFzIMzhmZMuhAk6toQXEqZE+BgnMBMxDaL?=
 =?us-ascii?Q?MaALNznf3Y2AGk6wtA8mSSF5pzNBYvBNZfEvajYr4py6VE9YsBnAkPKiIym0?=
 =?us-ascii?Q?nqAPP+Go1rlFKCIJQEHEj73+iPM8R4rubh5NZh2y58Z62cZlDOhMXi5/Vm7e?=
 =?us-ascii?Q?Itx0mz/z79WsJx8nlX59sGHLGpObO3vr6c44L8PwqtAlNPH7E1WhC5qtID7p?=
 =?us-ascii?Q?lHCH4MoajYqbw9MWOg3e09i9QZxK1ydWZUC/qaTlpjbz30j5+vUUMeRAP5iL?=
 =?us-ascii?Q?ohJl1ZF+gyQa8ux5HFQeZRQxmpzxjisOEszbq7qY5/HtG5nB1mGFOXQpbfsA?=
 =?us-ascii?Q?I5vWJSusVLn/4jVAjMrz/cG35+3tNB7SVUFoRbZMbpWLfxtoRB0PAFW2rYTr?=
 =?us-ascii?Q?HY6AF/03DXZiN8pfBSvd3VMrgJw+WKNAoKBaUrdY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9697fda8-f4b9-4651-4eb9-08ddc2f4ff4a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:39:26.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHD9795VOv/eogr9E7q8VfaesKYzgliyhCKQVbQrTLm5dw3ZiwdWcQEC5soZ4cV+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524

On Sun, Jul 13, 2025 at 09:37:26AM +0300, Leon Romanovsky wrote:
> +static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_uobject *uobj =
> +		uverbs_attr_get(attrs, UVERBS_ATTR_ALLOC_DMAH_HANDLE)
> +			->obj_attr.uobject;
> +	struct ib_device *ib_dev = attrs->context->device;
> +	struct ib_dmah *dmah;
> +	int ret;
> +
> +	if (!ib_dev->ops.alloc_dmah || !ib_dev->ops.dealloc_dmah)
> +		return -EOPNOTSUPP;

This shouldn't be needed, use UAPI_DEF_OBJ_NEEDS_FN() instead.
> +DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_DMAH,
> +			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_dmah),
> +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_ALLOC),
> +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_FREE));
> +
> +const struct uapi_definition uverbs_def_obj_dmah[] = {
> +	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DMAH,
> +				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah)),
> +	{}

I think it should be on the NAMED_OBJECT in this case, like AH:

	DECLARE_UVERBS_OBJECT(
		UVERBS_OBJECT_AH,
[..]
		UAPI_DEF_OBJ_NEEDS_FN(create_user_ah),
		UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),

Jason

