Return-Path: <linux-rdma+bounces-8803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF3A6833D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 03:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1B519C6604
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 02:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F954A0F;
	Wed, 19 Mar 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4k6JwYU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896B209674;
	Wed, 19 Mar 2025 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352143; cv=none; b=gyiEeb8ZeoQkQ5rCwL/aP/fegSP7M/tw4vwuHAVF6aKhW284N5GuE27YC1bRdFyU8OW09+gzkHfgtUXiiwvHgDVbS6V7m2ymjzpUIqzEABzUIOd8G8ZRS6E76aqqm2ihP4Q3aKQZunVQnKi8Nl2S+3zyonMQi92RndgkZGQKldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352143; c=relaxed/simple;
	bh=Yj6T0X/2HCiSmRuSpotaTytF5PjAW7Yi0axKCWTjt/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQBirkUnfVeViUiT+X+YpxztE6Ct5FYC55URWo6WDxdfZbixN5XfAgJXUWnrlGCMmLJU326vv/Oyl6Re+rACMDR/7H+CcJC1ydsIqZepPVCTcIohwkCT+vtOd9Bo3RvCWLx4OuXNqaHHii/YjiIH3u6ULjL7JeJJ3oHBr3PZeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4k6JwYU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225b5448519so121705365ad.0;
        Tue, 18 Mar 2025 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742352141; x=1742956941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5LIIm36cccYbao7TAk4Hq5YU6PWgxen0Sg9TmOOAtlo=;
        b=C4k6JwYUPbj4aijyOvNmBFMXiNILY+Sj79QvIQbvW9I3AFYdfLlhdbRXiKJ20Gw276
         5vMufkXBNvk6JKceIEt9NPlDmUOxNmkHUQm09DlSQhM8BmxlvB2CUkAQXG/Jy6VHj9MG
         fv3GPxREiJRQBFzEAqJO0gtZyiZmYl9cR1KSgSiFL1d0mNeARsjUeyHqjWvro9ICdIF2
         SiqMgStNRuSXJgMcNE8rq6sKVSqoINemQdwI4RyDYiYbKz44JZmRTL+U8S9cEhCalm7m
         jUUuHc28JieNPIBTADYqnZuAdRFYQh3A1WK0EtAcQGo/oYmBDuygcwaALeril8LyvFu3
         7hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352141; x=1742956941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LIIm36cccYbao7TAk4Hq5YU6PWgxen0Sg9TmOOAtlo=;
        b=dfK0k0wyF6ErvQAEI7beYO1mZJQl0rp8ZdlYEg2VAI2/JM9wkAQPRTOMSwTAoDUT+K
         YyLE3rNY6W0XhqxrXGsRdHFif9jvbpMTPjZLw0z34lB7A5BcZ2B0yEZ7nQhqvskG5LSU
         JTjoURrG6EVNHPfvXI//Py2KorUKU503vqS1IBQie+dtMhZAOYe5Y+TgMgNAMOJsIcCY
         6E1Nu9xwkXi36tC4IQhPv1+Da/TIKgeD1w7ZZTLzPsCbMq5ECHRFAnwVF6OxIggk6BtJ
         2OfKyf3cwJoppYc0NPu+rX7/rW0wD7H7+7zS/d8DSDxR4+D5DGua7Pwwc/+Ae0qQfvGU
         J/fw==
X-Forwarded-Encrypted: i=1; AJvYcCUL8ND8NFvDhJK5H6W0cBEeLjJW2/EtJyqYPz4G2WYrcOfPjnWU2sOv+BZHwHLyvNGIc8RQ4K5WM+jyRg==@vger.kernel.org, AJvYcCUqRgZy5C6HHt1WG4ku0hYsT4QM6gM9RT5x+ROKBQml5zmlw74mLSDiHqF0n/EsQgXNzcg14oR5W8E2aA==@vger.kernel.org, AJvYcCVHyKMexvtNEQ+uCup3nMzD4Cf3OKBKpdhzoIXr4freCJK3n8tFhCOXUjqfyvTOismAXrN3PoJdV8K8z/I=@vger.kernel.org, AJvYcCVgmA7WHVTsJ596pU4D3yKFIab7PBdmFVrfxTBDNiicI6bfaTbfZjvUsWoXe4sLRKiyUPlNsXto@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DlTxGF74OHfn2L2GXTpU1CcZNtzBE36yjsW9z5A0ruSKxdQy
	qoKRhKT0RKqEHlGsAsZ4SeSaO9OgH4ORH7JQ0XpgbauqJIHUOFDo
