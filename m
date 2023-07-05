Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0614747CB5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 07:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGEFwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGEFwp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 01:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E463DB2;
        Tue,  4 Jul 2023 22:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7050961425;
        Wed,  5 Jul 2023 05:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508FCC433C8;
        Wed,  5 Jul 2023 05:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688536362;
        bh=NQsFB+2RAaeuXH+1ZMfVCmr9PB+efMMQy8Vc7+0uDMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hffdCYLsKUQwJVoGPVqW8rsFnbBu7Hodcjt+MmNfLEkQBxXWhery2IASAx6WRt2Rf
         mTdJIoQQ33sOKzfXDmDKBXStaz/vH/miTkDJ/RXrI4U5iOzF6q9Dc4qSIM3MzU4qLC
         m/FyrWrT7DQtsUv5s2asRDu7YMzNOtgH3P7K1bDpWQyOHrvBp+AVqj0mC5jfTO6F2r
         a+ta5kkGmLev7VHafXNb7TMYzDiikAGfu0xfu77F4CKoJyEB/vrKmbcZIyTyl+xC2U
         Vj2/DJXD6ghlWgTXLK9aKmx8WP67L1Hm4r3O4Zg9S7CBDJ6z4RmxHLSf/iW3ZYCSfy
         XYn/KA8sW/LAw==
Date:   Wed, 5 Jul 2023 08:52:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &sde->flushlist_lock
Message-ID: <20230705055238.GG6455@unreal>
References: <20230628045925.5261-1-dg573847474@gmail.com>
 <20230704114849.GA6455@unreal>
 <CAAo+4rXkMM87OJzim=8dACdV=kWK_1yXeD=W5GZzHoJ2Gz6rtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo+4rXkMM87OJzim=8dACdV=kWK_1yXeD=W5GZzHoJ2Gz6rtw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 05, 2023 at 01:42:31AM +0800, Chengfeng Ye wrote:
> > Plus, we already in context where interrupts are stopped.
> 
> Indeed they can be called from .ndo_start_xmit callback and
> the document said it is with bh disabled.
> 
> But I found some call chain from the user process that seems could
> be called from irq disabled context. For sdma_send_txlist(),
> there is a call chain.
> 
> -> hfi1_write_iter()  (.write_iter callback)
> -> hfi1_user_sdma_process_request()
> -> user_sdma_send_pkts()
> -> sdma_send_txlist()
> 
> The .write_iter seems not to disable irq by default, as mentioned by
> https://www.kernel.org/doc/Documentation/filesystems/vfs.txt
> And I didn't find any explicit disabling or bh or irq along the call path,
> and also see several  copy_from_usr() which cannot be invoked under
> irq context.
> 
> 
> For sdma_send_txreq(), there is a call chain.
> 
> -> qp_priv_alloc()
> -> iowait_init() (register _hfi1_do_tid_send() as a work queue)
> -> _hfi1_do_tid_send() (workqueue)
> -> hfi1_do_tid_send()
> -> hfi1_verbs_send()
> -> sr(qp, ps, 0) (sr could points to hfi1_verbs_send_dm())
> -> hfi1_verbs_send_dma()
> -> sdma_send_txreq()
> 
> _hfi1_do_tid_send() is a work queue without irq disabled by default,
> I also check the remaining call path and also found that there is no explicit
> irq disable, instead the call site of hfi1_verbs_send() is exactly after
> spin_lock_irq_restore(), seems like a hint that it is probably called withirq
> enable.

Right, that path is called in process context and can sleep, there is no
need in irq disabled variant there.

> 
> Another hint is that the lock acquisition of
> spin_lock_irqsave(&sde->tail_lock, flags);
> just before my patch in the same function also disable irq, seems like another
> hint that this function could be called with interrupt disable,

Exactly, we already called to spin_lock_irqsave(), there is no value in
doing it twice.
void f() {
	spin_lock_irqsave(...)
	spin_lock_irqsave(...)
	....
	spin_unlock_irqrestore(...)
	spin_unlock_irqrestore(...)
}

is exactly the same as
void f() {
	spin_lock_irqsave(...)
	spin_lock(...)
	....
	spin_unlock(...)
	spin_unlock_irqrestore(...)
}

Thanks
