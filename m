Return-Path: <linux-rdma+bounces-7883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10AEA3D273
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 08:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768483B141C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE841E990E;
	Thu, 20 Feb 2025 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SICnMiI7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280C1E5734;
	Thu, 20 Feb 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037275; cv=none; b=MsOr55OxGiOo+ac0Jx6NE7fdi0h00sA2Ep+dA2jSZu42uIJL22lKBDAsFg6GVEVlQGsPhLvd4kkpvIE7ApE8oGxhbugOCWK8hOoDvZynJiKRjnfdZ+pHp/USbX3PUY6WKjnO8GUvKC3rDcjAx3V0K/hl/FFaCHTUA0RsnbLhX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037275; c=relaxed/simple;
	bh=Y5kYSgfukTER1EK5fH9cMVwho5EJgWr6Kj/8SYChQEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJ3Qx5Y6UmEm5rBh9reY7KTuXfMbIWs87kzLKRYDLdgUhWRkRU7/pUh1OyX37OedGny6Mp9NVbtow8sdSSdH4EM0ttw3veXZfUG01NWzr+aSxHQkSOUceWvePApI10dEUMkHr3Qdq29ByQ5eEtZB6o5i+D+LOtBeZVRUTx6FmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SICnMiI7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439a2780b44so3339975e9.1;
        Wed, 19 Feb 2025 23:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740037272; x=1740642072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJYv7ynx+2KN3B5BBC3b4wZsS5Thp/vdHPKspluBDSY=;
        b=SICnMiI7BPhcaPZngqawkSxFmW6RO8rXQ0Gd9nBJckm+jnclVIX1zmPklXzOY0OYCx
         69ytKuiAThoMxe1ucJN5W/yh8R03oEqDwHvDNj9/KxR4yiBwaqscCZsxY/l6+ItQRGUu
         2Oi8LVeK61NRB3ZkN5JTLDoTsYdUeas+zrfKY264gIpD1BqJ1jiq0f61KhhiYKR2VJE4
         q0IhaxJTw4fgvRV4pDxwCWWnd+YGou5kBghoF8Yq5YfDpatWXv04kdwLTb2t4R5YmZsi
         bByjidVy+Xg42V9U+T1W5aQ+MPL6pXmJPZXIdu5WZGRAg6pcitx60cNfBP66l09TcPdx
         r4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740037272; x=1740642072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJYv7ynx+2KN3B5BBC3b4wZsS5Thp/vdHPKspluBDSY=;
        b=iZXggKeofoI/vSMO38ArKNiHYN6ouj/B5X+x/vIg1O35oNBpewDVMNRORJk1/zjMXK
         g4VCG/1I+Nx+U+u5LFqEYOmXrmgM6OKnY8IWmRm+yTyKtxA81kt0QP2UQYOhyneZumuv
         oR5q9BM4XOUvNJDysiLp7B8lJ7Q9Hici5lCLEp/3m05pHvJgPN8BXZjC4uIO5irMOhdE
         CK792T7Y7sK6A06gDOjOArD5udjxbVe9dckf2O0pOuLKDZGObuHedv5D0R1YgRDrYIdU
         kpHLsJswouuODL8/46s8c2zQVXl8AbDTIv5dRGG/gtj0QkdRy3VIht0PElNA6o5ENqZ8
         27AA==
