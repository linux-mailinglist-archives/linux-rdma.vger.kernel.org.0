Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398BE76857E
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jul 2023 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjG3NSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 09:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjG3NSk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 09:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0789124
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 06:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FBBF60BF0
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 13:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5F0C433C7;
        Sun, 30 Jul 2023 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690723118;
        bh=lH7lMsbDNRfLEAWqj2vN6ftG+Ubzc8gO7KsZICt0CV4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BpK4ewdh1xSl626KOUNS0trZpY+keo9uUYXniv6EHXaXq8rfICzgSIZpa1sa97VrQ
         lNWN/zgrMHnxLmSIWcevSZG0wPdTAXkEUriPOV2Ta/Tb9P2aRInJombhos7+M5V7jh
         smeqwdRadDKy8lIfA+uHrJh8YYxlu5xHxuXv1aNwZVMHjNl/vax568GS16owPo/+DX
         x0NVeSNN1y/he3qWoBIUqJE9BTGNlFw0+K447V9tCsxyqvHDoAp+80Wt7HgOKnEyFC
         haA/xEaB2wtuDy8UR0e0w4Tm6fQIDzAJG4/LfIcIVAhtFIns6LY2QdscKIOd+45fA+
         6J0B8M6S3HDPQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, guoqing.jiang@linux.dev,
        Bernard Metzler <bmt@zurich.ibm.com>
Cc:     jgg@ziepe.ca
In-Reply-To: <20230728114418.124328-1-bmt@zurich.ibm.com>
References: <20230728114418.124328-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Fix tx thread initialization.
Message-Id: <169072311460.417463.6809259393346707343.b4-ty@kernel.org>
Date:   Sun, 30 Jul 2023 16:18:34 +0300
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


On Fri, 28 Jul 2023 13:44:18 +0200, Bernard Metzler wrote:
> Immediately removing the siw module after insertion may
> crash in siw_stop_tx_thread(), if the according thread did
> not yet had a chance to initialize its wait queue and
> siw_stop_tx_thread() tries to wakeup that thread. Initializing
> the threads state before spwaning it fixes it.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: Fix tx thread initialization.
      https://git.kernel.org/rdma/rdma/c/5a752f23f43a67

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
