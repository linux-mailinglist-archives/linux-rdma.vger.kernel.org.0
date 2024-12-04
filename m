Return-Path: <linux-rdma+bounces-6220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B9D9E33AC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 07:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52B6B23798
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 06:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DDF188006;
	Wed,  4 Dec 2024 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzpLuMQ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD6183CC2;
	Wed,  4 Dec 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294852; cv=none; b=Xx+WSPK0NT4ArVY6xKVzg/JHwWZMFI83Tsqt0LadWOjm3cx2z6zoyjygQ9gYltNTAyJXjgAFiFiBMHv9XwrE7tO/xiVM52qSYZ222YU63zWtBo3OTA9H47yYT9qA7ospe5OBbVaKda52QYNAJDQb2A1PrlKJ7UVMHsxON3UKD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294852; c=relaxed/simple;
	bh=qD0aj1MEF48v2o0C6Q6hDk6kekcWz0nkZQLjVcE7qh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3tuZEfeMBVDq6ikHF/XwaYFI8TU5q0cqCtzbXAhFBdN1rbBHPTBSAvqIVQGJNK0Le5CBriQ17vkW7cPyzU6q/D/34Rtcjq0lBB3S7dGGRwKH6fcwXkW3RF/VNKmwiER315QLoSm50aGbSp/AYudzlWMomNA1jU+dylrqDZZqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzpLuMQ7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a8640763so52727235e9.1;
        Tue, 03 Dec 2024 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733294849; x=1733899649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jX4zgEUUIkSOLuEe3qGJFlCiJj5u4kDgmYlOqDuEfy8=;
        b=BzpLuMQ7CjVgxzC+rxpf4FaZVMcYs9cFIPoaYL9zxx722md9Up6oaC1s9/Pt53FpUE
         TsqYKi9IZxcaUAqTb5gOkx+He4UftqbKmyI5SE9ngUXX8nZFeezdoInpxotaZYinEdxr
         lycVXZnaxgsTbC8ulAb4WxrpNffxGp55rJ+PMGc7FthpxhbrdGQcxSsIg0KUvrBt7CNi
         Fuyx8Zq2keIHrmeRhpd5tvzFPrRd9sYbg7epGM5M9DwIz9nSxVDUF9lznga1ZIhTg5lG
         I9BuVptXaAmPkn2H9MV6f5PBAObkKpR4H2zeMdhhfUWYAKLAZf2kl1k2X0r4vP08/r5+
         2AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733294849; x=1733899649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jX4zgEUUIkSOLuEe3qGJFlCiJj5u4kDgmYlOqDuEfy8=;
        b=T7EQVBTRMI6PJMprmnrNoRl/bPJvk5pttVzMLS0NKnNGtFFrqaMA2nHV0TN4cf2TFL
         mG6cQrU39HngSCETPeV638dF7b869p2YSoZY2UQBPEqQGP81OJS/7DO5KYWU6BWZfPgs
         LCZglYLpk9bWa+pbdzHWrm6cR2+lrCaL8yJW65WYmxBrwGgidc4+EtIhuXYIjQ9wCwJ2
         hqFq13eJFiIw8wn2hhipOJWk+jRKASYr6TuTfkmBPWX0A/tPwnAGTf3AIeqFa3egb035
         fTIv7r+4JQrMaXIroY8ADzPEHn3IoLTWJdij4oD36Df4ZtIC0YNotrt3mnwFrvssk07I
         aiBw==
X-Forwarded-Encrypted: i=1; AJvYcCWPMPPGTVyGp19W3zzlguybsS3qJ9llyNzleoFArzqNZ1GuZFy/ex1BdXFERDsQzKIIPx1ywE24vjBi@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGNg9Vl8eQ/mNP5xEQbe45mkamQ7HP7NCfPE0dq8KxwVoDLNy
	8wbEqnlljpOvGGjMXrhS2D63iDO7axhQF+7QrwLx2VpS6WC7q/d4Bf9j1Q==
X-Gm-Gg: ASbGncuyT11t3+vPmaJrvnKNRFRLhtf99lfo2INZnodNZpwoax5LqaxMdsbesEEPu7h
	YY1AJ5QeDnrb5SHmkeGNHXpYTsSbnfspAkCeUGs9FFhbbluyQn7X2xHmNlFm8DmrX1hovC8OvTs
	rxLm7gkbrLiOI7r1Ygd/bBifT0Sml0yBc6tEvfikbD75NanBP0GTVfuvCErxZqBQd/strpLgPbU
	w4Be5T1JtCGvCltjXGs14ELzSqqQQqLz52hw4cPJMtCQ9JK9NOd3DUPrO1uRziSO/A3bDg=
X-Google-Smtp-Source: AGHT+IEDuZyYBXWHgKLHNipFDuVddRsZtKGSDtN9tzgymNcV2WBsWl8RsBcQHfEnHQKDvozc/CjUhw==
X-Received: by 2002:a5d:6dae:0:b0:385:e1a8:e2a1 with SMTP id ffacd0b85a97d-385fd3c59a7mr4314737f8f.3.1733294848698;
        Tue, 03 Dec 2024 22:47:28 -0800 (PST)
Received: from [172.27.34.104] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f0158172sm8572469f8f.16.2024.12.03.22.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 22:47:28 -0800 (PST)
Message-ID: <918fde1f-b6e0-49ca-9aae-ac4c7150e3ea@gmail.com>
Date: Wed, 4 Dec 2024 08:47:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 00/11] net/mlx5: ConnectX-8 SW Steering + Rate
 management on traffic classes
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-rdma@vger.kernel.org
References: <20241203202924.228440-1-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/12/2024 22:29, Tariq Toukan wrote:
> Hi,
> 
> This patchset starts with 3 patches that modify the IFC, targeted to
> mlx5-next 

First 4 patches to mlx5-next, not 3.
Sorry for the confusion.

> in order to be taken to rdma-next branch side sooner than in
> the next merge window.
> 

