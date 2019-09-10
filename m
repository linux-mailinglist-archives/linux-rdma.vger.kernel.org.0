Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4710EAE8F9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbfIJLSX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 07:18:23 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:51523 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403952AbfIJLSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 07:18:23 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8ABI2nd002030;
        Tue, 10 Sep 2019 04:18:03 -0700
Date:   Tue, 10 Sep 2019 16:48:02 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
Message-ID: <20190910111759.GA5472@chelsio.com>
References: <20190904212531.6488-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904212531.6488-1-sagi@grimberg.me>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wednesday, September 09/04/19, 2019 at 14:25:31 -0700, Sagi Grimberg wrote:
> This may be the final put on a qp and result in freeing
> resourcesand should not be done with interrupts disabled.

Hi Sagi,

Few things to consider in fixing this completely:
  - there are some other places where iw_rem_ref() should be called
    after spinlock critical section. eg: in cm_close_handler(),
iw_cm_connect(),...
  - Any modifications to "cm_id_priv" should be done with in spinlock
    critical section, modifying cm_id_priv->qp outside spinlocks, even
with atomic xchg(), might be error prone.
  - the structure "siw_base_qp" is getting freed in siw_destroy_qp(),
    but it should be done at the end of siw_free_qp().
  
I am about to finish writing a patch that cover all the above issues.
Will test it and submit here by EOD.

Regards,
Krishna.
> 
> Produce the following warning:
> --
> [  317.026048] WARNING: CPU: 1 PID: 443 at kernel/smp.c:425 smp_call_function_many+0xa0/0x260
> [  317.026131] Call Trace:
> [  317.026159]  ? load_new_mm_cr3+0xe0/0xe0
> [  317.026161]  on_each_cpu+0x28/0x50
> [  317.026183]  __purge_vmap_area_lazy+0x72/0x150
> [  317.026200]  free_vmap_area_noflush+0x7a/0x90
> [  317.026202]  remove_vm_area+0x6f/0x80
> [  317.026203]  __vunmap+0x71/0x210
> [  317.026211]  siw_free_qp+0x8d/0x130 [siw]
> [  317.026217]  destroy_cm_id+0xc3/0x200 [iw_cm]
> [  317.026222]  rdma_destroy_id+0x224/0x2b0 [rdma_cm]
> [  317.026226]  nvme_rdma_reset_ctrl_work+0x2c/0x70 [nvme_rdma]
> [  317.026235]  process_one_work+0x1f4/0x3e0
> [  317.026249]  worker_thread+0x221/0x3e0
> [  317.026252]  ? process_one_work+0x3e0/0x3e0
> [  317.026256]  kthread+0x117/0x130
> [  317.026264]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  317.026275]  ret_from_fork+0x35/0x40
> --
> 
> Fix this by exchanging the qp pointer early on and safely destroying
> it.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v2:
> - store the qp locally so we don't need to unlock the cm_id_priv lock when
>   destroying the qp
> 
> Changes from v1:
> - don't release the lock before qp pointer is cleared.
> 
>  drivers/infiniband/core/iwcm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index 72141c5b7c95..c64707f68d22 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -373,8 +373,10 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>  {
>  	struct iwcm_id_private *cm_id_priv;
>  	unsigned long flags;
> +	struct ib_qp *qp;
>  
>  	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> +	qp = xchg(&cm_id_priv->qp, NULL);
>  	/*
>  	 * Wait if we're currently in a connect or accept downcall. A
>  	 * listening endpoint should never block here.
> @@ -401,7 +403,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>  		cm_id_priv->state = IW_CM_STATE_DESTROYING;
>  		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>  		/* Abrupt close of the connection */
> -		(void)iwcm_modify_qp_err(cm_id_priv->qp);
> +		(void)iwcm_modify_qp_err(qp);
>  		spin_lock_irqsave(&cm_id_priv->lock, flags);
>  		break;
>  	case IW_CM_STATE_IDLE:
> @@ -426,11 +428,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>  		BUG();
>  		break;
>  	}
> -	if (cm_id_priv->qp) {
> -		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
> -		cm_id_priv->qp = NULL;
> -	}
>  	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> +	if (qp)
> +		cm_id_priv->id.device->ops.iw_rem_ref(qp);
>  
>  	if (cm_id->mapped) {
>  		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
> -- 
> 2.17.1
> 
