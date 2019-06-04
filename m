Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B6340C5
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFDHyE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 03:54:04 -0400
Received: from verein.lst.de ([213.95.11.211]:34010 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfFDHyD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 03:54:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3526268B02; Tue,  4 Jun 2019 09:53:37 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:53:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 16/20] RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI
 handover
Message-ID: <20190604075336.GS15680@lst.de>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com> <1559222731-16715-17-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222731-16715-17-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -	if (reg->mr->need_inval) {
> -		reg->inv_wr.opcode = IB_WR_LOCAL_INV;
> -		reg->inv_wr.ex.invalidate_rkey = reg->mr->lkey;
> -		reg->inv_wr.next = &reg->reg_wr.wr;
> -		count++;
> -	} else {
> -		reg->inv_wr.next = NULL;
> -	}
> +	count += rdma_rw_inv_key(reg);

Splitting out this helper seems separate, would be nice to have it as
a prep patch separate from this big one.

> +	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));

Why do we need to do a struct copy here instead of setting up a pointer?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
