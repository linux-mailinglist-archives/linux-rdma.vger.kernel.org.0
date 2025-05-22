Return-Path: <linux-rdma+bounces-10578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C0AC175E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 01:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C163AEEE6
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418232C3768;
	Thu, 22 May 2025 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBYmjSSo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8642C3744
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955392; cv=none; b=slf7ht95nwwUlqUvu2IrQHk5znCdPMl6mQjr7fZyXxAju2hx9LJc0TVNlppItgQ2ptbNZScAPOO+z/AEW/BuVtf2frif51RQjgktnAeRFalI80LAPDQphYcHovIuU7VSCdOIlo8ejjjg9MkMlt3zt0SvL/0l/2DjyHTH5xKUod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955392; c=relaxed/simple;
	bh=xmmNbzOUYy0JPMzyNz1HKekN9DEWLMlFpi6NUrnivS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEDSwrxDLaiIF8e/ikdxqEqBz9zJbnYcg+pn1RotdtdB5D+IgCst6UMQFpLjHWTwdS4pfL6RrL5cFsSqSQkcsJgufVATMojjjEW25mj8x5w7IZfMZHRTzfFvPSyOLfUTzZCYlNLF8B1/CM4PHlt0G2K6rt5kY5LjzaiGztukKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBYmjSSo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231f37e114eso49605ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955390; x=1748560190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CA0pRDW8qyZDyuAgULvPatj8bCNl1YIn/HHQYllO0s=;
        b=hBYmjSSoafOI0S0ZPxJeNb1FsD0Dhuq4De73697uVaZHIQu/b908L3Cvw7Nt0VWeR2
         wVpr01plp4T7LnxtkgExm/AZjelO2sQDlSZBpVaiRUSeyB4xJPVmEeH2sKm5QqDDz5g7
         OVzn8brgCLPHK9aAGw7wBJJBUomDm5MZjhDFBGS28GS4OUEhlPFXwPAdYqWZ4Z8Mbde6
         HoYupD9o079K9glKrhql6fqQDgNFiY2m2WycNs/QcLv32VnDtBnl9cSFRWnChVutMOo7
         pEQcg8mNwX6dS1J7DZ+0aK2yRgbVxpV5hMVkm8Edy1+3tCZW6Y3djh4DsqehcfOe4ejv
         A69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955390; x=1748560190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CA0pRDW8qyZDyuAgULvPatj8bCNl1YIn/HHQYllO0s=;
        b=TEj36FPfu+XNB3KsOi6WoRb9kGI6Ww+H26W/dlAs0KLODI2oYiQix3bFWGwR4t0oUt
         C9VosJ3AURduId3XLTZpBFsMCqaN8s+rkUXs8TWlZu1vzENI5awvjFXndme9yhe7fC9O
         ER85xj5bIXIgPwR8xIU8OJP8KorWClJ1jZA62aN1FIx1DH3kDNXr4CPbDAoctHOj4BGX
         o76Q4ST3gmiS7d2VaeGI02/fLRA1e+F1S5MKeG5dPWzyabVF0sSEzZqxKjOj0aPWKDD7
         FyQ6oSO4e1km/fLeNN3MRsGRslFwmPvu/nT3J7U9e7Y0I1tviOXL4sEYCGWy634L3kiU
         eaug==
X-Forwarded-Encrypted: i=1; AJvYcCUJh2rscO5MUhn3FicD+HZo26fu2Z8arTxEIBvWrImaAvnfXtrmpDEu1b+1fAKgXcihbh2hi8u4LbOJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9/woVPlyNKX41dq9WzqI2T1tWu2BEIVOjVEXT34SYr5fKZzI
	KY7sgyeevPQ6c5vv82/TqCLCQt4C8kDjRtqVWSNivpBYP2NtbXjAbLkhB0wEnxURsuf2i3m1FZf
	hooOWj3edzXGltDD9fNCvWqwLxd0mVw67lXZdSy7t
X-Gm-Gg: ASbGncsPyfEYJ+29oCYV+2dd/N9aQ97S9ICwkTJpNIK4HGygRF47LB6VBTat2BTQVBd
	2jr/USFSZ2XfAN2x5vjgjSdZRzeZYcZdaGZ3YvjODWV08wJyybrFDbG9d+IPP6Qfv0ahjpCYHWR
	QmXXaqQlWUrtPOkU+wL4cCvdHivfCXtOudpAOBy/7eF9D7L+S+f9mUi403fxO4uigzaLg3UrDEU
	A==
X-Google-Smtp-Source: AGHT+IFJtNB+0R2HZaOFLO4H9RgrMoQxEv/cH23gmsEVlbJSkVFzBnQPZ8T049oEzAv/Mchs37L4pYjnW9hurdHf+gY=
X-Received: by 2002:a17:902:f548:b0:21d:dd8f:6e01 with SMTP id
 d9443c01a7336-233f34d7114mr438365ad.5.1747955389173; Thu, 22 May 2025
 16:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com> <1747950086-1246773-3-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747950086-1246773-3-git-send-email-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 May 2025 16:09:35 -0700
X-Gm-Features: AX0GCFvKx6EEmbSiu0G5AWSPg_voGp_bld5yLcmbYZI2_sQO6H-AEI2Fdpricnw
Message-ID: <CAHS8izOUs-CEAzuBrE9rz_X5XHqJmWfrar8VtzrFJrS9=8zQLw@mail.gmail.com>
Subject: Re: [PATCH net-next V2 02/11] net: Add skb_can_coalesce for netmem
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:43=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> Allow drivers that have moved over to netmem to do fragment coalescing.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  include/linux/skbuff.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 5520524c93bf..e8e2860183b4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3887,6 +3887,18 @@ static inline bool skb_can_coalesce(struct sk_buff=
 *skb, int i,
>         return false;
>  }
>
> +static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
> +                                          const netmem_ref netmem, int o=
ff)
> +{
> +       if (i) {
> +               const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i - 1]=
;
> +
> +               return netmem =3D=3D skb_frag_netmem(frag) &&
> +                      off =3D=3D skb_frag_off(frag) + skb_frag_size(frag=
);
> +       }
> +       return false;
> +}
> +

Can we limit the code duplication by changing skb_can_coalesce to call
skb_can_coalesce_netmem? Or is that too bad for perf?

static inline bool skb_can_coalesce(struct sk_buff *skb, int i, const
struct page *page, int off) {
    skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
}

It's always safe to cast a page to netmem.

--=20
Thanks,
Mina

