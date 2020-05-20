Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F631DA613
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 02:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgETAH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 20:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgETAH2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 20:07:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D7C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:07:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v15so530429qvr.8
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WCLnqT98vczImfza68Nrt/B3hFKHSrSJ8Kk5UG0l0q0=;
        b=EkeQIy9TXwLHpZ4c0g1qWY8IgMEBOzEEZJh6aojQOPYnwM3Ac0dgj7Xqok1Ni7I8Wc
         1Z3/foI3JS+W7ELLIXqSs8S9WJd/VhDWY9TvNs21u6J4qRKwZQ3xQHLktYCcwlTS2nTe
         idPryjg+HcuMTLYjQBfCthG2n7O7FEKUsuVC0TzdGJBw2GRnRTb919tDBBqQCnZ610rv
         QV7EfM+8NqxEbb1JB+NBvO8LCLyUxYJk36Dn9Am2N6fCIjyqMkNDnJsmdVAC/WIh42iQ
         ZGnShci3Q9H50+wkEZjNN7LgyALPNhcmQT6hFqrQt+UfRtpXmTms9tL/3WLALnVIdWnf
         iGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCLnqT98vczImfza68Nrt/B3hFKHSrSJ8Kk5UG0l0q0=;
        b=eTRZLC3tkCmJHh4c62SUVvp4wHd9oWO08/XK+HigJgmT+Pg5k2KiOBAjwuXd/IPiYD
         A2Uq8LLR+7UrKmmumP541QIye2bPCEtiRNx/objUVqLV++FvpLalMdRWl+IFIC3RwRYg
         xTC8ujNMZl3YTLFLEudSC4wKwf1TLrXFT4Y7p0x9q+v4Ry8HRin20Or9UiuXFCN68mdN
         w3h+VVt5qR++b0Uqjcx5vWC7pMwsydf0X24gWJfgsHlaeSyOJ6Xi+PLCjQpAB/4z8KYo
         m7FSzYiJw0N3+2rvCb6IwXn88CS1FU5W1L3BuolsqUFvq95Ogr6xVNpzM08efAkH/gTH
         Vu9A==
X-Gm-Message-State: AOAM533q4TGdT/ZvxFo4wEMXmgyqhgtMdv3qO+eYqfmAhFD/gJRBfe8m
        i1Rh2/vYBpZAwBxN24HIspCcPQ==
X-Google-Smtp-Source: ABdhPJzsod3nFDQrNwrdelEd3jClZeQICyU70Dt9l/F6Wynw5P1GvJx7r2Nzn2BSQAMvi+RAcoRJ5g==
X-Received: by 2002:a05:6214:1265:: with SMTP id r5mr2225047qvv.171.1589933246719;
        Tue, 19 May 2020 17:07:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y28sm1123768qtc.62.2020.05.19.17.07.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 17:07:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbCGb-0003Fg-P8; Tue, 19 May 2020 21:07:25 -0300
Date:   Tue, 19 May 2020 21:07:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/efa: Report host information to the
 device
Message-ID: <20200520000725.GA12446@ziepe.ca>
References: <20200512152204.93091-1-galpress@amazon.com>
 <20200512152204.93091-3-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512152204.93091-3-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 06:22:04PM +0300, Gal Pressman wrote:
> The host info feature allows the driver to infrom the EFA device
> firmware with system configuration for debugging and troubleshooting
> purposes.
> 
> The host info buffer is passed as an admin command DMA mapped control
> buffer, and is unmapped and freed once the command CQE is consumed.
> 
> Currently, the setting of host info is done for each device on its
> probe. Failing to set the host info for the device shall not disturb the
> probe flow, any errors will be discarded.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Guy Tzalik <gtzalik@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 63 ++++++++++++++++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c       | 14 ++---
>  drivers/infiniband/hw/efa/efa_com_cmd.h       | 11 +++-
>  drivers/infiniband/hw/efa/efa_main.c          | 52 ++++++++++++++-
>  4 files changed, 130 insertions(+), 10 deletions(-)

Applied to for-next, thanks

Jason
