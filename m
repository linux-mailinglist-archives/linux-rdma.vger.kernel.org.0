Return-Path: <linux-rdma+bounces-10196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03311AB10E1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0C95217B9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93BD28ECCD;
	Fri,  9 May 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0IpxkSZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CD28EA48
	for <linux-rdma@vger.kernel.org>; Fri,  9 May 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787099; cv=none; b=TQPYuJJ0gnVFSa7ToacCexOz91HBwU/Gmfr4cGOn0zyylaDCqahkdCIMSmOJJgFh39GDRrxaYUJ1OhKIm7cfwvT1ImnLdVP+/ixH7iVBW7tfSPXoV9KiXFe6rcLRWxmuM11VJZ21cOL+J8dCv043VNuCghvP+nEBqVX4R+UqVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787099; c=relaxed/simple;
	bh=h5vZ3RZrobbGTqXpKUDcyM+zgHHzgUsLiZ7YLN3JZoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMrSnvurMbRpF4wcLdgqtIkesGPgEFi7itoy+iglKHjF05wg55pEdFmVLXtt3f81yAoy9cUBUCPlC9kTBwFan/CUnSzu0K5rGO+80u0YZAnYcnHH6YcYVrlCOJsTMOlHpiP9aaHtyQ3On33htz7wDEFqG8A8rhwehCeho6NTBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0IpxkSZ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25482135-b7c5-499f-b5b6-acdfa794a037@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746787083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONPYX0QwJHMfIc+8sscJQjDDUYwa+bvuBMk/T9MfePk=;
	b=K0IpxkSZyJ8oN5WKJjvCdtmb/nfj5trTGlH8vLOsz3GxKP6rFGI0NqoZ3unuWRLIa+Q3nO
	BZu7IPHGJlwhCfsiXyAUIiU9Gk+3KMdflltxRXKhEmxbZjrHDI2lUT7po21WF8JwgTJqS2
	mdcgr1VmIGKkJM/fC271C2H245MLlV8=
Date: Fri, 9 May 2025 11:37:55 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net/mlx5: support software TX timestamp
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, leon@kernel.org,
 Jason Xing <kerneljasonxing@gmail.com>
References: <20250508235109.585096-1-stfomichev@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508235109.585096-1-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/05/2025 00:51, Stanislav Fomichev wrote:
> Having a software timestamp (along with existing hardware one) is
> useful to trace how the packets flow through the stack.
> mlx5e_tx_skb_update_hwts_flags is called from tx paths
> to setup HW timestamp; extend it to add software one as well.
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
> v2: rename mlx5e_tx_skb_update_hwts_flags (Tariq & Jason)
> ---

LGMT,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



