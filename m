Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5752CE06
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfE1Rwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 13:52:46 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39817 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Rwp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 13:52:45 -0400
Received: by mail-vs1-f68.google.com with SMTP id m1so801421vsr.6
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2019 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSo9d9sXIn0KnznBmtYlnJ/PCUFfv7Lb3+7hoBRawy4=;
        b=bIWle7WiD2SqhCsU1xAZ+IhlVOw7qaEyZ60SBnbGs+pcvy3rUfhmJFFhDo+RLuGmf+
         84RfQYqdOL2fZqq14eimXLwQCprg3W1YBhhXyodrNedMhQiEJTrVmYkeT59JYB8mzdS8
         rvSFEQVRSYJO2zBe45N/YhFtUubuXun1HpmpUypq7VEqK/jToUiKJy4zTEBpmg7HCYmC
         7RFhuPAZQvx/Sg9a/I0N2QjMuxqwfWf5Hc6RGDSsykyKK+K76DkJjEGccVHQPBDR3NVa
         dpiZzNxQzInRkEG46+kY4FEexnMX+mfjopS/JGPalBwE0hErefur9+BLb9p8Xa3XS3No
         hFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSo9d9sXIn0KnznBmtYlnJ/PCUFfv7Lb3+7hoBRawy4=;
        b=rjmq4Cf0R/uWUEdXqCLaRoQizU7xU/nlPxd4PPGCdBprSynXg3ouQZafK1kF3CdzCt
         8yiWuS/kQv2iuQoRfhlFf8cDo8eags3/GtPCFdzg8nnGuaC12NNjPlavQT7RiN4oVGQp
         XhNeiiQAUGC5QSzNtucibY2H35q5OevlfSKeENqZb229by40NZDA8Syy2RC2RswbSZgP
         ePHQc+rjjdfVveXKSGfG8meKFvGfVFzAmYD5jpYSEfaDkbKqz8kHueUsD3ULCXaLPqbh
         BDGd1CSoMwhEQ2DwMc1hfStS7XcDw2bK1paIkiaKsvMSM67S8DY6L5jfsmq8q02wqfGy
         VERA==
X-Gm-Message-State: APjAAAVYxelIIgD7Opl5EE1tTabp8Z5I9pInfH1a9ekbW6XkMWB6uIWD
        c9zS8JmLRX4dzuNqIzdb7KVYwQ==
X-Google-Smtp-Source: APXvYqxMqHAUC6CsBh5CCCz8EGvPgqyLcS+1/GQNr9qrlhvBUj71I+zuFH3uEoj6yRxne37k21oIdA==
X-Received: by 2002:a67:ca1c:: with SMTP id z28mr24882802vsk.6.1559065964691;
        Tue, 28 May 2019 10:52:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 126sm5839092vkt.14.2019.05.28.10.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:52:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVgHD-0001Kf-FR; Tue, 28 May 2019 14:52:43 -0300
Date:   Tue, 28 May 2019 14:52:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>, Sagiv Ozeri <sozeri@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma] RDMA/qedr: Fix incorrect device rate.
Message-ID: <20190528175243.GC31301@ziepe.ca>
References: <20190520093320.3831-1-michal.kalderon@marvell.com>
 <20190521180513.GA24517@ziepe.ca>
 <MN2PR18MB3182D17675466AF1B2B22353A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182D17675466AF1B2B22353A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 08:43:20AM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > 
> > On Mon, May 20, 2019 at 12:33:20PM +0300, Michal Kalderon wrote:
> > > From: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> > >
> > > Use the correct enum value introduced in commit 12113a35ada6
> > > ("IB/core: Add HDR speed enum") Prior to this change a 50Gbps port
> > > would show 40Gbps.
> > >
> > > This patch also cleaned up the redundant redefiniton of ib speeds for
> > > qedr.
> > >
> > > Fixes: 12113a35ada6 ("IB/core: Add HDR speed enum")
> > > Signed-off-by: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> > > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> > > v1 --> v2
> > > Removed empty line after "Fixes"
> > >
> > >  drivers/infiniband/hw/qedr/verbs.c | 25 +++++++++----------------
> > >  1 file changed, 9 insertions(+), 16 deletions(-)
> > 
> > Applied to for-next, thanks
> > 
> > Jason
> Thanks Jason, this patch was actually intended for rc as it is a bug fix. 
> Could you please apply it to for-rc branch ? 

It is sort of too late now, and the commit message is no really -rc quality

Jason
