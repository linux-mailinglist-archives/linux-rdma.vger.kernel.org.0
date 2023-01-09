Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30D662774
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjAINmI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 08:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbjAINlp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 08:41:45 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EFF1C90C
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 05:41:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGQ1zWtbDobSIxkYXd0gpu8v5EoXZhoa92xyXUTmS3Wa7xo8t5S89eaPhqsb1yYsb3bval3DtwUbE/ZrpYkQm2G2SPZgzVQ0LJ3HB/spIq3BY5yB9MW/cTC/m7AWSC/vw9wWqWLeok51Bstw/U55aUHrn5e2vGip2L56VlK0eLEeWPlvLxbsaMOExd3ZUh1s9ezrxWKTNw8bN/q5FsiLYmLd/dJIJw0AozfRq9oRVdYcCsqdbMIsjToMRP+fZhATKQPxr4JczQMFs4Lu7pHQU/s4c4lIwlVRhoPpxg52dBm6+zVR8go89T3buCuElsE264XwDPGC1U+6l2zP9DKbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvJYuj0E7apa5KzLZsNnnD2dXahghUfTwJo5UXWuC7Y=;
 b=RzFtxm3j6vjkaMigS6SOFfm3xZ5/x9S5TjNJ6nZsfwZlfM4UX6+lQ9hJZHfCubucBWCcYWdeuDTywBGGziDsTM0sroQ+RjsYjo2HrFX6FNSxM7y4Ux2dTiqrnFXHHUwXxLLqCKlYkKrJRZ/kuKSln33Ph4tu6c4rgwOXSGvRaHczy0pWZYnZ3EHEOUGar+gZsrKcfETYZKW4w0XyyT5wfAUYLnjI4GuT+7/RQx9G5JaP72/aX8Wdg/h1ZM2Orr1Rlo73Sjlpdc3NALtp4U0wpmPqeZl/NyPXNSL7Gnv/ckvoYcLC7hkWCEiF5iJw12n3J4W3ttbKu9qe6niE/Yzgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvJYuj0E7apa5KzLZsNnnD2dXahghUfTwJo5UXWuC7Y=;
 b=DFjjdU/BFf43fMF0rJv4f/YzCi7nrj4w8T/kIGwFos8Zf+lsuBkspt5WqWKw9JBu3mmxT1TbcLQRUSBinEWsxRc222cBRMpQll6f48X4XhhHDxFX9mOAfoVLkhDRnvzoVGzlA5F4ZdY97mN84wNUL96wBPTH54S3luHyL1d+pFaEAaoffQ2lcQIF0A/vDZWGgfVfbzCpQQiOW/v+kWutxHmnO+aNfd1472qE34PB1olDTRTf/lh5ku4uiRxF5xMvwudNKDjdJ04ETf7gITp96tEYNsItxbZumaqerwXkbbWA9t5Mnh/xX6SnxuD0zcLGdWC5nVq0r4w+GIP7e2D2zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:41:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 13:41:42 +0000
