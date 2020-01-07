Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2E132615
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 13:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgAGMWz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 07:22:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43689 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgAGMWz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 07:22:55 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so50799671ioo.10
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 04:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijZNngKPrbpiSHbp4EiHV97XJQRwKlTlChFvzqASRMA=;
        b=Cm9biH+3ATJN5g8MDXRplcSjNciYoVcPO+YfgEvfUUDhDOQq2jZ+mQEKh7RYyzUtis
         fk1b3RExekpJB28oXbIJ22GjfE7nu4Y4GGkS4RjF2TZNg0xixmV6JuJRkpK4/9IOd+Ix
         hXFY3++03Y4VWwtvL1uQ3/MtxJkdqP+sbUb8/hNBhylBKVBafTKx3hi4bPliMQMMQ30q
         lr1QrJAhKsUwlCXGvikqYtWACW3p/oDqj1pUr5fQNkWK03hPW8udvT06VItLXUAfbitD
         xSoyksHpWjFzo9tONLKYO/HxX6HOqkJWPdyfYfR4CArqJMQdZWg+593v/Z/a0MHebGbl
         ZHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijZNngKPrbpiSHbp4EiHV97XJQRwKlTlChFvzqASRMA=;
        b=Zg+l8jlNYHvbioCo/iec5mqhrzrZ/M38+JMj9QmYEmbQDFqyjA9AjHsX+AFNTBs9Mb
         oDarCABS+IXitWOY4y2d0brdFXY3ztZ6MG4rHyM6L21V0OXMpGW75qNGS9fumzGAvlyQ
         fgfR6wTxG5xt3wEZTEsUAqPSBgt2QQZ5z2DpWxZasixPBgMsxf8Q4tWmVOrjUokxZAK6
         sThPur3wGRDBUAsOC5DiHcfLYo/CpSfM8M72SJ+2kDr6tf7UbXJDzBM6Ux5qKfbcBab0
         IpgyTn6yJ6qX57/wJnN1+9Hf/F9DKx0S3BypjPIAC6zhZh9uAZoPMayU1P0JjJ/PGwKY
         1KAw==
X-Gm-Message-State: APjAAAW0jiD+YfgOAVOJMsv/heCXROubilZSetaVOttMCI3sgl6j41kK
        EhTobfTPiQ0C9oORzTq3A6lMq4dwigNPfO8rkt1wQA==
X-Google-Smtp-Source: APXvYqxV0x2hwLXk6oIkLLahjGsyv/VGTdKmH3T4AjccMGFd3R38jyCUczX0QPn05xVr+JlCKw6z3KDCzunxNzxKTPk=
X-Received: by 2002:a05:6602:25d3:: with SMTP id d19mr61296563iop.217.1578399774210;
 Tue, 07 Jan 2020 04:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-5-jinpuwang@gmail.com>
 <d4288d41-b000-9a98-d12a-0738a0f647e8@acm.org>
In-Reply-To: <d4288d41-b000-9a98-d12a-0738a0f647e8@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 13:22:43 +0100
Message-ID: <CAMGffEkG3N7ESyneN6PObq3L0Ps5cGSYboYac=Ti6yt-BqC2xA@mail.gmail.com>
Subject: Re: [PATCH v6 04/25] rtrs: core: lib functions shared between client
 and server modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 30, 2019 at 11:25 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > + * InfiniBand Transport Layer
