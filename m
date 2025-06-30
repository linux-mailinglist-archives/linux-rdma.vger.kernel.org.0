Return-Path: <linux-rdma+bounces-11748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6217DAED4F2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 08:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080F43B1895
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4733F20C461;
	Mon, 30 Jun 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL12VkNx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773271E25E8
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266304; cv=none; b=snd8k4SNwAQQTrwZyW+o6a3Bgc6tKvFEtR++FkKum/ENtzFGyuywaCapY0ViIOax6TZb2IhnNpZIPNL+IPBX86j58v1hLxhIyVjvffIKTlIFbHMRcLsCvPL4lAwbYYhHA8t/sH33LaB/fBZb6MaIlLIalvJUv6IgLoje948vPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266304; c=relaxed/simple;
	bh=1j/BOe6+uj6Rz+5EFQPn/l2EbhGasamVZqKuVWNilXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMxfTvQa+d/VX+o+4coWl33CSCA9jXybhoIoXJfu8GDC7v2NC+lNYgB7H0xN6tfFbtMe6ra/4lrh+R7EwXCRU/ASuvhb/pYt5Yj7bbqC8wil3sRQOC8jyVm4LDIDJ1Ybhva5/z7Ggh0A1af3QWAhQdOyCfCeUJUFYBDEz/ImTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XL12VkNx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751266301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14L4bSmzMK+Na24jtHZlikcuCB46GClv+lCWBOsYn3k=;
	b=XL12VkNxRj85syYOQHSpKb9ocN7rCtq1D0rKSh1cOaBoMY14rglkWKs/CqfMeSAb0pa7sJ
	njGphRe9YeCXsq2JKXXNBhilGNedRMq210b4SkjkCpKbd5muDeZZmC6Pj/yFxq/rXRXu5N
	8EE75N8vzmzBPZIVSAkYYGDJUY9HnOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--POwYzLANjeSXYt2Q2Eljg-1; Mon, 30 Jun 2025 02:51:39 -0400
X-MC-Unique: -POwYzLANjeSXYt2Q2Eljg-1
X-Mimecast-MFC-AGG-ID: -POwYzLANjeSXYt2Q2Eljg_1751266298
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4535ad64d30so14174335e9.3
        for <linux-rdma@vger.kernel.org>; Sun, 29 Jun 2025 23:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751266298; x=1751871098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14L4bSmzMK+Na24jtHZlikcuCB46GClv+lCWBOsYn3k=;
        b=wTD/Ckjf7AKOt6hRkSF45ZoX67hMkUCuSyMrBm5d3nuRZJT5X1FAk+evkLAa2Di4gr
         ND2qmdjjvm1PMtKK3h0XYI8G1lmnxaXNwVUo9OPYUSfGBR9MeyYLtTXRTMd1PyJL/fpi
         wPHLcklc2bp9Yg/SVStXkbPStBVZnebcHHKnbPlZoyp8qZDUCrrDSr+ov5RkpQ92APpg
         Xib9SBhmAuj8PbluFcKjbZop/Vhhq4s6HPU2gz8Ccz4UHKps1FBTx9WXcL7k56DFiCSq
         503O2LvZGojtYWQx9QdLVYMcFRHoMq4StawNag3foN4M60Xc02D7O32YTGzS8aO9t6bS
         Q7tg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3KQAnpOASI0XLrFGGV3q2Qp+Ph3PqZYssH1hBZnCH0P+kqQwSkgALdpeXV6h8yDd/1mduLBGnMe1@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeZ1xzk6c9BR1dp2mzuf+lRuI9gWFGaKGtLIEZsEsrZS+0PpI
	e6ydGq4Wz8WwbkYQEVInU+DwKv5bl1p6sl8FdG6QIzHKceEV9Tp+5brHnNgCbPXrlKUR+lNYoCK
	KmD7ZMUlUhW7cvUaJoA3o6e5iIzombx49Q8NnOctXZ+Hq5V4u1RKUaFm6F/OCH48=
X-Gm-Gg: ASbGncsPj9db55SMhuq7EBqjfcxdwdUkJFtkLl3QiN5LE+sV0ej1xbeLVZAlBc3ttKx
	dnrHdUrrEoVotWCFcWolDLp6mZBkSheKGqsHfgod5duk6iWp/9BmanEHltWFfHgRgrK5npiuGQx
	2+arNh2T1w98nslJNEjYw6bhlJ8YcwylLl3m9oYWAfpfwkLVreYDfeom58T4Hgn8qPni2BsxOIW
	PR6cfas6ORGLL0arMNKITbvoaAvwxKgBV9WaD6xoOKF+KLjrehObFJQKGcNARkQ0MZp6Dwxg6Sm
	S4Rw7WQ8N1Yl9LRkr94abvzMrmNWcBo/oFy8bFXUe1g1f/XFMX3fe0YFvTI1/JCYUs06AA==
X-Received: by 2002:a05:600c:3e8e:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4538ee5ce0cmr113844405e9.8.1751266298033;
        Sun, 29 Jun 2025 23:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8OzcnlTDoCi5GaakFcUjFo98VZ0Lu6zkZMiLKUwkNiF4+gQI+xZELrNOEu2y/m9jGEUvL0Q==
X-Received: by 2002:a05:600c:3e8e:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4538ee5ce0cmr113844085e9.8.1751266297611;
        Sun, 29 Jun 2025 23:51:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3aba76e40c0sm5286272f8f.59.2025.06.29.23.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 23:51:37 -0700 (PDT)
Message-ID: <83640113-ae18-4d5a-945a-44eef600d42e@redhat.com>
Date: Mon, 30 Jun 2025 08:51:35 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: syztest
To: Arnaud Lecomte <contact@arnaud-lcm.com>,
 syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
Cc: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org,
 jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 tonylu@linux.alibaba.com, wenjia@linux.ibm.com
References: <67eaf9b8.050a0220.3c3d88.004a.GAE@google.com>
 <20250629132933.33599-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250629132933.33599-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/25 3:29 PM, Arnaud Lecomte wrote:
> #syz test
> 
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -123,11 +123,14 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  					  struct request_sock *req_unhash,
>  					  bool *own_req)
>  {
> +        read_lock_bh(&((struct sock *)sk)->sk_callback_lock);
>  	struct smc_sock *smc;
>  	struct sock *child;
> -
>  	smc = smc_clcsock_user_data(sk);
>  
> +	if (!smc)
> +		goto drop;
> +
>  	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
>  				sk->sk_max_ack_backlog)
>  		goto drop;
> @@ -148,9 +151,11 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
>  			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
>  	}
> +	read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
>  	return child;
>  
>  drop:
> +	read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
>  	dst_release(dst);
>  	tcp_listendrop(sk);
>  	return NULL;
> @@ -2613,7 +2618,7 @@ int smc_listen(struct socket *sock, int backlog)
>  	int rc;
>  
>  	smc = smc_sk(sk);
> -	lock_sock(sk);
> +	lock_sock(sock->sk);
>  
>  	rc = -EINVAL;
>  	if ((sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) ||

Please stop cc-ing netdev and other kernel ML with this tests. You
should keep just the syzkaller related MLs and a very restricted list of
individuals (i.e. no maintainers).

Thanks,

Paolo


