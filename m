Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96B3E20EE
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 03:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhHFBWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhHFBWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 21:22:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE58AC0613D5
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 18:22:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d9so5316803qty.12
        for <linux-rdma@vger.kernel.org>; Thu, 05 Aug 2021 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ubKD2UGooDS++RfOAVuC1YB8Gp/dEfm9NpdK2s4ghkc=;
        b=Aq+smQ6ffGnG4KKgmAsgNTJoFlSTdzAkw0K3S1bMmcyNgyF+6JfWSLHFb8kFUqNIEy
         r1/zka+ub+OeSik2BaJv/9diQnsMIijlmGOTwSNliICVvxGtD7mpQ7XZTwk0lbggbZxA
         ox0JpgUw6dSlbFLKh+iT2qrRO+Lf6R6JlBa8Nowuhs+1pKTCmpVh9ccIY1K3ynUOGw2y
         LoFQsU+0evW59x1n38MbucXO7Ah6F5Z70PmsTX3bkWXgyn7ditSNrMwChsc1xPNjOGRJ
         336eCh0sNKyemhMx387hWoMao/f+PhY+rcB0CZVmSY80JX2pe68895afPnHAFRaMhoO6
         H7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ubKD2UGooDS++RfOAVuC1YB8Gp/dEfm9NpdK2s4ghkc=;
        b=Zu/NmeFksqx0N/zK5zvvzSlL5VQqxUGxcHObRtGUGrp6FAxtuFKXg9DnBKv0T/2xSp
         UoHDvuZHx/6Jqz3AtucI2fFVANllkB9yauABeSkKMAe0XhHraAh6+ZInS2bwTHSAEMtC
         GaITSFmaRlQce4ipbQgTgwsby/gqrCvycqlpaNhejUnvqga0WN1jDHtwZKF65DKBzAqG
         8BY+4g7N7yzEtzaJEpzJ+SS219d4mGrnK/IcbDF4y8BQbIe1FJ6MxE6yOwdb5VCDRF2m
         kuYqIeAAJUCGA8Qte7p6DlWh9NKk9BgtlPXNjOYgomoCiljAtjXRDpZg6J4tool18dxx
         Kw8A==
X-Gm-Message-State: AOAM533N2LOqN5hezY3rEwXyiUl/VaW7YzNGing0GUyDkjV93c1IVGVi
        TAaoubjMwkNq8IwW7kLxdGDFCA==
X-Google-Smtp-Source: ABdhPJzk9u/H4ANYXtSrUmWzqYmtSsP4IvSToVMjLuIQGNqAhwm0j2YrX5S+aRISgVQtWHcXFz1XfQ==
X-Received: by 2002:aed:2103:: with SMTP id 3mr7032270qtc.109.1628212953912;
        Thu, 05 Aug 2021 18:22:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u19sm2834948qtx.48.2021.08.05.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 18:22:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mBoZE-00DtJ5-Mi; Thu, 05 Aug 2021 22:22:32 -0300
Date:   Thu, 5 Aug 2021 22:22:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 09/10] RDMA/rtrs: Add support to disable an IB
 port on the storage side
Message-ID: <20210806012232.GK543798@ziepe.ca>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-10-jinpu.wang@ionos.com>
 <YQee8091rXaXU4vL@unreal>
 <CAJpMwyj6SjO+yNsA9uMDZP1Cu2gUfXHAeRGgaGf46xbxDBrk5g@mail.gmail.com>
 <YQge6yQTILQsQECO@unreal>
 <CAJpMwygeu=LYdTWMHxWYHMe_==yHxB_KEsTstH3CWOaMWu0sgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwygeu=LYdTWMHxWYHMe_==yHxB_KEsTstH3CWOaMWu0sgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 02, 2021 at 07:43:05PM +0200, Haris Iqbal wrote:
> On Mon, Aug 2, 2021 at 6:36 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Aug 02, 2021 at 04:31:01PM +0200, Haris Iqbal wrote:
> > > On Mon, Aug 2, 2021 at 9:30 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 30, 2021 at 03:18:31PM +0200, Jack Wang wrote:
> > > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > >
> > > > > This commit adds support to reject connection on a specific IB port which
> > > > > can be specified in the added sysfs entry for the rtrs-server module.
> > > > >
> > > > > Example,
> > > > >
> > > > > $ echo "mlx4_0 1" > /sys/class/rtrs-server/ctl/disable_port
> > > > >
> > > > > When a connection request is received on the above IB port, rtrs_srv
> > > > > rejects the connection and notifies the client to disable reconnection
> > > > > attempts. A manual reconnect has to be triggerred in such a case.
> > > > >
> > > > > A manual reconnect can be triggered by doing the following,
> > > > >
> > > > > echo 1 > /sys/class/rtrs-client/blya/paths/<select-path>/reconnect
> >
> > <...>
> >
> > > >
> > > > And maybe Jason thinks differently, but I don't feel comfortable with
> > > > such new sysfs file at all.
> >
> > This part is much more important and should be cleared before resending.
> 
> Agreed. I will wait for Jason to respond.

Based on some past conversation with Greg I'm skeptical he would
approve of this kind of usage of sysfs..

It is also very strange that this is under a class directory, I'm
starting to think it was a mistake to merge the original sysfs stuff
:(

Can you do this some other way?

Jason
