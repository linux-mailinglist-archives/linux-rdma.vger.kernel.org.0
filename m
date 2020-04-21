Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA641B25CD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDUMUe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 08:20:34 -0400
Received: from verein.lst.de ([213.95.11.211]:46396 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUMUe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 08:20:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 92A6668C4E; Tue, 21 Apr 2020 14:20:30 +0200 (CEST)
Date:   Tue, 21 Apr 2020 14:20:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: Re: [PATCH 08/17] nvme-rdma: add metadata/T10-PI support
Message-ID: <20200421122030.GI26432@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-10-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-10-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 08:15:36PM +0300, Max Gurtovoy wrote:
> For capable HCAs (e.g. ConnectX-5/ConnectX-6) this will allow end-to-end
> protection information passthrough and validation for NVMe over RDMA
> transport. Metadata offload support was implemented over the new RDMA
> signature verbs API and it is enabled per controller by using nvme-cli.
> 
> usage example:
> nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> ---
>  drivers/nvme/host/rdma.c | 330 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 296 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index e38f8f7..23cc77e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -67,6 +67,9 @@ struct nvme_rdma_request {
>  	struct ib_cqe		reg_cqe;
>  	struct nvme_rdma_queue  *queue;
>  	struct nvme_rdma_sgl	data_sgl;
> +	/* Metadata (T10-PI) support */
> +	struct nvme_rdma_sgl	*md_sgl;
> +	bool			use_md;

Do we need a use_md flag vs just using md_sgl as a boolean and/or
using blk_integrity_rq?

>  enum nvme_rdma_queue_flags {
> @@ -88,6 +91,7 @@ struct nvme_rdma_queue {
>  	struct rdma_cm_id	*cm_id;
>  	int			cm_error;
>  	struct completion	cm_done;
> +	bool			pi_support;

Why do we need this on a per-queue basis vs always checking the
controller?

> +	u32 max_page_list_len =
> +		pi_support ? ibdev->attrs.max_pi_fast_reg_page_list_len :
> +			     ibdev->attrs.max_fast_reg_page_list_len;
> +
> +	return min_t(u32, NVME_RDMA_MAX_SEGMENTS, max_page_list_len - 1);

Can you use a good old if / else here?

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
> +		struct nvme_command *cmd, struct ib_sig_domain *domain,
> +		u16 control)
>  {
> +	domain->sig_type = IB_SIG_TYPE_T10_DIF;
> +	domain->sig.dif.bg_type = IB_T10DIF_CRC;
> +	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
> +	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
>  
>  	/*
> +	 * At the moment we hard code those, but in the future
> +	 * we will take them from cmd.

I don't understand this comment.  Also it doesn't use up all 80 chars.


> +static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
> +		struct nvme_command *cmd, struct ib_sig_attrs *sig_attrs)
> +{
> +	u16 control = le16_to_cpu(cmd->rw.control);
> +
> +	WARN_ON(bi == NULL);

I think this WARN_ON is pointless, as we'll get a NULL pointer derference
a little later anyway.

> +mr_put:
> +	if (req->use_md)
> +		ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
> +	else
> +		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);

I've seen this patterns a few times, maybe a little helper to return
the right mr pool for a request?

> +	if (blk_integrity_rq(rq)) {
> +		memset(req->md_sgl, 0, sizeof(struct nvme_rdma_sgl));

Why do we need this memset?
