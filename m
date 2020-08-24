Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7427F2508A2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHXTBq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 15:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgHXTBp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 15:01:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B7D2074D;
        Mon, 24 Aug 2020 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598295705;
        bh=mpGX6hLqsoqx2+JAkLXJnHAtWfaEjL3lrZU8fBbcBSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deXfm0hgBieW/R04v79zTFAcga4Y6fGO/e1KKUGQgiIoAs2XnPo82NYTOMD181j6I
         LcqHbBYgFaDNubM5SCdDV+vDJ0sTxB66j+ymcbdUOW8SC+SkRVQQFmmiXZXHukxfzZ
         o1k320tym0QmyOMd4hhpD+als+gh/8pSwn5tb4a4=
Date:   Mon, 24 Aug 2020 22:01:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 1/6] RDMA/bnxt_re: Remove the qp from list only if
 the qp destroy succeeds
Message-ID: <20200824190141.GL571722@unreal>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
 <1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 11:14:31AM -0700, Selvin Xavier wrote:
> Driver crashes when destroy_qp is re-tried because of an
> error returned. This is because the qp entry was  removed
> from the qp list during the first call.

How is it possible that destroy_qp fail?

>
> Remove qp from the list only if destroy_qp returns success.
>
> Fixes: 8dae419f9ec7 ("RDMA/bnxt_re: Refactor queue pair creation code")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 3f18efc..2f5aac0 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -752,12 +752,6 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
>  	gsi_sqp = rdev->gsi_ctx.gsi_sqp;
>  	gsi_sah = rdev->gsi_ctx.gsi_sah;
>
> -	/* remove from active qp list */
> -	mutex_lock(&rdev->qp_lock);
> -	list_del(&gsi_sqp->list);
> -	mutex_unlock(&rdev->qp_lock);
> -	atomic_dec(&rdev->qp_count);
> -
>  	ibdev_dbg(&rdev->ibdev, "Destroy the shadow AH\n");
>  	bnxt_qplib_destroy_ah(&rdev->qplib_res,
>  			      &gsi_sah->qplib_ah,
> @@ -772,6 +766,12 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
>  	}
>  	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
>
> +	/* remove from active qp list */
> +	mutex_lock(&rdev->qp_lock);
> +	list_del(&gsi_sqp->list);
> +	mutex_unlock(&rdev->qp_lock);
> +	atomic_dec(&rdev->qp_count);
> +
>  	kfree(rdev->gsi_ctx.sqp_tbl);
>  	kfree(gsi_sah);
>  	kfree(gsi_sqp);
> @@ -792,11 +792,6 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
>  	unsigned int flags;
>  	int rc;
>
> -	mutex_lock(&rdev->qp_lock);
> -	list_del(&qp->list);
> -	mutex_unlock(&rdev->qp_lock);
> -	atomic_dec(&rdev->qp_count);
> -
>  	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
>
>  	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
> @@ -819,6 +814,11 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
>  			goto sh_fail;
>  	}
>
> +	mutex_lock(&rdev->qp_lock);
> +	list_del(&qp->list);
> +	mutex_unlock(&rdev->qp_lock);
> +	atomic_dec(&rdev->qp_count);
> +
>  	ib_umem_release(qp->rumem);
>  	ib_umem_release(qp->sumem);
>
> --
> 2.5.5
>
