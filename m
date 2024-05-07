Return-Path: <linux-rdma+bounces-2324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89A8BE946
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 18:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9C41F277BF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0616D316;
	Tue,  7 May 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a3W4cEA+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BB15FA70
	for <linux-rdma@vger.kernel.org>; Tue,  7 May 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099680; cv=none; b=iyiBi1j93a0rdD40qbhmIE1xH+lryJS5uJzoOQU/pK+E4CBmS6tyhDwYh6n4aNm0yTAEKCRh4DA/BMiUPUN+WAMRVfWSZAeulAe9BLdVObpsJaAKOc7HEearO/3w11WjQZo+zhbeJK6Es8jiDLJbYYyuFTuEQTj8DAamJ4TiWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099680; c=relaxed/simple;
	bh=VxFzCgfUjGZkaIJq1NXJEvjtXKhGePeLgzFYgc7qqaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0Uss53B31spVvvKjynExn1W4JmKHBKRZMgMqp6bOHxfhXyAguTPsn+X7TCckfJGBtUyhQ/JQCIeh1WasyNPYAHG5IAIgZUDporZbgxJtPBKNE5fdWyp+AOAVyA/OMh1P8CY3I4JisfgS3d3WkDr1Q7TAR8Yu8Q+1Q4jut6hdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a3W4cEA+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7928c5cb63fso241733685a.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2024 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715099678; x=1715704478; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uaTjuv9MHWZ7KfcpIF3FcH0nBlhF0D+YtiY2KzyAiNw=;
        b=a3W4cEA+44D0OikCVUoxSO1xiMmF+v9BQ4MADcsbM36hUY8kejhFxoJJpc2/oTbFrB
         va9t1NC7xjBESCBoyjB//fIzoYXRjPIXMLRdD6n9glfWgsg9UrafavfpyDadurtEfGws
         F1Td4n9lfVx6zpMHvdhvCeBbzO06V82PYG7HZvbnwMuW/ZIq0AU52bNt14At2QyrxhLd
         X0LCrdUqznbwICN7rYkUuD1Z1zIjU7F+dAEjqhL58LS8Jtp8o6aKqFh7nH7YaANuEQDz
         mmdi+h1HqqDfqYYVaQvZywPIOzs23CUlkjOX8/vUWbKY2z6OFM6K/qP1gZCIb908jSiz
         5cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099678; x=1715704478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaTjuv9MHWZ7KfcpIF3FcH0nBlhF0D+YtiY2KzyAiNw=;
        b=Rk7e6Z33SWbWaZZyhk0N05Kxtx+PlqeBab/GfIkUF7mxiODc33OnluJc0/IFhqAQrb
         lsrT072domm3bYBQqCV2F5PyfoOmPrrtTfBg3XTc4zDW//Cs9XmfrJp/9T9oay2ZtCZA
         t5xtyO/Q1+H9nB9KinDtlfCkN3xM2HAXIzC2hADp7OjSe5cad+aAizp0nPTSFQjHJzbT
         nlFP1xMtAfZ0AJj9LWNdvXzoxFbs1ekA9G+4RPqLDCU3ra/hEfyEw5uNBnvhXLZWm4D0
         wm2RMxH9HtQuWxxlzKifGA8fLDv7YuJ8q4i9dQZ3NuMQj17zeyFvjv+/L/1taZeJEJ1S
         Waew==
X-Forwarded-Encrypted: i=1; AJvYcCU+d1MAm1cCH08Vn1JevmaA1Xf+YGH4lhAAtlZ08iFvXGG33tWkbAYFP1YDNMacifzY/IQriXjkEmsxqz5SY5FZ2bOO4okDv9yTZQ==
X-Gm-Message-State: AOJu0YzC6sy1wy4qjUl+ywo1aqyBcUxAsl1BhVSlPow3E/KxYOdzhTct
	H9P8S+P0v1Y/0XcAsLFvykaDxSQoFCAC12Ym/LYUdu7yhIWKkzzEE0MfeOCKonw=
