Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8321BBDA8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD1Mbz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbgD1Mby (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 08:31:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D0FC03C1AB
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2020 05:31:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g74so21451483qke.13
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2020 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvnqZOpIhV+8wCjf27Mt4KlSqBJrjtqU1xwqeoc76wk=;
        b=PFYa8ZlAjDo6ijp1AnsAAmBB/kjyK5ZLBn0c4/9gBKpPQC0hFRw1wZ1Ylpd5UWh1QI
         ZIzVm/UuEviap8chz106dn9VG7s68oQccbXPjNtG/aetSW6ax0eptL/Z6GvK2pUG2woX
         J4C5wkOJeN79D+EbDggJRnILWfB2I8qz9Ss0S79piiX2Mx8/o8gLf3ePAShI6jQln5uR
         lmy0/Rqwim1EqKFlk5enIYFhTjoppOJYh3Sb3ETBV02Zqg4YAETmeceslsGXOl5mKXkM
         vl9u7vCieTA23E8N5oTVhiFGuzMIU4Izf4cB07rm62w1XmHjHH6mW4CF7K4GdMOxxzDE
         lbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvnqZOpIhV+8wCjf27Mt4KlSqBJrjtqU1xwqeoc76wk=;
        b=JSww8NHka0ZlOHe0MKdW1OVfu0qjmWVTwr0NcXu78u8b+GsVA7rY8W4AUXWJkLJuLB
         Ljxk1ebBWeJPFPuRewuOLESUpNxqspy7ciPVgYcWbmSG87CRNv3C4+WSCMRX1qLe0GNt
         Hk2HcYhg0jfSttWhmq3fNCruMdELWa0SR7gIZORgty2p8DIxMS4PZSLO7uJvWrULJp1n
         Z2ufmDMG0M596nxnckUqp+7ODvhn+SJoRXG+m4eg/k7a7ca6RPFK2cm8LArvT5GH+Md5
         hHFPSbp5GfYr53moSDTd6DzVFvZM/teHXXEcWBsvI51hxbcDqVSVIxOqvCCpFm3d74F3
         hiKg==
X-Gm-Message-State: AGi0PuawiSnO/bpNI7CSyqWJ/MwEMM/CbNLNcZ+z1wkKR1Qmn6hp/YoG
        /Bb98ejFfDX98RGMSv1LShJpbw==
X-Google-Smtp-Source: APiQypJE0XMFJTGSTZ3ftCbb5kdENgEmLpfrbQDaSL2brXKiNwf0w0Qje1uA9iQnF71GI3khQNpsvQ==
X-Received: by 2002:a05:620a:5bc:: with SMTP id q28mr25756082qkq.468.1588077112373;
        Tue, 28 Apr 2020 05:31:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o68sm13041661qka.110.2020.04.28.05.31.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 05:31:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTPOx-0007LA-2D; Tue, 28 Apr 2020 09:31:51 -0300
Date:   Tue, 28 Apr 2020 09:31:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-block@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v12 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
Message-ID: <20200428123151.GS26002@ziepe.ca>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <CAMGffE=R2zaL6Ao3gZ_XvKPvG0YX5bmo18o3cJ_SLBEjZ0Mv_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=R2zaL6Ao3gZ_XvKPvG0YX5bmo18o3cJ_SLBEjZ0Mv_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 25, 2020 at 10:31:55AM +0200, Jinpu Wang wrote:

> >  create mode 100644 Documentation/ABI/testing/sysfs-block-rnbd
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-client
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-server
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-client
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-server
> >  create mode 100644 drivers/block/rnbd/Kconfig
> >  create mode 100644 drivers/block/rnbd/Makefile
> >  create mode 100644 drivers/block/rnbd/README
> >  create mode 100644 drivers/block/rnbd/rnbd-clt-sysfs.c
> >  create mode 100644 drivers/block/rnbd/rnbd-clt.c
> >  create mode 100644 drivers/block/rnbd/rnbd-clt.h
> >  create mode 100644 drivers/block/rnbd/rnbd-common.c
> >  create mode 100644 drivers/block/rnbd/rnbd-log.h
> >  create mode 100644 drivers/block/rnbd/rnbd-proto.h
> >  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
> >  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h
> >  create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c
> >  create mode 100644 drivers/block/rnbd/rnbd-srv.c
> >  create mode 100644 drivers/block/rnbd/rnbd-srv.h
> >  create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
> >  create mode 100644 drivers/infiniband/ulp/rtrs/Makefile
> >  create mode 100644 drivers/infiniband/ulp/rtrs/README
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h
> >
> >
> Hi Jason, hi Leon, hi Doug, hi all,
> 
> We now have Reviewed-by for RNBD part from Bart (Thanks again), Do you
> have new comments regarding RTRS, should we send another round to do a
> rebase to latest rc?

We'd need an ack from Jens before the block stuff could go through the
RDMA tree

Jason
