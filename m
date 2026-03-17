Return-Path: <linux-rdma+bounces-18248-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICcTMks3uWnVvQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18248-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:13:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFF2A88CC
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1E0F3017AB8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0F3A7F5D;
	Tue, 17 Mar 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNEDWmFr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7283A4F57
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745910; cv=none; b=ZHGXUFefh3TCkmYJvS/S7mag2vjyjlJ1x27OrLYS/pBK9nN6cjc9tQy7P6plXfKBit4N+ucpct8AsoeXu/dzb5R5Day3tfAlpoV9jVNO+mEMoA7jP8+4l92h58l7C818ZWGZm6AV0KotCK1C0b8H2N3Zv1ffrcBLe9KFi6nckIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745910; c=relaxed/simple;
	bh=9GpSr+CM036Pf0nqirlHNcn4DMwLw8w+1TDyycfvG60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng0WFrXL0PYsATb2c4pD0KOWu48S36h1PGD1+5cJrBc20dWXhOyXGb61yvDA6pFowgz0slolQBNi8SY4uTN+lk6E3GHUkhWi5vKLY6FdX6kGKDtJq94RgeDykvmMImxm3h9F/WhYmFQ4Ldam817+vkKJXoAPBYGn/T/L++ZPjRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNEDWmFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8808C19425;
	Tue, 17 Mar 2026 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745910;
	bh=9GpSr+CM036Pf0nqirlHNcn4DMwLw8w+1TDyycfvG60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNEDWmFrI56splHlN1jCo+ZczygxVHUZtXC3uFT5+S/jeR2//Hcb5SUXXBf9ljpBF
	 NALttU1JTdfazVnM8nDfs5Z4WS/FR70qggBd5ZVvDvbpf9v8C6TQabTr7hCzdHiSsn
	 U8YtY3UdO+YdngXNH6jDJKBta18NMFLy9Fhei3JAD76UCK5CGLn4dSm4yGE+lvI5MP
	 1maGaKwAzF3vYgLwYw2vCXD4xQdz4KdE85sBOJqANEKn3h0mhqh1H5h/v3STUwvyEa
	 69aBuJ14QLTzrtbH8J89+ICqQTA+Y0FtgCwtf5GBceJDqvm8iTKXNDr4XK3IG7nD0G
	 YVL080G7SQP2A==
Date: Tue, 17 Mar 2026 13:11:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
Subject: Re: [for-next 03/12] RDMA/irdma: Change ah_valid type to atomic
Message-ID: <20260317111144.GV61385@unreal>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
 <20260316183949.261-4-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316183949.261-4-tatyana.e.nikolova@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18248-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D7FFF2A88CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 01:39:40PM -0500, Tatyana Nikolova wrote:
> From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> 
> Converts ah_valid flag to atomic to protect it against data-race.

Atomic operations don't prevent data races; they only guarantee that a
read or write happens atomically. Use the "xxx yyy:1" bitfield construct
only for fields that cannot be modified concurrently.

Thanks

