Return-Path: <linux-rdma+bounces-10486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF6ABF4B6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 14:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BA91BC2002
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4C267B6D;
	Wed, 21 May 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOZgprLV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04B2673B7;
	Wed, 21 May 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831713; cv=none; b=IUl9KmHpXI2Qwn33mkwGvKAY2Fdjf/jgyWOuiCEEG1MvIUeg2bR7hMApTm1mIYnwdJp49B2bNbzvJWtp5zXA1cMipXUDjT3VwnyIda1ncIKHn2ywIFHBV9/Ol202pS/p/E8TpLLt8oTTbab2+F7VvkQ5AhmgfgnypS8BU7S3gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831713; c=relaxed/simple;
	bh=6dpl5+hKXsjxHXJtgK+FmCRGvqugBoM7cVl8IOfANAo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=tqpDFRx8DpFsrSZPqC+yzdb8EHk+4VP/GwxpGnaG6zqTe2xe0+yeG5anzJKaZRCU3Pjgq5UeZBUC3mFV/r0OrLn11tT4B618ddvYBOlhLEqQyUpUc2kiHnXY7cCG2noke2EZPiBHpHlgdv3r7+e5TQoLZv7uQSMv5WrXr7QFhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOZgprLV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30f0d8628c8so2297665a91.0;
        Wed, 21 May 2025 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747831711; x=1748436511; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OlELLQdFDyxnorv2U2UyUYcCRMoCws2HjAojfez5Us=;
        b=dOZgprLVPpeVrxVno988z0M6OqReXamXePP/bv/nTfLwKRINAfW2NQ1MiE9+kOf4bs
         cfr5/tQtIi8XcP3uyBtGu26x47iqDwHS+AEi953IeVBNgUzLUdqGy8FjINre2UYk+/Oj
         0CVnGVwD3sJYwCoKBYLPm6qAGcP5r7ZJ5qVndtl78mSwXZchrTIuwjc5Og9/3inOraFp
         hD/Ja3FC63zD4OUIq91GSBhx/YImf42j+GL6sTmsomPsr0abl96k3y6qqT4GosEnA1eS
         mVBUh97ZxQEHhu1QklPjTjx6nwuaPH/stj5V5W/KbuDW+hVk+sVruVJY3k2MkUkTfgBb
         qV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747831711; x=1748436511;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/OlELLQdFDyxnorv2U2UyUYcCRMoCws2HjAojfez5Us=;
        b=Ok/LR6pGtX2Q0eVv3c5jn8/f36+ZiElk+SDGO2oVzZOrouIyOtfw1dmHZjyP10dh5i
         NFl0452vltYMwP1UwK1PU7c0iC7x2iR6QrjsIJiFPO73E80SbHrcVjJKwIx+HW+eYI/E
         6/7GXl69emFPB6XsFzcUEE8LyzooAwS+gGCh7epKnkAK4Zs5ZA1tiEzHkOUrwKIIH79S
         iYDBCTVCc8OnAX812VWy1TihqMavSMzd5hhyI3cnyaw0fL/7h9AiMKf3MSWS1+Tnb1e/
         /Wkd0gQYsGJ2Pm7kZNAg7kUrIEiRGFM4Yovyu3QieZA+tCG6gkgoZ17Lvms4zJ4T+S2j
         mSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD6z1hWuP9MZKrpRa/XZuz05qONyIXhDEE3uUNhNsmqpkXCBMytVLK4/1+1wwKvn8sXCICabjEoLmOIwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyah86/RRsWuiswyF+Ta3aACyjWfCykNpj5awkzmILDNsl6xi+c
	CjPxqMQ5ibX75poo6sG7fAG54Y8kj6Ws9qrTZV4Ckfezl2hnUWcDGxLb24GZhswb
X-Gm-Gg: ASbGncsfw3rVrnlWnMDQABxPO08G74Dy0XCqVufsOIGXX4wQy797E9IypCg89qFZOOr
	0zIY7JS9jUXIqe0rJDWw5QfcrSCdzPHfTSmukyvYQam3zSnGo/lyY3K0OZI4IRiMDRphOskf9oT
	a4y6vdj1TQICAUQmA+QFp6qXONHrA7f1yjG5Ca0OehKyUffPG80jXeyWv/ZxisicjG1x8Pko1gE
	FDF/lx2Gc6457OXTecq2eg7GZOICou2rM2mOy8wt+JJ1+ZBtCnf3yA3o3XnodvtINyflwac0toZ
	/kGa0w2pfeI5ZBJaH3QbxVgMMJCKe+GLR6f7Qyoav3xKmUgAxVWnubQcLltfoBQi1IHucm8bTn+
	4PxCHL+7cFTodupM3i32NPublJajf+Rp4/5oz2w==
X-Google-Smtp-Source: AGHT+IHLCkETVF9IpoaNAmpLh2aR9pR6si9XDzVi377NoVdogivwd38lRxIY5SMd0CmaMqVs7afjzA==
X-Received: by 2002:a17:90a:e710:b0:306:b593:455e with SMTP id 98e67ed59e1d1-30e7dc1f4a8mr33747981a91.1.1747831710723;
        Wed, 21 May 2025 05:48:30 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365e5b91sm3543183a91.39.2025.05.21.05.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 05:48:30 -0700 (PDT)
Message-ID: <3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com>
Date: Wed, 21 May 2025 21:48:27 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [bug report] [rdma] RXE ODP test hangs with new DMA map API
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

After these two patches are merged to the for-next tree, RXE ODP test always hangs:
   RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage
   RDMA/umem: Store ODP access mask information in PFN
cf. https://lore.kernel.org/linux-rdma/cover.1745831017.git.leon@kernel.org/

Here is the console log:
```
$ ./build/bin/run_tests.py -v -k odp
test_odp_dc_traffic (tests.test_mlx5_dc.DCTest.test_odp_dc_traffic) ... skipped 'Can not run the test over non MLX5 device'
test_devx_rc_qp_odp_traffic (tests.test_mlx5_devx.Mlx5DevxRcTrafficTest.test_devx_rc_qp_odp_traffic) ... skipped 'Can not run the test over non MLX5 device'
test_odp_mkey_list_new_api (tests.test_mlx5_mkey.Mlx5MkeyTest.test_odp_mkey_list_new_api)
Create Mkeys above ODP MR, configure it with memory layout using the new API and ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_odp_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase.test_odp_async_prefetch_rc_traffic) ...


```

It looks that the python process is somehow stuck in uverbs_destroy_ufile_hw():
```
$ sudo cat /proc/1845/task/1845/stack
[<0>] uverbs_destroy_ufile_hw+0x24/0x100 [ib_uverbs]
[<0>] ib_uverbs_close+0x1b/0xc0 [ib_uverbs]
[<0>] __fput+0xea/0x2d0
[<0>] ____fput+0x15/0x20
[<0>] task_work_run+0x5d/0xa0
[<0>] do_exit+0x316/0xa50
[<0>] make_task_dead+0x81/0x160
[<0>] rewind_stack_and_make_dead+0x16/0x20
```

I am not sure about the root cause but hope we can fix this before the next merge window.

Thanks,
Daisuke

