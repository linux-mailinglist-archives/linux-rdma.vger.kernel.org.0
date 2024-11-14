Return-Path: <linux-rdma+bounces-5977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1E9C86DB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDEF283F55
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AE1F6669;
	Thu, 14 Nov 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J80HIunj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB51E47A5
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578867; cv=none; b=N8jIVR92NhGK4h3qxQ6h2RCAW7fc+El/NBbBGvpPtXqoCLo83LlOolGoniwvW/fh8NYML7mT8CLqMND/TKuP6J/6xgKKytvWNnWtjKxAviftFnlweRO5flONOMyAqy8NARhx8qsVtn1vrkWEvF+y+pS1lSYSRETzYYGH25HfJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578867; c=relaxed/simple;
	bh=oi2qL9nIVdQ6M0f5LBYyu5NagYRbHd0aonkJ/ZSPcgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFDRg8jvr0ucsas5dZWouxGElnEsevSlsQ7/BMSWULZcWK/BkIj646UAGTyJXaQgpTY+FCIaJXU0qiOrWV7XQ37AP5po0RZQ7cIba3IMpu+3D6XrLKnYFKq+jec0QVDWTjL5T5bENHtxwuakMCL+8NiJ6uWdCfCrUWDnlDt2zCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J80HIunj; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so433680276.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 02:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731578864; x=1732183664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duibGTP/GNHD5nL4hJasNH83KTG17g4skasRQJ0B1Lc=;
        b=J80HIunjUATdv6EbzxX9UVMFyOrI6KAn1TewV0eNujEp0ZdBhjoeVBIrz5w9egyPEw
         wVfJkMNbR7hYxO/s26pOWQuRHcEl+2XFZLo+c8WNDtOTWtvB+7bx3pKjJz3NhzuHef7q
         nEipkLRaH0jRW9V2W4mudCl53XQcHRePMN4LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578864; x=1732183664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duibGTP/GNHD5nL4hJasNH83KTG17g4skasRQJ0B1Lc=;
        b=TyzL2aV3zGbIcLcXGR/hk5RDOmjjv9Su8DBKCH6YnfUfh71xU/W553UTGjaXNXIe7j
         zlm0w8rRKHVZ6iutrKqBVci/FBzNxk3bVYlb02sb2GXupbsgdly/ib2oGZAGQNOH4uze
         V0eMGLzNU55NL1dZSEl7TvjLqZgB3IzPI9s9WiqgwAEo/4sR0bsv+ettiFLxZW4CCc+P
         eD5sgE6x9cywF6RBJtl9YSV99frX+687nSpAOLV96DdU08b1eMzevrLVN3YJat9216yA
         dVs24xVwT/qr1xq9NCop86gTE+osynm0NtRGHQ45f6BUWG+CARFD81otXyb157183Qhy
         ygIA==
X-Forwarded-Encrypted: i=1; AJvYcCWpR6xOFVKv5hHAU2KNOIwvynitASyMpW7VC5n6fj+Nn+Jso/0vcAfLr2sonDlDcf6BrexrddQwQYvw@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/VMQlBxyX58+Ljx1Mkb9ykynAucohzW0yOPD3AjpqtFkJhPi
	iYOx0al3Cd4GPjwgzDqQXF+79aDnBhe5KLfPaMMWC/f9k3ftXlv9AL3s5cVbOiT8oXoKDrJ5MWZ
	XSDYCVqbzaM1GcO9zMnEJlRBIttFYaNoGmH+t
X-Google-Smtp-Source: AGHT+IHQit+hMZJD10Lhqc04ZsYr/CCLiF4Iaz2xNzXglB9oODQV48N8NwYg+no6ZxuCpKzUqwAlDBzaLtJDffNPo8g=
X-Received: by 2002:a05:6902:1001:b0:e33:1fa5:132c with SMTP id
 3f1490d57ef6-e35ed23f831mr7126622276.25.1731578864452; Thu, 14 Nov 2024
 02:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112134956.1415343-1-mheib@redhat.com> <20241114100413.GA499069@unreal>
In-Reply-To: <20241114100413.GA499069@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Thu, 14 Nov 2024 15:37:30 +0530
Message-ID: <CA+sbYW1cp17tH-p8ffjtgBecyMP_fECmes9RN9Bj=bdNPD_W2g@mail.gmail.com>
Subject: Re: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid
 accessing invalid memeory
To: Leon Romanovsky <leon@kernel.org>
Cc: Mohammad Heib <mheib@redhat.com>, linux-rdma@vger.kernel.org, 
	kashyap.desai@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 3:34=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Nov 12, 2024 at 03:49:56PM +0200, Mohammad Heib wrote:
> > If bnxt FW behaves unexpectedly because of FW bug or unexpected behavio=
r it
> > can send completions for old  cookies that have already been handled by=
 the
> > bnxt driver. If that old cookie was associated with an old calling cont=
ext
> > the driver will try to access that caller memory again because the driv=
er
> > never clean the is_waiter_alive flag after the caller successfully comp=
lete
> > waiting, and this access will cause the following kernel panic:
> >
> > Call Trace:
> >  <IRQ>
> >  ? __die+0x20/0x70
> >  ? page_fault_oops+0x75/0x170
> >  ? exc_page_fault+0xaa/0x140
> >  ? asm_exc_page_fault+0x22/0x30
> >  ? bnxt_qplib_process_qp_event.isra.0+0x20c/0x3a0 [bnxt_re]
> >  ? srso_return_thunk+0x5/0x5f
> >  ? __wake_up_common+0x78/0xa0
> >  ? srso_return_thunk+0x5/0x5f
> >  bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re]
> >  tasklet_action_common+0xac/0x210
> >  handle_softirqs+0xd3/0x2b0
> >  __irq_exit_rcu+0x9b/0xc0
> >  common_interrupt+0x7f/0xa0
> >  </IRQ>
> >  <TASK>
> >
> > To avoid the above unexpected behavior clear the is_waiter_alive flag
> > every time the caller finishes waiting for a completion.
> >
> > Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions after dr=
iver detect a timedout")
> > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
>
> Selvin?
Someone is confirming the fix. Will ack in a day. Thanks

