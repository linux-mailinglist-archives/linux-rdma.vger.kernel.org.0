Return-Path: <linux-rdma+bounces-15018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F55CC05FD
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 01:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4311D300E020
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CD1A08A3;
	Tue, 16 Dec 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a7ahYwS4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3FD72628
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846277; cv=none; b=GPwvhqMZzdbp8qf8kS0qWMsuhuCE6BSPgQg20AaWYbsHvFFD9wIm3WmIi4di/vtS4/ZSJusAtgxYpKrpwSVMQmxxszSivVyQnPbgClw3C6mB1uCDBXbuCCqK94Oa3qetxg66d7l5TyLBz+ISA443+APov2Snns1FcCcTvvZ0ivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846277; c=relaxed/simple;
	bh=DSeEE4HrhYbp7z/VS9tNE4y/1DYB+yUc6ewuUoDQFVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eh10JFBMS1A4znJ88CoyIV3p2i+SekK42ZifB4XyZYz2Cqu0o/W7C3Tb7mRqDl0FCdsU9UEDWUY72cWHLjoPkH/FlsqIy4sTILxMp/BXVpjboXLVt/K4+KsoT6XBBKQsb44QXzzcB5PNJllWwfPQmSZJIkIjAgla5KkHiV+pv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a7ahYwS4; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a37cb5afdso20881266d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765846274; x=1766451074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTq3nzbbQv44WTI1AV/EF0sjxJPOxxsk/jLpcdNXq7Q=;
        b=a7ahYwS48uVjv6dbplEGdBdW+V1BBG0OPj7AtGFMugaZo4rW091PYWM/1UqCZ0OnCq
         8tAGoGuMq6eIbi2QcN/ZUE2ggycgCXtlvktoqMVKTxQZ/jeAmLjHCrb9GR6WhCd72IQ5
         lW6N+Wf3T3Pcfwp6KNTsBT3bIghOCJp2vwBvDmG1MfCRPcPn5TwEjitSCZke7Y8Pvz0F
         H6Ayz1jhQG1tiDZl+bBzOzZXpNT3kyHWpC8halWpp9ZDpJ79TI8ltgQbJMf2XSAnTL/z
         KIE1uG5ns37ldtecwbAF/CUXbJ7eEMvtHcEalSJcRCJZrLJW7Wk0SdJd/A3PT4BeS2k3
         BPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846274; x=1766451074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTq3nzbbQv44WTI1AV/EF0sjxJPOxxsk/jLpcdNXq7Q=;
        b=kbWWVmDKw7EBW5LkaQoSWJBS+bq2AIbW6EK8ZFjO5+7N8gW0o82Jobj4r/BeXZV9Qt
         7kYSKBjaSKebJFnNZz3APFcP6pXyvlTpYXACZKycOB6JDRoCKWClpqXMssiKPS2oGvVg
         66ywjmb90ptqWrQitX+0YYqWE2d5UdE1AbTAZiiO7ZyByUpor7Cm+Sii8h3dl+siAKZe
         BsZykgFw3tB1373y4STYVIkuGqFDK66DUqsZY3Wqh67LIdOLmtb+z310ufJo+i4sryMZ
         O+UoYyI/3XC2wv0MzadgDMlkUTwcaSuDNo70F43GRCGkPNiwPdoj6MLk3VTDCydRoMnA
         gP5A==
X-Forwarded-Encrypted: i=1; AJvYcCUffAp4icovArYpz44IBKshaznsXPQ0LUpYFyC96yxYWdR90MJg4kSiU0NG/vobIm1MXd9oPUBAOevy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eWbLtgtnlPruALPurZtw5TlmpAQ85BGn2UyRdLFIKy/x/+TZ
	OIsWFUxgEegaZ3ve5uicubuDDhenBZhRHNvHmnvLFN1bqkTov3VlbP/XW+XrQYOTZGc=
