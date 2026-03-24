Return-Path: <linux-rdma+bounces-18559-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IHtHy5CwmmCagQAu9opvQ
	(envelope-from <linux-rdma+bounces-18559-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 08:50:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD45304274
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7749930570F7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 07:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6E344024;
	Tue, 24 Mar 2026 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KROC2JMp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C80320A14;
	Tue, 24 Mar 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338325; cv=none; b=ODn2XtaMEWNZW4kIzpZZXSIX7b5H+2M0S2/+62ubbGaHH4ArWA9AyQjYqmV3hcHmoKCA/8jUc6D6iYkstU+j3ucZuaOIyVCF+eV7gamQa+LtiJG6QLDu0q+Iv9azZk60j/TM+QUt1tiAsbn0yXAujC7cJTU8hpmAw9+nPZfcBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338325; c=relaxed/simple;
	bh=w7aSu3hEUiDumjA3EwakxvKSJQA92CEO6cfhnLNuU2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+Tc8Pf4/hkrJTbBsPGpB1rz6JEkuoaCR3olJWLxs4yHmodvQ+TZtfeI7RNCIJEx+GAuxexdPJKDzVPa+OU8IICNoGOlSCV3JzIgiK+XJHgdzegS4ZvzbvAofuE2VMQ6+y7qfmWqwlJdeCSF6Sc36V5i7V3l83uZIvhpZeBNgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KROC2JMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2A7C19424;
	Tue, 24 Mar 2026 07:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774338324;
	bh=w7aSu3hEUiDumjA3EwakxvKSJQA92CEO6cfhnLNuU2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KROC2JMpwnNJNnNv9ctBUFh+0mbCJT08QnNlnxUKcUSX7tO1lWfoAxilm0BVDj01P
	 qGoTmMuoh7nYVkmDLJiYMQjRCi8ADg54A7q6C8vfvT+2OiZ5Uo16UPWwQ0QW10QGpd
	 KEHaPZfVMgF1UsSCVEoJZn+IxrGp00gZp1WyCloSFN9SOv4bMQV96utkh149J+cseI
	 xvAvMKg4IqdXy8XwuPokj12Nkg3bjsEDmj2Ipkb19wVPZ2pqntVBJ64V2c2ojplltP
	 jWXlNJay7PWJohU3fuENgeYBWRywZvsKgesjOubPwKJWBQBROK2TvYw33UuTj+8QFL
	 xKErDv9LyjPgA==
Date: Tue, 24 Mar 2026 09:45:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: krzysztof.czurylo@intel.com, tatyana.e.nikolova@intel.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: validate AEQ QP and CQ indices
Message-ID: <20260324074518.GK814676@unreal>
References: <20260324014459.93348-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324014459.93348-1-pengpeng@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18559-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBD45304274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:44:59AM +0800, Pengpeng Hou wrote:
> irdma_process_aeq() trusts the QP/CQ identifier decoded from the
> hardware AEQE and uses it to index rf->qp_table[] and rf->cq_table[]
> without first checking that the identifier fits the allocated table.

HW should be programmed to provide valid index.

Thanks

> 
> Reject AEQ entries whose QP or CQ ids fall outside rf->max_qp or
> rf->max_cq before touching the tables. This keeps malformed or stale
> hardware event records from walking past the end of the driver-owned
> resource arrays.
> ---
>  drivers/infiniband/hw/irdma/hw.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index f4ae530f56db..32d7ac7d3885 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -313,6 +313,13 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
>  			  info->iwarp_state, info->ae_src);
>  
>  		if (info->qp) {
> +			if (unlikely(info->qp_cq_id >= rf->max_qp)) {
> +				ibdev_warn_ratelimited(&iwdev->ibdev,
> +						       "AEQ reported invalid QP id %u\n",
> +						       info->qp_cq_id);
> +				continue;
> +			}
> +
>  			spin_lock_irqsave(&rf->qptable_lock, flags);
>  			iwqp = rf->qp_table[info->qp_cq_id];
>  			if (!iwqp) {
> @@ -413,6 +420,13 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
>  				  "Processing an iWARP related AE for CQ misc = 0x%04X\n",
>  				  info->ae_id);
>  
> +			if (unlikely(info->qp_cq_id >= rf->max_cq)) {
> +				ibdev_warn_ratelimited(&iwdev->ibdev,
> +						       "AEQ reported invalid CQ id %u\n",
> +						       info->qp_cq_id);
> +				continue;
> +			}
> +
>  			spin_lock_irqsave(&rf->cqtable_lock, flags);
>  			iwcq = rf->cq_table[info->qp_cq_id];
>  			if (!iwcq) {
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

