Return-Path: <linux-rdma+bounces-14634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D393CC7382C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 11:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 831A22A67C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035232D435;
	Thu, 20 Nov 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3vhIb76";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDpUylQz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF71277CA4
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635455; cv=none; b=F5AsmK5QQEge2SyyAb/Tpj2fNqKYNnGpQqwhXyHKM0sC3n48UqwAnvhRbWxWB1vrfXrexDstQwDiTt+L6OwKPKHZuxmOMhmFVCWi1YH46FnVWK9Y6phW7X0MGWFG+s4854nbBY4xL6Qz/u2gO1cs99UlXu8iwQKvRHp9B68LQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635455; c=relaxed/simple;
	bh=0CiiO9j0xkb0mo5fLo8ag9H5ivXz95o7qymjM9S+1jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/A6biUmVSH9bBEJW6r6EPUUSQMOogUeNdRLlDbtj8NzVA+Abck5hBshSvnggdl6V4s4E/1dMBDNwKiHdyo24PBt63nLezCBYASwoOpP0G/G7/LNH7SW9od2FJOmescfBbYg6IIV2LS8ey19tLK7hIxKN2tNyGUOoiFHmxe69T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3vhIb76; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDpUylQz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763635449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8y1jPHiAwVo3dkS7PWUJ32CmlpzzI2xRMMetRTLKqec=;
	b=e3vhIb76lwwtORWkQ0wB/anOwHmCTVbBtjX/BuYg2T9j8sIb7fL6Gx+iLgGRAUDPdCyrvn
	iwkDIlpby4UFapbXmqgEKmzrzKrjj8NQvLa06FIY1PuDQMMxi5Hf5P0hqcU23hA23uZWhQ
	OVZlKxwrKdbn8DHEFCT2L/KGUf/hLNU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-PXXNJp9aMQS9yzg5B02XPA-1; Thu, 20 Nov 2025 05:43:53 -0500
X-MC-Unique: PXXNJp9aMQS9yzg5B02XPA-1
X-Mimecast-MFC-AGG-ID: PXXNJp9aMQS9yzg5B02XPA_1763635432
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47777158a85so11409875e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763635432; x=1764240232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8y1jPHiAwVo3dkS7PWUJ32CmlpzzI2xRMMetRTLKqec=;
        b=MDpUylQzcUQLl5LJ15FssQue3sv+OWkcdzZngyrvSkPAVgr/i5PkgsCKjTI/kr+BvA
         3prBObj17KkdQRTSoHs/pW3N87WQunaADAB6W+p+Y2c6jTbshj05N8FopJre0s5KJ6Zh
         fBeUak1yNQNOrMaJOAteYAFn/u9qSYVG3KLFRIZSd/IoQIy3+mC9yynmZFd5oWvTG6KY
         nEavtO0bkBTLwP9c6Zo3Gnzyt/ftVmmz8hdw+b4V2dh1TNjGS2OhRnblQC0UZIpxbMbC
         0CsqAImZSXeHoQFoUFd9n8qsJuNQMmD1iTue+0wWZ8pUcFp3XMEdBBS108Nu4rQLuF/Y
         AghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763635432; x=1764240232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8y1jPHiAwVo3dkS7PWUJ32CmlpzzI2xRMMetRTLKqec=;
        b=ePkhG5woV3flqGOekQmtR7fgQ1ux6nL67wRXw61k8v1iiOFLMtVVDkSVWg1CYJgUTa
         317bCRYH813hvraorBfnOwaE/V+qulwQx6JKXPoG/hqwbO0i09do32DJ6GkCCcVGCRm4
         gEw8Ohmn5xPp80CrsXincJtGUa0c19XNzXOlDxItl5S3dQoN2w52abCYHH+BxT8wiGER
         FoT1mV+CyW/n655jHW3mH6cGkJDFe8AuoHt4tGi09K5tRdj0hHgEHoOOeylwzTkDarkZ
         64Wlj+RmTal3Z4ZvvYLZPm+cSlKIoSbD1mYp3Bh9kmmqKKjVAhYCZzyyCV/27t79pqc4
         p1EA==
X-Forwarded-Encrypted: i=1; AJvYcCVwvvAh95KzbTupLFloFrVDMvOk7M7ftJI/OY3Mc0ztBnp2/L2iPNwz5RAShbsNTqpULhJzb3IxYtDM@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRVf6bBMYzpLRUsg0p+mMuA/vJzIArFIkPKgIZLmEpJi8eikz
	7OsK0kcl8kpq05rz/Tkw5i+kfHc2i7icftMTq+vk0Eg859QUKG0g4R2PcJIMvkvgHANGs94UjCz
	4MjxxxctW5Ep9kesvWreiNnMnX7ZChtdvOxUfOmCvebss1efDjUUgy5MGByOZbpc=
