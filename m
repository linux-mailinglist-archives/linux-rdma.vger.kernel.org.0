Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB29129FD0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLXJsn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 04:48:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLXJsn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 04:48:43 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63564206CB;
        Tue, 24 Dec 2019 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577180923;
        bh=6yGDZjX0JrU8C/8BEcKQQh2Bu17EIKIQbTQU3wxFxe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skY0Kk88RynWuZCJvIGNUXMlE1OZWO/kaIp0E5qOHWwkoQuAyTPKI14e1/0gd2Bm/
         Fv6FpYaxdb5et3Qou9Y+P6UQEd9oYpnaxRXWALuOgbU7cpfFrs7EYQLFX7qOQzW4Zv
         MIcHevbMD35EVCuRqe1CaxLNFNXSO5YiHEekdZro=
Date:   Tue, 24 Dec 2019 11:48:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 4/5] RDMA/mlx4: use true,false for bool variable
Message-ID: <20191224094839.GC120310@unreal>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
 <1577176812-2238-5-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577176812-2238-5-git-send-email-zhengbin13@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 24, 2019 at 04:40:11PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
>
> drivers/infiniband/hw/mlx4/qp.c:852:2-14: WARNING: Assignment of 0/1 to bool variable
> drivers/infiniband/hw/mlx4/qp.c:3087:3-10: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
