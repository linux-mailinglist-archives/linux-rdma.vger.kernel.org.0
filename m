Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F328611993
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ1Rp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJ1Rpt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:45:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772E696D0;
        Fri, 28 Oct 2022 10:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLA1buZU6ikPBt6WUBSBeoKeQM9CRSir9Uyl2FXtt1Gbl+2f9JgyBqPwmk6p9SN4hpbW6iDqPlfAbrL1MxSvMWq6kvX4BOQPhnC1VuWfu02qjpnh/EzlKraKc4XYsAn26CttAf1i9bRW2RdrCOuDF5Uvu9RhGH+2MAvpV7ba3ONDQvegpvmzfHd26noAUbMSH9SKtNcRMfgz8G9tKU2HYF9Aa9hLKyOh+srvpNv6q2N33SdORO/mcLpIJa9KMX9WrljS97iinWVaAFGIKYST98NCOuDcrS9nbN5YhY9TmsCAvVmzbgYB9Er4To18tbONqnEE39ebbeM6k0sApgHjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRDQ93TXkXDat2kY9ikKJtgqND8wNX6OELa+GGcaM44=;
 b=PVWrfHtPgsEmQrETV5huXc77D7vuRkrwau51f9tfHO6JFDKrWLq2/Q5t2MTVxOVeVZYTlLti2gdTmGIbkpG0/BTsyUjuwdcXcSumXoWX7QiWPBmyW/D/8wuwtri511wyHTCp1CkTGbvvKlxvOkrjrbju796YOvhN/srGES+KmNB2nCtjVqmftN2Bq8dpQ89xOsu4jEN1xn8Ac3yd5cjJKUQaquRp+9LcT/nGRselJ8n8kq1u7j3R069w7RrPL/tErnbSKlKx+6/BUFMV8BZTmjtcr3oF968VttMhDtjPa39SeCfwwQJ23M8UgCkCnz20uEqr223Ny3NKmOK6YkHKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRDQ93TXkXDat2kY9ikKJtgqND8wNX6OELa+GGcaM44=;
 b=mZJWx/VyLUCowy3B8kSmi1+6jMMmMkw3ldAZjoNyLt59lKlRmzFMFu11xDE8fW+SPu3ttuuuBJ7r6h7OrVKXUHTI9yu5IgwqTtiRsE/GT42chDLhINvqRDxIufttUQAE67x/xgL4MPmLzwAvga/c+UiwroNQl1CiHJ5nSHHlejAE5dt+Q/A0jmCN4f0BcghhDl7mdw9l8GSw9qDEwXizPYoWpj1nTN0CD9tBJ+TUmBgPHtXihBciJOdipG7SXQA3VhyieDQ+hbz6SNbSoLsynPLLAwySApXvxfF1kmRsOes51Z7YNTjZQBNCFIlMfkxB97UKHfZ0+ASE+uuOzoR0LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 17:45:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:45:46 +0000
Date:   Fri, 28 Oct 2022 14:45:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v5 01/11] RDMA/rxe: make sure requested access
 is a subset of {mr,mw}->access
