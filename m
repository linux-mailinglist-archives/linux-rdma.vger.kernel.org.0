Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99412E811
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 16:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgABP1t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 10:27:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39368 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgABP1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 10:27:49 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so8759669ioh.6
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuGmkaJu1UfI6YMMJvZiG3h7yvuBPE+FwkjyCnxeW3U=;
        b=V2qRdo33wQH3K9VbyDnzZ9lHZVq4OZwJU17msFoJlUrkekDpMW8uH1334NGxtlDJH3
         MdUCQ0QCWQYu38n4OoC3LLWma9ShVdtXKpNZ9CeyfG/qTHcnIqVE7jZAyZpBAZa8CMMW
         BRLixdyyle+h2Aj3VhPdvYqcC85AePbSphM0f0Be3DRfIokLoz8EnJ85QLuyGPE+EyS1
         9vQer/ZU3ke+AO6gneI9BjIcGauPI5QB4SLWrIcZAyE3iAcCNlsQ5t9NORTR4sfG0r5b
         BYY08sxVcAie5qidPp4GkfgRxtWo/otTLIqEREfpxA4NFUKRJvQH+FhOZ2pSL7KsP3ZJ
         FqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuGmkaJu1UfI6YMMJvZiG3h7yvuBPE+FwkjyCnxeW3U=;
        b=gtPN0rNQrSSLmciafk+4JPjCPDm+oMVhal2n6O5ZS82dHMkQ044DnfXC6fW8gsF0su
         Dy0qGoGwZjUdRIJx2WuRRuwy9IXZAXek5iBEssBhGJazZtOJgRMAFcv4acrQvFyHPrkA
         ueOUdEw8+D5FzndsGHuRuEQsxsFCxIHRNux48TmLScUKyOLeNmnqAW/vd6PoGadCaGuz
         +HkLrbPVYnH87FBH+AkEry3VkmRy22uwZDte+84apgRSEffuWyib+6+l2AECGmK8FQCD
         QYtjlLiIndepAramjctZamSDkf+8Jb0SMgl8Jlxt4BkRG6qIV03+KgAN/nf62c/nHKc9
         xdmQ==
X-Gm-Message-State: APjAAAXZ4MMlvhFNdGjk47S4UAoiD7FVXuYRJfNPpn5WU4zrmPxv1x7j
        Y2252fVrfYriX2TWNczjWbJmyB0Dt1AO3pJOYwYoDw==
X-Google-Smtp-Source: APXvYqxfMEEVrQIhsuKukYdR8w0Qg4Kv4C022IoSpGwR8Ko29fB7ufz5BZGQHsEFtBLAvm++FQ5TsRMw85Zouo2Zwqc=
X-Received: by 2002:a02:a610:: with SMTP id c16mr64226215jam.13.1577978868146;
 Thu, 02 Jan 2020 07:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-4-jinpuwang@gmail.com>
 <b13eccdd-09a2-70d5-1c78-3c4dbf1aefe8@acm.org>
In-Reply-To: <b13eccdd-09a2-70d5-1c78-3c4dbf1aefe8@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 16:27:37 +0100
Message-ID: <CAMGffEmC3T9M+RmeOXX4ecE3E01azjD8fz2Lz8kHC9Ff-Xx-Aw@mail.gmail.com>
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs
 and helpers
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

On Mon, Dec 30, 2019 at 8:48 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > + * InfiniBand Transport Layer
>
> Is RTRS an InfiniBand or an RDMA transport layer?
The later,  will fix.
>
> > +#define rtrs_prefix(obj) (obj->sessname)
>
> Is it really worth it to introduce a macro for accessing a single member
> of a single pointer?
maybe not, will remove.
>
> > + * InfiniBand Transport Layer
>
> Same question here: is RTRS an InfiniBand or an RDMA transport layer?
will fix.