Date:   Mon, 9 Jan 2023 09:41:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ynachum@amazon.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        matua@amazon.com, mrgolin@amazon.com, yatias@habana.ai
Subject: Re: [PATCH for-rc v3] RDMA: Fix ib block iterator counter overflow
Message-ID: <Y7wZlfIjwehnui1w@nvidia.com>
References: <20230109133711.13678-1-ynachum@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109133711.13678-1-ynachum@amazon.com>
X-ClientProxiedBy: BL1PR13CA0310.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a76ce1-35ce-4c05-61f1-08daf2473dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhYHF2x52w7JYaPZ3quVTDXvrYAXD/GTH/jAHaRSjWxq1R6fqSZklgQgM6LVXxEX7QGWGErSB//ipfFdXy5O4XBxdngr8Ao7JEmOEybgXlFK5ltgv6P2sOfDAVUoue/YasKK+VaE+yfmRtf2obe2L9/1A1ZDBACNj2hTjy0WOvGi+rGAFlM5CGgPB0WB0jjL1wxCJcTVJo1ThIrRtQ7nIp6iefcw7ZGRA4LO7QpIXKlzb9qHkgbU7PczJ0iVBTy4TH+lgCC9zbcoOoMW8ubL3Xh+8k9OpKiCL3hvoaM1b/8uHRpjaJlPD9jA0m71ucQSWAx217Qa3yRTOVwdPGmMDYzLHhHi9cM96tjMLcOEFcvQan/hGpKbSnSLOx+WBugcP7JHOuGgcFYWxnt38OkZ2fcVPkPTRgbqrOuskVivs6kJSTAX5jWzFlRKu/TchAb321PtVz3DJg2uFhO9NcKEgBu1qBZmDoRzhQvHLmPiaqET5vZvsSy7tps5L91jI1nT72vwImcMQ4tX7YJ7+HBayDswLGjSL5+jKQZlti3RxssoIS8ytvnzAis6K87Lrw+iJaQ/fXtSnoJm0J6T8izUyLc3qN/vlAej2B6PIYCOIGDWJrB8MVVxULL8f8xmF+m0ATj5NsbJzlFhoAteNzhhQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(2906002)(83380400001)(2616005)(66476007)(66556008)(5660300002)(66946007)(26005)(186003)(36756003)(8936002)(6506007)(6512007)(478600001)(38100700002)(8676002)(41300700001)(6486002)(86362001)(6916009)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RyRLspHO/7vlWgJqPOJZkEV7DHQeXhwD4PB1c3AsbfNla3YbIH+flMCZyYlZ?=
 =?us-ascii?Q?eU5cLYmbQYStIYl3fuigZqWjRoYllvaFM9hdow40ifkYfPpTbT8VTTQmm/P1?=
 =?us-ascii?Q?a9PVHrtOOMOMO9ZwDHFFOR0WOvaHFhPdB7N4MsABCNUh2a8Pl+tbhNxQTEPT?=
 =?us-ascii?Q?JSoHppfEzleIDIovug8vSVsIWubh/ZXaLGo4ghzofH+4Z2/mPO+RQijelH1a?=
 =?us-ascii?Q?QuqOIwgZRl4i/TT1pmk9e/7EPBrs6/sLj4Z/b+DuETaVmlZQya+ySZmtgOL/?=
 =?us-ascii?Q?MOqRn02s8lnrTbdxVosxuvZFepav4JsLrNR/AlXuqHKiM/4skp7p3xoPvGH7?=
 =?us-ascii?Q?Jrz2RCNP+6IrZ4dVAVivP0tvqmtU+xAn+0SZXGtzOWAxiKV42jxWR9ESoIM6?=
 =?us-ascii?Q?9Fl81nS26oLUEQwA5crKELjWY+uIKJTx3b/RY2BpGNo0LhyWo2FO0rxWBgyg?=
 =?us-ascii?Q?q/eNe8XSogTZZbM9PMlX7MXC3GqdGjK8D2yKDVlIzzNdiFPcUxwOprhv0DeM?=
 =?us-ascii?Q?8pKkD9jlKqCDUghiRn/61/pLLVitgeO295sMi3SvSwYGoEhjCICTQ79VDTyk?=
 =?us-ascii?Q?igt1YLBenvaF6upe9VN9uN4oxY++l1PpllHs0j1IkeYZqPYQBLfxmBEJP50t?=
 =?us-ascii?Q?QTdMmi/M6NPOHeBlQhYXCt2ldEC579dQiYO3BKY57uw4ru/zH42V3Jcb3zH7?=
 =?us-ascii?Q?Z8jghsnYbss7jGxlJsmgPiivA2kDFbFu65+T9YiX4C1pP/w5FfEUi2h2wam1?=
 =?us-ascii?Q?sodEsLjewW6ecrKeapF9vNZPYp1rwu74VPYKQ5BBttNNF7qq53fOTQc4viM8?=
 =?us-ascii?Q?JOqVqyUKRW0ReRCrr3RtzZRp1bMWL4MxRcoTaBgCD8sdSfAZeNeBkEeEUFb4?=
 =?us-ascii?Q?cAEaX57JNhDChdV6szKEpDACOgFYp85+dJLyvBrtcA6Qi4XUX1O+loS+X0U+?=
 =?us-ascii?Q?p+enctwjDbrjCF0tF1ki26Nhu0wfi3Q+rGYxhhyIKVMtHUsSiG1S51CtWXAD?=
 =?us-ascii?Q?72mCn3m4fWMni1whtkYv/CgAWrn5txBWsAIdHLNcHc7bH3Ic6AH1wTPfK2lJ?=
 =?us-ascii?Q?aRtDTk0DRLC+syd6nXYsrfp2sFjhgqfw4Y+9Q6PPVRn33J9UCzeX4JNBHDN/?=
 =?us-ascii?Q?O8AcnSLT7FUnNWKrkICdQ0TNhyTomDQQMGhLAoIDDFczJjlX6j0tls5ktLZ9?=
 =?us-ascii?Q?RZ2cAq1EW3hgmfluXpCNWZi9jzA+usMg6V71tqHFfmqkV7K8AtFtu21TQ/jN?=
 =?us-ascii?Q?KTO/k8EPQeYwxS56SZDghSvs61P/E7wHVN3JI+uuKDNYG5o8yoVqt29/9cew?=
 =?us-ascii?Q?vX/eFFpQiwKsCaKdu2V/0EUOPOckyzXisg5LbVy2988ioE00ALy/08wVDlDM?=
 =?us-ascii?Q?T55IwNYSCmUMFwXGbdDuXei+4cTqk6LcJON6b0tu6VcaYjO4o1RKMF7Lx8sk?=
 =?us-ascii?Q?lE/JaB5ftzMtIIJrT87RGYpQGF4wipoADHsA3xxfpM0ztHlIANGf8PpN8xgh?=
 =?us-ascii?Q?Ks5aKkB4PCwj5ZZKdhunX2Qxm/g1q0ezBnm2z4b04ZDn1T+EJ/9SZfkLCNFQ?=
 =?us-ascii?Q?Ox3j2B8IfICXewOspsAqqNU6BM7XqmghBmbiaqZc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a76ce1-35ce-4c05-61f1-08daf2473dfd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:41:42.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gdf+6cyZo75OOZODdGi2YtCARR6icG/Db/Fwt1m+YYZ+qWJ3xhDI2mdQoYFPubaK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 09, 2023 at 01:37:11PM +0000, ynachum@amazon.com wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> When registering a new DMA MR after selecting the best aligned page size
