Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B00134259
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 13:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgAHMzn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 07:55:43 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38462 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAHMzn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 07:55:43 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so2563600ilq.5
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2020 04:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+b+8uoqmDNLdb7NpY/ylmrSBRhxXRp5uOtfvXbiX9A=;
        b=G/PyWGGtb+Py0dClzGP/KAya6c/8oIqrjxKFXtN70jFJvM0rcUdBmLTTpunOVdiv+N
         0NR13jD1Z0uk8Y9PbSfcu2I4EnlLWg3Tf3f20B81oHbKSPQbQQ33ea8mQhKa7Gd66LgY
         WMLY1jYYOdQoyhmhru3EUMkVDxPVy96srkmO7YVp4DT2S5N/r7qouP20FvtZvy5uSs+g
         qXpi4Wgz6a8C+9LTzMTPPZSp5eouvZ0uP+qDROkAXlWskLTDrvQcqLcvK7aqTRmTNfDS
         ume5IrCoIZp+YvdrBGZuwXDNGNnyFPNw8Xt0IfxdCdgsdSbuIdaL/wsa1/WJ2+QXRkEI
         lmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+b+8uoqmDNLdb7NpY/ylmrSBRhxXRp5uOtfvXbiX9A=;
        b=LL4uramAGeTbFaVipd183gxlskKgybvISqrwJ+nB45vll09V3cHk54GZtdvmPhlKoH
         nDHOogTYpg3XrLb7jsQ8XOekWBULROeueaMhDk13hHNBd+13lj37PowUMvlODGpDzev7
         VZryVStv3Gk9onDV/jiFYzfCULYKimj076RCiZBXWBOjs28DPxiEEwglzy9j5ogWB7OP
         dBzcypJQ/XO3P2EoDVRAKzhLJN2qlXqVlawDlebICJnNTj9eEddIZj6thRLM8IJy0DIL
         ubINJ2EKv8fqDermUHOLkrwZ+It/kJrnTQtrkC8hgAMSxBCaWfxO0ur0jUPAnZUrkSY5
         eVEQ==
X-Gm-Message-State: APjAAAXqMzXkY/p43S1jtyr3F9ow5Q8kkZBQ4OCcbkbE8lNmAqo6nVPH
        LHA/3XGyrZqWetmyQmFOMFmGI+KlmBHL6XqNkelQqg==
X-Google-Smtp-Source: APXvYqxjWz5Zu/qB+Fax140bVTtEwJQWBCp+FkDPXFvvURppEcOqP3v9PXN2vHxa++l6XhOxpc/uSNaj8M76EP3Rft0=
X-Received: by 2002:a92:1090:: with SMTP id 16mr3578708ilq.298.1578488142467;
 Wed, 08 Jan 2020 04:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-12-jinpuwang@gmail.com>
 <15c76744-8ce8-e70a-506a-1a28c2518de0@acm.org>
In-Reply-To: <15c76744-8ce8-e70a-506a-1a28c2518de0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 13:55:31 +0100
Message-ID: <CAMGffEmdHcoefDAOxGAaKwC05YFXFj6+9rM7MwnYnJ4a2t5hdQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/25] rtrs: server: statistics functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 2, 2020 at 11:02 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
> > +{
> > +     if (enable) {
> > +             struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > +
> > +             memset(r, 0, sizeof(*r));
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
>
> I think the traditional kernel coding style is "if (!enable) return ...".
This can be changed.
>
> > +ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
> > +                                 char *page, size_t len)
> > +{
> > +     struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > +     struct rtrs_srv_sess *sess;
> > +
> > +     sess = container_of(stats, typeof(*sess), stats);
> > +
> > +     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > +                      (s64)atomic64_read(&r->dir[READ].cnt),
> > +                      (s64)atomic64_read(&r->dir[READ].size_total),
> > +                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > +                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > +                      atomic_read(&sess->ids_inflight));
> > +}
>
> Does this follow the sysfs one-value-per-file rule?
We have user space tools already depend on it.
On the other side one-value-per-file rule is never really enforced,
see https://lwn.net/Articles/378884/
I think it doesn't really make sense for the use case.
>
> > +int rtrs_srv_stats_wc_completion_to_str(struct rtrs_srv_stats *stats,
> > +                                      char *buf, size_t len)
> > +{
> > +     return snprintf(buf, len, "%lld %lld\n",
> > +                     (s64)atomic64_read(&stats->wc_comp.total_wc_cnt),
> > +                     (s64)atomic64_read(&stats->wc_comp.calls));
> > +}
>
> Same comment here.
See comment above.
>
> Thanks,
>
> Bart.
Thanks Bart
