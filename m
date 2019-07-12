Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04976680A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfGLH6J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 03:58:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46586 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfGLH6J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 03:58:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so8416706ljg.13;
        Fri, 12 Jul 2019 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fImaj8thWSSI1s0o2kWcty7GzKelijqQaaGELeSxg5A=;
        b=Bw3YfM6ra9CLrYqK6VjocfnlM5x7dd04QT2MNRtlEy9TJ39YO/5H5s97UnAe/BbVXm
         FSkTgNkhuA1N8+U2A+Ztb+SVnocFy4Bpg+W1NsN2qG+Hd9NNd8sCQqah+UzdduWyhOgM
         BjVbusZv+G9NMUN3L772GC9+MntURENU6cysnoaZk9Cf2nqy7WfH6PiiF4VhnxJF5NjJ
         s0XakN6cDnqJb8gyV0RdNzCNc5qN4LunR3/KUGsXO94f2+EUjaLqXJUpGwg44OTl+v3Z
         CJ/ONvQ+3/iahDq2nvXtnJoGcDN9zK/rhR0H6W0Eh3lzzNHaAq/Rt3zQGhnbRH5ftFUx
         iD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fImaj8thWSSI1s0o2kWcty7GzKelijqQaaGELeSxg5A=;
        b=nbwMFGZnLw1vJG3gZnZEskZr2z82YkDPAUqrUcWHaKfDjPwhi9DJrNaOqnlvBdnauW
         89ncEAyWh6DQhPpy0LEO5zrI+IsLsNj6w7XHu9rimvjn/tNwcF6I/XuEBiAMCk0HZWsc
         Zpoh0w5pcGwlN/yKzjpfXyNxEO+CPbOr3R7XN3BsuJTJlkYbKqLW4mQKvv6osocgbrq+
         1AUCueI1IqcprToVqGbHn+Sz+aL+1Z36GAmM3BzVwKUbSc74o0rUtgHiaSgt3drb6KxP
         od0/MRl5FsCSauMqXlHeZx8VC6KlNE7BWGZjq/60bkhsAyBNQSfDbTY7dWTaUW3UBDeG
         cwMQ==
X-Gm-Message-State: APjAAAUyKeC5w7okye5yFf4IVdQmEaV8XuulzjQSn/iC3Zu6WaUUi36i
        mtE8yM027aoMtzni1+KL5ioec+Z56w3DZEPFFeC8hw5a
X-Google-Smtp-Source: APXvYqwTV1wVTRulOJlMD7Zxj53FAfbdP/rFVwvHlE8gXKQEjMvnmBEqn0pUdTQLGPWWQ7pckW94lbcZjkcflJQh0II=
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr4833425ljk.90.1562918285821;
 Fri, 12 Jul 2019 00:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me> <CAHg0HuxZvXH899=M4vC7BTH-bP2J35aTwsGhiGoC8AamD8gOyA@mail.gmail.com>
 <aef765ed-4bb9-2211-05d0-b320cc3ac275@grimberg.me>
In-Reply-To: <aef765ed-4bb9-2211-05d0-b320cc3ac275@grimberg.me>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Fri, 12 Jul 2019 09:57:54 +0200
Message-ID: <CAD9gYJKcJ47ogKL4S_KMtxpS1gPHHhqqG7-GTi-2c0cOJ-LJtw@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi,

