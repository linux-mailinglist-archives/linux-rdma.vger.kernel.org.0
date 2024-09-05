Return-Path: <linux-rdma+bounces-4768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB296D60B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B2D285691
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6951990DB;
	Thu,  5 Sep 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnek6//t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A751198E83
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531948; cv=none; b=CaSKUzC13XaWrfioh+Fl1V/rEcREQVsxMqKrhI61SNXOtxO8uR4orBc0IHvERON5Ni0rvRJnzLrJpu9lhEzgl2N4aE6jU+5Yyucha2pCOng1+nHdQpozFa5BtqlEOdCFFd6aS3tnIJ4hSqanUxduqUfO1d0Xkrd6MW+c6o1Mfw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531948; c=relaxed/simple;
	bh=NK0lQCw+boB3+Le0/Psvjp0J6Ldnn/oqgIPHidOQ2k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ4HSXQS+T/p2hjHbrKVFLShSU7UVVfx5XoH3W5G+gkhO/2y1i+i2B7CwwzEACc27JPnpQ3nndlUyUxa1KsRuO8JqMF1tC7ncNl3UPZFLgtq2xItPIyDjeSshiYXknrFmnnGEKgn47zfg9+ELc1kqho8Td+lPB1i23zhBbT83SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnek6//t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA5BC4CEC3;
	Thu,  5 Sep 2024 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725531948;
	bh=NK0lQCw+boB3+Le0/Psvjp0J6Ldnn/oqgIPHidOQ2k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnek6//tfHSU3xNFFZXMK52DVaPhWP1wdi0pKuFEystxSy+CqD8OzydU6hT8Ur3k/
	 OViJzmA34OYN/XpadsdkTff+E6+F2MBCQtvG4r+OTu8as8/5rCpHhvUqkm6ERZdJ+7
	 uZvim12ZVIsSZJeQR1Wc+C7McYPNo44inBjWGo3wFAsRvgNCH0cBtlWgrFgO2k7SNM
	 Qml5XH7x/lRhj0BCblixmAX71P+xv9n9gQTbBzhiwPj3nlg3L6ERzcF6iVdfDAlTJh
	 arsbWQsnwbOPHC2ai98uxGDd5fpD5kqn/n9poX1JJU+At7OKJLdsv/Rkp4VPwQBCu2
	 R+09vTlAuhY8w==
Date: Thu, 5 Sep 2024 13:25:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH for-next 1/4] RDMA/bnxt_re: Add FW async event support in
 driver
Message-ID: <20240905102543.GS4026@unreal>
References: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
 <1725363051-19268-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725363051-19268-2-git-send-email-selvin.xavier@broadcom.com>

