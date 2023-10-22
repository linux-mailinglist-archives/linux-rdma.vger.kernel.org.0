Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF47D21A3
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Oct 2023 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjJVHcm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVHcl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 03:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9FC2
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 00:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EFEC433C7;
        Sun, 22 Oct 2023 07:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697959959;
        bh=fHG4TaMUd7HGuQQYQrNguovNk6O76d5irTKRQs97D9c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LFdy/Hb2XmwN9zLKA+ALFGtWIzbshRB3gZkeBWgs9/Ja7kho1WVnyMUMHKIGXt5ui
         k02p/mIT0hcUgXDwXfi2+ZxNZdFm2pWgUDU1Zao6+04aJxz1DnFEOiSvfWSslJFBbo
         ZyvOLiaekukVGEqvWmwClqHR7pL6VtPOvzS/EQ6ic9or+vjQ7I1V3W2R7EWgEqhiFj
         ptXY2DjBxa72anz3uYYmrAP87A0gseXbaM5j3ika7IS+8fX3AdN2GepfGW2T7wz58N
         8gLN6xcutMHwpJaVOQqMeiLgwDw/1LYJ6cnBE/L5/xhHIOnjok4kUV24bODmcuJCF+
         fQ+BqNze7nUgg==
From:   Leon Romanovsky <leon@kernel.org>
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca,
        Nathan Chancellor <nathan@kernel.org>
Cc:     ndesaulniers@google.com, trix@redhat.com,
        chandramohan.akula@broadcom.com, linux-rdma@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
In-Reply-To: <20231020-bnxt_re-implicit-fallthrough-v1-1-b5c19534a6c9@kernel.org>
References: <20231020-bnxt_re-implicit-fallthrough-v1-1-b5c19534a6c9@kernel.org>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix clang -Wimplicit-fallthrough in
 bnxt_re_handle_cq_async_error()
Message-Id: <169795995500.45770.3213574948546186734.b4-ty@kernel.org>
Date:   Sun, 22 Oct 2023 10:32:35 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 20 Oct 2023 15:17:02 -0700, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y):
> 
>   drivers/infiniband/hw/bnxt_re/main.c:1114:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>    1114 |         default:
>         |         ^
>   drivers/infiniband/hw/bnxt_re/main.c:1114:2: note: insert 'break;' to avoid fall-through
>    1114 |         default:
>         |         ^
>         |         break;
>   1 error generated.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix clang -Wimplicit-fallthrough in bnxt_re_handle_cq_async_error()
      https://git.kernel.org/rdma/rdma/c/9040c0d96fd66e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
