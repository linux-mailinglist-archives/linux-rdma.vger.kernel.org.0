Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE264175B6F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 14:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgCBNUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 08:20:54 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41283 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgCBNUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 08:20:54 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so11422502ioo.8
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtUNsuTFhkTJADYM6m2GSE9/VGJ4A97Ui/PEG/1wv7U=;
        b=eZL/uUpnRY9ABd9vRZ3lN+WP4CHQJDcsL3wsM3GOwK9eO3Xgacsd3UC2iHshsLep8h
         n4Daw/bhlfv1zYX4qoQLU1uptQZuq3CM8YN/K6oxY7zDdPYz2GqbPwiTXkdBZOeriZ+C
         Cs34MuZheBOeAO35HS8/c69mWAAcrylZYEzweSiMicSn2DuMSekI2ZoXytkIvpAM/Xu4
         bwdStYXTYijpnJ8aiUeyldEIS7fluip1aUYOubJCR08Q6v3qT81LSZyl7ll/ANE5iJ6v
         liy3LvcopIcGqqNliFt/UCcMKkwhISAyFZl7J2yzaJBOSPS6yU8bbHd+Xq5tuKl8F2T4
         /crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtUNsuTFhkTJADYM6m2GSE9/VGJ4A97Ui/PEG/1wv7U=;
        b=LdADH7l1xjjAyZOHyZ/+XOSQ/hvr+hCPEomhOPNJPk5tJZQIiYvkxedN1+X84XzjuI
         LnhBHqHA0Z8Wt/1XVjpdJ2H03R7Exv3rFw3RDAaVSiMVa5ywDWyz2P6igMbvaSHuxKYK
         zsq0ofUc8GeeDeQMe4Qp977R8sFlWeQJ0U7mfs2xBoboAxD31tWZn/w09Fx5AV2ezkog
         PA8/FtSoCE8nykjfkFKaPY0i2qfZWOcOPVB/cSlZyeF+DZTOY45tACERq3l5KfFJvlMX
         /g79sHhO5aT584kOOm79mQ9YW8Z7MeG76fvYcqjs2WWm1CqJgJNtjP/b+fm5hAoYWKs3
         QYKA==
X-Gm-Message-State: APjAAAVuYdlHWHAXkBmaX3Dgk9BHTjpCqG3Vu7MGpOB0Uk16NX/iVJ/j
        40dUkFdRoy9QU8adQttZOBLHXSss5oJC9WcC3rZz
X-Google-Smtp-Source: APXvYqwUPKr4cETLsRyMXKvmm4AwQ7LrTWDGxwVKns/OA19d5S0jOeCPk5uZwaTrjwr1H9Ax7B+ESA+fqWsW4Xbf8C0=
X-Received: by 2002:a5e:c111:: with SMTP id v17mr7024701iol.300.1583155251966;
 Mon, 02 Mar 2020 05:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
In-Reply-To: <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 14:20:41 +0100
Message-ID: <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 1, 2020 at 2:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
> > +             connected |= (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED);
> > +     rcu_read_unlock();
>
> Are the parentheses around the comparison necessary?
Looks not. Will drop.

> > +static struct rtrs_permit *
> > +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> > +{
> > +     size_t max_depth = clt->queue_depth;
> > +     struct rtrs_permit *permit;
> > +     int cpu, bit;
> > +
> > +     /* Combined with cq_vector, we pin the IO to the the cpu it comes */
>
> This comment is confusing. Please clarify this comment. All I see below
> is that preemption is disabled. I don't see pinning of I/O to the CPU of
> the caller.
The comment is addressing a use-case of the driver: The user can
assign (under /proc/irq/) the irqs of the HCA cq_vectors "one-to-one"
to each cpu. This will "force" the driver to process io response on
the same cpu the io has been submitted on.
In the code below only preemption is disabled. This can lead to the
situation that callers from different cpus will grab the same bit,
since find_first_zero_bit is not atomic. But then the
test_and_set_bit_lock will fail for all the callers but one, so that
they will loop again. This way an explicit spinlock is not required.
Will extend the comment.

> > +     cpu = get_cpu();
> > +     do {
> > +             bit = find_first_zero_bit(clt->permits_map, max_depth);
> > +             if (unlikely(bit >= max_depth)) {
> > +                     put_cpu();
> > +                     return NULL;
> > +             }
> > +
> > +     } while (unlikely(test_and_set_bit_lock(bit, clt->permits_map)));
> > +     put_cpu();
> > +
> > +     permit = GET_PERMIT(clt, bit);
> > +     WARN_ON(permit->mem_id != bit);
> > +     permit->cpu_id = cpu;
> > +     permit->con_type = con_type;
> > +
> > +     return permit;
> > +}
>
> Please remove the blank line before "} while (...)".
OK.

