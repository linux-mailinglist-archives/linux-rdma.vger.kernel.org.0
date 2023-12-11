Return-Path: <linux-rdma+bounces-372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41980D09C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CE51F2193A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C64C3D3;
	Mon, 11 Dec 2023 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdWVqDhc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D75A18A
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702310931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N5lAcUtexjyMcZlcm6EHnULS8QX5mhHesaKgXo2cQ8=;
	b=KdWVqDhcNHSx5pugxTzq4pDISlVTRoAYwxaH/4OGPORrXm5ajdq5z2TT3YhiNPQidWQ4F/
	NiKRUJOfTB6Qx+CcUPQjcUzEgqNNzeujMHhihQJc8WxuQevfUIGeQn0hteuE8H+j1u2tHF
	rZsw9rkDUtbhiaTh12SgBd4nwnUHuSQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-lxwUVtSjOKqJNwCYtiveyg-1; Mon, 11 Dec 2023 11:08:50 -0500
X-MC-Unique: lxwUVtSjOKqJNwCYtiveyg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2888414ac91so2802527a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 08:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310929; x=1702915729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N5lAcUtexjyMcZlcm6EHnULS8QX5mhHesaKgXo2cQ8=;
        b=td7hRQOtE8mXRQNHqgPmjzl7d0ahz4ez7HKw+ZToGRiUbtbs9BAkFpYvjgJX5atwsf
         H6xDl+7ywSrAZtu3J93AI5SLawQjeAiP5Foqc3VxYAMFaQHqrhvn2EArBHy1wtOmTXWo
         IWm1Z9aMXMgZ5T3tPag7FL6USUygA3bUGuIJttQR67srJ8qXSaol6v6PdLxMxKk0+C5W
         hT07rfo6vxJ39c/SaABgHDpkW22M04Ndz7eMueZSSOsn+m4qfcZi4QG22O0BZrrS8Wit
         MooDSVH3+7kwwS62Moh3wU+kAMb7fL3xdZECcKpFskQC1P/Q5bhNHNhv7xfHRLHFMzm7
         QRBg==
X-Gm-Message-State: AOJu0YxZyqlGq+2IF8uJmMv/4o8TCZWWc5ay5kwXApsO24zJHgD4VodK
	78Zg8uIiQHGhAe9v+182PBWPgZMEqAAnr+joj838DPUL0CWrZTwMgskM9EUJ7r2DNs+Gj564dGg
	G5g+DBJvPMhbt5s56dWTWu9kJ6M9mZ0HPfxThPA==
X-Received: by 2002:a17:90a:985:b0:286:6cc1:5fdf with SMTP id 5-20020a17090a098500b002866cc15fdfmr1769259pjo.98.1702310928950;
        Mon, 11 Dec 2023 08:08:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiUz1pxdLFncKj4z/9C3dpC7nihMurmeWObLH6KY07S0ymlRGydDN9nLTR/0Q/a+Bu0oVkO47ole5oNQm76QA=
X-Received: by 2002:a17:90a:985:b0:286:6cc1:5fdf with SMTP id
 5-20020a17090a098500b002866cc15fdfmr1769249pjo.98.1702310928623; Mon, 11 Dec
 2023 08:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211131051.1500834-1-neelx@redhat.com> <20231211132217.GF4870@unreal>
 <20231211132522.GY1489931@ziepe.ca> <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>
 <20231211152547.GC1489931@ziepe.ca>
In-Reply-To: <20231211152547.GC1489931@ziepe.ca>
From: Daniel Vacek <neelx@redhat.com>
Date: Mon, 11 Dec 2023 17:08:12 +0100
Message-ID: <CACjP9X-Oj2DFKY0bopMGTEAr1bShM4E+6TtskA+8Ym-bnAfnQA@mail.gmail.com>
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the warning
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Dec 11, 2023 at 03:09:13PM +0100, Daniel Vacek wrote:
> > On Mon, Dec 11, 2023 at 2:25=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
> > >
> > > > Please fill some text in commit message.
> > >
> > > Yes, explain *why* you are doing this
> >
> > Oh, sorry. I did not mention it but there's no particular reason
> > really. The @Subject says it all. There should be no logical or
> > functional change other than reducing the span of that critical
> > section. In other words, just nitpicking, not a big deal.
> >
> > While checking the code (and past changes) related to the other issue
> > I also sent today I just noticed the way 08bc327629cbd added the
> > spin_lock before returning from this function and it appeared to me
> > it's clearer the way I'm proposing here.
> >
> > Honestly, I was not looking into why the lock is released for that
> > completion. And I'm not changing that logic.
> >
> > If this complete() can be called with priv->lock held, the cleanup
> > would look different, of course.
>
> complete() can be called under spinlocks just fine, AFAIK..

Yup, agreed. We ended up removing the lock completely in this function
with the other patch. This patch can be discarded.

--nX

> Jason
>


