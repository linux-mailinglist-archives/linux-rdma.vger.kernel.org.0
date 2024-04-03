Return-Path: <linux-rdma+bounces-1763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5E897444
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA361F22096
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B614A4C4;
	Wed,  3 Apr 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U3QC94Hu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B311149DE1
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159058; cv=none; b=mBRp1hj5P/FIylUr3Vr93gdDJ1IONtK5YqfwY/DiGfwxqkt4/cU7QTpD08T8UrpjVeUyO53HEnZLDIPzHq/vWtY0eQ39ssa49r/FjWEpPYneWcnL9lpLeRTRlADeYnhFKFfY830KyUMW/C7mlEeP/2NR2QdrQJc6tFrc5Oy3IGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159058; c=relaxed/simple;
	bh=uOamvgZx3i26S0kHCSK6ShX3F/IohLv1voGOcXD6Y0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ilRy5FiZA7X0M2X4eynSGobB+weM2cYpDcsAbgeqbEAH1X1mHp6V2dUWeTdiaG4jyaXfYJPv7O53Z0v1jzOT8Oi6sw4jBAHJxhZmJSjseI3BMSwZDDK7vjFXFn27kZF7WhghyS7MOtdjPpTLQtO+DEISwtp8FW+zp1ZiWOM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U3QC94Hu; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e9e1a52b74so189817a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 03 Apr 2024 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712159055; x=1712763855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PVVYuNrAUl36pyd3xeuvzvQvdQgmwGY67VpgOIWSOw=;
        b=U3QC94HuPmdeR+8S9GLsXwTvVBjJog/AwExJ1IeyXnmxBBvEFd8F9fY1+EheF+kUV1
         ZwKsnsTx4nGp2wbilnz5J59CXzSNPv+vXZwnP/1PNwuiDjxnQqpccuCl2i+H6Tp3Ppzo
         xr+JeP0dfG+zDMpy032NqHAlTK/bynaHixcmCv0rA0MBvgDVf5+ptCurwvv38VcxQK69
         XDoNEEL7FeBAQUY7Kbc6IWppLpbOBehTNyLBm9CZ7Wp+Yjg52SuzkcXpO+5tkrANDWPB
         a8dz7naCSNptlwLWy0UX4nNhNRTRhHY5MR5jTsEs4JkWcFXc8vta2LTd81HKzxactbHO
         ANxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159055; x=1712763855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PVVYuNrAUl36pyd3xeuvzvQvdQgmwGY67VpgOIWSOw=;
        b=lEoe45HoK5MNivlB8Vwx4A05L3nav19IuaTi3v5rUFq9RNQCg1gV4aETjcf8u8N4+q
         x0wj0y1wxg+7ZXdbK4piZvmPCvywi7iqkwEHg0U6kXrbWrI4q6Ywrym1gEKGsZJCnSRk
         0eYRnX2GTNGrTYml+fPC+UGoqOm8QYeMZCU75hjGj51M7XXp/xPyTXMoU9Vly36q+EFC
         r327qtE4XrPTPZgV2boHHFvyUoqQNzv3blDnA61hSa5MKX4hANYBp36K+G9nVcGlGGbp
         Qi5kf8LDe7dqJ8YSww268QaAKThubLFeWrulMi8sVXuOgJ3R16ZOuRVA/KA/lSkZZuqC
         g79A==
X-Forwarded-Encrypted: i=1; AJvYcCVLm0z396gWZd/5Lqkd6Pb2kFD1w21zDjF7PuIJlw+9ZIWh2IinEeWSdA3+TdMQTiyjOXMeuVcrrao5+0wvtuKB2AXqaBWRy+RahA==
X-Gm-Message-State: AOJu0YxsLYmujL22kPPfkIxVS/ARXczh3aNAKa8WV2TbK42NbVimvrHY
	FRSX2JEdOOkbuzqXfvage45hS06uvuHdnFC75v1ie1jeF3QEd9jZXGc2vmwyt3c=
X-Google-Smtp-Source: AGHT+IFZkhbozTXxif0mxmF92PRdOyaPTrbx7gCtN2UwQ51SV5wycjFky/1bPdc61ntu60EA8vaM6A==
X-Received: by 2002:a9d:6f85:0:b0:6e8:aba7:4b8b with SMTP id h5-20020a9d6f85000000b006e8aba74b8bmr6319870otq.34.1712159055700;
        Wed, 03 Apr 2024 08:44:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f8-20020a9d5e88000000b006e6e3fdec53sm2673494otl.35.2024.04.03.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:44:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rs2mc-007hKH-2b;
	Wed, 03 Apr 2024 12:44:14 -0300
Date: Wed, 3 Apr 2024 12:44:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>,
	sleybo@amazon.com, leon@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: Implementing .shutdown method for efa module
Message-ID: <20240403154414.GD1363414@ziepe.ca>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
 <20240326153223.GF8419@ziepe.ca>
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>

On Mon, Apr 01, 2024 at 04:23:32PM +0300, Margolin, Michael wrote:
> Jason
> 
> Thanks for your response, efa_remove() is performing reset to the device
> which should stop all DMA from the device.
> 
> Except skipping cleanups that are unnecessary for shutdown flow are there
> any other reasons to prefer a separate function for shutdown?

Yes you should skip "cleanups" like removing the IB device and
otherwise as there is a risk of system hang/deadlock in a shutdown
handler context.

Jason

