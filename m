Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC052E93FA
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 01:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfJ3ACy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 20:02:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:46957 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfJ3ACy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 20:02:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 17:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="211209685"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2019 17:02:54 -0700
Date:   Tue, 29 Oct 2019 17:02:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: Re: [PATCH rdma-next 07/16] RDMA/hfi1: Delete unreachable code
Message-ID: <20191030000253.GB18853@iweiny-DESK2.sc.intel.com>
References: <20191029062745.7932-1-leon@kernel.org>
 <20191029062745.7932-8-leon@kernel.org>
 <20191029233327.GA18853@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029233327.GA18853@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 04:33:27PM -0700, 'Ira Weiny' wrote:
> On Tue, Oct 29, 2019 at 08:27:36AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> > 
> > All callers allocate MAD structures with proper sizes,
> > there is no need to recheck it.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/hw/hfi1/mad.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
> > index d8ff063a5419..a54746f4a0ae 100644
> > --- a/drivers/infiniband/hw/hfi1/mad.c
> > +++ b/drivers/infiniband/hw/hfi1/mad.c
> > @@ -4921,10 +4921,6 @@ int hfi1_process_mad(struct ib_device *ibdev, int mad_flags, u8 port,
> >  {
> >  	switch (in_mad->base_version) {
> >  	case OPA_MGMT_BASE_VERSION:
> > -		if (unlikely(in_mad_size != sizeof(struct opa_mad))) {
> > -			dev_err(ibdev->dev.parent, "invalid in_mad_size\n");
> > -			return IB_MAD_RESULT_FAILURE;
> > -		}
> 
> It's been a while but I'm not 100% sure we can safely remove this check.  A
> user can send an IB sized MAD to an OPA device and AFAIR there is nothing
> checking that the base version is set correctly for the size of mad received by
> the mad stack.
> 
> Are you 100% sure that the in_mad_size is based off the management base
> version?

Ok, I _think_ this check may actually be wrong and we were just lucky because
handle_outgoing_dr_smp() uses the port _max_ MAD size as the in_mad_size which is
not _technically_ correct.  And in normal RX we are passing 2K as
in_mad_size...  Again _not_ technically correct but irrelevant because it looks
like we pass the actual bytes received in mad_priv->header.recv_wc->mad_len.

After looking at your last patch I started to remember more.  OPA MADs are
variable size so this was the reasoning for the addition of the in/out size
parameters.

But I see that nothing in the hfi1 driver is actually using the in_mad_size.
So I think we may be ok here but...

Denny, would be nice to get this patch set tested though...  Just to make sure.

Thanks, and sorry for the noise.
Ira

> 
> Also, regarding the patches to remove the checks on the IB devices I would want
> to see that check in the core MAD stack to verify we are not sending an OPA mad
> to an IB device.  I may have put a check in there already so removing the code
> in those drivers may be ok.  I'm not sure off the top of my head...
> 
> Ira
> 
> >  		return hfi1_process_opa_mad(ibdev, mad_flags, port,
> >  					    in_wc, in_grh,
> >  					    (struct opa_mad *)in_mad,
> > -- 
> > 2.20.1
> > 