Message-ID: <Y1wVSSnV1nYRyiho@nvidia.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927055337.22630-2-lizhijian@fujitsu.com>
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 883dd16f-050e-403c-dbfb-08dab90c3e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXNMNevI4Moh02XBd8+oGxhRYYADKimnW71FXlDS5zLui6iUDvTdSChWwMKdNVPBW5hqAF9ZqkwUsQNiGF1v9VtOCMxFoGcaIT7vzKTF9unYFdWHFlCP08li8jN8wnAlRetGwPeecoRNrChF3LdPnuZk68CuUTVeoinLZXrzixsnMyVS5qcLhlEl4FEcWnv3ySPW21KRNLwXsuiJokYcBwrOpbRk62+eUWIub9KvDeYnKyBYl90padIf5t2RrNEBKGadTGQ82q5mH6AD5j3Nq20QvqcE6V0fn5cSbZySszHENSjW+sS7OzCdqCFUFLSibisThhAI8uXUNa8+6QqKv3Y/7jY/8plrrdUGLO4NVg9Sm5YSD3I0JTUOF8bGtDkFEIx2+RK8JqQIPnA5ew8rlp6pSVmHIVJagy53qfQDuhG+/TkAneXud9s8T5XmaW7Q1LMlNrtMGKKO3z2tA2MPFV1CNBmZZqVHaoE9/1Sgbj26IUkjFTbt89Ismaq3+CT8k8c9Cr7ZUr+bWvnkf/UQJJRb4/1naQ8s59Yx4Nvvoxn2BIsGF7u4Cmq6hWOJ2e4RQ8jbGiESO684lHemqvUWfKlF6ioA7F5nwNaGWzz93WUuPj/bMwWpKQxqS0pozN2Z/D9NT+nuzXYCLZf94kSVikcO8rKGkIjnN5OrkKoqehpeeat/4CN4O/xMXfptXIxus6nqwfa3MhSkGH3N1tuFvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(186003)(2616005)(6512007)(83380400001)(26005)(6506007)(7416002)(66556008)(66946007)(41300700001)(478600001)(4744005)(54906003)(6486002)(5660300002)(38100700002)(6916009)(316002)(86362001)(8936002)(66476007)(8676002)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9MNeFFmp90r8tEYKXskzW9raB85oVges2ybczbGxm4BJVT4/dshLqr5xpsMP?=
 =?us-ascii?Q?EP93W1eJr/mSJkoQSGK5Rf2doRRZVVHyDfMPCjnPPfbNosdEax/72oJKvZH6?=
 =?us-ascii?Q?PeNEzJKW5rPZN+2sRhLJnJ7mPszLNaOBAFiLLSoiHeyQpdWblMZEOovSc7fU?=
 =?us-ascii?Q?GVuOBQeiWR1QuRIAFrxCf3QqIxZVwNTHavmEGUg32saerGiktnhV83ENEilC?=
 =?us-ascii?Q?NMdgHl++CeKKgyPlvqTFFWOh1nNgzk4Qw96zMqRDkUBKvZJACiuDzo/L+Qu5?=
 =?us-ascii?Q?ls2vdWtNf8NUr26/4vKVapkGr/8ZjsZetX7D2fupLcpbZq9OdbkmPh1pEAhJ?=
 =?us-ascii?Q?K7jEw2PSVYhBUoJl1LuC0/oILoYplJdXugVjJ4Tb+kgsqIsQ9nmHxMiv/vZk?=
 =?us-ascii?Q?bEDVLmiGYyShXEnMrYaTWSLs61dAJ7ZehbkaULsJp2Aw701xdUDN6SBvskSn?=
 =?us-ascii?Q?pt+cka6ZamZYrFNGMmg+lzNE4gu94bP8eMwDki//AowlRHHbuULdG1zArj7+?=
 =?us-ascii?Q?mB/NeekWaIpsb78EqYcM6+Og0bAexWVIhpf/BMsHOUnnbOSs/UOibCPqiNw2?=
 =?us-ascii?Q?GiHA1EB5yVrMCrmso2J9PLcy2kBaVPna3CeLzu8LlIYwS2IniKXUk3YaHCvL?=
 =?us-ascii?Q?iys9DTkXAunQ7j07QHoGuo4OYhWSavV7vu48cZB0J/Yvx6HYZuAl/Uf5qZVH?=
 =?us-ascii?Q?OcMTQ9IRLYYFcOdMOyt2ocZucuud3QTdMxGP8be/gL6PgQyTWylOYkqlOXtl?=
 =?us-ascii?Q?X0cMNap3V+lbLEUByDsqBf+Nn4UOrE/g8NQKale2EdXUD/z2E3eTfj5lfGhS?=
 =?us-ascii?Q?YaW/EfSwyzQOofNC11H4M5DmYgq7Yx3nh0y+Bhped9CaQZhZlBv57Wz+MCH1?=
 =?us-ascii?Q?xVrNkx/sm2wxOgm5m3K7oI3kBjAOm4on0Z6eFqbpQCoDncBKt+AWXYhAg7bC?=
 =?us-ascii?Q?gAWAxRbkEl9BgZmKCP+7bE5JEW6mErGPIGiyPb5dzEeE2mipTTocKYIqr9fH?=
 =?us-ascii?Q?BGomuqT4lRO9gmpt7Qmy/7HHGiqYFoX0xtKuNpx/Yee/5Bp5NHiAMLM41HxO?=
 =?us-ascii?Q?3Hjvanil6nOxHnFN7E9aJrAtl9Fj03JwNj2AX6LbHKDt3HYC8MHaTBSEseHw?=
 =?us-ascii?Q?dznWzuOuVlK1a0pahjdVgd8EbZ4VH7fR5Tr+9xGLXSnIP89SKKMGby7ZAnD6?=
 =?us-ascii?Q?+C9/MhqNYr/T5UwrGiZY0Lukg1OXmQwPSei3fzcMoGjvcW6+hJzhSOstJHyB?=
 =?us-ascii?Q?FOjSzr+IKUsfvwv8L4hylC4NwHgOhzVuJ/W5cVAKS8sE4WoqcrFdLpENdroX?=
 =?us-ascii?Q?pXu8mcH9J0CMWA49y8ZqGu+YfoskxDaN+6rgrklIdSQzvB58P7hgv0CdVRql?=
 =?us-ascii?Q?P8MESk1WzxBEYCIu3TSWMHq+MLi3kQsZMV2B714YyuKKSPWVpEbxcp/sJw+v?=
 =?us-ascii?Q?XSJ2lC4TEFIoyQFpX0WKht4760ZccFTOkTw8cnShPrSlrnu4rbMlxZjkXFaQ?=
 =?us-ascii?Q?KD+zNF9lz4fkRCzdP2/NdGZ+Z5WCECzJYII/KrHGCxf2u0S6NZLhUfQTrEEv?=
 =?us-ascii?Q?aZVnFEZ4loeAa0Sl2UE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883dd16f-050e-403c-dbfb-08dab90c3e8e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:45:46.7892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fYxB7nI6clEn++VeSWQq5qVIIazsDxgnfM3x/dWzLsTjmg4cFbVEizwfnXYlumr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 01:53:27PM +0800, Li Zhijian wrote:
> We should reject the requests with access flags that is not registered
> by MR/MW. For example, lookup_mr() should return NULL when requested access
> is 0x03 and mr->access is 0x01.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  drivers/infiniband/sw/rxe/rxe_mw.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

I'm going to apply this little bug fix to for-next

Thanks,
Jason