>
> > +enum {
> > +     SERVICE_CON_QUEUE_DEPTH = 512,
>
> What is a service connection?
s/SERVICE_CON_QUEUE_DEPTH/CON_QUEUE_DEPTH/g, do you think
CON_QUEUE_DEPTH is better or just QUEUE_DEPTH?
>
> > +     /*
> > +      * With the current size of the tag allocated on the client, 4K
> > +      * is the maximum number of tags we can allocate.  This number is
> > +      * also used on the client to allocate the IU for the user connection
> > +      * to receive the RDMA addresses from the server.
> > +      */
>
> What does the word 'tag' mean in the context of the RTRS protocol?
should be struct rtrs_permit, will fix.
>
> > +struct rtrs_ib_dev;
>
> What does the "rtrs_ib_dev" data structure represent? Additionally, I
> think it's confusing that a single name has an "r" that refers to "RDMA"
> and "ib" that refers to InfiniBand.
Naming is hard, it's structure mainly to cache struct ib_device
pointer and ib_pd pointer.
more info can be found below, Roman did try to push it to upstream,
see comment below.
>
> > +struct rtrs_ib_dev_pool {
> > +     struct mutex            mutex;
> > +     struct list_head        list;
> > +     enum ib_pd_flags        pd_flags;
> > +     const struct rtrs_ib_dev_pool_ops *ops;
> > +};
>
> What is the purpose of an rtrs_ib_dev_pool and what does it contain?
The idea was documented in the patchset here:
https://www.spinics.net/lists/linux-rdma/msg64025.html
"'
This is an attempt to make a device pool API out of a common code,
which caches pair of ib_device and ib_pd pointers. I found 4 places,
where this common functionality can be replaced by some lib calls:
nvme, nvmet, iser and isert. Total deduplication gain in loc is not
quite significant, but eventually new ULP IB code can also require
the same device/pd pair cache, e.g. in our IBTRS module the same
code has to be repeated again, which was observed by Sagi and he
suggested to make a common helper function instead of producing
another copy.
'''

>
> > +struct rtrs_iu {
>
> A comment that explains what the "iu" abbreviation stands for would be
> welcome.
ok.
>
> > +/**
> > + * enum rtrs_msg_types - RTRS message types.
> > + * @RTRS_MSG_INFO_REQ:               Client additional info request to the server
> > + * @RTRS_MSG_INFO_RSP:               Server additional info response to the client
> > + * @RTRS_MSG_WRITE:          Client writes data per RDMA to server
> > + * @RTRS_MSG_READ:           Client requests data transfer from server
> > + * @RTRS_MSG_RKEY_RSP:               Server refreshed rkey for rbuf
> > + */
>
> What is "additional info" in this context?
We have a bit more documentation in rtrs/README in patch 14,
"'
3. After all connections of a path are established client sends to server the
RTRS_MSG_INFO_REQ message, containing the name of the session. This message
requests the address information from the server.

4. Server replies to the session info request message with RTRS_MSG_INFO_RSP,
which contains the addresses and keys of the RDMA buffers allocated for that
session.
"'
>
> > +/**
> > + * struct rtrs_msg_conn_req - Client connection request to the server
> > + * @magic:      RTRS magic
> > + * @version:    RTRS protocol version
> > + * @cid:        Current connection id
> > + * @cid_num:    Number of connections per session
> > + * @recon_cnt:          Reconnections counter
> > + * @sess_uuid:          UUID of a session (path)
> > + * @paths_uuid:         UUID of a group of sessions (paths)
> > + *
> > + * NOTE: max size 56 bytes, see man rdma_connect().
> > + */
> > +struct rtrs_msg_conn_req {
> > +     u8              __cma_version; /* Is set to 0 by cma.c in case of
> > +                                     * AF_IB, do not touch that.
> > +                                     */
> > +     u8              __ip_version;  /* On sender side that should be
> > +                                     * set to 0, or cma_save_ip_info()
> > +                                     * extract garbage and will fail.
> > +                                     */
>
> The above two fields and the comments next to it look suspicious to me.
> Does RTRS perhaps try to generate CMA-formatted messages without using
> the CMA to format these messages?
The problem is in cma_format_hdr over-writes the first byte for AF_IB
https://www.spinics.net/lists/linux-rdma/msg22397.html

No one fixes the problem since then.

>
> > +     u8              reserved[12];
>
> Please leave out the reserved data. If future versions of the protocol
> would need any of these bytes it is easy to add more data to this structure.
Sorry, we can't do that, as I explained in the past, we have code
running in production and
there are checks expecting the size the of message are the same, it
will make the transition
to upstream version in the future a lot harder if we change the size
of the controll message.
>
> > +/**
> > + * struct rtrs_msg_conn_rsp - Server connection response to the client
> > + * @magic:      RTRS magic
> > + * @version:    RTRS protocol version
> > + * @errno:      If rdma_accept() then 0, if rdma_reject() indicates error
> > + * @queue_depth:   max inflight messages (queue-depth) in this session
> > + * @max_io_size:   max io size server supports
> > + * @max_hdr_size:  max msg header size server supports
> > + *
> > + * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
> > + */
> > +struct rtrs_msg_conn_rsp {
> > +     __le16          magic;
> > +     __le16          version;
> > +     __le16          errno;
> > +     __le16          queue_depth;
> > +     __le32          max_io_size;
> > +     __le32          max_hdr_size;
> > +     __le32          flags;
> > +     u8              reserved[36];
> > +};
>
> Same comment here: please leave out the "reserved[]" array. Sending a
> bunch of zero-bytes at the end of a message over the wire is not useful.
same here.
>
> > +static inline void rtrs_from_imm(u32 imm, u32 *type, u32 *payload)
> > +{
> > +     *payload = (imm & MAX_IMM_PAYL_MASK);
> > +     *type = (imm >> MAX_IMM_PAYL_BITS);
> > +}
>
> Please do not use parentheses when not necessary. Such superfluous
> parentheses namely hurt readability of the code.
ok, will remove.
>
> > +     type = (w_inval ? RTRS_IO_RSP_W_INV_IMM : RTRS_IO_RSP_IMM);
>
> Same comment here: I think the parentheses can be left out from the
> above statement.
ok, will remove
>
> > +static inline void rtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
> > +{
> > +     /* 9 bits for errno, 19 bits for msg_id */
> > +     *msg_id = (payload & 0x7ffff);
>
> Are the parentheses in the above expression necessary?
will remove.
>
> > +     *errno = -(int)((payload >> 19) & 0x1ff);
>
> Is the '(int)' cast useful in the above expression? Can it be left out?
I think it's necessary, and make it more clear errno is a negative int
value, isn't it?

>
> > +#define STAT_ATTR(type, stat, print, reset)                          \
> > +STAT_STORE_FUNC(type, stat, reset)                                   \
> > +STAT_SHOW_FUNC(type, stat, print)                                    \
> > +static struct kobj_attribute stat##_attr =                           \
> > +             __ATTR(stat, 0644,                                      \
> > +                    stat##_show,                                     \
> > +                    stat##_store)
>
> Is the above use of __ATTR() perhaps an open-coded version of __ATTR_RW()?
right, will use __ATTR_RW() instead.
>
> Thanks,
>
> Bart.
Thanks Bart!
