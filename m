Return-Path: <linux-rdma+bounces-19726-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KrUGvrZ8WmLkwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19726-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 12:14:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE593492B47
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 12:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B373017259
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C93CAE94;
	Wed, 29 Apr 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek3KlBxT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3733A6E2
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457634; cv=pass; b=I4NXQ5yG0fuHJirk0KVhFrWR5AC1440Vg7PeHNJpX1CgxCOrP2j74dnC8eLTrVK9gOMpiNZ+g9uQRdyaTZYw2E71n93c0p7R8JLqUnoV5f3+kw/owbnMaiFNS/hQIdKaNbJfzDKZcUCeN47rbtMOZ/SZveLLoja2hLGEYO3wAbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457634; c=relaxed/simple;
	bh=fo4EiBwhV8mhP4Rm6q+hItF/pD/17eREaDJbCWs6gqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfxZNKOYne12ZeQASNzp6FjEugdXCtEsTm55lrcbfDxZeNuw7DqJRS3UHuTqXex7GT3Atx+P6RXFMd+Cymmq/DeoVnb2ZGG5nf1dW8RE1KJy5B7dkcwt89vcW82v9u3qOyZ7MZLLFpVgjDvEZGxVJSR4FPeNqfRC/fz9o50FDVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek3KlBxT; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ee5037d44so11038707b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 03:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777457632; cv=none;
        d=google.com; s=arc-20240605;
        b=iz/F1u2QtFVNn8pB9FdhpUW1xSii/4nVm1tWRP21rnv79gYZo75O9LcP26UnAL+4zd
         pjA65g8y0Gs0jvs9EUA/jfMfbpSTgAMpFvwDFUYP7atoCcBh2sSq+Zu9cuvl2rmfE81m
         Xlup8FWVJXTLJ1Pb8h+EoUqDXvzvWePloTM9H7oDeahWLxpUjk3eGIDbB8k2GaOEgIRO
         95riFRGJd75/VN9LgKndoyu8dQoCRF2CrRo9Zrl5GlJDLTlWCdNDGMVsAXNoBCA6Hb3c
         IlRGBFCR1GInFjYilKiUJlCu4ClJfvm96j9tWrbWhKwPi9Kb+nqqo2/tPdBJJcgVnZa/
         eoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fa95ogoQhE0p2rwPNbDEnCdMgoBzvOVValx4cHcuhpg=;
        fh=yzaC+pHlYZL4N7ZCkbWD7BMaczOuwBxZdCEieIWxgeY=;
        b=IDlcnw55bp4NJWULA9P83d4CNHXw7psmkL1qEzD7GowoqhT9Z6rnJW3VK7413JooCQ
         CTSytOFVy7szFGF91xXqcBWJHBE76AviI/U6uhEJyugrObbW8uJtXE5YYTXRou1A8ubz
         9wPJKWEAYJ63X1X+n/ygHAc1TkQwzPAbi8/mjK/b0ZVvtS8/NRdv4K2YwG2zDFS1Sbst
         rmdbDUGXPhd2yDPBfA2rpHF573DXl3WVgkf5deTMDlfabJnPMfQyZcf2QpVCAbuKx4u7
         UMMRX3rV1D3ZkRoa+VWic9pEcVt1BAUFPl7Eupcuh4F3uKpFskChqLZf5NbEkzKAbu37
         IPng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777457632; x=1778062432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa95ogoQhE0p2rwPNbDEnCdMgoBzvOVValx4cHcuhpg=;
        b=Ek3KlBxTqkgWUcEVdeWYv70SBAyPrkePW9OKWP3V029suKOCL/7CpGa67sMRgz1Ye2
         aESqi7zPIMB/RqfWOXhAVExWf1nJz4FawzEyaAaO0Sg73Srk6aELJiP5dQSirwtpO/28
         gf/2aSJvgFjcxMMIGK2ikbYkXGlUe5WYej2rjPVotfUqkuJeORkwsVn8Ap7tX9cxQAH/
         50IlT0+XhFE8xBNmC4nT5lZFUsoXcUXbaoprvnyjhZnE1jq3J1VwxE5C00StphVMktoX
         sJz1qlWy6RhfZL/FaRIQXNMEMb3I+tR9cWMjb1Ikhfodd+WVCoWvG75L5ltDjlu4PsXw
         fiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777457632; x=1778062432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fa95ogoQhE0p2rwPNbDEnCdMgoBzvOVValx4cHcuhpg=;
        b=EkxZIZQAHmmPvM0RelYcb0zXBqkSWtkcjUXRYsElBaxtq7Q0p/TF5uTivZtENQLWob
         Gegle2OypusWA6nycq1zPxXuBwyhi8N81K1YOLqCw5QTI/G5SnOK3TBHiACnOMly9gB6
         ZzytY5H6+diZM8ncNc1h1NpHsmVpwnlx+bDdxL1/1PEzj57SwUe+NFVqdyTXOHcurFRB
         QDkwQ2cab8zmJxVjNz5c0OQPjBptc7zbIUj8rpO/+ACGm3fyKdct259l88M4rZAy4/2q
         Q0dFhROxLq3tm8nRCAP/29XvzsWtLhueYZVzjHfdi81oCqWCl2yixduZRoNAVTNNuam9
         ZVag==
