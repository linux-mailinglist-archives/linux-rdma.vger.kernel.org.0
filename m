Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2238177570
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 12:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgCCLq1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 06:46:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42772 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgCCLq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 06:46:26 -0500
Received: by mail-io1-f65.google.com with SMTP id q128so3177535iof.9
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXWGgH1x+UktANQkYHYSPZ/6rNvaZ6zkhKhunf2NceM=;
        b=FMbO050c4p6MGJP3+AFdwA4w3lceLtezexhaeKX+L7dLY5ENTVfVBgODj9X0hy1TQg
         vjx//40HmOg+gwzv84Xllz47LOUGujpUuFP9kXEbjW9BKiPAumOxXPDNiCLdE9TDpjXm
         WkQ06G3GszDo+RFRFhtb15SjFhimMbGON9dmHPXeE0jQlFtAsK6bEYLZkdMBk/CpT5x6
         lwJm4bSThtw4KOH8VzEepTmZdLYLfFQ2eBKEeRoETw4ss8hnzBrAMviguPFHOHH+AaBv
         nR3zLVkVTFhrDATe1ZK9JUP2feasUBzvXaynPoDKsA21uJrfwIoeq7+2kjMTyObK5fB4
         ClEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXWGgH1x+UktANQkYHYSPZ/6rNvaZ6zkhKhunf2NceM=;
        b=nKkQm76W7zsFqJrG0+PudZnVSABQ2GFKjWqS54IJH48y1yvkxu9Pf6xFjgpoNpteyD
         ILnZMBgZlma3vgswlbExLmHv/jSbsNC64N7eGZPhnGnymGUUCfUQiGyx52Zyztt+Q+z5
         jPwPpBIs2MX9mDLyrsatFOA7BIao1f4up8ZBkQPU9/Z75QPFNuT0w4J7H3T9qFjWDI/w
         nEDJ11EdiXOH6XmxsxERDVIfFotkVvvF+EbUxHlxGvvKl71yVPyalhxGI/FsEfnrTjLc
         cWyxdqyUvra1ZfknCHZUwHNrDetkc4hT9ZTPfCGWnmUyXiNRT70XW/K/F/Hy/0UTHnGr
         h9eQ==
X-Gm-Message-State: ANhLgQ2n6V0Jt1Cst4+CQ3fOUVuK8Cfllq2b090b/UYN2l+ZyayE8TNf
        b0y93A5ycZA7VsWBX9E8QzUglS/MyDlZx7oOdsFkNw==
X-Google-Smtp-Source: ADFU+vusrxQuVB1ZtYA8SQ4qybl/u1iRTPTP/U9VIMZZyAWr1l9iWH3VjK7DcQEhRhxF7Ke9/+wEDsYgBvIM7NoDmkk=
X-Received: by 2002:a05:6638:e8b:: with SMTP id p11mr3454172jas.11.1583235984324;
 Tue, 03 Mar 2020 03:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-8-jinpuwang@gmail.com>
 <20200303112857.GL121803@unreal>
In-Reply-To: <20200303112857.GL121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 12:46:13 +0100
Message-ID: <CAMGffEmkeXe5ngycYSR1RH4FU_K9NYoh_UF9Z5OQok4rgU+ZTw@mail.gmail.com>
Subject: Re: [PATCH v9 07/25] RDMA/rtrs: client: statistics functions
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
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

On Tue, Mar 3, 2020 at 12:29 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:47:03AM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This introduces set of functions used on client side to account
> > statistics of RDMA data sent/received, amount of IOs inflight,
> > latency, cpu migrations, etc.  Almost all statistics are collected
> > using percpu variables.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 205 +++++++++++++++++++
> >  1 file changed, 205 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > new file mode 100644
> > index 000000000000..3f556b884a4e
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > @@ -0,0 +1,205 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * RDMA Transport Layer
> > + *
> > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > + */
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > +
> > +#include "rtrs-clt.h"
> > +
> > +void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
> > +{
> > +     struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> > +     struct rtrs_clt_stats *stats = &sess->stats;
> > +     struct rtrs_clt_stats_pcpu *s;
> > +     int cpu;
> > +
> > +     cpu = raw_smp_processor_id();
> > +     s = this_cpu_ptr(stats->pcpu_stats);
> > +     if (unlikely(con->cpu != cpu)) {
> > +             s->cpu_migr.to++;
> > +
> > +             /* Careful here, override s pointer */
> > +             s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
> > +             atomic_inc(&s->cpu_migr.from);
> > +     }
> > +}
> > +
> > +void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
> > +{
> > +     struct rtrs_clt_stats_pcpu *s;
> > +
> > +     s = this_cpu_ptr(stats->pcpu_stats);
> > +     s->rdma.failover_cnt++;
> > +}
> > +
> > +int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
> > +                                      char *buf, size_t len)
> > +{
> > +     struct rtrs_clt_stats_pcpu *s;
> > +
> > +     size_t used;
> > +     int cpu;
> > +
> > +     used = scnprintf(buf, len, "    ");
> > +     for_each_possible_cpu(cpu)
> > +             used += scnprintf(buf + used, len - used, " CPU%u", cpu);
> > +
> > +     used += scnprintf(buf + used, len - used, "\nfrom:");
> > +     for_each_possible_cpu(cpu) {
> > +             s = per_cpu_ptr(stats->pcpu_stats, cpu);
> > +             used += scnprintf(buf + used, len - used, " %d",
> > +                               atomic_read(&s->cpu_migr.from));
> > +     }
> > +
> > +     used += scnprintf(buf + used, len - used, "\nto  :");
> > +     for_each_possible_cpu(cpu) {
> > +             s = per_cpu_ptr(stats->pcpu_stats, cpu);
> > +             used += scnprintf(buf + used, len - used, " %d",
> > +                               s->cpu_migr.to);
> > +     }
> > +     used += scnprintf(buf + used, len - used, "\n");
> > +
> > +     return used;
> > +}
> > +
> > +int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
> > +                                   size_t len)
> > +{
> > +     return scnprintf(buf, len, "%d %d\n",
> > +                      stats->reconnects.successful_cnt,
> > +                      stats->reconnects.fail_cnt);
>
> How will user know that first value is successful_cnt and second fail_cnt?
>
> > +}
> > +
> > +ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
> > +                                 char *page, size_t len)
> > +{
> > +     struct rtrs_clt_stats_rdma sum;
> > +     struct rtrs_clt_stats_rdma *r;
> > +     int cpu;
> > +
> > +     memset(&sum, 0, sizeof(sum));
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             r = &per_cpu_ptr(stats->pcpu_stats, cpu)->rdma;
> > +
> > +             sum.dir[READ].cnt         += r->dir[READ].cnt;
> > +             sum.dir[READ].size_total  += r->dir[READ].size_total;
> > +             sum.dir[WRITE].cnt        += r->dir[WRITE].cnt;
> > +             sum.dir[WRITE].size_total += r->dir[WRITE].size_total;
> > +             sum.failover_cnt          += r->failover_cnt;
> > +     }
> > +
> > +     return scnprintf(page, len, "%llu %llu %llu %llu %u %llu\n",
> > +                      sum.dir[READ].cnt, sum.dir[READ].size_total,
> > +                      sum.dir[WRITE].cnt, sum.dir[WRITE].size_total,
> > +                      atomic_read(&stats->inflight), sum.failover_cnt);
>
> Same question.
>
> Thanks
Hi Leon,

For all the sysfs entries, we documented in Documentation, in your
cases, it's in Documentation/ABI/testing/sysfs-class-rtrs-client,
in Patch 14.

Thanks!
