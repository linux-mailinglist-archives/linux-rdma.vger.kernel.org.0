Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8941E9CB6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 06:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFAEZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 00:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgFAEZg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jun 2020 00:25:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7289206C3;
        Mon,  1 Jun 2020 04:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590985536;
        bh=j5jBspOPRRyK89NladxWTeYhp7KqBe+iA6sF8n3bGvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctMK8DU8Kes5cmCcdUsbGl5ssqIeYxk+5Cq1f6NFLGnPQTEd9MHfLRZxkfLmwV023
         M63vU7FyJB0FuaA89xohVD9RGEjfAjqn3xQF7+RgolQqN0jvhJOQVWSqiYkDMTaMsw
         Ujcx/KjXOULn2HAbD7SZIMecHa7x94ZvU+S2cRpo=
Date:   Mon, 1 Jun 2020 07:25:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Xi Wang <wangxi11@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Uninitialized variable in
 modify_qp_init_to_rtr()
Message-ID: <20200601042532.GB34024@unreal>
References: <20200529083918.GA1298465@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529083918.GA1298465@mwanda>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 29, 2020 at 11:39:18AM +0300, Dan Carpenter wrote:
> The "dmac" variable is used before it is initialized.
>
> Fixes: 494c3b312255 ("RDMA/hns: Refactor the QP context filling process related to WQE buffer configure")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
