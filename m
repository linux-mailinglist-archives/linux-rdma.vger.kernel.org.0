Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E3C8D8F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfJBQBV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 12:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBQBV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 12:01:21 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A2A21D81;
        Wed,  2 Oct 2019 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570032080;
        bh=98zbXrCvdXboZ6utLF9G+ewXb0o0MRQR//RXyXSOsws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9W+NDYGqAwNAD6EgCb7f3FpIqwv/I4RP8VNI/7AFZ15nIH/WRpF3gmAk5TBiRzmg
         Psldqu6rZ9X1fI04nN9t0ZBTC+nEDsT54SFV+O0up5NpjqmDL+KqDtjiEnGIraacng
         ++3VindvhrpNpTfnouEuW2je+QbaDDqfo62OIOKM=
Date:   Wed, 2 Oct 2019 19:00:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Subject: Re: [PATCH v4 11/25] ibtrs: server: statistics functions
Message-ID: <20191002160056.GI5855@unreal>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-12-jinpuwang@gmail.com>
 <8477e5d5-036b-f3b5-976b-624b811baf38@acm.org>
 <CAMGffE=dBo-yZVOvyjyeauEEHzHOjmgtOjGKB+GiQiSoMX7Sig@mail.gmail.com>
 <20191002154219.GG5855@unreal>
 <CAMGffEmfOHPCEOXC8OGvq2r0S_hrbN1D5EJk0Lpvte=dd4L7Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmfOHPCEOXC8OGvq2r0S_hrbN1D5EJk0Lpvte=dd4L7Rg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 05:45:04PM +0200, Jinpu Wang wrote:
> On Wed, Oct 2, 2019 at 5:42 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Oct 02, 2019 at 05:15:10PM +0200, Jinpu Wang wrote:
> > > On Tue, Sep 24, 2019 at 1:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > >
> > > > On 6/20/19 8:03 AM, Jack Wang wrote:
> > > > > +ssize_t ibtrs_srv_stats_rdma_to_str(struct ibtrs_srv_stats *stats,
> > > > > +                                 char *page, size_t len)
> > > > > +{
> > > > > +     struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > > > > +     struct ibtrs_srv_sess *sess;
> > > > > +
> > > > > +     sess = container_of(stats, typeof(*sess), stats);
> > > > > +
> > > > > +     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > > > > +                      (s64)atomic64_read(&r->dir[READ].cnt),
> > > > > +                      (s64)atomic64_read(&r->dir[READ].size_total),
> > > > > +                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > > > > +                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > > > > +                      atomic_read(&sess->ids_inflight));
> > > > > +}
> > > >
> > > > Does this follow the sysfs one-value-per-file rule? See also
> > > > Documentation/filesystems/sysfs.txt.
> > > >
> > > > Thanks,
> > > >
> > > > Bart.
> > > It looks overkill to create one file for each value to me, and there
> > > are enough stats in sysfs contain multiple values.
> >
> > Not for statistics.
> 2 examples:
> cat /sys/block/nvme0n1/inflight
>        0        0
> cat /sys/block/nvme0n1/stat
>  1267566       53 85396638   927624  4790532  3076340 198306930
> 19413605        0  2459788 17013620    74392        0 397606816
> 6864

OMG, I feel sorry for users who now should go and read code to see what
column 3 in second row means.

We respect our users, please don't do like they did.

Thanks

>
> Thanks
