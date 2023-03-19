Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1046C0066
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 10:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCSJh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCSJh1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 05:37:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740F1D906
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 02:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC142B8074C
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 09:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397F7C433EF;
        Sun, 19 Mar 2023 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679218637;
        bh=lOVlkhXGc5lL4Z5Hw2ixFsq8ybPXJ5Acc9HeV94Wpc8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RUhKgC6bfg9zWHx2qS4WaZB1aJG27suMLONHPVvuRk5Js04Q4v0/QkjW0WAKoDS/t
         IugSZGK1pmVJM7YVfAqGxM0SdBLV64C3sttH5rqAjWmvqrbpnJr1+htGBeCrLZU3A+
         K21U8NAZ9TB82agXHJGy1q2h5y+uqqpRj+RzmaObGyuc1bvzUlXctg70r3sO4knTFC
         eai1szU5cBsI3hr+fJKZMhti2yMUEnh8KDSSklwUuBGH3NfG0HEskLZtqVXztI+zqo
         EU2cVLih4kSaAEyiHwiYG6o7zeukSEbjLbPQQRb79TKYJNjd487w++CBRXJlTXkXUD
         wYbir7ym7R/Kw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230315145305.955-1-shiraz.saleem@intel.com>
References: <20230315145305.955-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 0/4] irdma -next updates
Message-Id: <167921863320.822580.18083496146139489244.b4-ty@kernel.org>
Date:   Sun, 19 Mar 2023 11:37:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 15 Mar 2023 09:53:01 -0500, Shiraz Saleem wrote:
> This series adds a refactor/improvement to the statistics
> infrastructure of irdma. And minor updates to IRQ naming,
> PBLE function arguments, and removes a redundant call in
> irdma_modify_qp_roce.
> 
> Krzysztof Czurylo (1):
>   RDMA/irdma: Refactor HW statistics
> 
> [...]

Applied, thanks!

[1/4] RDMA/irdma: Refactor HW statistics
      https://git.kernel.org/rdma/rdma/c/5a711e580704ac
[2/4] RDMA/irdma: Remove a redundant irdma_arp_table() call
      https://git.kernel.org/rdma/rdma/c/0219ad5d3afbb5
[3/4] RDMA/irdma: change name of interrupts
      https://git.kernel.org/rdma/rdma/c/99f96b4552330d
[4/4] RDMA/irdma: Refactor PBLE functions
      https://git.kernel.org/rdma/rdma/c/cc8997c94bf370

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
