Return-Path: <linux-rdma+bounces-14717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8960C81A41
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 17:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B89324E5B23
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68F82BDC01;
	Mon, 24 Nov 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrIiqskb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A612BD013;
	Mon, 24 Nov 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002665; cv=none; b=M4/WNnxRIhb6f/DDn64iEKnvI6H+JVBjL4a0Pq4CsSJBrN3AurdB9/c+LOzdBe3iL0SXTJtpgxkM1j3Ex6slNZ1bmyMIqrb9R/CKT+usW9ayeAySeA275JPC3y4XWEWXYAgdygnjmxUeCK+Xp+kCu1KwoFBTpYOZjvA/b8h9yRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002665; c=relaxed/simple;
	bh=VfRk0Gq4weG8EQRxjLjNBEfFFt3k0AUt+s0lMf2o0hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7uasH/LtOEdk2ArpIc7fY4JlTSr/5c+nZ03B7JY25xCwetYD+N/Me9yt8pqGKrsdnZtHgqyMF2AculjNX7BeFontSPKPfMrLdr15S4KGW1cHM6ReegmQCU4t77z4kOTiBp40EwnU5/mlc5507J0q+cNsSrciF0cwzEhnlggkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrIiqskb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63399C116D0;
	Mon, 24 Nov 2025 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764002665;
	bh=VfRk0Gq4weG8EQRxjLjNBEfFFt3k0AUt+s0lMf2o0hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrIiqskbY03moY5cHsHXsAToElIwprLNpiQ+z5nnrLJE96R9GHunJqoIsoQs07332
	 2Mf6HSqvULegeDOA+GfnKVg/H65Bta/Sd6pABJlIBGcvSx+MEtA+M0w+nVYmI41pgO
	 6pHV+8hGozm+dXR+cJE9rw53Kwo28wITOvR6gUbqLuhvBbbwwtyqrWWa7LoNUBYICy
	 7zvZg6jx6vUwAlarHdmDpIoJgdi/4L5afPCrkAXlweWn9h68zoAPky60RxTvQJv7kp
	 gvAdDjFX0G2FqSifT1ia/XqIxztDl4cODrG2vkUIAM1nIK1v2BP2rOOYhyL0SAcfsk
	 ZhLy38utKKbBw==
Date: Mon, 24 Nov 2025 16:44:21 +0000
From: Simon Horman <horms@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com, anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com
Subject: Re: [PATCH v3 5/8] RDMA/bng_re: Add infrastructure for enabling
 Firmware channel
Message-ID: <aSSLZZM4vgG_SZcm@horms.kernel.org>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
 <20251117171136.128193-6-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117171136.128193-6-siva.kallam@broadcom.com>

On Mon, Nov 17, 2025 at 05:11:23PM +0000, Siva Reddy Kallam wrote:

...

> diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c

...

> @@ -105,6 +105,69 @@ static void bng_re_fill_fw_msg(struct bnge_fw_msg *fw_msg, void *msg,
>  	fw_msg->timeout = timeout;
>  }
>  
> +static int bng_re_net_ring_free(struct bng_re_dev *rdev,
> +				u16 fw_ring_id, int type)
> +{
> +	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;

Hi Siva,

rdev is dereferenced unconditionally here...

> +	struct hwrm_ring_free_input req = {};
> +	struct hwrm_ring_free_output resp;
> +	struct bnge_fw_msg fw_msg = {};
> +	int rc = -EINVAL;
> +
> +	if (!rdev)
> +		return rc;

... but it is assumed that rdev may be NULL here.

This does not seem consistent.

IMHO a good approach would be to drop this check, and the one below,
and only call bng_re_net_ring_free() in contexts where  rdev
and aux_dev are not NULL.

But I didn't look carefully to see if that idea matches the rest
of the code.

Flagged by Smatch.

> +
> +	if (!aux_dev)
> +		return rc;
> +
> +	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_FREE);
> +	req.ring_type = type;
> +	req.ring_id = cpu_to_le16(fw_ring_id);
> +	bng_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
> +			    sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
> +	rc = bnge_send_msg(aux_dev, &fw_msg);
> +	if (rc)
> +		ibdev_err(&rdev->ibdev, "Failed to free HW ring:%d :%#x",
> +			  req.ring_id, rc);
> +	return rc;
> +}

...

> diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c

...

> +static int bng_re_process_qp_event(struct bng_re_rcfw *rcfw,
> +				   struct creq_qp_event *qp_event,
> +				   u32 *num_wait)
> +{
> +	struct bng_re_hwq *hwq = &rcfw->cmdq.hwq;
> +	struct bng_re_crsqe *crsqe;
> +	u32 req_size;
> +	u16 cookie;
> +	bool is_waiter_alive;
> +	struct pci_dev *pdev;
> +	u32 wait_cmds = 0;
> +	int rc = 0;

rc is always 0, so it may be slightly nicer to remove this variable and
simply return 0.

Flagged by Coccinelle.

> +
> +	pdev = rcfw->pdev;
> +	switch (qp_event->event) {
> +	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
> +		dev_err(&pdev->dev, "Received QP error notification\n");
> +		break;
> +	default:
> +		/*
> +		 * Command Response
> +		 * cmdq->lock needs to be acquired to synchronie
> +		 * the command send and completion reaping. This function
> +		 * is always called with creq->lock held. Using
> +		 * the nested variant of spin_lock.
> +		 *
> +		 */
> +
> +		spin_lock_nested(&hwq->lock, SINGLE_DEPTH_NESTING);
> +		cookie = le16_to_cpu(qp_event->cookie);
> +		cookie &= BNG_FW_MAX_COOKIE_VALUE;
> +		crsqe = &rcfw->crsqe_tbl[cookie];
> +
> +		if (WARN_ONCE(test_bit(FIRMWARE_STALL_DETECTED,
> +				       &rcfw->cmdq.flags),
> +		    "Unreponsive rcfw channel detected.!!")) {
> +			dev_info(&pdev->dev,
> +				 "rcfw timedout: cookie = %#x, free_slots = %d",
> +				 cookie, crsqe->free_slots);
> +			spin_unlock(&hwq->lock);
> +			return rc;
> +		}
> +
> +		if (crsqe->is_waiter_alive) {
> +			if (crsqe->resp) {
> +				memcpy(crsqe->resp, qp_event, sizeof(*qp_event));
> +				/* Insert write memory barrier to ensure that
> +				 * response data is copied before clearing the
> +				 * flags
> +				 */
> +				smp_wmb();
> +			}
> +		}
> +
> +		wait_cmds++;
> +
> +		req_size = crsqe->req_size;
> +		is_waiter_alive = crsqe->is_waiter_alive;
> +
> +		crsqe->req_size = 0;
> +		if (!is_waiter_alive)
> +			crsqe->resp = NULL;
> +
> +		crsqe->is_in_used = false;
> +
> +		hwq->cons += req_size;
> +
> +		spin_unlock(&hwq->lock);
> +	}
> +	*num_wait += wait_cmds;
> +	return rc;
> +}

...

