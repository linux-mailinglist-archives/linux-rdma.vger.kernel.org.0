Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0542047C0C5
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhLUNcQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 08:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhLUNcQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Dec 2021 08:32:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC6C061574
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 05:32:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7400DCE1759
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 13:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD94C36AE8;
        Tue, 21 Dec 2021 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640093532;
        bh=jaI7Ra8OoSxmbya4nEdPlSQqxPmRSoxU2xCE45hZZcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPJkVGZCrp+vcFu+TKdvJZIzNiBls2zQ62WDhswiWu9MapTRNpFosN0OrpQAiN/io
         DiR5DeWLH8Yp18DsMf3Wi3BO8LSK6v3mf2JG8ciZPGqatkrC/JWsOLaYReDskvhqW+
         7VaQwYOBDvILitaOixk01g628KrDK7XWo8ER5xzEiS3Z7Y/7soMn8AkpoHFm/uK/9G
         h4St8Pe5bE8Fr88Mgni87RJ+fkJZp2Cvg0zideu50Es9HeRQV17uMdfKyxEdqGHhPG
         1x/nxUl0yWFgjS//WXqk9fJ3LzaT5K7q/tAa6IixqjzCTZ7u+0/0CRBOcVZbusmlaO
         WVvfbssYHw3AQ==
Date:   Tue, 21 Dec 2021 15:32:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs implementation
Message-ID: <YcHXWCJyhIYldpfr@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-8-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221024858.25938-8-chengyou@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 21, 2021 at 10:48:54AM +0800, Cheng Xu wrote:
> The RDMA verbs implementation of erdma is divided into three files:
> erdma_qp.c, erdma_cq.c, and erdma_verbs.c. Internal used functions and
> datapath functions of QP/CQ are put in erdma_qp.c and erdma_cq.c, the reset
> is in erdma_verbs.c.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_cq.c    |  201 +++
>  drivers/infiniband/hw/erdma/erdma_qp.c    |  624 +++++++++
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 1477 +++++++++++++++++++++
>  3 files changed, 2302 insertions(+)
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c


Please no inline functions in .c files and no void casting for the
return values of functions.

<...>

> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
> new file mode 100644
> index 000000000000..8c02215cee04
> --- /dev/null
> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
> @@ -0,0 +1,624 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
> + *          Kai Shen <kaishen@linux.alibaba.com>
> + * Copyright (c) 2020-2021, Alibaba Group.
> + *
> + * Authors: Bernard Metzler <bmt@zurich.ibm.com>
> + *          Fredy Neeser <nfd@zurich.ibm.com>
> + * Copyright (c) 2008-2016, IBM Corporation

What does it mean?

Thanks
