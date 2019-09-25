Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C958DBE885
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 00:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfIYWxb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 18:53:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39470 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfIYWxb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 18:53:31 -0400
Received: by mail-io1-f68.google.com with SMTP id a1so1287267ioc.6
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgdVnypXV4KSvmqLrClLGHf8ETf2mlCO+2hqkwlCY7g=;
        b=RcAnulDB3F+hSgfwPTI5JwQzfOnANj8F4GXVIQTsNo+ZuDA351WlPFblb7uamtt302
         gDtaoeQvr/UKzOrAW6BrCHaHa2RZ20Mn4zrxBB6Xt4bFnfW3TchJ5DMGgAYstSj8wPQL
         5XnEuSMJmsHN8lga/+JYsv2TLZjxvYU0sv/GQYHuo6+IlxL/RDC8B9Bjz/Od/9Ud/f0o
         kORCM/n13WdQpk7fKAYKDvrg8Mlq5BydX67sl5GRk5DYu8a+6RQzwvaifP/ryLoAxRnR
         +EhkcX1FRU6FYxj/Dux6wbKz8qivICiPCkA/xupMmhJM+fa/7XKZ/8nClqIGy6b+5sXg
         K0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgdVnypXV4KSvmqLrClLGHf8ETf2mlCO+2hqkwlCY7g=;
        b=su9wihRTFEgnhIOM97+qz/bUcYUYczcU810OuDVfwKD0m7L3W7QQgCI4hp8Xo6pvcF
         2c5uIGRVKzojKPzmYiDpN6VQIb04nWkFr8fjTu8x+RF4I5LrTpFzu4z81rFWFb2oljKX
         39VSCSxiytktOhsaQLWdqky9fQNEXg295+gIgoDOPnM9BIsoOT791pW1CWOc0gRPZ7HR
         LA4VOJQ49v7xPuWNRpCYhz8w5JjseV8t0ZeNbmwLr/jrtwFzWNrGv7BqK6HhbaPi/Rpg
         FJAavTNDORdtSHv63GzKJ+/Vlziir9ux5jmCXBtRBnXWU2lJ+lv/0wE6A23B2Lnl4tkf
         si+Q==
X-Gm-Message-State: APjAAAUvrJUHS0PavLZ1koV/+hNT6epYF2ERnStVMbv184+HfFYGnhHz
        mo1uh/RYEP0R0zJHYLGQVHvy0x40qX0KWNJp+RKe
X-Google-Smtp-Source: APXvYqy7H1DLLF9NFPqCfEmk0idBJhTirLKNRbjFHMaUqXAjZoKqVPQxb+JY2UFC5+n7Q8VnzjZPYmCoYnU5oOmfByg=
X-Received: by 2002:a6b:db0a:: with SMTP id t10mr470533ioc.300.1569452008914;
 Wed, 25 Sep 2019 15:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org> <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org> <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
 <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
In-Reply-To: <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 00:53:17 +0200
Message-ID: <CAHg0Huzuw=O2CJvUGJYO0whUE6tx34iPm7ScWRn-uRafRYp5aQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 11:08 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/25/19 1:50 PM, Danil Kipnis wrote:
> > On Wed, Sep 25, 2019 at 8:55 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> There is plenty of code under drivers/base that calls get_device() and
> >> put_device(). Are you sure that none of the code under drivers/base will
> >> ever call get_device() and put_device() for the ibtrs client device?
> >
> > You mean how could multiple kernel modules share the same ibtrs
> > session...? I really never thought that far...
>
> I meant something else: device_register() registers struct device
> instances in multiple lists. The driver core may decide to iterate over
> these lists and to call get_device() / put_device() on the devices it
> finds in these lists.
Oh, you mean we just need stub functions for those, so that nobody
steps on a null?
