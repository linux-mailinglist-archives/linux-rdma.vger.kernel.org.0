Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEB4CC477
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Mar 2022 18:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiCCR6k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 12:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbiCCR6d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 12:58:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3D13FACD
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 09:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFC54B81DB8
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 17:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A389C004E1;
        Thu,  3 Mar 2022 17:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646330264;
        bh=GZcaW3E6qkKs6TvPfRY9r5Tyebq4uHnluHy+tR1Fkhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOw7sHoe/B5n+wymCvASYEoewVWL8I9f1ngLDkLcwHce0xfpNopDi60JSMqoYy97w
         bSIUJbFC1ItnM7L9liuP2K9r1T1PN1J8U8+vK/8cF0TszLSt3CJGRWHWV52JjU+OPa
         pY1kTPBUKczcVzuNG8GixOIn3SnXCLksKsnkVqRJul1OZPWrdFOQX0+vG/GFKPXWAA
         MMoSVnycYkUunt3EPokdyAfcIIDPHtS/vz/6cl27R9qebZypqId1K1ek3vwQ1OLT/U
         tGtOqrLR/0QlwJDZGNCOidyA80USWSuNgOJtoKeBEhWzEixjDAkzTCqr2wne4lgZ5S
         cgVhcRZZmhGeg==
Date:   Thu, 3 Mar 2022 19:57:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Use the reserved loopback QPs to free
 MR before destroying MPT
Message-ID: <YiEBlG5ndcbww8u2@unreal>
References: <20220225095654.24684-1-liangwenpeng@huawei.com>
 <Yhy5fZrsp79HZKR+@unreal>
 <0c14fac1-9448-7920-52fd-f353a8e7590f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c14fac1-9448-7920-52fd-f353a8e7590f@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 02, 2022 at 08:44:48PM +0800, Wenpeng Liang wrote:
> On 2022/2/28 20:01, Leon Romanovsky wrote:
> > On Fri, Feb 25, 2022 at 05:56:54PM +0800, Wenpeng Liang wrote:
> >> From: Yixing Liu <liuyixing1@huawei.com>
> >>
> >> Before destroying MPT, the reserved loopback QPs send loopback IOs (one
> >> write operation per SL). Completing these loopback IOs represents that
> >> there isn't any outstanding request in MPT, then it's safe to destroy MPT.
> >>
> >> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> >> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 334 +++++++++++++++++++-
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 ++
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   6 +-
> >>  4 files changed, 358 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> index 1e0bae136997..da0b4b310aab 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> @@ -624,6 +624,7 @@ struct hns_roce_qp {
> >>  	u32			next_sge;
> >>  	enum ib_mtu		path_mtu;
> >>  	u32			max_inline_data;
> >> +	u8			free_mr_en;
> >>  
> >>  	/* 0: flush needed, 1: unneeded */
> >>  	unsigned long		flush_flag;
> >> @@ -882,6 +883,7 @@ struct hns_roce_hw {
> >>  			 enum ib_qp_state new_state);
> >>  	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
> >>  			 struct hns_roce_qp *hr_qp);
> >> +	void (*dereg_mr)(struct hns_roce_dev *hr_dev);
> >>  	int (*init_eq)(struct hns_roce_dev *hr_dev);
> >>  	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
> >>  	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index b33e948fd060..62ee9c0bba74 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -2664,6 +2664,217 @@ static void free_dip_list(struct hns_roce_dev *hr_dev)
> >>  	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
> >>  }
> >>  
> >> +static int free_mr_alloc_pd(struct hns_roce_dev *hr_dev,
> >> +			    struct hns_roce_v2_free_mr *free_mr)
> >> +{
> > 
> > You chose very non-intuitive name "free_mr...", but I don't have anything
> > concrete to suggest.
> > 
> 
> Thank you for your advice. There are two alternative names for this event,
> which are DRAIN_RESIDUAL_WR or DRAIN_WR. It is hard to decide which one is
> better. Could you give me some suggestions for the naming?

mlx5 called to such objects device resource - devr, see mlx5_ib_dev_res_init().
I personally would create something similar to that, one function
without separation to multiple free_mr_alloc_* functions.

Up-to you.

Thanks
