Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E57D64A8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 10:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjJYINp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 04:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjJYINo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 04:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1363A4;
        Wed, 25 Oct 2023 01:13:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C133DC433C8;
        Wed, 25 Oct 2023 08:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698221622;
        bh=1GcjG9cCqbf1tvjBQVqQu2CUA6//8bHC0TltsUTfCeI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=blqCd77Kehr3Nm5Zm4QHrxt18Zt8TM5Hfl3wuhkajGq2WVC7CZfx5DsIR1JYCZdy5
         hnDHN5s1AT9f8GR4Iq2IBFzvCqJgLFS2zZEIdZg95vpyeVeV2cqE1hJWHXdp67mjYi
         yOWErRCYLMeFT+gwVDuavDyalDUM2LztQQJd2oXGGzlwJK1luzbEg5OnM8grPECE5c
         t6IIqQNUEY9XsWQdOsoMzD33u8R3ZTBpJkRVAmMOHTyH9btqgbQ46Wkw1eC+rEpEm5
         R1lC54nUpfLEsD+fwpPpdaaF8fH1sq2+MMuAQu4RoFfG3uKnh28IOSSewMuyjGBHfs
         OUTL27Mv4vlYw==
From:   Leon Romanovsky <leon@kernel.org>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        dean.luick@cornelisnetworks.com,
        Chengfeng Ye <dg573847474@gmail.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230926101116.2797-1-dg573847474@gmail.com>
References: <20230926101116.2797-1-dg573847474@gmail.com>
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &irq_src_lock and
 &dd->uctxt_lock
Message-Id: <169822161706.2969904.18279817075628417467.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 11:13:37 +0300
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


On Tue, 26 Sep 2023 10:11:16 +0000, Chengfeng Ye wrote:
> handle_receive_interrupt_napi_sp() running inside interrupt handler
> could introduce inverse lock ordering between &dd->irq_src_lock
> and &dd->uctxt_lock, if read_mod_write() is preempted by the isr.
> 
>           [CPU0]                                        |          [CPU1]
> hfi1_ipoib_dev_open()                                   |
> --> hfi1_netdev_enable_queues()                         |
> --> enable_queues(rx)                                   |
> --> hfi1_rcvctrl()                                      |
> --> set_intr_bits()                                     |
> --> read_mod_write()                                    |
> --> spin_lock(&dd->irq_src_lock)                        |
>                                                         | hfi1_poll()
>                                                         | --> poll_next()
>                                                         | --> spin_lock_irq(&dd->uctxt_lock)
>                                                         |
>                                                         | --> hfi1_rcvctrl()
>                                                         | --> set_intr_bits()
>                                                         | --> read_mod_write()
>                                                         | --> spin_lock(&dd->irq_src_lock)
> <interrupt>                                             |
>    --> handle_receive_interrupt_napi_sp()               |
>    --> set_all_fastpath()                               |
>    --> hfi1_rcd_get_by_index()                          |
>    --> spin_lock_irqsave(&dd->uctxt_lock)               |
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: Fix potential deadlock on &irq_src_lock and &dd->uctxt_lock
      https://git.kernel.org/rdma/rdma/c/2f19c4b8395ccb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
