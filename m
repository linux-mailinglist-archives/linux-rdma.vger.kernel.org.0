Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA617965D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 18:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgCDRJ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 12:09:56 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35714 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgCDRJ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 12:09:56 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so1117102qvi.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7DQZYG8fWUKxOQDbI6o95KvK/we6TdOQmtdo9LfpRHQ=;
        b=iqvw+56vvFOmFSeZ9LJzWmlyfLJ66FXjuhQmEEIMRnLRPdp+GAeHrzC7NWTSltYJ0J
         M51JG5j/5zTjb8/bsuQxMoq5b6HliBhXP0bWHEMqePJKVgQer9Zb/L1hOM8IXcuWu5Yr
         yUpLrkcp5RUFktODnvZ0av6ruoG3qESZjjMqie1dsbII3b3WRMrc0K+WFOCHoFU4ESIW
         wqg/eQa33FLw0XLPwmbR2GEunssLIVz3SX15Qvy9EsIbE5eYWYvrTiH7rauaQaXd8yzh
         KdT31n1sEVMhGLU0Hsv095wm37pxweaSTsgVTXo09fpo3lURo8U6+Ger7D3lSN7cPStF
         4pMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7DQZYG8fWUKxOQDbI6o95KvK/we6TdOQmtdo9LfpRHQ=;
        b=oyyTMcUXrCaiaXsxyFRchiHAFz+agFtMVlw1JfVhoDoF+WacNvQBuiBXFlHyscPsmq
         e2uPmanU74EVFj/y9xsugFaUv662a4rOxDMuyl7KW8nA8s/DD6YBdM8ViGpjRxzi0aL4
         4igf3X3Scy63glNSIIzy8SMQDBhFnhTcTrDJl0EHpYLg3aXIlx/VOsOl5A4r3qVRKnVW
         vCwtck2E0PDlEmVgTqo/BvGvEqD0JwM5EvP+4RcbCB6uSw9TtvisLdu6qAid1fkimFAe
         UaiC/bf6zq1fDCT+U3ilRob5UhKh/nuuseNR2b0Rbi6rWT9BC+nUPkNUkSNWJVdpA5S9
         +Fhw==
X-Gm-Message-State: ANhLgQ1Sv2Kxj1R3y/yljqlwaizs7/2Oiu66Ft/SB1HXXCi9Q/Xs9rQG
        SThzzcA9q6cJv4bZFfMo7vGMzA==
X-Google-Smtp-Source: ADFU+vvG0lb8WKV5R7SJg1eFxqIGMytosC9fNaUD54k7cZ/27MPRQKXRa3tIXsJ5swZNmRJBBvQXmQ==
X-Received: by 2002:a0c:cb05:: with SMTP id o5mr2903635qvk.141.1583341793910;
        Wed, 04 Mar 2020 09:09:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y3sm6443156qki.7.2020.03.04.09.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 09:09:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9XWq-00071J-UB; Wed, 04 Mar 2020 13:09:52 -0400
Date:   Wed, 4 Mar 2020 13:09:52 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next] RDMA/srpt: Avoid print error when modify_port
 is not supported
Message-ID: <20200304170952.GA26927@ziepe.ca>
References: <20200218101740.27762-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218101740.27762-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 12:17:40PM +0200, Kamal Heib wrote:
> Avoid printing the following error when modify_port isn't supported.
> 
> [47541.541145] ib_srpt disabling MAD processing failed.
> 
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 98552749d71c..eba2b156616d 100644
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -628,12 +628,14 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
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
> +		ret = ib_modify_port(sdev->device, i, 0, &port_modify);
> +		if (ret < 0 && ret != -EOPNOTSUPP)
>  			pr_err("disabling MAD processing failed.\n");
>  		if (sport->mad_agent) {
>  			ib_unregister_mad_agent(sport->mad_agent);

This logic is goofy if the original ib_modify_port fails then
sport->mad_agent should be NULL so it should just skip it anyhow.

If it is fixed up then we won't get the EOPNOTSUPP anymore.

I'm also unclear what this IB_PORT_DEVICE_MGMT_SUP is all about, it is
weird that a ULP is touching a device global flag like this

Jason
