Return-Path: <linux-rdma+bounces-968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DE84DAC2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 08:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C6C287462
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61C69D11;
	Thu,  8 Feb 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHl44ivj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589D69312
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377852; cv=none; b=SjK6zxweoCsymlhZaJHkM7ok1EWGiQtGvv9k1z+W1SqR8p+Y2akOpEhdRANaOijvIVpUacvpxHebrELIezvCJprdprs6cwCSQmrGgTOlI83lfo5haWkpy6j5K97ESlA/SUKCYpgofVYXxOj1xeRxZrtXxb3//aYl9l0a/w+LqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377852; c=relaxed/simple;
	bh=1HL7L+ZGGkPBH5bKRsU5TnsnxrzIL3qjGfk6G0ZRIx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0ZhQqXZLcmWIxLpiFUzpAbHuKL1alc+EjlYNZQSS3Y4LDHUVo3LglF36vhErjx99ORMoH6eZVfsqeN8kgjDQsn1cmnTJ09qMEc3IqK5TDeGM9A7HLVH3x76AK3szGaukpLnzT/amltP8Z7y7wHnZwvegtEApxmPO87p94kOajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHl44ivj; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2ff1709-2e4a-4844-af86-216ae678be0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707377848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZY2IYWge7aqEdTQkPsDOhrf4mVLwOBm/L2GuRcGffs8=;
	b=XHl44ivjdMtUfoiX4JloGN9vQo77odvxwr/LSPVHnqcn69QvtC56y8sO0OEJF5pbsHlX/e
	H6g12prbMQ6XbGBFZuJ+zuLvEbp0eKii5yCLidNx4IIWikru9clAIWs0cv/6TRHmXFB4j9
	8qomKAVo784+OrkyqR9DQirreoNrEDM=
Date: Thu, 8 Feb 2024 15:37:18 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] net:rds: Fix possible deadlock in rds_message_put
To: allison.henderson@oracle.com, netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 santosh.shilimkar@oracle.com
References: <20240207233856.161916-1-allison.henderson@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240207233856.161916-1-allison.henderson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/2/8 7:38, allison.henderson@oracle.com 写道:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> Functions rds_still_queued and rds_clear_recv_queue lock a given socket
> in order to safely iterate over the incoming rds messages. However
> calling rds_inc_put while under this lock creates a potential deadlock.
> rds_inc_put may eventually call rds_message_purge, which will lock
> m_rs_lock. This is the incorrect locking order since m_rs_lock is
> meant to be locked before the socket. To fix this, we move the message
> item to a local list or variable that wont need rs_recv_lock protection.
> Then we can safely call rds_inc_put on any item stored locally after
> rs_recv_lock is released.
> 
> Fixes: bdbe6fbc6a2f (RDS: recv.c)

A trivial problem,
Based on the file 
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst, 
Fixes tag should be the following?

Fixes: bdbe6fbc6a2f ("RDS: recv.c")

Thanks,
Zhu Yanjun

> Reported-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com
> Reported-by: syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>   net/rds/recv.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/rds/recv.c b/net/rds/recv.c
> index c71b923764fd..5627f80013f8 100644
> --- a/net/rds/recv.c
> +++ b/net/rds/recv.c
> @@ -425,6 +425,7 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
>   	struct sock *sk = rds_rs_to_sk(rs);
>   	int ret = 0;
>   	unsigned long flags;
> +	struct rds_incoming *to_drop = NULL;
>   
>   	write_lock_irqsave(&rs->rs_recv_lock, flags);
>   	if (!list_empty(&inc->i_item)) {
> @@ -435,11 +436,14 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
>   					      -be32_to_cpu(inc->i_hdr.h_len),
>   					      inc->i_hdr.h_dport);
>   			list_del_init(&inc->i_item);
> -			rds_inc_put(inc);
> +			to_drop = inc;
>   		}
>   	}
>   	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
>   
> +	if (to_drop)
> +		rds_inc_put(to_drop);
> +
>   	rdsdebug("inc %p rs %p still %d dropped %d\n", inc, rs, ret, drop);
>   	return ret;
>   }
> @@ -758,16 +762,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
>   	struct sock *sk = rds_rs_to_sk(rs);
>   	struct rds_incoming *inc, *tmp;
>   	unsigned long flags;
> +	LIST_HEAD(to_drop);
>   
>   	write_lock_irqsave(&rs->rs_recv_lock, flags);
>   	list_for_each_entry_safe(inc, tmp, &rs->rs_recv_queue, i_item) {
>   		rds_recv_rcvbuf_delta(rs, sk, inc->i_conn->c_lcong,
>   				      -be32_to_cpu(inc->i_hdr.h_len),
>   				      inc->i_hdr.h_dport);
> +		list_move(&inc->i_item, &to_drop);
> +	}
> +	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
> +
> +	list_for_each_entry_safe(inc, tmp, &to_drop, i_item) {
>   		list_del_init(&inc->i_item);
>   		rds_inc_put(inc);
>   	}
> -	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
>   }
>   
>   /*


