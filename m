Return-Path: <linux-rdma+bounces-12042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067EEB00B4A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D342A4E2212
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B682F50B6;
	Thu, 10 Jul 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qT+Gzrgf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF12F0C4A
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171930; cv=none; b=CcomUtdDX4VGtQUZzlrstbDK15mY//PMBjXKAI/zc9rQxvqPQBl1lVAuy023wDMm2M/enbv30tOzqH+lJ4Etze8ia7xdFV3xaGbd/GbADy3/OASMNZKAjW/RgFZpN81fbW/YX1uXp/v4JX801ovh2pVj8KF3zu6CQtuznGfMw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171930; c=relaxed/simple;
	bh=lzOg863td9wmwIzdOW1a8mSXM5R7uBGHNR/Wq8C+XKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS9VJ3+mdpHEqaXbToB90hMl8X6Z+ZNrz0+YUZWr71zIeg2aNNJSltvKoBN6D13OP8ELPnEI2hqw6FiJYSf26iRO/tGOmbEHRpEYcC/K/Ka9Yw10mLRIpa0WkLZKrtGb5aMRqDq8oH+qXp5JVBHw1hLVkFBKBbhbC3SHG5YIrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qT+Gzrgf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso1975a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171927; x=1752776727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=qT+GzrgfFbv7TNCyvI1nwQhemlew7h2QPaGYd69Kqi499zFAgpcsA9L6Ql8C2UR+2b
         z67/WVydCFIO9AGIyO1OsXS/QNtLnHPNtzbW4xhg/W7vGQqQ0v819gJlOeguSiYqoazk
         yMTfvUrnnPivCdLvSRZcCBY1l6MvszfzuWVhO4rcMWA7DWJFMF0dFW5zKB2ae7KxMgpZ
         fQsioD+YvOSbxnDPApSnChHOEQ7WgMczdqaCs+9KmDuuYoiQI34SRzh8O3sJQLGt4fOc
         +b1hMmPhnAM2GtRhbfsEDW1nlV0Dlnerr9J/1xLuLVglKv5j2qYJvI6pA9uC1oWpWxyH
         6ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171927; x=1752776727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGttGecOUfnj2vDKboTFLlNArn06kYu+jY7WB+vGDSo=;
        b=p++i3g1lVXkoFg2+tB3GgbOzfdWwLLG5r18cE0PfPzQFicpSlsUHdUWhPOWQ0L5pbS
         aGQAE3gsfvPz2/wA/RIxjqdaObV9k5NRqYECMRWQYlGeMbsg3JyMvqyQ5ePuL+rdpj9L
         GGKzD/VcJAvWuZuDyB8+Y22gC2I3Eut5/DGPCAPGL7/7KjNlQyahXJQHPqeMTqFTWB6G
         f5sUoc6zd/Y+wzIxZbRPWmw5Ab1SyJhKqKqU5X+zYLIM0dQEQ5Cb5W9giiwl1AHZEd6z
         HIYnkRTMj01nkpUSESiqzTKUEPL8CMByD+yZJ5bwp7+i9zV9WtlTm48yy48QkDBIMBSc
         LdGg==
X-Forwarded-Encrypted: i=1; AJvYcCXETCUE8KVTTccOg7l+JcWiLgV0rESOZDiKL4eViFC/SGB3jZCKWruoCmVL1tywZTed26s4J5foGR2m@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxoikHkOKabjIc0kg3VdQSyBP52CxiLwkq8cguruKhuD2jwAN
	zIKe6R0Ia/VAbn5tI2qCddmPFyjhf5xFOiVplilOHOGHXNX5/YJhm8sK5TUgG9NpZ1U0saaS3oQ
	osSVqtyvAIxsoqfw6XqCUEA00++wSnvlfsdif3kMh
X-Gm-Gg: ASbGncugA606tB8s+PqqwAV04Rv57NR45KkSLF6CpFwkDswzMJv0pGHBDFKnCTlyqwi
	UtKjS31XipkCLBDckabAS21AijlDqr5GwsLW3RzCCD1QTdt7Wvk68WC+5N/8BnuvQ4RZbtTt2m7
	zoFppkwfMW1OPK6D9MF0TTtPBGF7stKrm7D57OYhtqcKy4McT1rstJegH30Z6EPbfL8WI053E=
X-Google-Smtp-Source: AGHT+IFYbu4F77iXBeAnMl5OLLUNqSyy6NKKa5nSrUrX3MSMLO1UBBwllp1ZZ2m2gbUJ8CJrAGBesZolk6+61YYGeCs=
X-Received: by 2002:a05:6402:30a6:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-611e66aa77bmr9269a12.0.1752171927040; Thu, 10 Jul 2025 11:25:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-5-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-5-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:25:12 -0700
X-Gm-Features: Ac12FXxKh5TJZHgIcSqvUZXVnJGYFBLJKrIZOv19NnRAZsweNKYOtzi0atTHg_c
Message-ID: <CAHS8izM8a-1k=q6bJAXuien1w6Zr+HAJ=XFo-3mbgM3=YBBtog@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/8] netmem: use netmem_desc instead of page
 to access ->pp in __netmem_get_pp()
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of the page pool fields in struct page, the page
> pool code should use netmem descriptor and APIs instead.
>
> However, __netmem_get_pp() still accesses ->pp via struct page.  So
> change it to use struct netmem_desc instead, since ->pp no longer will
> be available in struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 11e9de45efcb..283b4a997fbc 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -306,7 +306,7 @@ static inline struct net_iov *__netmem_clear_lsb(netm=
em_ref netmem)
>   */
>  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>  {
> -       return __netmem_to_page(netmem)->pp;
> +       return __netmem_to_nmdesc(netmem)->pp;
>  }
>

__netmem_to_nmdesc should introduced with this patch.

But also, I wonder why not modify all the callsites of
__netmem_to_page to the new __netmem_to_nmdesc and delete the
__nemem_to_page helper?


--=20
Thanks,
Mina

