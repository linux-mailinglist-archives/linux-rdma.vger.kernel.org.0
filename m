Return-Path: <linux-rdma+bounces-150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6697FE13B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0899B28248D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4246B9C;
	Wed, 29 Nov 2023 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iCugaRcr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2CEB9
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:40:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtQtkQvCkaifEVhmChF8Zkgmfc9/MjKigTaCPve8+ONIKVWiEDF69F3OqLhBPKGGv4ZLU2C+VCtzyThRBaYdFV3KMJNmtWKBeG9VO3nwBIkzmHTKTEfXLH54czCG5mYsLsUwUJgbEKoEMZlv0AguTJJNYR9G9PFUoxcWWyonniCKohgUyj9qXLYqskw5/QjdI/CFeWZRFOEALac1udlnCo/QCqfGCALAABRAj+lDaL6q2y3wbFVuJo5OYGANueca9h8pfcRAOCME25gtl0W1oXIj9GQv4KTSal7pPdQonp9N2UdYDOiJ7ZV/z59ZDm/KmPyyenc3oCFl0/jgbOp3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSnUqQ/JLqTLlqhjYkeEmKndpseJM5mAAG1GuQ/E9UI=;
 b=acp7N8ewUOnnYgfrPmhGYLf6b2uHkbvePFNgrorTUwN4gGFu77zHCzIHnwnokJuxVwyGyHrrK86jIR2zO9py2Tpm1nzIQZzkkQdZx3AyHrhetWbaIfp2bDzfZ8XW1iL6rZNTeTDVbfE0Lfddxz4S11UFS4QVSBsAUWxJKdGmRD31zdcRZFtHeCZCyL4ZN6BUKqsMt3B4+3tEOiYRNyeTqB4eaHrVi3HfByiYjyG+Rtc2sBYVI3zX6gdXVPzm3ARVWBaAdeHS5R2q4tN2q7/1PA8JKxiNpuOvxgQHuvN/bvuFSB5KTsQSLb9nn+Ob2fv7+C9lIpkg/3s9NOabKGyOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSnUqQ/JLqTLlqhjYkeEmKndpseJM5mAAG1GuQ/E9UI=;
 b=iCugaRcrGbg7rrDl4bz2OTbCv12qPE+0OHzpUbKV/l2XA3RCY6mofhAnJlmViy2FP2VSnEclwEZtMvClGTb8Ehr2BIPlNVY+iEaZfNQ7NdWDMYQRswKgQ5WiAnI/ekUZC0Phrdx1aOm5zV0otUQt+KhocZGBd4+tZMVOlFbFr9Jo5rx0uQu8DfyT1MxkV7CJVf4wRr1m3rp6ZsA9aHtJSjtdoybO2bNv3j3GmVufCTgB/lcE0opNUkF6Rt9ROniikKDWWWKi2I+deTOQGhg3ZGiTU5CBSM2B8IcbA/xa0R9BumJxhgQtQMwJLJKsuLXwRPFC0LTu58LzYX0mEkEKGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 20:40:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 20:40:08 +0000
Date: Wed, 29 Nov 2023 16:40:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH v2 for-rc 1/3] RDMA/core: Fix umem iterator when
 PAGE_SIZE is greater then HCA pgsz
Message-ID: <20231129204007.GA1389974@nvidia.com>
References: <20231129202143.1434-1-shiraz.saleem@intel.com>
 <20231129202143.1434-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129202143.1434-2-shiraz.saleem@intel.com>
