Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E8599B46
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 13:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbiHSLsT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348061AbiHSLsS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 07:48:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667FED12C
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 04:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdUvO6LQ4ZBxHVSurz2xC1zJ8iwhfrmMhOMVZZsz+qGiFsLLm1Tz/Vxj0/ooCMc9LJxR0uoRqUrIHGdebCHzUv+H/o3K1rGHqGlcWcw0sbItJrfy/oktc6SeFu4Yy+l4cghHEaULQf1/fhn4c30d1KF0/WQn27BiJpmss+RmiQUkWepGSd1bSet1IYfYjSVfwyIQr5XnMtX1UP8+4qJjMQ9vlCS30/edkJYlBr7g1hW1lTIwcBeJP7Ror+2LYEiJkDuT2/4eSgNuAIBDBtcjIW7AWVkN2OBnYQz39XIE9c2sJbgTQPP8EMXtoZ8cHFrpt3MFgBT8fjTLdD8dfcsjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd27w5Hn/SKOTSlUkVfkINiErPIMUhY2ekcy6Wes++s=;
 b=cWMhGVilxaPxIu0VsUl3fggDHEIOhF2E2y7deO6A8OOt3KaT3eVQIjj3OMlgoK2Xd57rd7ykcxkMJtlT7BRpNx87K3uZUoVOpuZ24vu1p83B3l6/d17mKoXMYKgbCe9nkPb4T9sVy6bIOAmD+J188DXKqw5mdsOc3Hf0ONg05/glucjxM92df6pTK4U9HTrhPG9VFQzCo+GepMV9slClgEnfx88GHV3hTGPEB1JPT6URSNhE0DlP++YDSBvo68UkxsGY3XGLQRQaJuCeJXQwQGxWb/LwoKSef3uBZrfRfntxcJN2vcahdNw2afK6MYRAM87gX30Wkm1cBDwxyxCLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd27w5Hn/SKOTSlUkVfkINiErPIMUhY2ekcy6Wes++s=;
 b=Tb+rWIo+/MLsRfe23IriEX4MZQE70TKv4JO/pWjNsWl3wAd7dLl6K1h96FQWUo+mT8Yy1++FeNlV0YYFggX6X81i3/zig+Mr63xodaC/dglxUQUs/pGrd9y7sKBulOfNtaCfLzFEQ4v5LX3iJYW9svJGJd2pV2yv56mtzg/9CSz9bjeMktN4ZvEFg2/DJoUX5Lk0O0BSS5iAu/TOQkSro5nTx5NVnmM2ohezakbxLRf8WJHW3vtE0xnFpOT/cKUWU54p7Qk94Zue/37e5gAMuASvQbN3GDX3n13EB4jp2GaJ2ioN+QhO9/KvPohEMxp1RATZk58soHRTlAeSTUe4XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1788.namprd12.prod.outlook.com (2603:10b6:3:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 11:48:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 11:48:14 +0000
Date:   Fri, 19 Aug 2022 08:48:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for
 boundary condition
Message-ID: <Yv94fYp8869XZKFU@nvidia.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
 <Yv7QvMADD7g3yPWh@nvidia.com>
 <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
X-ClientProxiedBy: MN2PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:208:19b::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da389a7-0d38-4acc-181b-08da81d8b34a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1788:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIJSIVt7CDt97FEevTab/VjaDjvqs0G0bSLVsufrh9hgw6OuIoh6LEQrDWD/SIs3/it7hqES3MYj5+lZp5JgG1696uoTJSgm1zIjXDzfJqB2V/n30uOFFS5ZZDZ4KMlUD59xdvx0ECnG7YoNl1xcOGwstF71hBenJs20fi8T47LRAYbwoPMkLIXPCJNZRme2WTj1j6Psgt0A+pptju+uWaljeJJhb5RHowUT2B9if2WHvfMu8h8aIw4wLb67SW2eelqNvFZkxBdeIH4fY1QhIAiHkAB2cNBQ2dS7rYI/dqA8CyewV75oPrBhrtTfUV9EcKNxOlCwVxxYt5Js7RXBXWhYcunUAa1W+CeDcZ32+G1GnSrFeI4e9bch7PeWME3/QHFxp+uyU+mgnVwyBRovniwnQdu0LzEIuUDZULIymf2YBLxPhV9/pQxFQ8Fi4crAa3hx5o9s2Cd80FBduc2JW9cOLMW4VL8NacBY1PPTg5k0Cdcwg23WDpAN79jiJ63Y6HiW1SK1rUUlfeUr8MwrbcUDjQ2T+y9bY4ZwnpXr8x1YnQi/XMTIZHp6NsVN73k8qpoc8rPGyEG+BxqEudhhPluwJNW5JzVABRwo+BoP3iM38LWZhPk7TFSnP5kLdqtHFIvlFWgY5Mi1dtA+MyIYhq3qGhZDuF3DfeQ6h74wZvZVyRv1lNC8clfByfdwj5/yJ6w1Vy411OS43EBm5fQr7/kbP/FVtYFNaNyaG4t3GpVABWh56auYfAupbRuxqTVmE7CoAEPvBUXDfcGZ4rYXtgvk/66maZsvXgSzXyWkib0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(54906003)(86362001)(6512007)(6506007)(36756003)(2616005)(26005)(41300700001)(186003)(6916009)(83380400001)(316002)(4326008)(66946007)(66476007)(66556008)(966005)(6486002)(5660300002)(478600001)(2906002)(8676002)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vM4bZUXPC5WBCtfSk3Ooyz5Q6pINlxUvRabPWmXefxVvJHfTn+9H4dYnyz1v?=
 =?us-ascii?Q?39Xmjgtm+mIAX8HrQULpiQ/vTXqcwG681V5q8+o0kOphcELegRpVXOHLCJcm?=
 =?us-ascii?Q?yRr9ZsVLXyyvt7315VRwPRCWwWUZZXpTsAAu+MQBSlazVv7Arx+uHjjvPFgR?=
 =?us-ascii?Q?fmnd3aMdLDK5ZIBfL0EWzdQVIxkaqmOBRsgbSpj71A1D3nS15Zix41Tkf3Os?=
 =?us-ascii?Q?fenKqGg8dgiXz5hRzoCjCKUNYRaKNPL3zCE3uhTIltfP8Z2VWMj7vgkvQUba?=
 =?us-ascii?Q?VgaS/kp9oNQgt+POSJVtyjNU4VWig6S8xdlGjLTsxeJuEwXbczPOCjneY9ER?=
 =?us-ascii?Q?pfMlnuieQd1CJN5GcWI8iVFj3OhA/TMst3KIBrKRfE5F9NgtYyN6LfUfX5qV?=
 =?us-ascii?Q?QdNCUA1SElgZ7S1ER6ldHsSREFfwCLgKS3N8EZ6mMW5RtqbBswHS4neiSP1a?=
 =?us-ascii?Q?tP+zIj96wx2rnjN3ldO6X0JpLavVP+rOSZV9yNE7LVoAEuouY5DvcOGhpLj5?=
 =?us-ascii?Q?oT+8EyI8GXHVOOwksox4KyNBPksoOsx5aqzQSQznNJ/xZla4DMIqOO5IRLrS?=
 =?us-ascii?Q?1WjaPMd2eWBNJrXqyK1+7dyPSFNpSmdXuvP8s/J1OiAbIpp7a7Kuvn0xhwss?=
 =?us-ascii?Q?8MUgz2WURXg8TN5uEK30oxenuGNctIf9cw4+I8K7cB8+PERYJ2UYgw3Y5wgM?=
 =?us-ascii?Q?u/H+HAcFz6aYCZoltV7LohbGoSMD3urQx9zbUPEDQfzDLe/qBYbql7MD70wF?=
 =?us-ascii?Q?NB5S6h8wk+tX6N+VOEw6JC0dw7wSlLnaBMYC7sQcI4iCZt/MoXvfpbZsbjN5?=
 =?us-ascii?Q?UdionVVwygI7ZIEIzKEwzZ0U/fFhtWe0KzlbH6OcQ/6qGxtn4UqktPEmhrT0?=
 =?us-ascii?Q?P5DquTTNF/7RAjSpSCj4eQD1l7qfjx4FpZOxsUS4YZB0nsxGXkI1pUpd35qC?=
 =?us-ascii?Q?/lbvVSlaAQNRkAxIYViXDPZTsUYqqqpPNqIxmBHY5HmDynlqIl+hiEzZUSQY?=
 =?us-ascii?Q?25Fj7dtqFunD4dGw1XSIKafcO01WYqLRiW1/mzMNjbNIv0GaiGfUVTUTzBeP?=
 =?us-ascii?Q?tL1j/zhiRcb9hx4JCBgSXuuNLOtwjo9HzgzAvjbKmrvXISIcadW1AtxPbb/L?=
 =?us-ascii?Q?1PV0fNwLVJLO7CPzHi9qTlcTcDeec+qPEiKsG5AKXr8ZlE0CNVP5yLVqPYis?=
 =?us-ascii?Q?GLSnbwlPBh6aORnF40QAiBj9c3JvNjmuUgHm4p8DIbR1I6hFcsosO84zjNVm?=
 =?us-ascii?Q?CztezHnRR4RzQsCsPklryzBhwb92ZpLuxZDWTenPlX2+YbswU+8r8X8H+4ws?=
 =?us-ascii?Q?m8qBHzrBMS2AClBNqwtHaowtOGnmuFWn10Ix8ryONV+6Nq5pHkoNvgnqB0eC?=
 =?us-ascii?Q?7IXSXnCOGd8yPcALv7x4ElbGxMaqaObYLogcCvuXr6TEAclA5GW4tEyQRD0J?=
 =?us-ascii?Q?MN20LTDeJDqEvCXiPbGWH3eqC/1Z0YNU5SF66lo5Ej3CoK0zCGq/7x7y059H?=
 =?us-ascii?Q?aRKVu1+kzu5axla7FhSXh4CT8u6kFOzTN7LInT16OQAQ8Hq7mPEI2HNuD3Rs?=
 =?us-ascii?Q?C0933k4frGH3DQDYnGPr3oUYOhVBFmJ8VkokNdTO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da389a7-0d38-4acc-181b-08da81d8b34a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 11:48:14.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kOaBHaKpnlQbg3ikqtctEMJghAzVLCGwA/3dK8AFsjTQ8NotkeKUEIIBaFgk/RT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 19, 2022 at 03:13:47PM +0530, Kashyap Desai wrote:
> > > All addresses other than 0xfffffffffff00000 are stale entries.
> > > Once this kind of incorrect page entries are passed to the RDMA h/w,
> > > AMD IOMMU module detects the page fault whenever h/w tries to access
> > > addresses which are not actually populated by the ib stack correctly.
> > > Below prints are logged whenever this issue hits.
> >
> > I don't understand this. AFAIK on AMD platforms you can't create an IOVA
> > mapping at -1 like you are saying above, so how is
> > 0xfffffffffff00000 a valid DMA address?
> 
> Hi Jason -
> 
> Let me simplify - Consider a case if 1 SGE has 8K dma_len and starting dma
> address is <0xffffffffffffe000>.
> It is expected to have two page table entry - <0xffffffffffffe000 > and
> <0xfffffffffffff000 >.
> Both the DMA address not mapped to -1.   Device expose dma_mask_bits = 64,
> so above two addresses are valid mapping from IOMMU perspective.

That is not my point.

My point is that 0xFFFFFFFFFFFFFFF should never be used as a DMA
address because it invites overflow on any maths, and we are not
careful about this in the kernel in general.

> Since end_dma_addr will be zero (in current code) which is actually not
> end_dma_addr but potential next_dma_addr, we will only endup set_page() call
> one time.

Which is the math overflow.

> I think this is a valid mapping request and don't see any issue with IOMMU
> mapping is incorrect.

It should not create mappings that are so dangerous. There is really
no reason to use the last page of IOVA space that includes -1.

> > And if we have to tolerate these addreses then the code should be
> > designed to avoid the overflow in the first place ie
> > 'end_dma_addr' should be changed to 'last_dma_addr = dma_addr +
> > (dma_len - 1)' which does not overflow, and all the logics
> > carefully organized so none of the math overflows.
> 
> Making 'last_dma_addr = dma_addr + (dma_len - 1)' will have another side
> effect. 

Yes, the patch would have to fix everything about the logic to work
with a last and avoid overflowing maths

> How about just doing below ? This was my initial thought of fixing but I am
> not sure which approach Is best.
> 
> diff --git a/drivers/infiniband/core/verbs.c
> b/drivers/infiniband/core/verbs.c
> index e54b3f1b730e..56d1f3b20e98 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2709,7 +2709,7 @@ int ib_sg_to_pages(struct ib_mr *mr, struct
> scatterlist *sgl, int sg_nents,
>                         prev_addr = page_addr;
>  next_page:
>                         page_addr += mr->page_size;
> -               } while (page_addr < end_dma_addr);
> +               } while (page_addr < (end_dma_addr - 1));

This is now overflowing twice :(

Does this bug even still exist? eg does this revert "fix" it?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3e9579ecfb

It makes me wonder if the use of -1 is why drivers started failing
with this mode.

Jason
