Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5872CB4E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjFLQSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjFLQSm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 12:18:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3DC10C9;
        Mon, 12 Jun 2023 09:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQNOeCMKGaHYJ5OYcS1TWj3gPW0FaxsOA5twxbybJ/MVS3nbEIn7JycNvCS1AjPYva+4ZUwvd9+X/zm++lH/byIqY3uvz3fj9qrVqPMxJQvpg4v6qHsd9coNccH9UuustMWZqvptciuIs3qUrZaeCBGbZzgM0eurCzRvFVSoR3BzRPVtlvs48ioTn2v7FiBATm8srngZX+Wii5u18jpicTABl1Sb/K6/Uv9LZGmhZ18FMkCxrlnMZHdVCMOtCfkTZACgzzVK0tjqKY+fDyByaoTE8dakMHutGC/D1ehcEmdTjeQiDgWe7hEYOG6831GkshEE4pbiYA3MqULOZPLoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsLuEZ4vAGk+MYN7wZ9Vfd6zEkpMnoDxrwHJ9deHBG4=;
 b=UK+abb/x8e+hdnIXsl8fQc9ngQINGnmEhdJmPAVqy8kDaq4CUnp9gVfJ9Har11PdaE3clPe3DEocI6mWtAGOsloKOaIAbPD871vP0JVggFSaVySTsAS98/Qoc0GQHHYy/gRO8w1gFBZ2ABbBBp858GOxGBUdEEmfmFsVd1NncQk/qJd7Ri+mogopAG723Zm2tHCt4EXsBZ1BbJRyZOqsrYl29s/XMxx+xZpYBHtozu8iNFXm6sUrTRylqksPa8u0YedHSfwETiBz4IIDgL3zWnJ75YBOTvyzD00XdHOuq6y/P1jRoI0QKK8d0181d1hl4lGefA3Pt7dT+UIFYEZo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsLuEZ4vAGk+MYN7wZ9Vfd6zEkpMnoDxrwHJ9deHBG4=;
 b=mJuyJZqR87hbUGcDdcIWHbZzaWSTPEI9m5sLPfClPSfjk6b1U0OQSZPyfN3PcBfSd2fAbx1mHzd0HB25EYrfBPTIMrlsmqi3qU5bXGWpSgv7ct3Yq74mrM3nQtFfgoOXTyg/2eiJkBVE62a6Ij4GCRn5Z0pgW4upbooe/XbF4q/qIwaPQVdv4WOMhBNSMeMX40sL1KT7kultuelpkFc5wjCWlrDujZEReFbwxtzzEe5oP3a7+wBOyg9BkBs5hT/I7e+wS3eEPCLE1esA/54dpHB3Vca93JyvYVtAhifco4sjwBAgoHjIF9Aga5N38kGsJQIMoUSjVtfWEQsM6t6PpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 16:18:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 16:18:38 +0000
