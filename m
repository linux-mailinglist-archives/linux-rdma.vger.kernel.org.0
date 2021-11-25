Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CEA45E13B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 21:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbhKYUDe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 15:03:34 -0500
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:39842 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233721AbhKYUBe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 15:01:34 -0500
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7BCC8182CED28;
        Thu, 25 Nov 2021 19:58:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 3C137B00018A;
        Thu, 25 Nov 2021 19:58:18 +0000 (UTC)
Message-ID: <ddef1847b4694071ae914eab93b0d2bd45fdf050.camel@perches.com>
Subject: Re: [PATCH] RDMA/mlx4: Use bitmap_alloc() when applicable
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        yishaih@nvidia.com, selvin.xavier@broadcom.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Thu, 25 Nov 2021 11:58:19 -0800
In-Reply-To: <4c93b4e02f5d784ddfd3efd4af9e673b9117d641.1637869328.git.christophe.jaillet@wanadoo.fr>
References: <4c93b4e02f5d784ddfd3efd4af9e673b9117d641.1637869328.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.15
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3C137B00018A
X-Stat-Signature: yn53aj5yzrhutyoeq7rdpr4cc3gnxx3u
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+75TsI88XshvqkCZYPF2FcNlF9F4sYqEY=
X-HE-Tag: 1637870298-589355
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 2021-11-25 at 20:42 +0100, Christophe JAILLET wrote:
> Use 'bitmap_alloc()' to simplify code, improve the semantic and avoid some
> open-coded arithmetic in allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.

Thanks.

> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
[]
> @@ -2784,10 +2784,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
>  		if (err)
>  			goto err_counter;
>  
> -		ibdev->ib_uc_qpns_bitmap =
> -			kmalloc_array(BITS_TO_LONGS(ibdev->steer_qpn_count),
> -				      sizeof(long),
> -				      GFP_KERNEL);
> +		ibdev->ib_uc_qpns_bitmap = bitmap_alloc(ibdev->steer_qpn_count,
> +							GFP_KERNEL);

I wonder if it'd be simpler/smaller to change this to bitmap_zalloc and
remove the bitmap_zero in the if below.


