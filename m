Return-Path: <linux-rdma+bounces-9069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3BFA77900
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C68C188EFBF
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E002E1F0E3A;
	Tue,  1 Apr 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1xtA2gp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3D1F09A7
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503977; cv=none; b=m+7W9OEPN4dqppyv9j6HeyT+A4MV7KBodfJuAe6GutWqBG/tbc6TBi/tp061VX4wloaju0shSG5BChPjXUyu4U0cjcGOYoURKz75co+f99Z5KMacihoqDHlUHXFYJc3Nsx9u/AClYxcq2wy0iGxEKMLS1dqAeM/Tjt7tcGhqzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503977; c=relaxed/simple;
	bh=M/mq4JnSQpKTggcsMpPy/Ed800gvVrVsqjg65DhPwtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJJHArzmCCqX8t8jV29/n2pbB3bOFvFl+JKRe4Gwhxaf3naPgp/7fKeSKJWrqWMQHp+Hd7MXmu+FIAY2Tl4KW21CaLGDXqEOTtMUoGjmNJq8AARjE37c+c6I2g6PEx1Gr2T1dUJBE/EdUNu6n7bS6Co4cINUlwreU7Gs+fmf0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1xtA2gp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743503975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQNG48GY5mypw3mSkzgUDbnnJJHt0dyLOJoNC+0wZEc=;
	b=S1xtA2gp/3UEvc2JCeP6ea/BjG272K11fFc8l3+td7IXeVK6WsiX9e+blwpxpOmTGzX6NS
	Pm6/W3OreKFTU0M5EzuCI0XTJ3pgsnTD/1l6raxfgnP4K2SUrvm3xTBvOvQfYfuCdSQ/jA
	VoLyymfMQ1Dy2TFlc8AMwost38rlqdo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-65z7DwEVOt-_2h2r581S7Q-1; Tue, 01 Apr 2025 06:39:34 -0400
X-MC-Unique: 65z7DwEVOt-_2h2r581S7Q-1
X-Mimecast-MFC-AGG-ID: 65z7DwEVOt-_2h2r581S7Q_1743503973
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso34314165e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 03:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503973; x=1744108773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQNG48GY5mypw3mSkzgUDbnnJJHt0dyLOJoNC+0wZEc=;
        b=JRZgG3MgMPLP3kEZfh9E3SbvbRbOG2xhMSAoB1tMhZe5gmh4JRYjSDIY29Ti+ziYrB
         UaYJunBXufCH0xfikvPA1ofaS+LD2jp61l9n95MqR+6oP8JoJ3PYGCW/n9mSmWfubZX0
         aG3KGhP4N9v9lHlvwX2pGkHqHCI4PESgXJ2lECcSJI9c10eNed9LAOWr22liHxDQMQNz
         Ne1LYJnf0ycTA1XQD3+I3TrByWMCI7Jqne2aQ03f5x53GnGMSEHFn52CvAtHBWKBTaz0
         EG9JTrArhudlhzpNTq/2nyhKJ4wuuoXMFyoVeMjGM4SaXspxJgvTFy6oO0SFI1Zae1hD
         6LCw==
X-Forwarded-Encrypted: i=1; AJvYcCXqtIdiIhC5pQ6Clq1pHcvo/volTBpABwQO2zi8GKm6ZlsvMMamwyKLCNHe6Sj8V3MIMboMzuwPcRuo@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWokJ5cg1bRZ1I0EnSHE4m2mjocW6ZYpbEcTUdwtPg0F0xLSG
	zJOsj524WEqgvSSlY9VJMmzUlt4TqgLlIflvDPQ76p/QhuNhm/k5urqMcS0f4R90V5T/M8U6nu5
	ltyRuWDiTAJ3qM7odLH5qUECC8xX3ugGd2KLcYKMr4B3u9fXqRclQ6hc9qbjE2MiA9XI=
X-Gm-Gg: ASbGncvNnltxiwwf45bVEsNDvpW0/VeUWuC/EZdTl2o73iPqUb/v9eSyF09Yiowm28O
	WC4LYhUkS/J721+IfdmoxFBjmoPKT/c9yvE07/laPZGlwUmS1G/tolIYlTU9+Pt6Tc2eBK4vr0C
	j/QXQl42VQ9qh9Ezf0yp8DX7lHIyrfA5gGs/TVJtGe39RDhB3vxDkkGbm3nY53gPtw3Dhjbhm7d
	4ItXwdIxisrApKJbKL1F4CivxNSnIgFwGdtS7EKF4QH0OMTWEzPPWGXhzmHic7RKncQJKqqn/A4
	tBj3macaxQo7ZmgiIZJ2PfxN7VKvYml8T6P5vW9g0DTkag==
X-Received: by 2002:a05:600c:3c8a:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43db62bf4e4mr111608435e9.30.1743503972746;
        Tue, 01 Apr 2025 03:39:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMT1F7Au7S2zYRnLT7IwgveOyfD8e/jDXFa8aYnAAV9srHq09g2hSMlUYYnzNdWTUVtEhQsg==
X-Received: by 2002:a05:600c:3c8a:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43db62bf4e4mr111608175e9.30.1743503972421;
        Tue, 01 Apr 2025 03:39:32 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fba4c29sm157427945e9.5.2025.04.01.03.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:39:32 -0700 (PDT)
Message-ID: <3b13fcc0-31d3-4565-b5e6-b75c6b167311@redhat.com>
Date: Tue, 1 Apr 2025 12:39:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4_en: Remove the redundant NULL check for the
 'my_ets' object
To: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
 <a.vatoropin@crpt.ru>, Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20250401061439.9978-1-a.vatoropin@crpt.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250401061439.9978-1-a.vatoropin@crpt.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/1/25 8:15 AM, Ваторопин Андрей wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> Static analysis shows that pointer "my_ets" cannot be NULL because it 
> points to the object "struct ieee_ets".
> 
> Remove the extra NULL check. It is meaningless and harms the readability
> of the code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>

## Form letter - net-next-closed

Linus already pulled net-next material v6.15 and therefore net-next is
closed
for new drivers, features, code refactoring and optimizations. We are
currently
accepting bug fixes only.

Please repost when net-next reopens after Apr 7th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


