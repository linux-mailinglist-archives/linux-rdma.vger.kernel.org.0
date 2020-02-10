Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717BA157BA7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgBJNbh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:31:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44693 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgBJNbg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Feb 2020 08:31:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id v195so6404623qkb.11
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2020 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nsS1kLOP47bw8c1IOS+Sjk2eWilnFU5kAsufjhOMvMQ=;
        b=fxwFdJhsK7pVOMqfA6dJK0xOI0L5chlYtu0/lZTXydjwDeFtLiW3hHuCHf5J4X4KWp
         UNld1ER4ctCQVkmyfqhLda3hhbkALC9MJSzevAAPmMAixgMo7hHeJ5FYMxo96TG2vkRp
         yGOGDE5tPKmeqlztj+qcPMc/VfUzi62zCu4LfKq5NdK33o7zinJJmcPHBQTlzcHDGk33
         E6a5TX2gcPOPSe1i900gPKQ6l5KJF/EphyoP4hXE/Da4qESvBysCHYvD34PELmOLtp3j
         rUV/pbJJ2eT9bXi3QxL5hssu8vYQHfwnOjrwmp1xncZo69cAudrWpHrxSaGt179vlvHP
         mSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nsS1kLOP47bw8c1IOS+Sjk2eWilnFU5kAsufjhOMvMQ=;
        b=MyvKfAvOuCAQDT4U93dG59li7ZOiN1MOq5S5Zjj5tj0ZzgsGVtWtdDLcob2rWhwbx6
         cNU2itnSFzHcOdIZhx/rUSqhvmVV/FKzT6h79I9/kfpyqP5bSAPWcNahxCu95Eaf9Aip
         rRaQz2onNBotTWWeAvKUEsCFAEkIDu1MvtOUZgkbptqAiVqFLXYtLRUwS76oOuT90ehm
         28cnBZ1j6Mx2UmMbDHmHTdq2/X2Wi0sGXbqRH25XpxzGvR/4zBZa3joIzgKYgywF+ycd
         58N3BCVdowk8UOnQBm3CFeEeko3mwtaPs0qapnLt7zDx6C2UzuoKNBpOv6MpC84ni/Ry
         hhoA==
X-Gm-Message-State: APjAAAWndJtKiNkr9z0+Wbie/o2VJ04RI1uo7LNl/JsRKVWL2GY8DSOh
        tDi2uw6DiyztuDDSM67KwrTIBw==
X-Google-Smtp-Source: APXvYqy3ZlYn21F+P7/Idq5F4eNF79k9MEollu2t6X+qDOdqq4jVFgazH6HreF5X7HY0ch6s+KIv5g==
X-Received: by 2002:a05:620a:713:: with SMTP id 19mr1333630qkc.450.1581341495383;
        Mon, 10 Feb 2020 05:31:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i13sm133379qkk.78.2020.02.10.05.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 05:31:34 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j199y-0007aA-CA; Mon, 10 Feb 2020 09:31:34 -0400
Date:   Mon, 10 Feb 2020 09:31:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 00/16] New hfi1 feature: Accelerated IP
Message-ID: <20200210133134.GN25297@ziepe.ca>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 08:18:05AM -0500, Dennis Dalessandro wrote:
> This patch series is an accelerated ipoib using the rdma netdev mechanism
> already present in ipoib. A new device capability bit,
> IB_DEVICE_RDMA_NETDEV_OPA, triggers ipoib to create a datagram QP using the
> IB_QP_CREATE_NETDEV_USE.
> 
> The highlights include:
> - Sharing send and receive resources with VNIC
> - Allows for switching between connected mode and datagram mode

There is still value in connected mode?

> - Increases the maximum datagram MTU for opa devices to 10k
> 
> The same spreading capability exploited by VNIC is used here to vary
> the receive context that receives the packet.
> 
> The patches are fully bisectable and stepwise implement the capability.

This is alot of code to send without a performance
justification.. What is it? Is it worth while?

> Gary Leshner (6):
>       IB/hfi1: Add functions to transmit datagram ipoib packets
>       IB/hfi1: Add the transmit side of a datagram ipoib RDMA netdev
>       IB/hfi1: Remove module parameter for KDETH qpns
>       IB/{rdmavt,hfi1}: Implement creation of accelerated UD QPs
>       IB/{hfi1,ipoib,rdma}: Broadcast ping sent packets which exceeded mtu size
>       IB/ipoib: Add capability to switch between datagram and connected mode
> 
> Grzegorz Andrejczuk (7):
>       IB/hfi1: RSM rules for AIP
>       IB/hfi1: Rename num_vnic_contexts as num_netdev_contexts
>       IB/hfi1: Add functions to receive accelerated ipoib packets
>       IB/hfi1: Add interrupt handler functions for accelerated ipoib
>       IB/hfi1: Add rx functions for dummy netdev

This dummy netdev thing seemed very strange

Jason
