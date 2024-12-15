Return-Path: <linux-rdma+bounces-6522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014689F226D
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 07:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C5C16618F
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 06:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D9311C83;
	Sun, 15 Dec 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSoYpPZR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5572F30;
	Sun, 15 Dec 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734243950; cv=none; b=K4faHVe5wT7cXU9C1N4l38ErDV/a6Bf1HPLqK10/y+KlDGx2mBU2/HPTqNu1f7J4xdaXJdfWV2vb+tPWGdx1m+/D/Vrh4ppy16/01a+28a7z59uDSR2Qj5v2NKRPH/y3lCUeqY87LXyW3l7enuEdF4TOo8bKugu22YYn+11E5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734243950; c=relaxed/simple;
	bh=ePzuKjUGj/64znB1Km7nDXHwxzhQWhkanfir0wImHqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1L/XLjufoVUwH68wt785ibzm4To40XFjL93kaEv+kUKwCZJu/2E7ZjlcvJbdlbw2/U1O40JBDGOeBOyWFKoYTN6d8KIz6VPldy66GkgeJORCi00EEEruZ4YeS+yD0DUYrDMqhYI97Fid27LA4M4aGqozgBygooAnomER9IZus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSoYpPZR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso21771125e9.2;
        Sat, 14 Dec 2024 22:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734243947; x=1734848747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l54Jzi+B+BUMhoGA0YthKhGwDvZTzku0kyQBO/qcUow=;
        b=iSoYpPZRo8XMQREKiXGJLudZXbVb3dcSMdJWSxZiWpnTuGJU+untD+bPtbKtZ2Olpk
         p4EmnYpq3jdnff1sjxCGS0wx6W47zVIPIMTLUaosVWRj159OU0azQ9wGkc13Gpph96wD
         GvcnFDAwxPvRHi3jQ6UFucZWPwXk9E8Ok++B5AoFs6rm5/4ta01iGSPCbDwlq8zwDuu4
         xWCWNxLnwj5R3t8L04SvnLVFFcK6X2nDm1SJg+S3RyHYx9ZM+hOetk/E/2/e8VJsqs0z
         kG52554gaE4b6d+eu7G+YPuGF7WVeJG93Jon8B38emuJTJOo39vYDm2h7H+29FbmRWx6
         0Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734243947; x=1734848747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l54Jzi+B+BUMhoGA0YthKhGwDvZTzku0kyQBO/qcUow=;
        b=UfFUgIFGEQxs9xQF4dz+1aXpjtEhjQB2WgV7zYFi9SsFHlYClO6NKrqY4MlE8MTaKp
         Ln5w48RKVFTkRdXGHW5+AuQ2uuPLRsmy++gLyhK+LeY4KMCqiDI2n3GPGu6QRoumRuWp
         22YHKWAhpb4PiCiEiozbPwif1RIUn6/IEsyUBxCdEFisXFdxcQmePqa6cMyGI7t2Mm+l
         tJpNiHu7/QQYgGInZFkLh7IStrcFsjdefyvVSa8I/InYNI+HfmYCNajom0PaUZsf9zAF
         g2d7qN3+3YzBt8hjjnKbxkMm+Qdw/Un0q2147EALhef3W9W8ujL49GVzB6L4qckVKJWl
         LOgA==
X-Forwarded-Encrypted: i=1; AJvYcCV8PabPtJFnUrZObN1LEPhUieTb2YE9AbKZSFB3PzTa/L4xPh/A6U70lF70LExNloxWS3ualJx+KYgI@vger.kernel.org, AJvYcCWdgzO/jsMMC9kkU28HlJC+e+tM1va3lTJWABW5l7d/NUz/YWR3JymV5nSgpXe3bY3zxv4TFzw0@vger.kernel.org
X-Gm-Message-State: AOJu0YzunPt3pkw2w1D+jRLZ7xrOxf4xuUDv6sRY+scJAzFhE9Khnfj1
	UDFgxww8/fvBH3fsGfvWfFnfYLVR0Agej8SWG9JWBAiTrdrKReYF
X-Gm-Gg: ASbGncupNAJYJFh6dRWS6TFALjsQVmuF7hdXQHS1O1cnPAU3oM/aV+AY7Fajd1R5x21
	UEamrLSFRhGzTB741Q1DFnQX7sP8K9AZPjeZXM7HLnjXeuXIJtEwI1Qi46HDDvXAZWydP1IcboP
	Ka4n8ANGxNPTAflMvuo670XmRoYLI42ckjXoH8ap/tjDwGcCMGMrABZL69bBbWYNRcFu7atWjjt
	qkZfSB1QVhlbPZQwIO8rVD7PnfBMq5wmNmb4+UA01c5+GGiA7q0gW3608yYdKW7MUNkcorMzPxf
	FQ==
X-Google-Smtp-Source: AGHT+IH6bIqPPRY9enCqVJFALaw2fXVZSZEpyAH8atSqV+6l63KxOc8jAZU+F313tjohQdctJUoxAw==
X-Received: by 2002:a5d:5f8b:0:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38880ac4dddmr6132469f8f.9.1734243947094;
        Sat, 14 Dec 2024 22:25:47 -0800 (PST)
Received: from [172.27.21.141] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801bb00sm4379054f8f.62.2024.12.14.22.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 22:25:46 -0800 (PST)
Message-ID: <1e8c075c-2fd0-4d10-887d-04a5fb15baa2@gmail.com>
Date: Sun, 15 Dec 2024 08:25:44 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net/mlx5: DR, add support for ConnectX-8
 steering
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Itamar Gozlan <igozlan@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-11-tariqt@nvidia.com>
 <20241212173113.GF73795@kernel.org>
 <5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>
 <20241212171134.52017f1e@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241212171134.52017f1e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/12/2024 3:11, Jakub Kicinski wrote:
> On Thu, 12 Dec 2024 20:31:30 +0200 Tariq Toukan wrote:
>> It requires pulling 4 IFC patches that were applied to
>> mlx5-next:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next
> 
> What do you expect we'll do with this series?
> 
> If you expect it to be set to Awaiting Upstream - could you make sure
> that the cover letter has "mlx5-next" in the subject? That will makes
> it easier to automate in patchwork.
> 

The relevant patches have mlx5-next in their topic.
Should the cover letter as well?
What about other non-IFC patches, keep them with net-next?

> If you expect the series to be applied / merged - LMK, I can try
> to explain why that's impossible..

The motivation is to avoid potential conflicts with rdma trees.
AFAIK this is the agreed practice and is being followed for some time...

If not, what's the suggested procedure then?
How do you suggest getting these IFC changes to both net and rdma trees?

