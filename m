Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3325E1453AA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 12:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgAVLWz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 06:22:55 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45945 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgAVLWz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jan 2020 06:22:55 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so4845491iln.12
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2020 03:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUH030Ucjx6wSEh1Tt9g3o7Wsr/XQCAziEWCTfW8SaU=;
        b=hFzLiDN2F6hBrM+mkVatQqv7WzKq5KtkV6j6dpCDUcjBK9CXbj1bzvr9AqOHVTOPhP
         QiF0lZMIGQ3CdgBg4Lm/p7D9WmZcnlTjqkBKs5BoxaWmpvZA8vQyIFTHyJY8372CfgX6
         y6sV6/x9VhLkexaQo2QAk2/6zccDRKl5/5K92RBfaKqMZTKMLjoyX1s52OapBjP+qeJu
         uLpUiIhcJYzgXNq+xk2nwmWW+UDTg1JdgxLRIAtuKh82umP0ZAKJzkil1zGgQmCKS4oa
         88+z443ylZjUmfHe9A2/eoVsBcOorD2Zwnp7/hNJ93URcHXBBae31XpZDE+UwE6Ietn2
         TXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUH030Ucjx6wSEh1Tt9g3o7Wsr/XQCAziEWCTfW8SaU=;
        b=XLdcDlVy7kqvgAb19B6OklXL7EW3oeK38isRAATuqSsWZd0NomtBXcD4BtJoEUz08a
         WoGOk8/jTBDkq1tdF7SKUyZoV39COQI8MSHpogIzbdqT9+L1PfodQ1In1QGzevycM2tf
         xwX2vemAobokzfB74/dP8IyhPHrYbwFzMjA4VN55PYdX5VPDL6XWHkBMFFAPjAfspKq0
         W5xmP7oEcuc+JOypSTRFAaYK0SHVRQckHlw8QoYeVFmV6v5pcgN9RiisruLN0xDOZz0z
         l30FDW042tqP9QNM25jiPJooivFlQlfDOqxwDglBFEKZScG4HyseunbOEdr5DaV+89K0
         9EjA==
X-Gm-Message-State: APjAAAVHf7HkHzekHMoygwGU19l/c5cAOODcR4LIGkntpeO7pNA7Xv0R
        vA5WFuIFt8MHQuTrGLgejG3Vm2itJTngdNVsDe6gdA==
X-Google-Smtp-Source: APXvYqzTMw8qEqKroHt7vwE597QMda9Tc/gz8Br0vBdbrDEYp5bQ1g4btVjQp1LbkwgUVxCU41VQGL82druMFSll0KI=
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr7381160ilj.298.1579692174515;
 Wed, 22 Jan 2020 03:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-18-jinpuwang@gmail.com>
 <20200120134815.GH51881@unreal>
In-Reply-To: <20200120134815.GH51881@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 22 Jan 2020 12:22:43 +0100
Message-ID: <CAMGffEkt1v+OkWOZfFBitYpqYHxB2+RHSjZbbLBZFPSuRXPMXQ@mail.gmail.com>
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > +/**
> > + * rnbd_get_cpu_qlist() - finds a list with HW queues to be rerun
> > + * @sess:    Session to find a queue for
> > + * @cpu:     Cpu to start the search from
> > + *
> > + * Description:
> > + *     Each CPU has a list of HW queues, which needs to be rerun.  If a list
> > + *     is not empty - it is marked with a bit.  This function finds first
> > + *     set bit in a bitmap and returns corresponding CPU list.
> > + */
> > +static struct rnbd_cpu_qlist *
> > +rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
> > +{
> > +     int bit;
> > +
> > +     /* First half */
> > +     bit = find_next_bit(sess->cpu_queues_bm, nr_cpu_ids, cpu);
>
> Is it protected by any lock?
We hold requeue_lock when set/clear bit, and disable preemption via
get_cpu_ptr when find_next_bit.
even it fails to get latest bit, it just cause an rerun the queue.
>
> > +     if (bit < nr_cpu_ids) {
> > +             return per_cpu_ptr(sess->cpu_queues, bit);
> > +     } else if (cpu != 0) {
> > +             /* Second half */
> > +             bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
> > +             if (bit < cpu)
> > +                     return per_cpu_ptr(sess->cpu_queues, bit);
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static inline int nxt_cpu(int cpu)
> > +{
> > +     return (cpu + 1) % nr_cpu_ids;
> > +}
> > +
> > +/**
> > + * rnbd_rerun_if_needed() - rerun next queue marked as stopped
> > + * @sess:    Session to rerun a queue on
> > + *
> > + * Description:
> > + *     Each CPU has it's own list of HW queues, which should be rerun.
> > + *     Function finds such list with HW queues, takes a list lock, picks up
> > + *     the first HW queue out of the list and requeues it.
> > + *
> > + * Return:
> > + *     True if the queue was requeued, false otherwise.
> > + *
> > + * Context:
> > + *     Does not matter.
> > + */
> > +static inline bool rnbd_rerun_if_needed(struct rnbd_clt_session *sess)
>
> No inline function in C files.
First time saw such request, there are so many inline functions in C
files across the tree
grep inline drivers/infiniband/core/*.c
drivers/infiniband/core/addr.c:static inline bool
ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
drivers/infiniband/core/cma.c:static inline u8 cma_get_ip_ver(const
struct cma_hdr *hdr)
drivers/infiniband/core/cma.c:static inline void cma_set_ip_ver(struct
cma_hdr *hdr, u8 ip_ver)
drivers/infiniband/core/cma.c:static inline void release_mc(struct kref *kref)
drivers/infiniband/core/cma.c:static inline struct sockaddr
*cma_src_addr(struct rdma_id_private *id_priv)
drivers/infiniband/core/cma.c:static inline struct sockaddr
*cma_dst_addr(struct rdma_id_private *id_priv)

>
> > +{
> > +     struct rnbd_queue *q = NULL;
> > +     struct rnbd_cpu_qlist *cpu_q;
> > +     unsigned long flags;
> > +     int *cpup;
> > +
> > +     /*
> > +      * To keep fairness and not to let other queues starve we always
> > +      * try to wake up someone else in round-robin manner.  That of course
> > +      * increases latency but queues always have a chance to be executed.
> > +      */
> > +     cpup = get_cpu_ptr(sess->cpu_rr);
> > +     for (cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(*cpup)); cpu_q;
> > +          cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(cpu_q->cpu))) {
> > +             if (!spin_trylock_irqsave(&cpu_q->requeue_lock, flags))
> > +                     continue;
> > +             if (likely(test_bit(cpu_q->cpu, sess->cpu_queues_bm))) {
>
> Success oriented approach please.
sorry, I don't quite get your point.

Thanks Leon for review.