> for it, we iterate over the given sglist to split each entry to smaller,
> aligned to the selected page size, DMA blocks.
> 
> In given circumstances where the sg entry and page size fit certain
> sizes and the sg entry is not aligned to the selected page size, the
> total size of the aligned pages we need to cover the sg entry is >= 4GB.
> Under this circumstances, while iterating page aligned blocks, the
> counter responsible for counting how much we advanced from the start of
> the sg entry is overflowed because its type is u32 and we pass 4GB in
> size. This can lead to an infinite loop inside the iterator function
> because the overflow prevents the counter to be larger
> than the size of the sg entry.
> 
> Fix the presented problem by changing the advancement condition to
> eliminate overflow.
> 
> Backtrace:
> [  192.374329] efa_reg_user_mr_dmabuf
> [  192.376783] efa_register_mr
> [  192.382579] pgsz_bitmap 0xfffff000 rounddown 0x80000000
> [  192.386423] pg_sz [0x80000000] umem_length[0xc0000000]
> [  192.392657] start 0x0 length 0xc0000000 params.page_shift 31 params.page_num 3
> [  192.399559] hp_cnt[3], pages_in_hp[524288]
> [  192.403690] umem->sgt_append.sgt.nents[1]
> [  192.407905] number entries: [1], pg_bit: [31]
> [  192.411397] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.415601] biter->__sg_advance [665837568] sg_dma_len[3221225472]
> [  192.419823] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.423976] biter->__sg_advance [2813321216] sg_dma_len[3221225472]
> [  192.428243] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.432397] biter->__sg_advance [665837568] sg_dma_len[3221225472]
> 
> Fixes: a808273a495c ("RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks")
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/core/verbs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 26b021f43ba4..11b1c1603aeb 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2957,15 +2957,18 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
>  bool __rdma_block_iter_next(struct ib_block_iter *biter)
>  {
>  	unsigned int block_offset;
> +	unsigned int sg_delta;
>  
>  	if (!biter->__sg_nents || !biter->__sg)
>  		return false;
>  
>  	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
>  	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
> -	biter->__sg_advance += BIT_ULL(biter->__pg_bit) - block_offset;
> +	sg_delta = BIT_ULL(biter->__pg_bit) - block_offset;

This shouldn't be BIT_ULL if sg_delta is unsigned int. It looks like
this hasn't been especially careful about supporting > 4G page sizes

But this looks OK otherwise

Jason
