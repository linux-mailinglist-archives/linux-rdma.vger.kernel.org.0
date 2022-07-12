Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FFF571634
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGLJzG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 05:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGLJzF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 05:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE86AA753
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 02:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8399A61789
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 09:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCF0C3411C;
        Tue, 12 Jul 2022 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657619702;
        bh=UlYrlgXJZT7HuSFDnxQEr1Hz+7LHLJ3wMTciiZeaHrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LypSWR+BJq3oe578LuZloYKJmMn0KQMTeGBwD2WoVFI2mS/6R/RjrO56AUg5hwuNL
         ynShjdsM5egcVVRAT+juwQ+X2udQMyyZRKDUGx4RkKkBiGpm6leV6jsZBNjG8XoH0A
         U94cYFbC2gSLwpY1v2HSstL/EWYAiX0M4D0Se5iWDmvfM0RShIOO/CNtyL8P+hEsRg
         dnQ28jfmjz0VDCywY6kFDqZ4u1gqq+cvH1ETQI89rdFssGRpQOpUYGMaHbdo/xAG13
         WcNoC8TIw39o53y0D5esW4Zv43N0HhyD6p8WM+VkfjAnRg7xVUt0JfehuplCJYgu5y
         fvsiKK28wVwbw==
Date:   Tue, 12 Jul 2022 12:54:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@nvidia.com, Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hfi1: Depend on !UML
Message-ID: <Ys1E8fxDpXwl1bMk@unreal>
References: <165755127879.2996325.5668395672492732376.stgit@awfm-02.cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165755127879.2996325.5668395672492732376.stgit@awfm-02.cornelisnetworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 11, 2022 at 10:54:38AM -0400, Dennis Dalessandro wrote:
> From: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
> 
> Both hfi1 and UML depend on x86_64, this can trigger build errors.
> This driver must depends on !UML because it accesses x86_64
> features that are not supported by UML.
> 
> Signed-off-by: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)a

But why is this hfi1 specific change?
Shouldn't CONFIG_UML be disabled if someone choses !x86_64?

Thanks

> 
> diff --git a/drivers/infiniband/hw/hfi1/Kconfig b/drivers/infiniband/hw/hfi1/Kconfig
> index 6eb739052121..14b92e12bf29 100644
> --- a/drivers/infiniband/hw/hfi1/Kconfig
> +++ b/drivers/infiniband/hw/hfi1/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config INFINIBAND_HFI1
>  	tristate "Cornelis OPX Gen1 support"
> -	depends on X86_64 && INFINIBAND_RDMAVT && I2C
> +	depends on X86_64 && INFINIBAND_RDMAVT && I2C && !UML
>  	select MMU_NOTIFIER
>  	select CRC32
>  	select I2C_ALGOBIT
> 
> 