X-ClientProxiedBy: SN6PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:805:f2::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: e86c2c11-f36e-450a-9287-08dbf11b607e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RRpblniiZe55ZMbDXeuelHVa9AlD/V68QOpNhrItn7r3hosSsZyZ4msDrA21SRhwcia0+6N6yhs6BZrAS6Ekop1CszDzsdre3mBlssz+9pfqy3ZvoLRF9siBWL8bWi75lATQsd27OQMNeVeXsytd2zBo1W5gawvz+Ds/4DDzvddhwcrJXjjZXzMOfUdQJw8k41sCVR2GDBsAE8+bl8bTnXLXmqwaVzff5j3Wybr8uqudKi2FdiyyA5xoYiFpa8pF5d1W2Yb8ElulD2wXWBI6LIthfrIII2UKE8+lDR9U8nP7PmXMF1YBt5XKsobx8S5OTjNHUZ34VM9buUj8/wuRUHKqBuN1yrss8b7KSaPPn1VVEp1uIYNuSufUDszPy92gLOgtCBFhV67BMZzpY2X9SGKO3hkYUD37OgXidohpjO89xgiYVOGEChVZ+UEOqPU6DSx7T5vVv+7cErHYFB9wBWS0UGMp0ZjGvElTh8Wwo9vPeOSTwzw1L0Fm7uRFsDcqbrKu8YakMxYtT9rpCSz+ujhPCyeMHsSmBm2sdjbbChGdI6cF4EYl9nACe7zBIOSHdNU6IUuWmyDPvjEQkllljeOpZR3Kjmwy6PdPk411dbxUBAK+A4ZiltztNRVhM55Y1BRBN/+onY26YxZDnRLLZdoDipYgzlZZ6JGwrJ5OaY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8936002)(33656002)(86362001)(8676002)(4326008)(6916009)(66556008)(66476007)(66946007)(5660300002)(36756003)(316002)(2906002)(6506007)(6486002)(38100700002)(966005)(478600001)(202311291699003)(26005)(2616005)(6512007)(1076003)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbFhFyTwFxblWfO7FIPBClHcGx1UUCXHI0neL3FzZz7ogg+X9Njaqlei3vqD?=
 =?us-ascii?Q?5C9DrjvW44vOF7RWqGcT8vQG51thNDG+kDobARSos+sIe29dCdazb6v94dMo?=
 =?us-ascii?Q?/fXTJkX5wwdr8Ev0UXOCzUfmVO3Kb7uXpP0+dP6+SCvCF5iU7aOb6B148/xG?=
 =?us-ascii?Q?QfRX6jEpxCZH6hMZksCE3TlDfE35n/NC6kaqb1vSfBkQGjDqVipttX3q8aJy?=
 =?us-ascii?Q?WQRZ1UzpCrsFscVBB/MzSm0A0YtGGh9Jxg6IpfuKKXfchv9e+MEaQC6ngM77?=
 =?us-ascii?Q?5q7LjPqhg+Z4OLxCV5ytXXKPVGcsquemJmzgcXsZv0ODVv/F9XyarN7PpWKb?=
 =?us-ascii?Q?P3TO5vtLBlt+mvaNScZuPMnsqAuKYcLjLI06EtnlaHMoeqZeH35u6DBX78Za?=
 =?us-ascii?Q?BlXL41nsmCPuTEnnCRNP18w/aNyJrLmSI5JPunMiZUq3KQLcRuryELe0sh9u?=
 =?us-ascii?Q?SRxs668Gt263xDgKGqIjulJ5I933i3XO0PIMC6KqMTy4B0cVAtrpTJgCJMF/?=
 =?us-ascii?Q?eJYSPirSkqIClTzd4sKeJR3xAvnsV6gtVojYk+RG18GlKFJFowHI2+fvuFcK?=
 =?us-ascii?Q?Q5nXB4bK1mSjiEY+pxg2dKH5/3xI/RLg+zf/sgSKPoSEAZzt96Rs9UN7GqKU?=
 =?us-ascii?Q?LVmmQ8g16F11uNp7MYuOD5rtWQnWyTmZCFhil1fW0D3i1s36ItAPie9RJR8M?=
 =?us-ascii?Q?+fUbA4U2uq3Vn6wuw6IPel+/MMFrbB0ktxtCFoTjm8gwQp1HOtJdghzu0tvm?=
 =?us-ascii?Q?I8Ulr3uGuic1r+tyzuKeBPIHjThq/NT5AkFvt7ytDiIHX4gaHiTyaGhxvU0p?=
 =?us-ascii?Q?cO36RUXLez/apqqW1S1Nku/ryZva4W74a1riwzX0lsqfPayMp3Jw9+8be0A8?=
 =?us-ascii?Q?dCWrHXNyh2fTKQdvh/74DCCIwxB1NyeCCmsuHJiWAelUBmVOO1d/3VhMe9iq?=
 =?us-ascii?Q?wb9OHTGFWD2PMUCvZ9trB0AKA843kHgUTOFCnCOFIsbqzGY6Km5LLudFMIco?=
 =?us-ascii?Q?9q6LqeVOfFDa2ExpEcQX/A79F0LZMVYi+YrB1qmGNQGBtolh28noRFATny1s?=
 =?us-ascii?Q?zf0SQadnL/opJfcJ7TyLLHHFNfBrV4xqqMyQgXLS9JvuIqUlvtwrBjntnNoY?=
 =?us-ascii?Q?hX0eX9k3z++ww4KtFpe4wfqbHtBZkBFFXPEZfB2r5aznH/wqDuPc5ZGuUX7i?=
 =?us-ascii?Q?RygD5RQKzPSYHG3/5mH5gTQ+mS6VJ2+X+hk5Tr2jGTm0KLNFszIRn+KieAku?=
 =?us-ascii?Q?dIBUGRtKY8sCFqZWhHbmFTotlo9joR49Q4vbVodRpJ2chauJYoHroaxzOckF?=
 =?us-ascii?Q?UekDlQOISoqQoI/eH9Bd6A8G5YXzgNyUNR8u7cKKT4aZ5+eXuQXVk4GwbE2j?=
 =?us-ascii?Q?4165RvpjxX401cOZVa8iHw+DsYe1g8Pk27IToedMELp2ntdbVTeMUYZFo7p9?=
 =?us-ascii?Q?4htO5fEbDjFPEPrrby9phSGB4oNZEVQGZVF6USioEJZhfwJxjb4di49bJx8f?=
 =?us-ascii?Q?F3fDQWf0BlyrGflr6XBu0MRtqkcacj+CsQcClCAfr2xgiB50LH6HESX+bVnW?=
 =?us-ascii?Q?56+/oPmgh3rsxKF1SMP/9Ev5NCry3XiX+yTNi6ep?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86c2c11-f36e-450a-9287-08dbf11b607e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:40:08.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSUJqOioZPnzu2YtkjGuw14KcjMD9q/zzb5X+RxuJNCdGvS0TOszZBBHSnkvCs2R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

