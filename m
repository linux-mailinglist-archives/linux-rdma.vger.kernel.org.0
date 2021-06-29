Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A343B6E76
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhF2HAu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 03:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232182AbhF2HAu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 03:00:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0E4461DC6;
        Tue, 29 Jun 2021 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624949903;
        bh=8gP8Nztr5xuzd9X82dKzaFj5Esa7fpdQ/zB1vflk/BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1HItjp21rzYiJApINoGFiiryDC/uBFkEXddzWXXlib1N+ZNOMjBj25uUds+ED385
         vsGeoveyNi4Be+oDe253tqO0mf1j8TX2JxN2LRV6UD4XnDJr66C+9rQMirDMIffGBh
         /Mmn7vAS0Cn2oH+Yned9aeUJx45iLFVcseytY8k5U1/DeczUtkGkrFi8vAkKiF6cbE
         kDXPEWq/sAOaZkUV1eq9fgUo2f1iaR0IQRjcZyAgSuyf33M4faNYT0+3oaB8U5bNMP
         8f3jK3K41IzcFVniP+T+6kHllt7lgFcqLZuvjV7hsaA69gQLa6cLlF3eRlrkMjH4k1
         6FP/YPkyd1erw==
Date:   Tue, 29 Jun 2021 09:58:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] Update kernel headers
Message-ID: <YNrEi8G/n6YCl81O@unreal>
References: <20210628220535.10020-1-rpearsonhpe@gmail.com>
 <45f33f25-d75e-5905-a2ce-bd62573a9a5e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f33f25-d75e-5905-a2ce-bd62573a9a5e@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 29, 2021 at 09:36:50AM +0300, Gal Pressman wrote:
> On 29/06/2021 1:05, Bob Pearson wrote:
> > To commit ?? ("RDMA/rxe: Convert kernel UD post send to use ah_num").
> > 
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> >  kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> > index e283c222..e544832e 100644
> > --- a/kernel-headers/rdma/rdma_user_rxe.h
> > +++ b/kernel-headers/rdma/rdma_user_rxe.h
> > @@ -98,6 +98,8 @@ struct rxe_send_wr {
> >  			__u32	remote_qpn;
> >  			__u32	remote_qkey;
> >  			__u16	pkey_index;
> > +			__u16	reserved;
> > +			__u32	ah_num;
> >  		} ud;
> >  		struct {
> >  			__aligned_u64	addr;
> > @@ -148,7 +150,12 @@ struct rxe_dma_info {
> >  
> >  struct rxe_send_wqe {
> >  	struct rxe_send_wr	wr;
> > -	struct rxe_av		av;
> > +	union {
> > +		struct rxe_av av;
> > +		struct {
> > +			__u32		reserved[0];
> > +		} ex;
> > +	};
> >  	__u32			status;
> >  	__u32			state;
> >  	__aligned_u64		iova;
> > @@ -168,6 +175,11 @@ struct rxe_recv_wqe {
> >  	struct rxe_dma_info	dma;
> >  };
> >  
> > +struct rxe_create_ah_resp {
> > +	__u32 ah_num;
> > +	__u32 reserved;
> > +};
> > +
> >  struct rxe_create_cq_resp {
> >  	struct mminfo mi;
> >  };
> > 
> 
> I think the second patch didn't make it to the list.

I don't know how Bob sends his patches, but it is here
https://lore.kernel.org/linux-rdma/20210628220303.9938-1-rpearsonhpe@gmail.com

Thanks
