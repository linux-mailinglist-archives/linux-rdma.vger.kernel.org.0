Return-Path: <linux-rdma+bounces-6346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63A9E9FAD
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E9E282684
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B01925A2;
	Mon,  9 Dec 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ML5QyLTR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E05161311;
	Mon,  9 Dec 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772668; cv=fail; b=UsX+MvA7UC7Sf28Bm7j1grxm6zzyaTeHnpugrphCbXd3IxXrNZHjtodsvdytBn5AX9HS4YedcHVvAxDe0gX5RWUnUMdkUj8BUy+WG1ZzUrmR6eOpnQqlNOPTAGWnrfq8MkKL4QFUysuTaPLi/Tp5VE66G+IsyZi0BPp0FIRRIWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772668; c=relaxed/simple;
	bh=kQYJgCkN0JBADuYJahKBHz8szvQAhXNssLrQEabgjgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rIp55tO6UP+ZlMACRJPhWC8cSUjtxHiJW3gSWKF/BXw6G+WrrLQ6Yg/fFPbqVqGcbB56QfRYOLxBaFJXhAUQaIJUNrVU3zyipiKrKYJVxXI4lbZr6CEahx4IGaWGwJOlk2b6FseL0rXgbY4p4P+UfPv4w47eMai1DJsBuYdaBFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ML5QyLTR; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS7O+jdqzHHkf41eprRB9Gjx3sq3q5cFlNO+0jOVZmKPmhezSEExc8oJy9eAz2rBkbK+hIHQdYggk1SRUNy2lnmevOqQ+V7Aslj88OxQ/eEVD834QB1NFtOu8BhDyhKz6haN4SqCl2y3YB4YZDHT6CB0PPTsPWCvaRtLA/UbOF7SdzBOGrLVDK6Yc2gGwzdF1XS7bY4aCJObVS72QXNlAMfOqXJui6G1QIb1GH+k9BnQlkPhnovg7jFqMDuIlBcmzc5GjtexdEb0xQyeAJ+/iP+vs1I3xLBS+kvooSdtvCX38J26jCa3eGWLSUu5GZ4TyBD3/5IVTBKW4xl/zwatwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2jMr4l8/EuijroFFPzSfeXs/S91SqQMKZkPB8Atxv4=;
 b=iVWeSGMRhJ+ydTmixeJAY8ApMjncgEV0VVSlLdrzQxfOnOKHBPG1qhPMkLEiHLTR843BoCq3BHFdVm9z6xNP4p5aP2s2N9D3xeRFprFWJOO34FbpPuTa5jv3d7/J1/ZEI5HJu7kwgb38HG3q/PsjCfSTKg3b4lEtFEV1nIKK0mqT6VharwFj9ZjpVi8/BIQsKlW6GUbvZJ6rmin/lXnnzMbTGahz35HDBBYTMpsSYRWKMqcQXWGuP+pq5iI+weFKv70me92fVfmLXouXLLmApJukij6tN5Kh43D2yEaXiQynU+8hMByKlxlQ2coccOE88B4nZ3lT7NbXfzyLgBAHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2jMr4l8/EuijroFFPzSfeXs/S91SqQMKZkPB8Atxv4=;
 b=ML5QyLTR9TCMaOjlCc+u+D4pe+IfX/WgCHIEaesaYcdblGi67FaWjA1YtrTYrvB3TjZyiJbMg7Iz0lcsIufEf4ZgChFLyx3toak9QDC10ueJZ4h0mLL0gXZdp0aH2fSEyPevAVBzv6PMxI0wFckFXOM2xkk8/IiOjl/pjQiJWOywNykayFtJdTnEWuTL2TNe42hyJUk8zsYbZUbxXbkbJMYh2teIMhmDUPEnvfh10efmk0h1D2/HhSKQYrcS+PmOek+/OPWYieq6AmIxQ8eRFVll5EEpqqHHLyDTq6Ztp48bYu2jRVIOP+Vl8TCp9aG82TzZyPx9goDrbxOIfRMjyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 19:31:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 19:31:03 +0000
