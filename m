Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740951DD7AC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgEUTzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 15:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUTzh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 15:55:37 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06589C061A0E
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 12:55:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l1so6514035qtp.6
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SvU+q+Ni+fD6wE2TdElPNcO9Nx54szZTphr0DSdOk6Q=;
        b=a1vyUj54aiBaNCw0njaZeD1YIPpWLgg65Kr0Tls2EHcfC9sDoA0mIuSVG6RGJlmb9l
         rG25nI/kc0Cv38ADj3Qu1j35gUNf8cc/KwxnFVrMJ6FSx4SRL4PRHupWhJZafFSrqy7N
         juny0KsQDc6a9nO0eBMaUvXJiZBgAz1k+XcxKJW7HPx/p9aDEj/4yQFwgpDRWSFjyQpc
         GUEM4Srts2XKGqm1aTVIPBhUJb33eTbCFSi1nQE8L/eYfoBesfagC7VKxoKCXapDSOrH
         2Xk8wIfJANkbGm0gzwWdfiv7mnBt4DbPWvy9FNodAiIzg8D1gpdC8i8sb4nYTjYndzHU
         1jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SvU+q+Ni+fD6wE2TdElPNcO9Nx54szZTphr0DSdOk6Q=;
        b=i3TJ8QdfQiyHHGChm414D3azCE1Xsu/bZSeTyepsO8jwaARe6k6uvd6zf6jbJumvfx
         ypPvr9LwsHtq6vylmlGomJpehUmIx/gXddSckOBPgFSsb9TsxDj/MF0myvqY99BVwiMm
         T7sopTyuFH1h3x+o4/GPMrx0JAQA0Kfn5XUdRJvS6TnBNj2jqNIqWj+50hvxzNYFEBb/
         dqh4RusKRb+D8/MD0zopxHRacjHqivTQNo/oWp8vlDCYkk60GN0F+hYNpK7mgKTRvC1x
         xDRAlPpFEZv4th0QA2xr5qExn/yyplV1vMlDBgeZ/LsvLihafqzfdfLa7TRyB8iMGPWO
         iCRg==
X-Gm-Message-State: AOAM533X+DOJSo7djEsD8M3kRovywMhC6bh0jYlTBF1Kprtw2kSmRaWJ
        UxPv3fDsOaAAIVrGbgx06oahqhrPUbQ=
X-Google-Smtp-Source: ABdhPJxJqd2iHioeO1vUXf5AbpqVHfDM0I12tuuOQ3gwehKg+InWj7Ui0YHZvlsSpqeiH9wDDr1Q4g==
X-Received: by 2002:ac8:6bda:: with SMTP id b26mr13002685qtt.230.1590090936213;
        Thu, 21 May 2020 12:55:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y129sm5683560qkc.1.2020.05.21.12.55.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 12:55:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbrHz-0002mZ-3q; Thu, 21 May 2020 16:55:35 -0300
Date:   Thu, 21 May 2020 16:55:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 for-next 00/16] New hfi1 feature: Accelerated IP
Message-ID: <20200521195535.GA10609@ziepe.ca>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 12:05:35PM -0400, Dennis Dalessandro wrote:
> This patch series is an accelerated ipoib using the rdma netdev mechanism
> already present in ipoib. A new device capability bit,
> IB_DEVICE_RDMA_NETDEV_OPA, triggers ipoib to create a datagram QP using the
> IB_QP_CREATE_NETDEV_USE.
> 
> The highlights include:
> - Sharing send and receive resources with VNIC
> - Allows for switching between connected mode and datagram mode
> - Increases the maximum datagram MTU for opa devices to 10k
> 
> The same spreading capability exploited by VNIC is used here to vary
> the receive context that receives the packet.
> 
> The patches are fully bisectable and stepwise implement the capability.
> 
> changes since v2
> *Rebased ontop of latest rdma/for-next
> 
> Changes since v1
> *Fix incorrect parameter to xa_find() in patch 9
> *Address Erez comments and try to hide opa from ipoib in patch 7
> *Fix some typos in RB lines
> 
> 
> Gary Leshner (6):
>       IB/hfi1: Add functions to transmit datagram ipoib packets
>       IB/hfi1: Add the transmit side of a datagram ipoib RDMA netdev
>       IB/hfi1: Remove module parameter for KDETH qpns
>       IB/{rdmavt,hfi1}: Implement creation of accelerated UD QPs
>       IB/{hfi1,ipoib,rdma}: Broadcast ping sent packets which exceeded mtu size
>       IB/ipoib: Add capability to switch between datagram and connected mode
> 
> Grzegorz Andrejczuk (6):
>       IB/hfi1: RSM rules for AIP
>       IB/hfi1: Rename num_vnic_contexts as num_netdev_contexts
>       IB/hfi1: Add interrupt handler functions for accelerated ipoib
>       IB/hfi1: Add rx functions for dummy netdev
>       IB/hfi1: Activate the dummy netdev
>       IB/hfi1: Add packet histogram trace event
> 
> Kaike Wan (3):
>       IB/hfi1: Add accelerated IP capability bit
>       IB/ipoib: Increase ipoib Datagram mode MTU's upper limit
>       IB/hfi1: Add functions to receive accelerated ipoib packets
> 
> Piotr Stankiewicz (1):
>       IB/hfi1: Enable the transmit side of the datagram ipoib netdev

Applied to for-next

Thanks,
Jason
