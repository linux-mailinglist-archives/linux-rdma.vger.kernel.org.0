Return-Path: <linux-rdma+bounces-15190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E97CD9FE0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 17:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6A8B30115E1
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E94293C4E;
	Tue, 23 Dec 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/3ROfQV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939C78F26
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507908; cv=none; b=lBCWGJxvVanLUfv7t8kFlIWFC1c98iCzoH9de5LdrfUCQkkNg08uwUhdVn3M/046t9GpHXh2sEpywDjg/m+blfv3CZXtjwPx2jVLimSKLNrk37KgS4MFxlnhS+j5+Wu4C7Ae2NTBqoTXlbYpSqF+wzaSOTqSlHhgHozMprUD+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507908; c=relaxed/simple;
	bh=/u3TsQZ2BgOukyL1VncuimCUUH/fWpJcWfuu6O2MkPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoEpzcAsYU3almB8fmXwOAbNEoDNa+cm0uYhOjTZW9QlR7zQr3UChaNDTp7rs5iFoo7dV0SlioSd2JrZjEVwMW6fH/hP7AQq5B7CYuzhvh5uw7TA2x231N5NFfMusmxuMekn5NQArGLu/JecUd3T/3kDb17nOwNxbBDAo+/BQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/3ROfQV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6e815310aso4132394a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766507906; x=1767112706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLDNv/hI0DkRzO71RgQVXrSm+aSV0n+f8nAsN5ujQHc=;
        b=M/3ROfQVHgfQttiq2OW69fDxhITFXddwI0seDQcj+Go+ecqbMeN0vwne+rbwC/LChD
         meB8Ee6a/HhEIA7nHo0hVmNVZxJm1Nf94a5fBMZEYg/I1cjVjLkhAUKVKOvlfQ31njyN
         2vRGUMbBzjp6Evv5j16xhAJFaWBom5Uc3m2dcqqgO1Smw9C5VJ8/wZvxcUu6erK8GatV
         /UCkAwPL4woM6e4wlQspRHfHDVMi7Oq0Fu2iFDvXZKbHk2hEFLk2t4qm5UWk86KkACkt
         A9l7wVuirrnFAVccseN0eWCjwX6rU1pRFLpzJxyfMZ4TLe0Yy5uSP2Hf9XJeD1aCNUA5
         PUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766507906; x=1767112706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLDNv/hI0DkRzO71RgQVXrSm+aSV0n+f8nAsN5ujQHc=;
        b=eo5PZJNxJkMuB4b0IzMpGgHbs5DbSKNy/RLYOJYDomAYyKRrFTyaF6YhQhIEN7u6nI
         ZogrLFYF0EZu337DCVtAjw4hUROIfndnmV2gEQ6R/ZzceO+C3ebk6gxSPFdMMaonUeej
         aPhvQ70uaAAgdbPKV51MU+q57qybjTe3QJkohFy88tzUwDaNl6aO3jhiUzU87yGAGdO4
         xHj1d6Wg2LMJqggqStRoBZ/NPrbZ7EstXOCNrzK1ZQ4ZDHGPsTLYZMPxkHpJ9gO0F+zE
         Srm4QaepFru+fnLJxMLhwOzuXpxJ6u1zvAeAfeubobq1OdTUXg2FmgFVKn/M+ALbZyc2
         U4HA==
X-Forwarded-Encrypted: i=1; AJvYcCUw3Bzhpzpw1QrAmRE2pkZ7KFTpAsn0tuzFrn1QCdMr0tknjncUt7NRiF8b2dNX3+luJJzFRYlwLGSm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0l9ASMhtTgr92zB/BecoOuINRHPdpVko0FGXt3icH40rEFAnJ
	22Ns13Ge8f/Rpq5VOGLg2TWIzzq5qdXa4AEK0ZDH4UkRf/uLGHPi+tLVls86d4DlpJonwsLNaz7
	eT0075+oyOXOgof/4RkiX++KaexJV8Ck=
X-Gm-Gg: AY/fxX4lbR9QQ5XLTTShCtgWYREZi87NJe/6/Th457c07l/qGXKTbZ6Ft6CzB02bynY
	YqbRWchXrvB0DbD2OzceUDK2tfd+awcLHZeRyg9fcgK18VH3zpGPHGXEUs7+hPKfM909K2Kixj4
	XLaykpCdknfl/uiG1qYAJMcu+rbff6FRTauEv7nLS0Dv6Lf8SSh5p78TRv6+MYVv6Y1jqOeecLg
	/kZpJvCkDGxaPd+PDZ8TikH/I1+8qqXFKNg5jwhqRN0jLapTfVzi/juH0d1QKp4mrSsXAg=
