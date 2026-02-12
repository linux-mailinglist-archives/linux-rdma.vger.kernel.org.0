Return-Path: <linux-rdma+bounces-16776-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI+HJRd0jWn42gAAu9opvQ
	(envelope-from <linux-rdma+bounces-16776-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 07:32:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4812AC17
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 07:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75C9230185DC
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 06:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3962BD036;
	Thu, 12 Feb 2026 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYeuy6aa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2332BD586
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877967; cv=none; b=mwbXBinnWnAS8egOiByhA9XwCMkwkIDWZQDPww35sfiEkBqLwDkdVjA55uufQD1nq2TFJkT63iMsD8+GCtfWm/MEZyC3H9re7nYc/pgxnS2cG2Kqr+Kh381iMHPcvvVDFO2/EDtt+Wo9+ht+03nGQdZt77jyt5DScARjIW3kVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877967; c=relaxed/simple;
	bh=FRHlWrxIVzb4IegmiPrSpZ5Hso+mLMNkmV4GMNnZkzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxoSQo7f2o5Ry7mcUiVsx6YdKox6+YkW9+hekVc/iW5LBcqTZOGWCFuTCKGZc+LWQCJ4tVLY/m1okITH324Yx3jJlry3puI6s02eBK2tHnci1+VSdhg8SYthKSsChyvONMdXuDp5db88Gk1CA7hBzZGqEomzxo6F9/Pzs51AwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYeuy6aa; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4db3f295-ed9f-45dd-b0b6-7b08377819cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770877963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZzN6OZbHroSLkt9zLTTP3jknr+fN1lHMUBwNZClxhA=;
	b=GYeuy6aa4kVzbRK6ZkKHxY79GU8EEQanZqnzq7M+gXJ5yE69/6uByioefAIrJBd6/oyx9x
	hIJ/7sGv6I1nlUb0Mf/RB/x7SuzJ9vAi9qbziq2owZrlCnuz5+LyITQ2thQLgCtj6AxIUP
	iixnk1zakPE3kVHUr/jZj0tnMxGqJ5k=
Date: Thu, 12 Feb 2026 08:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Expose new extended max inline buff
 size
To: Yonatan Nachum <ynachum@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com,
 Firas Jahjah <firasj@amazon.com>
References: <20260211113346.9996-1-ynachum@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20260211113346.9996-1-ynachum@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16776-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal.pressman@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 3FE4812AC17
X-Rspamd-Action: no action

On 11/02/2026 13:33, Yonatan Nachum wrote:
> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
> index 98b71b9979f8..13225b038124 100644
> --- a/include/uapi/rdma/efa-abi.h
> +++ b/include/uapi/rdma/efa-abi.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>  /*
> - * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #ifndef EFA_ABI_USER_H
> @@ -44,7 +44,8 @@ struct efa_ibv_alloc_ucontext_resp {
>  	__u32 max_llq_size; /* bytes */
>  	__u16 max_tx_batch; /* units of 64 bytes */
>  	__u16 min_sq_wr;
> -	__u8 reserved_a0[4];
> +	__u16 inline_buf_size_ex;
> +	__u8 reserved_b0[2];

Do you need both values exposed to userspace?
Can't you reuse the same uapi field?

