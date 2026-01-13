Return-Path: <linux-rdma+bounces-15488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B98BAD16D91
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 07:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9462430206B9
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3B35CB8D;
	Tue, 13 Jan 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9QjCqi6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC2233723
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285922; cv=none; b=uKuWJNzoExjDbKraD15VNT/i5YJ/0fRuscIFvvFxRLwJCCtmU4CIotXWek4ZIjCgnSxYy5tmqjQpPBgSTBLPrA+hA8QDQ4K6QsRS8aIoqDvtqIOFsls2ZSOug250aGcnVLK+EKqi4PupkY/XWYKRjasodc942f5Lsf+SNfP0KCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285922; c=relaxed/simple;
	bh=yX7DhlFraPUD//ZuqML4tqjQ5mKp1gfm8pBA5BRUq/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NS7fgVtpEvH4CEZU9orgGmc/o6NCPDDpiwSHvmPc1JftL2ABNtpQjdugxD5/5cNBZC/aZwf7WmhHViXeNQ+1WJh2lY+ZnrfrgSsT3d6jPN0G48Hz+DOj6vUfbXhOdTtlcK5Kj+p73FNLLJAN/4wjMvUJfw/lI8DXQ1X0A2Wt52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9QjCqi6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so59864855e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 22:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768285919; x=1768890719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQhbZxT1S/lDurK26TholDxT9dj20OVvsAU3YYjIzC4=;
        b=M9QjCqi6CQFL/lUsrNPux0k/Fxi0Ix/7huip3lofiin1oMdBv3NTzN6Sc0Aop2dym8
         6jSORaAoz1DS4w/HAHNxbPI0rFghqENG1bXatbX6wEzE6zgUijGKQCkRkCQj4WM+Ndv6
         M5eRg2UEH4dpG/hMLgfUTNv2mxcBbhnVS0gNt1B6s9qQmnrTWybN39hFJKuGDW4KZp7d
         FuDy4pBwgwM7hVTXshhnqTYemLnSRmuHw/87dDhqRFzR4l2cOChxiC/6lsblovClHP0M
         PK6VlBOpjcznGHaFRpvfCTB3ytXAW0CbXKTWkDoYlojbNTiigHRs5GaOnuUHgyRSYxiS
         Ebug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285919; x=1768890719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQhbZxT1S/lDurK26TholDxT9dj20OVvsAU3YYjIzC4=;
        b=qKN0UXNo5iadvRwdFZuCKhMa7+Tn7boreIpE1zlqCQNtAQulQfFgonfQdfnnOFSEph
         21Gisqp6KgdH4F8YOel1VUhpvmm03kZ2k75Zxp1nVt9nLgeiLuc6jp+6l/8CcOO0ImlH
         u9LthWEAGXKOsKmXKKSF0s0xm9i6E7f7T3CwsjW0slyYFE/pJZl1JJWpqiJHE645/CRZ
         FpcCV/0UFISqwPpF6UNjvSeyPUWCsoVt26AZr7cvtgq9SNkEdqNXYXKEL7bWhIeiXnQ3
         cRqyWDxC5frKRkNhnChwpNVccuOfWW3237mU4CP55bceWVRiJyjnreaCTqFxs2oHrpcV
         AOeg==
X-Forwarded-Encrypted: i=1; AJvYcCURusnqwVPx29OiLwGgUEPd8cWTORswvOinslf7WwBKrpWddD44R6Cyg7gMSLHf+s85j22xMYmQTv3f@vger.kernel.org
X-Gm-Message-State: AOJu0YzYY//8DuktJOdyOmqIgFa4U9qLkCcSerfe511thtpBxPoUd9ej
	7uTdZNnNjR6TknTbaTpK3dzkkHepS10pJIKN0qem41zWe07TYitKnc1Z
X-Gm-Gg: AY/fxX6UTYz9pRkWQM/RIf2YooyTN/ffVefeaGDKRFGnMDTd1dRnFkV7scOiM1tt7tr
	NHMBwutZdMoskjURWJL+6tS40f5gYn2dtid8SJd3Xd/qNxBJLKFGWTNlDvRiAfBElg0V2/gSS2V
	r9ERxpkt2oVMXs7VkDzFhu2XmjzaFtbXPS/QUKNVD3B6tg77ba4Elv8+u5HplqLVOgcLGvUabHa
	g+xtnqUtfW5Vcp0LplPOY/EvvptoRgq2Ghmh72iwIE5wfanhpY5yQF0eaK6S8Cu/sRhh68MJ+P2
	OSE7UaOYXpRa+gSdtTD9IWJbOzb66FyAfSWhFTjDOV5sIJQ6BKXx+cWADLQbtMtCti/CP/MQeTD
	0/tKnCrAXe8BjrJbXhpRoXywEIF0AapEXxmG5BsiDJqtoWMSeNIgtjVLo2ku3O7o7EJiYezuvOo
	YjH8wP7Uw4LUcKx0MnmX7zL+XqEwqEuoMIT8w=
X-Google-Smtp-Source: AGHT+IEUAFfAI80TkN+eVQsY3YtARbADJ3c4FvvQWuIZMALTzGmm7ksRXUr+QWT776d5USXcuu/wkw==
X-Received: by 2002:a05:600c:c4a3:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-47ed1422becmr69367275e9.12.1768285919415;
        Mon, 12 Jan 2026 22:31:59 -0800 (PST)
Received: from [10.221.200.118] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed9eb9319sm9021265e9.2.2026.01.12.22.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:31:58 -0800 (PST)
Message-ID: <0ac69f6a-d587-45a7-be30-6ad4429ef8d2@gmail.com>
Date: Tue, 13 Jan 2026 08:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC mlx5-next 0/1] net/mlx5e: Expose physical received
 bits counters to ethtool
To: Kenta Akagi <k@mgml.me>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260112070324.38819-1-k@mgml.me>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260112070324.38819-1-k@mgml.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/01/2026 9:03, Kenta Akagi wrote:
> Hi,
> 
> I would like to measure the cable BER on ConnectX.
> 
> According to the documentation[1][2], there are counters that can be used
> for this purpose: rx_corrected_bits_phy, rx_pcs_symbol_err_phy and
> rx_bits_phy. However, rx_bits_phy does not show up in ethtool
> statistics.
> 
> This patch exposes the PPCNT phy_received_bits as rx_bits_phy.
> 
> 
> On a ConnectX-5 with 25Gbase connection, it works as expected.
> 
> On the other hand, although I have not verified it, in an 800Gbps
> environment rx_bits_phy would likely overflow after about 124 days.
> Since I cannot judge whether this is acceptable, I am posting this as an
> RFC first.
> 

Hi,

This is a 64-bits counter so no overflow is expected.

> 
> [1] commit 8ce3b586faa4 ("net/mlx5: Add counter information to mlx5
>      driver documentation")
> [2] https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/counters.html
> 
> Kenta Akagi (1):
>    net/mlx5e: Expose physical received bits counters to ethtool
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 1 +
>   1 file changed, 1 insertion(+)
> 


