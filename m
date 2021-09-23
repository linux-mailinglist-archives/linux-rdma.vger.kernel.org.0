Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE44157F7
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbhIWFum (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 01:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhIWFul (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 01:50:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1DCF60F6B;
        Thu, 23 Sep 2021 05:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632376150;
        bh=SAUDmu78Fuk0YYUr036/HWE4RPSuEK4pmMYD5ZGPWnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOy0vmhP0+zfVG1s9HPhDdWQiHGau9oZ07azS7wnTkOmlNh5xgJsTyQARaZjTAbwK
         JhIDPKEOsrAA5imEg70yEJ7pk9YBAm1htEn+qvsMMm3Zn9awvPZ75ped8DfaUihefm
         usT/DXG6/gWDtAaSJDCwVw+nolhVFPb5tO0DHen0IkDZ4QA+yTVCxerYy3aBfTH+xS
         3G8wInrVv8r/12A1hD7XSmw+i3ydUF2IqsIVzUbWFB283xESMDrBLjm31F7c2+jVhD
         04cSUg6AZ2Fv86utVmeYOhhZ4LoOaSCdUIjnDmiYyQyBkAleiWwAxJ0Vy6Oo/LHVRR
         gXYs6X/GzC6qg==
Date:   Thu, 23 Sep 2021 08:49:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <YUwVUjrqT2PyVEO7@unreal>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
 <20210922144119.GV327412@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922144119.GV327412@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 11:41:19AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 22, 2021 at 11:01:39AM +0300, Leon Romanovsky wrote:
> 
> > > +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> > > +			 * rdma_resolve_ip() is called, eg through the error
> > > +			 * path in addr_handler. If this happens the existing
> > > +			 * request must be canceled before issuing a new one.
> > > +			 */
> > > +			if (id_priv->used_resolve_ip)
> > > +				rdma_addr_cancel(&id->route.addr.dev_addr);
> > > +			else
> > > +				id_priv->used_resolve_ip = 1;
> > 
> > Why don't you never clear this field?
> 
> The only case where it can be cleared is if we have called
> rdma_addr_cancel(), and since this is the only place that does it and
> immediately calls rdma_resolve_ip() again, there is no reason to ever
> clear it.

IMHO, it is better to clear instead to rely on "the only place" semantic.

Thanks

> 
> Jason
