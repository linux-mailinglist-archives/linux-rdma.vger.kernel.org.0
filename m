Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F13A7635D9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjGZMGt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZMGt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 08:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E59E0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 05:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EAD161AA8
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 12:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15378C433C8;
        Wed, 26 Jul 2023 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690373207;
        bh=aFEKi2HMmplO0l6X2YJEiDP6sW9qjG1MxnLWPOAVylA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=imf5Dno9gXWO5qVTpYWWiJjbTMsrjqFGXVws67NVx8NouBBDf8IpoYi2SsGE0qxEY
         nuTZ5tihawezkRpWpdbPS7WvZCkkJp/7IG3tpBi6TE0gY9NqMsMoFn8fcTtJZp401v
         ewa3+BaTdPq/GR+2NHaUOh2bdot05XtGJFqUjEbCXISdjPOCZV9F0oLR1e8Hf3JxTI
         21dLlLz6kynz0Ii2KX4zFBWAhboQRgqkZSmVecOQx4bF/1ZeHLE8Zna2aImZJy4Yvc
         8XhRe03HSIHNjGClkcGTXIamLogx8JXqCPj/Cti4XxjteVMcFES9XBDuFs5dH3oMfd
         sk7xI/I9wy1IA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230725155505.1069-1-shiraz.saleem@intel.com>
References: <20230725155505.1069-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 0/4] irdma: Misc cleanup
Message-Id: <169037320297.1732901.1172203480574731086.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 15:06:42 +0300
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


On Tue, 25 Jul 2023 10:55:01 -0500, Shiraz Saleem wrote:
> This series contains miscellaneous clean up patches and
> update to how CQ lookup is done during AE events.
> 
> Krzysztof Czurylo (1):
>   RDMA/irdma: Add table based lookup for CQ pointer during an event
> 
> Mustafa Ismail (1):
>   RDMA/irdma: Cleanup and rename irdma_netdev_vlan_ipv6()
> 
> [...]

Applied, thanks!

[1/4] RDMA/irdma: Drop a local in irdma_sc_get_next_aeqe
      https://git.kernel.org/rdma/rdma/c/8cfc99dada35b8
[2/4] RDMA/irdma: Refactor error handling in create CQP
      https://git.kernel.org/rdma/rdma/c/133b1cba46c6c8
[3/4] RDMA/irdma: Add table based lookup for CQ pointer during an event
      https://git.kernel.org/rdma/rdma/c/e49bad785e550f
[4/4] RDMA/irdma: Cleanup and rename irdma_netdev_vlan_ipv6()
      https://git.kernel.org/rdma/rdma/c/693e1cdebb50d2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
