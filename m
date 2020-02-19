Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9680D1652FD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 00:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSXS2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 18:18:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:21759 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgBSXS2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 18:18:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 15:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="382952322"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2020 15:18:27 -0800
Date:   Wed, 19 Feb 2020 15:18:27 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: RDMA device renames and node description
Message-ID: <20200219231826.GD31320@iweiny-DESK2.sc.intel.com>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
 <20200219071129.GD15239@unreal>
 <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
 <20200219165800.GS31668@ziepe.ca>
 <03a8dd71-4031-4800-349f-525a013c2101@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a8dd71-4031-4800-349f-525a013c2101@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 02:35:09PM -0500, Dennis Dalessandro wrote:
> On 2/19/2020 11:58 AM, Jason Gunthorpe wrote:
> > On Wed, Feb 19, 2020 at 09:14:06AM -0500, Dennis Dalessandro wrote:
> > 
> > > > ABI breakage is a strong word, luckily enough it is not defined at all.
> > > > We never considered dmesg prints, device names, device ordering as an
> > > > ABI. You can't rely on debug features too, they can disappear too.
> > > 
> > > Agree, it is a strong word and we can call it what you want. The point is
> > > you should be able to rely on the node description not being changed out
> > > from under you unnecessarily though. We aren't talking about a debug feature
> > > here but a core feature to real world deployments.
> > 
> > People really use the node description as some stable name? And then
> > they put the HCA name in it? Why?
> 
> I've seen it in multiple places. Including storage configuration files.
> Suffice to say, yes people use it.
> 
> > Is that some thing unique to the OPA subnet manager?
> 
> I don't think so.
> 
> > I don't recall people complaining about this when we introduced
> > rdma-ndd by default and changed all the node descriptions away from
> > the kernel default.
> 
> Sure but the reason rdma-ndd exists is because people care about the node
> descriptions.

Yes people do.  Give a sys-admin 

0x00117501017af5cc
vs
node0170 hca-0

And see which one they get frustrated with.

>
> I can't really speak to the historical adoption of rdma-ndd

I originally wrote it...  So I have some history.

> but I believe it was a stand alone package/feature and was a conscious
> decision to use or not as opposed to the one package to rule them all
> rdma-core like we have now.

rdma-ndd was built to solve the race between potential host name changes and
ports coming on line.

The background is that many people use hostnames to describe their nodes and if
they wanted to configure rdma-ndd it would react to new ports and/or the
hostname updates and turn around and update the node descriptor according to a
configuration specified...  If the user wanted to use hostnames they could...
Or it could be configured with some static name if that is what admins wanted.
Hostname was just the "most likely choice".

> 
> > Also don't forget the whole thing about the node description is
> > inherently racey, so relying on it is Rather A Bad Idea.
> 
> I think that point is well taken and I don't think anyone is against the
> idea of fixing the "hacky" things as you like to say. This one just caught
> people by surprise is all.
> 
> > Should we change the default format string of rdma-ndd to something
> > else?
> 
> I'm not sure. I can envision situations where a user has updated libraries
> that are happy with the new persistent names but still want the node
> description to not change. If rdma-ndd could do something to keep the node
> desc the same, then in situations like this the device rename would not have
> to be disabled.
> 
> Given that we have seen problems with MVAPICH (even with mlx5), libfabric,
> psm2, and I believe open mpi has a similar issue, and that Intel, Amazon,
> RedHat, and Suse are experiencing issues from this I think we should make
> things as flexible as possible to protect users from breakages.
> 
> We do want to move in a forward direction though so we don't want to go back
> to the old way unilaterally. I think distros can handle their upgrade
> situations and if we build in protection to rdma-ndd something like a
> specific udev rule for keeping the node desc the same. That gives us the
> flexibility until all the software and use cases catch up.

The use of node descriptor was intended to be entirely up to the installation
in a manner to debug/locate nodes.  Not be used in libraries.  I'm surprised
that libraries are broken.

Regardless does the old rdma-ndd config exist?  Could it be configured and/or
modified to give the old names?  When it was written we designed the default
config to give the old names for backwards compatibility.  Apparently this is
no longer true?

Ira

> 
> -Denny
