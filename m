Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F5C8C75
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfJBPM7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 11:12:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38373 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfJBPLe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 11:11:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so7400723wmi.3
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIwBPELl88iaMbSYiV7ycp6Z2I2x7UqLvm1fpqtgIXY=;
        b=TfizWOp1O5grpdnBXDk3+LRhC3jOPjmjiOtARGAnecRh/K1l/Eze0BI3ax7G8dcRfN
         9npLURBC3t5GSXRgBjBXwPLtG8NtfXp1SzSZw9jSNwJfz8oFxTNxaoQKOzpl1NKDcQd0
         q1jkbm9GH5JRcVoAZjecW3T1H8QtX7UjbNT7L+ohbCmO7o0dw/yBsC2CTcXSjnwcAMqy
         /OAk9npnpenDU9whhCeJdWn5BOJGGjqo/zL5lz+AsmWrLITNhG9VGiO3DHzZyb8j2X9b
         QGotpTE2h7+/dKG+DuYJnFItWYtl+q7Cw0IpNvCS5ewq5P0+u2kan5huNKVyJaxLIvxU
         Tuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIwBPELl88iaMbSYiV7ycp6Z2I2x7UqLvm1fpqtgIXY=;
        b=cvF9ORgj/tKPKkLooga4Gz8vWX7GPT/XyfHH4etDNHbTnLIdC4FnFsL1/eoIkvb88W
         9mDNE/u7qqmNAoBuOpXwQqDmY2Y4+J8o9cctLiKxPObUwwr+e4ZP+g7AqY9eGBr0OgBx
         fJ1FQvqAQKumy2FOOjCfDvvpsanXgnvBOhYV4A4Kbuz50ZF9BL+5yN0ytYH7WJdi/UQ6
         /3/VXp4+P+ubtv6eVv1wLtb9D1CoSkiCNjIPhSURn37zbzewHt1g4ssxhrwcBFkNwZJA
         +PvGV2EpHh5qKnUsz4QGpb+nZxSIURYGJFreXEAFkth25oaXjogrBk4pu2vzfLzQ9gbP
         4Big==
X-Gm-Message-State: APjAAAVVJhWJY4QyCpIDXruJ3mMvs1uP0x39ESmMEY9I8sbztreYo1Dw
        YwPsD6W1UULbu+xY4YhVRDNBJQImih15Q/odFyFg9Q==
X-Google-Smtp-Source: APXvYqyVYtXXGpUdVB6ylwGhw1yNpK4mJ8Vn9U3jNTlfbgR4PTFniUnt/0j6bekeqzWI3mTgTbrRUGwR5AFnXJ0n2wQ=
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr3082276wmm.37.1570029091670;
 Wed, 02 Oct 2019 08:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-13-jinpuwang@gmail.com>
 <456f046d-391e-2344-f61b-ba84290ff7b1@acm.org>
In-Reply-To: <456f046d-391e-2344-f61b-ba84290ff7b1@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 2 Oct 2019 17:11:20 +0200
Message-ID: <CAMGffE=RkDw0rbL-qMnuv0jA-PkH-iaeWGAUyDxVvXanL59n+A@mail.gmail.com>
Subject: Re: [PATCH v4 12/25] ibtrs: server: sysfs interface functions
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

On Tue, Sep 24, 2019 at 2:00 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +static void ibtrs_srv_dev_release(struct device *dev)
> > +{
> > +     /* Nobody plays with device references, so nop */
> > +}
>
> I doubt that the above comment is correct.
>
> Thanks,
>
> Bart.
will fix it,

Thank you, Bart!
