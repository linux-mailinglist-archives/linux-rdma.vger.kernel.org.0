Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4279BEE3E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfIZJQ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 05:16:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39837 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfIZJQ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 05:16:59 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so4628578ioc.6
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opU2ZI5JfOeMYpBAwSTCngXukXJ/aa9xFV3oPHd6LY0=;
        b=N8NrSTeSaDVfcR6D7xcWuYzoTniMDLqUY1aWwjU3v0ZSgVyVrut1Q3AYJxzcKCNzD+
         c0+MySLMF79j27EvLTHLgo5yvh8xCoOVMjXkjjH0Ad+CN5gRRenL1W6OahwMgYll5S9T
         sKuDr+XQcoP2cuUqyZvGCGMjyQZEnC20YK/xfdCYLnIWqO5KVqdEnYANnGEGzHeG+3iP
         yTXtY4Ia1tX3YpjICRcU6+fsqOE3rYgAlXa0HbvTXPvmG8/zqw1faZQ8NYGicNZRXWxE
         mU8Fzsly5IuaKz3adjAkC2R1Ac2K1YczGzsPIeuo6y4NfgNpeOf7qx9Z5Q9oWXcScelN
         OTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opU2ZI5JfOeMYpBAwSTCngXukXJ/aa9xFV3oPHd6LY0=;
        b=DC64Ev8WYuG06/FRUnB9pRJ5TGIMbokR3Kk/EqMVKFhFEVFD5fBwYnmp2+pa5s79P4
         PJRH7hL7gfBKSmX5/Yv0kjaC7Rg2yRZ2Pk2b3uj5RPmyR4aIMybB2mcXyX5hS2r9u3BJ
         Vwu4NugzCSNy/jAO4jbAWGkj0y+3Cq1qu7SN0uLqx6VJrHX8UiFTN5erWRvg6mHNtTX0
         bazes6sMpscfevcg4Yvzcxzq2dS9Ck5r+bzxPpdoAK07JaUW6fpb7oOx7u4D2Vp8PX4O
         s42p3ktBg9u//hVwAk+vs3xp533e6Fx+SfxqmAFtSxozgrr2DOUeYBDtrkAq3aCEzmwg
         AvNQ==
X-Gm-Message-State: APjAAAVtumSs5Xj7E7sr/eHlAHYlj2/bUfGlFfxACGC318a+tXpHVUxK
        2APgU2gNcDBI7r6SnP5yc8BmiwDfNCjnw8k5oaD6
X-Google-Smtp-Source: APXvYqwIYSHBcJUQ3pMZh4YCYMydD9ttww2cVvSLVFh8Eoo4P7s3grDElbpXQD3jmw9i/t/GW2/r5TY2jZqXl35tb68=
X-Received: by 2002:a6b:c348:: with SMTP id t69mr2503648iof.66.1569489418455;
 Thu, 26 Sep 2019 02:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org> <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org> <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
 <befbe2d4-d37e-0e67-3bf5-01024663082f@acm.org> <CAHg0Huzuw=O2CJvUGJYO0whUE6tx34iPm7ScWRn-uRafRYp5aQ@mail.gmail.com>
 <aad75dc9-1503-3c32-5d69-2180d8abe3f7@acm.org>
In-Reply-To: <aad75dc9-1503-3c32-5d69-2180d8abe3f7@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 11:16:47 +0200
Message-ID: <CAHg0HuzaSHhGHExNzoH4pcA3H40azaRZsrAHFtDRKLu-datDVw@mail.gmail.com>
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

On Thu, Sep 26, 2019 at 1:21 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/25/19 3:53 PM, Danil Kipnis wrote:
> > Oh, you mean we just need stub functions for those, so that nobody
> > steps on a null?
>
> What I meant is that the memory that is backing a device must not be
> freed until the reference count of a device has dropped to zero. If a
> struct device is embedded in a larger structure that means signaling a
> completion from inside the release function (ibtrs_clt_dev_release())
> and not freeing the struct device memory (kfree(clt) in free_clt())
> before that completion has been triggered.

Got it, thank you. Will move free_clt into the release function.