On Tue, Sep 03, 2024 at 04:30:48AM -0700, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Using the option provided by L2 driver, register for FW Async
> event. Provide the ulp hook 'ulp_async_notifier' for receiving
> the events for L2 driver.
> 
> Async events will be handled in follow on patches.
> 
> CC: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  1 +
>  drivers/infiniband/hw/bnxt_re/main.c          | 47 +++++++++++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 31 ++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  1 +
>  5 files changed, 81 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index 2be9a62..b2ed557 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -198,6 +198,7 @@ struct bnxt_re_dev {
>  	struct delayed_work dbq_pacing_work;
>  	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
>  	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
> +	unsigned long			event_bitmap;
>  };
>  
>  #define to_bnxt_re_dev(ptr, member)	\
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 16a84ca..0f86a34 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -300,6 +300,20 @@ static void bnxt_re_shutdown(struct auxiliary_device *adev)
>  	bnxt_re_dev_uninit(rdev);
>  }
>  
> +static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *cmpl)
> +{
> +	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
> +	u32 data1, data2;
> +	u16 event_id;
> +
> +	event_id = le16_to_cpu(cmpl->event_id);
> +	data1 = le32_to_cpu(cmpl->event_data1);
> +	data2 = le32_to_cpu(cmpl->event_data2);
> +
> +	ibdev_dbg(&rdev->ibdev, "Async event_id = %d data1 = %d data2 = %d",
> +		  event_id, data1, data2);
> +}
> +
>  static void bnxt_re_stop_irq(void *handle)
>  {
>  	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
> @@ -358,6 +372,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
>  }
>  
>  static struct bnxt_ulp_ops bnxt_re_ulp_ops = {
> +	.ulp_async_notifier = bnxt_re_async_notifier,
>  	.ulp_irq_stop = bnxt_re_stop_irq,
>  	.ulp_irq_restart = bnxt_re_start_irq
>  };
> @@ -1518,6 +1533,34 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
>  	return 0;
>  }
>  
> +static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rdev)
> +{
> +	int rc;
> +
> +	if (rdev->is_virtfn)
> +		return;
> +
> +	memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
> +	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
> +					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
> +	if (rc)
> +		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
> +}
> +
> +static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
> +{
> +	int rc;
> +
> +	if (rdev->is_virtfn)
> +		return;
> +
> +	rdev->event_bitmap |= (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
> +	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
> +					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
> +	if (rc)
> +		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
> +}
> +
>  static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
>  {
>  	struct bnxt_en_dev *en_dev = rdev->en_dev;
> @@ -1580,6 +1623,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
>  	u8 type;
>  	int rc;
>  
> +	bnxt_re_net_unregister_async_event(rdev);
> +
>  	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
>  		cancel_delayed_work_sync(&rdev->worker);
>  
> @@ -1776,6 +1821,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
>  	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
>  		hash_init(rdev->srq_hash);
>  
> +	bnxt_re_net_register_async_event(rdev);
> +
>  	return 0;
>  free_sctx:
>  	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 04a623b3..2c82a2e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2787,6 +2787,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
>  	}
>  	__bnxt_queue_sp_work(bp);
>  async_event_process_exit:
> +	bnxt_ulp_async_events(bp, cmpl);
>  	return 0;
>  }
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index b9e7d3e..9a55b06 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -339,6 +339,37 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
>  	}
>  }
>  
> +void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
> +{
> +	u16 event_id = le16_to_cpu(cmpl->event_id);
> +	struct bnxt_en_dev *edev = bp->edev;
> +	struct bnxt_ulp_ops *ops;
> +	struct bnxt_ulp *ulp;
> +
> +	if (!bnxt_ulp_registered(edev))
> +		return;
> +	ulp = edev->ulp_tbl;
> +
> +	rcu_read_lock();
> +
> +	ops = rcu_dereference(ulp->ulp_ops);
> +	if (!ops || !ops->ulp_async_notifier)
> +		goto exit_unlock_rcu;
> +	if (!ulp->async_events_bmap || event_id > ulp->max_async_event_id)
> +		goto exit_unlock_rcu;
> +
> +	/* Read max_async_event_id first before testing the bitmap. */
> +	smp_rmb();
> +	if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)
> +		goto exit_unlock_rcu;

Isn't this racy with bnxt_ulp_stop()?

> +
> +	if (test_bit(event_id, ulp->async_events_bmap))
> +		ops->ulp_async_notifier(ulp->handle, cmpl);
> +exit_unlock_rcu:
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(bnxt_ulp_async_events);
> +
>  int bnxt_register_async_events(struct bnxt_en_dev *edev,
>  			       unsigned long *events_bmap,
>  			       u16 max_id)
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> index 4eafe6e..5bba0d7 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> @@ -28,6 +28,7 @@ struct bnxt_msix_entry {
>  };
>  
>  struct bnxt_ulp_ops {
> +	void (*ulp_async_notifier)(void *, struct hwrm_async_event_cmpl *);
>  	void (*ulp_irq_stop)(void *);
>  	void (*ulp_irq_restart)(void *, struct bnxt_msix_entry *);
>  };
> -- 
> 2.5.5
> 

