Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA89671F30
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jan 2023 15:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAROPz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Jan 2023 09:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjAROOW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Jan 2023 09:14:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD6B7928D
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jan 2023 05:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEb98wToLsb0Jn3MerI2op3Fx/9eULrqgerZbg5r7rEfDo9A2vw6MYD/t6PchFdSc5XF4CFXR/6i59W1aqmzAEupPscDcgc73HT2r6CHtIgyg1Gmr77aTENgDMWRA/NwXdXQrMgdLNY0xWTapgyONQAcz0GhmHU6RwRTglsGPHefEcplz/0Hu0S/zFu8D381l9Zgt5Q31UfotmQK6s+QwnW2fdfLNSHJFD0cxfX5eMSHnOXlDPsiv8bbT4WG+Vt0Q39Ux/DTLtooHH5NDj9jw4zMYEchj+b9IEtxdwkUmxZrUbzIe/hFCs4Noux89tnBjrXWEgbn4LykQp/nkivUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2k5RiBjdkcd0xHncGZ2cK1ljKT9mM9erfjj1Yn0Jl4=;
 b=ISJWWM3puJSmsSxl2vQXwAWQr/ovbLXiXbZo8aL4qzFxnxeTLU5L9bOzN9A4djRRrGKyzEYPsLUq81zuQIk77n5Yyzt0L/91/tW3UlvbqIZw/HyBdkpILnhGBJogcgoo1vNFIx0ueP/jhj7rVj6Bm/W4h1REo9E7SgnO1awXMDlnA6abv70RQKMUM5wJdGm4i5DiymDspWFsh6ly/n4A/qhKaTjw7G+wgvGw+jRHN78sizZXKsKKWaBq47njRUKPTBKrQIHwrlhzj4ASA8coHyLNmgGMihjlBj1RqeMNHuI6gnjdAOmOTnzm8JbNhOxs4oJp/KuD2Ce989b/v2IWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2k5RiBjdkcd0xHncGZ2cK1ljKT9mM9erfjj1Yn0Jl4=;
 b=Etl0+liH9/8OHIfiLcO0Byw+DFEvpZNalNh1n0b4uz6kB96EWGLRJfzeUEzpcpxWweNC8bvNjZ75LVurMFAX0qaWcsB68VykHG0c25alJdKhhaQ4nWN/i+mxyNXTfkSUR2m8dHIM19GxA9KCSeHQli26O+v6iARpIRTaW8mayJM1qWrbhv6UWkSUy+yHfSkIQxEkYzuKD2rqJyAAzkqfqKFOKHgQVZI4KAlAP5aqn07iXhvdGn0DD1inkgUkh4Tz+tGSS4evwVqUAH2QoLohw7zoCu60iikGM1AVtF+LiOKGeYr2iMdDBC/3JHTcZtW+vgE5T15qgqoTnakZZVvtAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 13:54:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 13:54:31 +0000
