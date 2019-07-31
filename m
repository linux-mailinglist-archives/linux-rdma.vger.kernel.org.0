Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD427B8A9
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 06:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfGaE2D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 00:28:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:6051 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387473AbfGaE2D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 00:28:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 21:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,328,1559545200"; 
   d="scan'208";a="371952775"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2019 21:28:02 -0700
Date:   Tue, 30 Jul 2019 21:28:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Add mitigation for Spectre V1
Message-ID: <20190731042801.GA2179@iweiny-DESK2.sc.intel.com>
References: <20190730202407.31046-1-tony.luck@intel.com>
 <95f5cf70-1a1d-f48c-efac-f389360f585e@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f5cf70-1a1d-f48c-efac-f389360f585e@embeddedor.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 06:52:12PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 7/30/19 3:24 PM, Tony Luck wrote:
> > Some processors may mispredict an array bounds check and
> > speculatively access memory that they should not. With
> > a user supplied array index we like to play things safe
> > by masking the value with the array size before it is
> > used as an index.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> > 
> > [I don't have h/w, so just compile tested]
> > 
> >  drivers/infiniband/core/user_mad.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
> > index 9f8a48016b41..fdce254e4f65 100644
> > --- a/drivers/infiniband/core/user_mad.c
> > +++ b/drivers/infiniband/core/user_mad.c
> > @@ -49,6 +49,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/semaphore.h>
> >  #include <linux/slab.h>
> > +#include <linux/nospec.h>
> >  
> >  #include <linux/uaccess.h>
> >  
> > @@ -888,6 +889,7 @@ static int ib_umad_unreg_agent(struct ib_umad_file *file, u32 __user *arg)
> >  	mutex_lock(&file->port->file_mutex);
> >  	mutex_lock(&file->mutex);
> >  
> > +	id = array_index_nospec(id, IB_UMAD_MAX_AGENTS);
> 
> This is wrong. This prevents the below condition id >= IB_UMAD_MAX_AGENTS
> from ever being true. And I don't think this is what you want.

Ah Yea...  FWIW this would probably never be hit.

Tony; split the check?

	if (id >= IB_UMAD_MAX_AGENTS) {
		ret = -EINVAL;
		goto out;
	}

	id = array_index_nospec(id, IB_UMAD_MAX_AGENTS);

	if (!__get_agent(file, id)) {
		ret = -EINVAL;
		goto out;
	}

Ira

> 
> >  	if (id >= IB_UMAD_MAX_AGENTS || !__get_agent(file, id)) {
> >  		ret = -EINVAL;
> >  		goto out;
> > 
> 
> --
> Gustavo
