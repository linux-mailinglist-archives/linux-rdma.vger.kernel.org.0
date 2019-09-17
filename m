Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5406B4ECF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 15:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfIQNKE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 09:10:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33325 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIQNKD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 09:10:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so3148634wrs.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BICN8Di8VFBMT6QS9s1kuCF6vCXiIA33xEhamtiRBAc=;
        b=Evd/zsCIgw7yEQFaqGzfEfTsoFVa4TrP8+U+AKl/gtR1Lh1I/Y7TH/O7D8YQ9z0FWJ
         uEWGi2BUecDkZvzN+xumjeUIVuuEBbmR4r++LyZbiINHgnwCJapYTDHOLzqxSvOop+DS
         0p0qIudRHJyQhlzviK0h79BIFO7lxLk4ZNnIFeDygI4utTj15Ve79vTxYwrTXPz+vpZA
         Zl31cQ++Vwxw32nyGSGkI6ye7l4cZhR2DNQeRbImBj/qLpnPKDM8E0ozFaajcOB8OplG
         60iQHPPlgxa10bN8EZlntoRI7RgTIkM3rF4hp2/a7ywX6sEfHjtCPCPbcXzmx0t3ew2I
         MoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BICN8Di8VFBMT6QS9s1kuCF6vCXiIA33xEhamtiRBAc=;
        b=Tnb6PAUfLkaQtdFEM5B441fqE8ghnGRF4xmTb7kajGSI1BfJjvNTELEyXiRlhWJnNT
         4f0s81Xr6OH8ddnJKBTKap1cOfMZDnOQ8P5a5OYe/dW2HaxxhgH5LT/RXGbh0y2sbzOn
         eE/SMKiXpDuBow3YY4na36Z1JOTXCFL7HSw9+mPb0tU3dqVR4+V2cBjcqp80rZKCTvqi
         Y1Vzs5k4InHVJ9edgul1mS61l1otc7Xc5T7YEUe4q6iIEzxS1riDhdNcZDIS4FEtMJB4
         Nvk3ErvZR0AhtNGiHAZbL8xJOAvEtRw0gsxdNKLrL/5Z08kVWvs/9fAdH69coFi86hAD
         U7Pg==
X-Gm-Message-State: APjAAAUhDmT4wkHdqJtzt8Un8EeH6wUuw4cA7zMRRJTpwQ6C9dFdipej
        RU6cuMes6+TL3CsKT28fD+WfQc730l2kn19ZpthfdQ==
X-Google-Smtp-Source: APXvYqwU3kTDl5tpkjQLx7hf9KC1fHx48uzH/J2lDzS0SURFLa8T7Ce6hTgn0O0CSOeTjIIMEQ8ITUuVn7o8rDSsyLk=
X-Received: by 2002:a5d:4744:: with SMTP id o4mr2919160wrs.95.1568725801641;
 Tue, 17 Sep 2019 06:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
In-Reply-To: <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 15:09:50 +0200
Message-ID: <CAMGffEn6=P8bLi7SyUC19+7wbU6YEZ_5BqjR06+CBKvENw-tFg@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
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

> > +static void ibnbd_softirq_done_fn(struct request *rq)
> > +{
> > +     struct ibnbd_clt_dev *dev       = rq->rq_disk->private_data;
> > +     struct ibnbd_clt_session *sess  = dev->sess;
> > +     struct ibnbd_iu *iu;
> > +
> > +     iu = blk_mq_rq_to_pdu(rq);
> > +     ibnbd_put_tag(sess, iu->tag);
> > +     blk_mq_end_request(rq, iu->status);
> > +}
> > +
> > +static void msg_io_conf(void *priv, int errno)
> > +{
> > +     struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;
> > +     struct ibnbd_clt_dev *dev = iu->dev;
> > +     struct request *rq = iu->rq;
> > +
> > +     iu->status = errno ? BLK_STS_IOERR : BLK_STS_OK;
> > +
> > +     if (softirq_enable) {
> > +             blk_mq_complete_request(rq);
> > +     } else {
> > +             ibnbd_put_tag(dev->sess, iu->tag);
> > +             blk_mq_end_request(rq, iu->status);
> > +     }
>
> Block drivers must call blk_mq_complete_request() instead of
> blk_mq_end_request() to complete a request after processing of the
> request has been started. Calling blk_mq_end_request() to complete a
> request is racy in case a timeout occurs while blk_mq_end_request() is
> in progress.

Hi Bart,

Could you elaborate a bit more, blk_mq_end_request is exported function and
used by a lot of block drivers: scsi, dm, etc.
Is there an open bug report for the problem?

Regards,
Jinpu
