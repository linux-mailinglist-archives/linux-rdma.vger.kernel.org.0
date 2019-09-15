Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F70B3087
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2019 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfIOOaU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Sep 2019 10:30:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44030 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfIOOaU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Sep 2019 10:30:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so31615052wrx.10
        for <linux-rdma@vger.kernel.org>; Sun, 15 Sep 2019 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpbEyYhEyM+JeZoyKiAsvkt0iMqjB+0QrD11tqdnxqc=;
        b=eAdQYBoMdUbNqgsY8Oymgtn8R4HSMh0kbd3gmPWhYpZtSfDgusVXJbnPjqLzRQLMmq
         zKBaSRmGLeP/Wy8sX22NVszW5PfMoWE6ILkXWr0SMemaszY3DF7tg9ogpQjwICP7yhpp
         lTCZNHHgB+KzzqtmIbRiOW0obhl/lcWw+TFaf9GOQWHekl7b1OCQm+P3OXiPMLZBt3Av
         NIaCouWulWeTs2TiKlEugp9UXtrghz8PjoCt/oYlMFfvdHAPpQOItR5E7c/cRgNJhgDk
         4sUVoqiXn++lEW3BlvcOodyvpwkWkDxPXeXbLTNVpJmca0hQHux0bB/9SATi+WdojkjW
         c3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpbEyYhEyM+JeZoyKiAsvkt0iMqjB+0QrD11tqdnxqc=;
        b=c6SxCt0DWvnsE8AXHHllL/c42IniCLqI5Np5pwqWHmAsIpQ1pt5rEYJYMHIa6vwrqI
         78B2dJFxggaYJBIs8KjG+84wXWONFVdai6TTtLi2vVwz+ezvdLRRTPrRWDkkRZXsMm9B
         ekc7MQn+vNq/AM+k6WLYkRqLpbsdHEXUjowT9Tum3whSEcg8jaCgvZdbYE40qpsnTY2z
         dYGizRaf/B1PUogN41yWHI8jFKv5CTrcjCJNSkBvpgM60TkZzij/PdvGDqwvuQ/BlbEM
         yYPcBG/g92x2R16yf9+tmiNVaN3UExa4sjtB0EyBIc/7bpe4mJE6AeAAKUBuXGsl7v8p
         r0Bw==
X-Gm-Message-State: APjAAAV0F9z9xMtzbTiAT5gcscUcXZEcFIFBmB9lOZC1wq0pHNOWYKPR
        2W469pLhR5MDXHxD34fSS3+Ot1pNYcAmOsngaiOE8Q==
X-Google-Smtp-Source: APXvYqyoaEi6K5uVUYrAfWfYqovLOYAXsvPaHzfdo+BcRn8NTFXewqMNdu3YY7RUTmbY5Mw7a3u6YN5GIMXi7o2PLlo=
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr891610wru.317.1568557816046;
 Sun, 15 Sep 2019 07:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org>
In-Reply-To: <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Sun, 15 Sep 2019 16:30:04 +0200
Message-ID: <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
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

Thanks Bart for detailed review, reply inline.

On Sat, Sep 14, 2019 at 12:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +#define ibnbd_log(fn, dev, fmt, ...) ({                              \
> > +     __builtin_choose_expr(                                          \
> > +             __builtin_types_compatible_p(                           \
> > +                     typeof(dev), struct ibnbd_clt_dev *),           \
> > +             fn("<%s@%s> " fmt, (dev)->pathname,                     \
> > +             (dev)->sess->sessname,                                  \
> > +                ##__VA_ARGS__),                                      \
> > +             __builtin_choose_expr(                                  \
> > +                     __builtin_types_compatible_p(typeof(dev),       \
> > +                                     struct ibnbd_srv_sess_dev *),   \
> > +                     fn("<%s@%s>: " fmt, (dev)->pathname,            \
> > +                        (dev)->sess->sessname, ##__VA_ARGS__),       \
> > +                     unknown_type()));                               \
> > +})
>
> Please remove the __builtin_choose_expr() /
> __builtin_types_compatible_p() construct and split this macro into two
> macros or inline functions: one for struct ibnbd_clt_dev and another one
> for struct ibnbd_srv_sess_dev.
Ok, will split to two macros.

>
> > +#define IBNBD_PROTO_VER_MAJOR 2
> > +#define IBNBD_PROTO_VER_MINOR 0
> > +
> > +#define IBNBD_PROTO_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
> > +                            __stringify(IBNBD_PROTO_VER_MINOR)
> > +
> > +#ifndef IBNBD_VER_STRING
> > +#define IBNBD_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
> > +                      __stringify(IBNBD_PROTO_VER_MINOR)
>
> Upstream code should not have a version number.
IBNBD_VER_STRING can be removed together with MODULE_VERSION.
>
> > +/* TODO: should be configurable */
> > +#define IBTRS_PORT 1234
>
> How about converting this macro into a kernel module parameter?
Sounds good, will do.
>
> > +enum ibnbd_access_mode {
> > +     IBNBD_ACCESS_RO,
> > +     IBNBD_ACCESS_RW,
> > +     IBNBD_ACCESS_MIGRATION,
> > +};
>
> Some more information about what IBNBD_ACCESS_MIGRATION represents would
> be welcome.
This is a special mode to allow temporarily RW access mode during VM
migration, will add  comments next round.
>
> > +#define _IBNBD_FILEIO  0
> > +#define _IBNBD_BLOCKIO 1
> > +#define _IBNBD_AUTOIO  2
>  >
> > +enum ibnbd_io_mode {
> > +     IBNBD_FILEIO = _IBNBD_FILEIO,
> > +     IBNBD_BLOCKIO = _IBNBD_BLOCKIO,
> > +     IBNBD_AUTOIO = _IBNBD_AUTOIO,
> > +};
>
> Since the IBNBD_* and _IBNBD_* constants have the same numerical value,
> are the former constants really necessary?
Seems we can remove _IBNBD_*.
>
> > +/**
> > + * struct ibnbd_msg_sess_info - initial session info from client to server
> > + * @hdr:             message header
> > + * @ver:             IBNBD protocol version
> > + */
> > +struct ibnbd_msg_sess_info {
> > +     struct ibnbd_msg_hdr hdr;
> > +     u8              ver;
> > +     u8              reserved[31];
> > +};
>
> Since the wire protocol is versioned, is it really necessary to add 31
> reserved bytes?
You will never know, we prefer to keep the reserved bytes for future extension,
31 bytes is not much, isn't it?


