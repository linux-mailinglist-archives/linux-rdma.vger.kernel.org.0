Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF98175DBA
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCBO6x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 09:58:53 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46486 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgCBO6x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 09:58:53 -0500
Received: by mail-il1-f194.google.com with SMTP id e8so4882913ilc.13
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cG4KsHZknk99RFAGLY2oUd12iQAqEbe0ngzbaTgxBLs=;
        b=d+DRBDf95wOhIma41cTAJGdPgDW+Dp7ZGUVmhK86PIS6GGy+8+4wxd6vVd8cMFTxRN
         TrB6Di0ODdvMFlE6L3MiH90+4JSMzRuBCHECqG/UFx/E5CNXTQXL0dnBOthwKX6QT2dA
         zPM7nR18XM7G5tG5W+b5E3U6WUSHbjBFQR4FczIfwfu/I5ehmRdfNeAqQPsvTh12RCzl
         9E5b8lfBOs4di9iXeCD1TEPGFUyyqXyguVaJkP40q0JtP5HUl9yENvlLHTO3wrsL1LLF
         1lHhK1AuiG5BTqMZrgkfdLaj7VBGClnd2EN6pTanzL9cNP0+3BWbu9InSwX4/3kMy3jG
         ox1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cG4KsHZknk99RFAGLY2oUd12iQAqEbe0ngzbaTgxBLs=;
        b=X3VYHjiMH2QxWfGG9BPV/+tJ3gPmb8FXE/QAZIP5cwIS/vO4XHR+ayht8J8a+BP536
         L3WINmrf9QaGMt6Qx78L4Kw0f0Yyvx1BuVBCw3rGiqU5ayobKWo8m4Zu8w8kNW5P0SRu
         y4vvXm8rCKKEWbfb8PVBEF6l6niLt9KY8dSd1QI7bblZZLjJV8W6dn3nmZiCAljVvut3
         j6L3cMyI8eYN5CueFgnaVe633VWwAxc07iQjuWein83Cv4+jYv1lk3VrPHVEx+M5vco/
         zQt5Ia+HsEc7XYQGX0x/YNmveRTt9mmxxachxIZEM9c9DBFIcwVnslHsfAbgHQokNVtX
         YmnQ==
X-Gm-Message-State: APjAAAULzmVZqSoEFbwyj85QgBsSzMdIR8K3Qiekmr90v+yurFHHIK5z
        bO0VD59HhldV7jzzzL7Ug8C7rj603BPv7q6n8X92hA==
X-Google-Smtp-Source: APXvYqzrdXEjLFBQzui9YPT8H0wMTdTYQjUtGiULMNldXhahY4Q5ydkZR7S7q2efjkrij8R52Foz1s0IrydUfWKsakc=
X-Received: by 2002:a92:af08:: with SMTP id n8mr16230470ili.217.1583161132897;
 Mon, 02 Mar 2020 06:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-18-jinpuwang@gmail.com>
 <16e946dd-b244-594b-937e-689f2f23614e@acm.org>
In-Reply-To: <16e946dd-b244-594b-937e-689f2f23614e@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:58:42 +0100
Message-ID: <CAMGffEnrX0+ktLPOocEt6kOYJ93F1yOYYCwrvnZQuWVCQG3qRQ@mail.gmail.com>
Subject: Re: [PATCH v9 17/25] block/rnbd: client: main functionality
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

On Sun, Mar 1, 2020 at 3:46 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +/**
> > + * rnbd_get_cpu_qlist() - finds a list with HW queues to be rerun
> > + * @sess:    Session to find a queue for
> > + * @cpu:     Cpu to start the search from
> > + *
> > + * Description:
> > + *     Each CPU has a list of HW queues, which needs to be rerun.  If a list
> > + *     is not empty - it is marked with a bit.  This function finds first
> > + *     set bit in a bitmap and returns corresponding CPU list.
> > + */
> > +static struct rnbd_cpu_qlist *
> > +rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
> > +{
> > +     int bit;
> > +
> > +     /* First half */
> > +     bit = find_next_bit(sess->cpu_queues_bm, nr_cpu_ids, cpu);
> > +     if (bit < nr_cpu_ids) {
> > +             return per_cpu_ptr(sess->cpu_queues, bit);
> > +     } else if (cpu != 0) {
> > +             /* Second half */
> > +             bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
> > +             if (bit < cpu)
> > +                     return per_cpu_ptr(sess->cpu_queues, bit);
> > +     }
> > +
> > +     return NULL;
> > +}
>
> Please make the "first half" and "second half" comments unambiguous. To
> me it seems like the code under "first half" searches through the second
> half of the bitmap and that the code under "second half" searches
> through the first half of the bitmap.
Ok, will improve the comments, say searching  "cpu to nr_cpu_ids" and "0 to cpu"
>
> > +     /**
> > +      * That is simple percpu variable which stores cpu indeces, which are
> > +      * incremented on each access.  We need that for the sake of fairness
> > +      * to wake up queues in a round-robin manner.
> > +      */
>
> Please start block comments with "/*".
ok
>
> > +static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
> > +     __releases(&sess_lock)
> > +     __acquires(&sess_lock)
> > +{
> > +     DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
>
> Please use DEFINE_WAIT() instead of open-coding it.
ok
>
> Thanks,
>
> Bart.

Thanks!
