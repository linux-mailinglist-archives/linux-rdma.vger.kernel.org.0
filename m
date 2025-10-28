Return-Path: <linux-rdma+bounces-14086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CAFC12AB3
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5813A3B42
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9DB26CE3F;
	Tue, 28 Oct 2025 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PehnpHXt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21D25D1F7
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618712; cv=none; b=gkryLQ4UQIc1bNYZCAVB0s/Q9/TB1sbJSDxiQNYfPKVJXfec0kDUKJFbaQLfQpkukgVgC1oMzpLFj9q7Obcon9MDca0SKXawl5NfkVcOuBz+s3lj3F+BefZ/IP1bx8iX3b/3UCbCuSCMBt4ROLEO7vh828PaXYj6mXVl8uiXA3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618712; c=relaxed/simple;
	bh=krWO4O+I6Syup84sG/IOEgf0qnpbjhmyqctFaWO1iw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvXfqenqFXP6urkbJwBypXMnyfx9PS+Hn8Qti//hgXMIkJLwYzDVkKyv1D/wJxi2+Ish6J1PjrlzuKDJyiR/psO7te6JYUp9cOcFEG1gRNYmCfD1KRrXui4daiqnl4eYjGtuM6d65SfqL17kt6LyhhK7QHEibllNLqWUVLNePuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PehnpHXt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so851520266b.2
        for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 19:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761618709; x=1762223509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krWO4O+I6Syup84sG/IOEgf0qnpbjhmyqctFaWO1iw4=;
        b=PehnpHXtZOEUr+eAPqiihfgEFrf6lyhOIhcg6iHzH5IrLGMjso7Hy96r9cD3Gl19YX
         LsDTGAhzZDy9tk80ff78dJn+58FVcdEIpoSrTDASLXAj112/CbOuaGZ4faUXNZy/6clz
         V1zA0e6YIj925GDQRfqap3kUDMOjzpM8w3kZUT94J0ANfxzI/vYs2DcjTfjOqGDeboo/
         NpkJMdzRarUTmN8/buEV7F7LCiEnicHIcmX/0pbo8e6sjc9B3V3Bw8sObWeVjK8COhbX
         uRm9KfG8t6dV6nkQ4j6bx7Ld81DpqUDKhD2aPVuOn1g1ZKghpmlAbg1WElJBypn+O8AH
         V/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761618709; x=1762223509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krWO4O+I6Syup84sG/IOEgf0qnpbjhmyqctFaWO1iw4=;
        b=auzd22uuYeY1S2fktK0mVFrK8alPrQV2YlXiME8Tk/7DQ7vlx9BdXF6Q8prQePhcBe
         fUZSR0Yo/+b3LyDbMOrEZAcL+QQM2MDXWdOpib45FnS7xHouwr9csRegwUvVpYgRiSvF
         U1SqNzIDEBoSqfQvTwkN/57IQGnoERYHVW1EcyqqI9zqwVUx3/Log1ZI7OjlBzWRN6EX
         ghvVZLj5bqfpu22DWx83GvuG+j54fI/9HMnQutt7GJgw2P0qTFFL/fKmBeauS50VWjHd
         JTp81WQ3mnmxnhV2qkWSmNsIQHHaKNqxovyIMxy0c7HWEV9vshEeiY4X7jDVsHX1Pzab
         BamQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyztBzqkvPWwQqEkypyLKO+JnyRHtNxZ5gKqUo6tTiiodTTE/8Pco81UvOEJTfyoABD58vlKJLiriT@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDHN+8oFoHE0aeNeXznjPngvZJLUjhsv03acxLNt++pIxsY3h
	mmf+XPXdMsZXGwzf51ICsmy/wN8G6T4WG72mSDjH5DzTvTKJeHDvdVsyDSQAyOm/tbzJbUFhJpP
	iRa42S5+3rWJa96rQkiw4EI92IS1kM6KL5fDI
X-Gm-Gg: ASbGncv6nfDEBTbex+HtGeD09Br4TF0BFytu6cd3U4MVe8JKXGievmjo9lmeIs7qRii
	2PwAYDBPRq2xO8xqCjhKJtYZg2X63V6PxkzekyKeX+6Eq/IhoegrRQ4XY2hEHLpSPjL1YsSWftp
	EbT7esxaXryS3neELBNAFAv+SXzAw9/M1mDwji2mZDgR0K28jx1p8DIo4VctCLPAbCqiLWRW8tN
	QOCKujrHAnmEKOP15vMf1ZJA0xzvnxIbxuPqv+wHKIeDoEdjojfG6pdXc6kIxzFlJImj0W6wO0=
X-Google-Smtp-Source: AGHT+IFBJulmjKaEIQwsvJx64/V8WnKApmQIOwSwHunZ+yybA0TJVObz3sscqfk1aYSp9aG5M78IBhqaP8umhuhldbI=
X-Received: by 2002:a17:907:d15:b0:b57:2d81:41f with SMTP id
 a640c23a62f3a-b6dba584270mr204086466b.40.1761618708492; Mon, 27 Oct 2025
 19:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
 <20251027133053.GK12554@unreal> <eb232c55-1307-473e-8620-4e277f28be4a@linux.dev>
In-Reply-To: <eb232c55-1307-473e-8620-4e277f28be4a@linux.dev>
From: Yi Liu <asatsuyu.liu@gmail.com>
Date: Tue, 28 Oct 2025 10:31:37 +0800
X-Gm-Features: AWmQ_bnI6tHx8fWAlcNUMW4fitJjrM2rhM6MWN-0lyeud0qKrBtE_3Ys9tfflTc
Message-ID: <CANQ=Xi3KzyGiFvoD_sgsq3x8e6B-npN87vD3vAT4gZZo37sUJw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize failure
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your kind help. I think the format issue comes from the
Gmail Web Client. I did not send the email by "git send-email".

Yanjun.Zhu <yanjun.zhu@linux.dev> =E4=BA=8E2025=E5=B9=B410=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:56=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 10/27/25 6:30 AM, Leon Romanovsky wrote:
> >> err_free:
> >> - rxe_queue_cleanup(q);
> >> - srq->rq.queue =3D NULL;
> >> return err;
> >> }
> > This patch is badly formatted and doesn't apply.
>
>
> Sorry. I will send a new patch very soon.
>
> Yanjun.Zhu
>
>
> >
> > Applying: RDMA/rxe: fix null deref on srq->rq.queue after resize failur=
e
> > Patch failed at 0001 RDMA/rxe: fix null deref on srq->rq.queue after re=
size failure
> > error: git diff header lacks filename information when removing 1 leadi=
ng pathname component (line 6)
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > hint: When you have resolved this problem, run "git am --continue".
> > hint: If you prefer to skip this patch, run "git am --skip" instead.
> > hint: To restore the original branch and stop patching, run "git am --a=
bort".
> > hint: Disable this message with "git config set advice.mergeConflict fa=
lse"
> > Press any key to continue...
> >
> >
> >> --
> >> 2.34.1

