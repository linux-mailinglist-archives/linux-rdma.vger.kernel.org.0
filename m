Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DEDB351F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfIPHIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 03:08:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33464 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfIPHIN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 03:08:13 -0400
Received: by mail-io1-f67.google.com with SMTP id m11so76282471ioo.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2019 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEc3XY4ZACvXcwSfiokSL2ixBOdX4sGF6A5ghbDhIoM=;
        b=cbK2DjZvbrNzwK2luQX49r9+wTsXo8mqZ0RF2hQwPR7ocnV0VwQbt6tj1fTuyM7mPw
         1lRiAlJcDI7tViZztVPb9Mid9EUYhe8CGPajnyhSkSydf50OwhWr5mKgxGpc8g/I+fOY
         DEe9He3fO+jkGsxpeGQ0MaP/SjSGfM0M9aK6E4KoYGN5HLMLxNBQETGy3raFxs5/rmxM
         gfz520J+gnAaaeGTbcebGWYTu931Bw9+SJgvSMj9m5vh0kjGGh6f0Yu5QKtFnrkZx183
         gh1b5VebLiDE9Gm4zJJNheljSQhzW225Ldj4RB8e6gMKrL2eCpi39ZMeqhR9z1gZmSoY
         3zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEc3XY4ZACvXcwSfiokSL2ixBOdX4sGF6A5ghbDhIoM=;
        b=qGx9RtKrWUMr4LqlctVgttBHpaXk5NtRF9gvxHorUn0Dt7FwCmjzEKDOslEGlCZNUm
         0LhsEop+joY2P8o3E3V6y3mxjcr47GbEVsHjKoBbggES0bwbHpymlo1aEWBsm7dOx807
         1zT3sBYzGdvmcffjtKBvTOwEOyOmOzJKczJlXhH8VVdjti+Jdbwvmmy9aMgPUaaDeYzI
         cM+o8uGv1W7C8W0UZkQrm2mA3iq608Yiqbp2HH6ZaGcrJTJqxBNCu1AyaSU/aDY2+uIZ
         16qIrA/HObTb0LXWfguxWesdxOwpmzT1ySHQkvbgLpdcCT8IRyYX/Kc/kU6hivNkh7Df
         RTng==
X-Gm-Message-State: APjAAAW1jtvx1LCSoU7/2/2Bobz1fzRCknU9NkMOZlTEix/OOnjpChxA
        sqLfO7rCJeiiv07WK4+JTfR5zYJ14214neWDyCuP
X-Google-Smtp-Source: APXvYqwsgmC5JxAG7iowEc1HKDnuBnltRXTuF0KQc6KxH/xI2OgxJyXYXd365qagiHa1yY+yENk+xf9Llj+eSVXJwtw=
X-Received: by 2002:a02:e47:: with SMTP id 68mr14035334jae.126.1568617692506;
 Mon, 16 Sep 2019 00:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
In-Reply-To: <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 16 Sep 2019 09:08:01 +0200
Message-ID: <CAHg0HuzBGLGhweQ-ow_LG+66sC6RFyFAvJPG9wJJvnYncRtoAA@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > > +/**
> > > + * struct ibnbd_msg_open_rsp - response message to IBNBD_MSG_OPEN
> > > + * @hdr:             message header
> > > + * @nsectors:                number of sectors
> >
> > What is the size of a single sector?
> 512b, will mention explicitly in the next round.
We only have KERNEL_SECTOR_SIZE=512, defined in ibnbd-clt.c. Looks we
only depend on this exact number to set the capacity of the block
device on client side. I'm not sure whether it is worth extending the
protocol to send the number from the server instead.

> > > + * @max_segments:    max segments hardware support in one transfer
> >
> > Does 'hardware' refer to the RDMA adapter that transfers the IBNBD
> > message or to the storage device? In the latter case, I assume that
> > transfer refers to a DMA transaction?
> "hardware" refers to the storage device on the server-side.
The field contains queue_max_segments() of the target block device.
And is used to call blk_queue_max_segments() on the corresponding
device on the client side.
We do also have BMAX_SEGMENTS define in ibnbd-clt.h which sets an
upper limit to max_segments and does refer to the capabilities of the
RDMA adapter. This information should only be known to the transport
module and ideally would be returned to IBNBD during the registration
in IBTRS.

> > Note: I plan to review the entire patch series but it may take some time
> > before I have finished reviewing the entire patch series.
> >
> That will be great, thanks a  lot, Bart
Thank you Bart!
