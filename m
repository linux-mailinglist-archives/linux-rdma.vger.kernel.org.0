Return-Path: <linux-rdma+bounces-22331-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vShBGuz8MmpR8QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22331-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 22:00:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B903969C47A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 22:00:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QXGqrnfC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22331-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22331-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B42300BC8F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDF3AFD04;
	Wed, 17 Jun 2026 19:59:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF933AFB11
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 19:59:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726371; cv=pass; b=CmRjVx9i6Qtzxw5+QNp9Gsx4xgYdmGpOH5M5reTCmdKZFtdy+FHu3uJ/8rQL0cFx/IO10XhPjCjBCo2kSATItxSIFbFwK9oUltIcwXd/UtFTv1ds0Vk3lZjJJx6v8zndouSN/WS9FfQ7Mh3Dnzk1vN6djPgOnsTQrZO5pQsM2fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726371; c=relaxed/simple;
	bh=/m+gMIMh+ti/7Cu5TUQFyHH7sv6pkaIxydKO+QO3OqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL5FCnOhPzm2z5gJSawzXU8yHV3RsVamk+Zg1XJMrgOH+cbuJQQfc/ayrYEd2X5bqdHY2XGRKPsiukBVGIRuTWJ1Bne5oG/qThLiq6TdGD73qxfhCaSc+NcTrhwfCCB1hP/vwSI+K2/dN02wxzAeaP3JDXLoY6QSvFKBM2ZHD+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXGqrnfC; arc=pass smtp.client-ip=209.85.167.53
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ad2abf31aeso303e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 12:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781726367; cv=none;
        d=google.com; s=arc-20260327;
        b=E+wN/oJwSM13il3IBps1ST9Wzuefc33OyZK6B48JsAd+ycEU9SNTLQdVrxZn14ecVb
         7CyTlxMAxzS1glMVcCvYB/RqGaVLhiytW4mwdC+45t5/AdD1q0QeQJPrgAl4IggdZSvz
         QtlBV3coyC8A02qMDtPAuAhDuzAJIocJAKYH01ni83+TcA8t7x0D7+etVFUF3HCzgQoF
         CDjBF6Ia/xm6cZJT2/Dncfjab2iRZcilRpEsJQ8Vl9e+PVsy/JimZT8QhkvlAAUj8JkS
         iaf1GlUL5NfLv4wEVrauVXZ7svdrTQmJ4AgYKgvdGWU97iFarR0DCNe7nD+xSoP2tA8J
         yRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NYJQ2p2sqst2MojPycT5TIKxiCWIggpF3fyFtaAtiAM=;
        fh=pTLU49nLnRRNiuah7PHv6dAr7c6droOMnvGbGvEsf5I=;
        b=RqXedj/PUU/43mWkpGFEbB9awRWj3FAtFYxhF2S+D3mMcogBZoQIkGMhsewM6SdJan
         rJxQljM/ueA+TGabcjbE+ZM90ySqm+YfeZ9HOUK3iwqLg4wZTqu9yPmD+YEjitvAnQPy
         Tjcgf50v2FPId47Hx4aEqUo2bO3LCPY6ed1S13r2zwH8nej8oNoMckAK9Lo7v+yF3zO+
         vrvVB8OhpD0IK0bA2BCuip7re+KQGh5IQ6Fr0WMBeCWKIS7DFY6K6FZJxkAetJeBe4ZI
         1AYYTCfMn9wOiA8AjG6tP27GGWExK6+8NQukv7WzlLCZzA93CERnfCKXT4Wz704cR0+k
         QWWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781726367; x=1782331167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NYJQ2p2sqst2MojPycT5TIKxiCWIggpF3fyFtaAtiAM=;
        b=QXGqrnfCgHl78OPklvU6HtSijZ4UAtUTuRnEyizCOneMq58DLxwOBTWsVFj13qmgP+
         QWWXpEe/lHXbeEBWuDf3WPEhD9J6mpq5f3nbmKZs0xPX+qFFQ/+4to2dD3f2Nqi0iQ4T
         ToKI9Z+N39eYIo8uE7Q+n/K4MsNM11tS6VH2LilvRNQGFh/ngTKg0bBh3eBXkV5eAWDr
         DeaF66qX+ifWe9mUokW9uLEpLO5Tn1FfZaVK8YvlVzfvjOHkm8sBd5fEUju9hjWGspcK
         817aW20qWfxDvfulk1wFZ+Ad2RZBlBf+WfJtM0Gu4dbAXVYpNYkNc3Ss2j/I/ULgF6SZ
         kM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726367; x=1782331167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYJQ2p2sqst2MojPycT5TIKxiCWIggpF3fyFtaAtiAM=;
        b=JgSxGpxn5VPuT5xYKYK3I8n9UsJSh4PwQZn7ajVjCk/3kQeYU/o4uEbPLxT7pkOsjD
         G8wf3vD6FnbNR2lRBb+x99S2YjsU2al0rrRO1sGzPlW2HXSJlYDurn149N9TcjQBs1o+
         IImc1PXXHqoDPqB3Qaytr2CLKRBB8L5qctmWGwbCgjMz2sf3v1ngHxZLREy2vu5CSpz7
         jgppM+jVEOkB6mmlamv2yzDC+RP2MWj5tSIcw31JF1zW44pZqk9hpp9XyQ8hPFKZfqB0
         ABHbcqjL8UAqV7RGoKE2d4zxXJc2575iozW0rwrq2L8DH1f+3QTvBF/E6qGvPT7mCgRw
         vFpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9lvaQe/QkJr/9KhXBhWTrv8g66UmkFT8t6V4Seq/YoAxEhGPdx3jRNbJomdCGrwRmYWGuI8fbDwER@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzxUiHxliLMunu5hVmDTj15aSulDReZt59G/qjd0QZ149VRQM
	jLHQDt+CMMWFLE+OhxDpy9H5G3hRCRe2bTy2ww228ggX1yzl+xeWS41qhEAIy3x7Ag33Dmyswg1
	J5wxvXlCn89kiXOhGySicgOXyYztRBtIz9w+Nieo=
