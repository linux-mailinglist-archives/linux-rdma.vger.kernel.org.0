Return-Path: <linux-rdma+bounces-20257-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMTDBlgh/mmunAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20257-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 19:46:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3F4FA279
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 19:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAD843024AB4
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC115B135;
	Fri,  8 May 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJxk7shN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257A421EE4
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262275; cv=pass; b=CCPckjaIIfGxjMz6vohTdWuAW3Dfs/p+L6u6AzQg6dcTeZWrimVeLqi5PerwkxzfrJ5ao+6FeHNgUA1BDjtrGpY+sCrxZSXSbvdzh0n805eUBkJ+Ef/6c1boMw3aj+FlWSxTUcqKl69DWwwI0ANTEaQdirEXzu0wPxlE64RT9KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262275; c=relaxed/simple;
	bh=CcDKf/KmVKLfF4zmyDCx2R+wF06pamP8rhBWcPAGVxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eh7Rd8jbgs4RMxYiMdOT57VEu3y/DR1rS0vzIYnHqAQUETNBCgoZcICkUMbn119ELDoz2a5Rim1uPOS1TnMg9gRWTzZbnoYFYOMqHXo2ioEqNq2S50ZATH8h+a20U4YdteeM5Slg7+prVBbdwIpXmeE3Ry1BlIpmgRItmFqS1S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJxk7shN; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd5e373d07so25590637b3.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 10:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778262273; cv=none;
        d=google.com; s=arc-20240605;
        b=bSbM3fShgszk5ejJ5JbihNwsvQ4hDDrwZGoiiZwvV+qpfyWCVOEsYJSMKX/Qzq5rWi
         0CJuGnNr4eaL2OvFweT5PzDzi6xBkL/TkEVlt83fPmLG8FqhYYOfvfHLAoU7pDiG/VmX
         k6WEmToU9LesAMGHOYbWVr8EU07cdPvqbCZslCit18xjdqEh8HI13+RLC9HfEUOnp2yc
         N9v5aAYvvVhvfaz/FgGhCvCYH7mzOY3Ey2dijZGNI1eAHyz0emZtLxkQSpIAQ6gF9/2t
         gmCqw4fDDfQfjLzfsFAyu2+LzulEwAHceVgP/8A8miGEQ0BUQMQtNYz9TBHXtzowpqQR
         TNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SegeXkJg0Qt295LoNImeq2zq+YRFqc6PexCOKts/PnE=;
        fh=tT3t/ErsHr0hjbUJCgZPhn9SHUWZJ4iMPCkR3xAzgws=;
        b=MtCThJFrjWEBMFccrbEc3I1cRBp4s0uM+RdlOIwfWwEL3Uz5hKgQt1clAX5I+6rFbV
         R2n5cjxTHaso5LRrBl0A10OZ1IGmPILNCMwSqmQZjD+odRs36QpbH0KOvT3Uts8x6OCo
         yxfq4wPVH6nH8iWrDIy2drIDDrZKYFuw1l5hm8gtmeSUoY+6wWiv+vqJGTJTfRAIlnFS
         QBnv4PquL4mkATlrGFo0tH7JZ8f+6n/MejSgGELRUUFn5PXDY+SkXX3wgfNg0fET3h0R
         4NQrh/VcpMn3quI/R2RwbOXYTbCnksZ+sYPu7bxPtoGgJGmYhE0dJnaJfKkCILtverzx
         9+GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778262273; x=1778867073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SegeXkJg0Qt295LoNImeq2zq+YRFqc6PexCOKts/PnE=;
        b=kJxk7shNyq27Pz2WNp+1S8KYqmQH+HwbB+wWeeNKrHykvqL0pXC6idcgjvebTS4YQl
         eMde0TcbmctguWbvLjBkq81TPUGQXWYWo2wuNSyU35QNUhne0aAkbAO90OpyFHKZE70b
         Fg3KEZuo08FcXbcEN3PxgBl+w+A9tpRBQWMIgyix1wf0kz32umgCdXpBE11QrprLo50g
         5R32OUxOzcZ+9zcVlWlU3zOg6GcZ0iphKCQUFcHhKq894blAUG2VFlpNYChd/t6VYwqd
         6fwpsr1osP35pxqw4k1xlT/hGJU5GbSF6klpo4tb9qHpXMxVa78UrgTiSOA4hlnEnLui
         ZrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778262273; x=1778867073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SegeXkJg0Qt295LoNImeq2zq+YRFqc6PexCOKts/PnE=;
        b=LP1eHhT4JjvqNf4tWPu/xBLgVwPEWB54xLTL6lp5BZmdvoe7rOiTBbjO1pTbuS1H/E
         2oMuUBNtqpd8i//beN2y7R4zp8ghqyWNib3VDzIBmnUDLAI5ed6aw735m18nSG2B3HPn
         6sgxJodZrk9G5j1nDm5GW6a4yKNuOtPfC+Ao1xBWo3b+17Ko3slxflV8cY8wPmhA3LjS
         4GZXavMhrP3VJsoUP1dapvv+UydpE3/s3r2OI5nHpatNc0t81Z5gBw9zAHBOg8fxo+0r
         lxs+Fjva4SNVCLsNy7ClwaDDIFQKd7RtHtq7xIcQ2RiexhEh96BgZnMW1eFBMwlvkqqw
         iSnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gY3ohVzwlN93n5nwgVcsDkM5qWJSA8Gx1OC0J6QW8rqSv4wTh8uProfE7FVHzcC9lgjkmkkkhjO0D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3stJTs4+5MGH7s5dcahiEUF61mbFW665VWzwUT3ujUtkeabHY
	cDZbHAl+avxLfY8w+vUwR50ah9p8GcCdrUpz9vxuhHRV0RYcT0fari2AWluxPR5mqC9LfAolz+0
	2E/U1U/rXI0Sxo9Kb10SCQL9HZDBaF0U=
