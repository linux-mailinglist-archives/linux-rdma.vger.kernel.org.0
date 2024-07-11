Return-Path: <linux-rdma+bounces-3809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB39392DEB6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 05:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5AC1F223B7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2F8F72;
	Thu, 11 Jul 2024 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwp85zpc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1393653
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667180; cv=none; b=juSupbvisQWwgS9jMOSLwj//FwKoww1AcyZfbFPlq+aUKcx8W4xx8sDmlUOOr50IT0b9Vt32Re85XvE5eY2FUHNwUcvvG61YbMey8WgRDqE0dBjLUWuzHGAqDpdhyaSk1B3t+4R7+axkIJl2k1umUWKTwc1x2puly36EG1Aq/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667180; c=relaxed/simple;
	bh=GI7zqH9ZbHlIssRNXRzQfPbtsuQRz2X5+2yABU9KnMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idkvudcbF7WmiUG3WWbYgez86fGSEvUemFAdU9VxTbBf3dVUoThrFrenV1PUROG1C+lFfRnPpkq4GTVaodgtpIFVUbyAWBpa+ukr27wLcWvfITaL8XgCwe+PMVxxZUWB4wEHw6cpTpGZn4zmbPxFWKJnuTmrbFe25do71jH+DMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwp85zpc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-656d8b346d2so215039a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720667178; x=1721271978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8iN4jKINJg82gBVUiLIXSRFzzRew5R+edlFztzUaC4=;
        b=iwp85zpcZoI4uQv6qWSmv81iP5n35+b9AnbYlkI2JVbiNT2pm5LrdecmReu4whrMki
         G3aegHGkXx9fTkdDDsfBZtRzZFBvGA0M7VC+mAZhJzQfpYhfZiS32dMKPgvV+k/ainAH
         0BHIUHuL3b7Lv6vDZRmWYOCa16OlZsPcG+DrPT7e4A+8w4Ry17MqvKdsgZJfBEXGNZEi
         WFA76tJM/YJzO5mXVu6pamE+tP2Z2a4NaefZMznK5krwJWMOVV6mLbXAYB1S575/CEY5
         PyqbEJW464PN1qNI+7R8PLBQq6W7sCq/QnscDip8N7DebqfUjzVh4z8Bm32YKuDY1A9l
         quNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720667178; x=1721271978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8iN4jKINJg82gBVUiLIXSRFzzRew5R+edlFztzUaC4=;
        b=SBKw5GIK/WQqn8veL6vGwe++DIZ8wnxjfMZV0+aX6hrTD34HfydGssYKKm7syISRFo
         DSSDgmTAr0VJGJIBnBh0fFEVXgw3EU8fhQcgofj8/q8WjG7Wj7VN97hIn+Fxh3sOUdyd
         24GUfkEcONbRwUj3Wt5WVRk7A6Qa5KJ8kNIMhjqrzH1l8ga1vmSaH3ovvu2Gq6PnziJv
         d4Ah0Cc93PWh8l3EB/0Atm6Z293x+P0IMszczi7GmZTpatLgJR9+8ouTtZ5u1ixY/n9P
         KV/JZ/DJJEzdUt87M6BzKjQQb+F+T4PiCuZCRJ5BKO6qCNFsLvzXBzfX6mJ99LuqE236
         QNBg==
X-Forwarded-Encrypted: i=1; AJvYcCVBEoXjh0vOpaA7QIdlkj/fhHBiFfS7kHB+rE0Frsa5o2BtX90POtnx3/vTaEhurHa0ci73WB+0Q83Th2VMtBZB7VmdWZ3J+mvrAA==
X-Gm-Message-State: AOJu0YxaO34/i+LeA4khdGLcLFVwbeKYq/1qQtU+3V1XNgTKCVTUcZzI
	iY3PmXzRFUConz9enk5W4ONfFc8kYJ2B6QjLXqInZ70p2F9M5t3reOs1UUKx14H/2wXIHewvRWu
	zQXQEyZMD8gAld8QeFmwSkq70C0Q=
X-Google-Smtp-Source: AGHT+IGhRPvu2sOLg1tpeMAJKYo8Dz6NrHyveIPTGcpmWjPC1E652538Vjb2xEj7kQx+gDRwQ9ItZyo4y15hcJlg6tc=
X-Received: by 2002:a17:90a:b782:b0:2c9:9c25:757b with SMTP id
 98e67ed59e1d1-2ca35d3a63dmr5721753a91.39.1720667177714; Wed, 10 Jul 2024
 20:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711014006.11294-1-honggangli@163.com>
In-Reply-To: <20240711014006.11294-1-honggangli@163.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Thu, 11 Jul 2024 11:06:06 +0800
Message-ID: <CAEz=Lcvxr4LRhesrWdrodMn2JAG32RzOKTPd=wh470tvH_rG6w@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
To: Honggang LI <honggangli@163.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, rpearsonhpe@gmail.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:41=E2=80=AFAM Honggang LI <honggangli@163.com> wr=
ote:
>
> If ib_req_notify_cq() was called in complete handler, deadlock occurs
> in receive path.
>
> rxe_req_notify_cq+0x21/0x70 [rdma_rxe]
> krping_cq_event_handler+0x26f/0x2c0 [rdma_krping]

What is rdma_krping? What is the deadlock?
Please explain the deadlock in details.