>
> Is RTRS an InfiniBand or an RDMA transport layer?
will fix.
>
> > +MODULE_DESCRIPTION("RTRS Core");
>
> Please write out RTRS in full and consider changing the word "Core" into
> "client and server".
will do.
>
> > +     WARN_ON(!queue_size);
> > +     ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
> > +
> > +     if (unlikely(!ius))
> > +             return NULL;
>
> No blank line between the 'ius' assignment and the 'ius' check please.
ok.
>
> > +int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu)
> > +{
> > +     struct rtrs_sess *sess = con->sess;
> > +     struct ib_recv_wr wr;
> > +     const struct ib_recv_wr *bad_wr;
> > +     struct ib_sge list;
> > +
> > +     list.addr   = iu->dma_addr;
> > +     list.length = iu->size;
> > +     list.lkey   = sess->dev->ib_pd->local_dma_lkey;
> > +
> > +     if (WARN_ON(list.length == 0)) {
> > +             rtrs_wrn(con->sess,
> > +                       "Posting receive work request failed, sg list is empty\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     wr.next    = NULL;
> > +     wr.wr_cqe  = &iu->cqe;
> > +     wr.sg_list = &list;
> > +     wr.num_sge = 1;
> > +
> > +     return ib_post_recv(con->qp, &wr, &bad_wr);
> > +}
> > +EXPORT_SYMBOL_GPL(rtrs_iu_post_recv);
>
> The above code is fragile: although this is unlikely, if a member would
> be added in struct ib_sge or in struct ib_recv_wr then the above code
> will leave some member variables uninitialized. Has it been considered
> to initialize these structures using a single assignment statement, e.g.
> as follows:
>
>         wr = (struct ib_recv_wr) {
>                 .wr_cqe = ...,
>                 .sg_list = ...,
>                 .num_sge = 1,
>         };
Will do.
>
> > +int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe)
> > +{
> > +     struct ib_recv_wr wr;
> > +     const struct ib_recv_wr *bad_wr;
> > +
> > +     wr.next    = NULL;
> > +     wr.wr_cqe  = cqe;
> > +     wr.sg_list = NULL;
> > +     wr.num_sge = 0;
> > +
> > +     return ib_post_recv(con->qp, &wr, &bad_wr);
> > +}
> > +EXPORT_SYMBOL_GPL(rtrs_post_recv_empty);
>
> Same comment for this function.
dito.
>
> > +int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe)
> > +{
> > +     struct ib_recv_wr wr_arr[2], *wr;
> > +     const struct ib_recv_wr *bad_wr;
> > +     int i;
> > +
> > +     memset(wr_arr, 0, sizeof(wr_arr));
> > +     for (i = 0; i < ARRAY_SIZE(wr_arr); i++) {
> > +             wr = &wr_arr[i];
> > +             wr->wr_cqe  = cqe;
> > +             if (i)
> > +                     /* Chain backwards */
> > +                     wr->next = &wr_arr[i - 1];
> > +     }
> > +
> > +     return ib_post_recv(con->qp, wr, &bad_wr);
> > +}
> > +EXPORT_SYMBOL_GPL(rtrs_post_recv_empty_x2);
>
> I have not yet seen any other RDMA code that is similar to the above
> function. A comment above this function that explains its purpose would
> be more than welcome.
Will add comment.
>
> > +int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
> > +                    struct ib_send_wr *head)
> > +{
> > +     struct rtrs_sess *sess = con->sess;
> > +     struct ib_send_wr wr;
> > +     const struct ib_send_wr *bad_wr;
> > +     struct ib_sge list;
> > +
> > +     if ((WARN_ON(size == 0)))
> > +             return -EINVAL;
>
> No superfluous parentheses please.
ok

>
> > +     list.addr   = iu->dma_addr;
> > +     list.length = size;
> > +     list.lkey   = sess->dev->ib_pd->local_dma_lkey;
> > +
> > +     memset(&wr, 0, sizeof(wr));
> > +     wr.next       = NULL;
> > +     wr.wr_cqe     = &iu->cqe;
> > +     wr.sg_list    = &list;
> > +     wr.num_sge    = 1;
> > +     wr.opcode     = IB_WR_SEND;
> > +     wr.send_flags = IB_SEND_SIGNALED;
>
> Has it been considered to use designated initializers instead of a
> memset() followed by multiple assignments? Same question for
> rtrs_iu_post_rdma_write_imm() and rtrs_post_rdma_write_imm_empty().
Sounds good, will do.

>
> > +static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
> > +                  u16 wr_queue_size, u32 max_sge)
> > +{
> > +     struct ib_qp_init_attr init_attr = {NULL};
> > +     struct rdma_cm_id *cm_id = con->cm_id;
> > +     int ret;
> > +
> > +     init_attr.cap.max_send_wr = wr_queue_size;
> > +     init_attr.cap.max_recv_wr = wr_queue_size;
>
> What code is responsible for ensuring that neither max_send_wr nor
> max_recv_wr exceeds the device limits? Please document this in a comment
> above this function.
rtrs-clt/srv queries device limits for ensuring the settings will not
exceed the limits.
will add comment.

>
> > +     init_attr.cap.max_recv_sge = 1;
> > +     init_attr.event_handler = qp_event_handler;
> > +     init_attr.qp_context = con;
> > +#undef max_send_sge
> > +     init_attr.cap.max_send_sge = max_sge;
>
> Is the "undef max_send_sge" really necessary? If so, please add a
> comment that explains why it is necessary.
it's not, will remove.
>
> > +static int rtrs_str_gid_to_sockaddr(const char *addr, size_t len,
> > +                                  short port, struct sockaddr_storage *dst)
> > +{
> > +     struct sockaddr_ib *dst_ib = (struct sockaddr_ib *)dst;
> > +     int ret;
> > +
> > +     /*
> > +      * We can use some of the I6 functions since GID is a valid
> > +      * IPv6 address format
> > +      */
> > +     ret = in6_pton(addr, len, dst_ib->sib_addr.sib_raw, '\0', NULL);
> > +     if (ret == 0)
> > +             return -EINVAL;
>
> What is "I6"?
IPv6, will fix.
>
> Is the fourth argument to this function correct? From the comment above
> in6_pton(): "@delim: the delimiter of the IPv6 address in @src, -1 means
> no delimiter".
'\0' means end of the string here, seems correct to me.
>
> > +int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len)
> > +{
> > +     int cnt;
> > +
> > +     switch (addr->sa_family) {
> > +     case AF_IB:
> > +             cnt = scnprintf(buf, len, "gid:%pI6",
> > +                     &((struct sockaddr_ib *)addr)->sib_addr.sib_raw);
> > +             return cnt;
> > +     case AF_INET:
> > +             cnt = scnprintf(buf, len, "ip:%pI4",
> > +                     &((struct sockaddr_in *)addr)->sin_addr);
> > +             return cnt;
> > +     case AF_INET6:
> > +             cnt = scnprintf(buf, len, "ip:%pI6c",
> > +                       &((struct sockaddr_in6 *)addr)->sin6_addr);
> > +             return cnt;
> > +     }
> > +     cnt = scnprintf(buf, len, "<invalid address family>");
> > +     pr_err("Invalid address family\n");
> > +     return cnt;
> > +}
> > +EXPORT_SYMBOL(sockaddr_to_str);
>
> Is the pr_err() statement in the above function useful? Will anyone be
> able to figure out what is going on if the "Invalid address family"
> string appears in the system log? Please consider changing that pr_err()
> statement into a WARN_ON_ONCE() statement.
I expect the caller should also print something in syslog, combine
them togather will help.
>
> > +     ret = rtrs_str_to_sockaddr(str, len, port, addr->dst);
> > +
> > +     return ret;
>
> Please change this into a single return statement.
ok
>
> > +EXPORT_SYMBOL(rtrs_addr_to_sockaddr);
> > +
> > +void rtrs_ib_dev_pool_init(enum ib_pd_flags pd_flags,
> > +                         struct rtrs_ib_dev_pool *pool)
> > +{
> > +     WARN_ON(pool->ops && (!pool->ops->alloc ^ !pool->ops->free));
> > +     INIT_LIST_HEAD(&pool->list);
> > +     mutex_init(&pool->mutex);
> > +     pool->pd_flags = pd_flags;
> > +}
> > +EXPORT_SYMBOL(rtrs_ib_dev_pool_init);
> > +
> > +void rtrs_ib_dev_pool_deinit(struct rtrs_ib_dev_pool *pool)
> > +{
> > +     WARN_ON(!list_empty(&pool->list));
> > +}
> > +EXPORT_SYMBOL(rtrs_ib_dev_pool_deinit);
>
> Since rtrs_ib_dev_pool_init() calls mutex_init(), should
> rtrs_ib_dev_pool_deinit() call mutex_destroy()?
You're right.

>
> Thanks,
>
> Bart.
>
Thanks Bart.
