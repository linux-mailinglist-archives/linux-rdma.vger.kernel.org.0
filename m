Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EF14576F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgAVOHZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 09:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgAVOHZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Jan 2020 09:07:25 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19AF52071E;
        Wed, 22 Jan 2020 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579702043;
        bh=Wy8Pr0E20M1TkFfD3kbyzyKhQuyBCG5ThscUojUfzXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y3iORS1SPpk40TWx1YMBLIlj4LHI82M44rmPOsHCDrQrTLliyDdVvn5b/eKtw4Cy9
         KTrXYOjeR1wCj5sPNdh0B7579dCsjeckCMNMGtWK5fN9RMUUksyOOhHi25UgAMfEqR
         03ZoRBLqbH9l0VklzL8OssO38P9xM8EN5VeB6Z9A=
Date:   Wed, 22 Jan 2020 16:07:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
Message-ID: <20200122140720.GF7018@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-18-jinpuwang@gmail.com>
 <20200120134815.GH51881@unreal>
 <CAMGffEkt1v+OkWOZfFBitYpqYHxB2+RHSjZbbLBZFPSuRXPMXQ@mail.gmail.com>
 <20200122122548.GB7018@unreal>
 <CAMGffEmpRvruSn6iz6EfgfAjE9xrnsihwPaQU8Ft9e7qLD5avw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmpRvruSn6iz6EfgfAjE9xrnsihwPaQU8Ft9e7qLD5avw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 22, 2020 at 02:12:19PM +0100, Jinpu Wang wrote:
> On Wed, Jan 22, 2020 at 1:25 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Jan 22, 2020 at 12:22:43PM +0100, Jinpu Wang wrote:
> > > > > +/**
> > > > > + * rnbd_get_cpu_qlist() - finds a list with HW queues to be rerun
> > > > > + * @sess:    Session to find a queue for
> > > > > + * @cpu:     Cpu to start the search from
> > > > > + *
> > > > > + * Description:
> > > > > + *     Each CPU has a list of HW queues, which needs to be rerun.  If a list
> > > > > + *     is not empty - it is marked with a bit.  This function finds first
> > > > > + *     set bit in a bitmap and returns corresponding CPU list.
> > > > > + */
> > > > > +static struct rnbd_cpu_qlist *
> > > > > +rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
> > > > > +{
> > > > > +     int bit;
> > > > > +
> > > > > +     /* First half */
> > > > > +     bit = find_next_bit(sess->cpu_queues_bm, nr_cpu_ids, cpu);
> > > >
> > > > Is it protected by any lock?
> > > We hold requeue_lock when set/clear bit, and disable preemption via
> > > get_cpu_ptr when find_next_bit.
> > > even it fails to get latest bit, it just cause an rerun the queue.
> >
> > It is not clear here at all.
> >
> > > >
> > > > > +     if (bit < nr_cpu_ids) {
> > > > > +             return per_cpu_ptr(sess->cpu_queues, bit);
> > > > > +     } else if (cpu != 0) {
> > > > > +             /* Second half */
> > > > > +             bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
> > > > > +             if (bit < cpu)
> > > > > +                     return per_cpu_ptr(sess->cpu_queues, bit);
> > > > > +     }
> > > > > +
> > > > > +     return NULL;
> > > > > +}
> > > > > +
> > > > > +static inline int nxt_cpu(int cpu)
> > > > > +{
> > > > > +     return (cpu + 1) % nr_cpu_ids;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * rnbd_rerun_if_needed() - rerun next queue marked as stopped
> > > > > + * @sess:    Session to rerun a queue on
> > > > > + *
> > > > > + * Description:
> > > > > + *     Each CPU has it's own list of HW queues, which should be rerun.
> > > > > + *     Function finds such list with HW queues, takes a list lock, picks up
> > > > > + *     the first HW queue out of the list and requeues it.
> > > > > + *
> > > > > + * Return:
> > > > > + *     True if the queue was requeued, false otherwise.
> > > > > + *
> > > > > + * Context:
> > > > > + *     Does not matter.
> > > > > + */
> > > > > +static inline bool rnbd_rerun_if_needed(struct rnbd_clt_session *sess)
> > > >
> > > > No inline function in C files.
> > > First time saw such request, there are so many inline functions in C
> >
> > 15) The inline disease
> > https://elixir.bootlin.com/linux/latest/source/Documentation/process/coding-style.rst#L882
> ok, will review the inline usage, and drop some.
> >
> > > files across the tree
> > > grep inline drivers/infiniband/core/*.c
> > > drivers/infiniband/core/addr.c:static inline bool
> > > ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
> > > drivers/infiniband/core/cma.c:static inline u8 cma_get_ip_ver(const
> > > struct cma_hdr *hdr)
> > > drivers/infiniband/core/cma.c:static inline void cma_set_ip_ver(struct
> > > cma_hdr *hdr, u8 ip_ver)
> > > drivers/infiniband/core/cma.c:static inline void release_mc(struct kref *kref)
> > > drivers/infiniband/core/cma.c:static inline struct sockaddr
> > > *cma_src_addr(struct rdma_id_private *id_priv)
> > > drivers/infiniband/core/cma.c:static inline struct sockaddr
> > > *cma_dst_addr(struct rdma_id_private *id_priv)
> > >
> > > >
> > > > > +{
> > > > > +     struct rnbd_queue *q = NULL;
> > > > > +     struct rnbd_cpu_qlist *cpu_q;
> > > > > +     unsigned long flags;
> > > > > +     int *cpup;
> > > > > +
> > > > > +     /*
> > > > > +      * To keep fairness and not to let other queues starve we always
> > > > > +      * try to wake up someone else in round-robin manner.  That of course
> > > > > +      * increases latency but queues always have a chance to be executed.
> > > > > +      */
> > > > > +     cpup = get_cpu_ptr(sess->cpu_rr);
> > > > > +     for (cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(*cpup)); cpu_q;
> > > > > +          cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(cpu_q->cpu))) {
> > > > > +             if (!spin_trylock_irqsave(&cpu_q->requeue_lock, flags))
> > > > > +                     continue;
> > > > > +             if (likely(test_bit(cpu_q->cpu, sess->cpu_queues_bm))) {
> > > >
> > > > Success oriented approach please.
> > > sorry, I don't quite get your point.
> >
> > The flows are better to be written:
> > if (err)
> >   return or conitnue
> > <...>
> > do_something
> >
> > in your case
> > if (!test_bit(...))
> >  continue;
> > do_work_here.
> In our case,
>  if we failed to get requeue_lock, we continue to next cpu_q and do the work
> I guess you miss read the code.

I don't think so, this is is how it is expected to be.

+               if (!spin_trylock_irqsave(&cpu_q->requeue_lock, flags))
+                       continue;
+               if (!test_bit(cpu_q->cpu, sess->cpu_queues_bm))
+                       goto unlock;
+
+               q = list_first_entry_or_null(&cpu_q->requeue_list,
+                                            typeof(*q), requeue_list);
+               if (!q)
+                      goto clear_bit;
+                list_del_init(&q->requeue_list);
+                clear_bit_unlock(0, &q->in_list);
 ....


>
> Thanks
