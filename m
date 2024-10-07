Return-Path: <linux-rdma+bounces-5274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885E993337
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD529B25D54
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6AB1D2711;
	Mon,  7 Oct 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iv9uD9EV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AD1D2717
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318497; cv=none; b=JO+tTl8X+CZr1LJ/L1EGHpR8ywGweO7OmBgA43EiAe6DZ11kXCBHCYLAjlyxy2w/6UWH8P++kYNZLMb8uLTfAQBXLDmRo2jktehBV7c7XQ8Ydv57h6rZqtHgmDfCN4Cnxohsz5wF58XlQTThtpaiLq/RJVJVoJ0AudFIUKMHvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318497; c=relaxed/simple;
	bh=cVAXMTJc5+aH9jC031E0s7Czjoij90A/Iw/3xzOeoGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCQuIPJAxsYqznERwyv0UCH11mXmu+mf4OmQ0bG4f7MFk1YWGuUEhluomu10HYdjKxjJS7Q7u3IfBEdIK6SFQSdbrpZwhbpl9Euq+cwsjLiA5zfELxeYqvvFOFyEVzJCyjr1P3lLXkjvr4cjOiIM73S/IwbHKe80o8f7kR5erww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iv9uD9EV; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a1a3090f39so17910455ab.3
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728318494; x=1728923294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4paSolghygsRvIMo8bBzAx56hUaijypQszvk5KlBUGc=;
        b=iv9uD9EV7hmACwyfAdxoRJAlbJCjeNOEFdB5nvEoVeelmf/YgMIyxNLpEdYxVMhRRs
         cp39ed4nIbiwog78gSoyqf/BqtoUkqGx5I0y2C+5M2uO+4GWmQwQW+y7raW9qEYOoTBs
         pxF3SdNy4Qby06jzG5b7qJViuZEpZrnWdjGddkwXs7Tw21PvLo6H2nBzNSxBz/gCejk8
         /EGjxh4mFPOJ/iuqZ+BOFKbIHfb/f2xJy3WnCY0k4JWXdW7CbRPj5hjmNyENf9vVrsd6
         19Y1dArfgXGJM1Mse7yeYz4faWlQ3VVvlaNgxkv6Vt+ZHvwue7JIkvedO1SZrSg4dIEQ
         5/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318494; x=1728923294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4paSolghygsRvIMo8bBzAx56hUaijypQszvk5KlBUGc=;
        b=YnEzLhDiXz5FXor7HHyRtM7QjLWK0hWWkJM2P24IChyLploaMCBNlJFD684+QJzkTp
         LTEpvmQN05dUFCXABBQ4b8k9VKjT/NTlrpm8+abx+zwfC2HztAwD9SKCTwtag76QwG6M
         gtchuA8EoUvnp+FCB/Su2r8GIhMTg7G7/EOeuFIuwMcn2FSWSmZN1tFxzg2u6aNVudTM
         4uXCVVLCndodhiipRWchlVdGISmOsEL4pQJLQ7u6NnBmFwVSC2VZZcGPM+ngoqIlh/zx
         6h8jfKB5mVlY26UC+WLlEalFHTyFgswfbZNBQ6dQZrUL7RWjxuzz4k66H0ry6zAnFuFr
         Pv2g==
X-Gm-Message-State: AOJu0YycvUtpWx1MluaD5OtDQsoMTrI/BSpQa8gW0tSYvsplnlXD6nxf
	UxwqcauoRySIKYN+cXSqp99Kuj+DViYHN4rXrMT/7H5bhDNRJdLJ6sxqQuHypcY=
X-Google-Smtp-Source: AGHT+IGKl5Yf0gwc4g2imGdURMP8wfA6arSlbq1uTHkj8c8luG7IQukey6hY4+yV2idgion3nlR9Gw==
X-Received: by 2002:a05:6e02:1746:b0:3a0:9b56:a69 with SMTP id e9e14a558f8ab-3a37598af76mr110812635ab.7.1728318494407;
        Mon, 07 Oct 2024 09:28:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a874b1esm13705225ab.71.2024.10.07.09.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 09:28:13 -0700 (PDT)
Message-ID: <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
Date: Mon, 7 Oct 2024 10:28:13 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 10:14 AM, Bart Van Assche wrote:
> On 10/7/24 7:06 AM, Jens Axboe wrote:
>> Still seems way over engineered, just use an atomic_long_t for a
>> continually increasing index number.
> 
> Even an atomic_long_t can wrap around and hence can result in duplicate
> slab cache names. With my patch it is guaranteed that slab cache names
> are unique. I'm not claiming that this patch is the best possible
> solution but it's a working solution and a solution that doesn't require
> too many changes to the ib_srpt driver.

Come on... The current patch doesn't even check if ida_alloc() got an ID.
Without that, using some mechanism to alloc+free an index is surely less
than useful.

-- 
Jens Axboe


