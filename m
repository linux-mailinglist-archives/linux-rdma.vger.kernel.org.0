Return-Path: <linux-rdma+bounces-15192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3533CDA135
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 18:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0433010AB8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D40726E710;
	Tue, 23 Dec 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJXU3bB5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCEF4F1
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510372; cv=none; b=jETrAd+ixwWug4G5wEYP+X5lDcZBcAi45jC2FLO0hg7ak4k3KeFm+Mz4JEk3VlQO5ZJwLO0ditm9colxRlDVYAWA0EJyXn/0U1xC/i6y5YtenPP4YX7A25yphzfQgleDI/06iQJtLDQk/WIaVVR74LhYahZyhfM26HxW/B9K7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510372; c=relaxed/simple;
	bh=tK0c/cohSY6yNlCN1rMLhsyVNvJZYhYiYUm0nruw1/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHhddpIz/UdHw1toq+IVIGUtJm2gxbSiCDtbDv1t5dmIz1SOZZHXV43LfxSLqVQxIqceVEo6CeJLL923nGFpuz7r1aZGt6xiKytG9xcWbGPEa0n+kJBmKZmSoEO7p+sEDGUI9gpx3qZNE/EGl4VcccTDc0bgMdodbPz8AQZhcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJXU3bB5; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so3592891a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766510370; x=1767115170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wczI3JN3pZttDlBcFSl7MoChfK8lmqIvbdbzN8sxB0=;
        b=GJXU3bB5VWRGS6QAl7R3hh4KhcZLTkWx4oNLZY4mvAKwmScsRzN+T54UXDdVfmOEpJ
         sCj0GhdIAMa1LwEF5Q6zQjUURqLTkq6bvcHg8F9avKam2TF7A6T1BoCCT835LTSpXoqC
         0rklNAAzdSUxBe/AHj4csnDizan1DUPegTGYUSVT1+7AR6U3Nz9PtYiRSB2KO2PD4QJz
         UGMK8GfoG0oNa9hZjEvufh5JZpAV6WmwoAtAv+Db21A3jv2Lg4THC0lhYsXQgqJMCG+V
         3DBnBKzV+57jczwBDxllicxHc6s9+wv4sMP+NwcG39+97jgyIpKCfILAocZbY7Fr237U
         OyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766510370; x=1767115170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wczI3JN3pZttDlBcFSl7MoChfK8lmqIvbdbzN8sxB0=;
        b=jQ/o0T3N+1XPWxwBI+rs8MJbQ5LBPHbyWCNvbNFg3OzrMNQGqUMntyrkEWmTexjvp6
         8ml/YfvlQwTHsJuWT6UEjViRRZ2MgCOolpILNUKYGEPkpY0Pu6cwdLZQkM7ZhQZyQkJK
         yAQt6YEb6LUrvvkCGNU9a0i0KBhjr5lV6mP3056LWbcfo2yFnFso1SeeZzfWyIqd+6SO
         yW/1+OobMSnkeWTZXAbaQHW4Fkc4Tewd/BZuUb5OA1zrkOOQRjiLm+u/SZmwfFPpcHBq
         dLaRqQaW4LMvbBnuQt/4pgorUTwfh9MAJ/z8kG+HTuqEAfd0JJSAa0+UoWfX6Ob1pDBv
         Jbcw==
X-Forwarded-Encrypted: i=1; AJvYcCWXdy7jp0NubOiYiokS5tz5Om+N0UekfUypjwNeMEUS0epXRHiSUifDjnj6D/Z99VRLakNf3U9Kj89T@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHBi8lJp/5JH7uHBy1f7CmMgvJ/KF2fLtERj7Dox5P3Cla8F2
	B5CFeGN4Gmo9Q6iKwauAd/muOpPtp75I9P89h2jY9x47Q1aeHk/tPkbp11as9raoe6leS47n0l6
	PuXMoqvTWNHBwr+or6zATFg/BWXZU05w=
X-Gm-Gg: AY/fxX7W3ctzlQ/83G5Xp0cnENrw7ecAY2jvpr7PuTDGT0BCFsEseYm/rZryKv0sXQO
	vKNIs/gEJSR+8VJEKTlaJByk5lpT+rqDHTqfb0X3Ql+wDwoU/IIOOBX+DzmpFntrJNDzpZhmUth
	GTz4D66HMtxK4nLcu4rEN9ihA0L2xFcykn9T9EABxBB+C9Al6otaHsfO52DPpdfhwKuyVKl20YJ
	PaktXwyGaw13bW5b0z5olLLAIddkwP624LcrcMK/tsc7jdm+bfKn+gd79WgKs8t9OD5i44=
