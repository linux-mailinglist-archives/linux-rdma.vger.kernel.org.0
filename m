Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD91C4667
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 20:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgEDSwR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 14:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDSwQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 14:52:16 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B4C061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 11:52:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t7so187507qvz.6
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adjJOFzCV27UBowg1lrxThAfdTSRhfjEwd7jUgPNu98=;
        b=YZRAV0AyEHZEn9/fI9ik+VuoPT/P7uH/RwqNo+WZMyDbXXmTmjuqh/wcgTIguVa+c1
         bIFVoETAloA5UQjrY1t/Yfc0FTqr3a+nbjEYziaQJyOSHpiiJ4aBZk/0mJdq4y4KCR33
         shmtfXvKf4ENockWIQs5WA//OxVlh4sPPB2HxV7/sVl9xJIVVWA8YNixo592fT92Cfas
         hJ9tCF+5zvqTJZqhTzml8lxtP7YqXdJwVZTk++9QxERvZuRmrrwDhT3PTOieWVi0aBgv
         YflogUvb3JD5DwtGmWyU+2rom/P4nqRfeTbS6gQDm5gdBF2Yh0oJlHNSGV+iDTMyy1O2
         Fv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adjJOFzCV27UBowg1lrxThAfdTSRhfjEwd7jUgPNu98=;
        b=Y8x0OT960NyTxegwFJ5PQoMhfr2CfM9oxvH1v+tDGD4cVxaW1DyQ7Kewx/MiVvuVbL
         Gzam5iiNxeELaaWQZ2CgEJ17lRpnmWY19PPy+sBc9dniaxWC8fGYHAA+u8E2P8Qs7h/f
         wV23mz593fSpZSiHvomBt5v22Ubgt4iW9ZMiOc5XAyXO7m/uCUrM+je2Rth8u1kyEYXJ
         oR/5sBOqhgYCxJpiwUORuKnQt6fEZ9LaN4Aa2FhB5qF2ZuMGYUJhLbbvmbvwQidLUSbo
         1Jlby2gRSUpGU1MDZj7063CUMmGsQNt+z/575D46pwOs3Thi+2qbEpLL2wcOS+WLpce3
         4gjA==
X-Gm-Message-State: AGi0PuYqFpYo2PgNzG8h1hW1oN2+ECXV18Lg+cHAYJIbkLK+SG72kfyc
        FzkB17L6pYCvvSNDJE77GklyBg==
X-Google-Smtp-Source: APiQypKM1fi3EYDT2GhyOd/rpGfZXDtFNFVhvL1pwgUmcfW72iElR9ef8v/6QtcP0NMRef0SzGen+w==
X-Received: by 2002:a05:6214:1386:: with SMTP id g6mr519872qvz.105.1588618335941;
        Mon, 04 May 2020 11:52:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p75sm3892500qke.121.2020.05.04.11.52.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 11:52:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVgCM-00027B-RF; Mon, 04 May 2020 15:52:14 -0300
Date:   Mon, 4 May 2020 15:52:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Denis V. Lunev" <den@openvz.org>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] i40iw: remove bogus call to
 netdev_master_upper_dev_get
Message-ID: <20200504185214.GA8086@ziepe.ca>
References: <20200428131511.11049-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428131511.11049-1-den@openvz.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 28, 2020 at 04:15:11PM +0300, Denis V. Lunev wrote:
> Local variable netdev is not used in these calls.
> 
> It should be noted, that this change is required to work in bonded mode.
> In the other case we would get the following assert:
>  "RTNL: assertion failed at net/core/dev.c (5665)"
> with the calltrace as follows:
> 	dump_stack+0x19/0x1b
> 	netdev_master_upper_dev_get+0x61/0x70
> 	i40iw_addr_resolve_neigh+0x1e8/0x220
> 	i40iw_make_cm_node+0x296/0x700
> 	? i40iw_find_listener.isra.10+0xcc/0x110
> 	i40iw_receive_ilq+0x3d4/0x810
> 	i40iw_puda_poll_completion+0x341/0x420
> 	i40iw_process_ceq+0xa5/0x280
> 	i40iw_ceq_dpc+0x1e/0x40
> 	tasklet_action+0x83/0x140
> 	__do_softirq+0x125/0x2bb
> 	call_softirq+0x1c/0x30
> 	do_softirq+0x65/0xa0
> 	irq_exit+0x105/0x110
> 	do_IRQ+0x56/0xf0
> 	common_interrupt+0x16a/0x16a
> 	? cpuidle_enter_state+0x57/0xd0
> 	cpuidle_idle_call+0xde/0x230
> 	arch_cpu_idle+0xe/0xc0
> 	cpu_startup_entry+0x14a/0x1e0
> 	start_secondary+0x1f7/0x270
> 	start_cpu+0x5/0x14
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Konstantin Khorenko <khorenko@virtuozzo.com>
> CC: Faisal Latif <faisal.latif@intel.com>
> CC: Shiraz Saleem <shiraz.saleem@intel.com>
> CC: Doug Ledford <dledford@redhat.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: linux-rdma@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to for-rc, thanks

JAson