X-Gm-Gg: ASbGncubJLF8oJJD+Acy5/7d643+eJoiVKb+WM02hPDtYG+w29FL/1aeu92ZRAXUuwM
	l74V8KeEmEu3kwDqGvjdMAPkoQf95OzeAHDZfxWmwBYaaIijNWn0QZsUAVZaGaLkuicFn037UGC
	kf1x+U+ZJWo+dcGbG0z/Und74fLQhAw5dCxe0AlK4hYkOFmAnlCWML06t9g2QRFoqYldVPN0eyi
	qvmk7uUeKZ7e2yI+anH/CtU39NZTORKYFsMaapCP2mXe42ikjjgzE19sj5gBeImVC35M7FpHYiS
	OKRhDBitb4UMMllE0ggnXa8P/RCILR73iQ7QYRhJHyLMwWPWg2C00RtyPPfwtQ==
X-Google-Smtp-Source: AGHT+IFMTPVzGmKOB0374Xwm8ymMGdht9WZf9KthbF99f4vKTy64/tyWlMgtJ/3VRoo6H4DyUbtn7w==
X-Received: by 2002:a17:902:d54a:b0:223:6657:5001 with SMTP id d9443c01a7336-22649c8fe35mr18839615ad.40.1742352141212;
        Tue, 18 Mar 2025 19:42:21 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:2ccc:91ef:96dd:9ad9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfdfesm102855595ad.203.2025.03.18.19.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 19:42:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:42:09 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, alibuda@linux.alibaba.com,
	jaka@linux.ibm.com, mjambigi@linux.ibm.com, sidraya@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	jserv@ccns.ncku.edu.tw, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net/smc: Reduce size of smc_wr_tx_tasklet_fn
Message-ID: <Z9ovAYqk8lESCug2@vaxr-BM6660-BM6360>
References: <20250315062516.788528-1-richard120310@gmail.com>
 <66ce34a0-b79d-4ef0-bdd5-982e139571f1@linux.ibm.com>
 <20250317135631.21754E85-hca@linux.ibm.com>
 <6191739c-93db-4a7d-8e83-3168909315cd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6191739c-93db-4a7d-8e83-3168909315cd@linux.ibm.com>

On Tue, Mar 18, 2025 at 09:43:07AM +0100, Wenjia Zhang wrote:
> 
> 
> On 17.03.25 14:56, Heiko Carstens wrote:
> > On Mon, Mar 17, 2025 at 12:22:46PM +0100, Wenjia Zhang wrote:
> > > 
> > > 
> > > On 15.03.25 07:25, I Hsin Cheng wrote:
> > > > The variable "polled" in smc_wr_tx_tasklet_fn is a counter to determine
> > > > whether the loop has been executed for the first time. Refactor the type
> > > > of "polled" from "int" to "bool" can reduce the size of generated code
> > > > size by 12 bytes shown with the test below
> > > > 
> > > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> > > > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-12 (-12)
> > > > Function                                     old     new   delta
> > > > smc_wr_tx_tasklet_fn                        1076    1064     -12
> > > > Total: Before=24795091, After=24795079, chg -0.00%
> > > > 
> > > > In some configuration, the compiler will complain this function for
> > > > exceeding 1024 bytes for function stack, this change can at least reduce
> > > > the size by 12 bytes within manner.
> > > > 
> > > The code itself looks good. However, I’m curious about the specific
> > > situation where the compiler complained. Also, compared to exceeding the
> > > function stack limit by 1024 bytes, I don’t see how saving 12 bytes would
> > > bring any significant benefit.
> > 
> > The patch description doesn't make sense: bloat-a-meter prints the _text
> > size_ difference of two kernels, which really has nothing to do with
> > potential stack size savings.
> > 
> > If there are any changes in stack size with this patch is unknown; at least
> > if you rely only on the patch description.
> > 
> > You may want to have a look at scripts/stackusage and scripts/stackdelta.
> 
> @Heiko, thank you for pointing it out!
> 
> Even if the potential stack size saving of 12 bytes were true, I still don’t
> see how it would benefit our code, let alone justify the incorrect argument.
>

Hi Heiko, Wenjia,

Thanks for your kindly review!

> > If there are any changes in stack size with this patch is unknown; at least
> > if you rely only on the patch description.
> >
> > You may want to have a look at scripts/stackusage and scripts/stackdelta.

Thanks for this, really appreciate! I'll try it out and see is there
anything different.

> Even if the potential stack size saving of 12 bytes were true, I still don’t
> see how it would benefit our code, let alone justify the incorrect argument.

Hmm I suppose smaller memory footprint can benefit the performace,
though I agree it won't be significant. I'm not sure how to do
performance test on this function, would you be so kind to suggest some
ideas for me to test out.

And I want to ask why's the argument incorrect? since I only change the
type of "polled", maybe you mean "polled" itself should be an integer
type?

Best regards,
I Hsin Cheng


