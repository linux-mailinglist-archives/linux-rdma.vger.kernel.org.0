Return-Path: <linux-rdma+bounces-13138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67237B47A7A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7367B0F4F
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D323D7D9;
	Sun,  7 Sep 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoH4tNnz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E81E5B60;
	Sun,  7 Sep 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757240801; cv=none; b=Y4W/hSnJLvyuzmCqTOL1DnKjtxFtfC1z1lK0dooQmQGHq0CpLdlDWfSYV2N6O6LQRx3ZC8MhAMOKyYTZLjKOjHtaJzm3E7N+5w9FWE6srdhdleQTq7IiKoOAXLmO/Ux2BEN7I2qpfLc3VKCqJI9ldOb/eNrg1ncY+jpcQ+ZdY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757240801; c=relaxed/simple;
	bh=j0BNIKPLu6kITVm7dRIIVVO5dxVqD+hLPK5UTciMXLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l55ESGNJTj47HuiCXRyGaLl86PzrFUt9DYwmPTrp2FAIRCsGxBzUCMGbcyok1KH97zRqn1Jrk9cqHozWVR5slwl3jbC/wndKDX97moNyZAvRtrOTIVz/b9jsyhNBGuhp0ImhzCt6UxRdKehTxdzlQUAob6iYHs/QlQzUYHGZIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoH4tNnz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dce6eed889so2928815f8f.0;
        Sun, 07 Sep 2025 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757240798; x=1757845598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ub/OeO4Ey/xCKSFz+e91m2gN/bnOshOB+I7kpG9dQw=;
        b=AoH4tNnzsJcpQxmUBVgdkhhm7Tc4lFyy0L4V75F/UmBKYC+xQfvcXw9xBExKDVMOGN
         mwn8PlxJxbM44vJL/B+pv7PS+IaMzkTIpdfmH1CWCjkN9yC6waYOztsWfBH0pekGkuEB
         JXxF4uwgRsH0FuL1GFD8R/c+QOVnZFHkFaL+x5FrEDieHKfAJBoV2cqrWKc7g6oQZe32
         bd1od5OEpDlRAV0UduePtwiMzadASkyny2TIZ/EHOjysuncSZaDb0o/KQmMnq+Kl7bFz
         GYUYaW2XmzaVjFG/rZrF5eXnO1Y/jNK8cGNc2IOFZ3c7QVYAuEWMcT2J3YdlVgYCyGwa
         RYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757240798; x=1757845598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ub/OeO4Ey/xCKSFz+e91m2gN/bnOshOB+I7kpG9dQw=;
        b=ow8DDv3F5Em/GrYlWf7oTsDD3QPexbZQ1F023Rzus82c2GDwh9tGze4vWC0Ejlz31o
         bQWH9Z0/Z2Bm0wUKmFDwS9LIbOzf5BlGILD8XJPpBobtI3p32TZbtum5U77HDDMaBq9w
         AHmHGzMAUGQM74tcF4j2Swy66QT6W9o/1ya8iq2A80ZA2J7PU3aD9y+Jcgp/oJuxVJ9C
         gBfIYrLPZ4l/Dg2Kx0aCM05kJuC56VyctvKUTcSz5T1Q2e8OM3wGzfuV8s1zZgQlh0kh
         HtJEFj80Fd2+OxdS0Gp8YETjlPbPzqXUNtimaCjWKrV9sOiwpZNNB0ufnppxtw1guu1b
         I/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6YvQwClxlvt7c8gZtL8l244hE3USGO9gfmJepoQ87l2o0OTWWH4lvQzHdOrrxKDPR4m0np1btCXCIeK9L@vger.kernel.org, AJvYcCULOG1cqQcqpokPmajhQjtWjoJa+fCIvD+qHiACH+SDIoqZVBJpvq6QhqyYsdel1tZ3SHF7fmti4OJpPg==@vger.kernel.org, AJvYcCUrYSMYHcMNC87xT5nnvIPdw4zO0og5B0wlyEUAAlYUUDMK/WGgR8RWxpPfRjDnQNx9oKkBiQs3NdY=@vger.kernel.org, AJvYcCWZpyZrZ9sW102LSKg2D0GaIPSk8EKAMuC4efMpEjBxec/M0ZeAg5WFYnHFYOgWBRVCCKy91GVN@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKis6WDR7KdhAeMNEKmGCC93OpcrkHQBGaWZVMTCtTdPZHj8h
	Zki9I1tRwtG7E+TbTJyvFKWj1Pl7+9IAOZYtVZpIHcMK/C+leQJDOhHk