X-Gm-Gg: AfdE7cmRbHXXbGBilWstxy1Qr9G2UoR/xjbJBLMrW+TMM4UsAiVMAg25ZtJbzMMi4pH
	g0F47Fdb4aa/lhdmEgalhoBxbFEHJ11TvpGQowS9xdFdomWu5X9bOsCVRdpa/xZaOc+afKqIa8L
	ACVKqEvdnQcMqHkSWWxnOtbHywM5IauK6ReIkrVsCpDZkRqaKESc2kWLqr1ErHCt6i5joleHCxO
	uxzGgSbYbR0FVptCjQ0/QhTfKfU2xFdgf/dMU9Ad3fnSqBKCwH7twotX5zDzVtN+WX0og==
X-Received: by 2002:a05:6512:228a:b0:5ad:46a4:9b5a with SMTP id
 2adb3069b0e04-5ad4db83d7bmr33111e87.6.1781726366235; Wed, 17 Jun 2026
 12:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617164013.280790-1-jmoroni@google.com>
In-Reply-To: <20260617164013.280790-1-jmoroni@google.com>
From: David Hu <xuehaohu@google.com>
Date: Wed, 17 Jun 2026 15:59:13 -0400
X-Gm-Features: AVVi8CdBxZ7exnsiwn0r9VLgTQ9z05WedcDFzekO3h_ew0NO97gDHu4If_dzs7Q
Message-ID: <CAPd9Lg-Mr+hLqoLPA041yifFZouh3J0jMTn8GvSnAKXN3hORYA@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Prevent user-triggered null deref
 on QP create
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xuehaohu@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22331-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuehaohu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B903969C47A

On Wed, Jun 17, 2026 at 12:40=E2=80=AFPM Jacob Moroni <jmoroni@google.com> =
wrote:
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 4c0ea7c9b9..4124e4d732 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -638,17 +638,16 @@ static int irdma_setup_umode_qp(struct ib_udata *ud=
ata,
>
>         iwqp->ctx_info.qp_compl_ctx =3D req.user_compl_ctx;
>         iwqp->user_mode =3D 1;
> -       if (req.user_wqe_bufs) {
> -               spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags)=
;
> -               iwqp->iwpbl =3D irdma_get_pbl((unsigned long)req.user_wqe=
_bufs,
> -                                           &ucontext->qp_reg_mem_list);
> -               spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, f=
lags);
> -
> -               if (!iwqp->iwpbl) {
> -                       ret =3D -ENODATA;
> -                       ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
> -                       return ret;
> -               }
> +
> +       spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> +       iwqp->iwpbl =3D irdma_get_pbl((unsigned long)req.user_wqe_bufs,
> +                                   &ucontext->qp_reg_mem_list);
> +       spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
> +
> +       if (!iwqp->iwpbl) {
> +               ret =3D -ENODATA;
> +               ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
> +               return ret;

Unconditional pbl lookup and bailing out early appears to be a clean
fix without any leak. Taking the spinlock unconditionally in the slow
path to validate input also appears appropriate. Guarding the check
within `irdma_setup_virt_qp()` might be an alternative, but enforcing
that a QP has a proper pbl upfront makes sense.

0x00000 does not appear to be a practical address in the real world.
If it were, the original code would break anyway.

Nit: -EINVAL might be an alternative return for an invalid address.

Reviewed-by: David Hu <xuehaohu@google.com>

