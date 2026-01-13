Return-Path: <linux-rdma+bounces-15529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B50D1A9C1
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC5B5300AFFC
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978EB3502A5;
	Tue, 13 Jan 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ESyvCqdd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E82EBDC8
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325244; cv=none; b=NGCkvB/Mm7r+iL/lh6agO+4etjPTwc83JR2Ka6Rf2u8cwyLxzCzqXOdbGgpj6V8kNC2qPaU9cFM6kmg1gUO7P/6qoLkytNuuuw1xoLU9VLFx4jAMNPAPmKPwwTpXHaqSh247LKBhrwqATjkI4jxjpDkrRguU2xISpSgaZbjqZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325244; c=relaxed/simple;
	bh=ViHx4ZdOltTSXzp0JemjfwXr5KdLCDBHGoaYBE2GRXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4iuT6z3u75P0hn0/ouOI4siDMYL8UTUaTnLz1zeu3N3y7dvFikrLs3cEEc6+pj8ZDGgfDrCFq90PdTjp3HJx0XpxOidfYuuKQ6jAJ+Md4rm3TGhHPSePG/M5kIewu/sELjHj+cFWPliuKWuZQiLzKjdyllUlOvElKeYdqgaZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ESyvCqdd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b31a665ba5so953175785a.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768325241; x=1768930041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OlZ1y+kl7fCt1NYCsGprtHmn9eMPUydGtWNO6vOUhs4=;
        b=ESyvCqddF2LBOSz0AV3eYfH25Egkv2JhNpFfJQBiijBSQWxYtMZzLTp91DRQWxYLeS
         IKJLXLR8/6Pc8NuJAgfOhSOU7QzGaVYjkAm0yLIEM5IGXNyZ2Wc7btTYE1FmtFL7CkCY
         LoxQci1/Ovt3ebGlr+vWOMPJ2zqvVQskHLhlgtgYe+zjSEkMTSxE5t+PqsTkt2wAcEqI
         L+3Cqe8MTGTnhaOXRfxRqt1xK7c9XSPObPX3pwCJWDOPPU1cLPzk6eD407OgnKpp3HTC
         WcpJHCw6pAd1fWf36lbTkE1QDxAGnHdAJe+DSw4cXf95BP5/3YfvM63zvT1Eo3/LnQWy
         mPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325241; x=1768930041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlZ1y+kl7fCt1NYCsGprtHmn9eMPUydGtWNO6vOUhs4=;
        b=BeiCbAm0sl7z69DxoO7IYiJlS/NmUWBC8V2TtIIzQ976VecRZNijPF71p/cy644ts8
         ubT5knrcbX0ef7Ml7jyoOArvQWy2ssOtq0SYWYrpFz5aNLnNxrBP7zJkSEjFu4Xcg81O
         HJMa1fj6uRl1V/yrRkFh3XVkTB6GUmqTRyk5Hs16b/oSW3yWQlymID5IHLgXsMp8uRyr
         b/dulVBKW/SI0KU5EMEPMiF42aLApsMC6ixQrdWxgPnHTUWjDfwWY8CGIkbcdNPIXVjz
         Lq9u0dq+bLQB0/99NC6QSs1ujYjiPWz5EcW/02ZJezmWUiInVqyxqAHBFmZoGxjNXyiR
         0OhA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Nm6AnI/fDL1w3qh8X8JadMKARNNkkqRw+fkU8M5RexCxEYQEGgpBkK6RhsD4hxuTiNvJW/2n/Z6P@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3bSF90Pr064p9eqlUUZQFy6AmLAII2CLeFl0cE932olVQT2N
	W56GuPaIMkrFrXw3i6TziInYtoYvuqkKV52yAVcgUDFFu4kWK7zhbxOHvm5hH8MxBys=
