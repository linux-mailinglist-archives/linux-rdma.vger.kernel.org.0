Return-Path: <linux-rdma+bounces-18249-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI0yLjw4uWk8vgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18249-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:17:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EA2A897B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0669830C7ABB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547C371CF2;
	Tue, 17 Mar 2026 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXMuv6UZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F1B35DA6B
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745955; cv=none; b=rh1E0AAvsZpXTRK/iVorI8uIQNyCZEYcwOwnls0IJ9HjrZkKMt7JgU/wPJ+erVSQtOpEo7OhFpkL4MkDIQP/WEo52hpbH57BA+WQ5SlmrCWTEoVahzehxoQvrNDnxLf6mFuLnfyE+RdzKHIcCsP2ZwRf+8DzteMz5LttjTwr0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745955; c=relaxed/simple;
	bh=zVTqvJ0isfmzRCACmnpiyE0nT4GSg7xFLJrR3EcZWms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuWObdeJUn97izNnMQTmzANQpHNoU5HEUUt3XSMF16QkI6WRYDF81Ri0lNTOwO0/D9QWrq8w2eNcQeXbEOok/Ly2vsImSux6Estgu8D9a5SyU9cbHVkLLPWBa6zC9V8qGlPx2cxcuPyXaj+rbG4QzaEjDZX1YG90nh1w0QDT9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXMuv6UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6881FC4CEF7;
	Tue, 17 Mar 2026 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745955;
	bh=zVTqvJ0isfmzRCACmnpiyE0nT4GSg7xFLJrR3EcZWms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXMuv6UZDlewRNZhZ9mgeb3GN64fjPgSIydX7ORjeZoOUqdon7VlgjMIpnMHLc1gs
	 Ujc7OAuBHoSpG1kbDkHcUDVdqf0Q+xfH+5h2tmy70tiSlWzLFE14ceeI7DTuqbzXr5
	 0qi24tIUq1VqVAtNSwdzkZybDSnqjPTgeKTSoGgkWwX1e3Ag2N/lrfv1Fd9ZoMenN2
	 SGZYVd+qfPjR+awBw2D9e/TaNOrWMuMer33xdgfou9vq5VUtK6FENhW2+AC/hTMMTT
	 u7J+ZvSAVPrXUzibEnspz8ogA+XjuWGYnYM5NDSmym8ukZ6fne0UfUmh9X345IAHR+
	 +OEbtvg7aUnow==
Date: Tue, 17 Mar 2026 13:12:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
Subject: Re: [for-next 02/12] RDMA/irdma: Fix data race on
 cqp_request->request_done
Message-ID: <20260317111230.GW61385@unreal>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
 <20260316183949.261-3-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316183949.261-3-tatyana.e.nikolova@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18249-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E2EA2A897B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 01:39:39PM -0500, Tatyana Nikolova wrote:
> From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> 
> Changes type of request_done flag from bool to atomic_t to fix
> data race in irdma_complete_cqp_request / irdma_wait_event
> reported by KCSAN:

Again, this fix is wrong too.

Thanks

> 
> BUG: KCSAN: data-race in irdma_complete_cqp_request [irdma] / irdma_wait_event [irdma]
> 
> write (marked) to 0xffffa0bef390ad5c of 1 bytes by task 7761 on cpu 0:
>  irdma_complete_cqp_request+0x19/0x90 [irdma]
>  irdma_cqp_ce_handler+0x22d/0x290 [irdma]
>  cqp_compl_worker+0x1f/0x30 [irdma]
>  process_one_work+0x3dc/0x7c0
>  worker_thread+0xa6/0x6c0
>  kthread+0x17f/0x1c0
>  ret_from_fork+0x2c/0x50
> 
> read to 0xffffa0bef390ad5c of 1 bytes by task 28566 on cpu 3:
>  irdma_wait_event+0x242/0x390 [irdma]
>  irdma_handle_cqp_op+0x93/0x210 [irdma]
>  irdma_hw_modify_qp+0xe3/0x2f0 [irdma]
>  irdma_modify_qp_roce+0x13df/0x1630 [irdma]
>  ib_security_modify_qp+0x34a/0x640 [ib_core]
>  _ib_modify_qp+0x16b/0x620 [ib_core]
>  ib_modify_qp_with_udata+0x3c/0x50 [ib_core]
>  modify_qp+0x6e1/0x920 [ib_uverbs]
>  ib_uverbs_ex_modify_qp+0xa6/0xf0 [ib_uverbs]
>  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x16c/0x200 [ib_uverbs]
>  ib_uverbs_run_method+0x342/0x380 [ib_uverbs]
>  ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
>  ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
>  __x64_sys_ioctl+0xc3/0x100
>  do_syscall_64+0x3f/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> value changed: 0x00 -> 0x01
> 
> Fixes: f0842bb3d388 ("RDMA/irdma: Fix data race on CQP request done")
> Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c    | 2 +-
>  drivers/infiniband/hw/irdma/main.h  | 2 +-
>  drivers/infiniband/hw/irdma/utils.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index 6e0466ce83d1..3ba4809bc1ef 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -235,7 +235,7 @@ static void irdma_complete_cqp_request(struct irdma_cqp *cqp,
>  				       struct irdma_cqp_request *cqp_request)
>  {
>  	if (cqp_request->waiting) {
> -		WRITE_ONCE(cqp_request->request_done, true);
> +		atomic_set(&cqp_request->request_done, true);
>  		wake_up(&cqp_request->waitq);
>  	} else if (cqp_request->callback_fcn) {
>  		cqp_request->callback_fcn(cqp_request);
> diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
> index 3d49bd57bae7..e22160e2ba33 100644
> --- a/drivers/infiniband/hw/irdma/main.h
> +++ b/drivers/infiniband/hw/irdma/main.h
> @@ -167,7 +167,7 @@ struct irdma_cqp_request {
>  	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
>  	void *param;
>  	struct irdma_cqp_compl_info compl_info;
> -	bool request_done; /* READ/WRITE_ONCE macros operate on it */
> +	atomic_t request_done;
>  	bool waiting:1;
>  	bool dynamic:1;
>  	bool pending:1;
> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index ab8c5284d4be..f9c99c216a2c 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -480,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
>  	if (cqp_request->dynamic) {
>  		kfree(cqp_request);
>  	} else {
> -		WRITE_ONCE(cqp_request->request_done, false);
> +		atomic_set(&cqp_request->request_done, false);
>  		cqp_request->callback_fcn = NULL;
>  		cqp_request->waiting = false;
>  		cqp_request->pending = false;
> @@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
>  {
>  	if (cqp_request->waiting) {
>  		cqp_request->compl_info.error = true;
> -		WRITE_ONCE(cqp_request->request_done, true);
> +		atomic_set(&cqp_request->request_done, true);
>  		wake_up(&cqp_request->waitq);
>  	}
>  	wait_event_timeout(cqp->remove_wq,
> @@ -610,7 +610,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
>  	do {
>  		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
>  		if (wait_event_timeout(cqp_request->waitq,
> -				       READ_ONCE(cqp_request->request_done),
> +				       atomic_read(&cqp_request->request_done),
>  				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
>  			break;
>  
> -- 
> 2.31.1
> 

