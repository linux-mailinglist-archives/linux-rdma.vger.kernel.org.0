Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227577D6B4
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 09:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfHAHzF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 03:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbfHAHzE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 03:55:04 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE28C206A2;
        Thu,  1 Aug 2019 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564646103;
        bh=KChASIecDhD+PbyVwhVkSDnkhE/5LlGZ9yCZy14L2Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnFiRJ0C2VWqoCdh3Avr9Kay5ug2tZ9VsgoifMy2FNhaBe4wytEHG1jjtS9h8Nkn9
         +5fvEFSr9H77vOxS/H+ghYskw7NCPeACkfYGTqD/w93GgI6iLnD4KODupKW7nBHI/s
         EOKfPkoojY3uVWgrKERFbcrG0AxUB1dZWUC9ZfnA=
Date:   Thu, 1 Aug 2019 10:54:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Colin Ian King <colin.king@canonical.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix error return code in
 hns_roce_v1_rsv_lp_qp()
Message-ID: <20190801075458.GF4832@mtr-leonro.mtl.com>
References: <20190801012725.150493-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801012725.150493-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 01:27:25AM +0000, Wei Yongjun wrote:
> Fix to return error code -ENOMEM from the rdma_zalloc_drv_obj() error
> handling case instead of 0, as done elsewhere in this function.
>
> Fixes: e8ac9389f0d7 ("RDMA: Fix allocation failure on pointer pd")
> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
