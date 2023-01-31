Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61545682088
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 01:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjAaATy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 19:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjAaATn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 19:19:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D427993
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 16:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkX9yt85KZ5pETjDYrJyxPvOsiRP8qkEdYllyUK04fEUyNoecyP3EP2e+IXEDaU29ElTux3Sm68wmBL3TrR5qzPIpAfqrNI9Ik9L0C71zrtGFl8cNZrKkPcSTYB7ChpyPvRIQ3Z0tGJ9XyjCQ2YHdLSrvI2dgjTu4OLukTtEbNOUE5JU4k7Q1DUXcYnooOA99BMdJCHGTm/ZH5d0TkDOTS+pOzYgYuQEQx4+CbcC25qjmMgJEWMflAPsNAFVnwXzprtcak/h9SACuqI6bNwz52ZOWs/mlQZP1+ZNhy+PkAfzWt+REZJBGM+JI/ICdngpvc7lWbC1ZqRVAZdZWqp1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MilF/38CzZjCo60WKyIXHARNkAxWg1IKizoc5hxeRpE=;
 b=khYaBavJfqJBlZPwdiySciGBMl5AgOSyP9j43JBZ9sSdgzbfbvRIcC4781Lu097ulHrY0/4dKzlMZhlT8vxY2LrvFh7VFemjjHZ8v5suj2qxlYdIwzt0rVcfp4/DcLxc2sSaEe8dtqJBP4v2yQAiia7YGX90NI8e0xnV1KoA6pTi15GHW6n7d9TeWIOtxnp9VjgA5WsljuGjjBsAm3fW3Mr8VoUusJkFMWu9j/1VXAAZJqt+HtGQX3xt9QnHJfmPMD5thJxy+kXjyKHaD0e2+0C9pGgBgNBhYkQlrauW1bRwq5aryUG/7T+mqI0d4dsQaztK/ejY5P2effkZTgYFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MilF/38CzZjCo60WKyIXHARNkAxWg1IKizoc5hxeRpE=;
 b=XILR4xvARBFaqczrhnp+zNQPogPCydA7CibFjZpTJZqIV42uLfYgYzUWXDtmgAbp5NliLhepYTAzRMkwQKSGegCUJWEurASobFfRJ3IGEiWL6bul0Dp4T+C4qGUcYEz9/iYaRrYQOgaPewa9aOCc/+6rxiC+346d6K0w2T1GuO9YroH+NJeYy0SaNkqyy+871LskMlfrMIqaYbefjhf3q9sJOQhFo5Or51lKUiC8p+/QXK78ZnOJXsAIHqtdOyAi0vbUckG/zb6SoTkxXhkiCBcOqA2UWxB1HLdOwBgYf9oIB+jHfTxjh56AdMQeJc5pHkgJudfG1loew2NCHywUSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 00:19:37 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Tue, 31 Jan 2023
 00:19:37 +0000
