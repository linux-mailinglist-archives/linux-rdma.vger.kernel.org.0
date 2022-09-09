Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90C5B3B07
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 16:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiIIOrv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiIIOru (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 10:47:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C91282C5
        for <linux-rdma@vger.kernel.org>; Fri,  9 Sep 2022 07:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4p9oxAOvrX+XW5Fk8HUkv6rkOiO036zOnWqm3fV7FjurWXGvADhj6zx3FJIXc3OqxucTDGcAimSiNUEIdrcHA8Y9pRCzSnn/P7P2JyDFjqsTdgpMd+FI8HJH9eyMbFS4dsEMgHfkXECQkrfYa00uhI5GgZvNblcxzqFra7WzZ61IQzmSbSmJ5eD9NHCjs7izrrjI/gGOvBIh41usRpxle23EcKy3ERWTlKkETXPdbF6UVpHR6+AupoPBbi21pikPpLbMUfOdzX8jbWar9X5um/fx5HsBZWx7xA36/Yqx5HjeNwMerg2cwa3NIOyZgKbzmqBESguG+oPwZHbRoCYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpHNeAPelx3a/UpVtJJh8VTAWGLjVe2ZdZrssesG7p8=;
 b=iYjV5pBtwmjS/+cwQM+mu+RmUQoGfnk9Idkbu0QdUzd3Si0CrPpuJJCkNN/6RsedhQbwt+rbITjlnXyVQlbFwnvUINby/sz0R4z6Hvgcx8ABA1mbv9r5RlGZt9LIL4PdOazcM3MfqZIPlxQBcozd/o63am87/Rg8lRc1jAOgI2+2NDFvnorbu9fcu6WWFmT8LY25Ib4U3FUf9gWK0HgpE+uO7VRztWOiwJp836+nj2cPX2pCMH2SB4H2NVsEAG6VrzJtKw49RtwwTbS+Y/jpiBs8ACgJ8CYsncYqAsMPkQEOAMOeQtUhoYS3LRvZKj/4paA/V62DF1b/ni9/dQ+mcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpHNeAPelx3a/UpVtJJh8VTAWGLjVe2ZdZrssesG7p8=;
 b=h9qLLl28rwamuZHE/9HJco4rsA1pkNrbBBfKIUsdTSkwVsEQ2b/CsHAk9BhS1UmlS1BN+NQfAPQRkLY0S5tNCjV2fSGegqfZZXvQF3v8JvkR1p1Zm13BkUhqi5KtvYa7B+ysQSz2ufAzXtg15S/Cnj2vmxfH9/D+8ulRbNLGCGjUMStvFRUDWvA1aZATo93CUw1p7nlYr2f7MhgRB4j44iapeqObB2ez7I3Nmvtd+4yIy7sULHtI79aWs1kEajloRUDtX03G6n/AKteS6bS+3wjQI+IAQFtBYJZL9as/kc0rslwvSn+8RZX72E5Z6flUUSMOiSxYnkO2Y2Cptb5RtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 14:47:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 14:47:48 +0000
Date:   Fri, 9 Sep 2022 11:47:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, maorg@nvidia.com, linux-rdma@vger.kernel.org,
        saeedm@nvidia.com, Aharon Landau <aharonl@nvidia.com>
Subject: Re: [PATCH rdma-next 2/8] RDMA/mlx5: Generalize
 mlx5_cache_cache_mr() to fit all cacheable mkeys
Message-ID: <YxtSE7xtfmo1vL/g@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
 <20220908205421.210048-3-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908205421.210048-3-michaelgur@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0033.prod.exchangelabs.com
 (2603:10b6:207:18::46) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: e203f18a-b9c7-4913-ac52-08da9272434d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBrBdYgXbQ5Cp8+iLt44tTocJA+2dBl9bk/lZIBuRDsjTbNK49Lth6XgL0LH4f1lTHDRL1ofbAsO3wGrONnkl1ZRK47myeOJM+nrbs9A38Gfk7kL5R7pCKMqNXclb97lUxCB7JUkBbohQb1cvYMEKClFpc7p75Rqwr7g8wQenyGZ1FPHPYKE7mv0rNWTI2sOSRvh8dXY1BJ45r1Bk8h8/11mUOrbnhArq7yQooiz7ztp80LZCSCGGW+qS5ka12oC0CdAhR2yvxFuvCBYi0zr7cFRAZxS0Rs4wIGnj7OSJLHMZs/6oNARJguKf7FofvVRSV+2cMaOCdkx7jCa62ljkljmD59E9lhbWJOOUtoEVEEUwuVLrXyLSjlavSHO5H5pwCaqMGuvQaJ2bCPhgiy6lLEDlK3Hct47d+oS7bDYbtWCtXbx7VmxzZZtK6PgHZT0hTSX32vKq0mqKwFgmfQ4hKiaRXtCwEnFTS8ItVsWyD6rdIdeEMPIPqT1Gz3BUq7PyBhMqexyl8CUPtfhcuA7pwHGCrtl8aFqYYUnGkUVGN33cACYd5tmR+mTUTjl3P4jPhZmGYTY34DX2Sp06XkMno/sNJReNsU1D2QHFb2SwcnEnWp0lUd/xQibQvexUeF8yJmlUEFgmMNOI1AkQ9k/KzZlT4yVjCnIohYXSe+h0QJ9zDI+v/EQhpVQxzFFvGqB10SLI3pJl5xTgb78PKw1Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(107886003)(478600001)(6506007)(26005)(6512007)(41300700001)(83380400001)(186003)(38100700002)(2616005)(8936002)(6862004)(66476007)(66946007)(4326008)(86362001)(66556008)(6486002)(8676002)(36756003)(2906002)(316002)(6636002)(5660300002)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDbEXSIkhzHF971UjxvhpUNqC0uweAkyLeMD/fiRJb0heGf/BFjObP0S8tgH?=
 =?us-ascii?Q?OlfUyojZyO6Vp7fu+cuN/GHVdqy/aaHhVg4SaT4e9/E09lc8TbrPJQ6++Qii?=
 =?us-ascii?Q?h3JhgBu9ygJLZPmz183F4CNV0qqJLw0ZOJehtp/CbHVZS9DlslDuYaW79CiE?=
 =?us-ascii?Q?jzUiaDjFMT+ekM2deoYok4J7TYPj2iWzInYp8VNL0Ukzczo/X5zfatLGA//p?=
 =?us-ascii?Q?lcbaVkbX624nBkGpCrFMRDfylB6fq8N6MK580GqDN9dp82tmHM/48sxdXGwG?=
 =?us-ascii?Q?YqzBkLbObkFCytemZGIj3eKjwZsvjRpGjb9jQ9n7/Hp/HSFo52JElLE4kWkb?=
 =?us-ascii?Q?VzznygOevDkaKFkBAjO8yn+KK1QDYhAmCbja+TVk5jokIOARXeWRHD85C6Al?=
 =?us-ascii?Q?V6P7dMy88AHbp4CY5qcNgcdAXR9OPyqR6N/LwdVRu1g8oOoFKwdBa7eQuGpx?=
 =?us-ascii?Q?JyzZ/fOOuyrl7PyEO5UXY2z/Lwd4AxPh+avOnXAD9vxaA4pTZdWoLeevz+F7?=
 =?us-ascii?Q?ByFLQAv+UtmNSflqgjmjvIaPxKUobcMnsLZV9ropCEsTtrCw6rkW+a0kfK5J?=
 =?us-ascii?Q?Eq+3mVDs0GDoPi3e6q6+OpyxDdZfHLTMesy+gyNExaB6WeYygBOETc/2xgNF?=
 =?us-ascii?Q?Ur9e4XoW9vkT5qhqTCn8vfW2fNgEiDJYPE3l6w0+p9sXVeinJS2mG2ZEhQTa?=
 =?us-ascii?Q?K6mdr1V4grfgsaejTzaaDsNXLz7vZc1j2dCJpN+1rBQD3zknbnIsa2FAVyYv?=
 =?us-ascii?Q?5Msfrd8XnsOmbL6upJJQezgFkXdPys+XvEfx3TsleBzmI0kgYFxif+LRTfpB?=
 =?us-ascii?Q?ecb132G96AX3AlB8TSSRr/eExZgudslF14bIdsVwchuq7T6a45hiwyUvsYpW?=
 =?us-ascii?Q?QPCK6PmTC3zlB3zU4WiPswNKuMB3pLTjJpodjkuMmhoHV5NfwBLELqjZgBv2?=
 =?us-ascii?Q?z5m5DX/jefgC5zenp8IoXRVaG+qqhb93Dx0pVX9gfQF9B/RYywYBEO6bLWBy?=
 =?us-ascii?Q?jtg4nK2dQrzMWmF09L0k7E9ltyuaKbhu/Gm5Zvbp84hcxfp5vAZ/WbijfKWN?=
 =?us-ascii?Q?Wspa95Y9VwtBHi/qxgwAiKGhFpS+2ipvtFKCC2fGHvst30awVvstWm3v0r1m?=
 =?us-ascii?Q?zSSgWcoBHUPjt2JWSpAtXECqWOLt5E/ytWy8t6Xb42bOUGQMw/8I4RvpLF3S?=
 =?us-ascii?Q?rahYmHQ1qB7zmRZWIDNu9yOPkCKhn2LShD5wSrcbO1GINJLeQUPGy1MZ6FUv?=
 =?us-ascii?Q?0t/QI/CHOz6Zj7DWS1DSahcSqpeMg8Yh0YG2BFhPKWVi+PDB+bJF2qO/E5qh?=
 =?us-ascii?Q?tksYho95yW7pj6cGpJteCW6UaPT3xr2fjmlQ8WMj36qhs70JDV6fIk1C4Hcw?=
 =?us-ascii?Q?2lTR8pXJQKeJiVPcXCHJJxAgXPxPQeQucyOeYH+iaJeaR2l9fSOyZvKVZb+W?=
 =?us-ascii?Q?MzoZb8McU73D2/4dPfga3GQGWVafn8VE4bm0BbH/x/l64OwojgitX4T6aLWm?=
 =?us-ascii?Q?pXxu4e4uw3ITw8WNsDbYnb0BfvIK4gr/DUaCi4IhURnACQif9dnp+ID760Pm?=
 =?us-ascii?Q?25Gfkw/C4/PkPaGUPo4ruDonsmU3BtTmeiyLPiMB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e203f18a-b9c7-4913-ac52-08da9272434d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 14:47:48.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oxhiq7f/VCR7KYwC9UuwgwCPXjyhQVemXtK9q8grscxpXuEoEWqAWlLIkZ7+fyDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 08, 2022 at 11:54:15PM +0300, Michael Guralnik wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> All the mkeys that can use UMR, can be cached.
> Instead of using reg_create() for mkeys that are not available in the
> cache, generalize mlx5_cache_cache_mr() to fit all cacheable mkeys.
> When a specific mkey request can not be satisfied by the available cache
> mkeys, synchronously create an mkey with the requested properties.

This doesn't seem right to me.

The point of the cache mkeys is this:

> -	if (!ent || ent->limit == 0 ||
> -	    !mlx5r_umr_can_reconfig(dev, 0, access_flags)) {
                                        ^^^^^

Cached mkeys are created with 0 access_flags, so any access_flags
asking for a change away that requires UMR cannot be in the cache.

> -		mutex_lock(&dev->slow_path_mutex);
> -		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
> -		mutex_unlock(&dev->slow_path_mutex);
> -		return mr;
> -	}
>  
> -	mr = mlx5_mr_cache_alloc(dev, ent, access_flags);
> +	ndescs = ib_umem_num_dma_blocks(umem, page_size);
> +
> +	mr = mlx5_mr_cache_alloc(dev, MLX5_MKC_ACCESS_MODE_MTT,
> +				 access_flags, ndescs);

So passing non-zero access_flags to a cache function that has no way
to record the access_flags in the cache is quite illogical.

Before any of this can be reworked the cache infrastructure has to be
fixed to record the exact details of the Mkeys it is holding,
specifically access flags.

But even if that is done, I don't think it makes sense to eliminate
the reg_create. Arguably once all mkeys are cachable we should
eliminate the mr_cache_alloc in the synchronous path instead.

Simply call reg_create always and on destruction put the mkey into the
proper place based on its size and access_flags.

Jason