X-Gm-Gg: AY/fxX6lb64KTZh6zBzwGTMxSCwS6oVFnt/pXK2/98RZEsEqPdCD+uAppObKX2vKJR9
	CG1+8f6Qj+UfCa1NZTb0FE5/mZhU2gW+vTljdeLwfQU/n0P64EBe3LXTBUraC03kjidKLAzHjEk
	T7TA4XYebz4Q+kewVkjE8oci33KuVdFrmY5vOSFtL/X8wN8xOVbp72tJnYSH8lSQzUq9lvO/749
	AQKi71v9xBjIsQm72jdoDlIyB+0cMmqRbQngJXEN5CFYrY4OyQUfo0f0u/+1OV3J5yok+ei+4AM
	QLKVdBcdHFwh1vEIAlQ+brYe0vedUrjvbrzTgJuOLJ4tNkY9F9L0lbMLgzbRah4bTa9T5holb7K
	UUaJOGVMVcPvrPftxaRIj0hYmyablrgCdSu6g9na0TWCNtJHyMH1v24cvRsKYzk7yjr7DZeCr4K
	Sl0mhkbL/3sMs1zla4ow27E+sFxzFbjdfJvZChf0VX8xON9ystzpzmlIHV
X-Google-Smtp-Source: AGHT+IGFTJNe03b55VZxD0iyhJAmgElamlY6rdssXdCvCzYWmjHzWAPQMFNVB0XQ3kGugatUmxLwAw==
X-Received: by 2002:a05:6214:252a:b0:880:88cf:59ff with SMTP id 6a1803df08f44-8887f2bf035mr191444926d6.22.1765846274091;
        Mon, 15 Dec 2025 16:51:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b59838sm63554286d6.13.2025.12.15.16.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:51:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vVJHU-000000008Fy-3TMW;
	Mon, 15 Dec 2025 20:51:12 -0400
Date: Mon, 15 Dec 2025 20:51:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Allen Hubbe <allen.hubbe@amd.com>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: Re: [PATCH] RDMA/ionic: Replace cpu_to_be64 + le64_to_cpu with swab64
Message-ID: <20251216005112.GA31492@ziepe.ca>
References: <20251210131428.569187-2-thorsten.blum@linux.dev>
 <aTu7FFofH/ot1A74@ziepe.ca>
 <66a98775-76f2-683f-77b1-7f5dc991ca14@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a98775-76f2-683f-77b1-7f5dc991ca14@amd.com>

On Fri, Dec 12, 2025 at 01:54:17PM +0530, Abhijit Gangurde wrote:
> 
> On 12/12/25 12:19, Jason Gunthorpe wrote:
> > On Wed, Dec 10, 2025 at 02:14:29PM +0100, Thorsten Blum wrote:
> > > Replace cpu_to_be64(le64_to_cpu()) with swab64() to simplify
> > > ionic_prep_reg().  No functional changes.
> > > 
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > >   drivers/infiniband/hw/ionic/ionic_datapath.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
> > > index aa2944887f23..1a1cf82d1745 100644
> > > --- a/drivers/infiniband/hw/ionic/ionic_datapath.c
> > > +++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
> > > @@ -1105,7 +1105,7 @@ static int ionic_prep_reg(struct ionic_qp *qp,
> > >   	wqe->reg_mr.length = cpu_to_be64(mr->ibmr.length);
> > >   	wqe->reg_mr.offset = ionic_pgtbl_off(&mr->buf, mr->ibmr.iova);
> > >   	dma_addr = ionic_pgtbl_dma(&mr->buf, mr->ibmr.iova);
> > > -	wqe->reg_mr.dma_addr = cpu_to_be64(le64_to_cpu(dma_addr));
> > > +	wqe->reg_mr.dma_addr = swab64(dma_addr);
> > This doesn't make any sense to me. The original code looks wrong and
> > would fail sparse, switching to swab just highlights how nonsense it
> > is, there is no way that is right on BE and LE.
> > 
> > Pensando guys what is the right thing to do here??
> 
> The original code does not have sparse failure. ionic_pgtbl_dma() is
> returning __le64, which is what swapped to __be64 for wqe->reg_me.dma_addr.
> However the proposed fix is definitely going to throw sparse warning.

Okay, so Throsten, please don't send patches for changing to swab.

If you want to improve it then the primitive should be

 le64_to_be64(x)

(and maybe vice versa) With proper sparse annotations.

Jason