X-Google-Smtp-Source: AGHT+IEUqIhoJiRljA8A7N271eBfpbpPMsM+P2acubnsOx8u1YtS5keawYddteSnlz+jm8nUIrzUzDxlp7vqK9zHqSw=
X-Received: by 2002:a05:6830:3153:b0:7c6:aea0:3382 with SMTP id
 46e09a7af769-7cc66a0ebb9mr8564471a34.23.1766510370144; Tue, 23 Dec 2025
 09:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223044129.6232-1-yanjun.zhu@linux.dev> <d1ecf8f9-5595-48fb-a694-41a542860986@embeddedor.com>
 <CAEz=LcvVgX8VA4M3TJM38NXrhyx-QohBdSoZOG=p3X9pbTY4pA@mail.gmail.com> <d4f60741-b0af-4a51-a1dc-cded1f34f309@embeddedor.com>
In-Reply-To: <d4f60741-b0af-4a51-a1dc-cded1f34f309@embeddedor.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Wed, 24 Dec 2025 01:19:14 +0800
X-Gm-Features: AQt7F2qI_cSPRm959P4k5ONQt5lUtzKfhjaTgYCrnw0It7IaLy5aBrJNixfuGL4
Message-ID: <CAEz=LcsLXuAiQ0Rv0Z7E9mV35Qd92xxGsoSdDFBT8F1AdfZcoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca, 
	leon@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 12:59=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 12/24/25 01:38, Greg Sword wrote:
> > On Tue, Dec 23, 2025 at 5:35=E2=80=AFPM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >>
> >>
> >>
> >> On 12/23/25 13:41, Zhu Yanjun wrote:
> >>> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> >>>
> >>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> >>> getting ready to enable it, globally.
> >>>
> >>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> >>>
> >>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure c=
ontaining a flexible array member is not at the end of another structure [-=
Wflex-array-member-not-at-end]
> >>>
> >>> This helper creates a union between a flexible-array member (FAM) and=
 a
> >>> set of MEMBERS that would otherwise follow it.
> >>>
> >>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; ont=
o
> >>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
> >>> start of MEMBER aligned.
> >>>
> >>> The static_assert() ensures this alignment remains, and it's
> >>> intentionally placed inmediately after the related structure --no
> >>> blank line in between.
> >>>
> >>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
> >>> to the end of the corresponding structure.
> >>>
> >>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>
> >> NACK.
> >
> > Just a small reminder about community conventions: reviewers can NACK
> > a patch, but authors generally should not NACK their own patches.
>
> It's obvious that you don't understand what's going on here.

I=E2=80=99ve read through the full discussion and understand how this evolv=
ed.
Based on that, I believe there may be a misunderstanding on your side.

>
> >> I didn't write this patch.
>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This line should've given you a clue.
>
> -Gustavo
>
> >>
> >> Please, don't ever submit modified patches on my behalf.
> >>
> >>> ---
> >>> V2->V3: Replace struct ib_sge with struct rxe_sge
> >>
> >> Patch granularity is a fundamental thing. Changes addressing different
> >> issues should not be mixed together. Previously existing issues (if an=
y)
> >> must be addressed in separate patches.
> >>
> >> -Gustavo
> >>
> >>> ---
> >>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
> >>>    1 file changed, 11 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniba=
nd/sw/rxe/rxe_verbs.h
> >>> index fd48075810dd..3ffd7be8e7b1 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
> >>>        u32                     rkey;
> >>>        u32                     length;
> >>>
> >>> -     /* SRQ only */
> >>> -     struct {
> >>> -             struct rxe_recv_wqe     wqe;
> >>> -             struct ib_sge           sge[RXE_MAX_SGE];
> >>> -     } srq_wqe;
> >>> -
> >>>        /* Responder resources. It's a circular list where the oldest
> >>>         * resource is dropped first.
> >>>         */
> >>> @@ -232,7 +226,15 @@ struct rxe_resp_info {
> >>>        unsigned int            res_head;
> >>>        unsigned int            res_tail;
> >>>        struct resp_res         *res;
> >>> +
> >>> +     /* SRQ only */
> >>> +     /* Must be last as it ends in a flexible-array member. */
> >>> +     TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
> >>> +             struct rxe_sge          sge[RXE_MAX_SGE];
> >>> +     ) srq_wqe;
> >>>    };
> >>> +static_assert(offsetof(struct rxe_resp_info, srq_wqe.wqe.dma.sge) =
=3D=3D
> >>> +           offsetof(struct rxe_resp_info, srq_wqe.sge));
> >>>
> >>>    struct rxe_qp {
> >>>        struct ib_qp            ibqp;
> >>> @@ -269,7 +271,6 @@ struct rxe_qp {
> >>>
> >>>        struct rxe_req_info     req;
> >>>        struct rxe_comp_info    comp;
> >>> -     struct rxe_resp_info    resp;
> >>>
> >>>        atomic_t                ssn;
> >>>        atomic_t                skb_out;
> >>> @@ -289,6 +290,9 @@ struct rxe_qp {
> >>>        spinlock_t              state_lock; /* guard requester and com=
pleter */
> >>>
> >>>        struct execute_work     cleanup_work;
> >>> +
> >>> +     /* Must be last as it ends in a flexible-array member. */
> >>> +     struct rxe_resp_info    resp;
> >>>    };
> >>>
> >>>    enum {
> >>
> >>
>

