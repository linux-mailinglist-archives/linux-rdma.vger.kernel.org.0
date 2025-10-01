Return-Path: <linux-rdma+bounces-13752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC5BAF60B
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Oct 2025 09:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F01B19211C3
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Oct 2025 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBC22B594;
	Wed,  1 Oct 2025 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcnIQXbp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5D1F0E32
	for <linux-rdma@vger.kernel.org>; Wed,  1 Oct 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303277; cv=none; b=GGKor9skl+PYyPWUBTpb4tZ39lZetSPm3yRk+mZwsFSI4ok5tp73q/Nk+LmN4h4VthIceqP92sL/05jHL3p94ts1oGPGgglQ9OfccgKwBjDyY8ANZCSmLQvsC0l9eFeTsgC455f+19G+m7GYfNLC7QybXf4Az+z5XH3HEGkzukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303277; c=relaxed/simple;
	bh=ZchBe3UVZFcajzAfPm5iupGhaT45ZKDAxK04VZzhIoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSD7xfSCbhrS171t/Uqn3jZ+cVfD5tsTgfdBNtskFlMxSfCsKkLxza1W01BSyDAFeo9BAmkHSQsDzfSP2NML/s2aZwdRv634Z3d6jgU4Y0md7i+xRMxeXI3py7cLGekquFyGDTfYmGwfG15osUlbsTxpysdtut+nnTQvmn7U63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcnIQXbp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759303274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6TphmWVV7btIJvjp1CTjxC8F2bt+sldx5I/c4TiGGc=;
	b=QcnIQXbpCqa3QuGfqc4LTZ8GIpfHs/Pm5KZBIfi24tc2rfSsgskY8NmNRBU6Nc7rYHlZ8J
	2SmPMOV59rEommb0W5rz0GNP3K6LUI21Nnp6RZfBHGwC32VYRMAtu2hG+DGK/2H9ckDvrs
	zTNR15kwE2CWrpyXNEcUPQZ/Po5NURM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-C58NPRxlN5ChBrnupiH8vw-1; Wed, 01 Oct 2025 03:21:13 -0400
X-MC-Unique: C58NPRxlN5ChBrnupiH8vw-1
X-Mimecast-MFC-AGG-ID: C58NPRxlN5ChBrnupiH8vw_1759303272
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4fa584e7so17941275e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Oct 2025 00:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303272; x=1759908072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6TphmWVV7btIJvjp1CTjxC8F2bt+sldx5I/c4TiGGc=;
        b=ucPtnRqCvQdvA2Qtvy+WB8B+yGqwEMoUf4vp+D9dgGkXCZWO8Zl1Zv3HGDTcS6izCc
         SFZAh0BAeC1DOM9VzoCXeKIc/jR/2Vtmc7zl8xoWDAWuLXI3Jzh7ATGcYfDfTkbY91Rk
         dmRsgs5S5+oemUutPeh7ZrZcCTzpvgLwz4SANvmihuJugaAVcdS2SKZHNvlMsdgqee23
         ZRMToRn8me2DfZa8dNqvC7UhfwRlBRey53sH+nzHT+2BelrZgPbeR/+6kUjQeCqCF4Dp
         9yjeZAX0aX6QnvgIpAp3ezLbPeXTQ7bpibS7OfRNUco5FhX5bDlnV5jKRfW0rxoJj1hZ
         75og==
X-Forwarded-Encrypted: i=1; AJvYcCUcZmkDcDLkLsQsU2R6DO//MvMXife2ExsW/G5UUbAvP7Jk6FhgcYiRmFjZXsOzJ0JNpz7NVN7DRkyx@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8+LKxHl9mPLVsDdis/40jNcYLi34ScyF/nuMha+hd/KRL+1w
	pSGRi9OIfe15+gXsknEB0iMryIcEHUPSM1cLzRGq8v1T7xsAXUFYqVpjcVmDiEupDbtvYgpnQ80
	7ovmMOlx+cvLk6yQ6gtheDq1akL7kDu4W9qC422YyEs38mq13XI7D+OJInKnId1A=
