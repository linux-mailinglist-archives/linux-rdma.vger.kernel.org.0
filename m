Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9C6CD871
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjC2L22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjC2L22 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 07:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D32109;
        Wed, 29 Mar 2023 04:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CF560C5B;
        Wed, 29 Mar 2023 11:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2C6C433D2;
        Wed, 29 Mar 2023 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680089306;
        bh=lrJxW6LBRPy/CJbOq9d8xUclvtd6lwZLPJY1+hAM29g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Gpi+zPCEA4bIllFgY3PlXRJomnQvj1OLjat7DA6fId7+Y2pUuD5qS8wYL/CnkIGF+
         JMQ+aBo7yVAxg9Y8/kU8YITCtKZU4Y4RyV3PYClKbnACe8P9EylnCzM4NbdzZsntyR
         +ZQsYWYoHY59UdlIfmopZxaCdzQ9DvWqR8+EZd594WKI1XKhoeMAB5HBJ2LaWQKR0I
         apVBzpY+P0a6LM4vMNiF+8ja3DpvHCIoN+aeCgOFmdw++i8zWMz2N47spjmPm8oPov
         bbN4rSRlPatwLn98h0OqhO9QR0AAPmkj7OfVBwb7jYFT2emjKo6gRbzUvRzouECHjw
         fbkKv+vL80PHQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca, nathan@kernel.org,
        ndesaulniers@google.com, mgurtovoy@nvidia.com,
        Tom Rix <trix@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230326120959.1351948-1-trix@redhat.com>
References: <20230326120959.1351948-1-trix@redhat.com>
Subject: Re: [PATCH] RDMA/ocrdma: remove unused discard_cnt variable
Message-Id: <168008930265.1169130.1752490473855395346.b4-ty@kernel.org>
Date:   Wed, 29 Mar 2023 14:28:22 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Sun, 26 Mar 2023 08:09:59 -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:1592:6: error: variable
>   'discard_cnt' set but not used [-Werror,-Wunused-but-set-variable]
>         int discard_cnt = 0;
>             ^
> This variable is not used so remove it.
> 
> [...]

Applied, thanks!

[1/1] RDMA/ocrdma: remove unused discard_cnt variable
      https://git.kernel.org/rdma/rdma/c/cba968e33e5df0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
