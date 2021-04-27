Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF5A36CB67
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhD0TAp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0TAp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Apr 2021 15:00:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E0C061574
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 12:00:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14so24589325pjl.5
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zWaKMnlFbx57gTC6jFzezIdM/5NolgPN/0JfNkKPXdk=;
        b=H3ftB4kityuOmpZWEa4buSYAWQYXfqynS/c/El/Zw4aN8z/Tt/AUVZ1UqiRyInWJub
         VAlACJV7o4cCZhAmNX0QT1Gt8dgBE8G7NhvIrC1CKuFYDgicgLw++N/gYIP5tjDeW7jl
         PGUOeSYGvEgRGl22zuOKnNpnv89RGDh79qnllGdLHTGEvmUhToSBvt4R7ZqvM9d4xin0
         oc9yHrLCyS5FgfXf3LOOJRpC6DYHOvpfv18L1V5wVFtx8AmdBUHWw8ZmaiF6zeXUw5M+
         mdO0wMyXhnUwQhwbIo3ZiOM/2Al8t+yvDY7eV5cFBcRM85jKKjjLBVgsRKdJLqFqVRIs
         7csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWaKMnlFbx57gTC6jFzezIdM/5NolgPN/0JfNkKPXdk=;
        b=hPOaRfCwHR6I2dlay4aArHkvygj6CedpknRGKPTV+VDr3XjnqGEdP6tIiPfLNqZyHV
         1Pazq2Y7nPBZ3x7gibGcBobTucWUwbOgZy21r8BX9S1n4gimorbrIpX8Ya/oHg9uMtyO
         egUGdjfsWuSY+zbaODO3s1twqXjGynZ5p0IDFp59TZDMztrb4velJerNial2pUac4Vbt
         CDZVyUWRYZ0eef11L+5cL6G+tSREvYqqrhkzHE7VbD2xPpzNRpmVVDPMwD6+50fxMYm2
         cdH2Pd7HBMOy+PPKIUW18X48JZgFEujDTWVhiBvEOtEUh529VnyP+BHTOpNSgxZbsl42
         lz4Q==
X-Gm-Message-State: AOAM533p0j9Mk/BqYLUxEAuCjTOhw7/GNGxwLAgFft27kUf2O5jvx5Ih
        VpDY8QLQACG5ggvntsRKcu8zQQ==
X-Google-Smtp-Source: ABdhPJyj+8riPVI7TYHyZKLfDUiStGVB4SqkIo2eghk5R5Z8sjDEv/6XfDwAZ052l/IhmlE7Y5iJdw==
X-Received: by 2002:a17:902:6b81:b029:ea:dcc5:b841 with SMTP id p1-20020a1709026b81b02900eadcc5b841mr25633427plk.29.1619550001422;
        Tue, 27 Apr 2021 12:00:01 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q3sm411590pgb.80.2021.04.27.12.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:00:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbSwB-00DgNr-18; Tue, 27 Apr 2021 15:59:59 -0300
Date:   Tue, 27 Apr 2021 15:59:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCHv3 for-next 0/4] New multipath policy for RTRS client
Message-ID: <20210427185959.GN2047089@ziepe.ca>
References: <20210407113444.150961-1-gi-oh.kim@ionos.com>
 <20210413224723.GA1370930@nvidia.com>
 <CAJX1YtYCAy09uvNtdq=UM+rWLo0SWaGC17XxZxUf_9ZcmhBWbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX1YtYCAy09uvNtdq=UM+rWLo0SWaGC17XxZxUf_9ZcmhBWbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 14, 2021 at 06:59:59AM +0200, Gioh Kim wrote:
> On Wed, Apr 14, 2021 at 12:47 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Apr 07, 2021 at 01:34:40PM +0200, Gioh Kim wrote:
> > > This patch set introduces new multipath policy 'min-latency'.
> > > The latency is a time calculated by the heart-beat messages. Whenever
> > > the client sends heart-beat message, it checks the time gap between
> > > sending the heart-beat message and receiving the ACK. So this value
> > > can be changed regularly.
> > > If client has multi-path, it can send IO via a path having the least
> > > latency.
> > >
> > > V3->V2: use sysfs_emit instead of scnprintf
> > > V2->V1: use sysfs_emit instead of sprintf
> > >
> > > Gioh Kim (3):
> > >   RDMA/rtrs-clt: Add a minimum latency multipath policy
> > >   RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
> > >   Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
> >
> > Applied to for-next, thanks
> >
> > Please be mindful about the subjects, rdma subject start with a
> > capital letter after the tag
> >
> > > Md Haris Iqbal (1):
> > >   RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
> > >     stats
> >
> > This one was replaced by that other patch
> 
> Hi Jason,
> 
> "RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its stats"
> This patch is still necessary. Please apply that patch.
> 
> As I wrote in the description of patch
> "RDMA/rtrs-clt: destroy sysfs after removing session from active list",
> each function still should check the session status because closing
> or error recovery paths can change the status.
> 
> For example, the client sends the heart-beat and does not get the
> response, it changes the session status and stops IO processing.
> It is ok if the status is changed after checking status because
> the error recovery path does not free memory and only tries to
> reconnection.
> 
> And closing the session changes the session status and flush all IO,
> and then free memory.

You need to resend it with out the oops message, a patch like this
cannot be correctly fixing an oops like it presents. Confirm you do
not have the oops now that the other patch is merged.

Please explain carefully what it is trying to do

Jason
