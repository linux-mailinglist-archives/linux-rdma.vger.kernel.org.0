Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7F572E96
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jul 2022 08:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiGMG5c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jul 2022 02:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiGMG5c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jul 2022 02:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9755A2
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 23:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295AE60AFC
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jul 2022 06:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B4AC34114;
        Wed, 13 Jul 2022 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657695450;
        bh=ax4UO6wH46U+sLGp1El5mPPZoPuiM27wxrm4RqBpI28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jg9jfRjw4zxjVxoN4aID1CR9xAVDVpVfuwpmWoDT98DtEzc13vl93yBNGiwrITqeV
         OGGEXl2OYM9f/5ZMhxFGqKxChPCo/wAC3oIGPwSPJCpj00mkeuOdfZ9POeQtojFh77
         W1Z++v+LN2wMlpMNsmcqOS0DeMdSbtUkTGevz+Z7oBTKsIGwHrecxFzHpY31i4npDP
         uOEu6mAz/z/vWMGf5pIcGwJL+Z0KsHCngf9SijbgVhRgEskzSWqLICrQifSUoPOksT
         F1IH4YcQb8mjbjeMrSUXcJnY2zUTNgAW8Hmp+SCEtpuBkIUh2hlLrQjGttDjAyfA9b
         8Va4VNYqqmKug==
Date:   Wed, 13 Jul 2022 09:57:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@nvidia.com, Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hfi1: Depend on !UML
Message-ID: <Ys5s1bIXRomxNg5d@unreal>
References: <165755127879.2996325.5668395672492732376.stgit@awfm-02.cornelisnetworks.com>
 <Ys1E8fxDpXwl1bMk@unreal>
 <b1edc535-ee1c-13f2-df2c-5980261c84fe@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1edc535-ee1c-13f2-df2c-5980261c84fe@cornelisnetworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 12, 2022 at 08:33:17AM -0400, Dennis Dalessandro wrote:
> On 7/12/22 5:54 AM, Leon Romanovsky wrote:
> > On Mon, Jul 11, 2022 at 10:54:38AM -0400, Dennis Dalessandro wrote:
> >> From: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
> >>
> >> Both hfi1 and UML depend on x86_64, this can trigger build errors.
> >> This driver must depends on !UML because it accesses x86_64
> >> features that are not supported by UML.
> >>
> >> Signed-off-by: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
> >> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> >> ---
> >>  drivers/infiniband/hw/hfi1/Kconfig |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)a
> > 
> > But why is this hfi1 specific change?
> > Shouldn't CONFIG_UML be disabled if someone choses !x86_64?
> 
> This was discussed in [1]. Perhaps there is further work from UML folks
> warranted. However there really isn't any reason to try to compile a HW driver
> like hfi1 for UML and this will silence build warnings.

I don't like this solution, but ok.

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
