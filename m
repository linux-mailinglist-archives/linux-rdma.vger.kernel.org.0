Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6099FDB
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfHVTYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 15:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731683AbfHVTYt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 15:24:49 -0400
Received: from localhost (unknown [12.235.16.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF0B2082F;
        Thu, 22 Aug 2019 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566501888;
        bh=ymYb1x1wuxKb+8mRlTcg+Gguh7rCe9kpDelkF09V3xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oP3+W/1N5noHHQL08yJS6w4wTVmkZMoyuS4AzDWMTv0gAGOWVfjyNwDejb6MVvXO2
         C35N5iH48KWvCQvRHdy9Ijb1yvQAc2pty0FH35bHA6/ekGnxyeySfErh9Hk9216/F5
         zRmPLWsFx8XROTprKO7WL/w4QHEdCq9OEkrTvMp8=
Date:   Thu, 22 Aug 2019 22:24:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Marcin Mielniczuk <marcin@golem.network>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Setting up siw devices
Message-ID: <20190822192446.GQ29433@mtr-leonro.mtl.com>
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
 <20190822154323.GA19899@chelsio.com>
 <20190822155228.GH29433@mtr-leonro.mtl.com>
 <bf42725d-d441-0237-9df5-bd39cb981dcc@golem.network>
 <20190822172155.GL29433@mtr-leonro.mtl.com>
 <b46f158f-61c9-b949-9174-ec110dc92f9a@golem.network>
 <20190822183807.GN29433@mtr-leonro.mtl.com>
 <20190822191354.GC8339@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822191354.GC8339@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 04:13:54PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 22, 2019 at 09:38:07PM +0300, Leon Romanovsky wrote:
> > On Thu, Aug 22, 2019 at 07:58:56PM +0200, Marcin Mielniczuk wrote:
> > > On 22.08.2019 19:21, Leon Romanovsky wrote:
> > > > On Thu, Aug 22, 2019 at 07:05:12PM +0200, Marcin Mielniczuk wrote:
> > > >> Thanks a lot, this did the trick. I think this is worth documenting
> > > >> somewhere that this step is needed.
> > > >> I'll make a PR, would README.md in the rdma-core repo be a good place?
> > > > I'm not so sure, but it is better to have in some place instead of not having at all.
> > > I think it's the first place one would look for some information. I'll
> > > make a PR today or tomorrow.
> > > >> Does <NAME> have any significance? I did:
> > > >>
> > > >>      sudo rdma link add siw0 type siw netdev enpXsYYfZ
> > > >>
> > > >> but the resulting device is called iwpXsYYfZ. I couldn't find a trace of
> > > >> `siw0` anywhere.
> > > > I would say that it is a bug in kernel part of SIW, because kernel rename
> > > > (the thing which change your siw0 to be iw* name) is looking for absence
> > > > of mentioning PCI inside of /sys/class/infiniband/siw0/*
> > > > https://github.com/linux-rdma/rdma-core/blob/master/kernel-boot/rdma_rename.c#L378
> > > I don't have /sys/class/infiniband/siw0 on my system, only
> > > /sys/class/infiniband/iwpXsYYfZ.
> > > iwp probably comes from iWARP.
> >
> > Your iwpXsYYfZ was siw0 before rdma_rename was executed.
> >
> > I can't test the patch now, but hope that this change below will fix your problem.
>
> I think we should directly blacklist rxe and siw from
> renaming. They can only be created with a user-given name so they
> should never ever be renamed.
>
> netlink now returns the driver_id and we can use that to trigger it.

Blacklisting does not play well with new kernel with new devices against old library.

Thanks

>
> Jason
