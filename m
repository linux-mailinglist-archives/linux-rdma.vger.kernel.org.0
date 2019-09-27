Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45262C04CA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 14:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfI0MEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 08:04:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42388 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfI0MEa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 08:04:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so2419001wrw.9
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2iw2VtLufxj11Fm0JlU+oavXCSMSBn9EwsIJtM7DtQ=;
        b=OAHrzWxT684cRT2Q/GTvTyymCyaxbdc3nQoVxzq/XX9VR9tXPlxFdVgH2Pp+hIPefl
         TxNiF7v3ZhzgHyFnOVJyXPPWQ2dJwAlvy9BYwbVZBS6QplsQvJ1teUCC/aNAB7dLWW6Y
         qsidadUVKJej3zS9PlKQ5rp1JfzZfkCOjgBMzt4Juf/ySTZeSQyyjGksG/JTmEacFRjv
         5hAiEf/nXBNcteBkTdwq9drth/z3IdldXHHwR0YQaYe8DA0slzWylW6QpKTwUNS93hmT
         v8r0J7DuMNB39x2GbNbRN2BnLOGb7FjereolHc7XhgT1aQQxK2A2i5pTUtMmE2AneqTl
         vmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2iw2VtLufxj11Fm0JlU+oavXCSMSBn9EwsIJtM7DtQ=;
        b=iACmW30/JY3KFdSDe7j0vHT1oy5cyXhqtWLeRRN7rQBJrlAvOiI9o4a92rrsIIFvZg
         eUQ6e1/Gqk3SmG0AMV+FDiLaMbIibAII6kfm2U8d/kZCt/brklu9tzqJ9fijWmgpbuEY
         7VYwqoPIJwnO75jknLdyJU6gMD59Ok4g09m9hBYfrB55HnZoZfxo5nbnORfnRiUawuSU
         iw6M7+Sd9TLCrtGpExcH+i718MNqQbIvnc+elr8UVNsNMGtfwBPXyQi5c0f8Dx+N/QHS
         niLge83QTS58B9XsQ7l0zvX/UiEl20HFgxzhoOJWIFfOiLcjTB797C39IKKwQTzGFSrd
         z5aQ==
X-Gm-Message-State: APjAAAWVNHp8jxZVS5RJbqNOJhXEhZh53u8mwYeoWMMIJpYhGGCQCVKA
        mOX48/EZy7N8YP/7kBP2SHkbAWuSbymUk/LhpLGBng==
X-Google-Smtp-Source: APXvYqxCJWbMzmW/zWMBktqKGLPDSSJau0EgT0yLx2A6eOZ1Kxv0eu+UGP4dL/ncofnLK8C52TUhPso+IYZ67eKl9T8=
X-Received: by 2002:adf:f406:: with SMTP id g6mr2574100wro.325.1569585868528;
 Fri, 27 Sep 2019 05:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-10-jinpuwang@gmail.com>
 <c0ca07e9-2864-b1a2-1b78-b9f1de5702c0@acm.org>
In-Reply-To: <c0ca07e9-2864-b1a2-1b78-b9f1de5702c0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 14:04:17 +0200
Message-ID: <CAMGffEnqC0peHr9W8y077YLZPC0+RzSJ4c8Z3q23eVgvFp1y3A@mail.gmail.com>
Subject: Re: [PATCH v4 09/25] ibtrs: server: private header with server
 structs and functions
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

On Tue, Sep 24, 2019 at 1:21 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +static inline const char *ibtrs_srv_state_str(enum ibtrs_srv_state state)
> > +{
> > +     switch (state) {
> > +     case IBTRS_SRV_CONNECTING:
> > +             return "IBTRS_SRV_CONNECTING";
> > +     case IBTRS_SRV_CONNECTED:
> > +             return "IBTRS_SRV_CONNECTED";
> > +     case IBTRS_SRV_CLOSING:
> > +             return "IBTRS_SRV_CLOSING";
> > +     case IBTRS_SRV_CLOSED:
> > +             return "IBTRS_SRV_CLOSED";
> > +     default:
> > +             return "UNKNOWN";
> > +     }
> > +}
>
> Since this function is not in the hot path, please move it into a .c file.
Ok.
>
> > +/* See ibtrs-log.h */
> > +#define TYPES_TO_SESSNAME(obj)                                               \
> > +     LIST(CASE(obj, struct ibtrs_srv_sess *, s.sessname))
>
> Please remove this macro and pass 'sessname' explicitly to logging
> functions.
Ok.
>
> Thanks,
>
> Bart.
Thanks!
