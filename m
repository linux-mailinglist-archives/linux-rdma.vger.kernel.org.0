Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1254166CEE6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 19:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjAPSfk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 13:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjAPSfO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 13:35:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9353A5BC;
        Mon, 16 Jan 2023 10:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYJfLuvQAyBRoAOMkUcQb2oeL+jRRsdKQs9TDf37DD7G0yOOp6VKoKK20CDjZi6WGmfgmWtNPlexlc7P5nSLQCMfWAiBwxY+QHCicnZnvlGNSrZkOQWevq+Y3omPfamGIbSmfFmSoOieHvNey0r/gm3jFrN2cFMd12wNXdwibSPagBi9ZwCN2RPBVoyyzHOE3kpwIDv7xScvbhE3e0AYdblijjiR2Ed4e1WdJu8AOcTIT413esVdmyQcM2y2h62j7GQs4sydrMvnvBQoEIEhr9C4lqRwvbHbfG38G3f0zCadSC8Zj1gICHRjh7se2Xn2h2oYCidMTdu6HFFT7g7jSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqTLvRw2k6Y4Em0EPfn5DtOGAduYqmBA2PLDYMoQAzQ=;
 b=lRcJCW4Zyw88NDXm7w0EaT0REGm8EZrIXgK+Id4yP3hgFssmCngmC2MwOIYHHKgsv03LPREueNc8bG9IV7/K7uO7Twsj6SpN0mvgDZacnjAJPDSCu1yVnUAYm4By1BVI6uCZO1qbeH2/aeoQxxbFzTky5YqjVDlISAVNbbo6H4DMJm/HTCwnIoYtsgiT4mdNH2vVydOsKST60hSl7kerKPb3DZu/Dl4+dSRelB8wSCrWiFigP78CJMZ3iffSTb9wR43Q3EOQjzuW04tsuyP2BLhC1mm29mQdHvsUAOtc/NLBssv0f5PtGmUj27mJyrroRl+p7fweE4+wt84Xagp3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqTLvRw2k6Y4Em0EPfn5DtOGAduYqmBA2PLDYMoQAzQ=;
 b=IjJ76TyPy+YulABve3AIppBprCpW1N8DChIehiOBx4uhPjDOv5K8Rf1SEi37ycBAZP0Qp6sAbDZ4eh0zeOvIQ/FUb8+M3ZtN/TloX1r1sSazn0EAy+Wmqh1dTzMDoGuy58q29M/REtl24q/9d6t1fxJq9E9qs2VCl/BpdO7RAwgJoZmE3Y7l2n1Lvk1z91a6VI3xrZr8oUXdPPxp499/zWtv5rx/TWD2vKAvgryAwMNhc3Za6kYWxEPcdCBnaTEmWDCF1M9QkEiOIas9nE451Jt++a+WCkwCphNROQ9ga4fRmHTTEsksdi9GssySdxXWW2O65HNByD5I0MoyWpRPgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 18:23:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 18:23:57 +0000
