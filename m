Return-Path: <linux-rdma+bounces-237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9676803EFD
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED371F21162
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DE3309A;
	Mon,  4 Dec 2023 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iod9k3i6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0BCD
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 12:07:10 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b894f5a7f3so2698185b6e.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 12:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720429; x=1702325229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIPLlmHQePcPDi88/FNBqHJb+EZXhPB0+Wmzw+3R+gw=;
        b=iod9k3i6AqKrhLCebqhVABEW1oVy7PlJBEZUVYSZyaK2NoSuueH9SCOgKjZUWnT3w1
         C3qJ1h/xsE5CGnLi2Adtmzw0lLzAED3sze8HB18zrH9PhQx1VFD61K0UNsTIoC6cs7b9
         INO1U13VVrG2DxoYOQ3jS5c2CUAqdaDNqyyKyc5f7o2ofpGhkhj2YreMW5WRm8cO4hAn
         i9h9+0vaConYBHb7OWMDGJBWHW08NIIvNWd9tAQn+0AaZlAAkSITOPOPifapNhCAUlTO
         8VSUX9cY7nYtB7PKK/60w2pn3mnGwlqaKpxeH3Y3MH2ebLa4hIXlugaf2CBZXf5d3FnU
         4YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720429; x=1702325229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIPLlmHQePcPDi88/FNBqHJb+EZXhPB0+Wmzw+3R+gw=;
        b=MGpmgiEF/ydde2H7HY3bHoNHenIGbFEw5y2LsW0xMuRPlFRrhD79Q+VhfRrXyK3AzQ
         FtWZP96BooVfHmEj9S146SJaEJfHTVh5C5ZWO3kgvpQMrPjXVCjSkaPblvXUd9MupY+I
         Jp+NLXjhZ3jEYB6gYtg8HlZ9/bgr6EYLfJZmBzkvXS/l/jdnEJt92b0EWNoAdkmMy7rJ
         8X8W+1iKF1caHGniMzT4UEX324ggfT/12iQOj4G/LNhvSfdU/SZHXH1sAbjZqZVGuq1y
         i3c4/xf52Yk69N95adsKBO4aJtA9I1y6bdkRb3xG8Q3FG+9DyU0g0vO2hSOqOyHtcC7O
         1bmQ==
X-Gm-Message-State: AOJu0Yw+lokXWx/2nA0nKj0kUZ7076z1zMz5ELCp7cB6xkgyxfoaLd+g
	/GHffdfjQijhQl5KW5uHWiM=
X-Google-Smtp-Source: AGHT+IFA0hWPIYfSpMzIBWhllFj81yq5jbPtws2DZaJbnWZ2AsqJnn9livkuLYf3j5iYsHv8WsR0zg==
X-Received: by 2002:a05:6808:1150:b0:3b8:98e1:5583 with SMTP id u16-20020a056808115000b003b898e15583mr6447020oiu.28.1701720429341;
        Mon, 04 Dec 2023 12:07:09 -0800 (PST)
Received: from ?IPV6:2603:8081:1405:679b:e463:fe8f:1aa8:6edb? (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id b21-20020aca1b15000000b003b85d6f6d74sm1927279oib.57.2023.12.04.12.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 12:07:08 -0800 (PST)
Message-ID: <2ce139e0-8fd7-4ed7-af5e-83a9e4b55710@gmail.com>
Date: Mon, 4 Dec 2023 14:07:07 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v4 0/7] RDMA/rxe: Make multicast work
Content-Language: en-US
To: jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
From: Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20231204200342.7125-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Zhu,

Thanks for testing this. It turns out I needed to take the sk_lock for
ipv6_sock_mc_join/drop().

Bob

On 12/4/23 14:03, Bob Pearson wrote:
> After developing a test program which exercises node to node
> testing of RoCE multicast it became clear that there are a
> number of issues with the current rdma_rxe multicast implementation.
> 
> The issues seen include:
> 	- There is no support for IPV4 multicast addresses.
> 	- Once a multicast MAC is added it is not removed.
> 	- Multicast packets are sent with the wrong QP number.
> 	- Multicast IP addresses are not created and without
> 	  them no multicast packets received on the interface
> 	  are delivered to the rdma_rxe driver.
> 	- The implementation in rxe_mcast.c is potentially
> 	  racy if multiple simultaneous attach/detach operations
> 	  are issued.
> 
> This patch set fixes these issues.
> ---
> v4:
>    Corrected a lockdep bug reported by Zhu Yanjun.
> v3:
>    Removed rxe_loop_and_send(). It turns out it is not needed.
>    Added module parameters to set mcast limits to small values when
>    driver is loaded to enable mcast limit testing.
>    Rebased to current for-next branch.
> v2:
>    Respond to comments by Zhu.
>    Added more Fixes lines.
>    Added some more explanation in the commit messages.
>    Fixed an error in rxe_lookup_mcg. Should have checked
> 	the return from rxe_get_mcg().
> 
> Bob Pearson (7):
>    RDMA/rxe: Cleanup rxe_ah/av_chk_attr
>    RDMA/rxe: Fix sending of mcast packets
>    RDMA/rxe: Register IP mcast address
>    RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
>    RDMA/rxe: Split multicast lock
>    RDMA/rxe: Cleanup mcg lifetime
>    RDMA/rxe: Add module parameters for mcast limits
> 
>   drivers/infiniband/sw/rxe/Makefile     |   3 +-
>   drivers/infiniband/sw/rxe/rxe.c        |   8 +-
>   drivers/infiniband/sw/rxe/rxe_av.c     |  50 +--
>   drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +-
>   drivers/infiniband/sw/rxe/rxe_mcast.c  | 524 +++++++++++--------------
>   drivers/infiniband/sw/rxe/rxe_net.c    |   6 +-
>   drivers/infiniband/sw/rxe/rxe_net.h    |   1 +
>   drivers/infiniband/sw/rxe/rxe_opcode.h |   2 +-
>   drivers/infiniband/sw/rxe/rxe_param.c  |  23 ++
>   drivers/infiniband/sw/rxe/rxe_param.h  |   4 +
>   drivers/infiniband/sw/rxe/rxe_qp.c     |   4 +-
>   drivers/infiniband/sw/rxe/rxe_recv.c   |  11 +-
>   drivers/infiniband/sw/rxe/rxe_req.c    |  11 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.h  |   5 +-
>   15 files changed, 303 insertions(+), 360 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c
> 