X-Gm-Gg: ASbGncv2q+R1tbPa95JDr81JiavCDkak5QroOxVxHRzNvf7173VZkciep9WetT2j8mr
	205nfmawmgPOX9Oj/ZsmSjAE9l/mS1JBr7yBJl/v584/RHPO8WPrBxnekV+ZG2pLyi3vBomg9n3
	6xVHhdhlFehvuOkV6uRghST+APU4RbysoqvmS6RaiydK+34wOPtkVB6R0q7l1phQT8mS4dvVAoQ
	BcAmmU4CJcN4uRS1ppBC8tA8YvBFN6xkGa70gMe8xpbS7jAFU0Js0IfePY9MsN+DiSSgy4MAW4b
	O8bUOvSO2ovFqIT/R1n9/8tCBXhQnnPQ0ugpTvG/y5KVmGfJWdonK4KopZkubtpcXKids9Pn4QM
	paIZ7L+IbZcJPMo+tPA==
X-Received: by 2002:a05:6000:2dc3:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-425577f0588mr1793507f8f.20.1759303271982;
        Wed, 01 Oct 2025 00:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL9Aoaglcvmq0NJZa7kQLBpIJUntR5wIckFB4bSle6etuGPxOt3URwof3q3OmopFDd6P6LuQ==
X-Received: by 2002:a05:6000:2dc3:b0:410:3a4f:12c8 with SMTP id ffacd0b85a97d-425577f0588mr1793475f8f.20.1759303271534;
        Wed, 01 Oct 2025 00:21:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb729sm25151903f8f.6.2025.10.01.00.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:21:10 -0700 (PDT)
Message-ID: <acad498b-06e6-4639-b389-ef954e4c6abc@redhat.com>
Date: Wed, 1 Oct 2025 09:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "D. Wythe" <alibuda@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-3-pasic@linux.ibm.com>
 <aNnl_CfV0EvIujK0@linux.alibaba.com>
 <20250929112251.72ab759d.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250929112251.72ab759d.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/25 11:22 AM, Halil Pasic wrote:
> On Mon, 29 Sep 2025 09:50:52 +0800
> Dust Li <dust.li@linux.alibaba.com> wrote:
> 
>>> @@ -175,6 +175,8 @@ struct smc_link {
>>> 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
>>> 	int			llc_testlink_time; /* testlink interval */
>>> 	atomic_t		conn_cnt; /* connections on this link */
>>> +	u16			max_send_wr;
>>> +	u16			max_recv_wr;  
>>
>> Here, you've moved max_send_wr/max_recv_wr from the link group to individual links.
>> This means we can now have different max_send_wr/max_recv_wr values on two
>> different links within the same link group.
> 
> Only if allocations fail. Please notice that the hunk:
> 
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -810,6 +810,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	lnk->clearing = 0;
>  	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
>  	lnk->link_id = smcr_next_link_id(lgr);
> +	lnk->max_send_wr = lgr->max_send_wr;
> +	lnk->max_recv_wr = lgr->max_recv_wr;
> 
> initializes the link values with the values from the lgr which are in
> turn picked up form the systctls at lgr creation time. I have made an
> effort to keep these values the same for each link, but in case the
> allocation fails and we do back off, we can end up with different values
> on the links. 
> 
> The alternative would be to throw in the towel, and not create
> a second link if we can't match what worked for the first one.
> 
>>
>> Since in Alibaba we doesn't use multi-link configurations, we haven't tested
>> this scenario. Have you tested the link-down handling process in a multi-link
>> setup?
>>
> 
> Mahanta was so kind to do most of the testing on this. I don't think
> I've tested this myself. @Mahanta: Would you be kind to give this a try
> if it wasn't covered in the past? The best way is probably to modify
> the code to force such a scenario. I don't think it is easy to somehow
> trigger in the wild.
> 
> BTW I don't expect any problems. I think at worst the one link would
> end up giving worse performance than the other, but I guess that can
> happen for other reasons as well (like different HW for the two links).
> 
> But I think getting some sort of a query interface which would tell
> us how much did we end up with down the road would be a good idea anyway.
> 
> And I hope we can switch to vmalloc down the road as well, which would
> make back off less likely.

Unfortunately we are closing the net-next PR right now and I would
prefer such testing being reported explicitly. Let's defer this series
to the next cycle: please re-post when net-next will reopen after Oct 12th.

Thanks,

Paolo


