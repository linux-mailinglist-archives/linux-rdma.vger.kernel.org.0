Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B667D1FAFE0
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 14:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPMIx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 08:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPMIx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 08:08:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4196E2074D;
        Tue, 16 Jun 2020 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592309332;
        bh=Mg11qQB7ESq6nNysFeavutlOj+KhMphPo0hap2y+mLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcv615ee4MKh3s2KMJYZzsQiDo0PubwzQ0nQENKckyV489L7GKxqH/ah8Mr9sOm51
         KCAyd60kBAnGrM6Q0coZJ/4F/k23SaEjW3gzIxK/vIsrdZ2evf8uw/q5J4BOa1VOS3
         5JylxKRfVO9eZGKI1999GURP1oLTpMmLFNNN7jrA=
Date:   Tue, 16 Jun 2020 14:08:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2.6.26-4.14] IB/ipoib: Arm "send_cq" to process
 completions in due time
Message-ID: <20200616120847.GB3542686@kroah.com>
References: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
 <20200612195511.GA6578@ziepe.ca>
 <631c9e79-34e8-cc89-99bc-11fd6bc929e4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631c9e79-34e8-cc89-99bc-11fd6bc929e4@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 12, 2020 at 01:44:55PM -0700, Gerd Rausch wrote:
> Hi Jason,
> 
> On 12/06/2020 12.55, Jason Gunthorpe wrote:
> > On Fri, Jun 12, 2020 at 12:41:16PM -0700, Gerd Rausch wrote:
> >> This issue appears to no longer exist in Linux-4.15
> >> and younger, because the following commit does
> >> call "ib_req_notify_cq" on "send_cq":
> >> 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")
> > 
> > I'm not really clear what you want to happen to this patch - are you
> > proposing a stable patch that is not just a backport? Why can't you
> > backport the fix above instead?
> 
> I considered backporting commit 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")
> with all the dependencies it may have a considerably higher risk
> than just arming the TX CQ.

90% of the time when we apply a patch that does NOT match the upstream
tree, it has a bug in it and needs to have another fix or something
else.

So please, if at all possible, stick to the upstream tree, so
backporting the current patches are the best thing to do.

thanks,

greg k-h
