Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D610C0194
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfI0I4b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 04:56:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfI0I4b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 04:56:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so1789853wro.4
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfXue9T2NkQBattDkXEon2NvQgVQztlS6k0o1+O9NR0=;
        b=UjKJwYJryZcxHCXwQqzpWtx7u991HKb7WQkoTDphhyFcp+NE6J2M5rolmd9lkRTnXN
         C4AYPPAF8iVymbgKGXxwj1Js/d5pavwIOj5zRhLYh38nNpK4t1EwK0JmHHLubh2oGbBy
         D4YikOeHQ0nMpPAMhWGQ8uwv7xt1TrHHLCVouCe4bcD3wMu+cJnfNKjmbZPEhTf/zYQ1
         EYj+BITqrZK9+eqJoOk1HeSsQRutPLl1R9sApgpiF9ya4c/EK9DKa/h2amlD+XNl9eUC
         U2rGO97uvHdABQ5+pYr/1tTIiACq9q+YdIiZhc/IDpqEGdU2ffc1OppOpgtoyMlZyESp
         7AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfXue9T2NkQBattDkXEon2NvQgVQztlS6k0o1+O9NR0=;
        b=iyTaQpfE/TUvB9QQSXnDNcJAbpEZiXTB4E0sjljynuxzjmrkn/jkY0qAZrASGqGXiT
         CSJJW0IjUi1VD7XWIqbldp+8e7TMr+RW/LKUX9t3OFRE1nrDSo9kspCZ6OOAxQrzOQnU
         RrC1MpRqhnBctuxbLFMn82ZHcL1Xiyl5YeWIgRyLZRrAPWSJdl0B0Eg8Nzr4qWVkofw7
         /4+w83i24MBnb7lmnAsnEMm8UP5ti6FRkqmVfCBCvBCoyuXCA5nTK7jy67Bsll9Tx0aB
         0SfB1+a/pBeWkuc21Kxpq77HM4xCjHkYnTL6MFWVPs4VL1nvQGdt0cVVSO1+W5SIb0Xy
         Ytzg==
X-Gm-Message-State: APjAAAWZe8D73SH5i07IjYdiEH/ssHlVYZsiGtBPJ6jUs9BCaQBjk+kF
        u14QRB/y7flW7NbhEkP27jyv+LsWZPwuEaQn0ONhPA==
X-Google-Smtp-Source: APXvYqxfWyaZuRbOnAwrVlspvqQMOlUGBXujPtXA5C42+fyPB1kYHoqubhTogBMEJYCXzLDa7+1kLUmFpNdgFEhvi5k=
X-Received: by 2002:adf:d192:: with SMTP id v18mr1043108wrc.9.1569574588074;
 Fri, 27 Sep 2019 01:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-4-jinpuwang@gmail.com>
 <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
