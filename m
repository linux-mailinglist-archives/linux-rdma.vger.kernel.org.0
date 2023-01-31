Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438D683A41
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 00:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjAaXNS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 18:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAaXNS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 18:13:18 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22109003
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 15:13:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3qGDIiijfhDkXUlS2igUa6JCFmipTP56GGZkgf3XZPATH/KCQOkFWrqJFr9rLqpuMBLyNhxx5UtVtYHQVHSOZE/xmDbRyUczwIdlcGFD19T9c/aZ0QaaO95xdWBMok9jUQGKzAtIxdPvj6iYqGeX8in+vArXvzcTIsuosnY/wWF23J7nrwHpPM+sY225VYSRV1zdgJTSP3HU9zJ74S4Fi7KnUF6mOjy/bRfB1QxGtVsUFv0a4mg5paFXafPD5CzcvDwphPUqt/HrJU3K2/3r98eWGJpU+Z8/PQd23jrl6bnXT+1OeOeezD10HyehYkeVsbftK/IrJuiOyn9mXgdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRuMJnh+zcoJSg1PahUgdtEbMXoMZXFqHzkhMQLCG/M=;
 b=CxT/XCBPNjclHVzGsVj/pHL4S0rXgAvEDxF17mBFppfoXJRPmDDqRVu/YSZkaXOpD9KRH9RfvsTO7J6EQZCk/UsnhdKt0JlZd9xeEOeoBwaDzMXM53xlUbCGa0g9PVSHhwWR/lDIT0yq7xKYTBF4Uajwru6FPe8ScGuoig4JOWmER1iiv7V1+rh2txLKqqaeH4Oy7fIvKGsCeTt6qVQXA4h0G1Pbcy0vxfTgwt3/lAyoFs3v1L9YJaHGY+LBDz2ONGsRE1cFQkTfoCQ0HQl1fv1jIAXq3nV6s4I6kag86YtdDd6Q8+lo1y7mM4x5HDBp1B2pnT7pUQvnl6vuXru/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRuMJnh+zcoJSg1PahUgdtEbMXoMZXFqHzkhMQLCG/M=;
 b=rf6+zrVv7i31sX6cEWKiAkvC3CX3HkZrzt2ujGJ6cAMfob08T4g78r4+Nkin24EQu6GWml0GzA+yU238Jev6ABz7fPgNaCibj3U6nUQoyfs6cBX327Tc6QYWXkUXKr0SgvZEAhoTaZY83+eYujJBIReR3yw9SCqLsoZT4R9H035e2K4xxRHzF2MlxhsBmMz1IKNHeV4E1ms6gYVVfKp+u+yI7bRtyvhIgJAfK61OyR2b4qZEOtc7f75p89ynqP+PTnw3LdF+ssxWNkCphtlzYgJVIa9S2dJfyR33q0yfFyVANtdgWi9N5fVSjogA06z/oXCpRKjwNHejEu3VIK7k3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 23:13:15 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6043.023; Tue, 31 Jan 2023
 23:13:15 +0000
References: <20230130133235.223440-1-bmt@zurich.ibm.com>
 <878rhjzhbg.fsf@nvidia.com>
 <SA0PR15MB3919E2F0F97368BF0069F4E499D09@SA0PR15MB3919.namprd15.prod.outlook.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Date:   Wed, 01 Feb 2023 10:10:33 +1100
