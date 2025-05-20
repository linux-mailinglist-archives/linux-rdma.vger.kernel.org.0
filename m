Return-Path: <linux-rdma+bounces-10457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5534ABE5D7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 23:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA677B049A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572CE2517B9;
	Tue, 20 May 2025 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U3bnpVuf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF6171D2
	for <linux-rdma@vger.kernel.org>; Tue, 20 May 2025 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775667; cv=none; b=acPUD/0yooDCnjlOqRpzSYE1LA+hWxi/8vAbhnzaYwsG0oHneJ31lGphJxAnFqeQbULqwMcWW6kPxO1WROjVIggsWO0mvqvQdfS0/Y3Sf9BRzy4Xwr38KTv8VUDTbsXuYk1Y8iFAlfWJtei5LQBgLBqWu/OxFOZpYrK21wRLLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775667; c=relaxed/simple;
	bh=dR7mPXcmHSk6MraG3A9EC1sQZzxuNXyj1X98XJJ+2Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrnq2ku9sn2DbDj8zdAnehNlOmTuIND1SEezJOaldTO0i65G+D6yc5y6p3T7yPmbK6yLacBPOLs8LRhwsxm+kBrwbeTrkpg3pbOeJH93Uhml1cUiYGk6KcG6R7cv0D4GdeuUnIW0e+AraIe9T1OgV+D0v0l3TopTfNQTK3p6h44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U3bnpVuf; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0ee3606-1068-4899-8e66-a5e7ec716b0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747775663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCj6T0K8tDntpLPKlxha0NHRopL4dOb+3Is5+ivmLEc=;
	b=U3bnpVufgHXpMuMRn2Z/g3khEVsTjGPjecSS6krq4h5YLoQksJKKU6w72rhmKW6nkHxi//
	c+e4vT3gRKnFybA82/OLuTmPpF3YlfKWZbAz/o1u8RJYJ3pyzkBFaSQXtfdOKB/0xA4Zb6
	AB5aTgtkuFcCGk+Oxv43ydvJ5u7kOPY=
Date: Tue, 20 May 2025 23:13:39 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 net-next: rds] replace strncpy with strscpy_pad
To: Baris Can Goral <goralbaris@gmail.com>, allison.henderson@oracle.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-rdma@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
 pabeni@redhat.com, shankari.ak0208@gmail.com, skhan@linuxfoundation.org
References: <43d0274b9e2d45f2dd81a4b8e74a6cfd247db5c0.camel@oracle.com>
 <20250520162342.6144-1-goralbaris@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250520162342.6144-1-goralbaris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/20 18:23, Baris Can Goral 写道:
> The strncpy() function is actively dangerous to use since it may not
> NULL-terminate the destination string, resulting in potential memory
> content exposures, unbounded reads, or crashes.
> Link: https://github.com/KSPP/linux/issues/90
> 
> In addition, strscpy_pad is more appropriate because it also zero-fills
> any remaining space in the destination if the source is shorter than
> the provided buffer size.

Please don't reply to an old thread when starting a new version.

It is better to start a new thread with the new version.

Zhu Yanjun
> 
> Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
> ---
>   net/rds/connection.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index c749c5525b40..d62f486ab29f 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -749,8 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>   	cinfo->laddr = conn->c_laddr.s6_addr32[3];
>   	cinfo->faddr = conn->c_faddr.s6_addr32[3];
>   	cinfo->tos = conn->c_tos;
> -	strncpy(cinfo->transport, conn->c_trans->t_name,
> -		sizeof(cinfo->transport));
> +	strscpy_pad(cinfo->transport, conn->c_trans->t_name);
>   	cinfo->flags = 0;
>   
>   	rds_conn_info_set(cinfo->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
> @@ -775,8 +774,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>   	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
>   	cinfo6->laddr = conn->c_laddr;
>   	cinfo6->faddr = conn->c_faddr;
> -	strncpy(cinfo6->transport, conn->c_trans->t_name,
> -		sizeof(cinfo6->transport));
> +	strscpy_pad(cinfo6->transport, conn->c_trans->t_name);
>   	cinfo6->flags = 0;
>   
>   	rds_conn_info_set(cinfo6->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),


