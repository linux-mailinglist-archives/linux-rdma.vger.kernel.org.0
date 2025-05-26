Return-Path: <linux-rdma+bounces-10731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F7AC437A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76F83BB3B3
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAF23F40E;
	Mon, 26 May 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5+6Fx9T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971ED3C465
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748280849; cv=none; b=kHkS9HjkRO3sldIXC5FikwK+QtWd+gAh/r3y7OwO7+fJ3Uvm6rK/MPgiteNLy5sEGl42EPTXcImZq3MKwFyiP111Y4/SkIoL4qGnsNQhG/AL2jzxnQJVY+e3FCL2lVWqaWDiDhAv/kRfF6nXyffd3gGuZLsRGR1Z9vo9DXVZZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748280849; c=relaxed/simple;
	bh=iLUd1Atl7F2XhGCO4Taa7I7wq59LVRkty/S6nhFd6J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uC5iOBjoQJNieOdaP6icsqIyiV6Tm8fyGYzG6tRTJNAdtSXctvX6/SgYiRx9bNOb6QY5C6IBWowH0NrJ7QxkMNQN6kOLI6AR8nVEJSz2teFOfuk+L06vXBnCU5jYC2X86NmBHjgskMJGj87P35l7rId+ckrbaa0/dCUH6fBON90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5+6Fx9T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2349068ebc7so45305ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748280847; x=1748885647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hgxk+Us9mQiW48CfwTTJ3SbvDd6vhg6S6WT+88w+Zks=;
        b=j5+6Fx9T1x0ZI0mXrTN9DCk2lDY6v3exbploQnxTq4Shoum7qJArG4mv+L6xSe5myG
         AI/Wq7eKLYlnP5ytjU4YIc/w3WNgmuHFCaY5LxW+59rVsApSrLm2CahADnCID+dY9Vm+
         icVSo5zTkg9tQqifdNdi4hDrf8oLEkZFDsyLjuXWhYTDaHQQgkqywbUer9uE6LUrddrd
         T0wJa8R/TFW+Gx3b1m2dc9Qmc1+LRrwllg5MFkYUqmShzhMglH0McTDwoXgwwg+qX+aw
         FewAQt1YS6C8krImANDYY465dELMaqwB4CYYC4g+/e2gH5iKfGsrN2YtSvcesa8LRZ/b
         ELHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748280847; x=1748885647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hgxk+Us9mQiW48CfwTTJ3SbvDd6vhg6S6WT+88w+Zks=;
        b=KlVEMTSRKWVOqMhkFlQFBkR2TefUavzztFrbCUjkpHJg/usKArPlA78ItZRa61A0OZ
         0WMxXcqUWSZnVhPo5fIJxA++f0bKobzpI5wYjeq7ZDYyK4mBx/pd6R4jgA46yjJ6+6Wd
         CLEsJCtdHe+7lTNU+q+GGoXLE2lB0SVg+B5/zXIm9ib+I+dRlRXWr9EF46vQ58gFjIkm
         Joy6dxfi3QJfztk8LQKM4HjT0se2poeZZZPGjAmR5EaRlGjd2p2jxSpxyBtyoIksG8HU
         d4I2K854HCF9To0QHiXkZHMX4kcYRNDwG6ygoMSTnIimBbhMcV7qmZ8U7MxpcjLOG5NP
         GMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW+5aUyM++VjpBm+L6q7obkbgP15vmQydYBCnSm7G4gc33eTY4hbqSZp+jfWjhY+sR+np5lcJJ52DK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zUOAvSS8vD2uqCeI5A7bXUyvToilANGPTGYToQsTy9ImsN9M
	mpGFkTvQ1kBYZD35bAAglMc3pzQyODCsT2E48BVKSPmiBHoKhiFSyJRhxtn1queXuUQiEAU7cOF
	6noGfQi2WKCcDJql4WHyJ35JRDOb005tQ+ZcFFUjJ
X-Gm-Gg: ASbGnctM0nKDOY5/geuzYPEi1zgtaNl/4VFqJ0QNA/Bf5rZhSSHc/yXJMCBeegTQSxn
	ngE1BNDJjSCiclEC5WPsfJv1AfnjVaIfdfItsl1lOiO0+xtRNKjXleqQ8mJ6w28OhyhgvVc52pW
	oZQ/pnMtkiYV2dFH3M7eppgjPbC3uRh1u9dNEoyR6qH7qn
X-Google-Smtp-Source: AGHT+IFQ3dUetNFfbOk0QYXpICwB0ij6uIvhORtrNLO5srstLqnDueoHgPjQ8gqgOvQXudMrOUcM53NL7t+iY+hfgmI=
X-Received: by 2002:a17:903:234e:b0:22c:3cda:df11 with SMTP id
 d9443c01a7336-2341807dc84mr4471365ad.10.1748280846532; Mon, 26 May 2025
 10:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com> <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
In-Reply-To: <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 26 May 2025 10:33:52 -0700
X-Gm-Features: AX0GCFvbcQEfDXG3A2E85eQ0suvZ9QGF79i6mkSHWdI2UWVhJN8XZ-nz6-kdVFg
Message-ID: <CAHS8izM5xd=cBRuUpAUNtcFzZ3hMwmseyh6rsV+WPRAvdzv4cA@mail.gmail.com>
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct page
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 9:57=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
> >> Removing these asserts is actually a bit dangerous. Functions like
> >> netmem_or_pp_magic() rely on the fact that the offsets are the same
> >> between struct page and struct net_iov to access these fields without
> >
> > Worth noting this patch removes the page pool fields from struct page.
>
> static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> {
>         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IO=
V);
> }
>
> static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netme=
m)
> {
>         return &__netmem_clear_lsb(netmem)->pp_ref_count;
> }
>
> That's a snippet of code after applying the series. So, let's say we
> take a page, it's casted to netmem, then the netmem (as it was before)
> is casted to net_iov. Before it relied on net_iov and the pp's part of
> the page having the same layout, which was checked by static asserts,
> but now, unless I'm mistaken, it's aligned in the exactly same way but
> points to a seemingly random offset of the page. We should not be doing
> that.
>

Agreed.

> Just to be clear, I think casting pages to struct net_iov *, as it
> currently is, is quite ugly, but that's something netmem_desc and this
> effort can help with.
>

Agreed it's quite ugly. It was done in the name of optimizing the page
pool benchmark to the extreme as far as I can remember. We could use
page pool benchmark numbers on this series to make sure these new
changes aren't regressing the fast path.

--=20
Thanks,
Mina

