Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB9BC3B6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394791AbfIXIEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 04:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394728AbfIXIEC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 04:04:02 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0944207FD;
        Tue, 24 Sep 2019 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569312241;
        bh=2jeWQM6m3wIup0+X9fBpq/ATGcP+PJNn8f5+2TD4rvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMXX7/WD8Z6N6+Vp19H32f20/n3URmwxmwFJt6dZDDICAvyW77ZXUIziBu+zZAyAH
         27BZLpVQbaKpjI6fUjpyvovyi7KKMf7VGxa9PUvJ0UHJfYRjdC5z72X2GVeeT0sfy8
         hMO1dA5/tQJO2dR1hmwMAIkEPU5Z+MPNiouaC+Wg=
Date:   Tue, 24 Sep 2019 11:03:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Honggang LI <honli@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org
Subject: Re: [rdma-core patch] srp_daemon: print maximum initiator to target
 IU size
Message-ID: <20190924080358.GQ14368@unreal>
References: <20190916013607.9474-1-honli@redhat.com>
 <deb829a3-813e-6b99-c932-ceecc06e09b3@acm.org>
 <20190918005508.GA8676@dhcp-128-227.nay.redhat.com>
 <46dfd841-f7d3-52fb-6737-253ce95108c2@acm.org>
 <20190924015936.GA28951@dhcp-128-227.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190924015936.GA28951@dhcp-128-227.nay.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 24, 2019 at 09:59:36AM +0800, Honggang LI wrote:
> On Mon, Sep 23, 2019 at 09:59:10AM -0700, Bart Van Assche wrote:
> > On 9/17/19 5:55 PM, Honggang LI wrote:
> > > On Tue, Sep 17, 2019 at 10:19:37AM -0700, Bart Van Assche wrote:
> > > > On 9/15/19 6:36 PM, Honggang LI wrote:
> > > > > From: Honggang Li <honli@redhat.com>
> > > > >
> > > > > The 'Send Message Size' field of IOControllerProfile attributes
> > > > > contains the maximum initiator to target IU size.
> > > > >
> > > > > When there is something wrong with SRP login to a third party
> > > > > SRP target, whose ib_srpt parameters can't be collected with
> > > > > ordinary method, dump the 'Send Message Size' may help us to
> > > > > diagnose the problem.
> > > > >
> > > > > Signed-off-by: Honggang Li <honli@redhat.com>
> > > > > ---
> > > > >    srp_daemon/srp_daemon.c | 2 ++
> > > > >    1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> > > > > index 337b21c7..90533c77 100644
> > > > > --- a/srp_daemon/srp_daemon.c
> > > > > +++ b/srp_daemon/srp_daemon.c
> > > > > @@ -1022,6 +1022,8 @@ static int do_port(struct resources *res, uint16_t pkey, uint16_t dlid,
> > > > >    			pr_human("        vendor ID: %06x\n", be32toh(target->ioc_prof.vendor_id) >> 8);
> > > > >    			pr_human("        device ID: %06x\n", be32toh(target->ioc_prof.device_id));
> > > > >    			pr_human("        IO class : %04hx\n", be16toh(target->ioc_prof.io_class));
> > > > > +			pr_human("        Maximum initiator to target IU size: %d\n",
> > > > > +				 be32toh(target->ioc_prof.send_size));
> > > > >    			pr_human("        ID:        %s\n", target->ioc_prof.id);
> > > > >    			pr_human("        service entries: %d\n", target->ioc_prof.service_entries);
> > > >
> > > > How about using the terminology from the InfiniBand Architecture
> > >
> > > As this is srp specific, so I suggest to use the terminology from
> > > srp specification 'srp2r06'.
> > >
> > > Table B.7 — IOControllerProfile attributes for SRP target ports
> > > ----------------------------------------------------------------
> > > | Field            | SRP requirement                           |
> > > ----------------------------------------------------------------
> > > |(skip many lines).....                                        |
> > > ----------------------------------------------------------------
> > > |Send Message Size |MAXIMUM INITIATOR TO TARGET IU LENGTH      |
> > > ----------------------------------------------------------------
> > >
> > > > Specification? This is what I found in release 1.3, table 306:
> > > >
> > > > "Maximum size of Send Messages in bytes"
> >
> > I don't have a strong opinion about which description to use. The latter may
> > be easier to comprehend though. I'm not sure whether every SRP user knows
> > what an SRP "IU" is ...
>
> How about replacing "IU" with "information unit"?
>
>
> +			pr_human("        Maximum initiator to target information unit size: %d\n",
> +				 be32toh(target->ioc_prof.send_size));
>
> If you want to use "Maximum size of Send Messages in bytes",
> just let me know, I will send a new patch to use that.

What is the resolution?

Thanks

>
> thanks
>
