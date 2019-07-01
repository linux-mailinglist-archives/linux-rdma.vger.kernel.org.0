Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD045B92F
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfGAKmY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 06:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfGAKmY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jul 2019 06:42:24 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D51208E4;
        Mon,  1 Jul 2019 10:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561977743;
        bh=xn+zXj+uALI5lBSl07If9Ow9AwaSyI3JQt0wSwFkNng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGfv472G7uVzL83ZjFBt4TmedtwLo2tN5Slt5LTJkbIpYHV8HiuK7qdEfY4/5yLGA
         Y9GhqQGN28dZc7/5qerXSv/nmki0im+1MNdyD4pqedCyRWDRkzOM0dXbWleqQzuNye
         Fw+sFgwKFKzNLBhR8Y3wV0NbEdEEDH+4KjuZL7ok=
Date:   Mon, 1 Jul 2019 13:42:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Pine, Kevin" <kevin.pine@intel.com>
Cc:     "Estela, Henry R" <henry.r.estela@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [ANNOUNCE] qperf maintainer change
Message-ID: <20190701104219.GK4727@mtr-leonro.mtl.com>
References: <152F98E1C68AAF499EABB07558C80F3B421A3FEA@ORSMSX106.amr.corp.intel.com>
 <20190630170026.GI4727@mtr-leonro.mtl.com>
 <E40FE939485AD2408750F67A0FFD42C93BCE773A@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E40FE939485AD2408750F67A0FFD42C93BCE773A@CRSMSX102.amr.corp.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 01, 2019 at 10:20:38AM +0000, Pine, Kevin wrote:
> I apologize.  I had given it to Henry in a separate email but didn't reply to your other email.
>
> My github username should be "kevpine" and my email is kevin.pine@intel.com.

I sent an invitation.

Thanks

>
> Thanks,
>
> Kevin
>
> -----Original Message-----
> From: Leon Romanovsky [mailto:leon@kernel.org]
> Sent: Sunday, June 30, 2019 1:00 PM
> To: Estela, Henry R <henry.r.estela@intel.com>
> Cc: linux-rdma@vger.kernel.org; Pine, Kevin <kevin.pine@intel.com>; Weiny, Ira <ira.weiny@intel.com>
> Subject: Re: [ANNOUNCE] qperf maintainer change
>
> On Fri, Jun 21, 2019 at 06:00:29PM +0000, Estela, Henry R wrote:
> > Hello,
> > I am passing on the role of qperf maintainer to Kevin Pine, since I am no longer working on RDMA related software.
> >
> > Leon, could you add him to the github repo?
>
> I see that no response was for my private email, so I'll request it again.
>
> Please provide github username, so I'll be able to transfer access rights.
>
> Thanks
>
> >
> > Thanks,
> > Henry
> >
