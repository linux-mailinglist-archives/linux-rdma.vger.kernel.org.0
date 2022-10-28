Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9B461174D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJ1QQB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJ1QPj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:15:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F465D3
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3167B82AE4
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 16:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31257C433C1;
        Fri, 28 Oct 2022 16:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973665;
        bh=+KPsLB3iN9xO7WWFOsXxisHxkSo+wz0b1atqZzN9WtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plL3lJUcX1yfKm8LvD0eWkNmj348v5LEddRRo1x9WXZnFlfDTJHmtmCfODletBn58
         fm/fKffY2KrTiyxUwrJ+svin8WE1fDeWSxkdA3la/ahPXOyS/n/1liAFSMmaVMrkwk
         qej4y+5v+NzHaYXzzePP+H15NAT4rdSLSGsb8kmQ4FQ6KB70g2zAEOT+LXtngJ2m79
         idbS+A0qv7quIxhCj+dnM+Uj47FiqH4iY+Io2G/aF96rAnKmH7Sfz0pKklGu10DVSs
         6ZX3q0AYaQdLHNHhmfnJYdtjXxs4tPWFaRu4dNRc7q9/2zfkTIDNhoJXWyMWmZihaE
         OTXLq95wveeeg==
Date:   Fri, 28 Oct 2022 19:14:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Fix section mismatch warning for
 nldev
Message-ID: <Y1v/2ArL1wyaoB8S@unreal>
References: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
 <Y1v8m0HliWscL6bT@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1v8m0HliWscL6bT@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 01:00:27PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 28, 2022 at 09:58:56AM +0300, Leon Romanovsky wrote:
> > ppc64_defconfig) produced this warning:
> > 
> > WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)
> > 
> > Fix it by removing __init/__exit markers as nldev is part of ib_core.ko
> > and as such doesn't require any special notations for entry/exit functions.
> 
> This isn't what the problem is, the patch Stephen reported:
> 
> commit ad9394a3da33995dff828dbfd4540421e535bec9 (ko-rdma/for-rc)
> Author: Chen Zhongjin <chenzhongjin@huawei.com>
> Date:   Tue Oct 25 10:41:46 2022 +0800
> 
>     RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
> 
> Adds a call to an __exit function from an __init function:
> 
> @@ -2815,10 +2815,18 @@ static int __init ib_core_init(void)
> 
> +err_parent:
> +       rdma_nl_unregister(RDMA_NL_LS);
> +       nldev_exit();
> +       unregister_pernet_device(&rdma_dev_net_ops);
> 
> Which is not allowed
> 
> All that is required is to drop the __exit from nldev_exit, 

This is why I dropped both __exit and __init. I see no value in keeping
__init, without __exit.

Thanks
