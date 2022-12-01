Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C376263EC5B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 10:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAJYG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 04:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLAJXr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 04:23:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC111A0C;
        Thu,  1 Dec 2022 01:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E16CB81E7C;
        Thu,  1 Dec 2022 09:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FC4C433D7;
        Thu,  1 Dec 2022 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669886559;
        bh=EbQEoSBkP4rq4nn7K1JqrZiC11qeUR4OKMOBmxo+YsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBnQ+JpnHiKrLR4z5/n48+eyUysKLHUFm7o0Z+Axi7KExPgLunVQtxraqEUfqJMXi
         iv0ygBuculcBlEAvw2RZLNVX0kDcwYcoBtEArun/pdfGOxiXwpmvz2m2vuWOr0XLSo
         /OXiCAxjIIGfsTXkoc52W8jnJ8vftiPGlIb8FLKrel9K2C0qp4/HVYk/1kNgiWSg7w
         bXl+fzrKnVbYl8rKHoZ9BHgwax6TKREJzTQ9kWVMRgnKMkXBHrVrwzODKL3QoRUBWk
         yDfuHKtBidWAxCRPfUISLLNQOcSDpVVj4w4fRSs/ivWW6RWmWpRRNCkyQQEoxuk11M
         J1OeSaqpS/JVw==
Date:   Thu, 1 Dec 2022 11:22:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 2/2] IB/rdmavt: don't use rdmavt for UML
Message-ID: <Y4hyW6mVer6kk1VX@unreal>
References: <20221130200958.25305-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130200958.25305-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 30, 2022 at 12:09:58PM -0800, Randy Dunlap wrote:
> When building rdmavt for ARCH=um, qp.c has a build error on a reference
> to the x86-specific cpuinfo field 'x86_cache_size'.
> 
> Fix the build errors by making this driver depend on !UML.
> 
> Prevents these build errors:
> 
> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
> ../drivers/infiniband/sw/rdmavt/qp.c:88:29: error: ‘struct cpuinfo_um’ has no member named ‘x86_cache_size’
>    88 |         return boot_cpu_data.x86_cache_size;
> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘cacheless_memcpy’:
> ../drivers/infiniband/sw/rdmavt/qp.c:100:9: error: implicit declaration of function ‘__copy_user_nocache’; did you mean ‘copy_user_page’? [-Werror=implicit-function-declaration]
>   100 |         __copy_user_nocache(dst, (void __user *)src, n, 0);
> ../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
> ../drivers/infiniband/sw/rdmavt/qp.c:89:1: error: control reaches end of non-void function [-Werror=return-type]
>    89 | }
> 
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> ---
> v2: rebase & resend
> 
>  drivers/infiniband/sw/rdmavt/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
> --- a/drivers/infiniband/sw/rdmavt/Kconfig
> +++ b/drivers/infiniband/sw/rdmavt/Kconfig
> @@ -2,7 +2,7 @@
>  config INFINIBAND_RDMAVT
>  	tristate "RDMA verbs transport library"
>  	depends on INFINIBAND_VIRT_DMA
> -	depends on X86_64
> +	depends on X86_64 && !UML

Same comment as for patch #1.

>  	depends on PCI
>  	help
>  	This is a common software verbs provider for RDMA networks.