X-Forwarded-Encrypted: i=1; AJvYcCU5O6zC3wnFzVWFDSav33LOrdzFIer4+djAazt7IYgtYPi+kwsgGeP10QSrzGri7ahR31AMm9f563GAYQ==@vger.kernel.org, AJvYcCVGr7slGETc3Lvs10WxH95QXzvh3n//L6kRCxSk5vEfZ/N8SyfPsQIgzmbBd4EExNC1pb7KAPPI7csmQ4GiarU=@vger.kernel.org, AJvYcCVQ0iRmKLyQ2V9haVJ2qnlVZLAuEFe6rNFUeyBXOVm0yIWY7kop1zANaHdj2VMsg0NbDpceXZKZ@vger.kernel.org, AJvYcCX9WrfcLW7VyUpcP81kNoLi6PjmG+OzBhZCIBuUrUs9tWEtkMxsBbi7TS0wtN1hKGBSr5R2lCGOBrrHqhxw@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVs5EnKGuOlPW6io510Hzyf9M2Ljq/4jxQ4iU3Z7nn0GL2zs0
	OWnzc9bxQvqGRQ5QlRJq6vzan0BA9dR/Ml92Zu3vzDVRq98WxOYTeVWwSw==
X-Gm-Gg: ASbGncs9/XzyPyGcEWwIaulmPvN2RJaUpf+3b1HvVyzR0W/d068axeZFRws1e4TkeAn
	gfyuuQ1mEdY8aRo0ehbq3jrImcWAaphVAVUoFRIeqS1OhEKLo80CSTMeDXV28PHTBYW9UEPP0u4
	W/55UYzEo6PZyEAcwm3i+9d+ooPwXV2LglKpiN0Lh7rwiZvPfShXtw5ZganAEDBp9BqroAfnNgg
	T1Vp0gw2+DCYejDEXbprRRCttnYnSdk/KyrwKqVOLxFPofPi1yNKHQ2+pWIGDJjUhDekIgi77Nq
	VLy7XlAlK+aAFJBn7cfaearKa2uQxbi8fyk=
X-Google-Smtp-Source: AGHT+IEMwSqIIsc4ebzckcZJDzHWuZ55uljwt7+wfboUSZakp8qJiZNrd0ew7LhjiwbxKJKaQ4irLw==
X-Received: by 2002:a05:600c:35c1:b0:439:9377:fa29 with SMTP id 5b1f17b1804b1-43999de1a26mr57522325e9.31.1740037271566;
        Wed, 19 Feb 2025 23:41:11 -0800 (PST)
Received: from [172.27.61.29] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982a2f92esm114030585e9.17.2025.02.19.23.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 23:41:11 -0800 (PST)
Message-ID: <98f1cc71-7699-40f5-909f-86e7317d8071@gmail.com>
Date: Thu, 20 Feb 2025 09:41:06 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z6GCJY8G9EzASrwQ@kspp>
 <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
 <8d06f07c-5bb4-473d-90af-5f57ce2b068f@gmail.com>
 <7ce8d318-584f-42c2-b88a-2597acd67029@embeddedor.com>
 <5f2ca37f-3f6d-44d2-9821-7d6b0655937d@gmail.com>
 <36ab1f42-b492-497f-a1dc-34631f594da6@lunn.ch>
 <59b075bc-f6e6-42f0-bc01-c8921922299d@gmail.com>
 <20250218131345.6bd558cb@kernel.org>
 <99543a40-2a57-4c10-8876-cde08cb15199@gmail.com>
 <20250219174629.4791c1e9@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250219174629.4791c1e9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/02/2025 3:46, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 14:14:35 +0200 Tariq Toukan wrote:
>> On 18/02/2025 23:13, Jakub Kicinski wrote:
>>> On Tue, 18 Feb 2025 17:53:14 +0200 Tariq Toukan wrote:
>>>> Maybe it wasn't clear enough.
>>>> We prefer the original patch, and provided the Reviewed-by tag for it.
>>>
>>> Can you explain what do you mean by "cleaner"?
>>> I like the alternative much more.
>>
>> Cleaner in the sense that it doesn't touch existing code in en_rx.c
>> (datapath), and has shorter dereferences for the inner umr_wqe fields, like:
>> umr_wqe->ctrl
>> vs.
>> umr_wqe->hdr.ctrl
> 
> IMO that's minor, not sufficient to justify struct_group_tagged()

No strong preference. I can accept both.

