Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A54631C3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 12:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhK3LGq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 06:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhK3LGq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Nov 2021 06:06:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22635C061574
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 03:03:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r11so85146496edd.9
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 03:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaxToQRlTo/EIBW0aRpBz2yRsmFcrik1qWRmtk8sVq0=;
        b=NAKKWMmw+M7GlQQcyB5EXDgDC35GDvEMCm7/rQWegCaZ8dQv0M+GjnjdlgtWRZXTYx
         6cYd/5duMzdkpp4O6TuP3qKoy0Ryy+m1fMHbl6zHU4g9FOYGXh8Xlps6iP5LXx9OlN+R
         66nS3d6TAuTwibRp6W2STQgL5YTp0UrPiq6n6DW3guQCshTaPPn92JIkj0Ilh1HqB7/b
         Od8TaNP/i9Wr2kEokOYvL/ru9tQNJQY1cwSyOTDKALWZtSZrtmF4JD/X3rWWaJzt9XiW
         8TZNDCRTWDu5HjzlMZBJvnCQmCs0y0yNcV14oYk3k1vEGFWIx9iLUnC37ecq3K6X3RtB
         5gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaxToQRlTo/EIBW0aRpBz2yRsmFcrik1qWRmtk8sVq0=;
        b=fFdeshr9ZCrneddUqNRfZsold/Ir8nXK3aUUKlqed4YdZBNQKn0hDqEafMjLbSGsCk
         VOSEZzjyZkIQizuDVPvHSlC4fgykm0dI94dMjrFgxgIz8OUZJhhBaj5I7DQLohyfixTW
         JSRZMPZfk//2oFUROuR5mRbzjphRAZbta+lguKDW/EBGeqxHqVKkSmIVbR3vRM6hL5GC
         1NeU56W6nLccOhoAK5xQchWuMw6uusepXhqrX7whmiPIsYZrwXIBwgS3RVN5sxXiAv+i
         3u47umRom6SbbYYAPCmADMu+J2CK+RWhSNCqx5OgjE1l+v1iT2FtpedLDTtj6Lyine0S
         l3hA==
X-Gm-Message-State: AOAM532JxSLHdmM1N+XaLNnYm1UIBcx0nfPDJ9IlipgxSR5QHw+K0bLp
        eL7mdjFpr6IgdfKWI3cugabwUuGQ+HAlEfsFXMWC0KqXm3E=
X-Google-Smtp-Source: ABdhPJyNOQ0+3Q6XWC5ibgiBLa1kXYFH0vP0qk9h14ZqMgReyJihL6eASNmRWo/9KH6shv9yCOOxhp5+5YEksLGfzCI=
X-Received: by 2002:aa7:c04a:: with SMTP id k10mr81051742edo.308.1638270205691;
 Tue, 30 Nov 2021 03:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20211128133501.38710-1-guoqing.jiang@linux.dev> <alpine.DEB.2.22.394.2111301137560.294061@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2111301137560.294061@gentwo.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 30 Nov 2021 12:03:15 +0100
Message-ID: <CAMGffEmE6789WiYbX4+XXt3ZwPCcx8AjLDDnhYJsSfb0Pu7oYg@mail.gmail.com>
Subject: Re: [PATCH V2] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
To:     Christoph Lameter <cl@gentwo.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, haris.iqbal@ionos.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 30, 2021 at 11:40 AM Christoph Lameter <cl@gentwo.org> wrote:
>
> On Sun, 28 Nov 2021, Guoqing Jiang wrote:
>
> >       int cpu;
> >
> >       cpu = raw_smp_processor_id();
> > -     s = this_cpu_ptr(stats->pcpu_stats);
> > +     s = get_cpu_ptr(stats->pcpu_stats);
> >       if (con->cpu != cpu) {
> >               s->cpu_migr.to++;
> >
> > @@ -27,14 +27,16 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
> >               s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
> >               atomic_inc(&s->cpu_migr.from);
> >       }
> > +     put_cpu_ptr(stats->pcpu_stats);
> >  }
> >
> >  void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
> >  {
> >       struct rtrs_clt_stats_pcpu *s;
> >
> > -     s = this_cpu_ptr(stats->pcpu_stats);
> > +     s = get_cpu_ptr(stats->pcpu_stats);
> >       s->rdma.failover_cnt++;
> > +     put_cpu_ptr(stats->pcpu_stats);
>
> This is equivalent to
>
> this_cpu_inc(stats->pcpu_stats.rdma.failover_cnt);
>
> Which will also reduce the segment to a single cpu instruction.
Thanks for your suggestion, Christoph.
As the patch is already applied, I will send a new patch as suggested.
>
> >  }
> >
> >  int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
> > @@ -169,9 +171,10 @@ static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
> >  {
> >       struct rtrs_clt_stats_pcpu *s;
> >
> > -     s = this_cpu_ptr(stats->pcpu_stats);
> > +     s = get_cpu_ptr(stats->pcpu_stats);
> >       s->rdma.dir[d].cnt++;
> >       s->rdma.dir[d].size_total += size;
> > +     put_cpu_ptr(stats->pcpu_stats);
> >  }
>
> Ditto
>
Regards!
