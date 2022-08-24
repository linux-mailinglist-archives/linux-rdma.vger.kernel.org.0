Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45FE59F91B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiHXMKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 08:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiHXMKl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 08:10:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB7459B4
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 05:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FE26B8239E
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 12:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF30C433D6;
        Wed, 24 Aug 2022 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661343034;
        bh=WqTLAnCxZ/ivyrEOv9cE5ywKaDL9SdxI8KG6By10xls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mksA4co0IlniG1sbOlqu3x6Zya6vanRJkciG02jONDhlxHNqMFfBjWt15td8zJOFU
         bXT+V6b6nYP5NEcEo/iMlm2CO0hnX0vk1Aoi8DSRaD2k8SkBrnoeWGD74G3Gm1LNE5
         FJTqkrtTr96xgf1fFJ66hJuJxZ0Y8hqLg5np9+rB9kCPR32no7YJ27pk+JW5ktpL21
         IBRiS7F/CZnR7H7ebs+FKZku0Q5VKXEkAIzA22A3sKBFjDAnpe48ny9i1fb9t/Pixv
         nSpZF3zFI9rcOxBAqrzN1t8zQBB71ZykIaWSpX+WyBud4rUeX2n3m5KA4Yzfj2nKtV
         zh+KXFF7s8rCA==
Date:   Wed, 24 Aug 2022 15:10:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 2/2] RDMA/erdma: Add drain_sq and drain_rq
 support
Message-ID: <YwYVNsKgkQWG1xLc@unreal>
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <20220824094251.23190-3-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824094251.23190-3-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 24, 2022 at 05:42:51PM +0800, Cheng Xu wrote:
> For erdma, hardware won't process any WRs after modifying QP state to
> error, so the default __ib_drain_sq and __ib_drain_rq can not work for
> erdma device. Here, we introduce custom implementation of drain_sq and
> drain_rq interface to fit erdma hardware.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_qp.c    | 71 +++++++++++++++++++++++
>  drivers/infiniband/hw/erdma/erdma_verbs.h | 10 ++++
>  2 files changed, 81 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
