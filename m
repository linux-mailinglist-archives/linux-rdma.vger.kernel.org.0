Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAD7BE84C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 00:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfIYW03 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 18:26:29 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:39706 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfIYW02 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 18:26:28 -0400
Received: by mail-io1-f47.google.com with SMTP id a1so1138732ioc.6
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/DJUCljRILck0Po37+hrFOa0sfqWuVOPAKCUrIr84k=;
        b=V66aROosIMb5jBBfnluQ/ChzYYbV6SY6ODVcdVVDEGqvsGFciqGq4DuLnrFmOChuAc
         D+00HfAJi05ypBpkaukMnrYj1gmW3PMGDBeYbZQ6RDlf99pji/qetNlKZ2kMGRjDmIT4
         ugHrYmSGX19gY6ydjvzlUb9F4RWS3DEAThFPC1t0Ri7AOvujQAsi5/ZQ0qzUh+Mbj6TB
         +g/ppjZyei7njxPGFgQ5rJ/Cgxtg9Hxd+oQQRCVC+gMM7j0DETVqDGocimqft/rMHAwg
         qQdU7xpxmzX9ExZfOrWiQVhEPrWuyzIegtq/sBe8m5vuraX35pSF8qwWBNHsehi0aPUp
         VKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/DJUCljRILck0Po37+hrFOa0sfqWuVOPAKCUrIr84k=;
        b=Am5YeEZiBRBSA1eDNLtBeEztDY8jaYKzsQ0lNLZ/+0KIPCPtuwDrcuu1HRXdghM7xb
         PEhfHHtFMcC0kjNvOSkNb4G5IX4qP1T1LdGztvcbhRpXxN1gzpAJUhexiW5q0ZyBpoPz
         WlI1EO4RlmAN/ivZHY+HnjaUuYfIw9LG7yq9vO4rl5dKt4rycF5x49b4/lIoAovB8Ua8
         /kvZurURcvIzH1gBRQ1RpNBC4hjbbbtPknWf1B2JpV0GxWdLXJzg7Uk2mG+wzuocPRmP
         Xt8RytUiM6QYVhdiPnlKwzdqttgCq4IorSpvtdy0bgc1h8KQlIhFInkhqIX8Rfh3K5oJ
         8DeA==
X-Gm-Message-State: APjAAAVIKrSr2ipq6QfR+IfZLY1ZzaDMA9wHCVFNevU6E8y7BTYSQgl/
        wMl4I3qIMhrlCGfYYBf5f8sYEnP//e0Q3fGyFCNH
X-Google-Smtp-Source: APXvYqzmOrF9c5VHfSpju2N8flft/cTD7TG3CwX/rT27e1wK7P7lE0eImlkdroqKZji80vJDyR9L0D6s4qLhtkWaWJ0=
X-Received: by 2002:a02:e47:: with SMTP id 68mr677176jae.126.1569450387555;
 Wed, 25 Sep 2019 15:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-18-jinpuwang@gmail.com>
 <bd8963e2-d186-dbd0-fe39-7f4a518f4177@acm.org> <CAHg0HuwzHnzPQAqjtYFTZb7BhzFagJ0NJ=pW=VkTqn5HML-0Vw@mail.gmail.com>
 <5c5ff7df-2cce-ec26-7893-55911e4d8595@acm.org> <CAHg0HuwFTVsCNHbiXW20P6hQ3c-P_p5tB6dYKtOW=_euWEvLnA@mail.gmail.com>
 <CAHg0HuzQOH4ZCe+v-GHu8jOYm-wUbh1fFRK75Muq+DPpQGAH8A@mail.gmail.com> <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
In-Reply-To: <6f677d56-82b3-a321-f338-cbf8ff4e83eb@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 00:26:16 +0200
Message-ID: <CAHg0HuxvKZVjROMM7YmYJ0kOU5Y4UeE+a3V==LNkWpLFy8wqtw@mail.gmail.com>
Subject: Re: [PATCH v4 17/25] ibnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>,
        Roman Pen <r.peniaev@gmail.com>
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

On Wed, Sep 18, 2019 at 5:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
> Combining multiple queues (a) into a single queue (b) that is smaller
> than the combined source queues without sacrificing performance is
> tricky. We already have one such implementation in the block layer core
> and it took considerable time to get that implementation right. See e.g.
> blk_mq_sched_mark_restart_hctx() and blk_mq_sched_restart().

Roma, can you please estimate the performance impact in case we switch to it?
