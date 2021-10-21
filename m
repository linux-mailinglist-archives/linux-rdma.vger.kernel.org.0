Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD343633A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJUNnE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 09:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhJUNnD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 09:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35BED61220;
        Thu, 21 Oct 2021 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634823647;
        bh=vRddTnmnNZ1G7/MHrauu1fPwinbPKp3NsatdLmySCpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORhRFLHCinrFBswvVw9WeCjAUyPrFfbhQGssTT04w3fte3VAsBDO4S4qJJKSmEnhH
         mT/pwgbejdUOWzV1iHJDMocxGS9WUsEsPyl0rRX53pP1+nkh5FWPCNgkzBjLQocegY
         PzW7P7/2wkf1hPJn0b+q8HmPB862l6eRJEBmMDrb7QBmeuORFWXfEsZukDNzubMzz4
         mnXw5jqafP/FV7AIpXR4OOHuleFkH523x2+c+Ks4dXZltgonAr2sqyvZ6tRCSIG68U
         /M+U4AXzd+GIxJKDNLwFePeOzJfU4MnMQ/oTGReWiPabbrVVC+Z5Ek79w/w9Br4qDW
         8JwLWpHqPzbyw==
Date:   Thu, 21 Oct 2021 16:40:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        saeedm@nvidia.com
Subject: Re: [PATCH rdma-next 2/3] mlx5: use dev_addr_mod()
Message-ID: <YXFt2/mx30fmDoj2@unreal>
References: <20211019182604.1441387-1-kuba@kernel.org>
 <20211019182604.1441387-3-kuba@kernel.org>
 <YXE3wblxcVY/1siJ@unreal>
 <20211021055823.2319a4c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021055823.2319a4c8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 21, 2021 at 05:58:23AM -0700, Jakub Kicinski wrote:
> On Thu, 21 Oct 2021 12:49:53 +0300 Leon Romanovsky wrote:
> > > -	dev->dev_addr[1] = (ipriv->qpn >> 16) & 0xff;
> 
>                       ^ the original modifies starting at offset 1

Ahh, right.

> 
> > > -	dev->dev_addr[2] = (ipriv->qpn >>  8) & 0xff;
> > > -	dev->dev_addr[3] = (ipriv->qpn) & 0xff;
> > > +	addr_mod[0] = (ipriv->qpn >> 16) & 0xff;
> > > +	addr_mod[1] = (ipriv->qpn >>  8) & 0xff;
> > > +	addr_mod[2] = (ipriv->qpn) & 0xff;
> > > +	dev_addr_mod(dev, 1, addr_mod, sizeof(addr_mod));  
> >                          ^^^ It should be 0, no?
