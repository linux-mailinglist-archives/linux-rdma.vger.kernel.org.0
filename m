Return-Path: <linux-rdma+bounces-10669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38B4AC323D
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 04:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9126E179CB5
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 02:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3078F26;
	Sun, 25 May 2025 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL6UaTlr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5054C83;
	Sun, 25 May 2025 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748141652; cv=none; b=n3srum0HbFXaDCrrBhXZREfY/N90WzxiFJ6BxtP4PKl1V/UucZJK7K1v5M5PbKdsJsxx4NfYDeL0dSZEFTVMAnhi0ihZdDWdAYh9qGet50hBSCHlFlA9x4CR23DZU8x5I11Jw1ol6GZwe0JBHOgCDYU6u/Mj2n2P/wU/x+lIbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748141652; c=relaxed/simple;
	bh=u7quDW7EhzirIAa4UUsPm91tBrM7NY6zUJ7DrERpubE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPHf1Exx1jPaX0rB9VPvyd8zXBtmfD/hfuztHeQe/Uyl2/v87R1NO6A62smnLlgFRmS9E1iBxBV5Y7ZINaoFznrhhLuZ6Zvi9nNY0eZON/3c5sNXjwtUQkcEsgJEFvBR0OtJz6UrUXF0aemhK9fvYy3AMi6RO/bfHYrYCHO/bP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL6UaTlr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3112e77bbf6so327100a91.0;
        Sat, 24 May 2025 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748141651; x=1748746451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pg1AujwKWuW+6eJShkyZAVgd4CJmr2DHUfLkarcFUEw=;
        b=LL6UaTlrXSr7ZPe0SO5fdnMNZhcM4ieXuc5d8c9ASW2rxCMhZFSus0EZFRTCcaE4+Z
         3S1H0PDbvhseCq+GjwyC+xY38+CnOc59ddHSQfM14X9p2ZlTPQg8dloJ1KW7H/rvrFTr
         WDojfYEsz6MGsigbV/OAdBE0ZnTCsGkIRoP6HIMmQN7dWohFeec0xfBGzJgfYDJAzW3S
         AfB0ggYCkbzDl073bcc0KiC+LDc2E9xebebrlG64R50mU1Nt5kHNP2+lGMemhkbDTMJz
         vgH2t0I87nwYBFhLleks4MCeSuTZ3pLQEJUAhqJmB6vpwFs5+htit93kf6g5mLXWl+cL
         eWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748141651; x=1748746451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg1AujwKWuW+6eJShkyZAVgd4CJmr2DHUfLkarcFUEw=;
        b=oO3CpCl81yxPQjvsBhYfxspQq5CzovjxL/MOCQT98K1fvXrtrY98zMsPkf16rgbq2m
         yUWVQPG3rMBzpcUAxK6F42k7Vc1QH5YJzA7/BaEYUlpTGOepTC7AdViNPNm4eXu9Ldgi
         n5BU2ev9915P+XSPk6BAXh/S/1/GZz/tVlfbNL2S8YnAkbxmg1/W8iV7qrdvIu/1mT4t
         KwtuC59MgjaxDXiVLd5kgfAifncycE4aKO7ZcxhJDlyNysPBb8gZK64+IK49sr95RPUn
         yRMrMSE/oGRlbhgOba/sDY+gpC3yZH2SdLXyK82Jigm4lV4fZf58WfmO98dgQr8kbgTU
         kcLw==
X-Forwarded-Encrypted: i=1; AJvYcCXFeIEZFj4daw1KADCM0GAsnCkbbVzePVDTsJ0WyeIhqBtJGQ1/VPLvy6IBwViDKMxvcLgj83YWwFtf@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUASgJYEzAjHlX+HFTqt8C4+4Iz+2dy0xUABbJ9cMbrLdIoJ5
	HhSafMoOJKzys7Hy1IY5TEUV855S4fmgRPa4FI1dXTC/5ktUS/BIE3of
X-Gm-Gg: ASbGncuS/D7JPI7k89DL9MyUl3NLW/FW3QGQdfaAC+RjZ36LUoWfg+guescUq1VFIBV
	8PnHJ8KfoV+9YE9dL/jmQXRkXHdQRrhx9Hl3H7AeLS8mc4x+wyRGNBSNM23rr+J4AK6HfAMtOq9
	YldvsDCONooP9ntbYnLPOthge2GZzR2waOyd0WE3eFyF8aKBOgoDLvSzwa56M1+uEA94qLjYr4q
	P4iSiQrrq+zkRae6Rt2Z7G42+eTUQyMgD/xYbgSGeZMJDqaAcXmQg6qUAM1SAW29yxnj1fcYi1S
	DmR1MS17ADjj7ga3nejC2V61o8rzlJSfB+zIdkQDmDZFedRH4WQ/EalYav9FazbniFNbIQUawXy
	QR+lM1sXZ9bGp8A0I7Btj6au6tBauloqwv+XjJX14dOFRzgCd
X-Google-Smtp-Source: AGHT+IG156mWQooBn5O0kQgkC3nRUC0TLhzKgBgZMmLUp29CeCUBbXHp09jUr26tofNWo4Tw7s3nlA==
X-Received: by 2002:a17:90b:1d81:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-311100d874bmr7914571a91.15.1748141650671;
        Sat, 24 May 2025 19:54:10 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b2d80sm9779171a91.4.2025.05.24.19.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 19:54:10 -0700 (PDT)
Message-ID: <dbf60d49-fa1e-49ce-b6db-16e834e42e42@gmail.com>
Date: Sun, 25 May 2025 11:54:07 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Greg Sword <gregsword0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, hch@infradead.org
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Your ODP patches have caused significant issues, including system
> instability. The latest version of your patches has led to critical
> failures in our environment. Due to these ongoing problems, we have
> decided that our system will no longer incorporate your patches going
> forward.

I always wonder why this kind of "report" seen around RXE never includes
the details of the problem encountered and the steps to reproduce them.
Everybody else in the linux kernel community does so.

--D--

> 
> --G--

