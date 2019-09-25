Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8692CBE36D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442976AbfIYRgz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 13:36:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39956 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440165AbfIYRgz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 13:36:55 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so897231iof.7
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5y9OdT+mqLC4BnlP3nfsBqkYX+ZY9L/bSXBmJL8kQU=;
        b=PdiAzlYWcA/TulEjeZ7jyyXUM1J/DPARdvXU3m/uv9jasshoHt7OXxaFBwY0fGQlZu
         Kk5KOrnCkwfUPHWByOeHtBbGft1LMPKmMn1cOJUozXerJJurPDs/vbVbiVobNAZOHQ5e
         aNaELDZM6RlTJUGUbfqI/VJ/MECqM2I4HIuqEdPfb5J9g0H2q2W42xtHW6Qp6EdHzRvy
         WhJKazEeRv5qU+SazNqZUHhszNFRTp19GI4xylUFxF6iQKgobdLVeXibfnLRjxcAP1Uf
         gZ4nYrYO34/tBkQxVc6nXOpyFM0IXNkxZVUeHP8NBTpPt61CjQ77tIKmpIQVUNTEtyhe
         3tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5y9OdT+mqLC4BnlP3nfsBqkYX+ZY9L/bSXBmJL8kQU=;
        b=PZXwBCkDRCXiSnniabTHKR4brOTBZufwwNzEDNrhXGmDbXJw6zY+GX8eSzrxspjsG5
         gRuH+dMrJAjl/dnDm2xDGTjxzlFcAoNq7zxna8ybvHrsaGm7hC/8sXgFlBlDbpKbj/T2
         6gv4Y2WT/cbx8MpFkapivLJ8RtuN1jSG/4uIsmIKPqG7r1cjH2KYvy4TB4PuXIKCHEh8
         5BDQjkTL4TUf42Hi8qDKEuZ0xZ2AA5fH+l5xzQrGmfDMo6gXERErb8a1sU8wWyC+Sygb
         KeJQ7ZKZ/C2fzHRDR6Q57r0GdFW9NoRL7zeKDPVtp/SLYVW8TdfE4spLBp2Zygeo5Qwd
         44FA==
X-Gm-Message-State: APjAAAXLAAiC6CDONo+P7vdmk4bQo7pD5sKvBqFE7CXogkKeFEBb/4/k
        cDFuJMzfFpw7aUTWL98od0fni3Gji7JRhx7Wtwf/
X-Google-Smtp-Source: APXvYqx3foS9hh/ZQI99v7xEu2DYUT0VKBiI3jamGFxxjMpR/9Zw0LpdsbH3iMvZv/pKDzFBIOGLBSDJ65xPv3NjP88=
X-Received: by 2002:a5e:cb49:: with SMTP id h9mr466095iok.307.1569433013830;
 Wed, 25 Sep 2019 10:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org>
In-Reply-To: <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 19:36:42 +0200
Message-ID: <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hallo Bart,

On Mon, Sep 23, 2019 at 11:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +static const struct ibtrs_ib_dev_pool_ops dev_pool_ops;
> > +static struct ibtrs_ib_dev_pool dev_pool = {
> > +     .ops = &dev_pool_ops
> > +};
>
> Can the definitions in this file be reordered such that the forward
> declaration of dev_pool_ops can be removed?
Will try to.

> > +static void ibtrs_rdma_error_recovery(struct ibtrs_clt_con *con);
> > +static int ibtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
> > +                                  struct rdma_cm_event *ev);
> > +static void ibtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc);
> > +static void complete_rdma_req(struct ibtrs_clt_io_req *req, int errno,
> > +                           bool notify, bool can_wait);
> > +static int ibtrs_clt_write_req(struct ibtrs_clt_io_req *req);
> > +static int ibtrs_clt_read_req(struct ibtrs_clt_io_req *req);
>
> Please also remove these forward declarations.
OK

