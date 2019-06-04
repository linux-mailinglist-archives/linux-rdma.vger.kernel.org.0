Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0872034098
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfFDHq3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 03:46:29 -0400
Received: from verein.lst.de ([213.95.11.211]:33948 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFDHq3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 03:46:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B397E68B02; Tue,  4 Jun 2019 09:46:02 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:46:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 14/20] RDMA/mlx5: Move signature_en attribute from
 mlx5_qp to ib_qp
Message-ID: <20190604074602.GQ15680@lst.de>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com> <1559222731-16715-15-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222731-16715-15-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 04:25:25PM +0300, Max Gurtovoy wrote:
> This is a preparation for adding new signature API to the rw-API.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>

Wouldn't it be better to have a qp_flags field with a bit set, as that
is more extensible?

> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index fc55482f51d6..936498c3f9cb 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1233,6 +1233,8 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
>  	qp->max_write_sge = qp_init_attr->cap.max_send_sge;
>  	qp->max_read_sge = min_t(u32, qp_init_attr->cap.max_send_sge,
>  				 device->attrs.max_sge_rd);
> +	if (qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN)
> +		qp->signature_en = true;

Don't we need a check if IB_QP_CREATE_SIGNATURE_EN is supported at all?
