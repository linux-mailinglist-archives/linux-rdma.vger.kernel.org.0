Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A524B3CFE
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 16:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfIPO52 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 10:57:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46853 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbfIPO51 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 10:57:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so8034424wrv.13
        for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2019 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjoybZxqlhO6j7YUJJKcSzxvlQi+UbRquVjBeqmyC2c=;
        b=S5eRfVJOWhP5W1QSvt4g1gkUmyEWabYd9Mn/cu8wMEteZNREzuMn1X00jsW4RdoTlq
         eX0VLKOP72egm8OnxhBumEK3Oj1tQqUJ0qgx0IBGihRdcLfl5AnuGpconHCKCRkGyTWx
         zeAGU5WFv1TLArbVx87SCMAQVwVTDu4g/1+a0kcxrEG2psiYiWQIRxNhrFAssJrrjW6/
         AWyh7Gsc/WokE1t7Y+30Xyo0oJEQODEv9bGb06IUewXjAWARGSC21xONVmXGwutLgTmb
         xgBkTb2ZsPoXWO+evcuum3AT9UtA9Zn0xXYx20zo8EaiC55l3dUiiAQfikM9xF8o7vbR
         8njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjoybZxqlhO6j7YUJJKcSzxvlQi+UbRquVjBeqmyC2c=;
        b=UUXF0yAA8EZn1LgetrPxxfdP5ngjwpsIYjf37+uQyU12FxyJE/N597vGZNvYgacSIo
         cCgPapa1dvmxIBTxEY8id2elwfKLRptdZJmoCcdSm/bhvYkJsYOeNiVPHi8HhZD6ZvHz
         Vj8K9/3X3TyGnM9cJELnP2lzKcv3uoH5QO/qp2/0JkTp/MviIZOPq5V6dPWPJ/mrId95
         VhZHeai7BfExdxt7XYvO4aRCSMkxdUPT0YnHh2AnsCJ0bE/iba815cfieRP74z+X471u
         q2bw2KU1dBSgTFSF9vqH/9+94D69//xb1LR9MwAqIDaqtaYakFaEI4nllwc57DZU0cQy
         +bzA==
X-Gm-Message-State: APjAAAU/khYY5J5UXCI4tKusCTsDp2djvyoPM4HlnrZD0oPCDKbjKrl0
        zzwmphZ2iu8suBNxHM60iuERMyMUkTLTYxK61X/I8Q==
X-Google-Smtp-Source: APXvYqzw+p99VUGvMgaRQPud63PDoqaKWLR+7eNkDR13nQz/3Sa0fvN5CR2Oz4v7draPRAWxmuSdZRWgISnjRONDB9U=
X-Received: by 2002:adf:8444:: with SMTP id 62mr190185wrf.202.1568645845836;
 Mon, 16 Sep 2019 07:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
In-Reply-To: <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 16 Sep 2019 16:57:15 +0200
Message-ID: <CAMGffEmnTG4ixN1Hfy7oY93TgG3qQtF9TkpGzi=BxWm5a2i3Eg@mail.gmail.com>
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

> > > +#define _IBNBD_FILEIO  0
> > > +#define _IBNBD_BLOCKIO 1
> > > +#define _IBNBD_AUTOIO  2
> >  >
> > > +enum ibnbd_io_mode {
> > > +     IBNBD_FILEIO = _IBNBD_FILEIO,
> > > +     IBNBD_BLOCKIO = _IBNBD_BLOCKIO,
> > > +     IBNBD_AUTOIO = _IBNBD_AUTOIO,
> > > +};
> >
> > Since the IBNBD_* and _IBNBD_* constants have the same numerical value,
> > are the former constants really necessary?
> Seems we can remove _IBNBD_*.
Sorry, checked again,  we defined _IBNBD_* constants to show the right
value for def_io_mode description.
If we remove the _IBNBD_*, then the modinfo shows:
def_io_mode:By default, export devices in blockio(IBNBD_BLOCKIO) or
fileio(IBNBD_FILEIO) mode. (default: IBNBD_BLOCKIO (blockio))
instead of:
parm:           def_io_mode:By default, export devices in blockio(1)
or fileio(0) mode. (default: 1 (blockio))


> > > +/**
> > > + * struct ibnbd_msg_io_old - message for I/O read/write for
> > > + * ver < IBNBD_PROTO_VER_MAJOR
> > > + * This structure is there only to know the size of the "old" message format
> > > + * @hdr:     message header
> > > + * @device_id:       device_id on server side to find the right device
> > > + * @sector:  bi_sector attribute from struct bio
> > > + * @rw:              bitmask, valid values are defined in enum ibnbd_io_flags
> > > + * @bi_size:    number of bytes for I/O read/write
> > > + * @prio:       priority
> > > + */
> > > +struct ibnbd_msg_io_old {
> > > +     struct ibnbd_msg_hdr hdr;
> > > +     __le32          device_id;
> > > +     __le64          sector;
> > > +     __le32          rw;
> > > +     __le32          bi_size;
> > > +};
> >
> > Since this is the first version of IBNBD that is being sent upstream, I
> > think that ibnbd_msg_io_old should be left out.
After discuss with Danil, we will remove the ibnbd_msg_io_old next round.

Regards,

--
Jack Wang
Linux Kernel Developer
Platform Engineering Compute (IONOS Cloud)