> > +bool ibtrs_clt_sess_is_connected(const struct ibtrs_clt_sess *sess)
> > +{
> > +     return sess->state == IBTRS_CLT_CONNECTED;
> > +}
>
> Is it really useful to introduce a one line function for testing the
> session state?
No, not in that case really, thanks.

> > +static inline struct ibtrs_tag *
> > +__ibtrs_get_tag(struct ibtrs_clt *clt, enum ibtrs_clt_con_type con_type)
> > +{
> > +     size_t max_depth = clt->queue_depth;
> > +     struct ibtrs_tag *tag;
> > +     int cpu, bit;
> > +
> > +     cpu = get_cpu();
> > +     do {
> > +             bit = find_first_zero_bit(clt->tags_map, max_depth);
> > +             if (unlikely(bit >= max_depth)) {
> > +                     put_cpu();
> > +                     return NULL;
> > +             }
> > +
> > +     } while (unlikely(test_and_set_bit_lock(bit, clt->tags_map)));
> > +     put_cpu();
> > +
> > +     tag = GET_TAG(clt, bit);
> > +     WARN_ON(tag->mem_id != bit);
> > +     tag->cpu_id = cpu;
> > +     tag->con_type = con_type;
> > +
> > +     return tag;
> > +}
>
> What is the role of the get_cpu() and put_cpu() calls in this function?
> How can it make sense to assign the cpu number to tag->cpu_id after
> put_cpu() has been called?
We disable preemption while looking for a free "ibtrs_tag" (permit) in
our tags_map. We store the cpu number the ibtrs_clt_get_tag() function
has been originally called on in the ibtrs_tag we just found, so that
when the user later would use this ibtrs_tag for an rdma operation
(ibtrs_clt_request()), we would select the rdma connection with
cq_vector corresponding to this cpu. If IRQ affinity is configured
accordingly, this enables for an IO response to be processed on the
same cpu the IO request was originally submitted on.

> > +static inline void ibtrs_clt_init_req(struct ibtrs_clt_io_req *req,
> > +                                   struct ibtrs_clt_sess *sess,
> > +                                   ibtrs_conf_fn *conf,
> > +                                   struct ibtrs_tag *tag, void *priv,
> > +                                   const struct kvec *vec, size_t usr_len,
> > +                                   struct scatterlist *sg, size_t sg_cnt,
> > +                                   size_t data_len, int dir)
> > +{
> > +     struct iov_iter iter;
> > +     size_t len;
> > +
> > +     req->tag = tag;
> > +     req->in_use = true;
> > +     req->usr_len = usr_len;
> > +     req->data_len = data_len;
> > +     req->sglist = sg;
> > +     req->sg_cnt = sg_cnt;
> > +     req->priv = priv;
> > +     req->dir = dir;
> > +     req->con = ibtrs_tag_to_clt_con(sess, tag);
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
> > +     if (sess->stats.enable_rdma_lat)
> > +             req->start_jiffies = jiffies;
> > +}
>
> A comment that explains what "req" stands for would be welcome. Since
> this function copies the entire payload, I assume that it is only used
> for control messages and not for reading or writing data from a block
> device?
Yes, we only copy control message provided by the user. Will extend
the description.

> > +static int ibtrs_clt_failover_req(struct ibtrs_clt *clt,
> > +                               struct ibtrs_clt_io_req *fail_req)
> > +{
> > +     struct ibtrs_clt_sess *alive_sess;
> > +     struct ibtrs_clt_io_req *req;
> > +     int err = -ECONNABORTED;
> > +     struct path_it it;
> > +
> > +     do_each_path(alive_sess, clt, &it) {
> > +             if (unlikely(alive_sess->state != IBTRS_CLT_CONNECTED))
> > +                     continue;
> > +             req = ibtrs_clt_get_copy_req(alive_sess, fail_req);
> > +             if (req->dir == DMA_TO_DEVICE)
> > +                     err = ibtrs_clt_write_req(req);
> > +             else
> > +                     err = ibtrs_clt_read_req(req);
> > +             if (unlikely(err)) {
> > +                     req->in_use = false;
> > +                     continue;
> > +             }
> > +             /* Success path */
> > +             ibtrs_clt_inc_failover_cnt(&alive_sess->stats);
> > +             break;
> > +     } while_each_path(&it);
> > +
> > +     return err;
> > +}
>
> Also for this function, a comment that explains the purpose of this
> function would be welcome.
Will add a description to it.

