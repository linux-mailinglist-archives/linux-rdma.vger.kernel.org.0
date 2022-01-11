Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A648A79F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 07:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbiAKGL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 01:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiAKGL5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jan 2022 01:11:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34F8C06173F
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 22:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0670614DB
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jan 2022 06:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600ADC36AE9;
        Tue, 11 Jan 2022 06:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641881516;
        bh=b9HgWQnOtQAJiyS5nmiNdG7snnLbfHuC/DYpdx7S50k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPYG1EfvTyBPCKiBL7C7EPNeo2LT5vgJu4L02E/Pz5/j23T3Hzs1kynkKiVVmxVUo
         OzD+MfwwpWYeKxL/wOkPoU3z/YIRauxHQMsptYQwSa2O/Q9ivZ1LfgAoSJqz+Zw8Nt
         KasNQhSdPQB6xK5C7WqDWlSRfU8dARjWSVthA7Ys7wVGBeKVQcjcOvc2uOvGEyJgKb
         1jC3pKvZMCobZyE4UF9/1xhEAMkeH2o2IsnjRXIqx7AdA5pG18YDIzNWzimQVam1mg
         6ASyZcfZ6AbGSObUyiTn+V/z+Vg9pT5ucwCUlXDc0B+eiNVDfVozUGPNa8zrxFJwsB
         i0y0+cZI9EYcQ==
Date:   Tue, 11 Jan 2022 08:11:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Message-ID: <Yd0fpzSbzWPv1TS0@unreal>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 11, 2022 at 10:24:04AM +0800, Xiao Yang wrote:
> The expression "cons == ((qp->cur_index + 1) % q->index_mask)" mistakenly
> assumes the queue is full when the number of entires is equal to "maximum - 1"
> (maximum is correct).
> 
> For example:
> If cons and qp->cur_index are 0 and q->index_mask is 1, check_qp_queue_full()
> reports ENOSPC.
> 
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
> index 6de8140c..708e76ac 100644
> --- a/providers/rxe/rxe_queue.h
> +++ b/providers/rxe/rxe_queue.h
> @@ -205,7 +205,7 @@ static inline int check_qp_queue_full(struct rxe_qp *qp)
>  	if (qp->err)
>  		goto err;
>  
> -	if (cons == ((qp->cur_index + 1) % q->index_mask))
> +	if (cons == ((qp->cur_index + 1) & q->index_mask))

Please reuse queue_full().

Thanks

>  		qp->err = ENOSPC;
>  err:
>  	return qp->err;
> -- 
> 2.25.1
> 
> 
> 