> > +void rtrs_clt_put_permit(struct rtrs_clt *clt, struct rtrs_permit *permit)
> > +{
> > +     if (WARN_ON(!test_bit(permit->mem_id, clt->permits_map)))
> > +             return;
> > +
> > +     __rtrs_put_permit(clt, permit);
> > +
> > +     /*
> > +      * Putting a permit is a barrier, so we will observe
> > +      * new entry in the wait list, no worries.
> > +      */
> > +     if (waitqueue_active(&clt->permits_wait))
> > +             wake_up(&clt->permits_wait);
> > +}
> > +EXPORT_SYMBOL(rtrs_clt_put_permit);
>
> The comment in the above function is not only confusing but it also
> fails to explain why it is safe to guard wake_up() with a
> waitqueue_active() check. How about changing that comment into the
> following:
>
> rtrs_clt_get_permit() adds itself to the &clt->permits_wait list before
> calling schedule(). So if rtrs_clt_get_permit() is sleeping it must have
> added itself to &clt->permits_wait before __rtrs_put_permit() finished.
> Hence it is safe to guard wake_up() with a waitqueue_active() test.
Yes, this is definitely more clear.

> > +static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
> > +                             struct rtrs_clt_io_req *req,
> > +                             struct rtrs_rbuf *rbuf, u32 off,
> > +                             u32 imm, struct ib_send_wr *wr)
> > +{
> > +     struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> > +     enum ib_send_flags flags;
> > +     struct ib_sge sge;
> > +
> > +     if (unlikely(!req->sg_size)) {
> > +             rtrs_wrn(con->c.sess,
> > +                      "Doing RDMA Write failed, no data supplied\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* user data and user message in the first list element */
> > +     sge.addr   = req->iu->dma_addr;
> > +     sge.length = req->sg_size;
> > +     sge.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
> > +
> > +     /*
> > +      * From time to time we have to post signalled sends,
> > +      * or send queue will fill up and only QP reset can help.
> > +      */
> > +     flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
> > +                     0 : IB_SEND_SIGNALED;
> > +
> > +     ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
> > +                                   req->sg_size, DMA_TO_DEVICE);
> > +
> > +     return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, &sge, 1,
> > +                                         rbuf->rkey, rbuf->addr + off,
> > +                                         imm, flags, wr);
> > +}
>
> I don't think that posting a signalled send from time to time is
> sufficient to prevent send queue overflow. Please address Jason's
> comment from January 7th: "Not quite. If the SQ depth is 16 and you post
> 16 things and then signal the last one, you *cannot* post new work until
> you see the completion. More SQ space *ONLY* becomes available upon
> receipt of a completion. This is why you can't have an unsignaled SQ."

> See also https://lore.kernel.org/linux-rdma/20200107182528.GB26174@ziepe.ca/
In our case we set the send queue of each QP belonging to one
"session" to the one supported by the hardware (max_qp_wr) which is
around 5K on our hardware. The queue depth of our "session" is 512.
Those 512 are "shared" by all the QPs (number of CPUs on client side)
belonging to that session. So we have at most 512 and 512/num_cpus on
average inflights on each QP. We never experienced send queue full
event in any of our performance tests or production usage. The
alternative would be to count submitted requests and completed
requests, check the difference before submission and wait if the
difference multiplied by the queue depth of "session" exceeds the max
supported by the hardware. The check will require quite some code and
will most probably affect performance. I do not think it is worth it
to introduce a code path which is triggered only on a condition which
is known to never become true.
Jason, do you think it's necessary to implement such tracking?

