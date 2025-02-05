Return-Path: <linux-rdma+bounces-7414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616F6A28457
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 07:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C861E3A571F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF432229B35;
	Wed,  5 Feb 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIQAlN5A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB622A1C0;
	Wed,  5 Feb 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736574; cv=none; b=d4thyuPEY5H2zFsrLkAAkbxfZ+f+Eb/MTzab6X3KCtmOILirtlMSEtra1oKi/B8SSjcEKFqmn7a5dY6s0CsALVHItZKL7v3dHUlYR5s/DFM3dnLMomBCEjsrdNNRaMY1k17+TdvAO23UpAJIcSkn3APyP/xu6WGVXzkN2XE/hEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736574; c=relaxed/simple;
	bh=2FwMGYOk8g/lmGNTCCDHr8s4TgW11+7c9hjPFP6vTEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7THFiPTfDD6B7Fnh6gjGLrdTKfgbHg8g1jzfLmLwTPNuIX+a7jLKnskXEmn02SF32EXaBrlvYxbnljupPB9OhNhzqVcKiE7Ys2G2mdv+00S9VKJQyr9F9JhQiVxmZILoRXkE2cACLSEZ7YWQ8Es9G//aV321466tM/zsqjDFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIQAlN5A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-438a39e659cso43523635e9.2;
        Tue, 04 Feb 2025 22:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738736571; x=1739341371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zgadaiki1GffcemlaJzJ1O0JT9RvcSk5B1GXHuZV+P4=;
        b=LIQAlN5AXsLe7fPJ5s8hZR3vYjnfHaWp0iQDfsAzvSSRwbX3H3sxxPysAfurSe+Cb3
         of06E5PsRHJSjBw/GrHltafVDtcfUKHvfzNggPbbuIqxvxQ3SIuJBUy5Ifrs8A0jQIWD
         f1UxfXwvAOLBK7ebsoff5Zg3xRbGwwpyxb0mVfdfTgwNj8mcmGsho3i3ZCaPjQsq2onc
         t5cbk9lUxemJ385mJDAytg7wBt+NMM2FDjrBOXF10Z5txTZypZ7wLaplX1+FSpbKN8tT
         V+wb7efe7Ac4lJSGKh8zyCpUd/slyMzQqliPOMe6nxSVYYxJp25L38Y9dHJbMeAhZ5cK
         YRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736571; x=1739341371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgadaiki1GffcemlaJzJ1O0JT9RvcSk5B1GXHuZV+P4=;
        b=LZhWwUefJ9bRm06giZh8xrlOOk9Uk9RT+4ps3IPvNXCNHA4ChqmJrLfU7ryp+M0xfV
         fwJnVBKzVYnb73o/AblgZswZGC1Rd8FeJ6vKvv5jwpQdHnptVU/89id3vfGw6oGhQyPz
         I/c3RbL7jA5pXercqm+WwVUvvY2PcfrT9K2YNDi0xtA+NbDQO/bF3+K2iZnD3xm7glLZ
         M4cxbq/n2V3+5z2ggyiWIDTOAnv1rVWb89ytxvyFHENvRQ0Slq/Cpbi4vhTT/pjXiByF
         13MSQY3IiRqV7JI+HzI8QKkU6al+i/hlt7Cg7B/a0Px6qBDMWnyPLzgQXqUwsI0aPCTg
         qq0A==
X-Forwarded-Encrypted: i=1; AJvYcCUdLN9+meiILIaAMbVNCrVoxuqyCQ0HKmoRhDZhmoGdFlPdyxDgOaML6aTC9JjnsOzeVGrdHl6hUS2L@vger.kernel.org, AJvYcCXZqUmrVSzTIYjJaJQU423PRmyiSKjmxMninG8Jq8CHUgpQ/6iMIKi/JQsRXAjEd59YagTrMH5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwP34LgtBDQaVZ2tvDGkN9Dq0Vl71HZdyaj8O9aKG1MjvBmqbiP
	bVhZP7oSMJJVT+EPUCNoxbNc46wK0UF14yabLEOc/nzShC+EVSTEXep0YA==
X-Gm-Gg: ASbGncsieCNzavld92qRdiemHFGquWMmKyMM9bj4JAunKCGwN5pg2JAydbn88iwgV3Q
	ij/U3Pmy+hGT3EKFHcTZNZ6Geh2KQ9Dyt9BSNeUyFX9Fj2BDTfmhkRpP/r9HFNV7aZzLF2qwRut
	ihU9a3ropv548ZmiUl292iXovuOdDgupZaqVgxehu4/QRGSvSIEVWmX+8D65ofSh2VPhqNy79kp
	yV3LTi1hHsc5gHfCX8y9Lp+7uzgJlkNZSeFXtTPYsDgfz4fa/3dAOsy+AoHOoj8xV/nJBzwEX/A
	zzLGSy+xM5u9B3qEbBDBE68RkFHKbrxU1zpc
X-Google-Smtp-Source: AGHT+IE4kc75mBchz+3cmEtMGpUmvdAv7a2W/KBHq87O0SGq6n2GfSGkUIn9NrZ1DWwop5WIBfwRsw==
X-Received: by 2002:a5d:6d0f:0:b0:38b:e32a:10ab with SMTP id ffacd0b85a97d-38db4857d3amr758956f8f.9.1738736571032;
        Tue, 04 Feb 2025 22:22:51 -0800 (PST)
Received: from [172.27.21.225] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38db1deeabesm1977401f8f.22.2025.02.04.22.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:50 -0800 (PST)
Message-ID: <0f3ac6e2-80be-4df2-9b4d-61433549cc2d@gmail.com>
Date: Wed, 5 Feb 2025 08:22:49 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jakub Kicinski <kuba@kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
 <20241204220931.254964-8-tariqt@nvidia.com>
 <20241206181056.3d323c0e@kernel.org>
 <89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
 <20241209132734.2039dead@kernel.org>
 <1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
 <20250120101447.1711b641@kernel.org>
 <a76be788-a0ae-456a-9450-686e03209e84@nvidia.com>
 <8dbc731c-2cff-4995-b579-badfc32584a1@nvidia.com>
 <20250122063037.1f0b794a@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250122063037.1f0b794a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/01/2025 16:30, Jakub Kicinski wrote:
> On Wed, 22 Jan 2025 14:48:55 +0200 Carolina Jubran wrote:
>> Since this worked and the devlink patch now depends on it, would it be
>> possible to include the top two patches
>> https://github.com/kuba-moo/linux/tree/ynl-limits in the next submission
>> of the devlink and mlx5 patches?
> 
> I'll post the two patches right after the merge window.
> They stand on their own, and we can keep your series short-ish.

Hi Jakub,

A kind reminder, as we have dependency on these.

Regards,
Tariq


