Return-Path: <linux-rdma+bounces-16514-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uORmJGsag2n+hgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16514-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 11:07:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA009E43F2
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 11:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B8353019B96
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335403D5254;
	Wed,  4 Feb 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k6cE/rL4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BD3D2FE1
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199633; cv=none; b=m5Ynrk1LbwVE0d0dzadJ/gcZHwzv1fKiIgASebHgAT1IPPJD3suCvgekjQqac9tr+Dl8ywIRzaeEPZZdjVxJbsAzwaTnFMt+kSZ1yoTO9ZoKRuLFeiF1eMnvwRkoEMauQy1n/Tiy97D3ignL0ysuq3ToCxyiT7791Bs53G3a6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199633; c=relaxed/simple;
	bh=cs2R93WVLkRqcGVguJaYNoduoOakcJB6Y1oKMHIuANA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbJaVArIRlwoo0c5ll0BcZ6J0qJCHyyxlimw0Dp7VnYlcNxFC+6zMge7zBhooiTpJC5Jnhee1TUjXmdEilJFEpDS+J0p4LkwfifEM6zWMZDRL4RIm+wKD57CkxBseBFIE7yxIjYNU7nHXjE8FAoahRWc2wHGy+Sk9DjA3WbcKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k6cE/rL4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <417e8676-cdaa-44a8-aa42-a5e5dc201171@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770199630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1IAelHVJPkSPpbYigKuwpyd+rqQR5x09OvaXG5WSt0=;
	b=k6cE/rL4VrLWEslLNnX8TjfzKGAkuQCLKIjumyzpb2kxBKVEBQtd9ANA2jNZfvCEhxIE2o
	yFfUU7SUjJmXM0ChnDZhMaF8/KatR1Ift2WT3+GcXM5mMFDmsEFp6nqNvuc5SFFUrLEi6C
	UT25cxBQHwT2pEx5b6OtPttmkEHbuT0=
Date: Wed, 4 Feb 2026 11:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/siw: Fix potential NULL pointer dereference in
 header processing
To: YunJe Shin <yjshin0438@gmail.com>, jgg@ziepe.ca, leon@kernel.org
Cc: joonkyoj@yonsei.ac.kr, ioerts@kookmin.ac.kr, linux-rdma@vger.kernel.org
References: <20260204092546.489842-1-ioerts@kookmin.ac.kr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260204092546.489842-1-ioerts@kookmin.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16514-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA009E43F2
X-Rspamd-Action: no action

On 04.02.2026 10:24, YunJe Shin wrote:
> 
> If siw_get_hdr() returns -EINVAL before set_rx_fpdu_context(),
> qp->rx_fpdu can be NULL. The error path in siw_tcp_rx_data()
> dereferences qp->rx_fpdu->more_ddp_segs without checking, which
> may lead to a NULL pointer deref. Only check more_ddp_segs when
> rx_fpdu is present.
> 
> KASAN splat:
> [  101.384271] KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
> [  101.385869] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50
> 
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> 
> v2:
> - keep srx->state > SIW_GET_HDR completion path intact
> - guard qp->rx_fpdu before checking more_ddp_segs
> ---
>   drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
> index a10820e33887..e8a88b378d51 100644
> --- a/drivers/infiniband/sw/siw/siw_qp_rx.c
> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
> @@ -1435,7 +1435,8 @@ int siw_tcp_rx_data(read_descriptor_t *rd_desc, struct sk_buff *skb,
>   		}
>   		if (unlikely(rv != 0 && rv != -EAGAIN)) {
>   			if ((srx->state > SIW_GET_HDR ||
> -			     qp->rx_fpdu->more_ddp_segs) && run_completion)
> +			     (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs)) &&
> +			    run_completion)
>   				siw_rdmap_complete(qp, rv);
>   
>   			siw_dbg_qp(qp, "rx error %d, rx state %d\n", rv,

Acked-by: Bernard Metzler <bernard.metzler@linux.dev>

