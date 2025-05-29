Return-Path: <linux-rdma+bounces-10893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC5AC7924
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 08:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97614A40A6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C071256C7E;
	Thu, 29 May 2025 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXBHpeGP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305E212B3D
	for <linux-rdma@vger.kernel.org>; Thu, 29 May 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500888; cv=none; b=ChyqaWapJK7pz2rjIjQKcm3MqPC+bfhLJOaOWj0Ty55fHtujc14mW15D66pGm6UbXZ7qGQK2HsNvj/fBusIZIxTTQ/s5tNgUPIFJn6BsgJjuIJLFKOz13elGtW8NVs6hTPCAIf3hgR4XIknb6vkiW242cRfv8hkXsvW1zjbbKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500888; c=relaxed/simple;
	bh=uo6zWtMJAmsChlsFAzrq8E9fCgS8gXBxbYq/eth/kWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfvPa0+OThfqR9wYvztVzQKSfGz3nN9h4rLRzyaQzl+bHriyXZSD0gX/komFG/ZF6HVDanQKehn4q4jLOnROB4+G+N/5nJTSHC+eOYb/2eoztYr4Gp9LimLQXbx4UhKCmuG9xRiR/HxcBprYus/UnhZ+dBV4oY8YX73F1Mn+Ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXBHpeGP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748500884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
	b=aXBHpeGPUdTDzNWyjiVeo6VcVGeDaNn63p5/0dikYfOdlNoKamlCkvPPtwLIr84jfCpj8Y
	Um18yxmBDZY6guuX2JPdJTtJGZ3hBYYW+zZa/L5YD1EuGHo0JgcjtySa9y394LGfv16Uur
	XoBnG9xYMjLY7WtLP0Nhl1I6CGPy6ak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-9Q-KoThZMPCLceiw-XU4mw-1; Thu, 29 May 2025 02:41:23 -0400
X-MC-Unique: 9Q-KoThZMPCLceiw-XU4mw-1
X-Mimecast-MFC-AGG-ID: 9Q-KoThZMPCLceiw-XU4mw_1748500882
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f3796779so127643f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 23:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748500882; x=1749105682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
        b=IvVfOVOnOSeSzaX0X8/CCS3cxjEc8fY/yAbKcKsUhglUwQS4t3nJdyh6Bf5ZCBZPc2
         84FBNKznqmMC/+eADJcEdlPFkXyqvdU8s/CBtgaZWZBpfJA3oG+V55a9Y5rlRmv/NtPK
         a7RvXb95I8vsyNGxFDPEcHKzjFwyHXJLVb89vBHsSTlgrP4ziW/V0s3DDystY45n9bGF
         PjCzTwLl4dAgkW+hPcFNHTCRd9APp+hriuWQhwSVfHBapcFrX8O4+MY7hwcAT5bBq9j+
         KYnyLwRig23sErbNaIhcAtJnsQL28lP6tFeF+LPdesn/fdE28uf5dziixYaHYIU6zZ8+
         lSpA==
X-Forwarded-Encrypted: i=1; AJvYcCWoCO2dt11SaSLA3sGnN8PuPxM6foKgIrfAmasH4XjsnIvJfkZAKPkJEf/zayKSVgSog/CAlWqjm0sk@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2cGpOoaMVheC8H4N6omJf1zucuThvYICVhAhbb+QpuWktGFF
	TFZH1/9HlENrWkdV4LZRGzQCt+Bpz10jngYYOMGwmsBG0gD3NxmstNAsOC06iut5CAM9/SXjY7R
	BPuAN0MVn1e3yFOArum6wuhwzUWoZg78pCgS52r30Jk1BL/L6KCN5ArNTx6mrbSM=
X-Gm-Gg: ASbGnctsNcbxngSJnLmcs6Q+/BA/t4T0mEhMVHWc2umJHK6R/O2qeBanS4UimOIzJka
	ZkKnAlFwC1rLO5mwZq0Lv+pwEMZnGEpwtq3JGQ7cUIsS7YQegzYUsLyPxVwZ4RF9Ky2JwmJnQqu
	+oSWtM5HKA3d2Y7l/i3giR5LVz0+7uFnUa+72Cmgo65bna5MlcXr/V8toQ1jlLGCKuDbGbXIhBy
	rQDbbphx9f1LpEe7knTQkDe1Pj15EzQNlHLNpHAQa1qUI/5eHm7Dl05NNWmgijfNobqkwYNy42Z
	rpopYyb0UioQhbhb3hMiBcDx/yJepkQtWjIIJoB+lFT+rkxwErbX5kMph4U=
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603429f8f.15.1748500881766;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WDum86fTnMvRYqch6MR+ztEYQ2eZPtIMANK31N5JRpHf3kQXQ5zQS9pHaQJE0QCeX7DRPw==
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603408f8f.15.1748500881399;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971efsm1015064f8f.62.2025.05.28.23.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:41:20 -0700 (PDT)
Message-ID: <21c1b2d9-1b94-4caa-aa68-8abbb6562446@redhat.com>
Date: Thu, 29 May 2025 08:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v6] net: mana: Add handler for hardware servicing
 events
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 11:42 PM, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


