Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905E2175F5C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCBQSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 11:18:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37989 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgCBQSo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 11:18:44 -0500
Received: by mail-io1-f68.google.com with SMTP id s24so12166210iog.5
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QoJBOzsSDvcA2tn9M+h3AKpf0S01wAffIbTzZfpZ94=;
        b=UIY+zNvRhdIQ8pA8uOiET5s+VmUKuguaxRXjmWChn91z5VbI2RFQwpl0t2WN3IcPuN
         wPfupFz7SjlhwHpk3ZjPqeI/rBxVUtnUnpFpy4FBP+Y4BjUb/ZF6sLo7ouNwKqNefwSU
         aLqkOSa+Utz++BTearn9xChZmVWxa5S/BLi6kNUtIPJdvjWF5EDptcdJhVdXe6+/SvZj
         EZhUu0EkaISrmenNMxbnEFEDqwn9NB73vYeIaJhP6CetnAO6jLx0v8Rhu3+jJUgDYDXC
         SooR/1Okqh02R6W1HPTUPwRbPN3cVHXaFyzAWZwvky4Ptu0Y0VomAPxDFMKfCoLlnudM
         Bo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QoJBOzsSDvcA2tn9M+h3AKpf0S01wAffIbTzZfpZ94=;
        b=D3memKk/KjJQ7gCqPq+R3QP9vKMI/ejna26GWFM0qCuZhzzp6xIl33SoxSBxXfkQw6
         9l9RkOFYdGwfiPMUfDfS56Sky+SIaikz4R5grK800umlcK44TAvfKh7oGC6YFymJhDD0
         lg42GqjoLE2F6iHvCjsBA8at1YbpPmdGq+y8IV6KhRjTgxUBnXKSAm11UidiVk92eoxP
         unWkfPK1G7z2bnRoBsC0gsWboWRTk6eTyUiYBiEJIP/9nu72ySvphjwK13tPV6+Kh6p4
         tnNmBZxteRTyLVHLi4hMHdf5NhfAXOAyFhfFGe96rUh/mrx2+3GCy4mfJ3i2ZSxrb8Fy
         IyGg==
X-Gm-Message-State: ANhLgQ3xadGXoQN3RgXlbWd+xVx199tIXSGMvsC6zyJieZ/AhrvLMilC
        73+kyFD40Pv7NuWTON6k7JvD88DhiXUDEvI0wbNoGw==
X-Google-Smtp-Source: ADFU+vtq0yIRjcizQ63TSnvTjrv4AE/Cl+VOuKnjaVBsW3PmF1xbM+AZxLAfYV/SDJ42V6Y60hUagYEZjZfmGzooJmA=
X-Received: by 2002:a6b:5a06:: with SMTP id o6mr269046iob.54.1583165922611;
 Mon, 02 Mar 2020 08:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-6-jinpuwang@gmail.com>
 <eb1759a7-c51b-eaeb-f353-4b948b1d64e3@acm.org> <CAMGffEmM8dtcO=uYg5drafaz5FjGV4ynQBpyGZFZwVMptgxcBw@mail.gmail.com>
 <fc0c1962-d5d6-96c0-cd5b-3e51a1aeb98e@acm.org>
In-Reply-To: <fc0c1962-d5d6-96c0-cd5b-3e51a1aeb98e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 17:18:31 +0100
Message-ID: <CAMGffEncM6JDoQcGt5wuXAhOqc3qsB03cxKqd741VNpyU1sWPg@mail.gmail.com>
Subject: Re: [PATCH v9 05/25] RDMA/rtrs: client: private header with client
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 2, 2020 at 5:13 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/2/20 5:49 AM, Jinpu Wang wrote:
> > On Sun, Mar 1, 2020 at 1:51 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 2020-02-21 02:47, Jack Wang wrote:
> >>> +struct rtrs_clt {
> >>> +     struct list_head   /* __rcu */ paths_list;
> >>
> >> The commented out __rcu is confusing. Please remove it and add an
> >> elaborate comment if paths_list is a list head with nonstandard behavior.
> > Will change to a normal comment, we want to use rculist, but no such
> > annotation usage for normal list_head, only hlist_head in kernel tree,
> > Do you know why?
>
> Hi Jack,
>
> I'm not aware of any annotation for RCU lists nor for RCU list elements
> that is recognized by sparse. What I do myself is to add a comment to
> each list_head that explains whether it represents a list head or a list
> element and also what the strategy is for ensuring thread-safety.
>
> Thanks,
>
> Bart.
>
Got it, thanks Bart!
