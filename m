Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F73641D31
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Dec 2022 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLDNWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Dec 2022 08:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDNWH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Dec 2022 08:22:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF4175B3;
        Sun,  4 Dec 2022 05:22:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B1C160DEB;
        Sun,  4 Dec 2022 13:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B45C433D6;
        Sun,  4 Dec 2022 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670160123;
        bh=/N4+1ICTq4Tnoftodb+i7fsD1R/4aMkMhsB2THYI6d4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTAOHpmKu5V1ZB3eUCqaBq7rVAEbxd+dr3k0cJ8pp9eU57ovrJPpnMQ1dk0/JCBi7
         sPWz5mdX/g9FbtC+Fxslg9dttAi1Xl7wCDcd9JEmcs9XRIvMIsiEQ7DOHN+XWa23If
         MDHCW39VeWfw88R3YiHVR29F9NIqnu12fqRbP/b3392+w87qxembDatMRzqTr+sctJ
         ZHJZ7kXkfQ8n7Li/gZC0RBtoBrllDLkYtd7u1DAyOIPdNOUYUUVgYBxJBz4/XtKh8+
         DbC1NNP2wdu3Ps0qgV7WO8vuKT6gBRfj9U/q2P9+qwG0TO5JREX1YJrXv/zLHjmC/k
         DevFwms+FRPWg==
Date:   Sun, 4 Dec 2022 15:21:53 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v2] infiniband: disable IB HW for UML
Message-ID: <Y4ye8YOWk0V/BqKL@unreal>
References: <20221202211940.29111-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202211940.29111-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 02, 2022 at 01:19:40PM -0800, Randy Dunlap wrote:
> Disable all of drivers/infiniband/hw/ for UML builds until someone
> needs it and provides patches to support it.
> 
> This prevents build errors in hw/qib/qib_wc_x86_64.c.
> 
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-rdma@vger.kernel.org
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> ---
> v2: just disable infiniband/hw/, not all of infiniband.
> 
>  drivers/infiniband/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)

I added rdmavt to the mix and applied.
https://lore.kernel.org/linux-rdma/20221130200958.25305-1-rdunlap@infradead.org/

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 6ee97c898231..a5827d11e934 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -95,8 +95,8 @@ source "drivers/infiniband/hw/qedr/Kconfig"
 source "drivers/infiniband/hw/qib/Kconfig"
 source "drivers/infiniband/hw/usnic/Kconfig"
 source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
-endif # !UML
 source "drivers/infiniband/sw/rdmavt/Kconfig"
+endif # !UML
 source "drivers/infiniband/sw/rxe/Kconfig"
 source "drivers/infiniband/sw/siw/Kconfig"
 endif
(END)




> 
> diff -- a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -78,6 +78,7 @@ config INFINIBAND_VIRT_DMA
>  	def_bool !HIGHMEM
>  
>  if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
> +if !UML
>  source "drivers/infiniband/hw/bnxt_re/Kconfig"
>  source "drivers/infiniband/hw/cxgb4/Kconfig"
>  source "drivers/infiniband/hw/efa/Kconfig"
> @@ -94,6 +95,7 @@ source "drivers/infiniband/hw/qedr/Kconf
>  source "drivers/infiniband/hw/qib/Kconfig"
>  source "drivers/infiniband/hw/usnic/Kconfig"
>  source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
> +endif # !UML
>  source "drivers/infiniband/sw/rdmavt/Kconfig"
>  source "drivers/infiniband/sw/rxe/Kconfig"
>  source "drivers/infiniband/sw/siw/Kconfig"
