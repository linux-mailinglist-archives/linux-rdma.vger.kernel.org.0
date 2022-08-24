Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207C59F90F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiHXMKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiHXMKZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 08:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD43FA31
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 05:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DEA56197C
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 12:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F929C433C1;
        Wed, 24 Aug 2022 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661343022;
        bh=YIEzBLIYlowM68GfETpL/f856/t7HfF01Ow9dyavVwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YH1nPDjg/GlPEq+4utV6iDBgyPKiwLGRAVc1LdPCBgB6PtQ9ROKT8Nc+XPqsyJmKj
         rO8zSni53Y/nxKUPSNXYY4xkTMHqYLWeVEyHIYbKM7CQLu6K/+x5wodB479NygTxxZ
         R4iGDTYF6p+ZFsN1Hj+jZaJlBohqcoMe+19GRjas+JiB9P9HyVKA4uieckY/TzIDye
         facZjUu7I5GImWJ+p43NJGlHf5hELuSYML3RvtskUFOD8axn1rdNK9b5VF2Ixh8Gfr
         D08AiWPOxG9qhVOIWJO4/gRA+9Mkcwwod4etJI1ZZ9kxosQ2GRdHXG7Zr4cheYOA6e
         oEn24l6n/mjLw==
Date:   Wed, 24 Aug 2022 15:10:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 1/2] RDMA/erdma: Introduce internal
 post_send/post_recv for qp drain
Message-ID: <YwYVKt96wBoFasaS@unreal>
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <20220824094251.23190-2-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824094251.23190-2-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 24, 2022 at 05:42:50PM +0800, Cheng Xu wrote:
> For erdma, hardware won't process newly posted send WRs or recv WRs
> after QP state changed to error, and no flush cqes will generated
> for them. So, internal post_send and post_recv functions are introduced
> to prevent the new send WRs or recv WRs.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_main.c  |  4 +-
>  drivers/infiniband/hw/erdma/erdma_qp.c    | 45 ++++++++++++++++++++---
>  drivers/infiniband/hw/erdma/erdma_verbs.h | 17 +++++++--
>  3 files changed, 55 insertions(+), 11 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
