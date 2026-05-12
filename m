Return-Path: <linux-rdma+bounces-20464-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FUlGF3lAmpEyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20464-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:31:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB051CBE3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2733230208C7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714F249550B;
	Tue, 12 May 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkFPHZ7c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXM1Zubc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00848494A0F
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574677; cv=none; b=hNCRIC5q5uh3l/fcBcuxJvEkwLvWhOjGOfT1yQcFn/hpceeyzDclidNu+Hjvvj7LOl9xmUz+pnL+l/GE2N+6n2fXob7YUb1XJNVyMBZLj5YOWJlFF6lQzl7w4RJC6Hugo22oPp+WrkP3v1//V47F6qjFYmvZLTXyIDOWlKjPqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574677; c=relaxed/simple;
	bh=fTGplt+watJ4CCJ48471v0saEF+Ue/1jSJxh0KQ0ZFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS788vsVfg+lfUplNzONPnLY21UsNa0f9ZyRTkuAFcJkpMvFV1qFeyW41wVAl2XWDRonv3JtUS8Q1q/NMQFQvdOI4rmRz003mjaMCTgWGg/ZkJCy9ZFkTJ9dydJ+a0H5sLpUjrchyKRx/iIvWBYyUOME6Licw/a0NbcFU82NwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkFPHZ7c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXM1Zubc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778574675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
	b=LkFPHZ7c+/gk/YAVMm6Pr2aaTtFcqC2bQA2f+Vn06vQ1BF0h9P6T+zEtcUZXkJadkuXlfc
	KfnvwFA40863m4fU/nhK8o/3xhP2Ohf1T3+Ggeb1Uikq8rMfZOancet9aDO1j8B4zANLha
	Fdaj6IBNSoob+rKATKjVzDWB1h61uUI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-PfTIPm1qP-ea2yVeaTn0rQ-1; Tue, 12 May 2026 04:31:13 -0400
X-MC-Unique: PfTIPm1qP-ea2yVeaTn0rQ-1
X-Mimecast-MFC-AGG-ID: PfTIPm1qP-ea2yVeaTn0rQ_1778574672
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e5dfa8ec7so28896325e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778574672; x=1779179472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
        b=iXM1ZubcFs4fu4W/ayBLZWMiqMZOOKDTtDbyjHXofib5CIgcLwXfYibmfGFVw0n7nj
         G7FR1UvhoKrgpdk+NEiXbQSTDKq3qMBwV3mXCC/w1mFfpQCQl/VG9ObcQqcZyAnLkOA/
         ZtMqy0tIEpXOKXwMXd0YHAWNlEK0McZ74gsp20WS7Kq3lxDP/TAPqXoDCFEoZ4HGd3s3
         xDNZ/4wMYlYzopEVu+N9PBtkJSzyuzQj0Es1CPznfTIwo+R+XIhYFAgL7VsjS05e90ZI
         LBH8IiBXZHVCWq6QtfnsdXbk17nKPUVEM58ADc4dG2n5MgWMQ9YrVhFLDrkWYVGBQXOP
         bAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574672; x=1779179472;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaygQPrE3vEfN+hpcIqqhfjFYc4/KOM3g2S8tsFLr9s=;
        b=nSWLYotg7m/0gncG/19xa22/+A3lWXTIAugHCCmZmV4SfV4D8yUsCFgEUYRSybF+in
         CBpVIWZ7rd+Rk/2wOZ0/nwNWryyiMBM+ydiuk1FekiRpb+MPkS3ms9+OV7AMZDv5ysxG
         VZzrK6iKdmsL/p+yD2QCidBbxHp1WpJRQXM2oC20UfLvGWcmvQQfs6td13HwyqyYjvuw
         /sqHX9FCAran7Cvbjuu1KWzgPyBEDFm9PrBKMvehR6ip+HaluI51QnVjfqw6khCwpPL7
         8Oq4kF6dR651iFtF4kdwVBMbeC1fF4iVluMM8oZdU1MVVy44IotRGf2kTve1kgu5IyTN
         CTJw==
X-Forwarded-Encrypted: i=1; AFNElJ8IH/Sm2cK76LFSnGm9HlA6H3aizL36XXd0fo+d3gwjcEgKYtHinuicAQN/Se0zr5RwjTxe/0QCnn0f@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkHVe84teyg6IST7YzoC9/xWeZnuLQq8N9ybdyhNdpM1VnY/N
	0sSjFZcVGrC4T81HI2L28SpsN9o1xuQGZInfomgkpbN0FGhybtr6/fnZoBMY90q+Xoiw1wS/Pxj
	WboETrLR8UYSzJBHFz6mHnT6S4F6WJbHTXf3M8PzEsMF7IG52BzF/+Ga7wwGgd7o=
X-Gm-Gg: Acq92OGwyUXvBD5KbLKpxsZ00wjn1EmoU48Pd2u9O3An9Q0Z6Q+kPilHQIXsr58A72+
	Yk/GtcoFaaifBIap0TFKtg5taMjR8jZ5Il1BKzFrbnXJ/z6e2fI4D2HaGIghdCWQ6GuJF66UNFj
	Ht/V3MHJ4sa88HUAIDnHOb5nfCReOhWSQAu/OtZgKtib9JADzOyplDYHfIKM8GGr2l0tm/R/Dyo
	s6V6hMwMNfYwM0/mGCrphaEjr/EHvlZpbolMvpKJYEdCWHKrO7EpPqT9+gXqss1hO+Q5Olbbbct
	jSf5VhB4ajyFQ1bttdfUfGHjelWQETGj0qmVnGxh5uY75pGHHPNmSpMGEoUCWO0IzUb8WNI2Kz4
	ErFeMLEAohWzJas/23kqjse7w9XqsoTOKMlVfpbGTRdH4ZEHlH9cxlwc=
X-Received: by 2002:a05:600c:c112:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48e8fe7b8f4mr22343165e9.20.1778574672091;
        Tue, 12 May 2026 01:31:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c112:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48e8fe7b8f4mr22342675e9.20.1778574671605;
        Tue, 12 May 2026 01:31:11 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a68ebsm29414592f8f.1.2026.05.12.01.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:31:11 -0700 (PDT)
Message-ID: <7aeb534e-cf2a-4a3e-83eb-d98a3a5787f6@redhat.com>
Date: Tue, 12 May 2026 10:31:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: transition to RDMA core CQ pooling
To: "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, Simon Horman
 <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, oliver.yang@linux.alibaba.com, pasic@linux.ibm.com,
 Eric Dumazet <edumazet@google.com>, Leon Romanovsky <leonro@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260508063718.101622-1-alibuda@linux.alibaba.com>
 <20260508063718.101622-2-alibuda@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508063718.101622-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F2FB051CBE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-20464-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On 5/8/26 8:37 AM, D. Wythe wrote:
> -void smc_wr_rx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
> -{
> -	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
> +/***************************** init, exit, misc ******************************/
>  
> -	tasklet_schedule(&dev->recv_tasklet);
> +static inline void smc_wr_reg_init_cqe(struct ib_cqe *cqe)

This and the next 3 helpers are used at init time, hopefully not
critical/fast path; the `inline` annotation should really be avoided.

Note that the sashiko gemini instance has more concerns on patch 1,
please have a look:

https://sashiko.dev/#/patchset/20260508063718.101622-1-alibuda%40linux.alibaba.com

/P