X-Google-Smtp-Source: AGHT+IHr2xf6L63MAEMnD/PmaA/l4oVsQcIqu52H/0KgTOJhTmI/mseoQ4+2w+IkY84Bp34yQRNW8X5Ox7zxmElnz7E=
X-Received: by 2002:a05:6830:270b:b0:7c6:ca92:3621 with SMTP id
 46e09a7af769-7cc6690c5f8mr7169127a34.22.1766507905740; Tue, 23 Dec 2025
 08:38:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223044129.6232-1-yanjun.zhu@linux.dev> <d1ecf8f9-5595-48fb-a694-41a542860986@embeddedor.com>
In-Reply-To: <d1ecf8f9-5595-48fb-a694-41a542860986@embeddedor.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Wed, 24 Dec 2025 00:38:11 +0800
X-Gm-Features: AQt7F2rOK0kYaf8PW9NJPm2ZuG5ZMc7Ub2CLcwOF0dQl5J-6pw8Yixann_iAdB0
Message-ID: <CAEz=LcvVgX8VA4M3TJM38NXrhyx-QohBdSoZOG=p3X9pbTY4pA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca, 
	leon@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 5:35=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 12/23/25 13:41, Zhu Yanjun wrote:
> > From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> >
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> >
> > 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure con=
taining a flexible array member is not at the end of another structure [-Wf=
lex-array-member-not-at-end]
> >
> > This helper creates a union between a flexible-array member (FAM) and a
> > set of MEMBERS that would otherwise follow it.
> >
> > This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
> > the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> > start of MEMBER aligned.
> >
> > The static_assert() ensures this alignment remains, and it's
> > intentionally placed inmediately after the related structure --no
> > blank line in between.
> >
> > Lastly, move the conflicting declaration struct rxe_resp_info resp;
> > to the end of the corresponding structure.
> >
> > Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> NACK.

Just a small reminder about community conventions: reviewers can NACK
a patch, but authors generally should not NACK their own patches.

>
> I didn't write this patch.
>
> Please, don't ever submit modified patches on my behalf.
>
> > ---
> > V2->V3: Replace struct ib_sge with struct rxe_sge
>
> Patch granularity is a fundamental thing. Changes addressing different
> issues should not be mixed together. Previously existing issues (if any)
> must be addressed in separate patches.
>
> -Gustavo
>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
> >   1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband=
/sw/rxe/rxe_verbs.h
> > index fd48075810dd..3ffd7be8e7b1 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > @@ -219,12 +219,6 @@ struct rxe_resp_info {
> >       u32                     rkey;
> >       u32                     length;
> >
> > -     /* SRQ only */
> > -     struct {
> > -             struct rxe_recv_wqe     wqe;
> > -             struct ib_sge           sge[RXE_MAX_SGE];
> > -     } srq_wqe;
> > -
> >       /* Responder resources. It's a circular list where the oldest
> >        * resource is dropped first.
> >        */
> > @@ -232,7 +226,15 @@ struct rxe_resp_info {
> >       unsigned int            res_head;
> >       unsigned int            res_tail;
> >       struct resp_res         *res;
> > +
> > +     /* SRQ only */
> > +     /* Must be last as it ends in a flexible-array member. */
> > +     TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> > +             struct rxe_sge          sge[RXE_MAX_SGE];
> > +     ) srq_wqe;
> >   };
> > +static_assert(offsetof(struct rxe_resp_info, srq_wqe.wqe.dma.sge) =3D=
=3D
> > +           offsetof(struct rxe_resp_info, srq_wqe.sge));
> >
> >   struct rxe_qp {
> >       struct ib_qp            ibqp;
> > @@ -269,7 +271,6 @@ struct rxe_qp {
> >
> >       struct rxe_req_info     req;
> >       struct rxe_comp_info    comp;
> > -     struct rxe_resp_info    resp;
> >
> >       atomic_t                ssn;
> >       atomic_t                skb_out;
> > @@ -289,6 +290,9 @@ struct rxe_qp {
> >       spinlock_t              state_lock; /* guard requester and comple=
ter */
> >
> >       struct execute_work     cleanup_work;
> > +
> > +     /* Must be last as it ends in a flexible-array member. */
> > +     struct rxe_resp_info    resp;
> >   };
> >
> >   enum {
>
>