Date:   Mon, 12 Jun 2023 13:18:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH for-next v5 5/7] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Message-ID: <ZIdFXfDu4IMKE+BQ@nvidia.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <7d8595c23e954e0fdc19b14e95da13ceef2adafd.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8595c23e954e0fdc19b14e95da13ceef2adafd.1684397037.git.matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: MN2PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:208:23d::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c0bfd0-2f6d-456c-0327-08db6b60adf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tW2MHtMy6sANEuJmgJUzXM9wkh7u6n/3esw8umgH/kaidyDY91XrPx2xAyNkJEul5GavOwCswA44rbJZefVE0L5Px+rrFSGSKuN7PCBPF7HHcsqw/5EhQkx5stFsG3N5V6Hx6S5EMLDlkJxGkWdJEIfdrKFakA0HI8OhT8KJqWBqFBNkj56VgY0MWAjX2G1u4XBgO+G1KasLexUz4EQlVJd6v6qRlIR8lorWl88lTEoiGMndfhcIXgvExc942/Md983+yxCIlGbK+Ej+deWULcTHH51kBfXnP7eS1RUP0ZdfV8hPLN29Rw69kHdFEMuQS+qNyrp8vBMMkEFluFat1nDj+bqkjCfkBKdRjA5eAQf1FKCDrx0Ikc8Milpb6hip/UxJKsOyK6Jz3bwn6bgWnv0AgsEmtBj44DhBEi3TQc6pHam2kKoyECOLAzm5MTfh43yXVEokqIilAyPDdfxbfLfWhkmdSZCKdi3ZSuPb8liqyo3mPeRMS9ni1KeOzid+QKDvSg2e8OJxClIpvCSdyNrrjOrnsXqPge0Cc0qDntKWb7cLK+XYV6xJR8ZsrCOsYNuHGkFcBANTTNBJMOuppdJyrIrlz96e5vDUHdckwVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(83380400001)(4326008)(36756003)(316002)(66476007)(66556008)(38100700002)(41300700001)(6506007)(26005)(6512007)(6916009)(66946007)(2906002)(86362001)(6486002)(5660300002)(8936002)(8676002)(478600001)(2616005)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SmaCSyZHCRcBs3/qHTphuPqqhMoAcvu/buHGrUePtLWnjqkD5IQN/2+MGRBu?=
 =?us-ascii?Q?L3AqJFcLZ1zHAXV5HzfZI9rM+n/MTBZRzaEAIuDx2aYNuOvCvRLiPdp6xujY?=
 =?us-ascii?Q?tD9olauNHrMmn+rtlAYwXf93K5JENF1diqjl4+cy+5i8kMXL3IX/eiS8i+cF?=
 =?us-ascii?Q?sWFYjfhj8A8wBdJSscZyc68azqaGCEHTH+g91E5tblv3XHj4t/csemA6Y1bk?=
 =?us-ascii?Q?9pcDiO5sVFDgZoARQHv5z+7vAqV/L0GP5TC+VM3zWgJNC6uRB7yHMgBR+9Zx?=
 =?us-ascii?Q?qLC4KZ2swhrFxQ4r0JpWyhOzekeRDc7kaYIKCAg5JFHaJWMwCSMXDJsYf80r?=
 =?us-ascii?Q?iZRONdclAajXUnjdbkKQnW1VkMZIob/rQg4W3L73a7+LkfQvwWQwX9Z6ZyoP?=
 =?us-ascii?Q?OtgmSDc8UVYhGJdyY3yGGdSRUZW/LdhPzgAfxzGk1S/8mv1V8ngWi545LYBB?=
 =?us-ascii?Q?mHp6asH49RtUc2Jc5bILVeX5pW+Y8eFhodIywk0ej7kvrFL4EkHnuT3GcY0E?=
 =?us-ascii?Q?qxAfBhvljFymvWQ8kt8CxUGZDZYnY+CNd/Y3HNfV/H16hc3umh8lRt+0gkp5?=
 =?us-ascii?Q?9V461ZkXOz4cxgqNBr7/9zN34W3XhDuVWDbqWjcp3x3pw7XMlH7zMbkrBdq+?=
 =?us-ascii?Q?B89phrTr7FkLCAJ3Io8nwtQ41ZEkBzIj0tK+n/gkDjXFodq9msv/H7y78jVj?=
 =?us-ascii?Q?ZjVM+MEa0pJblToYJzrVIdE+3DJHYjxFN1WNSszeCwzj4voelv7NhnrkIrT9?=
 =?us-ascii?Q?uUqHTf4/GcpX7j3B3KBZxVFLutmi7ReSUA0ZINKFDu9ezCS3QWU/uaSkeVII?=
 =?us-ascii?Q?eQU3V6Q1uZMq1MCcl9rMn+QyRidiluBvCMkrt+ikU5b+0zY4zsU3OUzQkOu8?=
 =?us-ascii?Q?5OcdzMbKc1Ff8wthM4e7K+OShMpdc9BysGyZM2qIPIIxXAVgFq5IthkBTAXt?=
 =?us-ascii?Q?N3JnKqYQbfod0w7KT7vMNDVvNmvz2S0A1TrvEvbCcmxBpQWE0J5LYaSYLg5I?=
 =?us-ascii?Q?EI41Si3TuKLTQWDLd4ib9S/pkJK9W0lyCBClI0SjmuB/6KodEZ+3KGKPnTI/?=
 =?us-ascii?Q?x9xZPUFH01WNhDA2O7LVO4gyw7lM3zuv58K5rhCrN86Icgl1HNy6QfkPmZHz?=
 =?us-ascii?Q?okwIRzC27oUPzGisUMwOhsT49wRFCcY0Ggf+9zvR7NXQfdsjdZQjMtEEBU1m?=
 =?us-ascii?Q?QYiKE0WNrIygc9C5CwDSbhKOgsT00kClFoTQTXeefW2b9CKNH52+BcJaLaPG?=
 =?us-ascii?Q?EaeLQiXujfCzTb1R0OT3sr7i10Bh+iJGzclWXZl8BQcKwBiHEbgGu4uKEbts?=
 =?us-ascii?Q?mNUkfNBFi2xyVncp274NYBUlv6vOagO8Nis/TFl9SAoXX8Udio54Skme9/us?=
 =?us-ascii?Q?hauyem/G2hYDth3xviA0DU0ZhG8Eev99W+KXHhFUPKXSSqunxU0Fvxcq4WiZ?=
 =?us-ascii?Q?O3ss8TsrYUmoM6dT0J6P5KkCXmPcd6aRgSo32RRI+ZXSiItFqyLf5SVCgX+L?=
 =?us-ascii?Q?e2lF9ArYwMfDXLOcufAXwQlIVpvFBSkDpxVhm6Bni5inkCLwJ3Qb4cm7CFWM?=
 =?us-ascii?Q?0f17zxGkYnj6pFvDv/xMtdp3foRfaTOd8+qDPXps?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c0bfd0-2f6d-456c-0327-08db6b60adf4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:18:38.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qg7AJp66jSQ5JgUmseWLe4F9jewJk3qyDTyp0dlbiYWRkxlIKfPcP4QmHhKD9Oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 18, 2023 at 05:21:50PM +0900, Daisuke Matsuda wrote:

