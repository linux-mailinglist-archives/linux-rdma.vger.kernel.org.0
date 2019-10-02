Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2904EC8D1A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfJBPmZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 11:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJBPmZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 11:42:25 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43EC21920;
        Wed,  2 Oct 2019 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570030944;
        bh=3MknwuQ+7iik5TpzqY1MVAEIi9owxEpZOx6iaCTi4OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uz3hOINOlwyqMEdPScmFn1B2GyCXO0t1bvqa05mjSgJG7y2KkzLrwVJHrIfREg3PN
         CqzZnBzlZPWPao4ff3d7xJ5ZiRnREO9GT0Yb3plPB5SihxWIGLn40uMz/ls52TvQmo
         Y48E5kd8fjEV+pgfoyFc6wJxHKZV2KKXz0QHMx4Q=
Date:   Wed, 2 Oct 2019 18:42:19 +0300
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
Message-ID: <20191002154219.GG5855@unreal>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-12-jinpuwang@gmail.com>
 <8477e5d5-036b-f3b5-976b-624b811baf38@acm.org>
 <CAMGffE=dBo-yZVOvyjyeauEEHzHOjmgtOjGKB+GiQiSoMX7Sig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=dBo-yZVOvyjyeauEEHzHOjmgtOjGKB+GiQiSoMX7Sig@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 05:15:10PM +0200, Jinpu Wang wrote:
> On Tue, Sep 24, 2019 at 1:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 6/20/19 8:03 AM, Jack Wang wrote:
> > > +ssize_t ibtrs_srv_stats_rdma_to_str(struct ibtrs_srv_stats *stats,
> > > +                                 char *page, size_t len)
> > > +{
> > > +     struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > > +     struct ibtrs_srv_sess *sess;
> > > +
> > > +     sess = container_of(stats, typeof(*sess), stats);
> > > +
> > > +     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > > +                      (s64)atomic64_read(&r->dir[READ].cnt),
> > > +                      (s64)atomic64_read(&r->dir[READ].size_total),
> > > +                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > > +                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > > +                      atomic_read(&sess->ids_inflight));
> > > +}
> >
> > Does this follow the sysfs one-value-per-file rule? See also
> > Documentation/filesystems/sysfs.txt.
> >
> > Thanks,
> >
> > Bart.
> It looks overkill to create one file for each value to me, and there
> are enough stats in sysfs contain multiple values.

Not for statistics.

Thanks

>
> Thanks
> Jinpu
