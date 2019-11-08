Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B8F4DF9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 15:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfKHOWA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 09:22:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35447 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKHOWA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 09:22:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id i19so5409574qki.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WjO2btyA4fH/g01Vok9AFfjtQqDDRIYayaN738hzydg=;
        b=L1Ag7UQyrDVfHd2FeVUoTHv/zhF7Z4cMIA0bf+T4Oen6FJb7r7d3qnhjca2k3KY1qp
         sHHI90Wqfrejml4lXzY/AZkPkINN/GFu+OLu98CSiAtijt4StXdHXhosPt3HPJYvx4RB
         p25rhzxh5qaUvg0uXFwqd4iSLJGwCUvIirhfOvZhi7iAD2kvNP4mPsTTnJ5glzRgm7FH
         fpLfmRNBzYToRs0ST1NjJ2Uq8L8iGmrAsVN5u0XFtVSyruanLHa9m7CkJXye7vEqyGZY
         IDHmZsK1QD6b8Dk1yfzQGYMOUXx7erX62SSJSNowr8OxiLaldcaaBWjL7WGNAU+T3PPM
         V2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjO2btyA4fH/g01Vok9AFfjtQqDDRIYayaN738hzydg=;
        b=WVQdrxZTcTPh6Tti5Y4C++FIEoA58FGrgM31NyLgxz4IzYvDw98vRWqcdaKFXqorwp
         TgYb3Wfv+27iD6qHILlUTJq7f6B4bmFDHAdPI5LsTw9p/9mTD28FQXtOGCorZLAW8yQz
         mi9el5U3rIFPXHL9n45dfMlzYdaTphZyIcplhFNbXB9BbQ2/BeNRsUBeLsqDVZr+Xbd9
         W0kWVkr5+YrEGod3+BjYmmMR8/O3z+Qvsb1Xs+Le3Mjw6SfWucyh0Ms+xxfTPx8oQp8F
         K1xkiRNVMYcoMobDf4zRnTzuW/B6V0Hx7jV+daUUW3fXhsHiGekAAdbthXMjC05OBvSc
         IgVg==
X-Gm-Message-State: APjAAAWJzaLZgk1FgXIeerg42UoxWavZUUZydYlDqa7eWtIhTQl86a6F
        53AGp2azBvfx4lYR82InvUEHE8pAGY8=
X-Google-Smtp-Source: APXvYqwGougD0MyvL6qGKLiPVNSUJfg8RsdKSUQAddb1iaS6XJ69j5cqR8gjTAV+x5KbIOjxIoG3UQ==
X-Received: by 2002:a37:a00f:: with SMTP id j15mr9322047qke.103.1573222919242;
        Fri, 08 Nov 2019 06:21:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w69sm2871249qkb.26.2019.11.08.06.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 06:21:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iT59B-0003CS-W8; Fri, 08 Nov 2019 10:21:58 -0400
Date:   Fri, 8 Nov 2019 10:21:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5] IB/core: Trace points for diagnosing completion queue
 issues
Message-ID: <20191108142157.GB10956@ziepe.ca>
References: <20191107205239.23193.69879.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107205239.23193.69879.stgit@manet.1015granger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 03:54:34PM -0500, Chuck Lever wrote:
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
>  drivers/infiniband/core/Makefile |    2 
>  drivers/infiniband/core/cq.c     |   36 +++++
>  drivers/infiniband/core/trace.c  |   14 ++
>  include/rdma/ib_verbs.h          |   11 +-
>  include/trace/events/rdma_core.h |  251 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 307 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/infiniband/core/trace.c
>  create mode 100644 include/trace/events/rdma_core.h
> 
> Changes since v4:
> - Removed __ib_poll_cq, uninlined ib_poll_cq

Oh I don't think uninlining is such a good idea, isn't this rather
performance sensitive?

Jason
