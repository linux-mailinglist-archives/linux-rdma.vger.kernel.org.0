Return-Path: <linux-rdma+bounces-1018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9548853D1E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 22:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15156B293A5
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A6961672;
	Tue, 13 Feb 2024 21:23:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAE612F1;
	Tue, 13 Feb 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859406; cv=none; b=DUvafV/kmoaRlQHO9N4a7CPBes54wbzbSrxWarlWO1NqhIdhVsxibk5d9gcNXHeWsnW3UYVw3Wy9ouvlrnDGvibU273LyXattuTkzhFk+GbH+a5v2V5xDjq8TtZ4MQq2Hnsg75BjOBEER7R2gJgKwPNmBqa3wVAU64WWVs2pavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859406; c=relaxed/simple;
	bh=zNdS4IWShzPCUtyQvVJ2Xx9JgtTnB6R56d3FqU5q/zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1EZIWqM43zb+N67zOtLLF9M2vXECYIjv/exrAZMvXzsgyP2BPslZZSwUcZDK9wvwoQrA4ggxayxWGT6Ui9HCOxEieGKmzKnyR/jytHqFJanoUGbsMWi1BR2wWryiqdc4Rt5enNBgGYhWTpS8lTK7gFcgxjvfQTR0la9bNPdTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2dbf54b2eso2084804a34.0;
        Tue, 13 Feb 2024 13:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859404; x=1708464204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNdS4IWShzPCUtyQvVJ2Xx9JgtTnB6R56d3FqU5q/zY=;
        b=M4K3QshxJADKxPYVVVXoii3VlZ/TMWo6k4EGTLYkG17T/o6Iv8xG1o8oxnDLTUMA2F
         fbMLSzMDb3XgQRsb1zbTvXh6Qy9R7nLUm3FnGnvZD79dzd3H+YV30N7rdHbn7Yk/lMFn
         SlMpsqHWOA35W6Tk7hIUa5VLNpdUjNOS71oBux4+D3QwFuPcRpLmzmkbYB6PAEgWa5hd
         +2ZouuFQwslgiShheB1VI7HSNE4PreVYL60EJzc7pfcZbfOGvYfkGWJHgq0OINAKSDmd
         +0QRIy21SIYZlpaGyz53kD+1YIec3kDYMfdbmNRh4x2iPDyTlYoZIu8GFHySqG5Skyc4
         whzg==
X-Forwarded-Encrypted: i=1; AJvYcCV9AGoBDA1vn5PPoHyVcDFnjwWhlW+YXyMQHxBUflZzs5udANT9naPskzXFbR/tZ/Xegbo0tBY5q71cN7MlXJ7Q6e6FHw11JoN21jN2+TvAU8Lv0EPON+JtmmzF4ShJ5yVC2HowbLpgXZX5Jy/0C4xoHAE7qx+5RZ4eTXNr8DOgtXJTsu58DQ==
X-Gm-Message-State: AOJu0YxjT2BwwS0T0dxFmgQFTNtNQapWTYS5R1X7xGrHcL62+gUz8I1m
	EZADYZZTytPBL16JyLlBKHYcFX2+V112fui/18oZhoo+9nW3n+1py3JydSZK
X-Google-Smtp-Source: AGHT+IHSDIYCiEJpbXHnj72htnQIqjs5Lx58sxhFgYYn/5FXG4QscL6nnfHbAv96HqavqpSaRjzCJA==
X-Received: by 2002:a05:6358:7e04:b0:175:fc1a:c7df with SMTP id o4-20020a0563587e0400b00175fc1ac7dfmr640257rwm.15.1707859403771;
        Tue, 13 Feb 2024 13:23:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV61jh8io2cFzHOQgPagQZn/vyQ6eElRDhB+kdJW6BQZDslFrF/G7qFWxOGH2UzodF4/8ggMaC1eIMspdGi9g0+IBKm2h1e7ulOUxa8rrn/SZhL7Ayht/Cwqcs+odOmGhD6QrC4RRFAFTk90qjQ8c8aIT/zuTnfsYYqcYba9inyTQrQjyK0Xiqri7/DBu6XYIuT9075Fr/mOgs7g6P2wFa15VKhsL0zGf6CYvdKHgcgBWOpq5oxQOGYBU+iJtoRvYsAnoYIlemAfbtCiW7duJoBMi/E9V+GJ174g9NrJnbIlg62cte7ddi36lKInbKyoykWB82faiS/ekfmBawnaGj3enVt0uf6oe3BBEshpEBaI461GeW9o7s3wU5+BNAlfxB/SYw2nvoIEuvQxDWXAfT4bS+CHQirAR7gxv18EmFIG+rOvLQBOwWV
Received: from ?IPV6:2620:0:1000:8411:85a5:575d:be51:8037? ([2620:0:1000:8411:85a5:575d:be51:8037])
        by smtp.gmail.com with ESMTPSA id r16-20020aa78b90000000b006e0dd50b0d0sm4421634pfd.8.2024.02.13.13.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:23:23 -0800 (PST)
Message-ID: <3945a1c1-16b8-4c72-9ff9-3a3f67a6c4b9@acm.org>
Date: Tue, 13 Feb 2024 13:23:21 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: fix function pointer cast warnings
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
 linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240213100728.458348-1-arnd@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240213100728.458348-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 02:07, Arnd Bergmann wrote:
> Change srpt_qp_event() to use the correct prototype and adjust the
> argument inside of it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

