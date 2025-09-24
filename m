Return-Path: <linux-rdma+bounces-13620-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F8FB9A1FF
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03BE19C8082
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C34305042;
	Wed, 24 Sep 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TdoRMKhi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511F303A1E;
	Wed, 24 Sep 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722191; cv=fail; b=s8AyDoe46dMUWwFr6H9/S4q3mT9skYWya6tvgd+LfG0OU/LygyDRoHZNa1SNn69J5ysREW9WZA94gS3n1aNbz6kiMkePKmOQ/fz4N9pqpdfwsSqRe5Gb+nR02EAcesaZ148KAKQl4kORQAt5k0OfuuwBXZCpVFtmJ/JIiUgJm3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722191; c=relaxed/simple;
	bh=9MPqyE6rwunziAVhzfMnJF+bIMFNG2mPi6F7FNINv9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCUfdf8yS56evYE4THpqSxW012nZuTDChF59TeslAG194fJ7HdG3uwQF7xssYzpu0EBAfxVkVDk8VF2feZdDx20zpvGwxqWUl1XoCqXnQIPK7WSgtzpM8nwmmVjbTNPexRWZPyekxgoCLSAl/2PiWYN+Sm3CZIfQYTOtn0o1yt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TdoRMKhi; arc=fail smtp.client-ip=52.101.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj/6sgGX0JtEg4NLrl6265awWfI2RrpOyH2T9lHN33AD3483d8ZojK7JbSvvNI6wTuJA8Gu/fia5Ilx+APmMlBjg52cKM+IBnj8Ls95Qk7ah6kJg1TFxtTV3u6ow6BgzXnMfZAM7dlOpe4rcE37T4k7QAL1IvCZ6+5iIntKC94HxtTLdlB7zE98h0mtdAxpw1FO7e71Ij7b5KvBCrad7TtLr7khxD5yY/9khMMa4cDU+6+I+Pshyta8tTeeTXTgUW17dbBrdivv7K0USPRGPVCCgK4ikP1hOZLGXvCmK/1F8tIq0VTgkDOsesB8gReaVdyceLqQxzfMndbu6hNV+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFRrSFj4oltXMoN8xd5nWwXwqAMoeQd2Gp7DZ1iN7/g=;
 b=Blu0q7FKxKDNS61F2I2godaluN1ChfhVMcP8BNIycFGcUiYTbQI1t7X+1Kg1s7OXwBKW/gGEJkLN/lK9r+MbS0GI3l7yqikDE+W7tVNydKq2LnPZ7TSYrRof9pIuMvFlQsRIISdbKkEQ0qULaGbCsRtVWFRqnDXXeq7D1zPgVhmzu/MBWvCCC6Wo/aUkbrfNa0TIWL1VYdOwmxQ4jGqM807LrOZKJZdS2ah/bZ5/gDxuaHKb0pAkWhR4vmyWT4zY2Ard4Ey9874zTI1Mh95X4VYRGcm89D4oiqRqf5AEHnqXcQJbpu/o26BlXNfBUb6dmnBaCj496QysESGbI2NrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFRrSFj4oltXMoN8xd5nWwXwqAMoeQd2Gp7DZ1iN7/g=;
 b=TdoRMKhi1N7zETw3AiKnsXUO2EJem7puZ/+RI+ZD1UtQchSYghtf/UetujCCigK4iOGPcRExBFs1wLfjmsjiGfFGbX94IU8gD/iUu+9hZVA7j0TZJJVpmv51AbKWA4ED+acTbKdIAadPUg+eCWjx2aqb7ulau17CkIR3GGc9nrLPIKFhNUaTBuEOUVah/xna10Yg8yadFvCGkJMdWtjfGoPIPJepseG6l2TxwZiifYPKO9OZKxK5a/YUrARF89Mi25aGnaDpF3+29RTQ+dyS0DBshOxnhRAL+Jp8X+aypydLU+EouiLVmE5ozkIVPBLqhdXRenBzFCdqnWRPcjIiZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 13:56:26 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 13:56:26 +0000
Date: Wed, 24 Sep 2025 10:56:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Faisal Latif <faisal.latif@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] RDMA/irdma: Fix positive vs negative error codes in
 irdma_post_send()
