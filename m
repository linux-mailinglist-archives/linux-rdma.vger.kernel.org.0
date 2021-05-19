Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7D388A0D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbhESJCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 05:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237641AbhESJCE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 05:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A98D1610CC;
        Wed, 19 May 2021 09:00:44 +0000 (UTC)
Date:   Wed, 19 May 2021 12:00:41 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Don Hiatt <don.hiatt@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH 1/5] RDMA/ib_hdrs.h: Remove a superfluous cast
Message-ID: <YKTTufav7me+Sgic@unreal>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512032752.16611-2-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 08:27:48PM -0700, Bart Van Assche wrote:
> be16_to_cpu() returns a u16 value. Remove the superfluous u16 cast. That
> cast was introduced by commit 7dafbab3753f ("IB/hfi1: Add functions to
> parse BTH/IB headers").
> 
> Cc: Don Hiatt <don.hiatt@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/rdma/ib_hdrs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/rdma/ib_hdrs.h b/include/rdma/ib_hdrs.h
> index 57c1ac881d08..82483120539f 100644
> --- a/include/rdma/ib_hdrs.h
> +++ b/include/rdma/ib_hdrs.h
> @@ -208,7 +208,7 @@ static inline u8 ib_get_lver(struct ib_header *hdr)
>  
>  static inline u16 ib_get_len(struct ib_header *hdr)
>  {
> -	return (u16)(be16_to_cpu(hdr->lrh[2]));
> +	return be16_to_cpu(hdr->lrh[2]);
>  }
>  
>  static inline u32 ib_get_qkey(struct ib_other_headers *ohdr)

It is unclear why this function in the header. It is called only once.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