> rxe_cq_post+0x128/0x1d0 [rdma_rxe]
> ? copy_data+0xe0/0x230 [rdma_rxe]
> rxe_responder+0xbe8/0x23a0 [rdma_rxe]
> do_task+0x68/0x1e0 [rdma_rxe]
> ? __pfx_rxe_udp_encap_recv+0x10/0x10 [rdma_rxe]
> rxe_udp_encap_recv+0x79/0xe0 [rdma_rxe]
> udp_queue_rcv_one_skb+0x272/0x540
> udp_unicast_rcv_skb+0x76/0x90
> __udp4_lib_rcv+0xab2/0xd60
> ? raw_local_deliver+0xd2/0x2a0
> ip_protocol_deliver_rcu+0xd1/0x1b0
> ip_local_deliver_finish+0x76/0xa0
> ip_local_deliver+0x68/0x100
> ? ip_rcv_finish_core.isra.0+0xc2/0x430
> ip_sublist_rcv+0x2a0/0x340
> ip_list_rcv+0x13b/0x170
> __netif_receive_skb_list_core+0x2bb/0x2e0
> netif_receive_skb_list_internal+0x1cd/0x300
> napi_complete_done+0x72/0x200
> e1000e_poll+0xcf/0x320 [e1000e]
> __napi_poll+0x2b/0x160
> net_rx_action+0x2c6/0x3b0
> ? enqueue_hrtimer+0x42/0xa0
> handle_softirqs+0xf7/0x340
> ? sched_clock_cpu+0xf/0x1f0
> __irq_exit_rcu+0x97/0xb0
> common_interrupt+0x85/0xa0
>
> Fixes: 0c7e314a6352 ("RDMA/rxe: Fix rxe_cq_post")
> Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c    | 35 ++++++++++++++++++++++++---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  2 ++
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  2 ++
>  4 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/r=
xe/rxe_cq.c
> index fec87c9030ab..97a537994aee 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -39,6 +39,21 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq=
 *cq,
>         return -EINVAL;
>  }
>
> +static void rxe_send_complete(struct tasklet_struct *t)
> +{
> +       struct rxe_cq *cq =3D from_tasklet(cq, t, comp_task);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&cq->cq_lock, flags);
> +       if (cq->is_dying) {
> +               spin_unlock_irqrestore(&cq->cq_lock, flags);
> +               return;
> +       }
> +       spin_unlock_irqrestore(&cq->cq_lock, flags);
> +
> +       cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +}
> +
>  int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>                      int comp_vector, struct ib_udata *udata,
>                      struct rxe_create_cq_resp __user *uresp)
> @@ -64,6 +79,10 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_c=
q *cq, int cqe,
>
>         cq->is_user =3D uresp;
>
> +       cq->is_dying =3D false;
> +
> +       tasklet_setup(&cq->comp_task, rxe_send_complete);
> +
>         spin_lock_init(&cq->cq_lock);
>         cq->ibcq.cqe =3D cqe;
>         return 0;
> @@ -84,7 +103,6 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
>         return err;
>  }
>
> -/* caller holds reference to cq */
>  int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>  {
>         struct ib_event ev;
> @@ -113,17 +131,26 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *=
cqe, int solicited)
>
>         queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
>
> +       spin_unlock_irqrestore(&cq->cq_lock, flags);
> +
>         if ((cq->notify & IB_CQ_NEXT_COMP) ||
>             (cq->notify & IB_CQ_SOLICITED && solicited)) {
>                 cq->notify =3D 0;
> -               cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +               tasklet_schedule(&cq->comp_task);
>         }
>
> -       spin_unlock_irqrestore(&cq->cq_lock, flags);
> -
>         return 0;
>  }
>
> +void rxe_cq_disable(struct rxe_cq *cq)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&cq->cq_lock, flags);
> +       cq->is_dying =3D true;
> +       spin_unlock_irqrestore(&cq->cq_lock, flags);
> +}
> +
>  void rxe_cq_cleanup(struct rxe_pool_elem *elem)
>  {
>         struct rxe_cq *cq =3D container_of(elem, typeof(*cq), elem);
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/=
rxe/rxe_loc.h
> index ded46119151b..ba84f780aa3d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -31,6 +31,8 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int new_cqe,
>
>  int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
>
> +void rxe_cq_disable(struct rxe_cq *cq);
> +
>  void rxe_cq_cleanup(struct rxe_pool_elem *elem);
>
>  /* rxe_mcast.c */
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/s=
w/rxe/rxe_verbs.c
> index de6238ee4379..a964d86789f6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1205,6 +1205,8 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struc=
t ib_udata *udata)
>                 goto err_out;
>         }
>
> +       rxe_cq_disable(cq);
> +
>         err =3D rxe_cleanup(cq);
>         if (err)
>                 rxe_err_cq(cq, "cleanup failed, err =3D %d\n", err);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/s=
w/rxe/rxe_verbs.h
> index 3c1354f82283..03df97e83570 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -63,7 +63,9 @@ struct rxe_cq {
>         struct rxe_queue        *queue;
>         spinlock_t              cq_lock;
>         u8                      notify;
> +       bool                    is_dying;
>         bool                    is_user;
> +       struct tasklet_struct   comp_task;
>         atomic_t                num_wq;
>  };
>
> --
> 2.45.2
>
>

