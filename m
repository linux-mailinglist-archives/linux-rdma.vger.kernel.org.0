Return-Path: <linux-rdma+bounces-20420-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NroGpphAmposAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20420-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:09:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47F517278
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E95B301C3C7
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AC356766;
	Mon, 11 May 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCJHZAyH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA434EF07
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540948; cv=pass; b=KjQSdkayfEnelDzTYS0/3yMt2kTvG6a9MVpHMqyQHu9ZV0knq0Xv8WKVcDW4KqUAoHY0sOe66rhiEjGN+V0UCbdyy5adyjKTooZzLsknZ5KfUJlnOZtChMrA6Kv2FN5WxwdQWnpi38DyOwgGtvUYbHTisgRVOdMHn/FAnjonjm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540948; c=relaxed/simple;
	bh=cNsdw7g/MrqmszFIbkH6/LfQ50TlmEUmn8TbKqKMgN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDJz3PLiODVNB+2S1cbDc8wZzjFci0pn0m1eg+oucW51bFJ0svX9M+VJQRXxUUCjsaSDupAuz9IEO9FDw41TVNYG/vGIRNIZwvp55Oawc3QxO93hzeglrdG+A1dytF/uW+yE81h+Co5t1PiKI72BQw7gFBd45qy9a/U06UDwyDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCJHZAyH; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b41fdf9de2so38185597b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 16:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778540945; cv=none;
        d=google.com; s=arc-20240605;
        b=AVffAtC7GL4q3b03CYzDvG43Fun802MR5SMQRTCgLnySvyZBZiesvNSy+etybEa46H
         LOWGfbnqQLvctJ9FB9VV51Vbffxo3neEcXQWBa4qLAcKW70qrZTcwzOJ1rmjmtIq8TsJ
         ck8ix4o0sqkzZBjuL/zdClxiI/EguROOhKRqkhWKXLMszPa1+8nDBS9FB9oEly4+DCyM
         +np8Nj6cQF3ka8s86cQWPrkMGXjJjyDq8MblLshtVDIpBU302fxF6PAp7eyAATg7+FX6
         Y+rzBIJBYVnjbIqx+vb5mJuCa6GMi1qMDiFAhnsGVfphRpk4oNpfuV7IPOfZEVSafR96
         cqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXC3S4tQXXBF/WZfZZtgdixtBOfU7xmOv6VXX9PDdSY=;
        fh=RG9qt7a0RvB6/fnLsMezBHkZr0WnfU2vFJggMB5pBfU=;
        b=FRpa/Hulgdmgclc7XH+XGWMcIb4AmcfzxSt9unPI8QSCQ1FpjV0CRFwmc3/6FGfoOI
         dvWaVO9ye7JjY+ab9HJOQGCeZ0LPlmjkeRqfTMEuFIxMbcS6xbaq4RT0cbGcGK1x8S9e
         yexgdv/nJ/tFVMT5yCxuByeWpo0QELbj28QdEGIUqlM8QgfCuTGsg+eRMP/ysZvAhXE4
         0rUVq/jTuMPmJ5R7liMrxH4dhGgwYO9y2O2tqIHO+OojNALd1Wt/277W6HUsXti4WuCS
         caWBQ5GDk//1hD5h+Z1KxxYtBXFytG+jv/oZCjxZ/c6qztOG7yZcqzWEK3Q99RdVwn9X
         jW/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778540945; x=1779145745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXC3S4tQXXBF/WZfZZtgdixtBOfU7xmOv6VXX9PDdSY=;
        b=aCJHZAyHOC4DFFv91nL3emV+PxxlwaBrJNr5vho0nSYUw2lUcIngid1E8WwrBXBoqZ
         21Lr7Ht0eiV1FGJsDLkxg8oQav4GTGUqZ2qH9xdESmNuTqI7JLCLeGBEZwAoZKoW9qxi
         Wci+JjCgZKU1wYFWfZ86+iC5F6xGL7t2+PQCvqau34nTQ7DykDmUF89+KkxCDox0mMsg
         9CzIWxi4XZHL7BqIUeFROYEts8kyUlmxN898Puyq+HoQaPvSpnm88fIeBjQtvTcswQs4
         F0+XkIIaqPNDBdOPtp0vy6BHyRCm+ihSoKcKUvJe6mbtcfw/ZjFxfdcB4umB/lQULgAY
         hezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778540945; x=1779145745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXC3S4tQXXBF/WZfZZtgdixtBOfU7xmOv6VXX9PDdSY=;
        b=mYAxv1PJb4g2D7iqZKmPFI27WZ6KlIEfBTxDnKLJlFDyMRT3tzzigluclUUKo6G9dF
         HeL5SfZtzx/TLK9UWkZyDE+D7oUqxZZmDzfPtHG3d2ymTLpYsQNUCU3llMJuxoQBA54Z
         nBGbO7F4D+OiNVkZwiK7rQNMDMfMo2f6QcBlkzPwgxc6qi2AOohNC0cm2jayF5IXJExv
         7CSKQxqateYHF/01FQbdR8xLZEnuED6Lgcse2F/EGKgxFgR5BGfW+gaMZ0hZFB6twtyJ
         yZ6Lqm5zkf1VzyQO+QR+PkXR+3axsy655kFEUJgs0fepGGrBAG3P8yFBuKfLxkrXEV3T
         B6PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WzMPhpEGXDUiBw1EPX3lBBJF+ziBHODxB5mleuGfU7MiU1N1I275iZzzNtfA/4ZJWme3L2U/O5pU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4t67+XkMKf8hXvgjBkOwI8IoqsgCMbct3uah1I707o14hdJtS
	jtnOItbNoQ57JoVuoR8cmmokE/NMJkYy+Ir/Ng2D6KbUhZ2i0PLQPiN6GG3baxHuxsFOh1LJpe+
	8cWyZpZ41/KqtcR1ax62DFA2Q6EcAkuU=
