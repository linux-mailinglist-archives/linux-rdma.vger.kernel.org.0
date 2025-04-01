Return-Path: <linux-rdma+bounces-9070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7884A7793A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5EF3AA5F4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6741F1524;
	Tue,  1 Apr 2025 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBbzpgRe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256041F0E49
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505293; cv=none; b=TsFqBo8PH0yG+hhkt8TmsqFJdMK3/Ok1lgX8fcqyPP7I2T7jwFSch4DmGhWOxsVU1UuDS3WLsCMM9I5XVs4f5zs1lfhuz/sJmVuy+AWUVt99fY6ITbjFIY8AoswYLby7GUZOnXkOq4f06KntTtXcxlWZXVZT7x22wxtAg8yweAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505293; c=relaxed/simple;
	bh=ivqGICVxLEozQGBTawILTTXP7Nl7eMNQhKWIstBNXQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bgpog0Uc6dLpuzk+Hpjj7AOGea6toUhtzMJksOcxVHT0ifFKAZjGXuy71XiFYncqxxxU1k4T2IVRwMWM+mmm2ZMebCMhW+ql7sMRVSG8NmETZ0JT0HUz2Dee4+8hFL57likQMnylD2kMlhTU/u6zSp2Aq+nSo+I67AJuKhkkDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBbzpgRe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743505291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjr/CuUIuzeRdMkmnmhYE65i0HIy2EZrxJ55nmXT618=;
	b=IBbzpgRedFdIdy4BUBF2gVd44npUZteaDYOZOalu5GD7jq/Dl3vh12W25F1H9jtohNCXXC
	Hc7qfFaNvg1/zAMn4CbsvFtHWbgTNskK6Wyvq0VzXB1bXCZgUwf1O4Nmf6Isw1dt+tGjSa
	VZz45Ksd/pz6dn7yehPjgj1BrEB6pEA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-wlh7f2yWM1qyE4c6PfqXQw-1; Tue, 01 Apr 2025 07:01:30 -0400
X-MC-Unique: wlh7f2yWM1qyE4c6PfqXQw-1
X-Mimecast-MFC-AGG-ID: wlh7f2yWM1qyE4c6PfqXQw_1743505289
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so33214395e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 04:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743505289; x=1744110089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjr/CuUIuzeRdMkmnmhYE65i0HIy2EZrxJ55nmXT618=;
        b=BZsamumvHSwuTenA0m3kEqcZSpVb68/tn4aouwjCSrhjB6KcpKVLaZ3Yve5E0F7cGx
         GR/8AyXy8w7vd1wFAxwXH8tqyVKu4UOOhrkFKZwbyAJsze95+qSiPP3R8k860zWY3kDy
         Y/EiriZZRT3owSqvAIL7gII/OKW3nqJV8aYNyrrbImsxhRtXsB03XLE4BlvrkoBnNjzk
         zIN7TypciSgNyiMl3IUI5FsEg9FKLrQw1twxQwbgIO/goT5lYSUYYFhOh/qoZVFBlwUz
         NpQeIrazcn7p8Vvkzc5//aXvwNtfzJxH0/8muuBMYcxjFr/SDjuzIcwa13HPyEruCZML
         W4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz0i23eSqQqdb7bqLfUQwNt9QAZ2rdFivHRg0o0S/2Z5+QhGb53XeCKVdfbBncgmtrjLW5U4koR1p6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3O2yBP3HmL/uAynCvTesdjUIOmTn0AXv9XjKnzr2S+eoqRNu
	D0aj5ULnyCdVeKBDLT/hYhct9mksPGPtYHTiaGZt5k8M9yMyB8OgtDhoVMGYccL6ylM8RyW7j2Y
	52CDCBVIHHI1Fw9QAFl21Aa9aBUqz4oFg9Vv24hSKbflVGUb9IZ7FuqZ2Q7E=
X-Gm-Gg: ASbGncuQExJs4nlgA1dsLHqaOgu8gW+WtgmktUjTFPyPFzMILUo6A9nXo+HMTTlqAh0
	cjvAmwSSDqrelPO4qGDFsf8ypWCVtE0gyf8O9yBz6pj43u7cQ2OMzCAM0azBPRNOyoTfsgrjGq0
	518EBudPPfNqU7VCRx3Qk+yMb6Y1vLJwmUa/TXrJyYl8U6v6c/VVacZ/SOQ3Z4aVsixRyjCQ3yO
	6cUiCUZlwwKdFeOiDW3DHcyj08rheUYofXt4w+AHrYiryegSrMvcP4rtToGjZx+oqH/KvgYG2sk
	flLutGgUKk0+831SJg6bibqJ5cNNca3MaL7G/Wctfwvj1w==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43db6228049mr92536625e9.12.1743505288643;
        Tue, 01 Apr 2025 04:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWR6oGgrBc9yh+EIWLu0f/Rl10wsiQ6GwZIk1/Jim/OUEtWye5DYg+AcOZjj2bj4OhsRKyqw==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43db6228049mr92536285e9.12.1743505288311;
        Tue, 01 Apr 2025 04:01:28 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdffdsm194280015e9.18.2025.04.01.04.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:01:27 -0700 (PDT)
Message-ID: <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Date: Tue, 1 Apr 2025 13:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ubraun@linux.vnet.ibm.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 10:10 AM, Wang Liang wrote:
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 3e6cb35baf25..454801188514 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>  	sk->sk_protocol = protocol;
>  	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>  	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
> +	smc->clcsock = NULL;
>  	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>  	INIT_WORK(&smc->connect_work, smc_connect_work);
>  	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);

The syzkaller report has a few reproducers, have you tested this? AFAICS
the smc socket is already zeroed on allocation by sk_alloc().

/P


