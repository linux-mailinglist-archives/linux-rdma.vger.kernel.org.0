Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64AA6876B3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjBBHrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 02:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjBBHrD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 02:47:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427C740FB
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 23:46:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPmrsdYQtHyNfjTohvkhCQJENhHF0ZHj4le9gt3Cu6CKogxAp4kcY28HVzC6/d7ka7SSZGs5uECr/UdHN3tsEUfRE329vlK+Zs4noOHDOO0VtAXvGkeUJXsOpbwFECHpJfA/UkH8/J88rxCQfuTG/ztBmPP1SxMEk9GZf6mmyXa7AyoVO3neHCNFzXOURkbuLMx98oZA6vxwp6XPO2HvrspXw32AwZ9soArnV/iKEKg2CqdFvrYFsEUdZ56nYIVzNpwxJ7bmtFoFf/tyrplPJeCCIuCgMBEfari5IUJvYGuYFA6OLMa+lTntWWRDxjmibhwd3/7IWs5rqBYahEpu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6k3MLDZKfjd85NHLMVk36PJQAPg83vUL+qnc2Is5x8=;
 b=QdiBWNwFf6MJNMva5GkBoD1PaKQnlbXsXkNi/t7zF0pV9lgKG42TQNaISCDajc0LNsTgWwhS2QntWyuLmVJ2jFXcrb6mjFB5XfEDbYpQ9xDDENod5slU75SYvY2n8AlYJUVYWugA0RVvnKXeKl9kPOz9q2Y4xVeQCxvcrgO2tHGMEcvKDGWPZXL02uroEkaqARyIiN/KGCJrburYg/QT8aMG0Ppqph66LGMA6UOcGOjcKQPvEyWEWbFCpmicN8SBD8Q90QXHFfMrlauB0tSe8AogdyrkF/CcoeV2IFMbOPB8/ht988euCwNV269Piyy2jI7E++ZonjI3AwN5loE6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6k3MLDZKfjd85NHLMVk36PJQAPg83vUL+qnc2Is5x8=;
 b=pgVkhtuZFmDMdWk5xiQOb05iP48WzBTGbARoQtaRjmxD2Ds6TXGVyPEk/Lzf9S3ER8obJAsgdH39Gzn5Vw3/WRpEEl7kar3X5oFibjtrOx78Qi1ylAZ7VoyY2CgQ2PorxdEeHnYz6m1KHFkDKfPysCRgUVnnjTcaaBc91CmzNrzC4FynHSPBtklNmCus+XTyZu9HWJfA61gYSky9hetBm/oAqk7e58DYEXwZKfFjl/jNF4BRJpRqYOVcp+sfkfVe9tl2SjdPzy5FQZ7iUBHF5kyOs+Znfj/uwjyNtivuvnx5RlHrBvnDmvye14m/Gb9o7hQiA+DF9ho0SV60MgdPRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 07:45:51 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Thu, 2 Feb 2023
 07:45:50 +0000