Date:   Mon, 16 Jan 2023 14:23:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v3 4/7] RDMA/rxe: Add page invalidation support
Message-ID: <Y8WWPAHvZsXpwc0M@nvidia.com>
References: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
 <97b0362e256dd3eb022d81c30941edd8fb0caba9.1671772917.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b0362e256dd3eb022d81c30941edd8fb0caba9.1671772917.git.matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e989f49-0c24-4e5c-35c0-08daf7eed4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5PD3lXFvKzl7TRHupindPkOIkH3uiljpR0eTCKCtH9EOwWKBOlVeYFn6+XNnGAyRJ894Q0D/91WVl7ssXiahG9epscu6vrqJLrMY0fgwquuL9J9qOuToEuMsxT06BImLfpbR05l2fUaYIUJGhf1MOOjOu9AFV6lyXwAH9y6s94Erv3f7zjBj/u0LbQhqA4W8AGEEOH6D3zUFrpuHNlr0JAYuih82zMgsv80dJTKJDrFq7sUBKuqZnTeoCXzqV70htI6noYgA7C2/ddzYUjSb/EAnYxl9gkU/Ok9XFh9uCkSx9Ha6x12/+ltqFzX3CXvo/FVTaMtTpc1smkv0q9+TrPGp9ciFjfGyIt6qHHK7RLQU0qjRpXGDB01am5CFuSjK1bVMchFLFi45OR16ImfJuqVjpmRolvqrHVM5S2PRTHDFn5zFZvtAX2OFpj/xexZRM65/PqT1iG+7tUP7yQ8VH0KrUuH3mT4mAUnO3LKdPqL9bYAl/PPe4BxfSSEutDA33cr61WP+MdkHc0yKjQ0TY+KVEsVZ3ENhufeiPE1ncb5HzfB2B9fXiAZ3kElq/VJz6VS8VgUrERHrYU8DHMnn9LfrFjanKKUqZwRDvNONw/PycslkSjtglEXTp+bvNQKJT0qkMw/GEmLSK7EY42pKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(2616005)(186003)(6916009)(4326008)(66476007)(8676002)(66556008)(26005)(6512007)(478600001)(66946007)(41300700001)(8936002)(5660300002)(83380400001)(4744005)(2906002)(316002)(6506007)(38100700002)(6486002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txICi5OcQtfnK6iYvCTaw8xl1r28dgQapaDApWjH3GRY5QFoyYJYVgDhzzi0?=
 =?us-ascii?Q?LIgBUiQBu3lEzzL9lOiTLxlhO8tW1SxlKFYeBl6B8qQN+Jh4j/l+KU+jUJNa?=
 =?us-ascii?Q?VQo92/KJnQWHfQxc2480eMWRiWz+Wq097pYNjsq+0Fq4NmCjd3OVfBEPTHsC?=
 =?us-ascii?Q?DBhs0A+hDjPCqPR7NTwfARLkeKkVjF4kQI6rqRUTV1l/dsKD89DZxJbw7oZz?=
 =?us-ascii?Q?7zDmktQaS2p/cG51YOilH8JF9V9oV9hHaWg6oEyLpNTe2mYB5VA+REWaHEEb?=
 =?us-ascii?Q?B5DJw+fHu4yT3z7X9yds4nNB8/Mrq8rexBM9EjlUlSq3w8vBTnZC76UFuxfR?=
 =?us-ascii?Q?MgYaSRQaOkEwkbA3m92Kw8PJU4tjgXU2W3rUby3JMkqbEIZR1h3zmaXIErgf?=
 =?us-ascii?Q?KrocUP1nzEOtWJOF5I3fGEEodCTVJirCLogEeQBxuAJS2lpI36fgj3++B0dN?=
 =?us-ascii?Q?STKUwVmgsaapGCAUnF/t5vEVGV4nsy/CZTrcocQapaKt1OxbN9NL+6F+MobR?=
 =?us-ascii?Q?z+LbVJVHV3+vQZLJ8d6DuGTR87SLkg4g66aHymx1GKhbsYDpU40KGhL0ovyy?=
 =?us-ascii?Q?E8ROhV0ih24kQthrgVFXjiWet5Aa4MSDqnHxmqDSpY9Nnk1jSENZFByqTXSS?=
 =?us-ascii?Q?6ER3t9kbos8S2vMCZBDCKqa1B4LXUlcy0RTs6h5ZrXI33oLuAxl5in5v91J9?=
 =?us-ascii?Q?oXl/9Pt6nBS4yD/XLEyD2ZGILMB1kRCZZpGWiriDH7belRQsNzetlw1hkt/7?=
 =?us-ascii?Q?3/NAT2QvN5NTI9O0I26r40EbX5QHiZhmGxmzd3ZBQji14uChREQxrwjZ8Qi1?=
 =?us-ascii?Q?32RL1bUuHsqVMrt2sxx8eTENPVyeb/ld6pNOuO07JEDetHTHgW4//iMyJ10Y?=
 =?us-ascii?Q?qEeZYIIwOYysHodibrcGg+YBCpMglDCJQWAhIb3D1CKSzJEjYLX+oG0oGvXz?=
 =?us-ascii?Q?hFJc1+bf/9d5WGZ6MWenkmyVVRUoGiMDqfex2ddDBEJU3YHcjkbmZB7lSGVd?=
 =?us-ascii?Q?utwja/ThfRzZvIpu6nnB3B50SYnmUxFdqr0eYqWK/sf93tLqQiNwOv5aXXsQ?=
 =?us-ascii?Q?LxhRbCDkFReevf50048HrfbKd2U2aZ+Fgc12fgD3AURILviWhKmPQrxDEAbF?=
 =?us-ascii?Q?mLRw7QheiqNaUGByp6EYl2Ny5ZpMa8AyAHCdU3mKl9t+Fz8kSOje96iZ57v6?=
 =?us-ascii?Q?QgDmrJtCpNjuuq8hJq8QK3H5OP475QPP/EpSA+1jMh3jsDUQxfH9SqZQebHd?=
 =?us-ascii?Q?bekw07alPiEeVcT/1lUs8X8qckikuKiJNMeeXKI4984+W1johMpxHLlJWBlX?=
 =?us-ascii?Q?eq60pY2LbYFkC/qIbgj8OGEf8W4vX2LXKiVpnluv16ZlnG7M78WCU9j+CbG+?=
 =?us-ascii?Q?LZDR3+Z5+/plw/pE0d8cDWMY44RMdpHEMyHBqyaC2ETyxi00sU0iz0VrDgaq?=
 =?us-ascii?Q?leNjBXqAvdQxMtxwbCM1WVKHx7TrPv5/s8q2mybBQiOHdF5oVU+RtXU7KLAJ?=
 =?us-ascii?Q?zYRZeBWJQCikiPCJ9aQkpbLiQEX0z3zdiVyIKLnSJ3J3FrFHxi1J6L/4Yt2z?=
 =?us-ascii?Q?Ju1D6MTrtjyZVgouCyfQR6YZbB6WJa/1bXghft9I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e989f49-0c24-4e5c-35c0-08daf7eed4e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 18:23:57.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qZJd4+rBM/F1JYOn2gVUt1V+PbWrEFcXN3jV2bkHuCGp0D4cqL/b3stzJncyYra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 23, 2022 at 03:51:55PM +0900, Daisuke Matsuda wrote:

> +static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
> +				    const struct mmu_notifier_range *range,
> +				    unsigned long cur_seq)
> +{
> +	struct ib_umem_odp *umem_odp =
> +		container_of(mni, struct ib_umem_odp, notifier);
> +	unsigned long start;
> +	unsigned long end;
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
> +	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);

After bob's xarray conversion this can be done alot faster, it just an
xa_for_each_range and make the xarray items non-present

non-present is probably just a null struct page in the xarray.

Jason