Date: Mon, 9 Dec 2024 15:31:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Message-ID: <20241209193102.GD2368570@nvidia.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BN1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:408:e2::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: e1017c6e-7975-41f9-57f4-08dd188804fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cr73wII7EQ7T+2D5Xl0k8vJxdOUMgmfuHQBt8yVEOvtjgQVRmqNd+jfsqcIR?=
 =?us-ascii?Q?YEoqWoAvXjgbh72MhgGDYa91njhQ+2Ak0E5TwCZOLvgazdjv2ZCeo65TN89g?=
 =?us-ascii?Q?VVjN6B78PPZQhyD+G1SvCNW49mZ+qa5OurRo0YyEPEgF0Sx5DMUBzA1cqGrB?=
 =?us-ascii?Q?6RxVWhEDJBShW/sQh5AfDcNIZbd0lgvMhYpeonmvxnRwbZ1U282gmyrqdgrj?=
 =?us-ascii?Q?5w4S9nySc7BW3CHSDJQE47HhUnHCF1KPv8igaPZTzFXazlDxSYq0ke8uoLA5?=
 =?us-ascii?Q?szsF52Cee7UIFbd7cMs9zhw1Bmx9p726HMR/OyTWhCkAFIL9/41bNQ0/NxHO?=
 =?us-ascii?Q?BsC/EG0+edh/t65mhELoRW7NNK8Sf8xz5lnD+acepAgpEXdaZ/vpU4l0nlFo?=
 =?us-ascii?Q?SJLfP7z6rQce/gJYAy2JUMNawtNd93kdhHs4Je1ZQknEgfHL46qUWECnvvhW?=
 =?us-ascii?Q?fhlRhAv36bdZknqLRli26mZRZV7ankf5GxYtPKxJIJCWuSOBVthufBPujMz0?=
 =?us-ascii?Q?5mJsU4607blkS0TIPlfR2zYWKC4K6mA8w8+68G2jBOvRLtRjMv9RCnpFWEDp?=
 =?us-ascii?Q?qQ9Ork455Y/Xkv9VUNrGLoaDwGSsl4XYKsH6FDW+PKs1ki3YK8kIzj+osAhY?=
 =?us-ascii?Q?NC9gMV5GfDKFz6dXQI07076bWQOGj6ZGPW6LV+A0I5fB49fNuivZFHevrDkA?=
 =?us-ascii?Q?n6Thce+0vB/Hal2GStyboR0eKpu/zrJDqysmw9NmzmvzFauZ5KcFfZH0BMjN?=
 =?us-ascii?Q?oi2Nr+Fzp8aEwMT2PlcDfnAGHIhYt1XmC6bhEuTn2lmtBTM5GCcOK8HNtni9?=
 =?us-ascii?Q?tbQyjqpk7ah6oqqlXmifEMVxRlxSXjhNl3S6F+0+i1NNjfAM2aSqnRF9UZyi?=
 =?us-ascii?Q?tC7DG5lEi7DtMCyVViDK8xnmj8q5Qqrye3ZY8WWk2aiWHnAQo/QXbjQUUAI/?=
 =?us-ascii?Q?q8jGUBE86Rsf7CIslcFhazgwdLKNmitdLHcBQTqbkKDT7yDX5xtxCom9pUNr?=
 =?us-ascii?Q?Zhv61ddHbc0xHxcOTJ4dWr4zEjY5IqNWl4RtLGwOC4AEbYKlrF0FbTawuwRY?=
 =?us-ascii?Q?wJxQlVv7qh38WJKzheKleZmx5IxY0EZol2yJFja+kpQYhelgScQaW0Y834EF?=
 =?us-ascii?Q?LDR2aiWIaDtl4NpTiFG+rMdYIP9sZSATFOCSBvS3OOJBnP9fZJojQWbKs4LB?=
 =?us-ascii?Q?isQgN8qgQfsSTouS2RElnFm/B/dXj4MSH6/BR2sftMIpks4VNAuYFqYsaWQU?=
 =?us-ascii?Q?hazPhuscmmnQxAn5kzBFQgmeMNNEI9Sii1zAjHTsqoagEe3b6PtGsmjAPSsY?=
 =?us-ascii?Q?Xi1qrkAd5wL/zrVEzWetZ1J78rg9RxkjI37Zczbea3Z48g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzimHm1ZUfIFqjyrc/H/zWtVY6W20xb+bhjcSZBvhB7A/mwnqjgX3gdKpj+9?=
 =?us-ascii?Q?gacUiReMv0fYTEMEs0prKhRY0nUeIv8zgTS6X0bLHC13fwPULqFlq52hzU48?=
 =?us-ascii?Q?8nosHTZ7kli3EF356M8Qe9Rl05dfM3h+s5nicjgF7VK7CiXGbKX6PVUXhjcC?=
 =?us-ascii?Q?pBKnTeMQKz29czxEpgS87xeHUQWT0eNd/pIiPoAApkxlYuIvOGd86j+9tZb2?=
 =?us-ascii?Q?djYwQ+5VDGMsJ7Zt67dAGfS79gz9jRm45yuJ3rmPzjFHs6EbPFnTd/kv3te8?=
 =?us-ascii?Q?TFZYalZBrZ207NlJkLRGGh69fLcN9+yOnJe0hZksaM6C7pNYThcQycpapDvB?=
 =?us-ascii?Q?rtUq+DJA9Y2h6jh7Lj0rVj45ALn0zvYbuBbtIJclJcKzleAHnYss25h64z6m?=
 =?us-ascii?Q?68VWAciB9wVOn1XLpp5b/Q8MuNMihyzudS8fZTSbWBtPzOxlUTb2Q40phSZZ?=
 =?us-ascii?Q?F8zJ2/0nuR9715eLg5MARVmeHkNSilJsBxzSnIZ/uAGRZHeC7mLqMMlIY/P0?=
 =?us-ascii?Q?jB6VmlLzf+1C3+xSuS1XTVGvfeg6Zb9XIxE5t7gzidjpINki91dNWiHr30bg?=
 =?us-ascii?Q?U5OW7nNYSYYfkLhbfZ2fDkkdpVxuYDUeHfcNjyfY+ZZ/dfTYuYsAc94XHYkW?=
 =?us-ascii?Q?U+RE7ueIunHwsdBo0mpU/J7jgAIWNCyHU7pFsDKEyeo2D0k+i/HSmAEePnUd?=
 =?us-ascii?Q?kCldGC1bMxrm5Yg/MP5thqOLAV4TN5b1d5EcJJR33857vmFew+1ZxNtVgKMO?=
 =?us-ascii?Q?flYIC8yomv4WltL1Ey/OYVm//c3anUNRyrOyFyt29K9fhqQ3SJwkbQFJ35yR?=
 =?us-ascii?Q?/v9KnOUN17lJcuIApyVA7YZkvWOwVeR5xfz3xxusOxBSOwj6tJ73NpRWh3PA?=
 =?us-ascii?Q?qu7jvJ2OzxEL7tG2kJ4zZVo0PohGNIU5l02g0rTmngEDcv/SVDv55yDL74h8?=
 =?us-ascii?Q?uEuXu9Wqu3FPm4wKVR7cmkZ216UqPWNspzu4BHargitgU0cTlNirsM2pu/ru?=
 =?us-ascii?Q?YO7vRDvApO/wHMDLMBa9pykgyMGihfcakgDDC+zF4dc4Ewqrdbo34/KQDW7c?=
 =?us-ascii?Q?lCJb6JHVRMCJMPfNk894gc+7MZ22q87uNFqq64epVakczF0nhM0637xBxiJr?=
 =?us-ascii?Q?y2AlJkxdI/EtO5LhPXNCOVGKhYL74JC+T6kvwTu3ng0yulCHqqbYVeZJcCde?=
 =?us-ascii?Q?ujK4xs522z4bl5xcJpxTP1ffLhl41DcHw7XXpjhkoNYUjeG/VHhBda1NzU2e?=
 =?us-ascii?Q?ApGVJ8gdQyUhcByogGwioQy/m/MXihf336aXyfy1BcT7ysXJW8m8xdWf9o9r?=
 =?us-ascii?Q?1/PmFq/+HUv+YWccqY2CzYBPnpEZeLpWNMW+2/si2vJQY2GVOny1xy3qA7+i?=
 =?us-ascii?Q?MXRNsINXS17nr6BO4ElHvcpT6BBoRFAh9bjW1QwT2d5nIAlnNAZexNsPBvVF?=
 =?us-ascii?Q?m8phG15oYoWypH7xyYUEoYhU2Pc6qe8qFFD3TmBxNuzbj6JC/Pga+lB7ejgk?=
 =?us-ascii?Q?KfpamfwUG+aqBB+JKb2vrnvl4CUFZ0TpCeAfrCtHmGgiH3uVZkSbPGUy0IuH?=
 =?us-ascii?Q?CZ5V8UrPfIsgWgv0l+XZ/ps/9eTKJTFMW3mDtkJs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1017c6e-7975-41f9-57f4-08dd188804fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:31:03.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmuTfToOWN7EnYyXpiFdVbTI0mhZk38AN8R0lHA3wVCurJxhSzzbFTqATkK1HoFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276

On Wed, Oct 09, 2024 at 10:59:00AM +0900, Daisuke Matsuda wrote:

> +static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
> +				    const struct mmu_notifier_range *range,
> +				    unsigned long cur_seq)
> +{
> +	struct ib_umem_odp *umem_odp =
> +		container_of(mni, struct ib_umem_odp, notifier);
> +	struct rxe_mr *mr = umem_odp->private;
> +	unsigned long start, end;
> +
> +	if (!mmu_notifier_range_blockable(range))
> +		return false;
> +
> +	mutex_lock(&umem_odp->umem_mutex);
> +	mmu_interval_set_seq(mni, cur_seq);
> +
> +	start = max_t(u64, ib_umem_start(umem_odp), range->start);
> +	end = min_t(u64, ib_umem_end(umem_odp), range->end);
> +
> +	rxe_mr_unset_xarray(mr, start, end);
> +
> +	/* update umem_odp->dma_list */
> +	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);

This seems like a strange thing to do, rxe has the xarray so why does
it use the odp->dma_list?

I think what you want is to have rxe disable the odp->dma_list and use
its xarray instead

Or use the odp lists as-is and don't include the xarray?

Jason

