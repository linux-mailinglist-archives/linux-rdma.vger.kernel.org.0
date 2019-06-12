Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47DE42D5C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405355AbfFLRXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 13:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbfFLRXW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 13:23:22 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1597208CA;
        Wed, 12 Jun 2019 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560360201;
        bh=X3y3faqBNWlR6eOmpqdbVZx8q18NB7nAsQLp+75VIac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wp+OGFnW+IIJjRn5EdPG84HQL5qr39lyQ6bCzVtlh325+XuZTxkuYNpTSy0iFbaYt
         pQZ+6AQtZTrC0IJVIrJCF+Xp/bGvfKbNpuizZ+Tq0l1tuHWS6TMru8VOX6X6LSaEUg
         Akci/zABJ26/+gEyTJMa3nrZukem6d8gsnmt6/Qs=
Date:   Wed, 12 Jun 2019 20:23:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_set_user_sq_size()
Message-ID: <20190612172316.GU6369@mtr-leonro.mtl.com>
References: <20190608092714.GE28890@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608092714.GE28890@mwanda>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 12:27:14PM +0300, Dan Carpenter wrote:
> This function is supposed to return negative kernel error codes but here
> it returns CMD_RST_PRC_EBUSY (2).  The error code eventually gets passed
> to IS_ERR() and since it's not an error pointer it leads to an Oops in
> hns_roce_v1_rsv_lp_qp()
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analysis.  Not tested.
>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index ac017c24b200..018ff302ab9e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1098,7 +1098,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
>  	if (ret == CMD_RST_PRC_SUCCESS)
>  		return 0;
>  	if (ret == CMD_RST_PRC_EBUSY)

The better fix will be to remove CMD_RST_PRC_* definitions in favor of
normal errno.

Thanks
