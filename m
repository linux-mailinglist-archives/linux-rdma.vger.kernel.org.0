Return-Path: <linux-rdma+bounces-10799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B5AC5FE1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76081BA34DD
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C01DE4EF;
	Wed, 28 May 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWyu1Vbv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC18DF5C
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401991; cv=none; b=tfY6beKF/4srMJjs+tC+sTMlH1jgb68yFRlu/65ypAjAn8t1x3Gbvz099iJ0kwJbpicz8dx887zeow08GMVIfWaPddfFL3Wc+cEA/XNnVcH5epJoi3o1PvBxqI8IYVeUJs/m4K4eukM+LxELo0A2T0XLtueXY2WOFTPM7+Y+7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401991; c=relaxed/simple;
	bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4w7VldH/tcijRDPTFwqXx94Vo4nCC1loMYCdfLu1r6j7h3nUIsAT8O292VP7E5x0VjNI4H0cjJWwmT5lDxPyaFCJr3Rg8IlQBKeeEQ2ZTjyjNk3NAEU0cWLzzecFb6H7AeHk/fQlgZUaJjhxiK40mgFyi0jUy0uxpIuRRkCBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWyu1Vbv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348ac8e0b4so69755ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748401990; x=1749006790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=ZWyu1Vbv2ejyjuwmvqu1s5LfjEB+ZlDCoQcWYYNoKJEIHuwynv37TA4DSBtp1UaZ0S
         zuJRuTA+hcMV3KHX4mCcQuBv+9ATmxDFcW1KDMbqI3vgmdVEBlR3+86X/gnC/kjumIqo
         hpUv4Z8VF64uiEztKO29w91LCXXBm7SB4I/vRih3EVRgbicfFWwMWAnptFa45ZrwtrwA
         3Vkq3epp/y39JSoFZA72R55fuSQflQs7VGkORFX/afLDoMqhcUcxbL+A3PXGw+R8XuYt
         ehXEjMr3F8JgaNKtCttMdDn0q/wht2A2DHeROq5FlhKDhmnDC1MRv7OnIiWcp7MKB8g9
         uv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748401990; x=1749006790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzZKAu+ekb5wfUFWFWxFj7mtfUTDEeQOhI9SgqQhXNE=;
        b=hPvQ5KKOU85LuinGtrbkhaJYZ1Zh5QOV9VgSXZ+bDrmQ0TFmsAFdaydlnKDjeUDLFN
         i/gkSy2D2qq5xNUwRNcIyVsthWnFbqiZ5UNpGPs0AqFvhio0IwdHSJwppF7+mt9arApD
         /qRQpnAVe9B40+253Ag+w3+EJwHXRPGx85QPhvxNNl+BCH/lFtqcG1VXzBfHQBtoIiiA
         fYTIpf+3R++k3a99vDXXO76Zr9j5kJiYdtJSeRp3gA2voi/HE9GkCxNBRw5LMMwuoEJX
         4oCNzPh/VIkfdlLbZUVvV7cf7zghDggRY755NnOkxr7tI99awFOes6c+Bz39sC6BbnuY
         UD4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7IowhN/9/RXddAX2KVf+VVKWQJJeGoWha+gWR54TRTcy5OMUPAHHp661qf3Yug5TMNYfnPEFtYAPz@vger.kernel.org
X-Gm-Message-State: AOJu0YxRn6X9IYUPQiYb+8TeCuge8slpns4ycSICpEIWQ0aZPLZChHwA
	tPxAJ/3b23tLnisCrEh8FU22wXOewqWFztiiY+xqB0O3EXI85TZ4QpIu47ZFKovIgu6E1iPKomJ
	x5zDjRby6znRK70xJnSARv2xbgEz8yOZCiXvTCh/O
X-Gm-Gg: ASbGncvNjQYS4PUHVE4D8MiUx+1utqnwAe+IXmaGi3VEP4Tsb9UhUbZH8AwzdK2TwDf
	Lz/d23/ueG2eKwxUvnfNS46WDrC51jlocXDATsczhOLrDQYOfx+6tRHZ439LkdSV1cYpqP5jfuT
	CS6pgIZWgcphqCg+BFB5wTpTGz24wP9Hfi7wds+uV9x5Ie
X-Google-Smtp-Source: AGHT+IEDUY7riFOOR08zN+pI5SwQ05vmhq98GyByeU8awQ87xrmYDNUTemcQa8sUY7rtO1VWlklZOkyX7GAf8CRHf1k=
X-Received: by 2002:a17:902:f785:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-234c5256552mr1833575ad.12.1748401989824; Tue, 27 May 2025
 20:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-4-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-4-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:12:56 -0700
X-Gm-Features: AX0GCFstQ8TSymZiP1u3KsDOqDNDhSVZvkeBqi3jCf2XyHkp_VooW3rcyXYh7Xo
Message-ID: <CAHS8izO_ypBm4htYOZ6mDqn5hge5S_3DBKHHTdEW7ay86MsSZg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

