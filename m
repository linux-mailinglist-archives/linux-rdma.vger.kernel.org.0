Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55274E698B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Mar 2022 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbiCXTzR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiCXTzQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 15:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1EA144F
        for <linux-rdma@vger.kernel.org>; Thu, 24 Mar 2022 12:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B5660A73
        for <linux-rdma@vger.kernel.org>; Thu, 24 Mar 2022 19:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844F0C340EC;
        Thu, 24 Mar 2022 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151623;
        bh=OJIxnGAmJO6RrIIm6r84SCUG2856gepIo3RB4rmXcvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESc0FeXE9m+AtBAiufVhFoVQ0x4LaUAZN548jas6qzfmvz/S2shwnT++FK5kpK8zc
         +kcni24Nx2fCK0ZqEoI2HNceFYn+mEOqZ+JsksTI42cXJ0VK6uolVKR6QKPmfEbOFS
         3SoZ6QAZxUIGAdeWISBSV2W71nTWayn59H2sc3akbmuPEZpApa2sMknApajhx3OBGY
         zVksDa0d2T/Nql7QEEGFJFe5ioLKcUcnMhcPhtk7mTSAWmUZiEnFUW+h6YTBr2FBK/
         n4rarD455O9ONW67Gr7QnHKu2lYJL8pJLXuRqM9VYtbdWf7RAv8NOmSbRHfL9twj+O
         bXOV+SSLzBFQA==
Date:   Thu, 24 Mar 2022 21:53:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH 1/1] RDMA/irdma: Remove the redundant variable
Message-ID: <YjzMQoYoUxqlP8Zw@unreal>
References: <20220323230135.291813-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323230135.291813-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 23, 2022 at 07:01:35PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the function irdma_puda_get_next_send_wqe, the variable wqe
> is not necessary. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/puda.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