Date:   Wed, 18 Jan 2023 09:54:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, leonro@nvidia.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8f6Fu2Sbv74mTQQ@nvidia.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
 <20230113232704.20072-5-rpearsonhpe@gmail.com>
 <CAD=hENc4W7ZXCa73oOnKbspf9TeVdZ096AYwHGp-HEtoT+m86g@mail.gmail.com>
 <Y8am/zTHUWDIhBos@nvidia.com>
 <f7916dca-960c-a722-cd2b-d9b330092670@gmail.com>
 <CAD=hENcxhH_N-4SJ-MCXXR6Da9W4gLYoOvE7_DzcK_=mv4EVGQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcxhH_N-4SJ-MCXXR6Da9W4gLYoOvE7_DzcK_=mv4EVGQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8e1ff7-c341-412f-95d1-08daf95b8626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLEuaAD7vXv/ozObA3KGORupa2yTC9nG4BEIQ+D70khwjq7Kfd1noAUujJb5Y+tGijCdmg40fTxLUb4PjxeuhZtvmmJD1rBsLTo4OqkdxvYoBuCbDJ9HR9FI/iVDE0H/eZMgg+qn9tfKbLQQB4+lX+UIzJEi0fL4IJqkDPGxz2y76nsd+rth7tMxMI3NoR8vu/FWXEryulzRRdsH2Hy6kSqx7edDOknkSaCN+FzG9u8PAOaBJbK1HmCPhdFlu+ch0qC7f0wIkbpG71hxzWjs3o14Y80miyCNyjMFfgiFvz25KCmbK5g+zmi8RIsUAd1sq6+yqBertOqh37QyWD27nzUAs2vfYNtx5AaJOJMRyeSVkO91m3g/9xUnYudhUBbv+h7aaIB4liQ2M5b9L4G5Bk9L/5KOJtzTw3om8phXTkn0oXd+JTuCncLWIWmarhsZcHRQIDh5/RS0SckEZ2pzM6qywoNf6Yr4Yl3BVocuyl/Avu36HA2AUF8ZuslISlQ1iF67NS8vmLxtOZdAZc3UpU8PhAxAjF8cFDZeA3NnFSZysqFl3QgkjFycQ3qs4Myu98q3KF9X1e46JVgjwWmAuc1tDZzUgGvYw62t9JweBG+ZgjOwOVwDUPGc9zZlDJhOmxp5BvIooA9LDk7u5yecwRM3KnLAjGhw2ahTlNOF4toQGBC/LlysYWd9RU9tilWIYKVVpfT91i3Bj8bGBF6jBmzQhDzklS5FL2sXIpBhDA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(86362001)(66946007)(66476007)(66556008)(2906002)(5660300002)(8936002)(38100700002)(316002)(53546011)(966005)(6506007)(6486002)(36756003)(478600001)(6916009)(8676002)(4326008)(41300700001)(26005)(186003)(83380400001)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZN3/MEkfDDTehxH+9mefXm41Dx2TT48Pu0fLlsrXnM8HCRkT01+v9hamhW0?=
 =?us-ascii?Q?YPD344myc3fFFffTU8E31fa4L94AsQ0maGqXpF+Nc9FblSUz744W3Z6Ohcy5?=
 =?us-ascii?Q?g4H5qrBidNsuI/rV78R8Ez8gDZHkTa3eF3H6JxCrA0T+shBS6KH6iw4JsY1t?=
 =?us-ascii?Q?kQt2pj7iP69WKBv0gLWFHueLVgj9yx1gneewO0SwnSDrTh3PxQ1wKhrjnt6N?=
 =?us-ascii?Q?GdM2eK3Xn1jZmL7qwPzO87++zNLS15B+0GcSnBEDV4F+Oe3YjlXe0l7GT6te?=
 =?us-ascii?Q?wzoU4WsRnuCQBtPCcrW/mXRfCTpEpw6IDgaac3+46VpAl0Z5uswSM1e2a3Rd?=
 =?us-ascii?Q?AY4SDyTEM+UqBQICOLPkv8vsMZ1Q9gu0V0SfbGvi/hNk6quHycOrezMHeO5w?=
 =?us-ascii?Q?IG8rdjZHxVLlsT/j8TqaCUdrCzY2E8/92G3AnYH0N1VVA+U7TBZjBmgxVr3r?=
 =?us-ascii?Q?E/Yz/IpKBDAT/GhMNX0iTZ895mG3LmNp7h7i5vNcAYrkOicsjWFE/ID5kfS9?=
 =?us-ascii?Q?4VGpVpUPZfwjRYojy1nUkWH26kxlDYYDm6ZSEXSvseeccEczWf26Y5nT4u77?=
 =?us-ascii?Q?Kf2aHtM3wbtr1TCbIPhn+5ctOV5pb1XsVY4zQnp6PAaNviHqSdUr8PiNDFrh?=
 =?us-ascii?Q?5k03163aXwYWI/IJAvYDfG84/z3uPQ/N5tjIXv8WIvg5vQxwBuE1l/mwWD+7?=
 =?us-ascii?Q?Adg5p9jUapvep4Ev34T3REGv/AUu+yj/ccpGvgcls+T96Avg7NIpQB/IkrEZ?=
 =?us-ascii?Q?DknIFjBaLFnYnBsHLtBbppNOHicfU/AmKK3glaYQAyHrxJGHgjPCQysfyCnN?=
 =?us-ascii?Q?oMkcnEYN+2xUswGJJLJW2Fks61dE1dX0ZpDPTfnx2wpgfPO42IFFTDGguJxb?=
 =?us-ascii?Q?rLjFN5BVvoDw6yVj6Q/u0DSfQFnI0TikQ/J7nAtsSFi7k4QQ5MRnYXJOB4pt?=
 =?us-ascii?Q?cN00OUHg4/XyIs6vt2lIuVAd5LVlS/WGKD6nJnlXXBYFXF6vMCI/FnSgz5T3?=
 =?us-ascii?Q?0jCm9jGooq3qRwqcjJaxnGpZ5ms+g+do3tMhQ2l0p1oBZkU0yvQeK4WE2fcv?=
 =?us-ascii?Q?gLOZEOiAVZ49JDSqO+PUpYWzrHOD5VoK0KpL55O+rBIE+t4ESHbZgsIXk6vh?=
 =?us-ascii?Q?2YJ9MfYIaA9firhUjTkjOAfB+EgWx1RHtt+hKQwDZw3SINR3Paa18TlL0IWx?=
 =?us-ascii?Q?+sMGug0VHPdVxULvpZ+F+FN7/LsQarsGTHbUbHZmQqDR9l9ulct4WU1UD5Cn?=
 =?us-ascii?Q?iwBBpeblHXoTL1nNOLEF0tWoWxYsVgs0zRwR3eGWGd09XsqgOwCLHOSN9SRt?=
 =?us-ascii?Q?U0YHzrA5yPdm5YX30BCGzElX0XMevy53npHukVynFcG3C40FPJNH1hz8sWPU?=
 =?us-ascii?Q?8GBkwwj6Fyc1HwFDOXpa3sRpuWylx0Jpr5sltcqIeJmqk/b6agbT4nC8pUrA?=
 =?us-ascii?Q?GqOSLDNubBXBN8Rpv7//dZvqGMQtMZ7tZAmCk69XQ6CNuk9RoIqnaJkZ67x9?=
 =?us-ascii?Q?v0p51R64HGCor7DPaZuDLLYKc9rENb+BKMZjZi8JF+PN1+d3r1qPp1GuujWX?=
 =?us-ascii?Q?UjOzo0Vs8+LVbVd7WgNBMFkVRUxyl7KM0E6+O6tc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e1ff7-c341-412f-95d1-08daf95b8626
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 13:54:31.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce+xwRLV96CS5nZe/MnB+Tn+5gWBcpqfH6RGJnzmwds07hvnFTYO8rT76iJr+1oB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 18, 2023 at 08:18:06AM +0800, Zhu Yanjun wrote:
> On Wed, Jan 18, 2023 at 12:45 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > On 1/17/23 07:47, Jason Gunthorpe wrote:
> > > On Tue, Jan 17, 2023 at 09:36:02AM +0800, Zhu Yanjun wrote:
> > >> On Sat, Jan 14, 2023 at 7:28 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> > >>>
> > >>> Isolate mr specific code from atomic_write_reply() in rxe_resp.c into
> > >>> a subroutine rxe_mr_do_atomic_write() in rxe_mr.c.
> > >>> Check length for atomic write operation.
> > >>> Make iova_to_vaddr() static.
> > >>>
> > >>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > >>> ---
> > >>> v3:
> > >>>   Fixed bug reported by kernel test robot. Ifdef'ed out atomic 8 byte
> > >>>   write if CONFIG_64BIT is not defined as orignally intended by the
> > >>>   developers of the atomic write implementation.
> > >>> link: https://lore.kernel.org/linux-rdma/202301131143.CmoyVcul-lkp@intel.com/
> > >>>
> > >>>  drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
> > >>>  drivers/infiniband/sw/rxe/rxe_mr.c   | 50 ++++++++++++++++++++++++
> > >>>  drivers/infiniband/sw/rxe/rxe_resp.c | 58 +++++++++++-----------------
> > >>>  3 files changed, 73 insertions(+), 36 deletions(-)
> > >>>
> > >>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > >>> index bcb1bbcf50df..fd70c71a9e4e 100644
> > >>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > >>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > >>> @@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
> > >>>  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
> > >>>  int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> > >>>                         u64 compare, u64 swap_add, u64 *orig_val);
> > >>> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
> > >>>  struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> > >>>                          enum rxe_mr_lookup_type type);
> > >>>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> > >>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > >>> index 791731be6067..1e74f5e8e10b 100644
> > >>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > >>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > >>> @@ -568,6 +568,56 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> > >>>         return 0;
> > >>>  }
> > >>>
> > >>> +/**
> > >>> + * rxe_mr_do_atomic_write() - write 64bit value to iova from addr
> > >>> + * @mr: memory region
> > >>> + * @iova: iova in mr
> > >>> + * @addr: source of data to write
> > >>> + *
> > >>> + * Returns:
> > >>> + *      0 on success
> > >>> + *     -1 for misaligned address
> > >>> + *     -2 for access errors
> > >>> + *     -3 for cpu without native 64 bit support
> > >>> + */
> > >>> +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
> > >>> +{
> > >>> +#if defined CONFIG_64BIT
> > >>
> > >> IS_ENABLED is better?
> > >
> > > is_enabled won't work here because the code doesn't compile.
> > >
> 
> drivers/infiniband/sw/rxe/rxe_net.c:
>
>  45
>  46 #if IS_ENABLED(CONFIG_IPV6)

You only need this pattern if the config symbol is tristate

CONFIG_64BIT is a bool

Jason
