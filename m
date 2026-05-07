Return-Path: <linux-rdma+bounces-20190-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF0XNufu/GkjVgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20190-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 21:58:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D84EE321
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 21:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CF3302012E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE3481673;
	Thu,  7 May 2026 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="fowFJ6Ps"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3F3B7B9E
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183909; cv=pass; b=gqZw0ZniVk1wbaWW1W44NKyMDpS4iq53iNJQkW5bMMEBhK+bn195Wbj3gqm1q+e0AqRVL1jm8LSzOQuQQP5tt4hw1Fw9lyP6yxrUBXrBi22ufLiM0vlRYFQzP5xc3qPQNbo49qo9u5rkbm2ESKaZ+1zCopoq9wITIalphsTxaIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183909; c=relaxed/simple;
	bh=1jSX07oYV5nmDbjBLzM5NXog/gi/Cj1GqnNGlLxkTrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ad7OHIwE+8a2T6rVQq2tWXScydKT4t4NF38CfkI8xV2plTz/AJFtwmtQbMyTVCiZTIJlaVjaphTa19lrmlx/zUl1ZVAObGL27jXPp8QldJFy4datC9lE5BTa53bie71gc7+SK7p+n6UITaf+iein9/RIEaXQOFQLHiNbv2NcCiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=fowFJ6Ps; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so1367163e87.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 12:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778183906; cv=none;
        d=google.com; s=arc-20240605;
        b=XFWqfVXpwZMM3hMSI+zVIRCc0tl9vCFwbj/jrS1B7aqCEhi73URpaBwZLgrrt+Ig6g
         EmlbHBamdVc5eLkD7MPIrbg7nPUvbHPFdn6rzVVSOWeZPHiPPfUrtLHTB05JqD7v236Y
         npcZ7emCA2hw21VDmZ71eM7PikLCuS41CrmJn+hl+IXFxzOmL47mYI0XWfgQkyxtGlk3
         R+5FQVJWNXUmjEyngrSV61itHuOLdUk0QGtW28OBPFQfXa4mjiXbjnEV3ADWvoaZUNA0
         HcwwM6ZR0idcmMzVcrweXJxpDVLBpnkYW3Oa7m4jFo6bksN+M1ud22MfNVEBImje9Szm
         itMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C85H7yrmXDgU6/+EUppOZ9UDQs+w36vgGUBxNcUwSfA=;
        fh=wbdyXA7MDaqxr1im+nqjSyChxGPBcSOPOZmBVHhwavo=;
        b=SsVu9+Ln0LiwkfjPXsyEUEEFEnD6TXQosDqdlt4yk5jAqX/RYikq2x9/o7IRYNmVP3
         xYNzcX7Zrukpkf4/EC/97V10+rHAW+GjdXOqBdjcwxE+tJifVs+sBVz4Dzdx1orHQOXN
         vA0sJF87ReKH8jcZF0dxnZ5Q0OXtMLV3JLxXfqPFJHFLLgawUbWrTi7wj3hStNKrHVk0
         q5wbWLaGpmgCL/MxWMO2WSg9DOexsTkhG0jkWGr18wMPvYoUjIEUf6kUEtPWtUixnmeQ
         GflsS8TudB2d6ddUkdj6eZEUCQCQKs7clf8Sb4BB/ZQngt/uFPbBVS6Z1p9FuVWhpBiA
         v+eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1778183906; x=1778788706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C85H7yrmXDgU6/+EUppOZ9UDQs+w36vgGUBxNcUwSfA=;
        b=fowFJ6PsFp9rOzFF3FwhggMrvlKZTEkumnuDWCcDfjCouzrMa0HwwzeojkFQg9F9nP
         G/goXyTPanvIqY3oyKXtSuJJ59ACfogaRgTd0zexpBiWeKRg3mlt8xkiUam3uk/7XC30
         6EThW9al2qA4dTEZRMecl+ZRgSwRpBJwtVkZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778183906; x=1778788706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C85H7yrmXDgU6/+EUppOZ9UDQs+w36vgGUBxNcUwSfA=;
        b=Sbd+xwqfCbhK/uuvhosN5BvoRkwHd+gFEYOP21AT/QlNaDMrlqT7uaIb06NigTzHRe
         JrYZkhmpEiwlh0O4IxzEaF/CZqetg7qo71IgTLAlzMY+fA4Mlw332TLBqdWIFTJus4NJ
         UQJGZNCvLQoNcGbxmVi+FjTDQM3Xdb+JkUbLQpvN1osO4/p8IhbObUvZIxhKysNDGrpF
         +RIMMyISzVEznpGRgFapbfcj7IR+Sp4vSK/BM0wypAVhA0PZMnD3nfG/w9emwDxePPC3
         Vms+493t+WHGgA+iPEF3lvW1W+6H3YtCg083D0FrK7GNYmgnxDF5gVY3yLNyExST5fVE
         PMfw==