In-Reply-To: <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 10:56:17 +0200
Message-ID: <CAMGffEmJ3_HSQ=i3Xq3v=pN75DXpDmLfQ0SS6dkv40T1q9PMhQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] ibtrs: private headers with IBTRS protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 24, 2019 at 12:50 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +#define P1 )
> > +#define P2 ))
> > +#define P3 )))
> > +#define P4 ))))
> > +#define P(N) P ## N
> > +
> > +#define CAT(a, ...) PRIMITIVE_CAT(a, __VA_ARGS__)
> > +#define PRIMITIVE_CAT(a, ...) a ## __VA_ARGS__
> > +
> > +#define LIST(...)                                            \
> > +     __VA_ARGS__,                                            \
> > +     ({ unknown_type(); NULL; })                             \
> > +     CAT(P, COUNT_ARGS(__VA_ARGS__))                         \
> > +
> > +#define EMPTY()
> > +#define DEFER(id) id EMPTY()
> > +
> > +#define _CASE(obj, type, member)                             \
> > +     __builtin_choose_expr(                                  \
> > +     __builtin_types_compatible_p(                           \
> > +             typeof(obj), type),                             \
> > +             ((type)obj)->member
> > +#define CASE(o, t, m) DEFER(_CASE)(o, t, m)
> > +
> > +/*
> > + * Below we define retrieving of sessname from common IBTRS types.
> > + * Client or server related types have to be defined by special
> > + * TYPES_TO_SESSNAME macro.
> > + */
> > +
> > +void unknown_type(void);
> > +
> > +#ifndef TYPES_TO_SESSNAME
> > +#define TYPES_TO_SESSNAME(...) ({ unknown_type(); NULL; })
> > +#endif
> > +
> > +#define ibtrs_prefix(obj)                                    \
> > +     _CASE(obj, struct ibtrs_con *,  sess->sessname),        \
> > +     _CASE(obj, struct ibtrs_sess *, sessname),              \
> > +     TYPES_TO_SESSNAME(obj)                                  \
> > +     ))
>
> No preprocessor voodoo please. Please remove all of the above and modify
> the logging statements such that these pass the proper name string as
> first argument to logging macros.
Sure, will do.
>
> > +struct ibtrs_msg_conn_req {
> > +     u8              __cma_version; /* Is set to 0 by cma.c in case of
> > +                                     * AF_IB, do not touch that. */
> > +     u8              __ip_version;  /* On sender side that should be
> > +                                     * set to 0, or cma_save_ip_info()
> > +                                     * extract garbage and will fail. */
> > +     __le16          magic;
> > +     __le16          version;
> > +     __le16          cid;
> > +     __le16          cid_num;
> > +     __le16          recon_cnt;
> > +     uuid_t          sess_uuid;
> > +     uuid_t          paths_uuid;
> > +     u8              reserved[12];
> > +};
>
> Please remove the reserved[] array and check private_data_len in the
> code that receives the login request.
We already checked the private_data_len on server side, see ibtrs_rdma_connect,
and keep some reserved fields for future seems to be common practice
for protocol, IMO.
Also due to the fact, we already running the code in production, we
want to keep the protocol compatible, so future
transition could be smooth.
>
> > +/**
> > + * struct ibtrs_msg_conn_rsp - Server connection response to the client
> > + * @magic:      IBTRS magic
> > + * @version:    IBTRS protocol version
> > + * @errno:      If rdma_accept() then 0, if rdma_reject() indicates error
> > + * @queue_depth:   max inflight messages (queue-depth) in this session
> > + * @max_io_size:   max io size server supports
> > + * @max_hdr_size:  max msg header size server supports
> > + *
> > + * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
> > + */
> > +struct ibtrs_msg_conn_rsp {
> > +     __le16          magic;
> > +     __le16          version;
> > +     __le16          errno;
> > +     __le16          queue_depth;
> > +     __le32          max_io_size;
> > +     __le32          max_hdr_size;
> > +     u8              reserved[40];
> > +};
>
> Same comment here: please remove the reserved[] array and check
> private_data_len in the code that processes this data structure.
Ditto.
>
> > +static inline int sockaddr_cmp(const struct sockaddr *a,
> > +                            const struct sockaddr *b)
> > +{
> > +     switch (a->sa_family) {
> > +     case AF_IB:
> > +             return memcmp(&((struct sockaddr_ib *)a)->sib_addr,
> > +                           &((struct sockaddr_ib *)b)->sib_addr,
> > +                           sizeof(struct ib_addr));
> > +     case AF_INET:
> > +             return memcmp(&((struct sockaddr_in *)a)->sin_addr,
> > +                           &((struct sockaddr_in *)b)->sin_addr,
> > +                           sizeof(struct in_addr));
> > +     case AF_INET6:
> > +             return memcmp(&((struct sockaddr_in6 *)a)->sin6_addr,
> > +                           &((struct sockaddr_in6 *)b)->sin6_addr,
> > +                           sizeof(struct in6_addr));
> > +     default:
> > +             return -ENOENT;
> > +     }
> > +}
> > +
> > +static inline int sockaddr_to_str(const struct sockaddr *addr,
> > +                                char *buf, size_t len)
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
>
> Since these functions are not in the hot path, please move these into a
> .c file.
ok.
>
> > +/**
> > + * ibtrs_invalidate_flag() - returns proper flags for invalidation
> > + *
> > + * NOTE: This function is needed for compat layer, so think twice before
> > + *       rename or remove.
> > + */
> > +static inline u32 ibtrs_invalidate_flag(void)
> > +{
> > +     return IBTRS_MSG_NEED_INVAL_F;
> > +}
>
> An inline function that does nothing else than returning a compile-time
> constant? That does not look useful to me. How about inlining this function?
This is needed for the compact layer, we redefine some FR functions to
use FMR for our
ConnectX2 X3 HCA.
https://github.com/ionos-enterprise/ibnbd/tree/master/ibtrs/compat
It will finally fade out, but it will take time.


Thanks,
Jinpu
