Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653E1A44F9
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Aug 2019 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfHaPUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Aug 2019 11:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHaPUB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Aug 2019 11:20:01 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86871217D7;
        Sat, 31 Aug 2019 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567264800;
        bh=uArJR7nOuUFj0EAGoJ0DqLc4fNAjYzoev/U/aovuGHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOv+yThxeVTX8XkrPolWCMUJz8vfeTLIFSmA1HzGWuTU6RKhqz7e+EWalO8RYWzKZ
         9gbNbtU5XZcR4Y5RH5lfIdAQvhGkWVRGpJokw6f8ICAuvFlLA6oqRgr30DZXvgu27C
         FOt3EJcMjfussSK1OQ/vUKZVu7PqLZTUn4YIjHB0=
Date:   Sat, 31 Aug 2019 18:19:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: qedr memory leak report
Message-ID: <20190831151945.GJ12611@unreal>
References: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com>
 <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
 <20190831073048.GH12611@unreal>
 <63286035eb752429fdb651750acf74765caecfe5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63286035eb752429fdb651750acf74765caecfe5.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 31, 2019 at 10:33:13AM -0400, Doug Ledford wrote:
> On Sat, 2019-08-31 at 10:30 +0300, Leon Romanovsky wrote:
> > Doug,
> >
> > I think that it can be counted as good example why allowing memory
> > leaks
> > in drivers (HNS) is not so great idea.
>
> Crashing the machine is worse.

The problem with it that you are "punishing" whole subsystem
because of some piece of crap which anyway users can't buy.
If HNS wants to have memory leaks, they need to do it outside
of upstream kernel.

In general, if users buy shitty hardware, they need to be ready
to have kernel panics too. It works with faulty DRAM where kernel
doesn't hide such failures, so don't see any rationale to invent
something special for ib_device.

Thanks
