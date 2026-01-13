Return-Path: <linux-rdma+bounces-15533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A52C1D1AECC
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 20:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D419303B7FE
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F9F34FF48;
	Tue, 13 Jan 2026 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gPwh0n/W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA0352946
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330800; cv=none; b=HVx7qxFtNouvqKB3nxQ/SPvKB7Z0l4BGOt3HyjfLPeRzS+hr27uP2vAr5YR6MmKj0Dw7gAHX5hWJ9Jc9AxEcHtXdVTH0bv9KA4g7Uve/VQbTdNbWnYx6lQqudmOglRYetRfZDytB3oV6IZP7D4jgSlxZQ52SX8MM6hCNo58q2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330800; c=relaxed/simple;
	bh=EE+gFuFrdWS5QX52vkIYBVpYeHMTNTLu7cI61/u/RQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPtMAUOymxbXjGwJyVm5kkxjtTJ8/S9KYygiYKbiudrNKgTgYSmJtf/5InPWApTo7wSSAf4s/d57Ka8njt35AWBUjv2OykfTzCayrQdVC0AD+L4QfLsgWjsP0nyJ5yAAWSMXnrvo+xap4XTKaOokTMNpx+r/iLNlqVu8Azo27m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gPwh0n/W; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5013d163e2fso11259931cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768330798; x=1768935598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wtHByn/BRgntevzVfMA8fYbgrfNKZF2kpn3t5pzBMV8=;
        b=gPwh0n/WipL23q8TpP36hMtrR4siBVhENrPV1LV63Fk8UGORqIPth+m8uMMx7RMERB
         A13yczEtWA+pjI7vy+2QH1U4VQsVNUdVEgBFxSg/YuvWaU3jSBUzOARQjUqteQqFTP/p
         uVF7WrjOEOroiRLHMMT8CLZQram4rfepPkGJxULFiIN86pF1VN71hZF0BEvLEWGF0WEa
         aKgtWYAI0Mp6H5AG3TP9+PVNISSObcG6lygIdNkwrfOOUdxyFVInJgwjTnvXij0PYntF
         1XbDGCxiyOK9oHGJ6ynFAQJlNuyhnrKTebWZ99/mxarblZNWxpRRgMG221948nWTxFLL
         BPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768330798; x=1768935598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtHByn/BRgntevzVfMA8fYbgrfNKZF2kpn3t5pzBMV8=;
        b=kC/CYh0niwr7ky15EanlZWc399MRkCT05qTyVCFiNDfsHCi/9hjUyA3P2AYpEDMWFh
         B23XROY/V7Uo5fNXR09cZ+IsXRfH/R9vCuEeHoMa+76zjp939pAuX5ZYKNBbEIp4dLn6
         3t8KL8JYR/Xo+GtSskbEw9Ge0JDVU3/0FrMUjhTMbKfGmK/idMfKr0SlTYFUJOr9PUMS
         0tII2FF4RB4sUWsKwGcx7OuCwDurgEL3+kzGgkVJ7kqGf4UNqgY9iohJZUXTFkF1Zb3F
         v7kshqFE08RjL/AruquYLyNyUowFrrDVQ2LFXlimuQ4xT8K5sjUxb2glCVusglsAsetb
         0EIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxPwkZtZeInWsgGsDFI1mzIxWr0YGO2dPp31vjmBLxPTgk8HQqb8vUl+M6V/NKua0l3ryX6SaeP+Yj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywle0SHhVMw+aiMchIxFLcexooYlSUVuJ/F89uk1fXjKfCBfH9z
	6OYOVurtUsJHwOQZf4y6AlHrFUqqMqORW4KfOLBCkc0mnI0RYcNWH4u7/qkEcIzX5V4=