In-reply-to: <SA0PR15MB3919E2F0F97368BF0069F4E499D09@SA0PR15MB3919.namprd15.prod.outlook.com>
Message-ID: <87mt5ymh6j.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0092.ausprd01.prod.outlook.com
 (2603:10c6:0:19::25) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: ae54cedc-2efd-4fb3-4ac8-08db03e0bb16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLtDiIiy3NJi/QcbqhSCy+KfjpdM6XfuT6FwXtH/OwfcvXRl20l4YKhfgM0x/tUyMLlMstbJp8a2luMscAD6Np7C4OpwpRqOoL3sE/g0cSE8YxkUEaFza2bhjLqfVzHvXBnLxO536qjUj3hnlQJb9REOOCTGnXG408ntnNeSyiXqa2OFY0xVEZwXlkJk96AFVYrYvMVM248QwILSuuT1HBozkYCeMYbuFcy0VJ0/XdTdj2h15mVtpOvHUYR1Lm0wbW4gelrKM8+lUjWviqjlkkA5RyGF1JY4pRKr74HHtWoRJbVP5PMqRE4uxYvqr/Rv/PEFPsY3P1FOr+1pvknzUabofJMG4/o3J6ySU4C7Z1YjWkdqJKqFtIyFA/7TK7cb9gZ8bKZG49uzWYaKp4bUcIPV8F466pRMnsXsyC0nBybptKTgx08Gl8E0vHFhn/dcnstK2jgiIfncioF58ILb3Ry0ZWRoyLl32OJh5w7iF82gzG2EPkpqjiknYIcKL10oqPbTGQA8UJU55mXwyQKt3bE56NDtSyHRM1tz197f3JSlM8sCcY1Cimj4hRwNiDCQ9VDInoZOmhpbV/H2CZESHgR7BVrPMMTWl208KRXgAya4OceqMPCF73BVL1draztv9/cgvoa+mQdPuKY/QM8neg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199018)(8936002)(54906003)(41300700001)(86362001)(83380400001)(2616005)(6486002)(4326008)(66476007)(6916009)(38100700002)(66946007)(316002)(66556008)(8676002)(6666004)(186003)(5660300002)(53546011)(26005)(36756003)(6512007)(478600001)(6506007)(107886003)(15650500001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G45PXIZc2NFLl+aP8SXGUg2G8sjA92jk3Dg1Jmz+T6a+URySFneVxn8is0mT?=
 =?us-ascii?Q?NXfWpMYa7JzgMJdx/0tPVi3M7mVM5PsPBMmBvBKdgWioi8oJsDj8mHHjpdb7?=
 =?us-ascii?Q?sgyWtv1osLtxAuhgdxENbMokmjXsM1FzwjenCDDZTrWVQxCvaxtZBGOehKor?=
 =?us-ascii?Q?4KPa0CtLZQeTLwvJAjtm9xLbPUIAjiqAGACZ8HaI9m71YmSkQVieMPzKxHfU?=
 =?us-ascii?Q?+IN6RF9THiKqXpHQl1Zix6jXMj0Sz98owRUGHNZMHsOtfbHf84ai3pjKlFdr?=
 =?us-ascii?Q?Bk7BWvr8M8HWiaSyenKXZznSUdj7ugBuG7jmfX7Egdf9Wq3zmV06YBa6r3d8?=
 =?us-ascii?Q?MRcHwtIRLR1O+VAQSq0McMEkmO0JKSUEmaHR95fcPIHgrS3OEWYQTft3DrvN?=
 =?us-ascii?Q?SJ+IYERtR/SoKeiDkWPKsd3f5Hz6XcaDTAcuHQWLEHdzmI9VxBMsOK34Oq4l?=
 =?us-ascii?Q?9x+lOX7sbgR93mGmm0Tkemsd8BJWGz41Onsx9bROMs+pye8I4SbZVNSVyjsB?=
 =?us-ascii?Q?BwtJhoVl3D9PwZARg2u56wbd8o6Ia4nqmF9nTYfSwWu8hybWu7NE0GZNeSDY?=
 =?us-ascii?Q?h9iBpqhbmLNcwRM1bB2h+FSTTQ9oaPOOAyThiwOHeWHlI2+aY6hW1zBUQmOk?=
 =?us-ascii?Q?+dHwriUbMGhCPQ/h84TKAowItvTso3berXafpeIwlG2znk/8GKgDxaABZotM?=
 =?us-ascii?Q?9A39iI+lRp92QaQrJLQHCqkTLZ7ED2ZdLv0nsaytIOpW52CI3AM2d4FWW8Uk?=
 =?us-ascii?Q?LjH3ROJiB6+z8Yy1XXVEV/FA9hGeHCWMT4mTkg22o6Oo67UpcV51JeAfvzYP?=
 =?us-ascii?Q?dZa4aB3Asy8/oUQir0pltsqhPqs3IdrlfvuEwV3CYPdIf5mzsD8yfhrpYA2c?=
 =?us-ascii?Q?HqwGBxeqmfr08ZmjQP/IPueqIpb1UBLkZTOwxqMRiqXYfNahH8FQe/inUiu7?=
 =?us-ascii?Q?ETKvwBquHUp4l+sCFENIWwgUzTXthfEDe0EfqRiRNWGDFf+qc5nMvgl016Z9?=
 =?us-ascii?Q?NtiVG1nS2wDsCojl2OUvNy9oU9DBRcMFjuOYfWjgvar7JYLvaYh+ddWfHJrS?=
 =?us-ascii?Q?alrb7otz8LUNwZC5vQe1/6jjN6d2YeH62N+mK55c1MXAz9DkYaOflnIhNFE+?=
 =?us-ascii?Q?I1xCX5cktM7cHSgS65swelNNwhaSaXmZzJ6UnQds8MlBNqm/ooGqKo2ZsQtP?=
 =?us-ascii?Q?2K+Ae7fzg0J46mHU8g9cJ+4av1vYRCyeMRh3TRiZCJ8KLSrHx1vC3E1Oz0BW?=
 =?us-ascii?Q?DcbZuA4iAmFWlpuGkOVT0UafagSpXZs55lNQ5UaH1AJSKKmO+CWcVXLCeLqS?=
 =?us-ascii?Q?bFHQ1HskxvXdOpSJdgQi+GvdvWRZhZEaoLG61YarJTwKEKyQKu1+w4gekFBT?=
 =?us-ascii?Q?gTKK7nxpjSou4ntBQOwrl6r7EytmnqFyconyIoZ/ZfUBc38S6MkCVWAyJLMh?=
 =?us-ascii?Q?/BFiE7bPb3Ay207VdASC9h4MxOXX+wl55KZ7Huyi7ss9zMY/EE0B7ieV/voL?=
 =?us-ascii?Q?Sc3O1nsrukybCkAp3fsEe6pufvPI+XmBTYGiv21juGkDJHMtNpegX/bv/WBx?=
 =?us-ascii?Q?gpI2EuQU1MT6sjffQ0gKLX5OiKpC0rbyJuvaa+se?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54cedc-2efd-4fb3-4ac8-08db03e0bb16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 23:13:15.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmAQNbqA9nhOWG+Z+3f+agXkwQTeUC6w2fwIigwn7SwPfUMzPeY8z+K5sBeRQocufoQoA4gnq3eHn/aVRJFJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Bernard Metzler <BMT@zurich.ibm.com> writes:

>> -----Original Message-----
>> From: Alistair Popple <apopple@nvidia.com>
>> Sent: Tuesday, 31 January 2023 01:09
>> To: Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: linux-rdma@vger.kernel.org; jgg@nvidia.com; leonro@nvidia.com
>> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix user page pinning accounting
>> 
>> 
>> Bernard Metzler <bmt@zurich.ibm.com> writes:
>> 
>> > To avoid racing with other user memory reservations, immediately
>> > account full amount of pages to be pinned.
>> >
>> > Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
>> > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> > Suggested-by: Alistair Popple <apopple@nvidia.com>
>> > Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> > ---
>> >  drivers/infiniband/sw/siw/siw_mem.c | 7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/infiniband/sw/siw/siw_mem.c
>> b/drivers/infiniband/sw/siw/siw_mem.c
>> > index b2b33dd3b4fa..7afdbe3f2266 100644
>> > --- a/drivers/infiniband/sw/siw/siw_mem.c
>> > +++ b/drivers/infiniband/sw/siw/siw_mem.c
>> > @@ -398,7 +398,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len,
>> bool writable)
>> >
>> >  	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> >
>> > -	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
>> > +	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
>> >  		rv = -ENOMEM;
>> >  		goto out_sem_up;
>> >  	}
>> > @@ -429,7 +429,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len,
>> bool writable)
>> >  				goto out_sem_up;
>> >
>> >  			umem->num_pages += rv;
>> > -			atomic64_add(rv, &mm_s->pinned_vm);
>> >  			first_page_va += rv * PAGE_SIZE;
>> >  			nents -= rv;
>> >  			got += rv;
>> > @@ -442,6 +441,10 @@ struct siw_umem *siw_umem_get(u64 start, u64 len,
>> bool writable)
>> >  	if (rv > 0)
>> >  		return umem;
>> >
>> > +	/* Adjust accounting for pages not pinned */
>> > +	if (num_pages)
>> > +		atomic64_sub(num_pages, &mm_s->pinned_vm);
>> > +
>> >  	siw_umem_release(umem, false);
>> 
>> Won't this unaccount some pages twice if we bail out of this loop early:
>
>
> Oh yes it would. Many thanks for looking close!
>
>
>> 
>> 		while (nents) {
>> 			struct page **plist = &umem->page_chunk[i].plist[got];
>> 
>> 			rv = pin_user_pages(first_page_va, nents,
>> 					    foll_flags | FOLL_LONGTERM,
>> 					    plist, NULL);
>> 			if (rv < 0)
>> 				goto out_sem_up;
>> 
>> 			umem->num_pages += rv;
>> 			first_page_va += rv * PAGE_SIZE;
>> 			nents -= rv;
>> 			got += rv;
>> 		}
>> 		num_pages -= got;
>> 
>> Because siw_umem_release() will subtract umem->num_pages but num_pages
>> won't always have been updated? Looks like you could just update
>> num_pages in the inner loop and eliminate the `got` variable right?
>
> Indeed, but we have to advance the page list pointer correctly,
> which was done by this variable before. Does that look better?