> 
> [  809.561229] BUG: KCSAN: data-race in irdma_create_hw_ah [irdma] / irdma_gsi_ud_qp_ah_cb [irdma]
> 
> [  809.565182] write to 0xffff8d911c8eee73 of 1 bytes by task 38949 on cpu 10:
> [  809.567113]  irdma_gsi_ud_qp_ah_cb+0x41/0x60 [irdma]
> [  809.567343]  irdma_complete_cqp_request+0x44/0xb0 [irdma]
> [  809.567572]  irdma_cqp_ce_handler+0x242/0x290 [irdma]
> [  809.567810]  irdma_wait_event+0xf2/0x3c0 [irdma]
> 
> [  809.570951] read to 0xffff8d911c8eee73 of 1 bytes by task 38952 on cpu 7:
> [  809.573037]  irdma_create_hw_ah+0x1e7/0x370 [irdma]
> [  809.573265]  irdma_create_ah+0x61/0x70 [irdma]
> [  809.573491]  _rdma_create_ah+0x262/0x290 [ib_core]
> [  809.573831]  rdma_create_ah+0xa3/0x140 [ib_core]
> 
> [  809.576933] value changed: 0x06 -> 0x07
> [  809.581184] Reported by Kernel Concurrency Sanitizer
> 
> Fixes: dd90451fac23 ("RDMA/irdma: Add RoCEv2 UD OP support")
> Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/cm.c    |  2 +-
>  drivers/infiniband/hw/irdma/puda.c  |  2 +-
>  drivers/infiniband/hw/irdma/uda.h   |  2 +-
>  drivers/infiniband/hw/irdma/utils.c | 16 +++++++++-------
>  drivers/infiniband/hw/irdma/verbs.c |  7 ++++---
>  5 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
> index 3d084d4ff577..947fd93f5fb0 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -313,7 +313,7 @@ static struct irdma_puda_buf *irdma_form_ah_cm_frame(struct irdma_cm_node *cm_no
>  	u32 pd_len = 0;
>  	u32 hdr_len = 0;
>  
> -	if (!cm_node->ah || !cm_node->ah->ah_info.ah_valid) {
> +	if (!cm_node->ah || !atomic_read(&cm_node->ah->ah_info.ah_valid)) {
>  		ibdev_dbg(&cm_node->iwdev->ibdev, "CM: AH invalid\n");
>  		return NULL;
>  	}
> diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
> index 4f1a8c97faf1..3410be38f602 100644
> --- a/drivers/infiniband/hw/irdma/puda.c
> +++ b/drivers/infiniband/hw/irdma/puda.c
> @@ -1652,7 +1652,7 @@ static void irdma_ieq_handle_exception(struct irdma_puda_rsrc *ieq,
>  	}
>  	if (hw_rev == IRDMA_GEN_1)
>  		irdma_ieq_process_fpdus(qp, ieq);
> -	else if (pfpdu->ah && pfpdu->ah->ah_info.ah_valid)
> +	else if (pfpdu->ah && atomic_read(&pfpdu->ah->ah_info.ah_valid))
>  		irdma_ieq_process_fpdus(qp, ieq);
>  exit:
>  	spin_unlock_irqrestore(&pfpdu->lock, flags);
> diff --git a/drivers/infiniband/hw/irdma/uda.h b/drivers/infiniband/hw/irdma/uda.h
> index 27b8701cf21b..773c33ce62a2 100644
> --- a/drivers/infiniband/hw/irdma/uda.h
> +++ b/drivers/infiniband/hw/irdma/uda.h
> @@ -22,7 +22,7 @@ struct irdma_ah_info {
>  	u8 tc_tos;
>  	u8 hop_ttl;
>  	u8 mac_addr[ETH_ALEN];
> -	bool ah_valid:1;
> +	atomic_t ah_valid;
>  	bool ipv4_valid:1;
>  	bool do_lpbk:1;
>  };
> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index f9c99c216a2c..be2dc92d008f 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -1967,7 +1967,8 @@ int irdma_ah_cqp_op(struct irdma_pci_f *rf, struct irdma_sc_ah *sc_ah, u8 cmd,
>  		return -ENOMEM;
>  
>  	if (wait)
> -		sc_ah->ah_info.ah_valid = (cmd == IRDMA_OP_AH_CREATE);
> +		atomic_set(&sc_ah->ah_info.ah_valid,
> +			   (cmd == IRDMA_OP_AH_CREATE));
>  
>  	return 0;
>  }
> @@ -1984,10 +1985,10 @@ static void irdma_ieq_ah_cb(struct irdma_cqp_request *cqp_request)
>  
>  	spin_lock_irqsave(&qp->pfpdu.lock, flags);
>  	if (!cqp_request->compl_info.op_ret_val) {
> -		sc_ah->ah_info.ah_valid = true;
> +		atomic_set(&sc_ah->ah_info.ah_valid, true);
>  		irdma_ieq_process_fpdus(qp, qp->vsi->ieq);
>  	} else {
> -		sc_ah->ah_info.ah_valid = false;
> +		atomic_set(&sc_ah->ah_info.ah_valid, false);
>  		irdma_ieq_cleanup_qp(qp->vsi->ieq, qp);
>  	}
>  	spin_unlock_irqrestore(&qp->pfpdu.lock, flags);
> @@ -2002,7 +2003,8 @@ static void irdma_ilq_ah_cb(struct irdma_cqp_request *cqp_request)
>  	struct irdma_cm_node *cm_node = cqp_request->param;
>  	struct irdma_sc_ah *sc_ah = cm_node->ah;
>  
> -	sc_ah->ah_info.ah_valid = !cqp_request->compl_info.op_ret_val;
> +	atomic_set(&sc_ah->ah_info.ah_valid,
> +		   !cqp_request->compl_info.op_ret_val);
>  	irdma_add_conn_est_qh(cm_node);
>  }
>  
> @@ -2069,7 +2071,7 @@ void irdma_puda_free_ah(struct irdma_sc_dev *dev, struct irdma_sc_ah *ah)
>  	if (!ah)
>  		return;
>  
> -	if (ah->ah_info.ah_valid) {
> +	if (atomic_read(&ah->ah_info.ah_valid)) {
>  		irdma_ah_cqp_op(rf, ah, IRDMA_OP_AH_DESTROY, false, NULL, NULL);
>  		irdma_free_rsrc(rf, rf->allocated_ahs, ah->ah_info.ah_idx);
>  	}
> @@ -2086,9 +2088,9 @@ void irdma_gsi_ud_qp_ah_cb(struct irdma_cqp_request *cqp_request)
>  	struct irdma_sc_ah *sc_ah = cqp_request->param;
>  
>  	if (!cqp_request->compl_info.op_ret_val)
> -		sc_ah->ah_info.ah_valid = true;
> +		atomic_set(&sc_ah->ah_info.ah_valid, true);
>  	else
> -		sc_ah->ah_info.ah_valid = false;
> +		atomic_set(&sc_ah->ah_info.ah_valid, false);
>  }
>  
>  /**
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 38bc0e656ecf..9cfcdf7b053e 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -5116,8 +5116,8 @@ static int irdma_create_hw_ah(struct irdma_device *iwdev, struct irdma_ah *ah, b
>  
>  		if (poll_timeout_us_atomic(irdma_cqp_ce_handler(rf,
>  								&rf->ccq.sc_cq),
> -					   ah->sc_ah.ah_info.ah_valid, 1,
> -					   tmout_ms * USEC_PER_MSEC, false)) {
> +					   atomic_read(&ah->sc_ah.ah_info.ah_valid),
> +					   1, tmout_ms * USEC_PER_MSEC, false)) {
>  			ibdev_dbg(&iwdev->ibdev,
>  				  "VERBS: CQP create AH timed out");
>  			err = -ETIMEDOUT;
> @@ -5236,7 +5236,8 @@ static bool irdma_ah_exists(struct irdma_device *iwdev,
>  	hash_for_each_possible(iwdev->rf->ah_hash_tbl, ah, list, key) {
>  		/* Set ah_valid and ah_id the same so memcmp can work */
>  		new_ah->sc_ah.ah_info.ah_idx = ah->sc_ah.ah_info.ah_idx;
> -		new_ah->sc_ah.ah_info.ah_valid = ah->sc_ah.ah_info.ah_valid;
> +		atomic_set(&new_ah->sc_ah.ah_info.ah_valid,
> +			   atomic_read(&ah->sc_ah.ah_info.ah_valid));
>  		if (!memcmp(&ah->sc_ah.ah_info, &new_ah->sc_ah.ah_info,
>  			    sizeof(ah->sc_ah.ah_info))) {
>  			refcount_inc(&ah->refcnt);
> -- 
> 2.31.1
> 