X-Gm-Gg: AY/fxX7jGWpO7sW2VHTSfOB6IbbW+MfE98o/x82Vo66grxvfaDjeg+86BaUrXZc7GEX
	a44OzbsbRBaKJ07px+xjwk4rUswIMC+9BtmlZDUAho9NrbPPw0Aul4lKNku+6HGc36+rj9BELxg
	icPZpr3jdJ4kMkLh4+ZbVn34BraKN4StypdTh6O4iG5Gx0q0WVbp3KOzZR775mNZQZeM22HgiYf
	xC/Uzg4UIDax6RgkQmhg5xrGSP2ZsdrtZPKaYanMrzSiOU3mU16Ojad4VZqJuultv1v9vpU9w1w
	sdkUGJEer+VUyFPF0nD/pUbY6vRBCGpUblHHsoqrs/QF4xGgYb3ARJICeVVEJokuRcSGKmQA9IO
	0AxtVMSK48dpEaHU44qdy3pR+s1mbDb/La8N3LvUKqxbeiADLIgi7xnPI0DHggqk8P+aa+mnqB3
	Ral22gwSOeFO7Jnfyv4ndJrdFhWpLwofK1fHihwr4ZK8VNozdznIaquoXo5+vufDV1fvE=
X-Google-Smtp-Source: AGHT+IFkndpTo4fC8ofH/k7eZSqpgYhtuTjOzJzKf5gakRpWK6Kgv4syB6B6byqmQGcU5Uh7UMascQ==
X-Received: by 2002:a05:620a:284d:b0:8c2:ada2:dca1 with SMTP id af79cd13be357-8c389368c9bmr2977246585a.12.1768325241359;
        Tue, 13 Jan 2026 09:27:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c52d79ea38sm61321185a.27.2026.01.13.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:27:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfiAq-00000003w7B-1Pzv;
	Tue, 13 Jan 2026 13:27:20 -0400
Date: Tue, 13 Jan 2026 13:27:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260113172720.GR745888@ziepe.ca>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com>
 <20260109190857.GO545276@ziepe.ca>
 <CAHHeUGWHkfNKK9qahDf6ZSxnbAso8skT-bny3=MsR+ZM9uckFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGWHkfNKK9qahDf6ZSxnbAso8skT-bny3=MsR+ZM9uckFg@mail.gmail.com>

On Tue, Jan 13, 2026 at 10:44:21PM +0530, Sriharsha Basavapatna wrote:
> On Sat, Jan 10, 2026 at 12:38 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Dec 24, 2025 at 09:56:02AM +0530, Sriharsha Basavapatna wrote:
> > > +static struct ib_umem *bnxt_re_dv_umem_get(struct bnxt_re_dev *rdev,
> > > +                                        struct ib_ucontext *ib_uctx,
> > > +                                        int dmabuf_fd,
> > > +                                        u64 addr, u64 size,
> > > +                                        struct bnxt_qplib_sg_info *sg)
> > > +{
> > > +     int access = IB_ACCESS_LOCAL_WRITE;
> > > +     struct ib_umem *umem;
> > > +     int umem_pgs, rc;
> > > +
> > > +     if (dmabuf_fd) {
> > > +             struct ib_umem_dmabuf *umem_dmabuf;
> > > +
> > > +             umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, addr, size,
> > > +                                                     dmabuf_fd, access);
> > > +             if (IS_ERR(umem_dmabuf)) {
> > > +                     rc = PTR_ERR(umem_dmabuf);
> > > +                     goto umem_err;
> > > +             }
> > > +             umem = &umem_dmabuf->umem;
> > > +     } else {
> > > +             umem = ib_umem_get(&rdev->ibdev, addr, size, access);
> > > +             if (IS_ERR(umem)) {
> > > +                     rc = PTR_ERR(umem);
> > > +                     goto umem_err;
> > > +             }
> > > +     }
> > > +
> > > +     umem_pgs = ib_umem_num_dma_blocks(umem, PAGE_SIZE);
> >
> > I should never see PAGE_SIZE passed to dma_blocks, and you can't call
> > dma_blocks without previously calling ib_umem_find_best_pgsz() to
> > validate that the umem is compatible.
> >
> > I assume you want to use SZ_4K here, as any sizing of the umem should
> > be derived from absolute hardware capability, never PAGE_SIZE.
> Changed to use SZ_4K.

You also MUST call ib_umem_find_best_pgsz()

Jason