X-Forwarded-Encrypted: i=1; AFNElJ+J81PHNowMOAzlZruO42WyNayGkwgJyWFTPX7wrfargk/53X+hPkAC+p48c7ef0nXnCEbBec7HXJ/y@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxrQ7I1O8gt69FY6KXXLx1O0qf+iP/zm30y/nYBx3rC92mGsf
	yIl1zUV0JBa9kk2jOzMdy+LZvQDQytlcwHeCVU6B1kxvmK4X/Fu4ztMnASmQiq/w0Ut9mXbLhFA
	frFO845w6/r1dkFXfELX8QmVOb9rwF2ZBlZDHfdXEnQ==
X-Gm-Gg: AeBDieuEDF3PzglS4mw17ZSjLeNqkrI938OUJo0s6B1N+8vL+nYoRbanKqBXnjwz50c
	oqmunxNzDie41hMc83r1qOhf/FnLguHZN1M66y0XBlnVUA84XTiTWCC+w1nrukkCZ9v+ffOSxZp
	HoZS6l7Kcr6mUKLXIExZFTU2mopr1RlkaYtGwSThPTH2CqMvHMZJtsj9rwtDZftc7oHTrFRPKPD
	MNqFh+nTX26JaJI7ERPegH7SIGXVLnFpvzOsHL5Mz7SWPFBIgobYtZD4dcexynKTLQ5+EEznkGL
	p/ZPxmNZKkPkAomgZgqiQQpzIk7z2dMHn4HBwB/QsJxxdeWKvaDl2IDYTmmOxyE=
X-Received: by 2002:a05:6512:15a3:b0:5a8:837b:3d80 with SMTP id
 2adb3069b0e04-5a887cde91fmr3430288e87.22.1778183906018; Thu, 07 May 2026
 12:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com>
In-Reply-To: <20260507095330.318892-1-tariqt@nvidia.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 7 May 2026 12:58:15 -0700
X-Gm-Features: AVHnY4JV4VWIWLKVs-gDS5YcsOQgok0n9OUPOC15YHITVJSjQyfs1wXaBTMWrbU
Message-ID: <CADg4-L-K=PYju3pRYxxzH7yDTZY8Qig7ck84K_5PQxKh8SqV1A@mail.gmail.com>
Subject: Re: [PATCH net-next V6 0/3] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Amery Hung <ameryhung@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5A9D84EE321
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20190-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cpaasch@openai.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[openai.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 2:54=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wro=
te:
>
> Hi,
>
> This is V6 of a series originally submitted by Christoph.

Sorry for having dropped the ball on this!

Thanks for pushing it forward!


Christoph

>
> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
> copies parts of the payload to the linear part of the skb.
>
> This triggers suboptimal processing in GRO, causing slow throughput.
>
> This patch series addresses this by using eth_get_headlen to compute the
> size of the protocol headers and only copy those bits. This results in a
> significant throughput improvement (detailed results in the specific
> patch).
>
> Regards,
> Tariq
>
> ---
>
> V6:
> - Rebase after Amery's changes.
> - Address Amery's concern about header length after XDP pull.
> - Add a small optimization to memcpy the header length aligned to cache
>   line.
>
> V5: https://lore.kernel.org/all/20250904-cpaasch-pf-927-netmlx5-avoid-cop=
ying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com/
>
>
> Christoph Paasch (2):
>   net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
>   net/mlx5e: Avoid copying payload to the skb's linear part
>
> Dragos Tatulea (1):
>   net/mlx5e: Align header copy to cache line for Striding RQ non-linear
>
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 31 +++++++++++++------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
>
> base-commit: dacf281771a9aed1a723b196120a0de8637910b9
> --
> 2.44.0
>

