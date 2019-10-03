Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57271CAA5E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbfJCREE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 13:04:04 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:48549 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732998AbfJCREE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 13:04:04 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x93H3sMP028509;
        Thu, 3 Oct 2019 10:03:55 -0700
Date:   Thu, 3 Oct 2019 22:33:53 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Waisman <nico@semmle.com>
Subject: Re: [PATCH] cxgb4: do not dma memory off of the stack
Message-ID: <20191003170339.GA16190@chelsio.com>
References: <20191001153917.GA3498459@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001153917.GA3498459@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, October 10/01/19, 2019 at 21:09:17 +0530, Greg KH wrote:
> Nicolas pointed out that the cxgb4 driver is doing dma off of the stack,
> which is generally considered a very bad thing.  On some architectures
> it could be a security problem, but odds are none of them actually run
> this driver, so it's just a "normal" bug.
> 
> Resolve this by allocating the memory for a message off of the heap
> instead of the stack.  kmalloc() always will give us a proper memory
> location that DMA will work correctly from.
> 
> Reported-by: Nicolas Waisman <nico@semmle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
> 
> Note, test-built only, I don't have this hardware to actually run this
> code at all.
Thanks for the patch.
Tests with HW ran fine.
Tested-by: Potnuri Bharat Teja <bharat@chelsio.com>

> 
> diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
> index aa772ee0706f..b2bd3de81dcd 100644
> --- a/drivers/infiniband/hw/cxgb4/mem.c
> +++ b/drivers/infiniband/hw/cxgb4/mem.c
> @@ -275,13 +275,17 @@ static int write_tpt_entry(struct c4iw_rdev *rdev, u32 reset_tpt_entry,
>  			   struct sk_buff *skb, struct c4iw_wr_wait *wr_waitp)
>  {
>  	int err;
> -	struct fw_ri_tpte tpt;
> +	struct fw_ri_tpte *tpt;
>  	u32 stag_idx;
>  	static atomic_t key;
>  
>  	if (c4iw_fatal_error(rdev))
>  		return -EIO;
>  
> +	tpt = kmalloc(sizeof(*tpt), GFP_KERNEL);
> +	if (!tpt)
> +		return -ENOMEM;
> +
>  	stag_state = stag_state > 0;
>  	stag_idx = (*stag) >> 8;
>  
> @@ -305,28 +309,28 @@ static int write_tpt_entry(struct c4iw_rdev *rdev, u32 reset_tpt_entry,
>  
>  	/* write TPT entry */
>  	if (reset_tpt_entry)
> -		memset(&tpt, 0, sizeof(tpt));
> +		memset(tpt, 0, sizeof(*tpt));
>  	else {
> -		tpt.valid_to_pdid = cpu_to_be32(FW_RI_TPTE_VALID_F |
> +		tpt->valid_to_pdid = cpu_to_be32(FW_RI_TPTE_VALID_F |
>  			FW_RI_TPTE_STAGKEY_V((*stag & FW_RI_TPTE_STAGKEY_M)) |
>  			FW_RI_TPTE_STAGSTATE_V(stag_state) |
>  			FW_RI_TPTE_STAGTYPE_V(type) | FW_RI_TPTE_PDID_V(pdid));
> -		tpt.locread_to_qpid = cpu_to_be32(FW_RI_TPTE_PERM_V(perm) |
> +		tpt->locread_to_qpid = cpu_to_be32(FW_RI_TPTE_PERM_V(perm) |
>  			(bind_enabled ? FW_RI_TPTE_MWBINDEN_F : 0) |
>  			FW_RI_TPTE_ADDRTYPE_V((zbva ? FW_RI_ZERO_BASED_TO :
>  						      FW_RI_VA_BASED_TO))|
>  			FW_RI_TPTE_PS_V(page_size));
> -		tpt.nosnoop_pbladdr = !pbl_size ? 0 : cpu_to_be32(
> +		tpt->nosnoop_pbladdr = !pbl_size ? 0 : cpu_to_be32(
>  			FW_RI_TPTE_PBLADDR_V(PBL_OFF(rdev, pbl_addr)>>3));
> -		tpt.len_lo = cpu_to_be32((u32)(len & 0xffffffffUL));
> -		tpt.va_hi = cpu_to_be32((u32)(to >> 32));
> -		tpt.va_lo_fbo = cpu_to_be32((u32)(to & 0xffffffffUL));
> -		tpt.dca_mwbcnt_pstag = cpu_to_be32(0);
> -		tpt.len_hi = cpu_to_be32((u32)(len >> 32));
> +		tpt->len_lo = cpu_to_be32((u32)(len & 0xffffffffUL));
> +		tpt->va_hi = cpu_to_be32((u32)(to >> 32));
> +		tpt->va_lo_fbo = cpu_to_be32((u32)(to & 0xffffffffUL));
> +		tpt->dca_mwbcnt_pstag = cpu_to_be32(0);
> +		tpt->len_hi = cpu_to_be32((u32)(len >> 32));
>  	}
>  	err = write_adapter_mem(rdev, stag_idx +
>  				(rdev->lldi.vr->stag.start >> 5),
> -				sizeof(tpt), &tpt, skb, wr_waitp);
> +				sizeof(*tpt), tpt, skb, wr_waitp);
>  
>  	if (reset_tpt_entry) {
>  		c4iw_put_resource(&rdev->resource.tpt_table, stag_idx);
> @@ -334,6 +338,7 @@ static int write_tpt_entry(struct c4iw_rdev *rdev, u32 reset_tpt_entry,
>  		rdev->stats.stag.cur -= 32;
>  		mutex_unlock(&rdev->stats.lock);
>  	}
> +	kfree(tpt);
>  	return err;
>  }
>  
