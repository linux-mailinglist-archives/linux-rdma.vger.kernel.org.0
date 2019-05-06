Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826021541D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEFTDG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 15:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfEFTDG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 15:03:06 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62AC20830;
        Mon,  6 May 2019 19:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557169385;
        bh=niyk2JMKSWZdJ1knoPmjJ4idLaWjT6AaVwKvCH/77Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daOXKpLhgGK8USjShZybDXmaD2Owag3b6IaUKgQfm5YR5QbCWcT+rt8hcvOFzTvVE
         zOmxaJXvjAnTwA6UM3wtlksj7AE9umWOzWFd8BIMh5dfPo2vI4FJYktaWOVy7wzL9P
         tnvYe7KI1fQVSJSL05zVsjNVrZ2jSK84I1nmFThE=
Date:   Mon, 6 May 2019 22:03:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190506190300.GN6938@mtr-leonro.mtl.com>
References: <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
 <20190327152517.GD69236@devbig004.ftw2.facebook.com>
 <20190327171611.GF21008@ziepe.ca>
 <20190327190720.GE69236@devbig004.ftw2.facebook.com>
 <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 05:52:48PM +0000, Marciniszyn, Mike wrote:
> >
> > My mistake.  It's been a long while since I coded the stuff I did for
> > memory reclaim pressure and I had my flag usage wrong in my memory.
> > From the description you just gave, the original patch to add
> > WQ_MEM_RECLAIM is ok.  I probably still need to audit the ipoib usage
> > though.
> >
> > --
> > Doug Ledford <dledford@redhat.com>
> >     GPG KeyID: B826A3330E572FDD
> >     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
>
> Don't lose sight of the fact that the additional of the WQ_MEM_RECLAIM is to silence
> a warning BECAUSE ipoib's workqueue is WQ_MEM_RECLAIM.  This happens while
> rdmavt/hfi1 is doing a cancel_work_sync() for the work item used by the QP's send engine
>
> The ipoib wq needs to be audited to see if it is in the data path for VM I/O.

It is, at least we had a test of NFS running over IPoIB and it needed WQ_MEM_RECLAIM back then.

Thanks

>
> Mike
>
>
