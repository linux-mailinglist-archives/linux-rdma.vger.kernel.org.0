Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89EB3AE496
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFUIOE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUIOD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 04:14:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E067610EA;
        Mon, 21 Jun 2021 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624263110;
        bh=B1HzwqF6qT//Y5Tg885P0y5TOhf9gHty4Tfj48hXgs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DG3n0y4jQeQ93qQYfC3lleF7+cF9JCV0gApVQJuAGBfdAhBgvUlpHivyu5LJjmofI
         BDxaHC7f4pw709wDALCHE/IRoLiwFyhQdmfTlFzp1HtNEj1SyhLgS+J+Y4NCzZEgmT
         /vib9syMyUKb5W5dLeAH3nji6ROzSAkwwslBK5YE7/b/wGisfqZIZC+2jfvQQZinoN
         1bw34xxE0Z05NAS5rAkylX2an60H33tFy5d7/WF1VH5h51ayZA0u8rD4u6W8YnwTAS
         boslV83TgSx325C3fxvaqzQBGpB4V7Nl9FNCvdJ6io9ryRFcznDDnyv2RN2ryjfOz5
         d0X4OERgeROJA==
Date:   Mon, 21 Jun 2021 11:11:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jack Morgenstein <jackm@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Avoid field-overflowing memcpy()
Message-ID: <YNBJwnwaS6w9A0x4@unreal>
References: <20210616203744.1248551-1-keescook@chromium.org>
 <YMr4ypsh7D3q1R5+@unreal>
 <202106171239.C425161E8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106171239.C425161E8@keescook>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 12:46:43PM -0700, Kees Cook wrote:
> On Thu, Jun 17, 2021 at 10:24:58AM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 16, 2021 at 01:37:44PM -0700, Kees Cook wrote:
> > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > > intentionally writing across neighboring array fields.
> > > 
> > > Use the ether_addr_copy() helper instead, as already done for smac.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/infiniband/hw/mlx4/qp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> > > index 2ae22bf50016..4a2ef7daaded 100644
> > > --- a/drivers/infiniband/hw/mlx4/qp.c
> > > +++ b/drivers/infiniband/hw/mlx4/qp.c
> > > @@ -3144,7 +3144,7 @@ static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
> > >  		mlx->sched_prio = cpu_to_be16(pcp);
> > >  
> > >  		ether_addr_copy(sqp->ud_header.eth.smac_h, ah->av.eth.s_mac);
> > > -		memcpy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac, 6);
> > > +		ether_addr_copy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac);
> > >  		memcpy(&ctrl->srcrb_flags16[0], ah->av.eth.mac, 2);
> > >  		memcpy(&ctrl->imm, ah->av.eth.mac + 2, 4);
> > 
> > I don't understand the last three lines. We are copying 6 bytes to
> > ah->av.eth.mac and immediately after that overwriting them.
> 
> I'm not following (the memcpy() is replaced by ether_addr_copy()).

Forget it, it was me who mixed src with dst in the memcpy() signature.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
