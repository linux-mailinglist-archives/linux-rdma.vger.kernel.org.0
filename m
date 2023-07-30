Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665DC76854F
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jul 2023 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjG3Mo1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3Mo0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 08:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFE173F
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 05:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A8360BB8
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 12:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A201C433C7;
        Sun, 30 Jul 2023 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690721064;
        bh=lkSrWWeyrfmgnqTFTLbVNfKVLJ/Te3wjKd6RBHSgPuQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S3J28UKJ8QRNXrJesPWON58yn/1ijScd+dFVzju6HNHYV4Y+UtFPleORPQyHKzixf
         oRDSULxaHfuBCRWf2wm1FUvOtj/WKeMwm0wF3EcIPof3Br6/qrjl5Y7ntGQIBPMxB9
         ZwIviZ365gy/vbmE7+EZyBQl1kiod3GLjyWzuEYDmOCvi1+jFpXl6bdCkxJhy6HX9/
         ekkI/lAwM3gfX0S41kIRxeYFJJpGbfMqRdsQflzD7tt5jROTIJMxq45nqXXdlZz9uw
         wibWGlR33Hyf5a+SuLHFaxKwFat/uHOPTWdbJ+LDaTBSxUFMXhvTEOLwkYg9wl8ib6
         yciHM8nHuXimw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230725155525.1081-1-shiraz.saleem@intel.com>
References: <20230725155525.1081-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 0/2] RDMA/irdma: Use coherent user/kernel queue size
Message-Id: <169072106057.307103.1525596967175240768.b4-ty@kernel.org>
Date:   Sun, 30 Jul 2023 15:44:20 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 25 Jul 2023 10:55:23 -0500, Shiraz Saleem wrote:
> This series extends ABI to allow user QPs max send/recv WR to be
> retrievable in driver and pass generation specific min WQ size to
> user-space.
> 
> Sindhu Devale (2):
>   RDMA/irdma: Allow accurate reporting on QP max send/recv WR
>   RDMA/irdma: Use HW specific minimum WQ size
> 
> [...]

Applied, thanks!

[1/2] RDMA/irdma: Allow accurate reporting on QP max send/recv WR
      https://git.kernel.org/rdma/rdma/c/3a849872045017
[2/2] RDMA/irdma: Use HW specific minimum WQ size
      https://git.kernel.org/rdma/rdma/c/72d422c2465e93

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