X-Google-Smtp-Source: AGHT+IEPovxBbcDlMGC0HwOh/WHREsods4JskpCcFKaQSmxjoF4qX1hkbji7shRDgUaZL/8uSfAHMg==
X-Received: by 2002:a05:620a:40c3:b0:790:77d4:5e7a with SMTP id af79cd13be357-792a6481e0bmr505548385a.20.1715099678153;
        Tue, 07 May 2024 09:34:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id os20-20020a05620a811400b0079282ce61fdsm4103806qkn.77.2024.05.07.09.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:34:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Nm0-0001VQ-QP;
	Tue, 07 May 2024 13:34:36 -0300
Date: Tue, 7 May 2024 13:34:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Expose the MSN table
 capability for user library
Message-ID: <20240507163436.GE4718@ziepe.ca>
References: <1714795819-12543-1-git-send-email-selvin.xavier@broadcom.com>
 <1714795819-12543-3-git-send-email-selvin.xavier@broadcom.com>
 <20240506174701.GG901876@ziepe.ca>
 <CA+sbYW0VZ-tnHGkB=nod7M-aOXryORpWrvV2CKN0F_tjEE9+JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW0VZ-tnHGkB=nod7M-aOXryORpWrvV2CKN0F_tjEE9+JA@mail.gmail.com>

On Tue, May 07, 2024 at 09:57:17AM +0530, Selvin Xavier wrote:
> On Mon, May 6, 2024 at 11:17 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, May 03, 2024 at 09:10:19PM -0700, Selvin Xavier wrote:
> > > Expose the MSN table capability to the user space. Rename
> > > the current macro as the driver/library is allocating the
> > > table based on the MSN capability reported by FW.
> > >
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 +++
> > >  include/uapi/rdma/bnxt_re-abi.h          | 2 +-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > index ce9c5ba..d261b09 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > @@ -4201,6 +4201,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
> > >       if (rdev->pacing.dbr_pacing)
> > >               resp.comp_mask |= BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED;
> > >
> > > +     if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
> > > +             resp.comp_mask |= BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED;
> > > +
> > >       if (udata->inlen >= sizeof(ureq)) {
> > >               rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
> > >               if (rc)
> > > diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
> > > index c0c34ac..e61104f 100644
> > > --- a/include/uapi/rdma/bnxt_re-abi.h
> > > +++ b/include/uapi/rdma/bnxt_re-abi.h
> > > @@ -55,7 +55,7 @@ enum {
> > >       BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED = 0x04ULL,
> > >       BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
> > >       BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
> > > -     BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED = 0x40,
> > > +     BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
> >
> > Wah? How can you rename this bit in the uapi?
> >
> > Looks really strange, userspace is even using this constant.
> >
> > Please explain in detail what is going on here in the commit message. :\
> 
> BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED was introduced to share the HW
> retransmit capability between driver and lib. The main difference in
> implementation for HW Retransmit support is the usage of MSN table or
> PSN table . When HW retrans is enabled, HW expects MSN table to be
> allocated by driver/lib, else PSN table (for older adapters). So when
> FW started exposing the MSN capability as a new field, we can actually
> depend on the new field instead of HW Retrasns capability. For
> adapters which support HW_RETX feature, MSN table capability will be
> set. For older adapters, this value will be 0  (to maintain backward
> compatibility with older FW).  I renamed the UAPI just to capture the
> correct name of the HW capability that driver/library is interested
> in.
> 
> I pushed an rdma-core PR [1] also with the associated change. Even if
> an older version of library is using
> BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED, it doesn't affect the
> functionality and this is reason for renaming and not defining a new
> UAPI.  If you feel that I should totally avoid this UAPI change, will
> add a new comp mask and leave the current value unused.

It is fine if it works, I asked you to decribe in detail the reasoning
and outline why it is correct in the commit message.

Jason