Oh indeed I missed that. Yes the below looks better to me.

> Many thanks!
> Bernard.
>
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index b2b33dd3b4fa..055fec05bebc 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -398,7 +398,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  
>         mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
> -       if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
> +       if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
>                 rv = -ENOMEM;
>                 goto out_sem_up;
>         }
> @@ -411,7 +411,8 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>                 goto out_sem_up;
>         }
>         for (i = 0; num_pages; i++) {
> -               int got, nents = min_t(int, num_pages, PAGES_PER_CHUNK);
> +               struct page **plist;
> +               int nents = min_t(int, num_pages, PAGES_PER_CHUNK);
>  
>                 umem->page_chunk[i].plist =
>                         kcalloc(nents, sizeof(struct page *), GFP_KERNEL);
> @@ -419,22 +420,19 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>                         rv = -ENOMEM;
>                         goto out_sem_up;
>                 }
> -               got = 0;
> +               plist = &umem->page_chunk[i].plist[0];
>                 while (nents) {
> -                       struct page **plist = &umem->page_chunk[i].plist[got];
> -
>                         rv = pin_user_pages(first_page_va, nents, foll_flags,
>                                             plist, NULL);
>                         if (rv < 0)
>                                 goto out_sem_up;
>  
>                         umem->num_pages += rv;
> -                       atomic64_add(rv, &mm_s->pinned_vm);
>                         first_page_va += rv * PAGE_SIZE;
> +                       plist += rv;
>                         nents -= rv;
> -                       got += rv;
> +                       num_pages -= rv;
>                 }
> -               num_pages -= got;
>         }
>  out_sem_up:
>         mmap_read_unlock(mm_s);
> @@ -442,6 +440,10 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>         if (rv > 0)
>                 return umem;
>  
> +       /* Adjust accounting for pages not pinned */
> +       if (num_pages)
> +               atomic64_sub(num_pages, &mm_s->pinned_vm);
> +
>         siw_umem_release(umem, false);
>  
>         return ERR_PTR(rv);

