Return-Path: <linux-rdma+bounces-10625-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B57DAC2693
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF74B540330
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAC5248F41;
	Fri, 23 May 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0rM6f3Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840714286;
	Fri, 23 May 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014730; cv=none; b=GMTJct5woD0Jx4VU8ElYEybl9LML8WnAmC9aNKJM7M4fKYMQi9dZBFYCdKAcniXd0K41LiqzdjeLa4WF+mIvjOiNGhe9iLviphkJzpTHDm9bqJ9MOzKTyxkOWIx1YswunR8SrU/k8/eGq49e/JyGO4wN+vBvqqh+1MG6Ji7JNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014730; c=relaxed/simple;
	bh=esKPzyKTo7EyhBPeYFjR099taB5F7qTmeYFSJEtpeUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPoSpL+ES5SK4LhS6xPDgEJuk1xZtyMwkEuaCLI0vJtqazshj62kkEY2cTqMrtBqo9oRi9k2JJ7SOuzLkItQYelBpn+R8cCIcWmLXRe96LigJtxueZBCZHqpShAylBoHtlPYK8U0KymZDwpSBTF24hNU1VqX2jmZk3BWfDbC2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0rM6f3Q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b1f7357b5b6so5841836a12.0;
        Fri, 23 May 2025 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748014728; x=1748619528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9By7081c2CRgn2t4xnecIrtE4ESQao/xPs7l46E2ec=;
        b=a0rM6f3QBM8UqSdNCTF3yv/XhWpcBk6CgvWPUXVMJ7gco2a5YmtgPQufd/bcQfJvOz
         ws01Ama/t9wMXj/mfqZ6dC5jX5fofJcRapity7O1Pwj1nW9kZoO1cw3m1vqDLxcW7Mf5
         lQ1T2PSjFDTZ3TP5LXMdPzkZn+TAxGHpi3SKC/43BNmqNogWnG5vLw3+A611cP6k/L5a
         ccmmkvGN/gkkMbQPiF/8RzPDeTMHiotM4W37FK/trRMSjVWq/Rz5mcE/Hfopcf72jaou
         vWbquyA4qJhIWSP5jZsySetJDAF8zq0xDw1vco5G41FKrdBjUJiwqZEKMFLV072D9ceI
         uPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748014728; x=1748619528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9By7081c2CRgn2t4xnecIrtE4ESQao/xPs7l46E2ec=;
        b=qUxMOPmFMk0WARcgXpXS+lCjW0mwDZu78IcAMSAIN1Tn7NLCjwo/r7bdr1kFRvpmkt
         TcT/KSutyHVxJkoCZYGPtb4hbZXdK0ZaAhmJqOp11ShcLSLkNIpxtszaSNFwiQNr3Rf0
         UrmFa9FzwWBq7WiN//oGaFrBaQocovOAMsqb0BiB7ruNYrJYV9zlW3T9mu6f4AXQxfKO
         EbdnH8rRtowgOaLxkxbEKAZDj54aiWfZEM4aWtwaEUB9Sst/xV83d/OUg9hUFkPm0m7z
         3LmqqAY0xMsaIwZY5421HZuR1jvnf5hhjKnz1PvVbINMIf97c2uFAYDjgXxppBp9mFSH
         LqUg==
X-Forwarded-Encrypted: i=1; AJvYcCW/T2/+pJHPQGQWaWY0+FfDA5L90/UtC4/AvQuTBkcIXLo+EglQzXKeOFoh4G7u6wy9koKxHg85nfQdks0=@vger.kernel.org, AJvYcCWjM2uJK2J0lMyWKeQdhumeWTpBfxG4qT4XYbOGlhIRAdUXts2qoye1I90cH6Ae9y6V5zXETBQtwPQr@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8a9jfshx4bUkq3yMCz7u6bOpGmnAWiDgCAajEwGqJdSFhVQG
	rXpEdACKoCapurYxyYhrgimZQJoUdgBPJBht3lLGhrLIThfY3WUlQeY3
X-Gm-Gg: ASbGncu4MPWjklGilwPl09yWFxb3TFAeTfMqrbv0iroD2mx6l7IVZ9yy5kMFUcGQJ+w
	r0ORgm5TVmyypbxOSdep/M0MbfUmbvDJ85nzAOAPPqcv4dSDr4JljHsV6cvAqnJ9+mOv7YYtkI6
	3Hia1nj+PJFJYWaRVywlxsKBCMjspFRFo3aYNAqDVumO6zImGTGtso7QvXQ4LN2YJT64SpbkX4/
	fV7ejuJoOhq63BAvW17GDBh5DzctlBrKwj24PWm6bGJZzSho7IajYeRo8fLj2gOC2gUISyQeHkh
	oLskRAnQiuiTfJPhz8hsorUDPltEJ1EfG8gYy0Fy2s0D6Eu/YKK4uKKVZegpGGtYCsyEACTE/mU
	O2ATG120uZ2JURrY/aiDVnLcAO1s=
X-Google-Smtp-Source: AGHT+IE+ZIequO6IEewOv6/npkzSIgcVfoP+JyEutRg58NuQQxakWelr4YYr4N2RGALZuFbYJsZAUA==
X-Received: by 2002:a17:90b:3682:b0:310:eea1:1c1 with SMTP id 98e67ed59e1d1-310eea10349mr2961466a91.16.1748014727610;
        Fri, 23 May 2025 08:38:47 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e11e33c2esm12871188a91.1.2025.05.23.08.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 08:38:47 -0700 (PDT)
Message-ID: <63702a66-4cc6-4562-89f4-857fe3f044e8@gmail.com>
Date: Sat, 24 May 2025 00:38:43 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: Allow hmm_dma_map_alloc() to tolerate NULL device
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-rdma@vger.kernel.org, linux-mm@kvack.org, leon@kernel.org,
 jgg@ziepe.ca, akpm@linux-foundation.org, jglisse@redhat.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, zyjzyj2000@gmail.com
References: <20250523143537.10362-1-dskmtsd@gmail.com>
 <aDCKsK2-zRkqge64@infradead.org>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <aDCKsK2-zRkqge64@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/05/23 23:48, Christoph Hellwig wrote:
> On Fri, May 23, 2025 at 02:35:37PM +0000, Daisuke Matsuda wrote:
>> Some drivers (such as rxe) may legitimately call hmm_dma_map_alloc() with a
>> NULL device pointer,
> 
> No, they may not.  If something has no device with physical DMA
> capabilities, it has not business calling into it.
> 

Hi Christoph,

RXE is a software emulator of IBTA RoCEv2, designed to allow systems equipped with standard Ethernet adapters to interoperate with other RoCEv2-capable nodes.

Like other Infiniband subsystem drivers (under drivers/infiniband/{hw,sw}), RXE depends on the ib_core and ib_uverbs layers in drivers/infiniband/core. These common RDMA layers, in turn, rely on the HMM infrastructure for specific features such as On-Demand Paging.

As a result, even though RXE lacks physical DMA capabilities, it still needs to interact with hmm_dma_map_alloc() through the shared RDMA core paths. This patch ensures that such software-only use cases do not trigger unintended null pointer dereferences.

Thanks,
Daisuke

