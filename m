Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BECB62A8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfIRMCc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 08:02:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbfIRMCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 08:02:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so6611751wrx.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2019 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1S9EMCNitqnrAe9ZtMh+zE7B61LAucDMksRsfpqkqsk=;
        b=WS5RL2Z0GVuSnGv5lEaRXOXb+g8GL8vHlQV6wb73W2te4MU/oRKjZxS495y2RUOyjZ
         QIDaauPkIhpsaInO0SmfrMnw5rlJKzE1x4sVEY0x3AEzPI95QSUn2U6tJgxeGTcLn41C
         o11jiQEnd7vhKSXYGuqK6PbjUA3KykcwpvsbE3A8zDFlj5PGeFtoUqwaaMQ1VK7F8QlX
         lfXczY0cWVwYrrMaVWqK2NsKy8P2tJXe91FEdhJSxrp7R/ca6pxEX5KPampPOIKGUuAz
         2FAF/o+6d2zgHmNCJaiN5i+K5yNHzHqagvTnF3GgXedIxAI8JsYsSHyLdWIcmbD+C0nL
         2AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1S9EMCNitqnrAe9ZtMh+zE7B61LAucDMksRsfpqkqsk=;
        b=d4PKOfccnz8dJAI8OIyS1tbn6Vi5FetcyVLW7op2PW9wnXNGIqTvhQPxRza3WvvQv2
         UiNkPYs85BRMqDPbrHR1WV2tkLhf5VBdXFihfC+y2Sd0X3lohABXo+CJXiJAbRjkTyDo
         w1TU2tQQA7ZSl60cvDy/iqLHZe5I13VxlIZDvI73xpfpsJjZMv01jkDPYXOv+9zn2jpz
         r3k1NOSx7D4wayGUuXZsWHDD/4gnlh3bopJgkG84a2pD9Pn/mn7Bg/O2GdMp6zjAKamE
         MnrEe0MVS1MmXIDXE6yWKvBQS4gubARTyN/Q9tiH7A+icIAmfgC+ObpJcu7duO6F2i8s
         1UyQ==
X-Gm-Message-State: APjAAAWPH5uvJjBhy8PPnVDlZJh/Nud+VY5mIPjyRxT54OvHoiEqrfon
        YM/HZGhrW6eUGlEOVXJ0L1YGNKCeO6QIgXql0Ck78Q==
X-Google-Smtp-Source: APXvYqzxv5eWcHvWyQeHvaamQCHqPD4Ul8vbG+Ra6SSEc1YFAs3JLeQ0zkzWe++KiEXK6V6uvKjuHruPHgCd2rei78Y=
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr2912476wru.317.1568808147967;
 Wed, 18 Sep 2019 05:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAMGffEn6=P8bLi7SyUC19+7wbU6YEZ_5BqjR06+CBKvENw-tFg@mail.gmail.com>
 <5a14b67d-9e32-c599-6525-7564becd526a@acm.org>
In-Reply-To: <5a14b67d-9e32-c599-6525-7564becd526a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 18 Sep 2019 14:02:16 +0200
Message-ID: <CAMGffEkbKU10_2eoFoitkWNFLydE1MukOh9jHsQCqWr0KT9V_Q@mail.gmail.com>
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

On Tue, Sep 17, 2019 at 6:46 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/17/19 6:09 AM, Jinpu Wang wrote:
> >>> +static void ibnbd_softirq_done_fn(struct request *rq)
> >>> +{
> >>> +     struct ibnbd_clt_dev *dev       = rq->rq_disk->private_data;
> >>> +     struct ibnbd_clt_session *sess  = dev->sess;
> >>> +     struct ibnbd_iu *iu;
> >>> +
> >>> +     iu = blk_mq_rq_to_pdu(rq);
> >>> +     ibnbd_put_tag(sess, iu->tag);
> >>> +     blk_mq_end_request(rq, iu->status);
> >>> +}
> >>> +
> >>> +static void msg_io_conf(void *priv, int errno)
> >>> +{
> >>> +     struct ibnbd_iu *iu = (struct ibnbd_iu *)priv;
> >>> +     struct ibnbd_clt_dev *dev = iu->dev;
> >>> +     struct request *rq = iu->rq;
> >>> +
> >>> +     iu->status = errno ? BLK_STS_IOERR : BLK_STS_OK;
> >>> +
> >>> +     if (softirq_enable) {
> >>> +             blk_mq_complete_request(rq);
> >>> +     } else {
> >>> +             ibnbd_put_tag(dev->sess, iu->tag);
> >>> +             blk_mq_end_request(rq, iu->status);
> >>> +     }
> >>
> >> Block drivers must call blk_mq_complete_request() instead of
> >> blk_mq_end_request() to complete a request after processing of the
> >> request has been started. Calling blk_mq_end_request() to complete a
> >> request is racy in case a timeout occurs while blk_mq_end_request() is
> >> in progress.
> >
> > Could you elaborate a bit more, blk_mq_end_request is exported function and
> > used by a lot of block drivers: scsi, dm, etc.
> > Is there an open bug report for the problem?
>
> Hi Jinpu,
>
> There is only one blk_mq_end_request() call in the SCSI code and it's
> inside the FC timeout handler (fc_bsg_job_timeout()). Calling
> blk_mq_end_request() from inside a timeout handler is fine but not to
> report to the block layer that a request has completed from outside the
> timeout handler after a request has started.
>
> The device mapper calls blk_mq_complete_request() to report request
> completion to the block layer. See also dm_complete_request().
> blk_mq_end_request() is only called by the device mapper from inside
> dm_softirq_done(). That last function is called from inside
> blk_mq_complete_request() and is not called directly.
>
> The NVMe PCIe driver only calls blk_mq_end_request() from inside
> nvme_complete_rq(). nvme_complete_rq() is called by the PCIe driver from
> inside nvme_pci_complete_rq() and that last function is called from
> inside blk_mq_complete_request().
>
> In other words, the SCSI core, the device mapper and the NVMe PCIe
> driver all use blk_mq_complete_request() to report request completion to
> the block layer from outside timeout handlers after a request has been
> started.
>
> This is not a new requirement. I think that the legacy block layer
> equivalent, blk_complete_request(), was introduced in 2006 and that
> since then block drivers are required to call blk_complete_request() to
> report completion of requests from outside a timeout handler after these
> have been started.
>
> Bart.

Thanks for the detailed explanation, I will switch to
blk_mq_complete_request(), will also drop the
softirq_done module parameter, not useful.

Regards,
Jinpu
