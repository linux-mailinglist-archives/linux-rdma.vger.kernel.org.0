Return-Path: <linux-rdma+bounces-22497-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IKycKrYqP2qKPgkAu9opvQ
	(envelope-from <linux-rdma+bounces-22497-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 03:43:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150F6D0BA7
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 03:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=aCYVI7Tf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22497-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22497-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82F7630442B4
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E8233D9E;
	Sat, 27 Jun 2026 01:42:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBA1862;
	Sat, 27 Jun 2026 01:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524569; cv=none; b=u8cGPkTqbL+Qkpfl8YzsyvNPdWiKP0NYEu0mVA28TfIG16ss+TG///+IrTzIjYttNRhgjwkzfWuw7yX5TjpM8nofBXkAKTCob5LFXIF4fF6TUa9jwIuyE9SUvY2KS/HBpCd3UD604Wba3WzhQ35HlaF6M0mxgjuDdns0TAXZKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524569; c=relaxed/simple;
	bh=lNULF0cbakZd5bZsxfAJJgCv9LuU971xnkp9Vm7kvc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7oFGuYByd2j7tmD7R948XK/yjIEW4sYRUoCq6eKwhYbBDENuPBArw7mYvEAhhO59NtYF07YTAyE8kLnnjTLawv4SL0gullKOKYq8ayjyPhJqRbWpbS4WhV9SK/IqLrauGb96Ilqf4eDqEF59Ef43KCb0ZRICi0AweKjwhST4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aCYVI7Tf; arc=none smtp.client-ip=91.218.175.172
Message-ID: <c219948e-1fd3-4bcf-8e38-0db3bfa49a6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782524563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlzbEEPFkI8YXipnBhrBx9G63SGgQCK8o/0VhjizDa0=;
	b=aCYVI7Tfmk1fQ+V4Ov9FsjSAnr8ngdQbCYTV96WavSEdbK4OKG2CILm/kentEEdhnc4iW7
	cePfwQNrZyEPGpkjb51WkTWVl9durhStdQUWamgyX7X0Rpeudnk2p+O+PP4DANoPbbLVyT
	May9DtNzRf+srBqfwlNEFq51M7+w03U=
Date: Fri, 26 Jun 2026 18:42:40 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fix: infiniband/rxe: check_rkey: fix refcount underflow
 due to unchecked rxe_get return value
To: WenTao Liang <vulab@iscas.ac.cn>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260626150511.50084-1-vulab@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260626150511.50084-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22497-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1150F6D0BA7

On 6/26/26 8:05 AM, WenTao Liang wrote:
> rxe_get is a conditional get (kref_get_unless_zero) that returns 0 when
>    the object's refcount is already zero. In check_rkey, the return value of
>    rxe_get(mr) is ignored. If rxe_get fails (returns 0), the code continues
>    to use mr without a valid reference, and error paths will call
>    rxe_put(mr) on an unheld reference, causing a refcount underflow.
> 
> Check the return value of rxe_get and bail out with an error when it fails.
> 
> Cc: stable@vger.kernel.org
> Fixes: 290c4a902b79 ("RDMA/rxe: Fix \"Replace mr by rkey in responder resources\"")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 9cb2f6fbf2dd..0c3f3930b494 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -514,7 +514,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   		if (mw->access & IB_ZERO_BASED)
>   			qp->resp.offset = mw->addr;
>   
> -		rxe_get(mr);
> +		if (!rxe_get(mr)) {

Can you reproduce this (rxe_get(mr) = 0)?

Thanks a lot.

Zhu Yanjun

> +			rxe_put(mw);
> +			mw = NULL;
> +			state = get_rkey_violation_state(pkt);
> +			goto err;
> +		}
>   		rxe_put(mw);
>   		mw = NULL;
>   	} else {