X-Gm-Gg: ASbGncugCGOEKKqfWJ81/RR3t0z8pvJFRQmBqZfty077Rsm2QnpWvRIj6p55kYZ43Gj
	xlEwKgfqEpq+JPwhIIEaH8BwtnQIzcJc4VhKG8ofpaXBwZCPFU85pKuOTCYIZbMoBpz8jW7SRXI
	INOS8GMb5HLeOEethYQq9IGadarwaw98YQFkyE64la7dZuBq7Kw+w+cwJ+Vqc7bEcZvcOSQdBut
	qCv5BjsM56lC5OeWxOmM36qN3g7kNK50xtOkUvAq4JEeO8cNN3c6gejmS8Ub3y+HnPIRnCb2jld
	kPDCvh+ToAMZ6PsZ9Pszo2iKQpsxllNimhM926Be9qfUgLDtUgBE5c5xxATYfx8CkIT6Kx3JDkZ
	8+HEvcKB7DLvm
X-Received: by 2002:a05:600c:4449:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-477b8953f82mr21394905e9.9.1763635432112;
        Thu, 20 Nov 2025 02:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR1Ruk2Gj51suzzS5y4BcXGGtt9pWyX/QRlRypsMh/5NKSs6sTrfUKJWhyNZl7GGOZM7Fmcg==
X-Received: by 2002:a05:600c:4449:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-477b8953f82mr21394645e9.9.1763635431713;
        Thu, 20 Nov 2025 02:43:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b8314279sm41801585e9.11.2025.11.20.02.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 02:43:51 -0800 (PST)
Message-ID: <98bbac96-99df-46de-9066-2f8315c17eb7@redhat.com>
Date: Thu, 20 Nov 2025 11:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/rds: Give each connection its own
 workqueue
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, rds-devel@oss.oracle.com, kuba@kernel.org,
 horms@kernel.org, linux-rdma@vger.kernel.org
References: <20251117202338.324838-1-achender@kernel.org>
 <20251117202338.324838-3-achender@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251117202338.324838-3-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/25 9:23 PM, Allison Henderson wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> RDS was written to require ordered workqueues for "cp->cp_wq":
> Work is executed in the order scheduled, one item at a time.
> 
> If these workqueues are shared across connections,
> then work executed on behalf of one connection blocks work
> scheduled for a different and unrelated connection.
> 
> Luckily we don't need to share these workqueues.
> While it obviously makes sense to limit the number of
> workers (processes) that ought to be allocated on a system,
> a workqueue that doesn't have a rescue worker attached,
> has a tiny footprint compared to the connection as a whole:
> A workqueue costs ~900 bytes, including the workqueue_struct,
> pool_workqueue, workqueue_attrs, wq_node_nr_active and the
> node_nr_active flex array.  While an RDS/IB connection
> totals only ~5 MBytes.

The above accounting still looks incorrect to me. AFAICS
pool_workqueue/cpu_pwq is a per CPU data. On recent hosts it will
require 64K or more.

Also it looks like it would a WQ per path, up to 8 WQs per connection.
> So we're getting a signficant performance gain
> (90% of connections fail over under 3 seconds vs. 40%)
> for a less than 0.02% overhead.
> 
> RDS doesn't even benefit from the additional rescue workers:
> of all the reasons that RDS blocks workers, allocation under
> memory pressue is the least of our concerns. And even if RDS
> was stalling due to the memory-reclaim process, the work
> executed by the rescue workers are highly unlikely to free up
> any memory. If anything, they might try to allocate even more.
> 
> By giving each connection its own workqueues, we allow RDS
> to better utilize the unbound workers that the system
> has available.
> 
> Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>  net/rds/connection.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index dc7323707f450..dcb554e10531f 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -269,7 +269,15 @@ static struct rds_connection *__rds_conn_create(struct net *net,
>  		__rds_conn_path_init(conn, &conn->c_path[i],
>  				     is_outgoing);
>  		conn->c_path[i].cp_index = i;
> -		conn->c_path[i].cp_wq = rds_wq;
> +		conn->c_path[i].cp_wq = alloc_ordered_workqueue(
> +						"krds_cp_wq#%lu/%d", 0,
> +						rds_conn_count, i);
This has a reasonable chance of failure under memory pressure, what
about falling back to rds_wq usage instead of shutting down the
connection entirely?

/P