X-Forwarded-Encrypted: i=1; AFNElJ8tUU+ZoyVPu1tyG67vzCgfNrzm48DgM8Rr8m4gG1sbLfxVpZ3agKtxgm2Zp9Bau8PGtX7pwGLwevtU@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxzhgrwX1XUhm12GLL33zwbcAFKMVrpfX4axk4/65OC1yGyd6
	1olR+XVm4uEipdsr3vSH4CHMIXtDHwRA+4WRunZeKOW3jIAimwWHlEdXG3vdqOfMtxAEYpokUDu
	T4o0bZOGgZV6sic9e8xNpzuoRyAVVBec=
X-Gm-Gg: AeBDiev5W2YMJo8X9DF/VK5tbzv7pFZ63+nZAAYNgvSe8JtaoptHRfMp0l+LEFUVKng
	cbmYH2Tx3Ty1f+TiC/JXcaHe3h6aijkKLZcX2q85j4LMgSCLMwDYuF1zDhgarhTOKAY3jfyRakY
	UCfGVbYxqIAAvhsLOgny2RcQfp1QBbiZrM32xtIqstvoB/opOgC9DsXRQaAJySCREbq43f5DM81
	MAqfs1Kq7rtVfGZl/IO5bCMlWa+0Mn+b+tHK/SCeFOfXAfTaRyF9rja5lQMiv+h4OgE2ucurtJ6
	lQTxKSfdG9YRTHsLhlTI
X-Received: by 2002:a05:690c:6610:b0:7b4:6f40:639 with SMTP id
 00721157ae682-7bd26720337mr16777347b3.17.1777457631842; Wed, 29 Apr 2026
 03:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGp+u1bdbe_5Xk6icnDcs70Krbr_6M4yXjhs0HVo8T4953wNSQ@mail.gmail.com>
 <345650f0-6da6-447c-9b27-0bbefca0558f@nvidia.com>
In-Reply-To: <345650f0-6da6-447c-9b27-0bbefca0558f@nvidia.com>
From: Ginger <ginger.jzllee@gmail.com>
Date: Wed, 29 Apr 2026 18:13:40 +0800
X-Gm-Features: AVHnY4J9YPIXW1V1o8KG2ZjCXSkwqVGDgNnMcU7TMaiMF703EkjM0JeyOrbdcFQ
Message-ID: <CAGp+u1baSuC9z9rGkJR0v1+eBW==9ppxh7tSn19jJOA9bX1Ycg@mail.gmail.com>
Subject: Re: [bug report] Potential refcounting
To: Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	ttoukan.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BE593492B47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19726-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Tariq,

Thank you for your prompt and detailed response. I agree with your
point that calling refcount_dec_and_test() is safe.
However, the major concern of the original report is that whether
simply calling 'refcount_inc()' is safe in 'mlx4_add_cq_to_tasklet()':

T0:
if during a tasklet callback calling 'mlx4_cq_tasklet_cb', a destroy
verb arrives, which eventually leads to 'mlx4_cq_free()'. Both
functions can decrement the 'cq->refcount' and potentially enable
cq->free.

T1:
irq fires --> mlx4_cq_completion --> mlx4_add_cq_to_tasklet -->
refcount_inc(). Here, the refcount increment does not check whether it
has been zeroed in T0.

Side note: to see if T1 (i.e., IRQ) can fire, I checked the calling
path to 'mlx4_cq_free' and only 'synchronize_irq()' is seen, but not
'disable_irq()'. It means that T1 may still happen after T0 calls
'mlx4_cq_free()'.

Is the above race possible? IMHO, perhaps it would better to change
'refcount_inc()' to something like 'refcount_inc_not_zero()' if the
race may happen.


Best regards,
Ginger

On Wed, Apr 29, 2026 at 4:36=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
>
>
> On 27/04/2026 5:07, Ginger wrote:
> > Dear Linux kernel maintainers,
> >
> > My research-based static analyzer found a potential
> > refcounting/atomicity bug within the
> > 'drivers/net/ethernet/mellanox/mlx4' subsystem, more specifically, in
> > 'drivers/net/ethernet/mellanox/mlx4/cq.c'.
> >
> > Kernel version: long-term kernel v6.18.9
> >
> > Potential concurrent triggering executions:
> > T0:
> > mlx4_cq_tasklet_cb
> >       --> if (refcount_dec_and_test(&mcq->refcount))
> >       --> complete(&mcq->free)
> >
> > T1:
> > mlx4_cq_completion
> >      --> cq->comp(cq);
> >          --> mlx4_add_cq_to_tasklet(struct mlx4_cq *cq)
> >              --> spin_lock_irqsave(&tasklet_ctx->lock, flags);
> >              --> refcount_inc(&cq->refcount);
> >              --> spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
> >
> > In T1, the refcounting increment on 'cq->refcount)', although within
> > the protection range of the 'tasklet_ctx->locl', is not synchronized
> > against T0 because 'refcount_inc()' does not check whether the
> > refcount has reached zero in T0. This case is potentially problematic
> > because T0 decrements he 'mcq->refcount' and can enable the
> > 'mlx4_cq_free()' to proceed.
> >
> > Thank you for your time and consideration.
> >
> > Best regards,
> > Ginger
> >
>
> Hi,
>
> Thanks for your report.
>
> IMO the described race is impossible.
>
> CQs that work with mlx4_add_cq_to_tasklet as their comp() callback (i.e.
> T1) are added to the relevant list only after refcount is incremented.
>
> Hence, if a CQ exists in the list in T0, it necessarily means that
> refcount is already elevated, and calling refcount_dec_and_test is safe.
>
> Regards,
> Tariq

