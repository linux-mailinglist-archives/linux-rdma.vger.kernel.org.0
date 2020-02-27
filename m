Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72417299A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 21:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgB0Um3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 15:42:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41736 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0Um3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 15:42:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so344357qtr.8
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NVL4zF3vxoUx869tmqxtq9T6A8QxtIl6Dfe9llYBdm8=;
        b=oPPhsBpiCKppwK86GwTwVjh9izY46zTPQqpTIFuFcLu1vuGAikExGRzUJ5Yq67QRST
         Ag2DUqrOLHuFyZHySGiSz2aec25G3aLqfjgsZCl962RkJYAgHzwHmgXB57yIfx/0IUR0
         bmEY+emiq2bPAR0n4czi1Co4wjSThNvbp850IxyMuiuAN7G1bTUHzjTCcyAI0W2LA7du
         /KPu+0U8vmdZWS8jRUfPp0YKsqVJ5Q8sCKqDOgPyCAwDk4ontbOEUL3r7XoXgR4OGCgh
         MtI96NoHsGFAAFMhYRZwx19NdgshmdMB5TZru1hBg3ANCDwfceQM1mrisvJgpFCK072L
         oyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NVL4zF3vxoUx869tmqxtq9T6A8QxtIl6Dfe9llYBdm8=;
        b=rxp3b+QmSbNWBJ7py6vHlltGO0qQh2ez7Bcn6I5LVjT/1SH/0ukm/iLA10Msgrd9ql
         BCMXt9omh0zg+Y46IPoflCidnOJfRMQWkH1IxDZqmT/xXwWKGbkB0ON3xpmU69nErZg9
         k2Iq31oKG2tUr6QB8GVC5YomVhISVavfCt6k6stxfT/nhiaefUqOfnUftp5xcuEVrTHq
         HGKeaIvYjXJVOScQnkIrfdTqmVNav8Ym+wKZ9ueR//6nZryFjskK6Ue9OnsDF869GPAP
         4i158m0eem0/Qr2xqvy6VhxxaTVG32psF8HMIJifmbUWKNFfewZJHMA6SyP645RoE/w0
         EH6Q==
X-Gm-Message-State: APjAAAWzk0eFemgBJrtQYMfvemJN7pM92l09NmoXVP/Izyzj3fPxw9bc
        kdByojTLYOYM8PTnf/NoEtJf6eV9htQEiw==
X-Google-Smtp-Source: APXvYqz2B9JMUQEeq9ou+p01w5dmKH7WLn/hBSyKbaG4peRoSnVmxxwzmzY/ItvG0zqhQOQgy6ZUUg==
X-Received: by 2002:aed:3022:: with SMTP id 31mr1147483qte.282.1582836146848;
        Thu, 27 Feb 2020 12:42:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b2sm3670319qkj.9.2020.02.27.12.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 12:42:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7PzG-0008EN-4k; Thu, 27 Feb 2020 16:42:26 -0400
Date:   Thu, 27 Feb 2020 16:42:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH rdma-next 0/2] Drop driver version in favor of default
 ethtool
Message-ID: <20200227204226.GC31359@ziepe.ca>
References: <20200220071239.231800-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220071239.231800-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 20, 2020 at 09:12:37AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Following the change in ethtool to provide default driver version which
> is aligned with kernel in use, drop the static assignments of driver
> versions in IPoIB and OPA_VNIC.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   RDMA/ipoib: Don't set constant driver version
>   RDMA/opa_vnic: Delete driver version

Applied to for-next

Jason