X-Gm-Gg: Acq92OGnRYmKVM8RfdiC2Y73ZTcptvi488BWWzNiX0wli1Dr4xrLBvGEgG3d7S97d4W
	oWiDx9IXmQMX6W55dVdxnGFdSGaYKj7W+iFYEls8IO2PHZDZ1toem1ZXMIuC1RIaRg5cLSrVlBG
	Dw48ffVWH7itoX0Y4x99/TUR+BS99+UAMTS2XkpHb2sOkD1f90813avDgMa/YQUeqJyfoKNBwLV
	RlPN8hMZUyoBpiQ1XWO5Lj/2O+saJwj7TGKc90AuVeWX/8RgAOPBAyIa93V0Mhvg8bMCz0pQXd2
	MODuJx0tJn2iyR2zuB+I+Kg=
X-Received: by 2002:a05:690c:dd4:b0:7bd:a4dc:c23b with SMTP id
 00721157ae682-7bdf5efad66mr147425427b3.49.1778262273164; Fri, 08 May 2026
 10:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com> <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com>
In-Reply-To: <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 8 May 2026 19:44:21 +0200
X-Gm-Features: AVHnY4LuhPNVOQMgrNqkEPKZxxuymUm4dL0F_gglKlMd8ExwxL5Tv9DtMUApznk
Message-ID: <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
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
X-Rspamd-Queue-Id: D7B3F4FA279
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20257-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 2:15=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 07.05.26 22:50, Amery Hung wrote:
> > On Thu, May 7, 2026 at 4:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> >>
> >>
> >> Hi Amery,
> >>
> >> On 07.05.26 15:53, Amery Hung wrote:
> >>> [...]
> >>> Am I understanding correctly that the better performance comes with
> >>> the assumption that the XDP does not change headers?
> >>>
> >>> headlen is determined before the XDP program runs. If it push/pop
> >>> headers, there could be headers in frags or data in the linear region
> >>> after __pskb_pull_tail().
> >>>
> >> That's right.
> >>
> >>>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_X=
MIT, rq->flags)) {
> >>>>                                 struct mlx5e_frag_page *pfp;
> >>>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5=
e_rq *rq, struct mlx5e_mpw_info *w
> >>>>                                 pagep->frags++;
> >>>>                         while (++pagep < frag_page);
> >>>>
> >>>> -                       headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - l=
en,
> >>>> -                                       skb->data_len);
> >>>> +                       headlen =3D min_t(u16, headlen - len, skb->d=
ata_len);
> >>>
> >>> headlen - len can underflow but will be capped by skb->data_len, so
> >>> this should be okay, right?
> >> It is safe. But it might trigger an extra allocation in the pull when
> >> len > headlen. We could also skip the pull in that case. Or do a
> >> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?
> >
> > Make sense, but this line took me a bit to understand. Maybe consider
> > checking len < headlen first?
> >
> > if (len < headlen) {
> >         headlen =3D min_t(u32, headlen - len, skb->data_len);
> >         __pskb_pull_tail(skb, headlen);
> > }
> >
> Yes, that's what I had in mind when skipping the pull. I would also
> tag this as likely.
>
> > Another clarifying question. So this patch will improve the
> > performance when the XDP programs don't change header length. For
> > those that encap/decap, they should precisely pull only headers into
> > the linear area for optimal performance. Is it correct?
> >
> Right for encap, but for decap not quite:
>
> Let's say that the XDP program pulls 64B header into the linear part
> and snips 4B of the encap out. This would result in a pull of an
> additional 4B (headlen (64B) - len (60B) =3D 4B) which are now
> data bytes =3D> sub-optimal layout.
>
> I don't see how we can improve this corner case though.

I see. Thanks for the clarification.

I think the "if (len < headlen)" makes too many assumptions about what
the XDP program did.

How about this policy instead: If the XDP program did not create/pull
data into the linear area, pull the parsed headers; otherwise, assume
the XDP program owns the geometry. min() is still needed since the
program can shrink the packet.

if (!len) {
        headlen =3D min(headlen, skb->data_len);
        __pskb_pull_tail(skb, headen);
}

This preserves the optimization for the default no-modification case,
and most importantly allow XDP program to get the optimal performance
if it gets the final geometry right.

>
> Thanks,
> Dragos

