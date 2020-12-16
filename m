Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F095E2DBAA7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 06:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgLPFeF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 00:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLPFeF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Dec 2020 00:34:05 -0500
Date:   Wed, 16 Dec 2020 07:33:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608096804;
        bh=TiSBf5w2tXdsmwrHWZAnYD9B5JYVKhkRA1G+th2aN20=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9QY0zNxJK5JkrU+uV0xcKftRAX/07zfhU0aj7HTzgKkTIS5d3fRrQaDAUALfFjI0
         DfM1VzjKL5h1wDViFhkOkRHljSLaH8xQ174LYKDjA3ap7g8wq0VtGLRGFt45iKyQpf
         kenmHLLhFotNaV6NKTMGK+sjNVjN062vHZcULgXQajcDWteFyr1RFnMAO5RpT6mOsy
         ySYSaGMggkNw+dwHM0g/3ZewPoOHTyV0u9/73baqU+uaQjxxgLRbSrMRwLlF2c4ijV
         dbeC6cl0b9uHRHJoNYfVBukXGN1wDuSwmu8gmdoWrBc1DO/N68JIrF+DPIn8O88KUq
         slQjqF5oysSNQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, kamalheib1@gmail.com,
        yi.zhang@redhat.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20201216053320.GO5005@unreal>
References: <20201215122306.3886-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215122306.3886-1-bmt@zurich.ibm.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 15, 2020 at 01:23:06PM +0100, Bernard Metzler wrote:
> During connection setup, the application may choose to zero-size
> inbound and outbound READ queues, as well as the Receive queue.
> This patch fixes handling of zero-sized queues.
>
> Reported-by: Kamal Heib <kamalheib1@gmail.com>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 54 ++++++++++++++++-----------
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++++++----
>  drivers/infiniband/sw/siw/siw_qp_tx.c |  4 +-
>  drivers/infiniband/sw/siw/siw_verbs.c | 18 +++++++--
>  5 files changed, 68 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index e9753831ac3f..6f17392f975a 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -654,7 +654,7 @@ static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
>  {
>  	struct siw_sqe *orq_e = orq_get_tail(qp);
>
> -	if (orq_e && READ_ONCE(orq_e->flags) == 0)
> +	if (READ_ONCE(orq_e->flags) == 0)
>  		return orq_e;
>
>  	return NULL;
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
> index 875d36d4b1c6..b686a09a75ae 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -199,26 +199,28 @@ void siw_qp_llp_write_space(struct sock *sk)
>
>  static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
>  {
> -	irq_size = roundup_pow_of_two(irq_size);
> -	orq_size = roundup_pow_of_two(orq_size);
> -
> -	qp->attrs.irq_size = irq_size;
> -	qp->attrs.orq_size = orq_size;
> -
> -	qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
> -	if (!qp->irq) {
> -		siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);
> -		qp->attrs.irq_size = 0;
> -		return -ENOMEM;
> +	if (irq_size) {
> +		irq_size = roundup_pow_of_two(irq_size);
> +		qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
> +		if (!qp->irq) {
> +			siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);

Please don't copy prints after kernel allocators. You won't miss failure
in allocations.

Thanks
