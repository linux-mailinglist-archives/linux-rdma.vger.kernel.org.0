Return-Path: <linux-rdma+bounces-7832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23BA3BDDA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDB91895BCA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF41DFE22;
	Wed, 19 Feb 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErDxbRHm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0651DF756;
	Wed, 19 Feb 2025 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967283; cv=none; b=FBWS1pXAj4W27VG8R/isaJz1o7L51HhBTQBT+uf4jXANyMzZagcoq4E4PTjnn8AQmW0+itNKGryrZakyZBj9cFsKw7XGLen7uzmAxxzUPHKBy0wUXAKFqhi8AlCU7Gp/zwqWnA5ZAZ8dq/bz7S7RDfLswSUMp5hr/A3LjN7REBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967283; c=relaxed/simple;
	bh=OrCOpJddM6LIg95vdctyswCAmgotAgsL7ljevbXOtdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2+x7yqRcy8Cnd2hR9BbYZLGh0qUnyEE1LkqrUva/USctWQ8L05HKBQDHkzVepe8WT1752G4TzGsiDIjotw2tYdKwurHtq3RiWZ1eK8Md+idPEq9YImVSQPERUyueHUSt8DU0nI7/1MTBCA6DkPoItdtODsFHOCKWKo2QCMC+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErDxbRHm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso72771335e9.3;
        Wed, 19 Feb 2025 04:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739967280; x=1740572080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ab22A3ykTONxROH1D8ihC1zZqBmC/DXSXlZBaAR5siw=;
        b=ErDxbRHmVhQ+nAnJl6FfvPulT1E/WMP2GDK9HAR6wNoNGlKTLCZFVr8aFwplLabLqj
         e3rqVyPWfnO6k/wSplJ+072VcK4+8Ems6qbBHshzTybKE7/316/k2E+NzbSfHniBxXK3
         y2IfLmCZHQK6FiLkWIuKdt1wokBuiTxCSvoo3DBySB8ytzvu/IzGEpqehhIQROB4dTVK
         ZbZ12VVXzWJ6ZL4N3fiTMg7WdGXHDmIOME14HgXOTB25XdbC+/0FbcgiPH66PoZeFpB9
         ZEmc4vIVuo6nR8b67pmlPqHjm9+OEKqjbwMCxlPFO2KQp34iWI18KjDpFbORFG8TL6aB
         okZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739967280; x=1740572080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab22A3ykTONxROH1D8ihC1zZqBmC/DXSXlZBaAR5siw=;
        b=WFxKuVGtYMp0UHdzGh1t1ElWBSH+ecfDyyc1xCLYBRL2Kk+0L//S+BWXJWdyZfeRse
         naeNr6EOi9IdOFKXWOfFbyIaDYOZDXNsEK9xgAgsrXaw5iO7x8ReOSTz49+pFbpv3DjW
         eUW1qvJtsNab4eBpBAbdVR/xqbUuwP4vad3pTCNVfuTNIGbM6eh7zQYRCiXlYu0UzblY
         VBpGtuDXhs0Zbf+Xb0trsikkkrcJsJYQmqIBQ33fx4pz/Vb7uUaM9Lt/Xe3VD1zeSGt1
         9Dqpj0SBBVKMwbF2QtNo7q0mYufjAUqa9FgEXgikNNCXmU4eGzwbXcoTP7nmfzb/t2Wk
         VO5A==
X-Forwarded-Encrypted: i=1; AJvYcCU+jGt7qY+1ZKGQRD8zo28DCemGzgUCpr9b0TqLZhaW0JdDSa+BV4giBEs2PRMryYF562qD9/exjQzrqPEv@vger.kernel.org, AJvYcCVrO+22iRYmDe7YezX1AKX3SJB+RKcfZa34pFWl1s54tXGFpqXitKL3h/cSmOJIoEFX7vL53vybwzxV7Q==@vger.kernel.org, AJvYcCWBsTRvFW64ohC4dGe6WVE6ros03pJxK7YNVGjP0Pk4HpP1evXf/oezno7GeQUfpKDOk8/M084F88pUtq3ptoo=@vger.kernel.org, AJvYcCX8PY2aOSUuIqoHMQcfhGEIsCeUT8O0C/o4VfPuH0kPiBeRplGzHSQOybMJQAgcoImpa72jYR9C@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtBtvWSshDYnfIn/52dCa1Rl7PCQJPFNWWhElgAkeTcese9PZ
	6fD8FW3BUoV694hbUv4XFI20Vrc/5E3OQjE8rAml2pPqjqE7xhcU
X-Gm-Gg: ASbGncsDjfVmqlCHubo6/miHM8W5ZqiScNM+S7ZZMVITY7lxDbgf7nthKxW0K7dq/2l
	3ZR5FjY+l8aswnJBcoFwlEE7tz5d3XW6ESfaY6y4VNJ3wiCU1owy2oQlDs5WU3OgYwJECn26sCH
	Fdh22pEyVaYW0PCFKV9W4fV+YpHcrQ0jk7G/NsR3VYomMDoHs7IhHvA0kdesWEsRmCKS7mzPen9
	avJ488Jnw/Qocmv444xKFYHTer4dbba6VRFKIvWLQdRyKf1PAXQ0VDEekpusECYlzYEfwWoWfFf
	JiGo/AwL5KD5XmDeg1NoPGfIcXkTl+88yiuJ
X-Google-Smtp-Source: AGHT+IHdcRGrtJIfHWDw5Xxi+7H+Xxsa/a7hetSgJLdRQEFaqnW5KIwrD6cxhu8p4gfgESp/yZhb5A==
X-Received: by 2002:a05:600c:450d:b0:439:9dec:b7a2 with SMTP id 5b1f17b1804b1-4399decb9a6mr16062575e9.2.1739967280042;
        Wed, 19 Feb 2025 04:14:40 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982bcc607sm91022085e9.16.2025.02.19.04.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:14:39 -0800 (PST)
Message-ID: <99543a40-2a57-4c10-8876-cde08cb15199@gmail.com>
Date: Wed, 19 Feb 2025 14:14:35 +0200
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
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250218131345.6bd558cb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/02/2025 23:13, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 17:53:14 +0200 Tariq Toukan wrote:
>> Maybe it wasn't clear enough.
>> We prefer the original patch, and provided the Reviewed-by tag for it.
> 
> Can you explain what do you mean by "cleaner"?
> I like the alternative much more.

Cleaner in the sense that it doesn't touch existing code in en_rx.c 
(datapath), and has shorter dereferences for the inner umr_wqe fields, like:
umr_wqe->ctrl
vs.
umr_wqe->hdr.ctrl



