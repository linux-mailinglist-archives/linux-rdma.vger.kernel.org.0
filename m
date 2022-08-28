Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B262D5A3D5D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 13:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiH1L3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 07:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiH1L3g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 07:29:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A8356CF;
        Sun, 28 Aug 2022 04:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF2A5B80A4D;
        Sun, 28 Aug 2022 11:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BC7C433D6;
        Sun, 28 Aug 2022 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661686173;
        bh=PCobnhAmzI6CGWoCBind+iKZ7jdQQvQJAHdLjZFumHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4eEvRYesIRLcRqPP7aYtoK+ql38fNh5g2SJBiPywsKIQXKYfStV3mTQ7n/Xxf63+
         kluu1/rALpCW3Y8pAU2jRR9ylUwXxd/yEtkVzglRQyK/SG2OlrtDB1rlRfOqawryG+
         S+4Q6vogoxHVXglfkEgavqz3V1TIu+RKyQgrI18mImjzBruX+3kU1gUP3KzcP7lC+l
         /xFbxKUimG60vTU8ExOq/e55weCqNefq730G/oBrPVdAy2RNHMkV1p/1nt0dVdF6+3
         F12t1MT2PY7WVE/v8HJY14vZujjsmal+hKQeqFZhY4zAKde92SBcxo2NduFkNClAoZ
         1xKqmXVZeoRAw==
Date:   Sun, 28 Aug 2022 14:29:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: remove 'device' argument from rdma_build_skb()
Message-ID: <YwtRmftTsXE1rLFz@unreal>
References: <20220826143215.18111-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826143215.18111-1-linyunsheng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 10:32:15PM +0800, Yunsheng Lin wrote:
> 'device' argument is never used since rdma_build_skb()
> is introduced, so remove it.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  drivers/infiniband/core/lag.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Thanks, applied.
