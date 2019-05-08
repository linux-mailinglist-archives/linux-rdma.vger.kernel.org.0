Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902DE1717A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEHG0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 02:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfEHG0F (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 02:26:05 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAC421019;
        Wed,  8 May 2019 06:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557296764;
        bh=3Iw1dc3gpAjj9IHzgQhFtL51X4m4rSqp3lDThC0Wh38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHNnxrWejFxLTyCiglJ9vL2RNv09IyL2b2zLUawj5SwSWUf1p75aHHEDaHxNSbDlN
         3ihzDVNVx6S875DhQjT6hMBcBbPQosH4ndn6uZ+FfaAJcsKQxA5N9ceA8PkNDRa/J6
         OVADplNN1qb+VKu6AWlI2j982e29pmKigt17esgs=
Date:   Wed, 8 May 2019 09:26:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190508062600.GV6938@mtr-leonro.mtl.com>
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <20190507161304.GH6201@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507161304.GH6201@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 01:13:04PM -0300, Jason Gunthorpe wrote:
> On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> > So, Jason and I were discussing the soft-iWARP driver submission, and he
> > thought it would be good to know if it even works with the various iWARP
> > hardware devices.  I happen to have most of them on hand in one form or
> > another, so I set down to test it.  In the process, I ran across some
> > issues just with the hardware versions themselves, let alone with soft-
> > iWARP.  So, here's the results of my matrix of tests.  These aren't
> > performance tests, just basic "does it work" smoke tests...
>
> Well, lets imagine to merge this at 5.2-rc1?

Can we do something with kref in QPs and MRs before merging it?

I'm super worried that memory model and locking used in this driver
won't allow me to continue with allocation patches?

>
> Bernard you'll need to rebase and resend when it comes out in two weeks.
>
> Thanks,
> Jason
