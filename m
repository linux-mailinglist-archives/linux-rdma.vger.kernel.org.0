Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1812669A6C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfGOSEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 14:04:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41286 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfGOSEO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jul 2019 14:04:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so16563880qtj.8
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2019 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WiKMgGiVemUwJKQ/H9mtRMX4AQUKVV2S7NavvFyDuX4=;
        b=TuGqf5L+nwpT6pW1dgceNu2S8cu59tDoh/pV/jN7mXM3VRvRQM6xT2WsrjQJSSD1QF
         8DO6fSWcOv58g6rF14JjNJEs1al8bL9KFWQMiklHm5OqsssJK1GT1fp6Y8FYdmYiTR86
         Vtrgw9tALesf4Vw3UrZE5dx0glxzgZLWPD/4A+Vv4de7QzEp18DgJxJTKRlzpdYmo88g
         iKryboBKohBqP1Df5vVF0OO7mcv85EyJY5dIibwLmh1b5kIeepLZi9tZ72YkkJEhpwgv
         c15dkaveGF3SeluoQhhjnBpeNNAuyZIjMNuKt67cSi+1moKr7UtpY02fHE6Ib1SLrqaO
         8Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WiKMgGiVemUwJKQ/H9mtRMX4AQUKVV2S7NavvFyDuX4=;
        b=alzRTzamGKIeWoeq/qVQuaCCeZ9RvHfraXzmAJc7gSwDJqL19VFDfZSpkMOC0GrvgA
         rQ6O6J4ghEFkbi0n0uDrprtECPoIeWSYxqJvL4aU/dK438FyPDITeri/Lgh9IH8sfHPP
         Rv0Iq3EDbx2dXc1fNxB7jQePzNPADv4tuzckvmfCER6FgKp6ezxHN4QUxS7fFuUcC9FD
         r97yZkSIar3gjAHMu9166D1B/JRMOFYs2myYST6V5b30P5KErls0EjkSffOB4Q/KpHd2
         d56Q3i3DM1eRkzhTSctqWZs62C2yZ8di6GQ2LLquIKmZw0XXG/JE+r5/CKBH+hubVsA7
         HPFw==
X-Gm-Message-State: APjAAAUOH2ZJfJQgJPqB3uwabwgvaAbwXzTRKHvfqQmxKMQvTLuLf6Ol
        TKTAVJFp7iMT1SAAx3J+KqxUjwBV9rw5gQ==
X-Google-Smtp-Source: APXvYqzo7Gx5lb12cx5ed/G2VffLDwH3DnLzdlC5EzCkel3Ua0nDnkTIHUkEhVQCw/9OamxzpUtUPA==
X-Received: by 2002:a0c:d11c:: with SMTP id a28mr20030227qvh.180.1563213853787;
        Mon, 15 Jul 2019 11:04:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d23sm7876101qkk.46.2019.07.15.11.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 11:04:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hn5Ke-0001yO-RG; Mon, 15 Jul 2019 15:04:12 -0300
Date:   Mon, 15 Jul 2019 15:04:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 0/6] More 5.3 patches
Message-ID: <20190715180412.GB4970@ziepe.ca>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
 <20190715175409.GA4970@ziepe.ca>
 <32E1700B9017364D9B60AED9960492BC70E15005@fmsmsx120.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32E1700B9017364D9B60AED9960492BC70E15005@fmsmsx120.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 15, 2019 at 05:55:02PM +0000, Marciniszyn, Mike wrote:
> > Subject: Re: [PATCH 0/6] More 5.3 patches
> > 
> > On Mon, Jul 15, 2019 at 12:45:14PM -0400, Mike Marciniszyn wrote:
> > > The following series contains fixes and a cleanup.
> > >
> > > I noticed that 5.3 rc1 hasn't happened yet? So I'm not quite sure of
> > > the destination here.
> > 
> > You shouldn't send patches during the merge window. If they don't
> > apply cleanly to rc1 they will need resend.
> > 
> 
> They apply cleanly to for-next and rdma/for-next.

Those branches are done - we are jumping to 5.3-rc1 next Monday.

Jason
