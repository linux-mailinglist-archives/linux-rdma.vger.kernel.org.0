Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA206401E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 06:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfGJEgA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 00:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfGJEgA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 00:36:00 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEEFD20838;
        Wed, 10 Jul 2019 04:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562733359;
        bh=JXGYM+pHhCsyqyqJjEIfz0/70vlarffU1HeD/KPv9TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeR9JtT8SuW9+GjsycamFPzyuDYznpbrkoFgwjsA7G2K3pnBKjpXYjgZRJrbhLs3c
         jkrpJz4CB1cUyLHGdA1qLCLXOGzzqsm1oE4duoYmYLDUCUx1L8E63V9oqjxdDagTep
         tb2bJhqcjth7qFD00ww0rWyhE+1Fh+uzkDabkGYo=
Date:   Wed, 10 Jul 2019 07:35:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Print error code while kthread_create failed
Message-ID: <20190710043554.GA7034@mtr-leonro.mtl.com>
References: <20190710015009.57120-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710015009.57120-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 09:50:09AM +0800, YueHaibing wrote:
> In iw_create_tx_threads(), if we failed to create kthread,
> we should print the 'rv', this fix gcc warning:
>
> drivers/infiniband/sw/siw/siw_main.c: In function 'siw_create_tx_threads':
> drivers/infiniband/sw/siw/siw_main.c:91:11: warning:
>  variable 'rv' set but not used [-Wunused-but-set-variable]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/sw/siw/siw_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index fd2552a..2a70830d 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -101,7 +101,8 @@ static int siw_create_tx_threads(void)
>  		if (IS_ERR(siw_tx_thread[cpu])) {
>  			rv = PTR_ERR(siw_tx_thread[cpu]);
>  			siw_tx_thread[cpu] = NULL;
> -			pr_info("Creating TX thread for CPU %d failed", cpu);
> +			pr_info("Creating TX thread for CPU%d failed %d\n",
> +				cpu, rv);

Delete this print together with variable, failure to create kthread
is basic failure, which affect performance only. The whole kthread
creation spam in this driver looked suspicious during submission
and it continues to be.

Thanks

>  			continue;
>  		}
>  		kthread_bind(siw_tx_thread[cpu], cpu);
> --
> 2.7.4
>
>
