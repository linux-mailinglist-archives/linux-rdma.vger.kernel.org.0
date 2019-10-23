Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527ECE1E75
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbfJWOny (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 10:43:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45770 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389423AbfJWOny (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 10:43:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so32596949qtj.12
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFnkE16xugRgV59wYqRYhAl2ShITFXL3ENT9jA2lCU8=;
        b=Mz7R4XGqndbLRsDd1H5MjmxArFdMjKJinettGPvoZRYgLZeuHa37gjbJdeq10JMtcf
         KbCV6ixOEySZjDIBRw6cpk0GxkMBwZmzbSN4wAkIfdd0vnRn/t7yb2Olx0BbfpnZKato
         Vn5ykOOLm++nm0Y7ioLtrk2axnNjE7gk5v3aEFOlUBx6n0/52GG8BsPYmggrAm3eKeio
         kuTE9Luio3Sx+c0TzipeaVexDJk1+0Q1N0o3s+7+tDQs6YO02ogY3TikLKdShvK6NUHs
         Iw9Ao/RpEztzS2uNmv+zd2syzYIl7s42kFPACStmFRvKaKDyelAxLMNQHzNRtsBVKv2H
         R56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFnkE16xugRgV59wYqRYhAl2ShITFXL3ENT9jA2lCU8=;
        b=C21LNEGbgEve3mUtGGkHFWQZLisARwTrj9SnCePTxkHfsybH63yfR7BHUUnypIffvm
         3LbeNuLnR1C4TmMs75/+xQ1YrvssP9v+DCyUAiYFiaZrXtga54Jfn3SjHiH89/vJ1EJk
         JN3erjHP2XnXTa67S9E5X7aG0kSvImEg4+5EYbOcFhos8fXPvtVzggNfrXlFKn192Y5f
         XhmSbOlfkvHBrkRhK6w6nre30uyo8C55ow0zG2hmCfjDm0zYgYuKpFt4/ha6RJWtNUUn
         GkSgT4ogSWOUSZtVHQiQ7GVNGxnQc+LvgTqoxCEqhbjLB8E2GtAClC2tV3eOipwyURQR
         6KhA==
X-Gm-Message-State: APjAAAUUYh8ejblBzquW0Do6VfKN4Vgn6WRyWDkHLlimGd06R7B1Svbd
        YMMF2/VHsP7Zo0KFdx9hXK2pKg==
X-Google-Smtp-Source: APXvYqzsNd3y3JosE8rkydM1ykorz+SAZXgI2rWKPqszgPndzRiTfTWIafJsX8QImN8/+bX/MSiI+A==
X-Received: by 2002:ac8:5547:: with SMTP id o7mr8404513qtr.315.1571841833445;
        Wed, 23 Oct 2019 07:43:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j7sm3570448qtq.25.2019.10.23.07.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 07:43:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNHrc-0003PK-6p; Wed, 23 Oct 2019 11:43:52 -0300
Date:   Wed, 23 Oct 2019 11:43:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Fix
 synchronization methods and memory leaks in qedr
Message-ID: <20191023144352.GN23952@ziepe.ca>
References: <20191016114242.10736-1-michal.kalderon@marvell.com>
 <20191016114242.10736-2-michal.kalderon@marvell.com>
 <20191022193623.GG23952@ziepe.ca>
 <MN2PR18MB3182B5EED33E362D875C70B6A16B0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182B5EED33E362D875C70B6A16B0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 09:49:14AM +0000, Michal Kalderon wrote:
> > 
> > > +		/* Wait for the connection setup to complete */
> > 
> > > +		if
> > (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_CONNECT,
> > 
> > > +				     &qp->iwarp_cm_flags))
> > 
> > > +			wait_for_completion(&qp->iwarp_cm_comp);
> > 
> > > +
> > 
> > > +		if
> > (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_DISCONNECT,
> > 
> > > +				     &qp->iwarp_cm_flags))
> > 
> > > +			wait_for_completion(&qp->iwarp_cm_comp);
> > 
> > >  	}
> > 
> > 
> > 
> > These atomics seem mis-named, and I'm unclear how they can both be
> > 
> > waiting on the same completion?
> 
> In IWARP the connection establishment and disconnect are offloaded to hw and asynchronous. 
> The first waits for CONNECT to complete. (completes asynchronously) 
> If we are in the middle of a connect that was offloaded (or after connect) the bit will be on and completion will be completed
> once the connection is fully established.
> We want to wait before destroying the qp due to hw constraints (can't destroy during connect).

The atomics seem to be used in a 'something in progress' kind of way
as the first thing to get the 'set' does whatever is happening here or
waits for the otherone to finish doing it.

> I didn't see a reason to use another completion structure, since
> from what I read complete does comp->done++ and wait_for_completion
> checks done and eventually does done-- so it can be used several
> times if there is no need to distinguish which event occurred first
> (in this case there is only one option first connect then disconnect
> and disconnect can't occur without connect)

I suppose it is OK here because both completion waits are sequential,
but generally it is kind of sketchy as when
QEDR_IWARP_CM_WAIT_FOR_CONNECT completes it will wake up something
waiting for QEDR_IWARP_CM_WAIT_FOR_DISCONNECT as well.

Jason