>
> > +static void fail_all_outstanding_reqs(struct ibtrs_clt_sess *sess)
> > +{
> > +     struct ibtrs_clt *clt = sess->clt;
> > +     struct ibtrs_clt_io_req *req;
> > +     int i, err;
> > +
> > +     if (!sess->reqs)
> > +             return;
> > +     for (i = 0; i < sess->queue_depth; ++i) {
> > +             req = &sess->reqs[i];
> > +             if (!req->in_use)
> > +                     continue;
> > +
> > +             /*
> > +              * Safely (without notification) complete failed request.
> > +              * After completion this request is still usebale and can
> > +              * be failovered to another path.
> > +              */
> > +             complete_rdma_req(req, -ECONNABORTED, false, true);
> > +
> > +             err = ibtrs_clt_failover_req(clt, req);
> > +             if (unlikely(err))
> > +                     /* Failover failed, notify anyway */
> > +                     req->conf(req->priv, err);
> > +     }
> > +}
>
> What guarantees that this function does not call complete_rdma_req()
> while complete_rdma_req() is called from the regular completion path?
Before calling this function all the qps are drained in
ibtrs_clt_stop_and_destroy_conns(...).

> > +static bool __ibtrs_clt_change_state(struct ibtrs_clt_sess *sess,
> > +                                  enum ibtrs_clt_state new_state)
> > +{
> > +     enum ibtrs_clt_state old_state;
> > +     bool changed = false;
> > +
> > +     old_state = sess->state;
> > +     switch (new_state) {
>
> Please use lockdep_assert_held() inside this function to verify at
> runtime that session state changes are serialized properly.
I haven't used lockdep_assert_held() before, will look into it.

> > +static enum ibtrs_clt_state ibtrs_clt_state(struct ibtrs_clt_sess *sess)
> > +{
> > +     enum ibtrs_clt_state state;
> > +
> > +     spin_lock_irq(&sess->state_wq.lock);
> > +     state = sess->state;
> > +     spin_unlock_irq(&sess->state_wq.lock);
> > +
> > +     return state;
> > +}
>
> Please remove this function and read sess->state without holding
> state_wq.lock.
ok.

> > +static void ibtrs_clt_hb_err_handler(struct ibtrs_con *c, int err)
> > +{
> > +     struct ibtrs_clt_con *con;
> > +
> > +     (void)err;
> > +     con = container_of(c, typeof(*con), c);
> > +     ibtrs_rdma_error_recovery(con);
> > +}
>
> Can "(void)err" be left out?
Yes
> Can the declaration and assignment of 'con' be merged into a single line
> of code?
Yes

> > +static int create_con(struct ibtrs_clt_sess *sess, unsigned int cid)
> > +{
> > +     struct ibtrs_clt_con *con;
> > +
> > +     con = kzalloc(sizeof(*con), GFP_KERNEL);
> > +     if (unlikely(!con))
> > +             return -ENOMEM;
> > +
> > +     /* Map first two connections to the first CPU */
> > +     con->cpu  = (cid ? cid - 1 : 0) % nr_cpu_ids;
> > +     con->c.cid = cid;
> > +     con->c.sess = &sess->s;
> > +     atomic_set(&con->io_cnt, 0);
> > +
> > +     sess->s.con[cid] = &con->c;
> > +
> > +     return 0;
> > +}
>
> The code to map a connection ID to onto a CPU occurs multiple times. Has
> it been considered to introduce a function for that mapping? Although
> one-line inline functions are not recommended in general, such a
> function will also make it easier to experiment with other mapping
> approaches, e.g. mapping hypertread siblings onto the same connection ID.
We have one connection for "user control messages" and as many
connections as cpus for actual IO traffic. They all have different
cq_vectors. This way one can experiment with any mapping by just
setting a different smp_affinity for the IRQs corresponding to this
cq_vectors under /proc/irq/.

> > +static inline bool xchg_sessions(struct ibtrs_clt_sess __rcu **rcu_ppcpu_path,
> > +                              struct ibtrs_clt_sess *sess,
> > +                              struct ibtrs_clt_sess *next)
> > +{
> > +     struct ibtrs_clt_sess **ppcpu_path;
> > +
> > +     /* Call cmpxchg() without sparse warnings */
> > +     ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
> > +     return (sess == cmpxchg(ppcpu_path, sess, next));
> > +}
>
> This looks suspicious. Has it been considered to protect changes of
> rcu_ppcpu_path with a mutex and to protect reads with an RCU read lock?
>
> > +static void ibtrs_clt_add_path_to_arr(struct ibtrs_clt_sess *sess,
> > +                                   struct ibtrs_addr *addr)
> > +{
> > +     struct ibtrs_clt *clt = sess->clt;
> > +
> > +     mutex_lock(&clt->paths_mutex);
> > +     clt->paths_num++;
> > +
> > +     /*
> > +      * Firstly increase paths_num, wait for GP and then
> > +      * add path to the list.  Why?  Since we add path with
> > +      * !CONNECTED state explanation is similar to what has
> > +      * been written in ibtrs_clt_remove_path_from_arr().
> > +      */
> > +     synchronize_rcu();
> > +
> > +     list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> > +     mutex_unlock(&clt->paths_mutex);
> > +}
>
> synchronize_rcu() while a mutex is being held? Really?
The construct around our multipath implementation has been checked
https://lkml.org/lkml/2018/5/18/659 and then validated (is "validated"
the right word for this?): https://lkml.org/lkml/2018/5/28/2080.

> > +static void ibtrs_clt_close_work(struct work_struct *work)
> > +{
> > +     struct ibtrs_clt_sess *sess;
> > +
> > +     sess = container_of(work, struct ibtrs_clt_sess, close_work);
> > +
> > +     cancel_delayed_work_sync(&sess->reconnect_dwork);
> > +     ibtrs_clt_stop_and_destroy_conns(sess);
> > +     /*
> > +      * Sounds stupid, huh?  No, it is not.  Consider this sequence:
> > +      *
> > +      *   #CPU0                              #CPU1
> > +      *   1.  CONNECTED->RECONNECTING
> > +      *   2.                                 RECONNECTING->CLOSING
> > +      *   3.  queue_work(&reconnect_dwork)
> > +      *   4.                                 queue_work(&close_work);
> > +      *   5.  reconnect_work();              close_work();
> > +      *
> > +      * To avoid that case do cancel twice: before and after.
> > +      */
> > +     cancel_delayed_work_sync(&sess->reconnect_dwork);
> > +     ibtrs_clt_change_state(sess, IBTRS_CLT_CLOSED);
> > +}
>
> The above code looks suspicious to me. I think there should be an
> additional state change at the start of this function to prevent that
> reconnect_dwork gets requeued after having been canceled
Will look into it again, thanks.

>
> > +static void ibtrs_clt_dev_release(struct device *dev)
> > +{
> > +     /* Nobody plays with device references, so nop */
> > +}
>
> That comment sounds wrong. Have you reviewed all of the device driver
> core code and checked that there is no code in there that manipulates
> struct device refcounts? I think the code that frees struct ibtrs_clt
> should be moved from free_clt() into the above function.

We only use the device to create an entry under /sys/class. free_clt()
is destroying sysfs first and unregisters the device afterwards. I
don't really see the need to free from the callback instead... Will
make it clear in the comment.

Thanks a lot,
Danil
