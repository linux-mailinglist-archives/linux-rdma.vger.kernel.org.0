Return-Path: <linux-rdma+bounces-10732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE2BAC438E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8EF3B3904
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4023E358;
	Mon, 26 May 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teg6X/wj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFB1F37D4;
	Mon, 26 May 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748281915; cv=none; b=Cz18kCCaMK/uAuP/Pi76wdqtH5rVHYF6t83TXdSzqBEJTKgOS+d45EShBwmbk5eq5emabb+BA8/Gwj4I9PcfF2skT7QSj6NaX8xlK8XyRm2pxokBFqo/dhgvOQNFYZm6hBK6caBkYK3YG6s0p5jWfb5NrlmgP1gdCm9uBprBRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748281915; c=relaxed/simple;
	bh=2k88PnJhpaw0nwX/rLtY9mHSGuWNeOjNdRUmXCcIA7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRjHrRYUSMxJ0dx6ekknnn5b8z9UuJI+PwFXMHjxZlDZDvsnBm5DgRUfctMk4lmovl1/ZNZ3lxeqz8GLFbaNTct1ngl4REnMiP+LbAyBzSeqYnliN4C5qtr6+YgL6vqV9cr4QF57IhUJu6qeavcilwmCpws0iUzdFkS1mSVqzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teg6X/wj; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-601ad30bc0cso2112859eaf.0;
        Mon, 26 May 2025 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748281913; x=1748886713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k88PnJhpaw0nwX/rLtY9mHSGuWNeOjNdRUmXCcIA7w=;
        b=Teg6X/wjghzcir4ybGuWUedickjSRo8zS2k9FjY74B4G2/t7RVeF0Xyfmo+dtRpeGM
         EILOWwXImyd7OEr3YMeoAW4zzzvrNJ19cVypq12x1KQmSPAZJ186W+tTY7ZHiCf7NYP7
         b4NOLjQLPHcOfe+tLPKaB9M6FyaRUT3agpMOxXXduD6ixxGmrgQWEfM4hdg8Z1CeAlnc
         Hhp16NkErJS+60lNfG1qgoW61/Wx80ZOZ+yVjvEdUsc3G7HifwkZkSCaLBXrG5qjXj2p
         a6yRU1irtLKe5bV2R45h6y0pWeNEO0SQZ0JUbhMfJh4IGW71TIpF9zdUg/+v5VKrPCZL
         Mz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748281913; x=1748886713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k88PnJhpaw0nwX/rLtY9mHSGuWNeOjNdRUmXCcIA7w=;
        b=O0B0muLTnDrxYVrPnjo/aEWTAKAHOft8WumleKxyEcCCFRHPyKb7mkl+6e8jVsgPh1
         dpKOLzXrHou7yQ+ljdGHB3GA92wOHWPlatQQQR6x8zWmA/3WsRK0eXu+s2dl6criSrH+
         aw7i2fkNEBn5mpE0Ft2FQ+KvuSfGT/iA3zRcHhb0xR5so3gktzd94kVr0ASyZnuhmYIg
         FMlg2cWIZI16JaCqdBGHlGB44Lcx96WsRL1Vn2pNLJ1MCyMW+3RZetqRx5Nu6F/Vywn6
         /FGg3+PqYxgEw3li31T0tDX9w9PnLRrM3KOE2bC3l+bDOPXO+swxr8WmyRxVuYfuBmtG
         VwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOrnlLR3Va2gJ6ZRklc/vqxTNjfPg8Cgu1TLBYZ7x+bFdkeLgehnkplG1ITETuy049Hxenlv1907ao@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7cHrpuIQKd/ioCZaot6smEX/5qUKrzc3Z9fdCRyVGJRQbCxq
	toLHniXdtX8VYNMIrqRRUBVHCy9ZIsHJGZKonKJa6VdGY5ueRXrQ26Pu2B9s286E/fckDJZvJ8Y
	RLVTx14aLL//2MXgIFOuYIRhT4Mb47+8=
X-Gm-Gg: ASbGncsMKwU4Z3Bfi71pS5YY5nRnKbU7MDrkZAxkQVtaad9fjRkr83jTZYW9A5il9Px
	1CtTLH9tLP7jY7o62+6Va9dZTXrnXQ6/QkIRyo6EkLqyQStIcH0rWkXvCn2J2xB+ECoRB96/ka4
	X7QlEXPl9ObM1YfaV1V5MPf+9mBiEX1gL2
X-Google-Smtp-Source: AGHT+IHfQzUQlWpF3xqMyX71z6KhzG9Q7TBZLdmiLySLL7YcDhNzHNOHQWNhFnhWKVRrbrQnK/7FWB1TjDqwBrKBPLE=
X-Received: by 2002:a05:6820:818e:b0:606:3abb:1934 with SMTP id
 006d021491bc7-60b9f9373ccmr5453708eaf.2.1748281912877; Mon, 26 May 2025
 10:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524144328.4361-1-dskmtsd@gmail.com> <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>
 <dbf60d49-fa1e-49ce-b6db-16e834e42e42@gmail.com>
In-Reply-To: <dbf60d49-fa1e-49ce-b6db-16e834e42e42@gmail.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Tue, 27 May 2025 01:51:40 +0800
X-Gm-Features: AX0GCFtT0baM6oZKA_mDPeBTGvWFL0qzuDBj_usrFR8qpdJumaxPdCqhTum73-0
Message-ID: <CAEz=LcurXJWDws=D1CkkDhOrUQB-xatszjpZp67AUou-Cs39dQ@mail.gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, leon@kernel.org, 
	jgg@ziepe.ca, zyjzyj2000@gmail.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 10:54=E2=80=AFAM Daisuke Matsuda <dskmtsd@gmail.com=
> wrote:
>
>
> > Your ODP patches have caused significant issues, including system
> > instability. The latest version of your patches has led to critical
> > failures in our environment. Due to these ongoing problems, we have
> > decided that our system will no longer incorporate your patches going
> > forward.
>
> I always wonder why this kind of "report" seen around RXE never includes
> the details of the problem encountered and the steps to reproduce them.
> Everybody else in the linux kernel community does so.

Test it a few more times on your local machine and you can re this
issue, it's such a simple test, can't you do it?

>
> --D--
>
> >
> > --G--