Message-ID: <20250924135624.GA2674496@nvidia.com>
References: <aNKCjcD6Nab1jWEV@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNKCjcD6Nab1jWEV@stanley.mountain>
X-ClientProxiedBy: BN8PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:408:d4::33) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 114eaba4-efa3-45ef-0c43-08ddfb722726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lgQntXuontLKL6MP/s3uceE0Yt/IY3MTCftV8ZQTytSW/gLxWWdTA202BnZJ?=
 =?us-ascii?Q?tqBht6AXemnTjzb6qRtG5nIuKToasvGQgwj+cPFfbQxhyqJM8MIbqluvHJoK?=
 =?us-ascii?Q?Hdd8YtABHvPpEf+y9MctzZOxK1bVkyUtuMphYLZAP+7SS2CMw8LPgkXo1qQl?=
 =?us-ascii?Q?aNy88nYIJ1RnGlnOGGpJrcxHVe1kyY8IKX4xbyPljIC26OxvypfSPOXV0pml?=
 =?us-ascii?Q?96zKmavcQY/v63nhlOSMQRTrUxikXbUW1wZ56PmwK7OsoAoO66aXs261biGF?=
 =?us-ascii?Q?Z7uSjTdmIJywdMJiBp+hz72VT+cuj/3YeOe0UY+U0OyridkZ0bc7CwXP/+qV?=
 =?us-ascii?Q?N5s54TtSPdIVdj3JDNRtJsQB9DvnNzm9HUZQ3htQJtV1FUzjS0Z4ju5SMqXX?=
 =?us-ascii?Q?R7JkOq1DdI5mUfdIiXqYDrh1psR6+lhoZ8zmjntsHw+vekfbuYfYpwNKG5m0?=
 =?us-ascii?Q?r+SoconY94SHERlUDBtHSTAaJa1F9jQALMvUqRUzgxW4Eknz15XfnrsXH4w4?=
 =?us-ascii?Q?OTNi8lmLsYLvPh8I1EYpC3cpq3bzgVAiQfxem7Pjc0GLvlFHnzT1+tJBRZrz?=
 =?us-ascii?Q?96HNjh+8vBlEpzhzM9Ai4jU16rRO1tTxnBYUOCNFJB2mZFBXiVJesSaRObEh?=
 =?us-ascii?Q?QWyr+TriFVQDqrLXYhQcwbZxqh4j7ezUBa22muD7uVV6fFSLQdRMmoTjPT3k?=
 =?us-ascii?Q?ONLJI4Yfs+HCZugYnS6qxOLy24OKXn+QgWacyvGAMIN0YiRAEiD0C/44d5rn?=
 =?us-ascii?Q?yrKVm1fP8ZVV9fPBawrQmzyrQYSayjsg2jMjQNewB2IRFVYfrkvx2RM/QFSg?=
 =?us-ascii?Q?A7Ok7C4hWjDXHfNoe5lv3mmIxpnq6KdEAzucW4NzrIyfcr6zMHIOjTlGLDKs?=
 =?us-ascii?Q?wG/mHT65DdwFkppJuqu88wZ4kRhRp0+Yy1fgUvAdnRKlq8/cI7UGmfGnEc5I?=
 =?us-ascii?Q?SkMOE0Y0NTG6xvWmTPUXEnu+iv63SVmqoFv5AoTiKAKgkMGtyQrSPepW2V0+?=
 =?us-ascii?Q?+pekm4+6e11UHl2AsZ7b+iHzvuw/Mc74Jq3eNXgN8TD7NqJCncB7AzO1Xapn?=
 =?us-ascii?Q?ShpmJb6KFLtLc/2jWEJYam1iSlfLnu35TJtTZyf5RKWnFU4MDgIZ+V4p2CFG?=
 =?us-ascii?Q?z2KxKsHI4x5UXIX5DSJvF6hMnqCVbQdc418AsXvhBtnOZFvU3Iw9DfWD6jBU?=
 =?us-ascii?Q?vG3WLXoSRiLaSOrTf/zKvJg3R9U0DWPXpyG/al4lV/EAY0ZOMIAxcgTtDqK0?=
 =?us-ascii?Q?TjAU8etQwY6gJIe7mEmtDBZNIndR8u7lMq5ReaWYJxwDeVIF4CB4agsM7w0N?=
 =?us-ascii?Q?v1GA46lGy+glgZVUpDCc3n926yOIAXPgbjFTUkC8sa9p65r7Temb7PlPh+u5?=
 =?us-ascii?Q?W5FnfbzfhAiGcgB4Kx8LNXtBZi5GPWjxhFBTA5QQ9L9mgruPlwOfExrZXLAY?=
 =?us-ascii?Q?++dU0mX7YNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JINaOs+12/yhhVKW43ae8S6463CU9/bWliBPn1Dcm6sVsVRLkkWgrNw+su7r?=
 =?us-ascii?Q?Npjc95ArVyK3kGNJ6hnuOE2IvxFbIM67p45Px1zcGM4rbH7ArSRnQrpWLuzI?=
 =?us-ascii?Q?BvPTOWNzfDxV+KVlG07AbgQ9yxOpCbN5Gv61QRRtwW80X+Cm6RTZ1H6OzOtu?=
 =?us-ascii?Q?w7cdatkuUduJ/ofUiZ78f6kNY7RhMt6cKmeVnNxub1z031wbtHms/eAqDLUh?=
 =?us-ascii?Q?8tc90a9MN8Ptc+m1iIqzXOHwIvjyEAIg58WE9Qr9+kA0h3k6i/UowWpJkd4o?=
 =?us-ascii?Q?5qIv8gearmvhOkiNQIACakJDcMI7Esc4jtEDlZfVpzU1jFNTULAN0SYO+wOP?=
 =?us-ascii?Q?hnSZvA9hLZS1pnBd9Y1CHjPlna+Xy67O5njirDsJoeH1+FnVWEIfjSRThVBE?=
 =?us-ascii?Q?QgSnwa8q9NDeeualbWO8QxlllIYNVInXWhfNEhM/aGVpYIJz5QuU4XmJ2swi?=
 =?us-ascii?Q?N+jihleOvFRuUUVfIbiR6TJnZFWxdMrnA669uQ2PhNdB+S2LNybQuijZVR+u?=
 =?us-ascii?Q?+dCXH4F5DkpcTiLStvhUjf+NRP/KVy+NwG7RI7bdAIAIfVpXs4nc/HOLwNgf?=
 =?us-ascii?Q?Gvnw6wKvJ1ng+4tJJMjJelV4HHr4cPnpY/BtRopoq48KAj+4Q3v4UsWRAQK0?=
 =?us-ascii?Q?bzyJz42t7GsYv9+ZjJ8JKZLRjP69KpT2dfeIwrpMU/QqcjqCrb4k94ODEVZe?=
 =?us-ascii?Q?SrefswvQRiHBvanrnjKZzsu9letraRY2FImQWVXjxMX75h8yMtCBZ3JjFx31?=
 =?us-ascii?Q?vA3H2MEYv0jvNOTMLWRreDXBTOvWY9xX1gPsZzTjFnbImgR0bYwJUQsIk9fZ?=
 =?us-ascii?Q?5p/T/hob9R4jwD0FQjE6Z9+NPRoO5SFaGWhntBFVemFfpr28S/kW0Ajqceho?=
 =?us-ascii?Q?IHBsW7vpmiFwkVihnIbgjpy7ci/Nndh3Y9p5eJfzAhnrQE7MiBdWvLKhyeZU?=
 =?us-ascii?Q?eNMZULkNc/bbgEs+Qif2+iGlg+//lnkb//i+IebYxdw3TsQxf4ejcc+dTXpD?=
 =?us-ascii?Q?P3ZY3uwhAPfieAa3pTngGGUFx2mgRggLpKCmkabFGt0MNld0tKVWZYPhzI3l?=
 =?us-ascii?Q?/sDLo6VpOdPAj5T4E8WV+uGaOIocU4w6PXoOCaBOmfXccvflgw1uF/71lK1L?=
 =?us-ascii?Q?cLh9MRvkhjpJp1wRWu23lU+Biz0Skx8yzwdmdO7Xz+SPQS/wo+GkSu+gEuFg?=
 =?us-ascii?Q?b7hUVhOcQ9JYVwhxCXfaYbYvAGSblbzTKc6SwOe7hvM/EFL5CtSS/tzRe9t/?=
 =?us-ascii?Q?B6wn4TGq0nN/NiV4xJhi1fvo+xuqNQ07JOgY4lmsS3+qhygxPsnVFnfxCb/m?=
 =?us-ascii?Q?bEtbXLPErtKmR/Mohh8AQAZJAjkNWgzERrWNBetHJ/aJd1K5nGOvVzo+p93N?=
 =?us-ascii?Q?V/ee+OeqgbHQQz5UXonq2pZIiu+qE/D2C39acW3gpxQ7ovevcZWzh9yIdCPF?=
 =?us-ascii?Q?13QBNaKwG8ODHJVxJBr+By9m1USzyg8BWVp19s1c2gfzuHyUzMnbzP3GXVpm?=
 =?us-ascii?Q?Ek23pIWVBGHwDHQeVjGmbobUOotJFflSpc6DTI6daTcS2L3UdPXgb0NVNJ+M?=
 =?us-ascii?Q?pLPIqI/x0+/N5L+c11xQKd4g5iIn73hqJU1k7D6N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114eaba4-efa3-45ef-0c43-08ddfb722726
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:56:26.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IusmUOS90Sby8Fy4GRib1d2L9qFrPKchFNKRTEzOSweqgz+fT41JwgC0TLywTL25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620

On Tue, Sep 23, 2025 at 02:20:45PM +0300, Dan Carpenter wrote:
> This code accidentally returns positive EINVAL instead of negative
> -EINVAL.  Some of the callers treat positive returns as success.
> Add the missing '-' char.
> 
> Fixes: a24a29c8747f ("RDMA/irdma: Add Atomic Operations support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason

