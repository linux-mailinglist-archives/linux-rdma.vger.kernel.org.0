Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142D1436233
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhJUNAo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 09:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhJUNAk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 09:00:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC7E6109F;
        Thu, 21 Oct 2021 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634821104;
        bh=349TnA80VU7qhPZUrG4YvQkB4+qf9yYTVh7Ph2VsEYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s6huM0Vu9LUBJzJm8rYtArox2Twf+dfN4c6Ujv7/EY6GcqscyZrCaT5pxwMzBwbGa
         LNlRpkxtVqE99xPMhm7rN4nMXSxAfdZj9zPDSxmgkBUO6y3JhTsVWoKr1GNZpE/ry4
         nvDe3TE18JiQ2rmiyYU8LuhMyipIaOGg9Q3YRAbAQNWySgxqECvKG10Cs0TAx0z5Gv
         waIj2mrPQ70RkprLhQZcHuSKFBmecOkt/uEEeJ3/hLkAuFgUdtokfy+dV0HUmdk7Jl
         SYTSnRwPWwrNGuSOluGFdeeLRo71K5DUU1AjYJ7hrUVddSfcHYgi3NtJLNG3juTq7E
         jfCPB2ASZkUFA==
Date:   Thu, 21 Oct 2021 05:58:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        saeedm@nvidia.com
Subject: Re: [PATCH rdma-next 2/3] mlx5: use dev_addr_mod()
Message-ID: <20211021055823.2319a4c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <YXE3wblxcVY/1siJ@unreal>
References: <20211019182604.1441387-1-kuba@kernel.org>
        <20211019182604.1441387-3-kuba@kernel.org>
        <YXE3wblxcVY/1siJ@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 21 Oct 2021 12:49:53 +0300 Leon Romanovsky wrote:
> > -	dev->dev_addr[1] = (ipriv->qpn >> 16) & 0xff;

                      ^ the original modifies starting at offset 1

> > -	dev->dev_addr[2] = (ipriv->qpn >>  8) & 0xff;
> > -	dev->dev_addr[3] = (ipriv->qpn) & 0xff;
> > +	addr_mod[0] = (ipriv->qpn >> 16) & 0xff;
> > +	addr_mod[1] = (ipriv->qpn >>  8) & 0xff;
> > +	addr_mod[2] = (ipriv->qpn) & 0xff;
> > +	dev_addr_mod(dev, 1, addr_mod, sizeof(addr_mod));  
>                          ^^^ It should be 0, no?