> +static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
> +			      unsigned long end, unsigned long *pfn_list)
> +{
> +	unsigned long lower, upper, idx;
> +	struct page *page;
> +
> +	lower = rxe_mr_iova_to_index(mr, start);
> +	upper = rxe_mr_iova_to_index(mr, end);
> +
> +	/* make pages visible in xarray. no sleep while taking the lock */
> +	spin_lock(&mr->page_list.xa_lock);
> +	for (idx = lower; idx <= upper; idx++) {
> +		page = hmm_pfn_to_page(pfn_list[idx]);
> +		__xa_store(&mr->page_list, idx, page, GFP_ATOMIC);

All of these loops can be performance improved a lot by using xas
loops

>  				    unsigned long cur_seq)
> @@ -54,3 +72,105 @@ static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
>  const struct mmu_interval_notifier_ops rxe_mn_ops = {
>  	.invalidate = rxe_ib_invalidate_range,
>  };
> +
> +#define RXE_PAGEFAULT_RDONLY BIT(1)
> +#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
> +static int rxe_odp_do_pagefault(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
> +{
> +	int np;
> +	u64 access_mask;
> +	bool fault = !(flags & RXE_PAGEFAULT_SNAPSHOT);
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +	access_mask = ODP_READ_ALLOWED_BIT;
> +	if (umem_odp->umem.writable && !(flags & RXE_PAGEFAULT_RDONLY))
> +		access_mask |= ODP_WRITE_ALLOWED_BIT;
> +
> +	/*
> +	 * ib_umem_odp_map_dma_and_lock() locks umem_mutex on success.
> +	 * Callers must release the lock later to let invalidation handler
> +	 * do its work again.
> +	 */
> +	np = ib_umem_odp_map_dma_and_lock(umem_odp, user_va, bcnt,
> +					  access_mask, fault);
> +	if (np < 0)
> +		return np;
> +
> +	/* umem_mutex is still locked here, so we can use hmm_pfn_to_page()
> +	 * safely to fetch pages in the range.

All the comments should be in the style like the first one, not the
second

> +	 */
> +	rxe_mr_set_xarray(mr, user_va, user_va + bcnt, umem_odp->pfn_list);
> +
> +	return np;
> +}
> +
> +static int rxe_odp_init_pages(struct rxe_mr *mr)
> +{
> +	int ret;
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +	ret = rxe_odp_do_pagefault(mr, mr->umem->address, mr->umem->length,
> +				   RXE_PAGEFAULT_SNAPSHOT);

Probably suffix this with "and_lock"

> +	mr->odp_enabled = true;
> +	mr->umem = &umem_odp->umem;
> +	mr->access = access_flags;
> +	mr->ibmr.length = length;
> +	mr->ibmr.iova = iova;
> +	mr->page_offset = ib_umem_offset(&umem_odp->umem);
> +
> +	err = rxe_odp_init_pages(mr);
> +	if (err) {
> +		ib_umem_odp_release(umem_odp);
> +		return err;
> +	}
> +
> +	err = rxe_mr_fill_pages_from_sgt(mr, &umem_odp->umem.sgt_append.sgt);

Uh? What is this? The sgt is not used in the ODP mode?

> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index b6fbd9b3d086..de5a982c7c7e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -333,6 +333,8 @@ struct rxe_mr {
>  	u32			nbuf;
>  
>  	struct xarray		page_list;
> +
> +	bool			odp_enabled;

You can tell from the umem, don't need a flag

Jason
