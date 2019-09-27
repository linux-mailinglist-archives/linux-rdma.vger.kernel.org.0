Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC91C04C1
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfI0MAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 08:00:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54400 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0MAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 08:00:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so6293696wmp.4
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 05:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sau4xOb8dPAV6A8mONisBLMb8Kneqh/zCycDLH7kVM=;
        b=JBx5mSIFQWc67My7BtaboyYPhlJ2ld2ZaxutYkYxsWk/2GoodnKW91vbnziHjt/6aE
         weQgSFmAO8xjf3Y8/jne6cmlJkhKRbzKNKrbTgu5e1ECiRfgJ3sFXJLQpxlQFNT696ma
         IGAXuZ9JcQrvNsK2R8W5QNGY8zOyGDdqk47EU1GXaY1l8DuwxYeCO8VE/ScWrbhmGlUY
         Hm8rt5hp7u+4BpNBO50CWDvdIKT+dg0JZmtZLdDE2sbUSMZGn4gcbtEKL9kbDdqpmdqX
         lS8/pyy0OHpXVZRyvQgnR1ZPodt61ZqbhHlGpbBjLCYagDYGNib+7D/RN4vTd0l4r/uv
         lwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sau4xOb8dPAV6A8mONisBLMb8Kneqh/zCycDLH7kVM=;
        b=TbRaJdXdGMlKP2jmvcj1KQWKkTC6Fp/qbeRnjUc+z1JEdVS97ohNLYEdTEvLkAGTfw
         Ptt/A2F7F9VmzQ+odEIJcsXJgrlZCoAfOLRbb/z9V3fZGweyRBSs5I7047OwY0Q6vOHk
         pgHxdKj+upfeXJtNx2TFlEe1W8Ye+ME7MY43FA2x6TAe/Q0lTCQv8G+cuuXVkw7hl02D
         wGiDqAKGNFsjTQrEN2YEhWFwvE8rdorGOJVaiiyRODD3+ZUgPPJg3p8lQ7wLkdguY8tM
         hhYsqg+0jv3yEl1wdDff0/kWV+wi2IMvwpjoWpUjJiVHku1zu5PfBFb0sU8i6pzeOEJ6
         YJxA==
X-Gm-Message-State: APjAAAVMwZwEXu2OABXqPPY9MPVRqlbii0+tVQblb0itpmJg+AMdUpDv
        6H7qXeJ/bTD7jt6cbp4C7u5o2lrYa4EQQdVodSjk2g==
X-Google-Smtp-Source: APXvYqySiV0qQ9lhK5Uto9CXxqqUPTX+RQLORdsyn9dS/8FaZXdJZDAA0Tc1FTVrOfx3oL89tccCvAvzqQ/EhQSNeB4=
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr6611245wmc.59.1569585622131;
 Fri, 27 Sep 2019 05:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-8-jinpuwang@gmail.com>
 <0f6ce58e-48f2-8020-f8f6-957cf464ae60@acm.org>
In-Reply-To: <0f6ce58e-48f2-8020-f8f6-957cf464ae60@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 14:00:11 +0200
Message-ID: <CAMGffEkud6di8veG0sVfLSY4Qe+ngMvPd4YnHh1SZK9-CeZnmA@mail.gmail.com>
Subject: Re: [PATCH v4 07/25] ibtrs: client: statistics functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 24, 2019 at 1:15 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +void ibtrs_clt_update_rdma_lat(struct ibtrs_clt_stats *stats, bool read,
> > +                            unsigned long ms)
> > +{
> > +     struct ibtrs_clt_stats_pcpu *s;
> > +     int id;
> > +
> > +     id = ibtrs_clt_ms_to_id(ms);
> > +     s = this_cpu_ptr(stats->pcpu_stats);
> > +     if (read) {
> > +             s->rdma_lat_distr[id].read++;
> > +             if (s->rdma_lat_max.read < ms)
> > +                     s->rdma_lat_max.read = ms;
> > +     } else {
> > +             s->rdma_lat_distr[id].write++;
> > +             if (s->rdma_lat_max.write < ms)
> > +                     s->rdma_lat_max.write = ms;
> > +     }
> > +}
>
> Can it happen that this function is called simultaneously from thread
> context and from interrupt context?
This can't happen, we only call the function from complete_rdma_req, and
complete_rdma_req is call from cq callback except fail_all_outstanding_reqs,
cq callback context is softirq, fail_all_outstanding_reqs is process
context, but we
disconnect and drain_qp before call into fail_all_outstading_reqs

>
> > +void ibtrs_clt_update_wc_stats(struct ibtrs_clt_con *con)
> > +{
> > +     struct ibtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> > +     struct ibtrs_clt_stats *stats = &sess->stats;
> > +     struct ibtrs_clt_stats_pcpu *s;
> > +     int cpu;
> > +
> > +     cpu = raw_smp_processor_id();
> > +     s = this_cpu_ptr(stats->pcpu_stats);
> > +     s->wc_comp.cnt++;
> > +     s->wc_comp.total_cnt++;
> > +     if (unlikely(con->cpu != cpu)) {
> > +             s->cpu_migr.to++;
> > +
> > +             /* Careful here, override s pointer */
> > +             s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
> > +             atomic_inc(&s->cpu_migr.from);
> > +     }
> > +}
>
> Same question here.
The function is only called from cq done callback,
>
> > +void ibtrs_clt_inc_failover_cnt(struct ibtrs_clt_stats *stats)
> > +{
> > +     struct ibtrs_clt_stats_pcpu *s;
> > +
> > +     s = this_cpu_ptr(stats->pcpu_stats);
> > +     s->rdma.failover_cnt++;
> > +}
>
> And here ...
this function only call from process context.

>
> Thanks,
>
> Bart.
Thanks,
Jinpu
