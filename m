Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B813E12FE03
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 21:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgACUjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 15:39:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38032 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbgACUjo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 15:39:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id n15so37763283qtp.5
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 12:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uwto7vrkUQtrWJSFJTS/1IavIxmcHeTYe+CAUsTCK8=;
        b=mdaLcrzEKpM/uHGLst7j4AH8BnoPGBsJsMkhSaK2JE/d0CrmnhGLEACNNHDcm9oe11
         nGCxR/SkcDbdgaeSuMtucHatxi1DJRGGu7eBwKc+D/PpxvVG3BTBMtn0EHS6FLgSz+Fq
         wvSFHeplsm3gGW6CImSpO5vvpNIAQ5amusyEtp5hxX4R/6i9lDlZQxlN7u2HPLU+N7WG
         i1MZ5UEiP2coNgiohexxWLN1xCaaFZNMiTqqahcuqZw6EOpP2zM/TdmKvi7D8JL9GUNn
         S4Wg2ql8HAg3r27AMCkw7VmrOsqwTTp5wBsGbJ+g88+ikmmfwBJAhYmzU4oXWDdnZpJ5
         JBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uwto7vrkUQtrWJSFJTS/1IavIxmcHeTYe+CAUsTCK8=;
        b=Az/y2/E6dr93ODYnt5G/4VWL6X9MQsv8ysXweFxpz6IlSnsBcMir1UaQAFwhJfZ05x
         OuL1T92AEBij79muNSYh/zuBfwkgcHAFYgQG+20PCJrQnJ97PuIGoRGOdX4ZsNPlDCXh
         RLkDT1CuAL69A9VX9MMPs059G+RTEXJQlPA7OO+Kthd/w5nlrh+qCkdB57XPNncqlh4H
         8PfTe+Z/JQpe81HRjlUzmSFfaPv3rCQopFUJWeoj8CPy3G8ERfi36fsWL8CGsq05vVGd
         l4ru1PJcI2gGn6Etb5gEnFCBcC9BezrZFUTWpxmI/dx6Yz6Oi6AjiscTCNfZHECG7fSS
         A+Cw==
X-Gm-Message-State: APjAAAUKj6pciX5FdCGiNWqqYHUsocE2b3abPpjqEg6p1TEMWnjNM0ow
        QfbvMYqlnQ1AyLJrDcrKmSz5BcEdAhk=
X-Google-Smtp-Source: APXvYqxmCn3DQIutZS61HOJcMmhKtrKjPZbHXqWUw14kj8WHHE43Pditftaui85GB9XN7iMwNrH1GA==
X-Received: by 2002:ac8:4257:: with SMTP id r23mr64691006qtm.126.1578083983573;
        Fri, 03 Jan 2020 12:39:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u4sm16809273qkh.59.2020.01.03.12.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:39:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inTjS-00016f-LW; Fri, 03 Jan 2020 16:39:42 -0400
Date:   Fri, 3 Jan 2020 16:39:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Eugene Crosser <evgenii.cherkashin@profitbricks.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx4: Redo TX checksum offload in line
 with docs
Message-ID: <20200103203942.GA4218@ziepe.ca>
References: <20191219134847.413582-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219134847.413582-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 03:48:47PM +0200, Leon Romanovsky wrote:
> From: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> 
> Ingress checksum offload was not working for IPv6 frames because the
> conditional expression that checks validation status passed from the
> hardware was not matching the algorithm described in the documentation.
> 
> This patch defines L4_CSUM flag (which falls inside the badfcs_enc
> field in the existing definition of the CQE layout) and replaces the
> conditional expression with the one defined in the "ConnectX(r)
> Family Programmer's Manual" document.
> 
> Signed-off-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> Reviewed-by: Jack Wang <jinpu.wang@profitbricks.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx4/cq.c | 18 +++++++-----------
>  include/linux/mlx4/cq.h         |  5 +++++
>  2 files changed, 12 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason
