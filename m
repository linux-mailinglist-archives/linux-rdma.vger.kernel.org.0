Return-Path: <linux-rdma+bounces-20193-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALQ5MLz8/GmxVwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20193-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 22:57:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E184EF081
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 196F2300F5D7
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF33732E13B;
	Thu,  7 May 2026 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4T3hi0m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EE30E837
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187147; cv=pass; b=fhcPtGQ1zogcTGcxCE8EpEdoSUGXecblDkNbURVjv0LfkEQd3fhPk6xsWgKieW0pSH6nFiuqoka2PJRyRgyzxbqbOxMe+uWIuAV00A1zrLOVYfK6qypaRL/TxIlwLPpcHG/JbxSecdMyoV3l4cqU6LoOd0NHsAsbS5PCzlwDLZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187147; c=relaxed/simple;
	bh=86OSAQIYk8Fza0WBZAxsFaEjEAENY+zRLdenWp0sSXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oijBtFMZpurM+rOLNYmKrcVDtPZqnaVia6t4ND2AraKJfAcs48E5SGC+GliQBSKdvxvVnhYVcTDQTTF7pWwncLE73sWYz++YNjB18jku8R983l1Qjl9BxpC4rdeUpIGCpjj2hUxnz7sGUjxUUpZYPKlSDOm7pBnDo6fHqDbRVTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4T3hi0m; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so14290387b3.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 13:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778187145; cv=none;
        d=google.com; s=arc-20240605;
        b=iRKeZCJxkeqeuq2qwKnmlFZ5KtvmQYD9FsMgFpCKDJkcq5fkzz6G4AyY0KI1RMh1oe
         mjD7gxT8UhGbHCiwbzaRz+dIM7tmjvvMqEvDG5FewPUaZeKqtBjMik42/QiD/QAgqzG/
         zGrucsA11lF49UE/w0AyMwAzqaRsA9I+566iQx/mRA0bSzQ7yFunChsV/rcdBZFIhflA
         T3TTQKpjp6aMbMEYaBCYJUrwMRBw9wb5YC8KQ+r1qtUs9nbjJiIxHAC/n/ZtOSaixM1O
         1PO2HGf5ITldKaqsebSAovAQx2ybw119jhFvkhYjVW9XTaXfijHMNId66XzrJSDPBSM1
         3fYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AxGruxsGNZDKumgY5Vw8e2je4vXGSSu6VCMkCFSxceM=;
        fh=HHAhEFkfULyXY7EFRUQsJktBMN3f5c24SNkVcXDQtI0=;
        b=JNx+3oATQY5f9pRz+ZBPWFHUq2t3hYL/P0SIlAXL6mvx0qs/p88+aES+oSx8tyO/dW
         sH4xbqd3baKS6YIeOtUCRWMt6+/0tnYqRt3DvasUMcpkKDFY7v0m4mwLECzgOcVKEwsI
         FrHBeKO/gZG5rLMStTlb+4VE0n9YauTwp0CjQtqQln8F4mdF+eQFDfujQCSGPvhmvasI
         DMvYoYhcOGi5x7LAemrF0Yu79CF8m/ehXInYVF7FU+vbDwU6cx+Hm6B0+yagwPuJeI5N
         F9eq0D6WrFCCfFAAY5NCQyVmN/EJi1y6kkbZ6lvzCB2C3VAn7CGiE9nHahMO7Fw9xlf6
         e0Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778187145; x=1778791945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxGruxsGNZDKumgY5Vw8e2je4vXGSSu6VCMkCFSxceM=;
        b=o4T3hi0m35j+VkZAncDB4DHYKDrYS9qFY4RAlCJhP5apoUi8+69GFuUJVmauKr//51
         TznYikymrJJd0Ko5LM5Nsm/+Ex3J+Ojyoa9Ok61bNi7L82DwXMVuPtA9mYk3LWhgJuLU
         O9HIbtWF6PMvkVgle8aFvMooD95Z70PVDsqdrIGTdITcY4QCggIwvuL+01Ap7ZNhkYnI
         ZiEMIJjdkYnCKL/RRdoZU0+v/BdRea3RcCwbx4qv98UdZ2IdWwY4tuAFXXqeFCzYgMt4
         lESMvvRMioKaTNJbTPSwocF//4FhePA6LLQzrjwLdMNeZUafMTcMldWgOhAk7dEsD2mK
         7zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187145; x=1778791945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxGruxsGNZDKumgY5Vw8e2je4vXGSSu6VCMkCFSxceM=;
        b=I9Y+Ir5aTBa3zxWoILlddnswNdWp/R3P/vSQ7yq311bJgGz7JKbb/MogC6Mbr1MMUJ
         CNYHuveOhEG+wqgERV/kMTzaYq6nRqICpmHQOPrnhnTA5uZKk7NDMbX46+WQJStaFGTh
         ap88STRflzO5otTmxTgdaeRejgiC1D0cYofDWdP7nVOzBdM4g+AFHM3ozBTmdCgM8gb5
         m3j50XvVe0W3qC8WlpqNhVVaiwRxS1MkfHkM+cuXBAtjxngrXCt5UNhDCh27TBu9yVX9
         dR3xoIiovcFA0S63UdiXHVkl6pwHNAGM8DvsF/NriMQ0b/WLx8F57YwI8OlCPZeCTjMn
         O88w==
X-Forwarded-Encrypted: i=1; AFNElJ8XL8qpt1PAyMq81RJWsoN8mXVQQGDpMc3Y35fbvD/lu7CjrZ6QJKTcKGJ2DX6H7t4CoVckZ+PDLORh@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoHXVdngUVfSYJGOlBGWCrOEvTyc0/9NS9lmjjVoDfEXmw06L
	NInaRaSraQf+KsjnfgUKvg0Wmx+fjd2kCcqJ4I1K6+F9dt3+Sg9SRCRg4wdZlB7FiSUiTJ5xlpA
	vea+xZmIcqJrcyP7+v3oXprgNUMGGeCI=
X-Gm-Gg: Acq92OFsabR20+QpXdUWrJMP9A9bHQQN0y0imjV+IqUk3RvhN4V5Yq0E1a2I1x5kC2z
	HHnQN/4ihlxAY2du8ioBSIr6l0Pr2EWQiY1w/NtjwvH4RGM5oFtMFiz3jyvJKkX9Aa/uqmKR7Od
	XoSS6MdTCNFRdHdtsJFE/C7TknSifBatOO30BtK8SpuQUtJMrSC8hQBWXnv0gqPZ5RT4NKv3MTH
	+3E/NtXRrg1cRjDpksqIpZfBY6UcxBTEyrrLRUHti+UG76nv2RU1rt2blY2mkpdsckjAy38u8oO
	Q4azTnwY
X-Received: by 2002:a05:690c:399:b0:7bd:9f34:59a3 with SMTP id
 00721157ae682-7bdf5debfdemr105514997b3.11.1778187145420; Thu, 07 May 2026
 13:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com> <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
In-Reply-To: <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 22:50:55 +0200
X-Gm-Features: AVHnY4JXLq0U2mInYg8CWMgYg4YNUYRiIklNKGDbus860W7Gzb2PpLEEAl4-lvc
Message-ID: <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 28E184EF081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20193-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 4:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
> Hi Amery,
>
> On 07.05.26 15:53, Amery Hung wrote:
> > [...]
> > Am I understanding correctly that the better performance comes with
> > the assumption that the XDP does not change headers?
> >
> > headlen is determined before the XDP program runs. If it push/pop
> > headers, there could be headers in frags or data in the linear region
> > after __pskb_pull_tail().
> >
> That's right.
>
> >>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMI=
T, rq->flags)) {
> >>                                 struct mlx5e_frag_page *pfp;
> >> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_=
rq *rq, struct mlx5e_mpw_info *w
> >>                                 pagep->frags++;
> >>                         while (++pagep < frag_page);
> >>
> >> -                       headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - len=
,
> >> -                                       skb->data_len);
> >> +                       headlen =3D min_t(u16, headlen - len, skb->dat=
a_len);
> >
> > headlen - len can underflow but will be capped by skb->data_len, so
> > this should be okay, right?
> It is safe. But it might trigger an extra allocation in the pull when
> len > headlen. We could also skip the pull in that case. Or do a
> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?

Make sense, but this line took me a bit to understand. Maybe consider
checking len < headlen first?

if (len < headlen) {
        headlen =3D min_t(u32, headlen - len, skb->data_len);
        __pskb_pull_tail(skb, headlen);
}

Another clarifying question. So this patch will improve the
performance when the XDP programs don't change header length. For
those that encap/decap, they should precisely pull only headers into
the linear area for optimal performance. Is it correct?

>
> Thanks,
> Dragos
>

