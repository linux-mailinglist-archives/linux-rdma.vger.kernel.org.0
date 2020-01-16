Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D429713DF65
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgAPP7H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 10:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgAPP7H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 10:59:07 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66CF22073A;
        Thu, 16 Jan 2020 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579190347;
        bh=d9ICWds/chX2RD0zzx4vQorW6WMnCajqYfbFXv8wGek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMMF49M+EtzoM/oXgWgdHTDVsKRtGQSBcL+EUo0OaE17DKhwTXMbrofkNqoipipcd
         CSsdFelbsero1GlohlvauWJ5r5MocU4qXri5pykG0mfexPSVYPkhwOVX4UKytgKq2P
         3x0W0HLFline/TgEA0OJopVTRIh+WgBk8ALgIgus=
Date:   Thu, 16 Jan 2020 17:59:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v7 23/25] block/rnbd: include client and server modules
 into kernel compilation
Message-ID: <20200116155903.GB18467@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-24-jinpuwang@gmail.com>
 <20200116144005.GB12433@unreal>
 <CAMGffEmaif+Gc-OT2Dmn+u06A3tryHA0bu52ekroHaixBFZKGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmaif+Gc-OT2Dmn+u06A3tryHA0bu52ekroHaixBFZKGg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 03:54:03PM +0100, Jinpu Wang wrote:
> > > +obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
> > > +obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
> > > +
> > > +-include $(src)/compat/compat.mk
> >
> > What is it?
> >
> > Thanks
> quote from Roman
> "'
> Well, in our production we use same source code and in order not to spoil
> sources with 'ifdef' macros for different kernel versions we use compat
> layer, which obviously will never go upstream.  This line is the only
> clean way to keep sources always up-to-date with latest kernel and still
> be compatible with what we have on our servers in production.
>
> '-' prefix at the beginning of the line tells make to ignore it if
> file does not exist, so should not rise any error for compilation
> against latest kernel.
>
> Here is an example of the compat layer for RNBD block device:
> https://github.com/ionos-enterprise/ibnbd/tree/master/rnbd/compat
> "'
>
> We will remove it also the one in the makefile for rtrs if we need to
> send another round.

Yes, remove it please.

>
> Thanks
