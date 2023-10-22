Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849B7D21B3
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Oct 2023 09:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJVHvp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVHvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 03:51:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01455F4
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 00:51:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6F5C433C8;
        Sun, 22 Oct 2023 07:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697961102;
        bh=w20upZhtoYktgFTb2Dfm1aCak094mG6D3zK5lZPhTiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVot/0ywKIg5m80FFERXIJ1z5fmB6I4d5i8HG8VXAx1n1NKw+DUlfQlIqrRxw+RWK
         Bt7gp9+ABsZzOAtsjDD4M7+e9MMd3EKVzxWpq4ze9+21qBDhN8wJaJHEjYiKdHHEWJ
         ut5/GYGZwB83uVVlxrcJ4ITPL++9HCBMOHfJenhme0bOT4rw4N2iWm7/zIHeQKT6mk
         dB2LTvmPqN7WlOyIo20dJpL2FSfEv6ANK6IMnHhbLZAM2qIRG10Xm0h20n01nxZt3s
         3kaV/Pl9f1l6kzTBIx02yBNaVa8udomF/B7NOUvr9fZCpQ0gUiIRuis5oLvHerwIPK
         2CUvSYJq6enqQ==
Date:   Sun, 22 Oct 2023 10:51:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     hariprasad@chelsio.com, Ganesh Goudar <ganeshgr@chelsio.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/iw_cxgb4: Low resource fixes for Completion
 queue
Message-ID: <20231022075138.GA10551@unreal>
References: <73451d77-8612-4e14-9695-ad455b84f673@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73451d77-8612-4e14-9695-ad455b84f673@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 20, 2023 at 06:45:19PM +0300, Dan Carpenter wrote:
> Hello,
> 
> The patch dd6b0241260d: "RDMA/iw_cxgb4: Low resource fixes for
> Completion queue" from Jun 10, 2016 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/infiniband/hw/cxgb4/cq.c:1153 c4iw_create_cq()
> 	error: double free of 'chp->destroy_skb'
> 
> drivers/infiniband/hw/cxgb4/cq.c
>     1138         pr_debug("cqid 0x%0x chp %p size %u memsize %zu, dma_addr %pad\n",
>     1139                  chp->cq.cqid, chp, chp->cq.size, chp->cq.memsize,
>     1140                  &chp->cq.dma_addr);
>     1141         return 0;
>     1142 err_free_mm2:
>     1143         kfree(mm2);
>     1144 err_free_mm:
>     1145         kfree(mm);
>     1146 err_remove_handle:
>     1147         xa_erase_irq(&rhp->cqs, chp->cq.cqid);
>     1148 err_destroy_cq:
>     1149         destroy_cq(&chp->rhp->rdev, &chp->cq,
>     1150                    ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
>     1151                    chp->destroy_skb, chp->wr_waitp);
> 
> destroy_cq() calls kfree_skb(chp->destroy_skb).  The call tree is:
> 
> destroy_cq()
> -> c4iw_ref_send_wait()
>    -> c4iw_ofld_send()
>       -> kfree_skb()

It is not always the case, kfree_skb() is called in c4iw_ofld_send() error flows only.

> 
>     1152 err_free_skb:
> --> 1153         kfree_skb(chp->destroy_skb);
> 
> Probably we can just delete this kfree_skb()?

I don't think so, in case create_cq() failed, there is a need to clean
preallocated SKB.

Thanks

> 
>     1154 err_free_wr_wait:
>     1155         c4iw_put_wr_wait(chp->wr_waitp);
>     1156 err_free_chp:
>     1157         return ret;
>     1158 }
> 
> regards,
> dan carpenter
