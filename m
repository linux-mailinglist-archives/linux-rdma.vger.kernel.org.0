Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458D4C3782
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfJAOe2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:34:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39643 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfJAOe1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:34:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so11413328qki.6
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IrcOmQ8joVQ9VXHhOm4plz03yDUsuAlNt8q7tPyIPEI=;
        b=WXU39riE914quwUjrJCLYR90HFn6wfuunc5XC0HWQxeSfp/ewpbZ+ns31OumtaGu0k
         DjpGoa+rXSnAn+6ta0j42Z28YBGviuOyqfyZjszhemR86vjv0oCWWKyUy70Wk4DQbm5q
         3VFX7VGF0ppEe7yHUTL5pAz1T+W1uD55tS7h3S4YoU24mYBDGj0J2O8xGiTpo6UDroUT
         kIbOfPMHkM/MYJsQiLfq0oRMLcvLCxHkJvpRCJHsRrGvYt7Pm99MODfX4B6nZCP0O9Sm
         nCNhMseCd7v5vIR5mOMFmmBnYyf14RhapGE6aWItr2RIGkBC+1i4SNo6Q13iF+QhEBTg
         o0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IrcOmQ8joVQ9VXHhOm4plz03yDUsuAlNt8q7tPyIPEI=;
        b=PVatZwL9z9Vxv5kLtcsPMVbHNBFmcMmsYLfPPEfbqR1t1Mk+SV5iDWsQP9cEK7+bkH
         v/VzJpuAaWXipXzHdAYFYZo3vo7UYImwLZhB6grIG/QE/YU2TX3GCKp0V0T7e1BDA7tD
         qseU5qM5VcqkevX/YxRH6x28m9NLwC/2/TNaR06V1EgyMlaFm/+8T1Alq2aqtnyjI4+N
         /lkMhjfasMh3uGauxQMNLbAvkeiFiSxo8bS2c2GAnpyitTKN54qMJy52I1DLdionOGAb
         itDQ/5LiHtUt/MPIWuxkGnCbBR7Y8fgrHfR+hz2FOvC0BoN1PaNXmpF/qlQQXvI9O/lc
         ljOg==
X-Gm-Message-State: APjAAAUPqUavppiDyAXAeJc3e6AqYRR3GbuRNrqsDk/pE8lC9r2FEvYj
        lztBlyNQFxN1X//SWZID8p9QMg==
X-Google-Smtp-Source: APXvYqzrkVnAQViO7zLQ9oc7vIJYrsZfeYVl17iPQMK0P1/M3FyUirZc+2SthLf1m20yPSk9iytg7w==
X-Received: by 2002:a37:5f47:: with SMTP id t68mr6474438qkb.497.1569940465608;
        Tue, 01 Oct 2019 07:34:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t199sm7812380qke.36.2019.10.01.07.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:34:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJEO-00038n-P6; Tue, 01 Oct 2019 11:34:24 -0300
Date:   Tue, 1 Oct 2019 11:34:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     dledford@redhat.com, kamalheib1@gmail.com, aelior@marvell.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Fix use after free and refcnt leak
 on ndev in_device in iwarp_query_port
Message-ID: <20191001143424.GA12047@ziepe.ca>
References: <20190925123332.10746-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925123332.10746-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 03:33:32PM +0300, Michal Kalderon wrote:
> If an iWARP driver is probed and removed while there are no ips
> set for the device, it will lead to a reference count leak on
> the inet device of the netdevice.
> 
> In addition, the netdevice was accessed after already calling
> netdev_put, which could lead to using the netdev after already
> freed.
> 
> Fixes: 4929116bdf72 ("RDMA/core: Add common iWARP query port")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/device.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
