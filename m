Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65FD158267
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 19:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJScv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 13:32:51 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42653 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJScv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Feb 2020 13:32:51 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so3640148qvb.9
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2020 10:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V98pyfuqIsKINaU9G2YfO+p/YtqBX4/ZmyTRNhw2EYw=;
        b=mufHwE+aY96/kxZnThBrz3H3RjCqgyI+6kRKT9B9M/3nDUu2pzLrS2G0QF9GTqKg4X
         KH5m2Jg9o9JuleX8vFmqND3yNMWQcJ4z3jaYaXiTpnIfdtEK7OQGzaknQru4yaqBvV3w
         +HVVFRImIeZZwiqpQl8PJfaCRD84w1CRoG77pSoQgsvHkkSPJkRlgN6TXFjErLu4fd/P
         hxMG5Q4TKmUNabDrajP2f0cDz08yGBVVEE9mOHe9yUHC9gHrE8wXizse8nN72bd9qIrK
         PXyYBzp4Vp5fgPEh50GP8Ee8gZFqxpfzoDKi6tr4gKskm5lylARJfTMepDPZIoENPgpJ
         vAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V98pyfuqIsKINaU9G2YfO+p/YtqBX4/ZmyTRNhw2EYw=;
        b=o8Ww9OozgDc4wUyg1LrDozRPwUeR7DaHJqbm5Zh5/rOwPeZEGQYl/v28+gt1kMKxSI
         lC/GKJ7UbEvWlDqhD64H+vUELp4og2l/08Dn7s5dm02dM63Syo3o+/pjvf1XqDsX5pce
         bQepu/e+suZj+3mZmjthc2xynsJ6Zj1U9FmjM47WWmlCU7C/p9l1cEmwBRpxhpEVBWiF
         b4ln1q88mKlsRC37NrheCmJ6FV7Idgfj7+H1+QqpA7FZ8t5F3tMTfR9tyNT/L9Ijr78p
         HWXURuHJPfx5gJgRKWDf3UtMKVoR3aKmxfK4CPaEXtN5WA7yi7CF0u4bdhqC+w3B6pp+
         fpdw==
X-Gm-Message-State: APjAAAWBxeD9GS9/hRm0xdeiWd+8hI7P1IAWi6Q+yQmZTHeNH5+fJNgA
        +wYN58FEkCFERNnK4A1qzyZTkJaRyl26ug==
X-Google-Smtp-Source: APXvYqy7ypFdAlQFZELCNYZJancynR9NMW7Cs57j81yXSfXBPyZunjA9X3jDZ7Cb5I3z71l2NxWjZg==
X-Received: by 2002:a05:6214:94b:: with SMTP id dn11mr10829635qvb.12.1581359570098;
        Mon, 10 Feb 2020 10:32:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f11sm392971qkk.40.2020.02.10.10.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 10:32:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1DrV-0005Tq-49; Mon, 10 Feb 2020 14:32:49 -0400
Date:   Mon, 10 Feb 2020 14:32:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 00/16] New hfi1 feature: Accelerated IP
Message-ID: <20200210183249.GA4182@ziepe.ca>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210133134.GN25297@ziepe.ca>
 <84596806-a9ff-1c2a-7116-abd9fa9d2213@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84596806-a9ff-1c2a-7116-abd9fa9d2213@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 12:36:02PM -0500, Dennis Dalessandro wrote:
> On 2/10/2020 8:31 AM, Jason Gunthorpe wrote:
> > On Mon, Feb 10, 2020 at 08:18:05AM -0500, Dennis Dalessandro wrote:
> > > This patch series is an accelerated ipoib using the rdma netdev mechanism
> > > already present in ipoib. A new device capability bit,
> > > IB_DEVICE_RDMA_NETDEV_OPA, triggers ipoib to create a datagram QP using the
> > > IB_QP_CREATE_NETDEV_USE.
> > > 
> > > The highlights include:
> > > - Sharing send and receive resources with VNIC
> > > - Allows for switching between connected mode and datagram mode
> > 
> > There is still value in connected mode?
> 
> It's really a compatibility thing. If someone wants to change modes that
> will work. There won't be any benefit to connected mode though. The goal is
> just to not break.

I am a bit confused by this.. I thought the mlx5 implementation
already could select connected mode?

Why were core ipoib changes needed?

> > > The patches are fully bisectable and stepwise implement the capability.
> > 
> > This is alot of code to send without a performance
> > justification.. What is it? Is it worth while?
> 
> It avoids the scalability problem of connected mode, the number of QPs.
> Incoming packets are spread into multiple receive contexts increasing
> parallelism. The MTU is increased to allows 10K. It also reduces/removes the
> verbs TX overhead by allowing packets to be sent through the SDMA engines
> directly.

No numbers to share?

Jason
