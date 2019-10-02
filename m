Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FCCC8D36
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfJBPpR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 11:45:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBPpR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 11:45:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so20198361wrv.13
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5p/0tThgyItyODv7V+0TAVxGAAHOFwJFUBoHw4F5G0=;
        b=gYoxaP2UH776VGMKgpsR/TmCJc9tGlF5ZZ75dA/fbSpuKq38JvZLL5gPWQXJqMsbhQ
         jjTOZAJ6RIZAtcDxP98Siq4LmdJzhuGc8kGfcqXHc9LKsRJLR6/Q7oxvY+Vohkm2ieQo
         WJJPfvBrPIzt89lTXOTBV25CpuUREwSqYXBZnazFDKl76cBYuxhoxoDKuohDOOMMGxAb
         LmIF6x+cDIm3hfDSy65/fpyXJS57pogqTA1jI/GX4TX9aGQ5ZEg3CaK/DGoEBfv0zi1i
         EXWNxrvMVQ6dceBuHa5DeOnQ3zb6Au9PZ+QatO56Z5o9Ynh8zMbpXYfiwReOtieePKJ1
         kEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5p/0tThgyItyODv7V+0TAVxGAAHOFwJFUBoHw4F5G0=;
        b=PN93im+bNLxCu0aBjSDY1Ec40EIIlhBDlc9GqeosTHwEuOReEGwZRODRC9JDV5BAQR
         Ar6BifJTDHclO252XvuV0H14YoFJDqkvg9epkuvWXRKqNs6PPcq69RKqMu0Bv0c43mUF
         SLq1laFF+JO9oMKgF/ZIUTzkTAFY1m9Dtd76xgRtTqpEr2Sy7K3baz4wwUiRbD21FsFN
         wU+4eDfGf3chaL6F/1j1763GdVXDWfN5+/iZjyHCsl3vKPuKkESVmBSQ3LVL322CXwJg
         oorMsvUBT06GBUOHjl+sjMackJ7bXXsEYrerMklOZWEPYJpAj7xAd4jfHd/vL0yGW7/w
         LXsw==
X-Gm-Message-State: APjAAAXjsnvzCOJ5Qa5QRtIfypVm4nozvjkqpA+7ggokAIi9DjO6nQZK
        sYm+wLdygN1taT1YOfcssVJS7IReqdi+xHgP9FUP2g==
X-Google-Smtp-Source: APXvYqz0qilpqeX88ijxeU7I/xyvTYeowmVr0R+DOax/VJOsJHJuxlfJai/yVIAL8OD1gUyL8Tm9tBzyvDoYPl+dpNQ=
X-Received: by 2002:adf:d192:: with SMTP id v18mr3531467wrc.9.1570031115489;
 Wed, 02 Oct 2019 08:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-12-jinpuwang@gmail.com>
 <8477e5d5-036b-f3b5-976b-624b811baf38@acm.org> <CAMGffE=dBo-yZVOvyjyeauEEHzHOjmgtOjGKB+GiQiSoMX7Sig@mail.gmail.com>
 <20191002154219.GG5855@unreal>
In-Reply-To: <20191002154219.GG5855@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 2 Oct 2019 17:45:04 +0200
Message-ID: <CAMGffEmfOHPCEOXC8OGvq2r0S_hrbN1D5EJk0Lpvte=dd4L7Rg@mail.gmail.com>
Subject: Re: [PATCH v4 11/25] ibtrs: server: statistics functions
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
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

On Wed, Oct 2, 2019 at 5:42 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Oct 02, 2019 at 05:15:10PM +0200, Jinpu Wang wrote:
> > On Tue, Sep 24, 2019 at 1:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On 6/20/19 8:03 AM, Jack Wang wrote:
> > > > +ssize_t ibtrs_srv_stats_rdma_to_str(struct ibtrs_srv_stats *stats,
> > > > +                                 char *page, size_t len)
> > > > +{
> > > > +     struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > > > +     struct ibtrs_srv_sess *sess;
> > > > +
> > > > +     sess = container_of(stats, typeof(*sess), stats);
> > > > +
> > > > +     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > > > +                      (s64)atomic64_read(&r->dir[READ].cnt),
> > > > +                      (s64)atomic64_read(&r->dir[READ].size_total),
> > > > +                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > > > +                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > > > +                      atomic_read(&sess->ids_inflight));
> > > > +}
> > >
> > > Does this follow the sysfs one-value-per-file rule? See also
> > > Documentation/filesystems/sysfs.txt.
> > >
> > > Thanks,
> > >
> > > Bart.
> > It looks overkill to create one file for each value to me, and there
> > are enough stats in sysfs contain multiple values.
>
> Not for statistics.
2 examples:
cat /sys/block/nvme0n1/inflight
       0        0
cat /sys/block/nvme0n1/stat
 1267566       53 85396638   927624  4790532  3076340 198306930
19413605        0  2459788 17013620    74392        0 397606816
6864

Thanks
