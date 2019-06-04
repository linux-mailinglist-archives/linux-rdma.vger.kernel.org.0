Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3C340AA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFDHtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 03:49:25 -0400
Received: from verein.lst.de ([213.95.11.211]:33969 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFDHtZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 03:49:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 69BD268B02; Tue,  4 Jun 2019 09:48:58 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:48:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 15/20] RDMA/core: Validate signature handover device cap
Message-ID: <20190604074858.GR15680@lst.de>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com> <1559222731-16715-16-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222731-16715-16-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 04:25:26PM +0300, Max Gurtovoy wrote:
> Protect the case that a ULP tries to allocate a QP with signature
> enabled flag while the LLD doesn't support this feature.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Oh, ok.  I think this should be folded into the previous patch.

> +	if ((qp_init_attr->rwq_ind_tbl &&
> +	     (qp_init_attr->recv_cq ||
> +	      qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
> +	      qp_init_attr->cap.max_recv_sge)) ||
> +	    ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
> +	     !(device->attrs.device_cap_flags & IB_DEVICE_SIGNATURE_HANDOVER)))
>  		return ERR_PTR(-EINVAL);

This looks almost unreadable.   Just make the signature check a separate
conditional.