>
> > +static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
> > +                                  struct rtrs_clt_sess *sess,
> > +                                  rtrs_conf_fn *conf,
> > +                                  struct rtrs_permit *permit, void *priv,
> > +                                  const struct kvec *vec, size_t usr_len,
> > +                                  struct scatterlist *sg, size_t sg_cnt,
> > +                                  size_t data_len, int dir)
> > +{
> > +     struct iov_iter iter;
> > +     size_t len;
> > +
> > +     req->permit = permit;
> > +     req->in_use = true;
> > +     req->usr_len = usr_len;
> > +     req->data_len = data_len;
> > +     req->sglist = sg;
> > +     req->sg_cnt = sg_cnt;
> > +     req->priv = priv;
> > +     req->dir = dir;
> > +     req->con = rtrs_permit_to_clt_con(sess, permit);
> > +     req->conf = conf;
> > +     req->need_inv = false;
> > +     req->need_inv_comp = false;
> > +     req->inv_errno = 0;
> > +
> > +     iov_iter_kvec(&iter, READ, vec, 1, usr_len);
> > +     len = _copy_from_iter(req->iu->buf, usr_len, &iter);
> > +     WARN_ON(len != usr_len);
> > +
> > +     reinit_completion(&req->inv_comp);
> > +}
>
> It is hard to verify whether the above function initializes all fields
> of 'req' or not. Consider changing the 'req' member assignments into
> something like *req = (struct rtrs_clt_io_req){ .permit = permit, ... };
OK.

> > +static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
> > +                                 struct rtrs_clt_io_req *req,
> > +                                 struct rtrs_rbuf *rbuf,
> > +                                 u32 size, u32 imm)
> > +{
> > +     struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> > +     struct ib_sge *sge = req->sge;
> > +     enum ib_send_flags flags;
> > +     struct scatterlist *sg;
> > +     size_t num_sge;
> > +     int i;
> > +
> > +     for_each_sg(req->sglist, sg, req->sg_cnt, i) {
> > +             sge[i].addr   = sg_dma_address(sg);
> > +             sge[i].length = sg_dma_len(sg);
> > +             sge[i].lkey   = sess->s.dev->ib_pd->local_dma_lkey;
> > +     }
> > +     sge[i].addr   = req->iu->dma_addr;
> > +     sge[i].length = size;
> > +     sge[i].lkey   = sess->s.dev->ib_pd->local_dma_lkey;
> > +
> > +     num_sge = 1 + req->sg_cnt;
> > +
> > +     /*
> > +      * From time to time we have to post signalled sends,
> > +      * or send queue will fill up and only QP reset can help.
> > +      */
> > +     flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
> > +                     0 : IB_SEND_SIGNALED;
> > +
> > +     ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
> > +                                   size, DMA_TO_DEVICE);
> > +
> > +     return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, sge, num_sge,
> > +                                         rbuf->rkey, rbuf->addr, imm,
> > +                                         flags, NULL);
> > +}
>
> Same comment here. Posting a signalled send from time to time is not
> sufficient to prevent send queue overflow.
See above.

>
> > +             memset(&rwr, 0, sizeof(rwr));
> > +             rwr.wr.next = NULL;
> > +             rwr.wr.opcode = IB_WR_REG_MR;
> > +             rwr.wr.wr_cqe = &fast_reg_cqe;
> > +             rwr.wr.num_sge = 0;
> > +             rwr.mr = req->mr;
> > +             rwr.key = req->mr->rkey;
> > +             rwr.access = (IB_ACCESS_LOCAL_WRITE |
> > +                           IB_ACCESS_REMOTE_WRITE);
>
> How about changing the above code into rwr = (struct ib_reg_wr){.wr = {
> ... }, ... };?
>
Can be done, thanks.

> > +static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
> > +{
> > +     struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> > +     struct rtrs_clt *clt = sess->clt;
> > +     struct rtrs_msg_conn_req msg;
> > +     struct rdma_conn_param param;
> > +
> > +     int err;
> > +
> > +     memset(&param, 0, sizeof(param));
> > +     param.retry_count = 7;
> > +     param.rnr_retry_count = 7;
> > +     param.private_data = &msg;
> > +     param.private_data_len = sizeof(msg);
> > +
> > +     /*
> > +      * Those two are the part of struct cma_hdr which is shared
> > +      * with private_data in case of AF_IB, so put zeroes to avoid
> > +      * wrong validation inside cma.c on receiver side.
> > +      */
> > +     msg.__cma_version = 0;
> > +     msg.__ip_version = 0;
> > +     msg.magic = cpu_to_le16(RTRS_MAGIC);
> > +     msg.version = cpu_to_le16(RTRS_PROTO_VER);
> > +     msg.cid = cpu_to_le16(con->c.cid);
> > +     msg.cid_num = cpu_to_le16(sess->s.con_num);
> > +     msg.recon_cnt = cpu_to_le16(sess->s.recon_cnt);
> > +     uuid_copy(&msg.sess_uuid, &sess->s.uuid);
> > +     uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
> > +
> > +     err = rdma_connect(con->c.cm_id, &param);
> > +     if (err)
> > +             rtrs_err(clt, "rdma_connect(): %d\n", err);
> > +
> > +     return err;
> > +}
>
> Please use structure assignment instead of memset() followed by a series
> of member assignments.
OK

