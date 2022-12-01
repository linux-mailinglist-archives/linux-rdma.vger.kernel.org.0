Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8FF63EC50
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiLAJWR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 04:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLAJWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 04:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE788C453;
        Thu,  1 Dec 2022 01:22:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0567AB81E62;
        Thu,  1 Dec 2022 09:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C89C433D7;
        Thu,  1 Dec 2022 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669886528;
        bh=/YadyfgemSRHO9+7Uo4Gf+Xn86JmQFwcdEvy7RUitZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Drfuwxdv5m4E7Px5rg9iKHJEemwE2KPax8QGb7FkJEigL47BELovgknedwsxGOvpj
         mKPyDkMDu8pNnFDMMBfmKMEXKld6AkE7P/AghkLLd2tdaApusq7uZlKLnBfMKzY2UD
         tezcYIkLyIMZzXnmu/bamy8bU5nqHxFlWjtBKlHYtzDwHVtAOJyfEFbBPrxlrdIrpj
         f4siW+XAdhSVj79lA99O2vH1/fbvtI97oWLp/cUvAuTNpFf3sUW65S7clxbjyB8XBc
         V27IoFna46w+cCRJmUOuMvdb3KZMmqfaZePQlduzAsnOeUY7RztR2yDg/JGunMKklT
         SxDIt0qyEv9Qw==
Date:   Thu, 1 Dec 2022 11:22:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4hyPPzyQiI3i9jh@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221130200945.24459-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 30, 2022 at 12:09:45PM -0800, Randy Dunlap wrote:
> When building qib_wc_x86_64.c on ARCH=um, references to some cpuinfo
> fields cause build errors since cpuinfo does not contain x86-specific
> fields.
> 
> Fix the build errors by making this driver depend on !UML.
> 
> Prevents these build errors:
> 
> ../drivers/infiniband/hw/qib/qib_wc_x86_64.c: In function ‘qib_unordered_wc’:
> ../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:29: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
>   149 |         return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
> ../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:44: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
>   149 |         return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
> ../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:44: note: each undeclared identifier is reported only once for each function it appears in
> ../drivers/infiniband/hw/qib/qib_wc_x86_64.c:150:1: error: control reaches end of non-void function [-Werror=return-type]
>   150 | }
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
>  drivers/infiniband/hw/qib/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/infiniband/hw/qib/Kconfig b/drivers/infiniband/hw/qib/Kconfig
> --- a/drivers/infiniband/hw/qib/Kconfig
> +++ b/drivers/infiniband/hw/qib/Kconfig
> @@ -3,6 +3,7 @@ config INFINIBAND_QIB
>  	tristate "Intel PCIe HCA support"
>  	depends on 64BIT && INFINIBAND_RDMAVT
>  	depends on PCI
> +	depends on !UML

I would advocate to add this line to whole drivers/infiniband.
None of RDMA code makes sense for UML.

Thanks

>  	help
>  	This is a low-level driver for Intel PCIe QLE InfiniBand host
>  	channel adapters.  This driver does not support the Intel

