Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE10EBBFD4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 03:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403750AbfIXB7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 21:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392902AbfIXB7j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 21:59:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5457485541;
        Tue, 24 Sep 2019 01:59:39 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B2D196B2;
        Tue, 24 Sep 2019 01:59:38 +0000 (UTC)
Date:   Tue, 24 Sep 2019 09:59:36 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [rdma-core patch] srp_daemon: print maximum initiator to target
 IU size
Message-ID: <20190924015936.GA28951@dhcp-128-227.nay.redhat.com>
References: <20190916013607.9474-1-honli@redhat.com>
 <deb829a3-813e-6b99-c932-ceecc06e09b3@acm.org>
 <20190918005508.GA8676@dhcp-128-227.nay.redhat.com>
 <46dfd841-f7d3-52fb-6737-253ce95108c2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46dfd841-f7d3-52fb-6737-253ce95108c2@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 24 Sep 2019 01:59:39 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 09:59:10AM -0700, Bart Van Assche wrote:
> On 9/17/19 5:55 PM, Honggang LI wrote:
> > On Tue, Sep 17, 2019 at 10:19:37AM -0700, Bart Van Assche wrote:
> > > On 9/15/19 6:36 PM, Honggang LI wrote:
> > > > From: Honggang Li <honli@redhat.com>
> > > > 
> > > > The 'Send Message Size' field of IOControllerProfile attributes
> > > > contains the maximum initiator to target IU size.
> > > > 
> > > > When there is something wrong with SRP login to a third party
> > > > SRP target, whose ib_srpt parameters can't be collected with
> > > > ordinary method, dump the 'Send Message Size' may help us to
> > > > diagnose the problem.
> > > > 
> > > > Signed-off-by: Honggang Li <honli@redhat.com>
> > > > ---
> > > >    srp_daemon/srp_daemon.c | 2 ++
> > > >    1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
> > > > index 337b21c7..90533c77 100644
> > > > --- a/srp_daemon/srp_daemon.c
> > > > +++ b/srp_daemon/srp_daemon.c
> > > > @@ -1022,6 +1022,8 @@ static int do_port(struct resources *res, uint16_t pkey, uint16_t dlid,
> > > >    			pr_human("        vendor ID: %06x\n", be32toh(target->ioc_prof.vendor_id) >> 8);
> > > >    			pr_human("        device ID: %06x\n", be32toh(target->ioc_prof.device_id));
> > > >    			pr_human("        IO class : %04hx\n", be16toh(target->ioc_prof.io_class));
> > > > +			pr_human("        Maximum initiator to target IU size: %d\n",
> > > > +				 be32toh(target->ioc_prof.send_size));
> > > >    			pr_human("        ID:        %s\n", target->ioc_prof.id);
> > > >    			pr_human("        service entries: %d\n", target->ioc_prof.service_entries);
> > > 
> > > How about using the terminology from the InfiniBand Architecture
> > 
> > As this is srp specific, so I suggest to use the terminology from
> > srp specification 'srp2r06'.
> > 
> > Table B.7 — IOControllerProfile attributes for SRP target ports
> > ----------------------------------------------------------------
> > | Field            | SRP requirement                           |
> > ----------------------------------------------------------------
> > |(skip many lines).....                                        |
> > ----------------------------------------------------------------
> > |Send Message Size |MAXIMUM INITIATOR TO TARGET IU LENGTH      |
> > ----------------------------------------------------------------
> > 
> > > Specification? This is what I found in release 1.3, table 306:
> > > 
> > > "Maximum size of Send Messages in bytes"
> 
> I don't have a strong opinion about which description to use. The latter may
> be easier to comprehend though. I'm not sure whether every SRP user knows
> what an SRP "IU" is ...

How about replacing "IU" with "information unit"?


+			pr_human("        Maximum initiator to target information unit size: %d\n",
+				 be32toh(target->ioc_prof.send_size));

If you want to use "Maximum size of Send Messages in bytes",
just let me know, I will send a new patch to use that.

thanks

