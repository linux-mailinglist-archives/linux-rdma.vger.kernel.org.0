Return-Path: <linux-rdma+bounces-9526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C160A920F5
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD2F7B27BE
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE025334B;
	Thu, 17 Apr 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="H3yATVk1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121B252295
	for <linux-rdma@vger.kernel.org>; Thu, 17 Apr 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902658; cv=none; b=dFgPyt9r3vFgssSmi27zwhsd+9PqyW2k0NPOzNtHQzbYqF5TmC7cZg0rW0mZKAuWR8HTzRz/pfq7iNBEwTM2CYbfVzM2rIKGl68Cnw5riqhP63zYCAU93qfJ2HQfuI8lWPiyop67pYdXUredRmVuJiudXbVWBfE6DKu/7qmpc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902658; c=relaxed/simple;
	bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAsaq5LqmKVBDSY4L296UVe9Upfo5vlF2hb3YynJdvaeZC5HQDGJV0j6sMbUnQafvUAnZol9cvMDpczboQ5XyYN+QcbQrBoKow37ZpLjq2Fkp6gyWUpXQi4qnioaXC/o8JrSuFkQGDLTbJ/fwqqPAeTEgQ+PUI1l9oBBEDRRxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=H3yATVk1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso12205705ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 17 Apr 2025 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744902655; x=1745507455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
        b=H3yATVk10aZqoRI+w4nNhDNAcSrm+D72kf09ipil/lhZBQVG98+L9kHkPcmnSnwazQ
         2l2q7/rcLpNyHl7W14wjQCbWN87G0IAsm+Yej1cduBZyRY+bLzSw3rdEYxijZFieiE5K
         4p9sZvZQrU1T5YW0n/Phw1rSXkT4kX9Je/Pl622+TtYHoFzbnncoMrFYet2UFNdX7dEZ
         Kp5GDmv6d0PucyJocp1zYdAefTVH68d510dC+sFSGKo4O3dpzsf/SX5osPX6hm1NRhbn
         mn8Q/7MwclR7BEHoMAaKF+jTuamIjIVUOtP2h2aefp90oQRbxnCBj4UUds3GxtLFjNgk
         ZaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902655; x=1745507455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
        b=ctHIuG4CcWklytz5XMod+h/mrj41IAbTsslklx+KvcgHVXzY0w5H0p2JrlaUftPUPt
         kopcSDNM5W0lAk8wK6hIsVtSqQKv0UQ/6nn182KpE03illk6XmnhbT4rBL4wPCjMjd76
         rkpWhS6N1409dpvtZ+dlX38jMln2Vu0++gaTikuRHXuUZQDXbMTInfsAUUUB4NhfSH/9
         fd6oGnQgG7pBjYRkNUrn35ihcgu67fJdoKAe9cmM1UlsmYaF88mJyfURpvYTfV3VmPOX
         GTRN3uScDzRMBownAPIMpAQcz5Eb3h+6Og+2A/2VqtBU3YTm0/Qjf7bgU6Bj1AOpor/R
         sEOg==
X-Forwarded-Encrypted: i=1; AJvYcCUDXiGBL6SRW0rpOtts+wve/SisZC7T/S+kaqhoK5d53VQLXkU+eTF5h24r58cD2kHk2RgzDAVQv/+U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86aUJlTqcHInkoDvxvrMeQbL379Q6iMc3HSBa3uas1FSxUeaa
	UCR7lEiHiXRTIZXuefXAG6G8RRJT2uEmx6KIYAVa1v8Wzcwp+Ejz9QETrnNNKyU=
X-Gm-Gg: ASbGncs6QQPUYLrW2pZS6huxdzwd6ZxEmwDpG3ThTKdvMzCqffcAJVBj1yOYcHNYbM/
	FcN4gqAIdl+yKouADb12/fhl6XONesNK498WyQF7e+Do12O25ftwSzZGa++mq5X6IeOVIiSVsLM
	SjOz0n19FPpXv4jglX7oy0Pum0+/vqAjkq/HHnRW19XWwBuG9JRutYJ68pYqXXNalzhAmfMbtQI
	bjJxBdGgkTMoDuDBjDWgvf/Bo/DUyfVGePRz40M8V9AhVTs2DgqsalZlCgaRuZ6NZDialX2MZ+u
	kulAYxF/0dug60AfYT7ULLbGA7QU07JhCpI0ssimdCBhE5K1A94oiQAyck2Dl9ppAH0+1oZn0XK
	zUPyJELFuOGLrcPBn
X-Google-Smtp-Source: AGHT+IHIP5FBpE6QRyj07ov+jrBL6Cb9idEsBOVjWQ1/IColpF0qdvEnnkroDFpHC82/JIDmUgRLTQ==
X-Received: by 2002:a17:902:f642:b0:220:c813:dfd1 with SMTP id d9443c01a7336-22c359734c3mr102186955ad.36.1744902655602;
        Thu, 17 Apr 2025 08:10:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c210esm12348763b3a.41.2025.04.17.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 08:10:55 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:10:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 kent.overstreet@linux.dev, brett.creeley@amd.com,
 schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, rosenp@gmail.com, paulros@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250417081053.5b563a92@hermes.local>
In-Reply-To: <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
	<1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 00:57:09 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> Introduce support for HTB qdisc offload in the mana ethernet
> controller. This controller can offload only one HTB leaf.
> The HTB leaf supports clamping the bandwidth for egress traffic.
> It uses the function mana_set_bw_clamp(), which internally calls
> a HWC command to the hardware to set the speed.

A single leaf is just Token Bucket Filter (TBF).
Are you just trying to support some vendor config?