X-Gm-Gg: Acq92OHlSzsIJMU813uXK4qq7ut1ksZBX2sSZPJu1fy1fTG27iJSomngih67CezrBt5
	aO3y8DKqK9NHNGqP9b1uaCbXNunnzM/P0yeVp0SJ8GcMvZhgvVAI45ncuegbJ6YMIb7ZCC/uijZ
	eRcO6VEyPIonXOzWueJXDE+2X3eOsaXZy2Dd+g1RnA/gj1ktGamq3uteS+SJY2im183GgYWMAY2
	0UUaj0tcydh3ayoeLz7VfcgYSk18VW0eP5xMz8YDLcOjuYBDnA09fiEXXWHtDyuhE+JxnRsdfBe
	r+ddPvaK3xbveiX+7lcf
X-Received: by 2002:a05:690c:97:b0:7b3:6c50:2e8f with SMTP id
 00721157ae682-7bfb9f8eccbmr164762087b3.41.1778540945359; Mon, 11 May 2026
 16:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com> <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com> <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
 <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com> <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
In-Reply-To: <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 01:08:52 +0200
X-Gm-Features: AVHnY4KLKD6htIEllFdI8dqPO2D1AdH38X59DFCpiZ_6MmShTen909W_j38aiKs
Message-ID: <CAMB2axN6USwsGaUQWkL52G=9V=kSe2La_gE-ppOFLWbPCnaVKQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: BA47F517278
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
	TAGGED_FROM(0.00)[bounces-20420-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 11:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 08.05.26 20:42, Dragos Tatulea wrote:
> >
> >
> > On 08.05.26 19:44, Amery Hung wrote:
> >> On Fri, May 8, 2026 at 2:15=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >>>
> >>>
> >>>
> >>> On 07.05.26 22:50, Amery Hung wrote:
> >>>> On Thu, May 7, 2026 at 4:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> >>>>>
> >>>>>
> >>>>> Hi Amery,
> >>>>>
> >>>>> On 07.05.26 15:53, Amery Hung wrote:
> >>>>>> [...]
> >>>>>> Am I understanding correctly that the better performance comes wit=
h
> >>>>>> the assumption that the XDP does not change headers?
> >>>>>>
> >>>>>> headlen is determined before the XDP program runs. If it push/pop
> >>>>>> headers, there could be headers in frags or data in the linear reg=
ion
> >>>>>> after __pskb_pull_tail().
> >>>>>>
> >>>>> That's right.
> >>>>>
> >>>>>>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XD=
P_XMIT, rq->flags)) {
> >>>>>>>                                 struct mlx5e_frag_page *pfp;
> >>>>>>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct m=
lx5e_rq *rq, struct mlx5e_mpw_info *w
> >>>>>>>                                 pagep->frags++;
> >>>>>>>                         while (++pagep < frag_page);
> >>>>>>>
> >>>>>>> -                       headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD =
- len,
> >>>>>>> -                                       skb->data_len);
> >>>>>>> +                       headlen =3D min_t(u16, headlen - len, skb=
->data_len);
> >>>>>>
> >>>>>> headlen - len can underflow but will be capped by skb->data_len, s=
o
> >>>>>> this should be okay, right?
> >>>>> It is safe. But it might trigger an extra allocation in the pull wh=
en
> >>>>> len > headlen. We could also skip the pull in that case. Or do a
> >>>>> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?
> >>>>
> >>>> Make sense, but this line took me a bit to understand. Maybe conside=
r
> >>>> checking len < headlen first?
> >>>>
> >>>> if (len < headlen) {
> >>>>         headlen =3D min_t(u32, headlen - len, skb->data_len);
> >>>>         __pskb_pull_tail(skb, headlen);
> >>>> }
> >>>>
> >>> Yes, that's what I had in mind when skipping the pull. I would also
> >>> tag this as likely.
> >>>
> >>>> Another clarifying question. So this patch will improve the
> >>>> performance when the XDP programs don't change header length. For
> >>>> those that encap/decap, they should precisely pull only headers into
> >>>> the linear area for optimal performance. Is it correct?
> >>>>
> >>> Right for encap, but for decap not quite:
> >>>
> >>> Let's say that the XDP program pulls 64B header into the linear part
> >>> and snips 4B of the encap out. This would result in a pull of an
> >>> additional 4B (headlen (64B) - len (60B) =3D 4B) which are now
> >>> data bytes =3D> sub-optimal layout.
> >>>
> >>> I don't see how we can improve this corner case though.
> >>
> >> I see. Thanks for the clarification.
> >>
> >> I think the "if (len < headlen)" makes too many assumptions about what
> >> the XDP program did.
> >>
> >> How about this policy instead: If the XDP program did not create/pull
> >> data into the linear area, pull the parsed headers; otherwise, assume
> >> the XDP program owns the geometry. min() is still needed since the
> >> program can shrink the packet.
> >>
> >> if (!len) {
> >>         headlen =3D min(headlen, skb->data_len);
> >>         __pskb_pull_tail(skb, headen);
> >> }
> >>
> >> This preserves the optimization for the default no-modification case,
> >> and most importantly allow XDP program to get the optimal performance
> >> if it gets the final geometry right.
> >>
> > I like this. It will also save us some neurons next time we need to
> > touch these lines.
> >
> Sashiko disagrees:
>
> """
> If an XDP program changes the packet geometry by prepending data, len wil=
l
> be greater than 0, which skips the __pskb_pull_tail() call entirely.
> The resulting SKB's linear part will only contain the prepended data, wit=
h
> the Ethernet headers remaining in the fragments.
> When the network stack later calls eth_type_trans(), it unconditionally
> pulls ETH_HLEN:
> net/ethernet/eth.c:eth_type_trans() {
>     ...
>     skb_pull_inline(skb, ETH_HLEN);
>     ...
> }
> Could pulling 14 bytes from a smaller linear area cause skb->len to drop
> below skb->data_len and trigger a BUG() in __skb_pull()?
> """
>
> So I think we need an else where we preserve the old behavior:
>   if (!len)
>           headlen =3D min(headlen, skb->data_len);
>   else
>           headlen =3D min(MLX5E_RX_MAX_HEAD - len, skb->data_len);
>
>   __pskb_pull_tail(skb, headlen);

I see. I am okay with the fallback.

One last question: if the fallback is mainly to preserve the minimum
linear head needed by eth_type_trans(), can we make that explicit
instead?

unsigned int pull_len =3D 0;

if (!len)
        pull_len =3D headlen;
else if (len < ETH_HLEN)
        pull_len =3D ETH_HLEN - len;

if (pull_len)
        __pskb_pull_tail(skb, min(pull_len, skb->data_len));

This keeps the parsed-header pull for the fully nonlinear case, but once
XDP leaves some linear data, the driver only pulls enough to satisfy the
Ethernet header invariant and otherwise leaves the final geometry to XDP.


>
> Thanks,
> Dragos

