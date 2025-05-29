Return-Path: <linux-rdma+bounces-10906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9496EAC82E9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 21:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C6D4E0F9D
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426C2356BE;
	Thu, 29 May 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSUxL6Eh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72C235076
	for <linux-rdma@vger.kernel.org>; Thu, 29 May 2025 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748548487; cv=none; b=u/TNZgqZt1iH22c/4J/Xn0FyXQULORztNyuYQN8IorMdLq1LLvwznumoyJDtG5jXOekqG+GzuupysifcMnQyKfDNwBeK3jwAIw0xWx4G4NLsZH4eJQw8o4anhDWjtdGtsKUK3J5hKpyKDFH+3QPu34E5yiaSZrIktWWXcsUZ8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748548487; c=relaxed/simple;
	bh=KDAyZCxfpcHV0to5/wSFImIdoFPpjfeLeo2xpeGVPeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZPgoh02SWwTLh1RhZoA4XbVS44YVSUisVG0pcRTppT+5zq3TEeoksDwu0estsdnE+WpIzLWiOcFrYrL33pmLjYmk5ko7Wj6AlVWYpqzYmI3y8ViTQBS4T2UlCu7ucEOu6kkjJIGXJ0iQNWAoqByN1GxUeR2CfN5znDgFGnxCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSUxL6Eh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2348a45fc73so47455ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 May 2025 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748548484; x=1749153284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S4lB4Gv2jYjRHEOEuJ0wV1gBVt5Pet87rhCpqcSobY=;
        b=MSUxL6EhFcxZAX2nnGpVvd6okohJVgLifzOSpskOkM1C/UVhFz2FyRM6BndNBkInq4
         XRCLCcKD003T1nXhD9/IxCeLSEh0K3JwlgDsUQJ3pchbE0TlozSoDSqP8R/R+o1TBdJB
         oAwaE/C2rHV/IqbTHYaUo8eGIOdSw1PM03dTq6LTBYqRXxx9u4HeKVozrA5eS8t1SxDr
         XorECmCtUU8RMdyTIdE6fZCmaSmy8gflI6M+w3JQSWFa7mrjEntSPHU0sd3CmUGDCs3p
         vfnKNmXYrzudRI236aTDhSqhBpYvxIIVVVHtZzM1DbY5Hrblf+VzcvFgxia7VPLa9QZ9
         U0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748548484; x=1749153284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S4lB4Gv2jYjRHEOEuJ0wV1gBVt5Pet87rhCpqcSobY=;
        b=eqT5gnp0riK1V1is/sJkBbHAurSvdTmCEeR0jbRfop362blhU51qbrIYs9cQckYgOo
         9gpK1Bs2nr9bm8Xs1Vp1K+x8+3a8f3s9JkWVApVt80ZAuFuqDA0uKaPIFallcVlzsPNV
         10Cy3AcZrFfDziWXbEoU2l051dkjouYH42zfLlf6nR1Hmnwk7akNjOH81Q+7ER2mysCi
         RW70Cj7KENVVhtH895JD7GycHwGpAnaLoBoGFZ3ARoUkSElXSprShsSaKvVIR708ss0x
         Ezvb84U+cgqaorArxLo7iyJWX3ERscHhwVjlYvT+Q6ZR9GHFtweGEz6+svMNX/sH3p1a
         tFAw==
X-Forwarded-Encrypted: i=1; AJvYcCUueIfag5tuA6nhaHdmP7AzF9du+G6aOJy1T2IcdNAEf1tMjfg6U3iJm6fZTx2f4GyYdYO6cTd8297e@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RA15jBPHCAYpmn4scqkpA68DD8AGS/YMQ+axz9QLAY165FW4
	ObcyO3SoPjcUTppMOXJorv5ESGDKSsz+puYi7lyl285an/1p3ZwNH0SjNMT1ivrByiBe9LYO5us
	+D8vXIPPtkml4T2gKbgTQZ/K9kGKAQO/25q/iT6WH
X-Gm-Gg: ASbGncsyZmeUCOSi8tsGHFBJPLfd0jIAEvgQqICqFgLenw0VoeLisbGNX1KYo5Wg5AQ
	GpJCdNw/A9HvWs6IWe9jmg35uF7Wc7ma+vLPysxS8mEFgaon8vxSqNiPDkNwSLexcXSPBlv23uB
	WFzPqd5H/DROABe4QOsZ3f4G96MOBSngINNBJdKzx4NPYoE8HSm3SLD1h++e5DlJQYgsM51Fad9
	w==
X-Google-Smtp-Source: AGHT+IGmg+nEhmGzdkLEDm9ONY2hZUhV/0fEvZFKjJYpf64+Bw18ZGKp0XAOrshELwrE2o9kRY3dj61qUB92cOKcTUI=
X-Received: by 2002:a17:902:ea0b:b0:234:c37:85a with SMTP id
 d9443c01a7336-2352e05b0edmr555885ad.24.1748548484265; Thu, 29 May 2025
 12:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529031047.7587-1-byungchul@sk.com> <20250529031047.7587-19-byungchul@sk.com>
In-Reply-To: <20250529031047.7587-19-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 29 May 2025 12:54:31 -0700
X-Gm-Features: AX0GCFt2p_r4U8_gCj8tNExwCZt7Mt1YqF_zxcfMdfPoeOcDtEP_NDyoXRdx3FE
Message-ID: <CAHS8izNyXM_KQiySAw4hZQ+FU8yxAZmcqvjsO7P3pM0HNy0STA@mail.gmail.com>
Subject: Re: [RFC v3 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
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

On Wed, May 28, 2025 at 8:11=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
>
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm.h   | 12 ------------
>  include/net/netmem.h | 14 ++++++++++++++
>  mm/page_alloc.c      |  1 +
>  3 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8dc012e84033..de10ad386592 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   */
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #endif /* _LINUX_MM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index f05a8b008d00..9e4ed3530788 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -53,6 +53,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>   */
>  static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page, _ref=
count));
>
> +#ifdef CONFIG_PAGE_POOL
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       struct netmem_desc *desc =3D (__force struct netmem_desc *)page;
> +

Is it expected that page can be cast to netmem_desc freely? I know it
works now since netmem_desc and page have the same layout, but how is
it going to continue to work when page is shrunk and no longer has
'pp_magic' inside of it? Is that series going to fixup all the places
where casts are done?

Is it also allowed that we can static cast netmem_desc to page?

Consider creating netmem_desc_page helper like ptdesc_page.

I'm not sure the __force is needed too.

--=20
Thanks,
Mina

