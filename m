Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA4E0C27
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfJVTCp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:02:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38012 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732509AbfJVTCp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:02:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id p4so17332829qkf.5
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lkf0EJAEascXPDW2MsgcqqmkdSH+LkjFEpCIffGTte8=;
        b=XFvHGw6wZEz5Mzui7JhEwp1nWR5q9N5SPJ0bfK50hrobcwOmnZHDW68gYt06uuTmEE
         BO7VMVNEwrSQK1+wg92w2TDPEGmITBzI+eUIvh1wHPo67yshaA2KW/uCoD0URqbOCCzi
         kRNk4oIVCcWwRdCaV98cYZaRIDQgYn1+UI2srZ7Kv2eO4c+dXnypnfclpzIghmiPPgcR
         hQdXyudAxe3EtHB+J273hOv1hCEV6NB6vPoD2OyJ1cE5sC90gw3ADUReEQufkJMMxYEZ
         +gHWW65niBmxtA1E/pYpRDsVlS55NUil5648nToRCPO7AaPI09klP/SuCcf3l9AEK1Kr
         lZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lkf0EJAEascXPDW2MsgcqqmkdSH+LkjFEpCIffGTte8=;
        b=DGhp3YJyK3M0VzvBqWton7HFm3EZlxaAB+BRgSuP/EkF3v/4OR0kxgYjc86ltBvELq
         sKwg4+RjWFaM6AvKk92WL0vz0eC/2/Ilxpgg4+M5ZhDSTbZAuwagQoNHJord9/42bbe2
         RLkwseBYn20x9xmEld3n4zFRsUqo/+kOLIePduQ30NQs86SzP5Yhs86Gkhh2eVfxBYWT
         ps+nuT3ouA4ytbdeI8dUlTRQ4zchSr9P379gS54eyAmJRDRX7cY2cAYCjLrPG8/YJTtu
         7gQTj/mSlamMnRAKJlTxdpRFh5fsQR3jl/YSSG8v5bx9u37sLXVIFIxFi06dLCRmsUqu
         pkeg==
X-Gm-Message-State: APjAAAUibF5oi+RcncqzdyaiFr2A0idZxVgFIsBOtVsMxSxjYlhgVaTM
        JAdJusJeMS1KWjRqqBEjUzwTxDw3Wg0=
X-Google-Smtp-Source: APXvYqyG1SMHGT9zsfHnYFf9P40oVZTRYCtDX4PhGU1Sm5huMy4zIy4h8rcncFmnQMIEbG8foK1a4w==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr4630067qke.93.1571770964011;
        Tue, 22 Oct 2019 12:02:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h184sm4030999qkd.66.2019.10.22.12.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:02:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzQZ-0002dT-09; Tue, 22 Oct 2019 16:02:43 -0300
Date:   Tue, 22 Oct 2019 16:02:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next v1] IB/cma: Honor traffic class from lower
 netdevice for RoCE
Message-ID: <20191022190242.GA10085@ziepe.ca>
References: <20191015072058.17347-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015072058.17347-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 10:20:58AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> When macvlan netdevice is used for RoCE, consider the tos->prio->tc
> mapping as SL using its lower netdevice.
> 1. If lower netdevice is VLAN netdevice, consider such VLAN netdevice
> and it's parent netdevice for mapping
> 2. If lower netdevice is not a VLAN netdevice, consider tc mapping
> directly from such lower netdevice
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changelog:
> v0->v1: https://lore.kernel.org/linux-rdma/20191002121959.17444-1-leon@kernel.org
>  - Protect call to netdev_walk_all_lower_dev_rcu with rcu
> ----
>  drivers/infiniband/core/cma.c | 61 +++++++++++++++++++++++++++++------
>  1 file changed, 52 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