> > +static inline bool xchg_sessions(struct rtrs_clt_sess __rcu **rcu_ppcpu_path,
> > +                              struct rtrs_clt_sess *sess,
> > +                              struct rtrs_clt_sess *next)
> > +{
> > +     struct rtrs_clt_sess **ppcpu_path;
> > +
> > +     /* Call cmpxchg() without sparse warnings */
> > +     ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
> > +     return (sess == cmpxchg(ppcpu_path, sess, next));
> > +}
>
> Did checkpatch report for the above code that "return is not a function"?
No it didn't... But we can remove the parentheses.

> > +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> > +                                   struct rtrs_addr *addr)
> > +{
> > +     struct rtrs_clt *clt = sess->clt;
> > +
> > +     mutex_lock(&clt->paths_mutex);
> > +     clt->paths_num++;
> > +
> > +     /*
> > +      * Firstly increase paths_num, wait for GP and then
> > +      * add path to the list.  Why?  Since we add path with
> > +      * !CONNECTED state explanation is similar to what has
> > +      * been written in rtrs_clt_remove_path_from_arr().
> > +      */
> > +     synchronize_rcu();
> > +
> > +     list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> > +     mutex_unlock(&clt->paths_mutex);
> > +}
>
> At least in the Linux kernel keeping track of the number of elements in
> a list is considered bad practice. What prevents removal of the
> 'paths_num' counter?

We need paths_num for our failover and multipath (load balancing)
mechanism. We use the list of paths as a ring. We want to choose the
"next" path for every new IO (i.e. round robin or path with minimal
number of inflights). I.e. if there is only one path then we always
choose it. If sending fails then we want to try resending the IO on
every other path but only once. Only for that reason (try sending an
IO on every possible path once) we need that paths_num variable. In
other words: we have that do_each_path/while_each_path macro, which
must make a full loop over the list of paths before failing but not
loop for ever. This loop can happen in parallel with path adding and
removal. Only traversing the list is not enough: we want to prevent
going over the list more than one time:
 693 #define do_each_path(path, clt, it) {                                   \
 694         path_it_init(it, clt);                                          \
 695         rcu_read_lock();                                                \
 696         for ((it)->i = 0; ((path) = ((it)->next_path)(it)) &&           \
 697                           (it)->i < (it)->clt->paths_num;               \
 698              (it)->i++)

> > +static void rtrs_clt_dev_release(struct device *dev)
> > +{
> > +     struct rtrs_clt *clt  = container_of(dev, struct rtrs_clt, dev);
> > +
> > +     kfree(clt);
> > +}
>
> Please surround the assignment operator with only a single space at each
> side.
OK
>
> > +int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
> > +                                  const struct attribute *sysfs_self)
> > +{
> > +     struct rtrs_clt *clt = sess->clt;
> > +     enum rtrs_clt_state old_state;
> > +     bool changed;
> > +
> > +     /*
> > +      * That can happen only when userspace tries to remove path
> > +      * very early, when rtrs_clt_open() is not yet finished.
> > +      */
> > +     if (!clt->opened)
> > +             return -EBUSY;
> > +
> > +     /*
> > +      * Continue stopping path till state was changed to DEAD or
> > +      * state was observed as DEAD:
> > +      * 1. State was changed to DEAD - we were fast and nobody
> > +      *    invoked rtrs_clt_reconnect(), which can again start
> > +      *    reconnecting.
> > +      * 2. State was observed as DEAD - we have someone in parallel
> > +      *    removing the path.
> > +      */
> > +     do {
> > +             rtrs_clt_close_conns(sess, true);
> > +     } while (!(changed = rtrs_clt_change_state_get_old(sess,
> > +                                                         RTRS_CLT_DEAD,
> > +                                                         &old_state)) &&
> > +                old_state != RTRS_CLT_DEAD);
>
> Did checkpatch ask not to use an assignment in the while-loop condition?
No, checkpatch seems to be fine with it. But looks we can move the
assignment into the loop.

Thank you,
Danil

>
> Thanks,
>
> Bart.