> >> Another question, from what I understand from the code, the client
> >> always rdma_writes data on writes (with imm) from a remote pool of
> >> server buffers dedicated to it. Essentially all writes are immediate (no
> >> rdma reads ever). How is that different than using send wrs to a set of
> >> pre-posted recv buffers (like all others are doing)? Is it faster?
> > At the very beginning of the project we did some measurements and saw,
> > that it is faster. I'm not sure if this is still true
>
> Its not significantly faster (can't imagine why it would be).
> What could make a difference is probably the fact that you never
> do rdma reads for I/O writes which might be better. Also perhaps the
> fact that you normally don't wait for send completions before completing
> I/O (which is broken), and the fact that you batch recv operations.

I don't know how do you come to the conclusion we don't wait for send
completion before completing IO.

We do chain wr on successfull read request from server, see funtion
rdma_write_sg,

 318 static int rdma_write_sg(struct ibtrs_srv_op *id)
 319 {
 320         struct ibtrs_srv_sess *sess = to_srv_sess(id->con->c.sess);
 321         dma_addr_t dma_addr = sess->dma_addr[id->msg_id];
 322         struct ibtrs_srv *srv = sess->srv;
 323         struct ib_send_wr inv_wr, imm_wr;
 324         struct ib_rdma_wr *wr = NULL;
snip
333         need_inval = le16_to_cpu(id->rd_msg->flags) &
IBTRS_MSG_NEED_INVAL_F;
snip
 357                 wr->wr.wr_cqe   = &io_comp_cqe;
 358                 wr->wr.sg_list  = list;
 359                 wr->wr.num_sge  = 1;
 360                 wr->remote_addr = le64_to_cpu(id->rd_msg->desc[i].addr);
 361                 wr->rkey        = le32_to_cpu(id->rd_msg->desc[i].key);
 snip
368                 if (i < (sg_cnt - 1))
 369                         wr->wr.next = &id->tx_wr[i + 1].wr;
 370                 else if (need_inval)
 371                         wr->wr.next = &inv_wr;
 372                 else
 373                         wr->wr.next = &imm_wr;
 374
 375                 wr->wr.opcode = IB_WR_RDMA_WRITE;
 376                 wr->wr.ex.imm_data = 0;
 377                 wr->wr.send_flags  = 0;
snip
 386         if (need_inval) {
 387                 inv_wr.next = &imm_wr;
 388                 inv_wr.wr_cqe = &io_comp_cqe;
 389                 inv_wr.sg_list = NULL;
 390                 inv_wr.num_sge = 0;
 391                 inv_wr.opcode = IB_WR_SEND_WITH_INV;
 392                 inv_wr.send_flags = 0;
 393                 inv_wr.ex.invalidate_rkey = rkey;
 394         }
 395         imm_wr.next = NULL;
 396         imm_wr.wr_cqe = &io_comp_cqe;
 397         imm_wr.sg_list = NULL;
 398         imm_wr.num_sge = 0;
 399         imm_wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
 400         imm_wr.send_flags = flags;
 401         imm_wr.ex.imm_data = cpu_to_be32(ibtrs_to_io_rsp_imm(id->msg_id,
 402                                                              0,
need_inval));
 403


when we need to do invalidation of remote memory, there will chain WR
togather, last 2 are inv_wr, and imm_wr.
imm_wr is the last one, this is important, due to the fact RC QP are
ordered, we know when when we received
IB_WC_RECV_RDMA_WITH_IMM and w_inval is true, hardware should already
finished it's job to invalidate the MR.
If server fails to invalidate, we will do local invalidation, and wait
for completion.

On client side
284 static void complete_rdma_req(struct ibtrs_clt_io_req *req, int errno,
 285                               bool notify, bool can_wait)
 286 {
 287         struct ibtrs_clt_con *con = req->con;
 288         struct ibtrs_clt_sess *sess;
 289         struct ibtrs_clt *clt;
 290         int err;
 291
 292         if (WARN_ON(!req->in_use))
 293                 return;
 294         if (WARN_ON(!req->con))
 295                 return;
 296         sess = to_clt_sess(con->c.sess);
 297         clt = sess->clt;
 298
 299         if (req->sg_cnt) {
 300                 if (unlikely(req->dir == DMA_FROM_DEVICE &&
req->need_inv)) {
 301                         /*
 302                          * We are here to invalidate RDMA read requests
 303                          * ourselves.  In normal scenario server should
 304                          * send INV for all requested RDMA reads, but
 305                          * we are here, thus two things could happen:
 306                          *
 307                          *    1.  this is failover, when errno != 0
 308                          *        and can_wait == 1,
 309                          *
 310                          *    2.  something totally bad happened and
 311                          *        server forgot to send INV, so we
 312                          *        should do that ourselves.
 313                          */
 314
 315                         if (likely(can_wait)) {
 316                                 req->need_inv_comp = true;
 317                         } else {
 318                                 /* This should be IO path, so
always notify */
 319                                 WARN_ON(!notify);
 320                                 /* Save errno for INV callback */
 321                                 req->inv_errno = errno;
 322                         }
 323
 324                         err = ibtrs_inv_rkey(req);
 325                         if (unlikely(err)) {
 326                                 ibtrs_err(sess, "Send INV WR
key=%#x: %d\n",
 327                                           req->mr->rkey, err);
 328                         } else if (likely(can_wait)) {
 329                                 wait_for_completion(&req->inv_comp);
 330                         } else {
330                         } else {
 331                                 /*
 332                                  * Something went wrong, so request will be
 333                                  * completed from INV callback.
 334                                  */
 335                                 WARN_ON_ONCE(1);
 336
 337                                 return;
 338                         }
 339                 }
 340                 ib_dma_unmap_sg(sess->s.dev->ib_dev, req->sglist,
 341                                 req->sg_cnt, req->dir);
 342         }
 343         if (sess->stats.enable_rdma_lat)
 344                 ibtrs_clt_update_rdma_lat(&sess->stats,
 345                                 req->dir == DMA_FROM_DEVICE,
 346                                 jiffies_to_msecs(jiffies -
req->start_jiffies));
 347         ibtrs_clt_decrease_inflight(&sess->stats);
 348
 349         req->in_use = false;
 350         req->con = NULL;
 351
 352         if (notify)
 353                 req->conf(req->priv, errno);
 354 }

 356 static void process_io_rsp(struct ibtrs_clt_sess *sess, u32
msg_id,
 357                            s16 errno, bool w_inval)
 358 {
 359         struct ibtrs_clt_io_req *req;
 360
 361         if (WARN_ON(msg_id >= sess->queue_depth))
 362                 return;
 363
 364         req = &sess->reqs[msg_id];
 365         /* Drop need_inv if server responsed with invalidation */
 366         req->need_inv &= !w_inval;
 367         complete_rdma_req(req, errno, true, false);
 368 }

Hope this clears the doubt.

Regards,
Jack
