Return-Path: <linux-rdma+bounces-10710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C3AC39C2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 08:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604AB1891028
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 06:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3991D799D;
	Mon, 26 May 2025 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIyuLu+C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2488EEBA;
	Mon, 26 May 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240562; cv=none; b=iekFfdV3zZO73ghlEKfT8C0ONtYsWVqpV11RQfcj94X80lJLsXhZjrfo19qdAmQ3ydXShwJNYl4x3ueHU4e4uUhMQqUFEgb0rJKQwhnpNa/mfcH0fIKMFNRf9qDBfvoFnr8UWjRyc39Kux760pR74PVbpjgkuVk/3l4Q2SP0Rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240562; c=relaxed/simple;
	bh=hnnZTNDaZBUCR9K0SnMBUDR0UhPpaMKzyE8A//b2wNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq5RS1NCusSVNbQ2r+PqYabmbKQ3ISIki6shTYHmjGdo8u72xbi0f/ZWqiBlXmTHOJRBtXD1jCU7t/Le+MVoEiQ92AE6PkV2HD9vavSWuB+ZiXMF47aYUl5X3qNnlAkP+VcAtImlRQP1qkRMMPqAKrit7LS8hjhWbf2bvabu6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIyuLu+C; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4cad7d6bdso1152274f8f.0;
        Sun, 25 May 2025 23:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748240559; x=1748845359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tb3rSzekXqFF6ENi4VattxwMV28CbiKc//xu0AGGt8k=;
        b=UIyuLu+Cbx0rsHByBJN/Qss7wG69nTMNZxt9k2QGZhRLcY1MngnJP6ON4BHP3d+VfF
         g7nKt0l5rvbBk+ffu6Ff7trAee8urR8zNpGLEtjFWVstRDCnbM7BQiYu96jC4Da+6g22
         uZjHLbMM5mOaALv3uLI8Yv1i/Ppka92TN/yEwz+h7Ja20xHDBZXzwGPSH0YxJObqd+2M
         8/lB94lfOpekKiSY6qLuQAcuF5NKL9cA63ZHc5/sazIyjm2CGGuhKhrqbmkI2UXS4dYl
         RZnDC0ubbL67Y9Y1G5IPNYxzFdt8z4dk8LSZnmx3UtTh581Wo1Kml7JozBMIYwuJdiep
         qTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748240559; x=1748845359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tb3rSzekXqFF6ENi4VattxwMV28CbiKc//xu0AGGt8k=;
        b=Uuee0g/sBMjtAzHzYXlOp2VQKSLewHOtKaRY75w8nq3URpX8WUvqvRiniZ3o8dWnIS
         4z0xrlBP5V4jxeCvJFEnb/1WDXO58uIDI3Q0M0yBrx1PbHyU8wlJcHFE4+eQHT7Ktbu4
         6caMO+m68dviVFDqSwlSE86j+9o4tWWPU0OfFFtRs8nOPU9bqYj7hVklP/ZGTWZOztWa
         h+KH4g39THN6wTNdvjVIfO9iqGzqEOPpSu7tmbq+DPItCVHoXjeJS1ubYs3qdsoeSyZC
         aNM1uiKlKt86ohqup5ZqTxA/ChUSZRH8uvtClgv9WwdMX98VlQgzT8C0Z3zRDMVU87oV
         oGoA==
X-Forwarded-Encrypted: i=1; AJvYcCV8+nbTVTcES6Uee3R/1FGj6ZFMX7GCHwHEun6oufli4vmXC8gfiBigvOdM/vk1OIHjwF5htFFr@vger.kernel.org, AJvYcCVyJ5QofLxCkdu9ZjkpuyU2jXxheN0x/3yLZegmDi0HT5aCQpLqrQm8/wxqZ6NchOJw0BFU1UWrqNnXbyw=@vger.kernel.org, AJvYcCX4tI/J3dPgIGbeTB8nv7psW381LrYMeMPGwO7F7+clMknihz8W7YFjVuqIN43JhExaV26SppZ9ZSNM5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtSpL7WWcd5RLf+WSPvz4Pd+rZ0tBTXBlgo6KBHg8aVfzPOrB
	6LLoE6TrGN3QBCAhaHUN+aA7Fm42utGVBj8H/NV2x5eFuU5q7Ooxc4pP
X-Gm-Gg: ASbGncvu4n0CCUiIePOSYE8EBaCXm+f2aRKVpCzje128/PqWiWj2UX6e35AfDRGr5yn
	Z9aqM4FrptQKX2ExamC9UGCg1yXv3EDdbqTbNa+3w+rPQxGj9iWuhxGaTAJxeh7dI5PvXFPUHH9
	YIFSL9FA22Z+sBat+j113AByOilz0InJc6fFxWWy4RZPEOHcgXqO5t1AJBoiJgZyxa+YgA6AQuz
	/0rJTNGSk9y5qLTjXETKpSRTdgDPtPYLQJ+4InGQp4ArX3uCCvTQ96RjibWf0CSRiOmWjl7rIPO
	HB5xotOQt6EOLjvZ+fZPwIdR0WB/5BGeUs8iQqa2n3MnPmv6dkSKYL2ZAkxEDTbIDbC4
X-Google-Smtp-Source: AGHT+IG3ao4YL/f+dYXj4zkDZBrlvJ9mAc1gMop1MmEklYYpCoe+W/8q2crgZ1MBuIR145kcpM/k/Q==
X-Received: by 2002:a05:6000:2083:b0:3a3:76d8:67a7 with SMTP id ffacd0b85a97d-3a4ca544fc7mr6632449f8f.20.1748240558734;
        Sun, 25 May 2025 23:22:38 -0700 (PDT)
Received: from [10.80.1.87] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cb450867sm7123523f8f.57.2025.05.25.23.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:22:38 -0700 (PDT)
Message-ID: <3e5104a5-66cf-4446-9846-22c007fd8002@gmail.com>
Date: Mon, 26 May 2025 09:22:36 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net/mlx5: Add error handling in
 mlx5_query_nic_vport_node_guid()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250524163425.1695-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250524163425.1695-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/05/2025 19:34, Wentao Liang wrote:
> The function mlx5_query_nic_vport_node_guid() calls the function
> mlx5_query_nic_vport_context() but does not check its return value.
> A proper implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v5: Remove error tag.
> v4: Fix code error.
> v3: Explicitly mention target branch. Change improper code.
> v2: Remove redundant reassignment. Fix typo error.
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


