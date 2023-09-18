Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C2F7A43B6
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjIRH7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 03:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbjIRH7c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 03:59:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C985E61
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 00:58:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98004C433C7;
        Mon, 18 Sep 2023 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695023856;
        bh=muD5byWFgnARpzqhoPbuB3JOX3EA+IEe5lcbUW6Rnog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfiRUnMIn3Z+hT5aJy7BifjoIPnxlx47RS9dHi929vpLJ6z7UzFqlKZg3pUmSg9BT
         YoCxgBYvMlxQiHY7YyoCWlmyetiST/ulf/hO7j7ZqqE20WL5xV1fm1GTck+yOkIDO9
         JfINMc06ZSLZdE7QR4V//cBf3QBdtWEx+5kGK8orUUpd28DO4dFdwzt+a50hVXPysB
         N1owYF8M8OU4mp4NXPk1VNMyA1W3bMPoWpMH6d6jsLTTQJ7zdZgusZc4ZNa7v7pJr7
         IYzcOEKANqcJ3f6EdHBb1Cxn9io1YjdKPcs8Fcj4KcEt6N8G6tpLinmi5IGjTHw5v6
         5Fea8Jr0I7y5A==
Date:   Mon, 18 Sep 2023 10:57:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Michael P. Deignan" <michael.p.deignan@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Question on libibverbs "problem"
Message-ID: <20230918075732.GB13757@unreal>
References: <1UemSoI5JF.EPU4Dkh77Fx@mdeignan.blidomain.braintreelabs.com>
 <1UemTrupdT.IdMQk9Gt7h3@mdeignan.blidomain.braintreelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1UemTrupdT.IdMQk9Gt7h3@mdeignan.blidomain.braintreelabs.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 08, 2023 at 07:39:09AM -0400, Michael P. Deignan wrote:
> I have a user who is running an mpi model using mvapich2, compiled with the Intel OneAPI compiler (2023.1.0) on a Rocky 8.6 OpenHPC cluster. Bear with me for a minute as I lay the foundation to get to rdma-core.
> 
> Periodically (randomly after X minutes, where X has been as few as 5 and as much as 30) the model will crash and in the error log there will be thousands of messages:
> 
> [mv2_mcast_resend_window] Failed to post mcast send errno:0
> 
> Basically this message repeats until the disk fills up and the job terminates with an out of disk space message.
> 
> I tracked the error to the mvapich2 source code at src/mpid/ch3/channels/common/include/ibv_mcast.h:
> 
> 
>    int ret;                                                    \    ret =
> ibv_post_send(_mcast_ctx->ud_ctx->qp,                 \
>                &(_v->desc.u.sr), &(_v->desc.y.bad_sr));        \
>    if (ret) {                                                  \
>        PRINT_ERROR("Failed to post mcast send errno:%d\n",     \
>                                errno);                         \
>    }                                                           \
>    _mcast_ctx->ud_ctx->send_wqes_avail--;                      \
>    while (_mcast_ctx->ud_ctx->send_wqes_avail <= 0) {          \
>        MPIDI_CH3I_Progress(FALSE, NULL);                       \
>    }
> 
> which leads me here, to the rdma-core group, as the ibv_post_send subroutine is in include/infiniband/verbs.h:
> 
> 
> 
> /** * ibv_post_send - Post a list of work requests to a send queue.
> *
> * If IBV_SEND_INLINE flag is set, the data buffers can be reused
> * immediately after the call returns.
> */
> static inline int ibv_post_send(struct ibv_qp *qp, struct ibv_send_wr *wr,
>                                struct ibv_send_wr **bad_wr)
> {
>        return qp->context->ops.post_send(qp, wr, bad_wr);
> }
> 
> For some reason, this function call (ibv_post_send) is returning zero back to the caller, and no error code is being set (errno = 0).
> 
> As the model does run for a random amount of time, this would seem to suggest some type of hardware problem, but everything we've checked (system, ib card, ib switch, etc.,) doesn't show any errors.
> 
> Can anyone shed some light on under what circumstances a call to ibv_post_send would, in fact, return zero when previously it didn't?
> 
> I realize I'm probably not giving much data to really help.. I suppose there could be some type of underlying operating system issue but even there I'm not sure how I would determine where the problem is, since everything else is running fine (and it appears only this one model seems to cause this problem) with nothing abnormal in the event logs. I tried running the model on an older Rocks Centos 7.x cluster and likewise received the same error.
> 
> Having some basic understanding of what would cause the post send call to return zero and not set an error code might help.

According to man page, errno is not set and users need to check return
value instead.

https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/man/ibv_post_send.3#L155

  155 .SH "RETURN VALUE"
  156 .B ibv_post_send()
  157 returns 0 on success, or the value of errno on failure (which indicates the failure reason).
  158 .SH "NOTES"

The right print in mvapich2 needs to be
    if (ret) {                                                \
        PRINT_ERROR("Failed to post mcast send ret:%d\n",     \
                                ret);                         \
    }

Thanks
