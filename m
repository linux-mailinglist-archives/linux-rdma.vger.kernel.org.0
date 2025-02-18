Return-Path: <linux-rdma+bounces-7804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC774A397B8
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C187A577F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B19235346;
	Tue, 18 Feb 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFraw+Iv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FF231C8D;
	Tue, 18 Feb 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872161; cv=none; b=XqxRGuICG9rbHoqvF5gpbeiEtbINrh+UWpEetywd49gJRDmR8TH9Q4s5bPYsJ/3jFL81eePEHa7VHyxnfH+XImyzLX/vdC5+cKf3sMmLLbMT+mcq5BBcf0i1DNM58zeigDJvooQ3IzkGW2HVF8WqhlUO3PPKL8wWXIJJwPUg8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872161; c=relaxed/simple;
	bh=XbF9Z9EDOE+WH6IsM10sX91VT6//KmQmo+fxU51EyWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYDCXGNxGTTWV8bN//Uzh5TG1eF2758cn29RcK5v+QRFDZXOq+TI/IdDK+Qn2qmZA/9GXKRmtM4clUTpZZ83w1omXMJp58aotdfRwA6CIN6qsIBHWgdGK9BEQ8x44pjAlaGh1RnrON+CTq4i/sUT9YfsV5aEKTukIqqSgMMDhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFraw+Iv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2913299f8f.2;
        Tue, 18 Feb 2025 01:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739872158; x=1740476958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmC+DcBpQAGFGOKtkkBPoJk4Mr/Jtv0ZiKFK90g8220=;
        b=nFraw+IvTEiak+45ZTjOsCIVk8idx4nEpHJhdUlAp6F8JgiE4vlNQa6Vay+IN6TT47
         +DU330t+VHrJxId0q2msTYOZk9no6h76gQxb2upP4GAjJwPHZwG11wceY3gmju+FAfl3
         DBTLCXG8gdXW49/0cIXD+O5GmC8pK7t2Fcm0RrKKLEN/Zb2ZC7vvDUlCfQKg0/9ExIPe
         vuCwC25znSHBnTAJ4AQV97PwazcAM4+dI8K408DIXs29aYZ3PhrWMH5VP5coKHkTV5xp
         BUSZHFK61YLfO7FB+wRdRhEmDPH8ZbFXjh/7ifIja0nJ/b11e8rAK1SXj7l2Cp7L/Qqe
         AyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872158; x=1740476958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmC+DcBpQAGFGOKtkkBPoJk4Mr/Jtv0ZiKFK90g8220=;
        b=mVZIrW4rUL/gmoBrm1W6sLs82Vtj2nuMtcPOmTGED0368emgvy9dfhLRO6xAW8VAHD
         qhUb/i01djKMIOvTIeCW362IJ5FTLePFLDFg3Nzh4j03xriMEuOlqGVIb12lwzZm2d5/
         9r4U37MKVc9fRWosS/IDXqHZeKgDUnwCSxrStpVHPWtemHfhuEGDklhGkmLV2xLVfrKS
         1EwgAfHfitIza10/0JHC2pfnFYfpcO6qQMpKeeKx4hp7VEE2iDv2CjmgPVlWgAfAuKd/
         4iSgBXLUbG9tD9NPyM2x10dbNr+SrPF7dThl7mgJxH0u9cxEdHHHYLmem/y78UlhEWrE
         AKUg==
X-Forwarded-Encrypted: i=1; AJvYcCUJyPFrLHrvoxwEzqWYUa0eIOLsvyeGgvh3Ji/rsM2kWNYUPzWs+yRGBNlGHqZMb5kcGVk5QREPT5jFnuAm@vger.kernel.org, AJvYcCVFSvaQuCqeVPcgmNcHG848Voj+AZDwZnp9AafznTjxm7wmjDrjr+wH3c+hpMC9s0ngbrj2xePh2lpJ7A==@vger.kernel.org, AJvYcCVjTil4mSGmG223Q2npQAPxV+Use5xEnPeCnT0CjGGbNMGhaQuWawE9qnDQr60NW67yd/0R392+QfPGy1/IFFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfdvWg/J9n5x4e3cWjmPqL/yuyUbAvF4a9HuA1MWzgv+upIUl
	26BvIoj6IHFMJhfJqFtiL44e8hvsHxN+KwgKq0NAZrKaQPcT9/mc
X-Gm-Gg: ASbGncsttmkB56v8rXW9P0sjR4Kn2qgPBqz7gugQ8Rv1JCSUC51aTuEIGFblezhmQPN
	eOEBPkV7ptHIGkDbwtlffhjm41oh3DgxaEaf2S7O+WJkxcEKEnhnNskTgRPNu9hV6e/gJSQ/0jp
	Wt7VhSHjwuMnzi706FmhnY20JMTrla2JeYD7mDOkiOH6I6rkunb4Rys//2BMZ+AzOd8TJlN62fC
	aJH79Nhu9rP1D65Qlab/aJzGenZhMDkHZwRa6B0eyZFwjJPw3yN8az4dxu6qUwNf8F8Id5dPNB9
	Paxiu3ncqPvfErJy9eT0hkZjicSTaF02Zne2
X-Google-Smtp-Source: AGHT+IHMMavTvoFgwqe3JTZjFjaVhMPpCPIj09sm9EPZ0jm15kDP34LtqQrw6MAxx6sLesAeKhn1HQ==
X-Received: by 2002:a5d:64ad:0:b0:38d:d4b5:84cf with SMTP id ffacd0b85a97d-38f33f1b5cbmr13829426f8f.5.1739872157727;
        Tue, 18 Feb 2025 01:49:17 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm14201167f8f.89.2025.02.18.01.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 01:49:17 -0800 (PST)
Message-ID: <5f2ca37f-3f6d-44d2-9821-7d6b0655937d@gmail.com>
Date: Tue, 18 Feb 2025 11:49:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6GCJY8G9EzASrwQ@kspp>
 <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
 <8d06f07c-5bb4-473d-90af-5f57ce2b068f@gmail.com>
 <7ce8d318-584f-42c2-b88a-2597acd67029@embeddedor.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <7ce8d318-584f-42c2-b88a-2597acd67029@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/02/2025 10:14, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> -- 
> Gustavo
> 

net-next maintainers, please pick it.
I provided the Reviewed-by tag.

Tariq.