>
> > +struct ibnbd_msg_sess_info_rsp {
> > +     struct ibnbd_msg_hdr hdr;
> > +     u8              ver;
> > +     u8              reserved[31];
> > +};
>
> Same comment here.
Dito.
>
> > +/**
> > + * struct ibnbd_msg_open_rsp - response message to IBNBD_MSG_OPEN
> > + * @hdr:             message header
> > + * @nsectors:                number of sectors
>
> What is the size of a single sector?
512b, will mention explicitly in the next round.
>
> > + * @device_id:               device_id on server side to identify the device
>
> Please use the same order for the members in the kernel-doc header as in
> the structure.
Ok, will fix
>
> > + * @queue_flags:     queue_flags of the device on server side
>
> Where is the queue_flags member?
Oh, will remove it, left over.
>
> > + * @discard_granularity: size of the internal discard allocation unit
> > + * @discard_alignment: offset from internal allocation assignment
> > + * @physical_block_size: physical block size device supports
> > + * @logical_block_size: logical block size device supports
>
> What is the unit for these four members?
will update to be more clear.
>
> > + * @max_segments:    max segments hardware support in one transfer
>
> Does 'hardware' refer to the RDMA adapter that transfers the IBNBD
> message or to the storage device? In the latter case, I assume that
> transfer refers to a DMA transaction?
"hardware" refers to the storage device on the server-side.

>
> > + * @io_mode:         io_mode device is opened.
>
> Should a reference to enum ibnbd_io_mode be added?
sounds good.
>
> > +     u8                      __padding[10];
>
> Why ten padding bytes? Does alignment really matter for a data structure
> like this one?
It's more a reserved space for future usage, will rename padding to reserved.
>
> > +/**
> > + * struct ibnbd_msg_io_old - message for I/O read/write for
> > + * ver < IBNBD_PROTO_VER_MAJOR
> > + * This structure is there only to know the size of the "old" message format
> > + * @hdr:     message header
> > + * @device_id:       device_id on server side to find the right device
> > + * @sector:  bi_sector attribute from struct bio
> > + * @rw:              bitmask, valid values are defined in enum ibnbd_io_flags
> > + * @bi_size:    number of bytes for I/O read/write
> > + * @prio:       priority
> > + */
> > +struct ibnbd_msg_io_old {
> > +     struct ibnbd_msg_hdr hdr;
> > +     __le32          device_id;
> > +     __le64          sector;
> > +     __le32          rw;
> > +     __le32          bi_size;
> > +};
>
> Since this is the first version of IBNBD that is being sent upstream, I
> think that ibnbd_msg_io_old should be left out.

>
> > +
> > +/**
> > + * struct ibnbd_msg_io - message for I/O read/write
> > + * @hdr:     message header
> > + * @device_id:       device_id on server side to find the right device
> > + * @sector:  bi_sector attribute from struct bio
> > + * @rw:              bitmask, valid values are defined in enum ibnbd_io_flags
>
> enum ibnbd_io_flags doesn't look like a bitmask but rather like a bit
> field (https://en.wikipedia.org/wiki/Bit_field)?
I will remove the "bitmask", I probably will also rename "rw "to "opf".
>
> > +static inline u32 ibnbd_to_bio_flags(u32 ibnbd_flags)
> > +{
> > +     u32 bio_flags;
>
> The names ibnbd_flags and bio_flags are confusing since these two
> variables not only contain flags but also an operation. How about
> changing 'flags' into 'opf' or 'op_flags'?
Sounds good, will change to ibnbd_opf and bio_opf.
>
> > +static inline const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
> > +{
> > +     switch (mode) {
> > +     case IBNBD_FILEIO:
> > +             return "fileio";
> > +     case IBNBD_BLOCKIO:
> > +             return "blockio";
> > +     case IBNBD_AUTOIO:
> > +             return "autoio";
> > +     default:
> > +             return "unknown";
> > +     }
> > +}
> > +
> > +static inline const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
> > +{
> > +     switch (mode) {
> > +     case IBNBD_ACCESS_RO:
> > +             return "ro";
> > +     case IBNBD_ACCESS_RW:
> > +             return "rw";
> > +     case IBNBD_ACCESS_MIGRATION:
> > +             return "migration";
> > +     default:
> > +             return "unknown";
> > +     }
> > +}
>
> These two functions are not in the hot path and hence should not be
> inline functions.
Sounds reasonable, will remove the inline.
>
> Note: I plan to review the entire patch series but it may take some time
> before I have finished reviewing the entire patch series.
>
That will be great, thanks a  lot, Bart
> Bart.


Regards,
-- 
Jack Wang
Linux Kernel Developer
Platform Engineering Compute (IONOS Cloud)

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de
