Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447A6129FD1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 10:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfLXJsy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 04:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLXJsy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 04:48:54 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7991D206CB;
        Tue, 24 Dec 2019 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577180934;
        bh=UzZQIxbkEsgOisfn+1oJ3Vb/5MZh2XxcYs5Dxh0kl5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lz6rvP/3nKNF5QcNz3FE2+uBSKWDytNFIfH+Ecm1yf0TkDIy+xHjmCbdXuVyqlGR1
         PHV5iRWfeTNul/wsjDE1w9YezGg4rs/rIpY3ijoNwDYfNcQn79TrYmxFg8vZr7tExE
         RiSfhJJKgXWZfQM0RlYrRlrxPrPhTGA7KEWrmJZQ=
Date:   Tue, 24 Dec 2019 11:48:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/5] IB/hfi1: use true,false for bool variable
Message-ID: <20191224094851.GD120310@unreal>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
 <1577176812-2238-3-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577176812-2238-3-git-send-email-zhengbin13@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 24, 2019 at 04:40:09PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
>
> drivers/infiniband/hw/hfi1/rc.c:2602:1-8: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/rc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
