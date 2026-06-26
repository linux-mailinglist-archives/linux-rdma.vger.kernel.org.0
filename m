Return-Path: <linux-rdma+bounces-22483-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FnQ6NV7fPWqR7QgAu9opvQ
	(envelope-from <linux-rdma+bounces-22483-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 04:09:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C676C9A8D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 04:09:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FbgJLkDK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22483-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22483-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8791302AD2B
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198422E2DDD;
	Fri, 26 Jun 2026 02:07:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736201F09AD
	for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 02:07:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439656; cv=none; b=lJEqE8LeDphSCEg41TFDNeqSpsDkYsd/uI7PLhqguURwedqwP3SQDDRAoy3p9BDjgNRNskgPCK6vhqRTDg+ekZFmu3L5z4y+jHfe+UizPFPZMKBNAEJyB8h2TR85LNGz63nr1dd0NLLqfZxI6Kd/EAEbu6CYcPBoJW+v5v/Qj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439656; c=relaxed/simple;
	bh=1ihNJoT8/ZXc62I41MiabtaWrBjIF6/3qgFIsqKehL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWvhM/1GDWatcD8e87cKvFiAD6CPzr+WRZTVZgipwGyAbfhIS00hcTiWDm7+7a+54NLOpZJ+eUj5D6/kb31yXOqrEB2r1i1IoaKXhjbCNcpXQL4ZARmY+pK28DI/V70unudLaY0ehH73S/s+RVnK3ArdgcB4UD7Aiudj60zW0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FbgJLkDK; arc=none smtp.client-ip=91.218.175.174
Message-ID: <c94264a5-3078-4152-b38b-e20156c54068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782439653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbUtshgjGrpyDeVrPrLHX9g+whVL51wvLopZCYzLVVE=;
	b=FbgJLkDKmKdvo0opxclS+GcrnTAl07QSduRbE+NpRM0px1DEh+03Jyq9XLyXrywZOM0elb
	geWTBLr4cEyf5SCfTxpk7tOc1xXVgbQsd1KZG2M7Mi+NOuUhdzeaONMIijMFa09cpLiZkr
	aWXlM4rEzttwX51Nxx2p0dGkoLpSXzQ=
Date: Thu, 25 Jun 2026 19:07:29 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: Check PDs for memory window binds
To: Zhiwei Zhang <202275009@qq.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_FD4FB25AA4FFA845E63F5AC36CF4A46CDC0A@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_FD4FB25AA4FFA845E63F5AC36CF4A46CDC0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:202275009@qq.com,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:yanjun.zhu@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22483-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35C676C9A8D


在 2026/6/25 18:59, Zhiwei Zhang 写道:
> The IBTA Software Transport Verbs specification requires the QP,
> Memory Window and Memory Region for a Bind Memory Window operation
> to belong to the same HCA and protection domain.
>
> rxe only checked the QP and MW protection domain for type 2 MWs.
> Move the QP/MW PD check to the common bind path and also reject
> binding an MW to an MR from a different PD.
>
> Invalid bind requests continue to fail with IB_WC_MW_BIND_ERR.
>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Zhiwei Zhang <202275009@qq.com>


Thanks a lot. I am fine with this. Let us wait for the comments from 
Leon and Jason.

Zhu Yanjun


> ---
>   drivers/infiniband/sw/rxe/rxe_mw.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> index 379e65bfcd49..bddb7a257831 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -72,13 +72,6 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>   			return -EINVAL;
>   		}
>   
> -		/* C10-72 */
> -		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
> -			rxe_dbg_mw(mw,
> -				"attempt to bind type 2 MW with qp with different PD\n");
> -			return -EINVAL;
> -		}
> -
>   		/* o10-37.2.40 */
>   		if (unlikely(!mr || wqe->wr.wr.mw.length == 0)) {
>   			rxe_dbg_mw(mw,
> @@ -87,10 +80,21 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>   		}
>   	}
>   
> -	/* remaining checks only apply to a nonzero MR */
> +	/* C10-72 */
> +	if (unlikely(qp->pd != rxe_mw_pd(mw))) {
> +		rxe_dbg_mw(mw, "attempt to bind MW with qp with different PD\n");
> +		return -EINVAL;
> +	}
> +
>   	if (!mr)
>   		return 0;
>   
> +	/* remaining checks only apply to a nonzero MR */
> +	if (unlikely(qp->pd != mr_pd(mr))) {
> +		rxe_dbg_mw(mw, "attempt to bind MW/QP to MR with different PD\n");
> +		return -EINVAL;
> +	}
> +
>   	if (unlikely(mr->access & IB_ZERO_BASED)) {
>   		rxe_dbg_mw(mw, "attempt to bind MW to zero based MR\n");
>   		return -EINVAL;

-- 
Best Regards,
Yanjun.Zhu


