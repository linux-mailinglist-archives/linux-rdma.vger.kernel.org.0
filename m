Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408A71D1316
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgEMMsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 08:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgEMMsu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 08:48:50 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120BFC061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 05:48:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p12so13954144qtn.13
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=piOik5VBBOtgVHsUlPDt+SR4sWgq3cICx+KMFs5W0ds=;
        b=iOQmptvFfkmNPn+ZD7Q9hQG0pH/Aeuv5PjhSohoTK4zpUiIwv5sU4vj7EMuRuPjLTo
         VKTVOReMyygrjg9ZSd/J6XhDAV0RGC0ly1MOinVrxHViGsd55Sykg7hriqmsai9ZE/5b
         bxdkLAwTrE96RizzIXeFD4vfoMC1fe25t++A4NTkFY1UNQ0SODGbpJ+jcNk7J+WUL/R9
         pw6WY3VUFyYyKAABe2HMRykGcOG7Se42fyEG7mmlwgg0YgOWF0KhaSqUDct4cUIZSvDJ
         QztgSNPsuLEIEYsgJggH7TKXQTeAEsCDkjAfYye5S6te+XWt5iYNWSII+gV1gWS5r/KD
         MhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piOik5VBBOtgVHsUlPDt+SR4sWgq3cICx+KMFs5W0ds=;
        b=JCH5ezb0ErbsnX4bCJDTanPcE7AFg2YvMHO3sJGajWczPX/P5rXrla8zko8evujJxm
         mB9XP3hAn9eImXoYkZGJIvqlokqs+hnYs/wL/WMSYUu5z0t/W6As20koH0ptcd5uMCa9
         zxKO3fGFhyUi4OwLjD/d6YIvh/0aPNfpM5WLSDeo+me9CKAl8YxTrx7NjxEaCkm+hMDP
         Cnfl1iFbRfwvlXHUojvd4qxNM5EBq+PI2lZ2/swLHuq4MdAK8bftRM+ANc+bhAQNiicM
         +aFoajvUpiN1KtwOmjg8vHF/7Bwfpji5/Hm/nsf+u6i5g4oQZPqEb8mZ6F+LSPndpIXc
         NzyA==
X-Gm-Message-State: AGi0Puamous/xSVa/lIgiLZN/4f1OfIXrQZqv1/19Fy++rhFUH4HfLYb
        qQGlIcll4sA9PcuUhRfYG3dFPnK8lrk=
X-Google-Smtp-Source: APiQypJVymhuxgO81RTblPDrC9whUyohJhHUcKBfrDFCO762hngPq6NopnwInIG1upxaBEdPwgd9JQ==
X-Received: by 2002:ac8:2c44:: with SMTP id e4mr28551157qta.13.1589374128211;
        Wed, 13 May 2020 05:48:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s56sm7717487qtk.45.2020.05.13.05.48.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 05:48:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYqoZ-0008HL-3w; Wed, 13 May 2020 09:48:47 -0300
Date:   Wed, 13 May 2020 09:48:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513124847.GB29989@ziepe.ca>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511222918.62576-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 01:29:18AM +0300, Kamal Heib wrote:
> Avoid disabling device management for devices that don't support
> Management datagrams (MADs) by checking if the "mad_agent" pointer is
> initialized before calling ib_modify_port, also change the error message
> to a warning and make it more informative.
> 
> Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 7ed38d1cb997..7b21792ab6f7 100644
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -625,14 +625,18 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
>  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
>  	};
>  	struct srpt_port *sport;
> +	int ret;
>  	int i;
>  
>  	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
>  		sport = &sdev->port[i - 1];
>  		WARN_ON(sport->port != i);
> -		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
> -			pr_err("disabling MAD processing failed.\n");
>  		if (sport->mad_agent) {
> +			ret = ib_modify_port(sdev->device, i, 0, &port_modify);
> +			if (ret < 0)
> +				pr_warn("%s-%d: disabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
> +					dev_name(&sport->sdev->device->dev),
> +					sport->port, ret);

This ib_modify_port needs to be strictly paired with the
ib_modify_port that turns on IB_PORT_DEVICE_MGMT_SUP.

If the call during register fails then we should not try to do it
during unregister.

So this is sort of the right approach, but the error unwind in
srpt_refresh_port() needs to be fixed too so that sport->mad_agent
indicates if modify_port is needed on unregister.

And the print is wrong, if something fails here it means the driver is
busted up as we should always be able to undo setting
IB_PORT_DEVICE_MGMT_SUP if it was successfully set.

Jason