X-Gm-Gg: ASbGncsVJk99ofTYbsT4cP1bVzJCWIpTxRpFikZh5vd+MXLdD9hK824JwgydEPv80RJ
	nai2jjkCb9gnJ6nF6Hzq+K/84l7h9g2uT0qiwKMAiI58IS1Vm7IrqdHVXUxtHhgBWOmgpe/3k3E
	CYQzAi/Z09VV1f37xKBV0Ha/TETirtKGuv0rGZJmjV1Wstr1imsuOZ6Yoik5jpO2HdkukRf/Jf2
	99UG3CJtnUtl/iR5bW+2MHZ+pnk3IfXDEvwJeupPowkIK7AMcLKrowIO+He/g/YnwJmp9YM65dj
	yWDXaoSLbBv6i0NZzCyBII2OWLc8yH1y3G7cRgH2nBAR0kBtOzj/05KHVH9zAS4Hxxncz5hYX9j
	flIHOpFIlguuP9Cjc5YaKC5eKOlpEWvOVfS88Hb1BfkhzDw==
X-Google-Smtp-Source: AGHT+IEHoUHEpi7kdcR1qyeyqCuZmm7CeTOzzxcChwfJwz8IYsmf5FbXPKlypXKns5jwvQy/dUXj5w==
X-Received: by 2002:a05:6000:2489:b0:3e5:2082:8941 with SMTP id ffacd0b85a97d-3e642f9050amr3249710f8f.23.1757240797792;
        Sun, 07 Sep 2025 03:26:37 -0700 (PDT)
Received: from [10.221.203.56] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d95df59e50sm22569210f8f.23.2025.09.07.03.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 03:26:37 -0700 (PDT)
Message-ID: <2dbde1ef-cbad-40f6-a1de-12f27dc1560d@gmail.com>
Date: Sun, 7 Sep 2025 13:26:35 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net/mlx5e: Add pcie congestion event extras
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/09/2025 12:39, Tariq Toukan wrote:
> Hi,
> 
> This small series by Dragos covers gaps requested in the initial pcie
> congestion series [1]:
> - Make pcie congestion thresholds configurable via devlink.
> - Add a counter for stale pcie congestion events.
> 
> Regards,
> Tariq
> 
> [1] https://lore.kernel.org/all/1752130292-22249-1-git-send-email-tariqt@nvidia.com/
> 
> Dragos Tatulea (2):
>    net/mlx5e: Make PCIe congestion event thresholds configurable
>    net/mlx5e: Add stale counter for PCIe congestion events
> 
>   .../ethernet/mellanox/mlx5/counters.rst       |   7 +-
>   Documentation/networking/devlink/mlx5.rst     |  52 +++++++++
>   .../net/ethernet/mellanox/mlx5/core/devlink.c | 106 ++++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +
>   .../mellanox/mlx5/core/en/pcie_cong_event.c   |  79 +++++++++++--
>   5 files changed, 238 insertions(+), 10 deletions(-)
> 
> 
> base-commit: c6142e1913de563ab772f7b0e4ae78d6de9cc5b1

This has some trivial devlink conflicts with the other inflight series:
https://lore.kernel.org/all/20250907012953.301746-1-saeed@kernel.org/

Submitted in parallel as no real features dependency or order.

We'll help in resolution if this gets relevant (i.e. in case current 
version of both series are accepted as-is).


