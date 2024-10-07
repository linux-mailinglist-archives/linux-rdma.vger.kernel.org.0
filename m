Return-Path: <linux-rdma+bounces-5270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11033992E4C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78751F23AA6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58D1D45FF;
	Mon,  7 Oct 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bU+lCWed"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A91D45FE
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310003; cv=none; b=q+O/2SCtu8NFWjeYSfcObTybJ+SeKbpMMvSEUlBIP66yKSF2Il8K7VQh8MJg+Z89aAaA6SOGWuJan11mpjDoJdOCgK6ZCQnM781OWpSYIwoUrT7FNLicG782oGi68d+W9pKDZC1pKeBqaodxcxyIrseeuVT6mTouC7d6UcYoqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310003; c=relaxed/simple;
	bh=Zw+St1S3HaAxdhlWUH+h4rGhg6ZNujDpbcI/dBOFtWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL9OyUEt0tzJQ3CUAMkmqKHzo1uy2Ze/ZDFHITyauz4xD5NNdkuxhzUNbzdr9J1ew/MJRXHl3ROgrT4CVkIijcTYCBtLQYel0yt5onp+E01ONifbijIbMJj6sfBVPeQXxXbVVn5sTimUKhZk8Fo6RRVhGUyo2tQl1Glxlipsjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bU+lCWed; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a34802247eso26302695ab.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728309999; x=1728914799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arIAYxZz47K33aPWOj97XFx8obpL/OetnzHlDezlYuA=;
        b=bU+lCWedMDwdj5QCP1ObpqtB/1XD7PA+l/PG6szXfoZrvwagAp+qKSnGWFhCOhIXIQ
         LCdX2+LVZCT398zbZjF8KNJ8yNZqWoh8Egms7pRzP4QuYk59e/NltUDIwWy0Xa54+j8K
         JyJspPq3B3j6xD45gvnyoBs6/9q9Enpe7pn005EPEWkM6YTYFkCQ+e8muoYV9O+Nomg/
         S8TZoKenWuKVXv+TM3QLdcxqPVEpBRJXpBqEwUnOzzIIrItEr/cT00WVjfrv6xPbwrAx
         iJmVQjjIvhx6Xd3OpH3ZtlVY7Z0HXlr7DMU4+24O2UAuiswoi7xcA8u8wybV4nOg5vnK
         qzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309999; x=1728914799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arIAYxZz47K33aPWOj97XFx8obpL/OetnzHlDezlYuA=;
        b=gsFiMwlxtn7fSHK6YkIdFe1Gm1rOLH1Eq+CEdoB7AgDbsPJoBrz/V8xkxQWmR/PyHY
         lpErwjxPc+MANBbCY8Uepf2iNqyJuJYU44jxa6K+s1PA5UbClt1bMXLZyGNKmXhzP6ui
         lYD0zY4MzHbAVstwftYdh7tHWA16Hqa/n/Uf+fgezVSE50bl6M5ZOttJjKDr0f8PoHQj
         wxpYbVy/eQU+ENp1W6vCazF0rZatLWzeAMrs9sEEEqfUnIevlBrso6glDu+FR2eQ8Kud
         IQ1Pq6JL5F5FZZ9GUMkEUEpOZKJuJsmJdJ+i9Az5e9xL7yYamzFG2yUk2GnEk2ojBycr
         +lAQ==
X-Gm-Message-State: AOJu0YxFePCkiu+wlG98kIMWxVNtxOzt0P+AN6D/Ygq9Y+8LBSpgx4Ac
	lSzxX9NM0xV0PIjSAGH8/PO2uKzZivuKIAtOq70ZG7t5IAVgQn+1yyKzymynsI4=
X-Google-Smtp-Source: AGHT+IE0SDKK/K6oarl51Emql91aqyRs3ALNWJUsBG62flnxNKu2kKU6oH0gk5qHRo8SHwY8bFz2Iw==
X-Received: by 2002:a05:6e02:12c4:b0:3a0:98ab:793e with SMTP id e9e14a558f8ab-3a375bd2bacmr92249655ab.23.1728309998917;
        Mon, 07 Oct 2024 07:06:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db8544f2d4sm529400173.6.2024.10.07.07.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:06:38 -0700 (PDT)
Message-ID: <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
Date: Mon, 7 Oct 2024 08:06:37 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Still seems way over engineered, just use an atomic_long_t for a
continually increasing index number.

-- 
Jens Axboe

