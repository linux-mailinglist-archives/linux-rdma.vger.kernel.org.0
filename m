Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3762FFE1B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 09:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbhAVIZz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 03:25:55 -0500
Received: from gentwo.org ([3.19.106.255]:53046 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbhAVIZy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Jan 2021 03:25:54 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 454953F555; Fri, 22 Jan 2021 08:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 4379A3E86A;
        Fri, 22 Jan 2021 08:24:57 +0000 (UTC)
Date:   Fri, 22 Jan 2021 08:24:57 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Leon Romanovsky <leon@kernel.org>
cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Fix sendonly join going away after Reregister event
In-Reply-To: <20210121161124.GD320304@unreal>
Message-ID: <alpine.DEB.2.22.394.2101220817050.126441@www.lameter.com>
References: <alpine.DEB.2.22.394.2101211318530.120233@www.lameter.com> <20210121161124.GD320304@unreal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 21 Jan 2021, Leon Romanovsky wrote:

> >  	spin_lock_irqsave(&port->classport_lock, flags);
> > -	if ((port->classport_info.valid) &&
> > -	    (port->classport_info.data.type == RDMA_CLASS_PORT_INFO_IB))
> > +	if (!port->classport_info.valid) {
> > +		/* Need to wait until the SM data is available */
> > +		spin_unlock_irqrestore(&port->classport_lock, flags);
> > +		goto redo;
>
> We have all potential to loop forever here, if valid doesn't change.
>

Right. So what is the right solution here? The sendonly check function could return
an errno instead?

0	= Sendonly join is supported
-EAGAIN = SM information is currently invalid
-ENOSUP = SM does not support sendonly join

Since all SMs out there have had support for sendonly join for years now
we could just remove the check entirely. If there is an old grizzly SM out
there then it would not process that join request and would return an
error.

