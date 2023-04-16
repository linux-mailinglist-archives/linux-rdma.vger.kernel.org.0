Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F26E3774
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Apr 2023 12:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjDPKaE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Apr 2023 06:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDPKaD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Apr 2023 06:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337F10D7
        for <linux-rdma@vger.kernel.org>; Sun, 16 Apr 2023 03:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2C6D6117A
        for <linux-rdma@vger.kernel.org>; Sun, 16 Apr 2023 10:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A3CC433EF;
        Sun, 16 Apr 2023 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681641001;
        bh=OWj2ezR74e2vZwiGQGJ/gGszld4xh91D7xh/mO0EAVI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WkL+jGGRECy7+3sJq90llCrUSmDsTMNidIk+sU/93AeskZRK7u90oc3Ss7Tg7L/fC
         Twdu1SsPYm9EzAeQdmLxjfpSWUXFMjzu/oudLX8w/jNI/6RMVt1huL3tuSs+dI9WNW
         WvLJFAzt1euB4AKQXHTbXRCuOQouqh1iwzBbup80jUXlmdjziR+mVPObSd8fVbsAea
         YC/foas7Sl+e4AP2PesHTdvIyv+S5zxBYPjegzuqQDS7TohvaY4KP5dt/9pFw1kydp
         CV3F5wd/N1yVS93+wSAb5v6rHArAQjttSgMRQ9VUTLUCCl2KpRv7dUHImZW99/xjZQ
         RzfOpvtbHgALQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <0-v2-05ea785520ed+10-ib_virt_page_jgg@nvidia.com>
References: <0-v2-05ea785520ed+10-ib_virt_page_jgg@nvidia.com>
Subject: Re: [PATCH v2] RDMA: Add ib_virt_dma_to_page()
Message-Id: <168164099730.148301.9451001441432768414.b4-ty@kernel.org>
Date:   Sun, 16 Apr 2023 13:29:57 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 14 Apr 2023 10:58:29 -0300, Jason Gunthorpe wrote:
> Make it clearer what is going on by adding a function to go back from the
> "virtual" dma_addr to a kva and another to a struct page. This is used in the
> ib_uses_virt_dma() style drivers (siw, rxe, hfi, qib).
> 
> Call them instead of a naked casting and  virt_to_page() when working with dma_addr
> values encoded by the various ib_map functions.
> 
> [...]

Applied, thanks!

[1/1] RDMA: Add ib_virt_dma_to_page()
      https://git.kernel.org/rdma/rdma/c/8d7c7c0eeb7428

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
