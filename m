Return-Path: <linux-rdma+bounces-5251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC56991AEC
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0901F2294E
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 21:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01625165EEF;
	Sat,  5 Oct 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HLKY5YtP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620F13C908
	for <linux-rdma@vger.kernel.org>; Sat,  5 Oct 2024 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164751; cv=none; b=TPFsnr7mqBmZwUnxdy5spNCDfXxJ5ZS1AlTl2df0FZBKPrS5El5qSu93hmXwrd/Qm99czQGc2WyVib0bmaobOuDq3SRGG9UtQ3tePalcEhFGBKe4X8sKGn35YaWTNmNwESXtjtMQHu/vDG0eDfaQZ5+8ohRk/3bdQna596Kj0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164751; c=relaxed/simple;
	bh=o1c3cH7WiFg32NGuM/T7GjljhaJCu7xpquK2HQfv9JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OE0236ydelZH73xbtpA0scJ+dSed/Yn50lg+4MtvS28YXIS/dYZavhyLh9Kj4muvSHhz7tV0jJ7VgAg2BzY8fe1UavIcbp08ZMEXEGanw0GISRhVI6OfvahoEDusf9tdhOEgE1vHy4Gj+WwpQ/xw3MbglODenieHM55m0JNdE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HLKY5YtP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71df468496fso713157b3a.1
        for <linux-rdma@vger.kernel.org>; Sat, 05 Oct 2024 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728164748; x=1728769548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmK9Xs58S08yxjMtYHm+HrNkToU7fdzXxnd+5Lv0Xns=;
        b=HLKY5YtPjtUKo7jhhqV9yBzei1nMDYPYei3hU4YT2IWqHgQqRCs55cEBhKE90rBUBh
         tcJQcmRby6hxqA9zEFDoldHKyTU6VVYmb3UzW0dN8iWJpy3V7FjAgBjZz+oKUe18n3nN
         8axpnJBlk3smY//dqMQwcy4GoXrlAXeB1FtSjP623H4FRUTYVaRWqtskTP4zlPSQS5Dv
         q/jOgfw4zqm8WOeLxKkHuHp3BhZnmaic28B+K9v84B5i/gMjSqxygO0uuEcLqUSEwJwB
         kCqAVRWVw57fuB4nFH7OtAijyXR0hHcrluzPwPKfNt0hUdcOjwt/vmXp0bSTm9BGZlyT
         FiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728164748; x=1728769548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmK9Xs58S08yxjMtYHm+HrNkToU7fdzXxnd+5Lv0Xns=;
        b=Jct1/O5oChzbHBW+9Jwaw/SovP55ONr+xUq+p26qr7Trbbw/DITDeEHQlzdwQpiKCM
         TeUvL/+ZjOCk+BKo3bnFc/hftMNo7IHoNhOUHt6kqMEw7okHQNyMdE81l6RceZFjPWEY
         4XnPMDPa/fJncxnEEEAtrxeahZYZt50ylXR+yi48g4GsPveqWFtZqjcluwf7T6UeuM6Z
         zuGqOMW2UHPaOBeufEwpWCh07Cq0rm3OrEiMrruS1UhsZI+6D27WQEyQJ559aC5SdUOU
         LW5fAe+/uwSdPRGivmmUd/tPW53d+podsNjxrUHYKDNKDf3hrO19qy5rE2ln3K+Jy91m
         Wj6w==
X-Forwarded-Encrypted: i=1; AJvYcCU39umm4jyAIY8HAa4m+V9nUXFkwH0MalWZ/xpRMI5IShoLGPKnlH4EoNXdadoeiv6chW+YpV1uHga2@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/xyJjOodaF8tMtFE7XaWSUsyPOTcI+bGy0mbnrx/MKV0SLut
	bU4tF8VK1LmeVPQr6QTRuXNvUZCemNGL3SzJEJ/9IQAtyvlysjAW3JlvvL/DgbE=
X-Google-Smtp-Source: AGHT+IF2CIeoWIaR7M9L7MG4cg5BH98dJB3GOpxAS+7PQNC9MiHoMI9+gMzk9ipUOljcrFRhvDz1NQ==
X-Received: by 2002:a05:6a20:2d22:b0:1d2:e504:52ba with SMTP id adf61e73a8af0-1d6dfabb7ebmr11814308637.38.1728164748471;
        Sat, 05 Oct 2024 14:45:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d69246sm1882056b3a.182.2024.10.05.14.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 14:45:47 -0700 (PDT)
Message-ID: <dd003ffd-c63a-496a-8585-52fbb08c2189@kernel.dk>
Date: Sat, 5 Oct 2024 15:45:46 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
 <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
 <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
 <d5fe08b6-68df-4d67-8870-dd7ae391973e@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d5fe08b6-68df-4d67-8870-dd7ae391973e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/24 3:36 PM, Bart Van Assche wrote:
> On 10/4/24 6:41 PM, Jens Axboe wrote:
>> That seems over-engineered. Seems to me that either these things should
>> share a slab cache (why do they need one each, if they are the same
>> sized object?!).
> 
> The size of two of the three slab caches is variable.
> 
>> And if they really do need one, surely something ala:
>>
>> static atomic_long_t slab_index;
>>
>> sprintf(slab_name, "foo-%ld", atomic_inc_return(&slab_index));
>>
>> would be all you need.
> 
> A 32-bit counter wraps around after about 4 billion iterations, isn't
> it?

I did use an atomic_long_t, just forgot to use that for the pseudo
code inc and return. Though I highly doubt it matters in practice...

-- 
Jens Axboe


