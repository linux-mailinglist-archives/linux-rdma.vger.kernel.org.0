Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C059A7A4342
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbjIRHoX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 03:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbjIRHoB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 03:44:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD6F10FD
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 00:42:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC33CC433C7;
        Mon, 18 Sep 2023 07:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695022955;
        bh=sI5ixamfHgJb+k+2DR1ctLnwFibNYuoFRYyjARuhHEM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JDc6ROL7muwEX8AbFwNcZNg53A9S+VvtalkgJCgXHcpqDG073FK3DllYIryhp9zGa
         f5Won/Ph4EBg3s0+weu8X9m/hbiqkHUo/dsJaxs8FP2L01bVNyjbHRcPXykpEmmhQO
         ofttqD8PJwt2Y2uLvGdH+AFmOHHqUc/sYu+1KG0sw30tDP4Koxl1G9Re7TLEmqtd2W
         YzK5bVc0KfVQGYWIC6yfL/L6naFQiBmsJOtL8h4ZDANZ6wqKOCCZAAm8MVeomTrgRk
         VRWzVAtHGjB57tbuK3rZdNHuxdQs+0RkHRvGhvs7yRkeQWUFx9oMlrJhkg0jXN3g8k
         eac/yEVhYOmlA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Cheng Xu <chengyou@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
In-Reply-To: <20230908060559.80203-1-chengyou@linux.alibaba.com>
References: <20230908060559.80203-1-chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-rc] RDMA/erdma: Fix NULL pointer access in regmr_cmd
Message-Id: <169502295128.82702.1339969116129339729.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 10:42:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, 08 Sep 2023 14:05:59 +0800, Cheng Xu wrote:
> Fix the crash of regmr_cmd called by erdma_ib_alloc_mr. The reason is
> that mr->mem.mtt is not initialized but it is accessed in regmr_cmd.
> 
> The call trace information:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  <...>
>  RIP: 0010:regmr_cmd+0x170/0x1c0 [erdma]
>  <...>
> Call Trace:
>  ? __die+0x20/0x70
>  ? page_fault_oops+0x66/0x150
>  ? do_user_addr_fault+0x61/0x660
>  ? exc_page_fault+0x65/0x140
>  ? asm_exc_page_fault+0x22/0x30
>  ? regmr_cmd+0x170/0x1c0 [erdma]
>  ? preempt_count_add+0x70/0xa0
>  ? _raw_spin_lock_irqsave+0x19/0x50
>  ? _raw_spin_unlock_irqrestore+0x1b/0x40
>  ? erdma_alloc_idx+0x51/0x90 [erdma]
>  erdma_get_dma_mr+0xa3/0x120 [erdma]
>  __ib_alloc_pd+0xeb/0x1c0 [ib_core]
> 
> [...]

Applied, thanks!

[1/1] RDMA/erdma: Fix NULL pointer access in regmr_cmd
      https://git.kernel.org/rdma/rdma/c/b2abdffb505f7e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
