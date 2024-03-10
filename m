Return-Path: <linux-rdma+bounces-1368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFCE8777AB
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 18:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF12811D7
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D5374FA;
	Sun, 10 Mar 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm8pH31F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DB8485;
	Sun, 10 Mar 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710090153; cv=none; b=GVB79fE6VYpWmomQtjf5RgX+OBfzUB8jQjob2+6ky1sffE4at7vVZRTdWL8XFn5hQNLZ2Y8yShG0ODdgUHfkxx5NNFQ8nMYOMI8PaPYkHMDDFvSCCYE/r4bN6K/BbbRMgtPHxVwFJgl1JzTQTr8cqnvLDpKCvS5gdMXzylrVi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710090153; c=relaxed/simple;
	bh=F+iPS0EP1K4D70rZpNDkKBZBEIiXC7boY4epEpSGBxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijr/x36fqv4P7HpHbrSKc/RXJcz71738ZhDJlWYokds96VEwFYgKr229tDYH6BDxq2ARLPdyWcXb+kxUDj77PWMuvLkejOQWBuwd0z77PXKqOlOGASLO80Xdr/kLN+VwbMChCzkykj09BtDt6Yp1lTVTOWsI9+R3vHgvGManAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm8pH31F; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29c078370aaso59206a91.2;
        Sun, 10 Mar 2024 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710090151; x=1710694951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+iPS0EP1K4D70rZpNDkKBZBEIiXC7boY4epEpSGBxk=;
        b=Qm8pH31FRINexIP9EE/4Wv0iTaFHa7dyPULctr8J+wjXaqCfYUTKRbEOehIhDetcJt
         iltJzBIqszYrCw/9fZhvseRQays2+ibZKRS/NfJNojyypif3zsrnLvNNWqK6fIkv2zaC
         wi9EXLaeDu+JsHYkm0TvEgfns9uebWiXJqLMf70KuWcNfsUhhKDFX8rX5eLrFs5Mlz/W
         /3dikKH5CS9QHG2UvbynyHSfe81dZhlKvP7ea7a14GnBIpB6Z/KpRx2XZ+LyQ1OhZX+A
         jh1RnTGHPvHOKvYaOXkghhqk3mxpRGVDwFSYk8fW3oLEemOmzkksNjJ0zkVC4hP3Cq/O
         laog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710090151; x=1710694951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+iPS0EP1K4D70rZpNDkKBZBEIiXC7boY4epEpSGBxk=;
        b=St0+z8RPiEDoOyda5BU6ZSnNvSoKxcls2OX2nvSmoVCsEt1LvTEEPmCwNvH3xfyA8Z
         KQp/I4TtgBI6fbVKM0oC9IaK5vCcGpib0N34Lc/TRvp4Ug/AJIYY5ZCTqMinOvRPYF8F
         daQtk+NDEgz3sAzyy1KUp6LyGcX4w3tJdnijMiB/PZPFeXAe7nOZW/sz9GNoyyTtykWy
         gDgo+83c3gEBPBU5q5fBoWPOJRZQhpbEalkzF8+PDrrgfhNeRdpydzrFEYMJRKxdUxwS
         /Ctj46oj7ObFFJ1xy1n+9ib5JspmpSwS9ZpavAN/1TMQz48M0Zkdr3ZjuiNrCI0laRR7
         g+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUh4/ZWeCe56VFqltxjo+us/YtAjrAl9BpG53wJzi9E0+G9rgq63u9KOupL0qsSw4qd9HvzR0WYUK2jUVY/WsMAr3ZudO8fEHCL4kbZMqLbS6GnyhYsvFi0XLn18z5au7O7pT35oKEldw==
X-Gm-Message-State: AOJu0YyjlMcbDlRSvfetIs/uW6DdkzGZQ8wu614+wKN36A6ABvrhXKKh
	0xQVd9wZHwyfIPdpBSjBFrlcnfBToUeN2cyQkNd4TgCzzXyZHNOM6WqSSJtXTnwkrfxzO98urY/
	unlQn4878nrjTWP2td2Nq27j9EUU=
X-Google-Smtp-Source: AGHT+IEc5PSESHty0ru998s3fhbY/hT5nIaoikegQZhReMvG7j8hkv669E4/6T0/wxrghoHuQO3vpqlSVFCB0n480wM=
X-Received: by 2002:a17:90b:802:b0:29a:729a:be2c with SMTP id
 bk2-20020a17090b080200b0029a729abe2cmr2463281pjb.21.1710090150696; Sun, 10
 Mar 2024 10:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com> <20240310113306.GF12921@unreal>
In-Reply-To: <20240310113306.GF12921@unreal>
From: Greg Sword <gregsword0@gmail.com>
Date: Mon, 11 Mar 2024 01:02:18 +0800
Message-ID: <CAEz=Lcvm9a0Zg-V8O5xPZ0t3BHNj8+H-wSdSn0i4eZfZgsqRNw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
To: Leon Romanovsky <leon@kernel.org>
Cc: linke li <lilinke99@qq.com>, Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 7:33=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Sat, Mar 09, 2024 at 08:27:16PM +0800, linke li wrote:
> > In siw_orqe_start_rx, the orqe's flag in the if condition is read using
> > READ_ONCE, checked, and then re-read, voiding all guarantees of the
> > checks. Reuse the value that was read by READ_ONCE to ensure the
> > consistency of the flags throughout the function.
>
> Please read include/asm-generic/rwonce.h comments when READ_ONCE() is use=
d.
> There is no value in caching the output of READ_ONCE().

Agree. Read the link
https://www.kernel.org/doc/Documentation/memory-barriers.txt, too

>
> Thanks
>

