Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC69F3AFB0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 09:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfFJHaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 03:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388000AbfFJHaw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 03:30:52 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78410207E0;
        Mon, 10 Jun 2019 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560151851;
        bh=iJeEKH80rKgGU86YrkGhGj0Pkj63WOgeuBFIE6wczIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w6yWVpPcFREaipXS/SrFn8hOEotfmUF0RzhXy/W9rSgEYqyDDtp/e1P2hyEaQkTkE
         Dr5PAnfnWeuGgl5BLgavJNOUrEv5x0TtzMfxaZavLpl0M9eqezXtn7jJ2Tzurd9DxZ
         B9TlUQ5QbEU92VjGM8Fhe1gaM/1yc7c62WyAq2T4=
Date:   Mon, 10 Jun 2019 10:30:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 10/12] SIW completion queue methods
Message-ID: <20190610073047.GI6369@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-11-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-11-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:54PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_cq.c | 109 +++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
>
> diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
> new file mode 100644
> index 000000000000..e776e1b9273c
> --- /dev/null
> +++ b/drivers/infiniband/sw/siw/siw_cq.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
> +
> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> +/* Copyright (c) 2008-2019, IBM Corporation */
> +
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +
> +#include <rdma/iw_cm.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/ib_smi.h>
> +#include <rdma/ib_user_verbs.h>
> +
> +#include "siw.h"
> +#include "siw_cm.h"
> +#include "siw_debug.h"
> +
> +static int map_wc_opcode[SIW_NUM_OPCODES] = {
> +	[SIW_OP_WRITE] = IB_WC_RDMA_WRITE,
> +	[SIW_OP_SEND] = IB_WC_SEND,
> +	[SIW_OP_SEND_WITH_IMM] = IB_WC_SEND,
> +	[SIW_OP_READ] = IB_WC_RDMA_READ,
> +	[SIW_OP_READ_LOCAL_INV] = IB_WC_RDMA_READ,
> +	[SIW_OP_COMP_AND_SWAP] = IB_WC_COMP_SWAP,
> +	[SIW_OP_FETCH_AND_ADD] = IB_WC_FETCH_ADD,
> +	[SIW_OP_INVAL_STAG] = IB_WC_LOCAL_INV,
> +	[SIW_OP_REG_MR] = IB_WC_REG_MR,
> +	[SIW_OP_RECEIVE] = IB_WC_RECV,
> +	[SIW_OP_READ_RESPONSE] = -1 /* not used */
> +};
> +
> +static struct {
> +	enum siw_opcode siw;
> +	enum ib_wc_status ib;
> +} map_cqe_status[SIW_NUM_WC_STATUS] = {
> +	{ SIW_WC_SUCCESS, IB_WC_SUCCESS },
> +	{ SIW_WC_LOC_LEN_ERR, IB_WC_LOC_LEN_ERR },
> +	{ SIW_WC_LOC_PROT_ERR, IB_WC_LOC_PROT_ERR },
> +	{ SIW_WC_LOC_QP_OP_ERR, IB_WC_LOC_QP_OP_ERR },
> +	{ SIW_WC_WR_FLUSH_ERR, IB_WC_WR_FLUSH_ERR },
> +	{ SIW_WC_BAD_RESP_ERR, IB_WC_BAD_RESP_ERR },
> +	{ SIW_WC_LOC_ACCESS_ERR, IB_WC_LOC_ACCESS_ERR },
> +	{ SIW_WC_REM_ACCESS_ERR, IB_WC_REM_ACCESS_ERR },
> +	{ SIW_WC_REM_INV_REQ_ERR, IB_WC_REM_INV_REQ_ERR },
> +	{ SIW_WC_GENERAL_ERR, IB_WC_GENERAL_ERR }
> +};
> +
> +/*
> + * Reap one CQE from the CQ. Only used by kernel clients
> + * during CQ normal operation. Might be called during CQ
> + * flush for user mapped CQE array as well.
> + */
> +int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
> +{
> +	struct siw_cqe *cqe;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cq->lock, flags);
> +
> +	cqe = &cq->queue[cq->cq_get % cq->num_cqe];

Safer to ensure that cq_get is always in range, instead of performing
modulo for accesses.

> +	if (READ_ONCE(cqe->flags) & SIW_WQE_VALID) {
> +		memset(wc, 0, sizeof(*wc));
> +		wc->wr_id = cqe->id;
> +		wc->status = map_cqe_status[cqe->status].ib;
> +		wc->opcode = map_wc_opcode[cqe->opcode];
> +		wc->byte_len = cqe->bytes;
> +
> +		/*
> +		 * During CQ flush, also user land CQE's may get
> +		 * reaped here, which do not hold a QP reference
> +		 * and do not qualify for memory extension verbs.
> +		 */
> +		if (likely(cq->kernel_verbs)) {

Let's try to find a way without "kernel_verbs" variable.

> +			if (cqe->flags & SIW_WQE_REM_INVAL) {
> +				wc->ex.invalidate_rkey = cqe->inval_stag;
> +				wc->wc_flags = IB_WC_WITH_INVALIDATE;
> +			}
> +			wc->qp = cqe->base_qp;
> +			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
> +				   cq->cq_get % cq->num_cqe, cqe->opcode,
> +				   cqe->flags, (void *)cqe->id);
> +		}
> +		WRITE_ONCE(cqe->flags, 0);
> +		cq->cq_get++;
> +
> +		spin_unlock_irqrestore(&cq->lock, flags);
> +
> +		return 1;
> +	}
> +	spin_unlock_irqrestore(&cq->lock, flags);
> +
> +	return 0;
> +}
> +
> +/*
> + * siw_cq_flush()
> + *
> + * Flush all CQ elements.
> + */
> +void siw_cq_flush(struct siw_cq *cq)
> +{
> +	struct ib_wc wc;
> +
> +	siw_dbg_cq(cq, "enter\n");

No "enter" prints, please.

> +
> +	while (siw_reap_cqe(cq, &wc))
> +		;
> +}
> --
> 2.17.2
>
