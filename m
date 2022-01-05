Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E79484EE3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 08:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiAEHw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 02:52:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38894 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiAEHw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 02:52:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C798B81923
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 07:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72992C36AE3;
        Wed,  5 Jan 2022 07:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641369146;
        bh=AW0Q5NRIZtjgtmpr86XnXQOI+UakHT2SI+Inj+5ffss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXMzj5sntO/i+DmW7xhUAlUvD2QjueYLcT0k8XvlCO6iHmqtvVJRSrLBliglCse0Z
         DTioo6vFCI/6etokfkeoxPhVSqO+EmnEWxYLOan9YfDHMDw/iCT/9wXMix/4Ta+Loq
         GUwqCXOnm9jOz6X4cncoc0cMbXLeZw0JMXncR4qM19D/MjIcYtp613j6Zo5isxo3Ar
         irxQYcqcCzsh786YGZ0UqQiKhLB2VfXuDI5+WZahH5z/o7AyWpLAm7lJEd0zrOclAH
         3GLePSW/2WaLXBuEgK78rQbiSAj8AvDq4NJXLlONd50HeTP0wLaAgDuvm9cIjwOThj
         2f2zQqZp8H+LQ==
Date:   Wed, 5 Jan 2022 09:52:22 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 4/5] RDMA/rxe: Use the standard method to produce udp
 source port
Message-ID: <YdVONs32Ue7R0kk1@unreal>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-5-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105221237.2659462-5-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 05:12:36PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Use the standard method to produce udp source port.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 0aa0d7e52773..42fa81b455de 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -469,6 +469,12 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  	if (err)
>  		goto err1;
>  
> +	if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_AH_GRH))

You are leaving src_port default and wired to same port as other QPs
without any randomization.

Thanks

> +		qp->src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
> +						  qp->ibqp.qp_num,
> +						  qp->attr.dest_qp_num);
> +
> +
>  	return 0;
>  
>  err1:
> -- 
> 2.27.0
> 