References: <20230130133235.223440-1-bmt@zurich.ibm.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, leonro@nvidia.com
Subject: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Date:   Tue, 31 Jan 2023 11:09:27 +1100
In-reply-to: <20230130133235.223440-1-bmt@zurich.ibm.com>
Message-ID: <878rhjzhbg.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0107.ausprd01.prod.outlook.com
 (2603:10c6:10:1::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c7ed0f-9b0a-4c85-0168-08db0320d680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/XClFlzStvaxeJKGar+ISpKqdIAUm4avSCcLMkxHlp7bkqjp8/UoeWulJTl+JUVDnGOj2YR4t+UHVYkEDimXNcXHc1RBgLPCkBgGc92oK3dmAsaLOIOdDWiHPiPF4KefMpownj0PjXolJfZIrcEf+u/GyZlJ4yIBDYYYU46gb/++DDjlBeYOvcSQxDz3mmIO6b6VVRz5UK/yE0c8QAyQe2RfFZCE29/minkPxGTMG47PuZGo4VMuEdO/oO8mC/pWZxD1038OXstN8fFxzys6Rpf4Z5LEnyJe0Imnu41pMcoQlJT0QawosP4ZoRXZLEHLXIRFKmELAZgxWraYtOMG/bfbE1FCThs6pA90Kywk+BaClfcGjqckECmkBCdnM8mBvIZx3X+a1M/KDR629fzZ5esA4ZMnUjjBO9gRlyrfgoE21ty6MRhOmNhyt2zEzzNRfDOiQGa19Cl4oPBtvWMYyu8+SViXKr/uLydIuxcVCDnQsoGOWo+Mh+TWtoq0OTFOwWDwuD9wrCtYrvku2NWfg/StrOOlL7ogiIfvkw0STB1txzKDS+q/chtbX/rsRHb4VFLWYMgMG9rB7FsJb1TgJ/N+1uSajwQp/TxFDQnAin0tJDwH10TgkPojD0v//PB220ERlazSHTu/JSF+QuVpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199018)(8936002)(41300700001)(66556008)(83380400001)(5660300002)(38100700002)(66476007)(6916009)(4326008)(86362001)(36756003)(6486002)(316002)(478600001)(8676002)(66946007)(2616005)(186003)(26005)(107886003)(6512007)(6666004)(6506007)(15650500001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sl0yvSYmGuK1fcCP6khv3SHH8rj+OWERIIamxDddFI0nTU2Kul/NrbsyQjGI?=
 =?us-ascii?Q?MOgnAxc1wIfg4ctRPhw8DSGHMZcRK87fuqZrLUBdQYp+pRSoD8Rykt0pHYXO?=
 =?us-ascii?Q?4gqluVjwcnRumbzSIA7okP4VkZPs16Av2r9WSEUlUHoG7FBEUgJsOegnQ8EF?=
 =?us-ascii?Q?E9CnHRLdFFBk/MjbspTAF0E7TlYhGheWuTIkqMM+bgqWJBWZyKvEdyOwUHNV?=
 =?us-ascii?Q?w+sz8W7Oa7+XV2B2VYa2l4grdE7tbcJr7xrERBlUVc1myU7M09mNIP4Znu7e?=
 =?us-ascii?Q?kvHo8Q4X5bW95N+VOE00ZbmCcjqNRpH1UC5c7j/XPi6g+H2s67L765OXp9HI?=
 =?us-ascii?Q?d8kgbZivuZgH8TDOGyFyzS0BFcxBLrE9HjtZAH3NSDDSCsJ658lgq4zsIAMh?=
 =?us-ascii?Q?LTOChe+L6WqKjz5YCz8iXKddfZcyFUa+8xsV7tZRCBYWj67DZ/2Avla8LF18?=
 =?us-ascii?Q?l7wOT0lvFdQNwB7DXgZQlGyQsVKwHmb6qtYzkyfuISO8+uPUiIOLvmmQIVNS?=
 =?us-ascii?Q?z8mdJvK9FCSGhPZQjwtaC69VpshjbpqzQLUBpN74WhNyEfLNvQYsKsSyrybu?=
 =?us-ascii?Q?5NU8vZDBNbuPhDCkA+VhW+lS5I4jTtyvvFgnW24X2ngrNHxNdl8zmukdCFfE?=
 =?us-ascii?Q?aHE8912Vh7bD19Gc3GI+GswYRLB6mcjFvWtNXRQFVKnjjj2KnYrnJQb7jp5R?=
 =?us-ascii?Q?LuOg/bYPnxbU71isbrNF8VIYFkBXf0iop8yw2HQ12rOEZ6BnB7BC97NHoBhH?=
 =?us-ascii?Q?0cTBdjPueE07vdjRqtHPVA0TWv574qzKiYwUXlZGAKfL1q80Dh4tp3UcihXs?=
 =?us-ascii?Q?PZvqVvOdA8TpAVUe6Fs3ireRhG52umtA0FdBwL5Nu8jYiOuoEXrWf6ev3gNX?=
 =?us-ascii?Q?etiJ59SxB6Ry3to6qVpdVY+VqWgWxlH5PZgV+KBNNIUCI+a1VWdyLJQve139?=
 =?us-ascii?Q?5cDVkeyfuHr+CgB6R3ggRn3Bsd4FYE5uay6YcEAA9wivH9GdCFpLAk5BzZkR?=
 =?us-ascii?Q?9oDJb3iX1cE7j28bF6N+3Y32o4QK5HJ4SRBFQBQ+Dlf3PZBHwEM/FZ5sK33V?=
 =?us-ascii?Q?e067nUbheXh9vvF4jSzW/7pMhzLvhnggloj9UGYyXd0Z5gJpHKLGH2CKJzm4?=
 =?us-ascii?Q?63rFdU8oIAJ6OE6hVzpMbOf1pQwVBb3AQzUpFXWbvoFFaivIxnTWWIWz9AMH?=
 =?us-ascii?Q?wev1KeGvehBVk/2uec6MDafzfVfjLXWI4qStOtgauvePtuqUGtrYcKgy4NHc?=
 =?us-ascii?Q?06dG49t2YzwRxpk0nmIXTESDADtoljnNeE3aYsQOYVgAtCLf+cVwoiGKrBaz?=
 =?us-ascii?Q?Fg3sOYIIMbxtTNhy9dvNjwaBDAfsZBk7yMeMxRLLC6pTxsf7AihTCtYTUZ7Q?=
 =?us-ascii?Q?EYclNYE2jgII8L87aTSi5OgWQtI+8Zjge6El1jkEi23DK2gbWi0nfygSVI4c?=
 =?us-ascii?Q?rV1qpQSbXSvdBy9fYEDpBpSHYqgmrc+WyvVs40CEHs2J7gdefZFi7feqrYeu?=
 =?us-ascii?Q?q9/tLKbEHbNRKdkanqv5IBudoo1J61595+VA60DYEzv5sr9qW2Vy89KOojlw?=
 =?us-ascii?Q?PWv5FjHSkRyt6v5lKhVoILmaMY5JQdI0lc/ARPbH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c7ed0f-9b0a-4c85-0168-08db0320d680
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 00:19:37.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpqQ2y/2/dnJ36tJ7E3/K5RkMUIToWQkuJj9nmgW2YGcg/cy+2+j9iVUffMaRvrxiHVaaI6FVtrdyDS/eaUrVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Bernard Metzler <bmt@zurich.ibm.com> writes:

> To avoid racing with other user memory reservations, immediately
> account full amount of pages to be pinned.
>
> Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index b2b33dd3b4fa..7afdbe3f2266 100644
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
> @@ -429,7 +429,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  				goto out_sem_up;
>  
>  			umem->num_pages += rv;
> -			atomic64_add(rv, &mm_s->pinned_vm);
>  			first_page_va += rv * PAGE_SIZE;
>  			nents -= rv;
>  			got += rv;
> @@ -442,6 +441,10 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  	if (rv > 0)
>  		return umem;
>  
> +	/* Adjust accounting for pages not pinned */
> +	if (num_pages)
> +		atomic64_sub(num_pages, &mm_s->pinned_vm);
> +
>  	siw_umem_release(umem, false);

Won't this unaccount some pages twice if we bail out of this loop early:

		while (nents) {
			struct page **plist = &umem->page_chunk[i].plist[got];

			rv = pin_user_pages(first_page_va, nents,
					    foll_flags | FOLL_LONGTERM,
					    plist, NULL);
			if (rv < 0)
				goto out_sem_up;

			umem->num_pages += rv;
			first_page_va += rv * PAGE_SIZE;
			nents -= rv;
			got += rv;
		}
		num_pages -= got;

Because siw_umem_release() will subtract umem->num_pages but num_pages
won't always have been updated? Looks like you could just update
num_pages in the inner loop and eliminate the `got` variable right?

>  	return ERR_PTR(rv);

