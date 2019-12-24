Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21421129FD4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfLXJux (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 04:50:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfLXJux (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 04:50:53 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35318206CB;
        Tue, 24 Dec 2019 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577181052;
        bh=VVgs2tO7LIN86tacpClBg6g3oNKBjk1Z4pbfQe3WIx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4hWRfijJ1+kq/Iw5zlZCxvlvAA+n01PUGuOxR8Pox8Ng/i/gqG6us/+34kR5bmKA
         TcZgpTtUjLMUN2BpiDjrtkETjvK1lTkz5zQV4bYNYSekGodYIO8GMgus6QfZTncJU0
         2xjds2W+9TOspN/2ClooRXx6IPOq1A6ezRmhDAS0=
Date:   Tue, 24 Dec 2019 11:50:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/5] RDMA/siw: use true,false for bool variable
Message-ID: <20191224095049.GE120310@unreal>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
 <1577176812-2238-2-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577176812-2238-2-git-send-email-zhengbin13@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 24, 2019 at 04:40:08PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
>
> drivers/infiniband/sw/siw/siw_cm.c:32:18-41: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index 3bccfef4..0c3f058 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -29,7 +29,7 @@
>   * MPA_V2_RDMA_NO_RTR, MPA_V2_RDMA_READ_RTR, MPA_V2_RDMA_WRITE_RTR
>   */
>  static __be16 rtr_type = MPA_V2_RDMA_READ_RTR | MPA_V2_RDMA_WRITE_RTR;
> -static const bool relaxed_ird_negotiation = 1;
> +static const bool relaxed_ird_negotiation = true;

It is worth to simply delete this variable.

>
>  static void siw_cm_llp_state_change(struct sock *s);
>  static void siw_cm_llp_data_ready(struct sock *s);
> --
> 2.7.4
>
