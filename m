Return-Path: <linux-rdma+bounces-15319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFED0CF785F
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 10:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A6E330402BB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764052D541B;
	Tue,  6 Jan 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="E6HWBjDO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408729B8E6
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691631; cv=none; b=MA81yLo9N59WyWalXngDV7hrlmKnokpRmFx6kRmZ8fMOGG7N7OBN3vxulm1QCehavmN1n0wrqgjcqd8jizy3OjI/t+DSoS0NlneF87uOvg8T6dVlXXYlorIMueZcOxjXRwS5vKzm4Wqnp/UDHxmIR+ffbGYQCelTh+RRA4YBABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691631; c=relaxed/simple;
	bh=myn5yAPlu07TtLM3TDqXNKElymZF0Twa/rGuIZl/By4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXLLbQAWzr0+6qwFOy06uCylVwhNT957lu1NBCUGW7Tt6oocb5Gj2ZGLadrMhf4pZHuKsoB/Xm1tx1Dh7fdN+yqZ0S8V48r9W3YsP2DvNyCY7aAxJ8lx2m79ZDNiPxVFGFZffFIvEZY2Xo1tvgJusiWy/yZgyhPyua9O1B041fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=E6HWBjDO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37d13ddaa6aso5045171fa.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jan 2026 01:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767691627; x=1768296427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM19Bh1Oil5q0MYn6qelLn14RqYQhYn/OJnpfT3sECk=;
        b=E6HWBjDOSjKpcErGjTTzTelz/P/bC+biK/eF9YYIvJzRTwMoX4SpRIlPqmou8FTmCh
         Uh8zYSUHGSZY8zz9TwCfSUBXAwwMe6Dn/4PnWL6ePDrBXMCjN0T+71HpSNeE9JToHKuC
         XSCG08xgF/zu/ik9jzqgEVMmq9fgCOBTGWJdmyUIa2xXh5Ek7Lq0dCLyI/oQXl1lbmkp
         /AeHCgn4YaFvXB7+M9iSVnbIYjXJzYZE2J2C8sDt8jJ1lO3hBeT0RtAuhqbWXr9GVNL+
         k6VtWmFFWrI9tUVNJsWL/yBfWfWBimocsBqzKoyCMXkCxsAW1+SWowJo2/rZ9ZmzLBwQ
         av4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767691627; x=1768296427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uM19Bh1Oil5q0MYn6qelLn14RqYQhYn/OJnpfT3sECk=;
        b=X8s2D0/HEff3lpSDYDGyltDfb2wiS+ac9IWrWDvIR3vw/ON8FYrUsinCNiBnnzTjXz
         BHTTs7g3glo1YIGLpkgjlGjk0af9qdwk7F+rXfmEmOKgY1WXqTprVA/qH9sXZg3Qu+6k
         h/dq0G2OKOWUU1YlBoupLons382mSwLBbQoNATIsr5DqJAB5vxmh8ZAmqziwdvr+yGU9
         6Nldot63vcBAzc+qaD1/boMMZeLR6w7GBkpcC/7F5gG8hvsfO490TEps6NJ56keFhdun
         QVraFXgBHX0akKLmB6xFSVRb26Sf++uECvgXCVs9fydm93XSivXiiiHph60Kj9fzMOHK
         fDDA==
X-Gm-Message-State: AOJu0YylICA35iyPEx8ZrgMoyZtvPJAatn9yo1aoDMjLW9m8FluskCa4
	Evd2Wr+ca1gBcET1uoF4ShPKJFJ/ydcZ6SQkBA+V/I/DUEnExzl4nv6tdbrfVRQeRlmlWMJ1bfg
	9ax5EX6pdfqJWUuDmh0zJq6cEWtu4PGORM2+sM/cm7A==
X-Gm-Gg: AY/fxX5G9UD4FIqkoZ6ZFyNQgpiMSN24vfBBR76NKXfQxTrFFKT+fXAicwH+7g/OVso
	JWMoYHsB7hUO4c6qEMtZCmPvAmjWSQN33wiBhe6W9bX3nXCi9X4RmIfY03Z+o17FJAncAzW5587
	XAbvbNRsYOAWC88iyvS6jgYZd8lZlXSXjT6ogWqXjGjwYiRLcZHhs9NOQBkgSZuMtFbh18zJe5j
	EVPPFAw1dy8HoXIgHR2zuWoe6XTw5dTe9GvIRZVTXDvJUHn2POG5fre7CEY610qM/inMwY=
X-Google-Smtp-Source: AGHT+IFiwF3ZPoFjwJVb4R8qgnmCWwCHG2SdSHOX08KMw8/AeU8qEPh066qoCOAQP7BIb227dQ3R0SyEAVoImjmklHk=
X-Received: by 2002:a05:651c:1507:b0:382:51cc:d267 with SMTP id
 38308e7fff4ca-382ea9e70dbmr6420951fa.8.1767691626568; Tue, 06 Jan 2026
 01:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-6-haris.iqbal@ionos.com> <aTd4B9vJ--hDESNJ@fedora>
In-Reply-To: <aTd4B9vJ--hDESNJ@fedora>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 6 Jan 2026 10:26:55 +0100
X-Gm-Features: AQt7F2pGCQSdPaY1dSAoetpBs2GTWasmnTixizY2zmXG96eQ0fhYn0pNFUOiDLA
Message-ID: <CAJpMwyjt_MwT0pF=a6NVfUiZGKH8-b2WJsiWeu1JJ2OjLNomkw@mail.gmail.com>
Subject: Re: [PATCH 5/9] RDMA/rtrs-clt: Remove unused list-head in rtrs_clt_io_req
To: Honggang LI <honggangli@163.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org, 
	jgg@ziepe.ca, jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:14=E2=80=AFAM Honggang LI <honggangli@163.com> wro=
te:
>
> On Mon, Dec 08, 2025 at 05:15:09PM +0100, Md Haris Iqbal wrote:
> > Subject: [PATCH 5/9] RDMA/rtrs-clt: Remove unused list-head in
> >  rtrs_clt_io_req
> > From: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Date: Mon,  8 Dec 2025 17:15:09 +0100
> > X-Mailer: git-send-email 2.43.0
> >
> > From: Jack Wang <jinpu.wang@ionos.com>
> >
> > Remove unused member.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniban=
d/ulp/rtrs/rtrs-clt.h
> > index 0f57759b3080..3633119d1db2 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > @@ -92,7 +92,6 @@ struct rtrs_permit {
> >   * rtrs_clt_io_req - describes one inflight IO request
> >   */
> >  struct rtrs_clt_io_req {
> > -     struct list_head        list;
>
> It seems these two members alse unused. Why keep them?
>
> struct rtrs_sg_desc        *desc;
> unsigned long                start_jiffies;

Makes sense. Will remove them. Thanks

>
> thanks
>