X-Gm-Gg: AY/fxX7keFFX2lxxexUC3HGuqz+mXifTiFzm5h+Iu6AtggpnLR3Lak73MlVF9P8qXry
	jxGOmLAzoEk+JY2cKwP9QNsuRZxwlMDw4SMMYay5iukwnotG5TpgboLLeR1/3AqqS9bsEe/wB5o
	CzP8dkmWqxfaDkE6Qq2XC2Qx0zyxcUbFPZ5nCViJ2RNBCK/qvw4ekZUqlLPtyTEnQYBU9mmVYI+
	iD0Hm1K2rmGNUnHhI0e63ydGAoFqejaMTwl8N3CsUltdQl+lZd/Eohe+3Q4aiEW9Ak/jbs1GIU/
	h7AeLpLjoHGTqPQy2aOMUIiW3Q0OuleknsR50qo5ZTeqDV+7KmRESLYKGRv1fqIjJu4mKrD0cX5
	pYJ45l7EAS6RRp3nhFJ0Q44ErkNqQAq1zDTJKWRN0JFmID6D4ylIDWkdqPoevL1XXzEsj8iwbf0
	4gxldHsA08jeSTklF+aKXtCPaAlux7TiEZyzNaMUT/5zQqD1FwEG3qzcBbEfdlWkEEI/A=
X-Received: by 2002:a05:622a:606:b0:4ff:c8ae:efe4 with SMTP id d75a77b69052e-50148219986mr2279511cf.30.1768330798084;
        Tue, 13 Jan 2026 10:59:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb813ffb8sm127699721cf.20.2026.01.13.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 10:59:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfjcT-00000003zRR-0KUU;
	Tue, 13 Jan 2026 14:59:57 -0400
Date: Tue, 13 Jan 2026 14:59:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260113185957.GU745888@ziepe.ca>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <20260113173247.GT745888@ziepe.ca>
 <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>

On Wed, Jan 14, 2026 at 12:06:38AM +0530, Sriharsha Basavapatna wrote:
> On Tue, Jan 13, 2026 at 11:02 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jan 13, 2026 at 10:39:56PM +0530, Sriharsha Basavapatna wrote:
> > > +int bnxt_re_dv_create_qp(struct bnxt_re_dev *rdev, struct ib_udata *udata,
> > > +                      struct ib_qp_init_attr *init_attr,
> > > +                      struct bnxt_re_qp *re_qp, struct bnxt_re_qp_req *req)
> > > +{
> > > +     struct bnxt_re_alloc_dbr_obj *dbr_obj = NULL;
> > > +     struct bnxt_re_cq *send_cq = NULL;
> > > +     struct bnxt_re_cq *recv_cq = NULL;
> > > +     struct bnxt_re_qp_resp resp = {};
> > > +     struct bnxt_re_ucontext *uctx;
> > > +     int ret;
> > > +
> > > +     uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
> > > +     if (init_attr->send_cq) {
> > > +             send_cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
> > > +             re_qp->scq = send_cq;
> > > +     }
> > > +
> > > +     if (init_attr->recv_cq) {
> > > +             recv_cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
> > > +             re_qp->rcq = recv_cq;
> > > +     }
> > > +
> > > +     re_qp->rdev = rdev;
> > > +     rcu_read_lock();
> > > +     if (req->dpi != uctx->dpi.dpi) {
> > > +             dbr_obj = bnxt_re_search_for_dpi(rdev, req->dpi);
> > > +             if (!dbr_obj) {
> > > +                     rcu_read_unlock();
> > > +                     return -EINVAL;
> > > +             }
> > > +     }
> > > +     ret = bnxt_re_dv_init_qp_attr(re_qp, uctx, init_attr, req, dbr_obj);
> > > +     rcu_read_unlock();
> >
> > So now if dbr is racily freed the QP just keeps using it? That doesn't
> > make alot of sense.
> >
> > I think the reason you having problems with your locking here is
> > because this is the wrong way to pass a handle to another uverbs
> > object.
> >
> > Pass in the uverbs object ID and use the uverbs object lookup to
> > acquire *and lock it*. Then refcount the uobject properly for the qp
> > lifecycle so the underlying DBR record cannot be destroyed. Get rid of
> > the hash table.
> 
> I thought about it, but couldn't find a lookup function that can use
> the ID (idr) passed through a driver specific ABI structure (and not
> as a uverbs attribute) and find the corresponding uobject.

That's right, we want drivers to pass in attributes like this because
it triggers alot of core code to handle the locking and lifetime
details properly.

> In this
> case I'd have to pass the dbr handle in bnxt_re_qp_req structure
> instead of the dpi, and then look it up. Is there an example?

Pass the dbr handle in a dedicated attribute, and then get the dpi out
of the handle once it is converted from a uobject.

Look at how QP releates to its CQ, it is the same relationship.

Jason