References: <20230201115540.360353-1-bmt@zurich.ibm.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, leonro@nvidia.com
Subject: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Date:   Thu, 02 Feb 2023 18:44:13 +1100
In-reply-to: <20230201115540.360353-1-bmt@zurich.ibm.com>
Message-ID: <875yckmrx0.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cba24c-4500-490f-3bae-08db04f18138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhInI6yrKNRYFy8mnKKwx/uwHgMYjavCpbskxlrXNl/cyh/37gKllLiYN2FjuUdUZAw+8dC9qsMjM3S5ygzCVKvK1oFC/3EEw9mHieX3LsVZf70c0aIKwlp39nlHY1JatjQXWrHoiV0EE/C696ShDr3CEa0FEkiKt2eOyrW05vSjmXuX+KUvZlZmTv3CNiqmyUj6o8YfpRT5Pbrr2KT9YYTj4K/vRSZVoGUsgDywMvmF3Ws7LGEhR0iBtyZApYwRsQzqwlAwilAjqryXfYt8UBjaLnuHvMvXytZqIOt/gn5UVIVQ6mpdc+DRS2K12wzIAl6iqBBiqk30/OYBMR0vNg3mGPmDgeB53a4u5eNvQyYQIDBhHkoYU8gNIEJaZvsw/yoPp6zPEgVECdYv3dUXHoH1J0XWFrOoblb1RrOJrUdgU+mlkioFwS3W/8DNusjg3weCHYoHZE6jMrIaMAp7T+E11tqsjcOc68Mn1p+pAnuAC5twEvrd+enu2x9j4D99Im1pyHJxYmDUuHpqoP8gln5lJMY1TMUXY4GcWBqLLIcHksFPRsDwJ7Au7nPuKEb+G5ZN87cF4oimZjfSuTuKvcdhZm+0hGbNckako4mPWZXp1QghYLQvuKIkudpkfmwjClFjcNawVkuOwzmJknjI+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199018)(6486002)(478600001)(107886003)(6666004)(66556008)(2906002)(86362001)(66946007)(4326008)(6512007)(6506007)(26005)(186003)(5660300002)(15650500001)(316002)(8936002)(38100700002)(66476007)(41300700001)(2616005)(36756003)(8676002)(6916009)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzG8dcNzrFitkRreufU/3CXdLmofIyt5x0f6r9PMJh4elrGNrJK9KCYwJ6NW?=
 =?us-ascii?Q?1IjtVa2OtNH/khNfNYDxc/U3GBtavblOHXjfUTKaAqOr2K1Vlp3NDmf09z8S?=
 =?us-ascii?Q?SX2ZL0afzrRd5o2o7t7jG/smVHPGmY8vU5SxXILxWHLMJNsn5PCASSDAxzts?=
 =?us-ascii?Q?M/PvFvquoPIwIXvQU8MXCWrNpOmvh7O970DM3Vn5dwlLZLzMxXwiotyuHnFy?=
 =?us-ascii?Q?g73p89Z6J4wxA1BvnUso9QcsMFoegdhM8/yWU2KB0x2mYJTw8DD8cZYAjvpU?=
 =?us-ascii?Q?Ek80LByQOZMWTW7e6juudew8bxbY7F3+O4+FoP+0yDlpZ+75G/tp33oQVEDG?=
 =?us-ascii?Q?M7P785XlDNtuZ3JjKa6/pf54PZDxJffJDppRPufiXRg72AEoQ+2qacP6HgFe?=
 =?us-ascii?Q?Qf/LvX2voJFJlgQ0oc47hzGAFsiaAhAi5xPoYmBjbDTyLoT0D3fjuGNG6gC2?=
 =?us-ascii?Q?0JJhdzM+Kb5A2ubwak8WcN4rHU8HN9xacCoT36NEohWbGVwrWACcrdTiaMET?=
 =?us-ascii?Q?fIhvuKnSKDHb06cVMPmVo5MNxxgMDYXFhlaTnzSMO/RYaqD5pGDmfxuolbQV?=
 =?us-ascii?Q?uY7AWCiMtJc4W/1xOT6/hAFhBNc4X0GgNpmlcFzFW62vcU0ukiLNSACrGujf?=
 =?us-ascii?Q?6QfMx1zoaxOjF7i4AgY86GPTUwmPUM4yIBKJDdS1coxsw+UbSWIgZ8BltBIW?=
 =?us-ascii?Q?XqBmnojYPgmNmefgXAikNg4tI+cA6AKK3XJBF7X1dr6mp4bENkiCCvxwuaQ1?=
 =?us-ascii?Q?n78PyweQMBd+c7lhIEYYwVY5C0wv8EMMK80YM4PDTT9gr2yEqclqDnwWDmue?=
 =?us-ascii?Q?ve1Dl5x810igTRs6YNEugdg+PtFBgpsyHzUh5u+EI5ErbUU8w2vvJVsjt4y4?=
 =?us-ascii?Q?wi5cW6vyztOldu+ZQoWadjC8aLUDb07RR59W/c0T9zN84ELyskz8jeXvLqHf?=
 =?us-ascii?Q?3jO/FS4AD2aLqcVpeY9KfLqfWPOscFSWOhAzf50s5bE7zg8+++bIrI0BTAyh?=
 =?us-ascii?Q?XH07AMxYXXU3JPWk04TMK+LRcBZ0PtZh9DKl/ME778zbH8jx6Ulfn96NcYfS?=
 =?us-ascii?Q?2qX3swkDx76K3UG1Rz3r0PwVmqGrJ09yBLcMvbTUAkkrOkqOaUHqP+pBg/hb?=
 =?us-ascii?Q?xI4ZS5llVSsp2SqRR8bIWVTydlVMJv4YacKtQFfEFDCR0FtKA7IjAUDNre38?=
 =?us-ascii?Q?INtWRk3H9IX/P+271BHnGJjKRijxpWwcAUgLYco6OufaQ0gf3Q2pB64ZI4Bz?=
 =?us-ascii?Q?4ZzktK8w/0ALnOH1R+MRm+Jauw9ZQxIqvVLM7YgtppWpc4o5+zqdHethxF6E?=
 =?us-ascii?Q?r6XjVPrT66k9Qe28KFzt7i57OAovOp85rRdKU1Xgz8BvwF4bgtdRBAKpH8Fb?=
 =?us-ascii?Q?GqhJFTc0hifeZPUfsKfvCqlhgWnASig5C5V5Gt9nF2m6gkczs1NRy/Tj5Hni?=
 =?us-ascii?Q?XLTf2BDtYwOL+RvVG1tt/2/1a3S0i5E4e5368q3QosScoaDekqEVWF6nqX/t?=
 =?us-ascii?Q?2Jcctd6W7+rFMzTgRrLAxxTDwLPKxRlCnlicedgmyeIbrOjmEu2idN1vg/88?=
 =?us-ascii?Q?HnTh4q0So2BMFgrS3ChzoiFZmVgmeTYNrLM0BRJX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cba24c-4500-490f-3bae-08db04f18138
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:45:50.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpR3Deb/TdetdQUcfyaDbDtWix6GXkuRgw3nXZ0okc9i1DpO4oh5UFMIIEjzP9clfqdSrg0VzdD2T8ZoKHrfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Thanks for cleaning this up, will make any potential follow on I do
much easier. Feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Bernard Metzler <bmt@zurich.ibm.com> writes:

> To avoid racing with other user memory reservations, immediately
> account full amount of pages to be pinned.
>
> Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index b2b33dd3b4fa..f51ab2ccf151 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -398,7 +398,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  
>  	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
> -	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
> +	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
>  		rv = -ENOMEM;
>  		goto out_sem_up;
>  	}
> @@ -411,30 +411,27 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  		goto out_sem_up;
>  	}
>  	for (i = 0; num_pages; i++) {
> -		int got, nents = min_t(int, num_pages, PAGES_PER_CHUNK);
> -
> -		umem->page_chunk[i].plist =
> +		int nents = min_t(int, num_pages, PAGES_PER_CHUNK);
> +		struct page **plist =
>  			kcalloc(nents, sizeof(struct page *), GFP_KERNEL);
> -		if (!umem->page_chunk[i].plist) {
> +
> +		if (!plist) {
>  			rv = -ENOMEM;
>  			goto out_sem_up;
>  		}
> -		got = 0;
> +		umem->page_chunk[i].plist = plist;
>  		while (nents) {
> -			struct page **plist = &umem->page_chunk[i].plist[got];
> -
>  			rv = pin_user_pages(first_page_va, nents, foll_flags,
>  					    plist, NULL);
>  			if (rv < 0)
>  				goto out_sem_up;
>  
>  			umem->num_pages += rv;
> -			atomic64_add(rv, &mm_s->pinned_vm);
>  			first_page_va += rv * PAGE_SIZE;
> +			plist += rv;
>  			nents -= rv;
> -			got += rv;
> +			num_pages -= rv;
>  		}
> -		num_pages -= got;
>  	}
>  out_sem_up:
>  	mmap_read_unlock(mm_s);
> @@ -442,6 +439,10 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  	if (rv > 0)
>  		return umem;
>  
> +	/* Adjust accounting for pages not pinned */
> +	if (num_pages)
> +		atomic64_sub(num_pages, &mm_s->pinned_vm);
> +
>  	siw_umem_release(umem, false);
>  
>  	return ERR_PTR(rv);