On Wed, Nov 29, 2023 at 02:21:41PM -0600, Shiraz Saleem wrote:
> be arbitrary, but for 64k pages, the VA may be offset by some
> number of HCA 4k pages and followed by some number of HCA 4k
> pages.
> 
> The current iterator doesn't account for either the preceding
> 4k pages or the following 4k pages.
> 
> Fix the issue by extending the ib_block_iter to contain
> the number of DMA pages like comment [1] says and by using
> __sg_advance to start the iterator at the first live HCA page.
> 
> The changes are contained in a parallel set of iterator start
> and next functions that are umem aware and specfic to umem
> since there is one user of the rdma_for_each_block() without
> umem.
> 
> These two fixes prevents the extra pages before and after the
> user MR data.
> 
> Fix the preceding pages by using the __sq_advance field to start
> at the first 4k page containing MR data.
> 
> Fix the following pages by saving the number of pgsz blocks in
> the iterator state and downcounting on each next.
> 
> This fix allows for the elimination of the small page crutch noted
> in the Fixes.
> 
> Fixes: 10c75ccb54e4 ("RDMA/umem: Prevent small pages from being returned by ib_umem_find_best_pgsz()")
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/rdma/ib_umem.h#n91 [1]
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/core/umem.c | 6 ------
>  include/rdma/ib_umem.h         | 9 ++++++++-
>  include/rdma/ib_verbs.h        | 1 +
>  3 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I admit this fix looks so easy and simple I wonder if there was some
tricky reason why I didn't do it back then.. Oh well, I've forgotten,
I guess we will find out!

Jason

