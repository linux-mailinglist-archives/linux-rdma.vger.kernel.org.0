Return-Path: <linux-rdma+bounces-1590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9113488E66F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402B61F302B0
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42B15624D;
	Wed, 27 Mar 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YMWCd6NX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9E15666C
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544889; cv=none; b=tifh6rXdPnqANA8IEPsc53w0/ozRMdLVsvhUp8+ZJb2bpE4akIj6ff7Ych+u5fZlkLfa0jpg3c6Wn7bQt82XQXwM1NfF0Jo0vNKTZs/4WkuBktRYnVQUuoDxsIofM9t1ATVUJvtacI/VVyjeJFF5nyiY6eM64ZZ5dVgNpTVowqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544889; c=relaxed/simple;
	bh=bOCkQBpIbq+4OIWdKTY8jbhBvo0QfKqri3bdkbW4zyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHS4GnLKgzHSL4Rmq6+KW91Wi5YWXmxrlTddNOZv+/clL8ngocxCoAnXnqPGtY2tK4ec7MPH8FqbGb6iFzRaDjZgXTQR2iz4pvCOS6JtAJq/tEBitd82gGrNJzil300hE9n0k/WNW2WDcURiUrNfA49LkEhu1fg9fYsIRExYIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YMWCd6NX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789dbd9a6f1so488607285a.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711544886; x=1712149686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXZa+ziL2zpwTGqFg+fGo/Ha4jpsnKT6N89ll+XfG5Q=;
        b=YMWCd6NX9mG5C/Dkh/u1QCtMYD8xkhuWOdU7UzilFzXuHVM3RT6HMCdJpnhn8vKPNr
         Ka93zlzG9GSFOhhPHYUga2SZxC0DhbHc7VmOZ5hvOVrBiOFhtFiBWzgXaPwrezgfdRN9
         UzghzhLlz7PwQxxAjfciS3oojXYyePOEX+1t3SjRmbaRxqQfFcdD0lK53U6YoVnkcFYL
         HumVLamb8cUPUfaqyWo5qsLTsqihZBJK9LuDugL/JAEhg27sjL7RXm4ITOS0N3mnYv6c
         a/nhUyaK8WEpYMqM7uujy8YBaIq0lG6/E2FHwu0bv+VXbmFEaUVRMiQFDy16X+Jq2kqq
         q60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711544886; x=1712149686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXZa+ziL2zpwTGqFg+fGo/Ha4jpsnKT6N89ll+XfG5Q=;
        b=FNODO2ebvE4JQenMR3nnUY+k6n5YISfIUPM6umXIPE4NXbThBcAMTfGkTywMIjrsHS
         HxrnRfcY1GFBcIxnvIon0CP6Bc33ghM+xS3z2Fh3PeGJ8ruuJyblD/Q0aF9U/bEbqzUK
         KHEIDIppD6OxR30vh/pNvxGdPjfwRtcMghYEWL5sgMwKua0isZUiK4KKow2hKvOpLu3V
         l7cI7ZxCms3ZQlrZZRg6GK3q19neSQktzX/5zUomNNSfEibYejxk1DXOe8WdFFgLaJjj
         dIiN6RIufzGFivGw5CJ+xgLV/9YauwWZsCHeo8UK02qbII5CORMD9BJZNW8J7kIZBJk0
         s+0g==
X-Forwarded-Encrypted: i=1; AJvYcCWWwLeVKr0KV3tp7tq1imAnxPn6ECk3C8ZZ342s5ZOHWaTIoEkKMwFAQMiAIwbnu/knt1w1GWSkDD0UCm8WCSh079WboPuIdj7yyA==
X-Gm-Message-State: AOJu0Yxc/oXp/4UpXVvhAf+I6L3yqwhOUjG3m6JSu7CZnof1rBkb9J8V
	xC51r17SmW23AyE6cYMprvlGM7/D6180U55CbBYDPl0eKzJZfITM97pD8LwwWz4=
X-Google-Smtp-Source: AGHT+IGlpQIHuernZeSozwetSI/5VRE3ooiShaK55odmLq13YVr8tLSvwy/mCZzNn1Q6Y4pG5p53XA==
X-Received: by 2002:a05:620a:5d86:b0:788:5d22:788d with SMTP id xx6-20020a05620a5d8600b007885d22788dmr2638012qkn.61.1711544885895;
        Wed, 27 Mar 2024 06:08:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id m22-20020ae9f216000000b0078812b73ea1sm3846930qkg.28.2024.03.27.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:08:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rpT0e-0057YN-Gv;
	Wed, 27 Mar 2024 10:08:04 -0300
Date: Wed, 27 Mar 2024 10:08:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
Message-ID: <20240327130804.GH8419@ziepe.ca>
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323083139.5484-1-yanjun.zhu@linux.dev>

On Sat, Mar 23, 2024 at 09:31:39AM +0100, Yanjun.Zhu wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> If the definition of pr_fmt is before the header file. The pr_fmt
> will be overwritten by the header file. So move the definition of
> pr_fmt to the below of the header file.

what header file?

Jason

