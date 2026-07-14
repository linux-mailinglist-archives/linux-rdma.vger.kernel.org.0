Return-Path: <linux-rdma+bounces-23169-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kB3mMkalVWpWrQAAu9opvQ
	(envelope-from <linux-rdma+bounces-23169-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 04:56:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E87507E7
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 04:56:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="tUXg1u7/";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23169-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23169-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8334F301B912
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 02:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1B37F73A;
	Tue, 14 Jul 2026 02:56:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE183624B2
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 02:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997761; cv=none; b=crUv8sQRDkJB0jjguz+UVdBnIPn+oiEpojfi2+of1labOF+fbjYMBvStr+l5YM2NyUV9R+iawfggBzLWwoN8q99KS0r1Q1j9IUg7tw8GP9aedvxdOi/zdZ7NzPFlwSrFMSJLyC9fykYGCyMksItwgVv84ELmnzWXzlQ6wA10DG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997761; c=relaxed/simple;
	bh=s6cO1MOngcabjINj+1cmLqjuL8ZRAjLhnkD7LW/xaAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BI319Cjm9vzgAVr1EdBkbLPfBgTgjvj4DcDLAIAPvQUzwUxWQe5kfVUdWuk75hv0lOmHuN9PSEB5m6G0JIzBf+jvTdlDCq4UNGxZq3SNrYXOducLkHC5QFMSAogdD9tYoG79GngQu2ew9MxGlzRjVAEDE/l9k2mIzc6ERklhfIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tUXg1u7/; arc=none smtp.client-ip=95.215.58.189
Message-ID: <99a613bd-8f32-4a7c-828f-b30097075e76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783997757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFCEBM2O2w+Tfp2mxhFX9m4Mz1xH2m+AAHhFF8XbM7w=;
	b=tUXg1u7/T4ctaPSMpNLC7jHzNLNXc/iXyHDK+PWwnX+O7wGxyNaAB8aYtgehMF9cHfmMvI
	dELKymLYPrvFPbX82hHGMLAupYkCofntk84KdEBgZer7uiW1kq4P6MZYiXQvTeDJLFUtzU
	S5fPGrWZ2VNqLacCCoAWVWt/S27WLL8=
Date: Mon, 13 Jul 2026 19:55:37 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Reject unimplemented implicit ODP cleanly
To: weimin xiong <15927021679@163.com>, linux-rdma@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: jgg@nvidia.com, xiongweimin <xiongweimin@kylinos.cn>
References: <20260713010439.331054-1-15927021679@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260713010439.331054-1-15927021679@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:15927021679@163.com,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:jgg@nvidia.com,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23169-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 933E87507E7

在 2026/7/12 18:04, weimin xiong 写道:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> rxe advertises ODP but not IB_ODP_SUPPORT_IMPLICIT. The reg_user_mr path
> still contained a dead branch that checked the implicit capability and
> could never succeed.
> 
> Return -EOPNOTSUPP for the implicit ODP address range up front so the
> intent is obvious and the unreachable code is gone.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> Cc: linux-rdma@vger.kernel.org
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> ---
> 
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -87,14 +87,9 @@
>   
>   	rxe_mr_init(access_flags, mr);
>   
> -	if (!start && length == U64_MAX) {
> -		if (iova != 0)
> -			return -EINVAL;
> -		if (!(rxe->attr.odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
> -			return -EINVAL;
> -
> -		/* Never reach here, for implicit ODP is not implemented. */
> -	}

It seems that the above are for implicit ODP. However the implicit ODP 
is not implemented currently. I am fine with removing this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun


> +	/* Implicit ODP (start=0, length=U64_MAX) is not implemented. */
> +	if (!start && length == U64_MAX)
> +		return -EOPNOTSUPP;
>   
>   	umem_odp = ib_umem_odp_get(&rxe->ib_dev, start, length, access_flags,
>   				   &rxe_mn_ops);
> 


