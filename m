Return-Path: <linux-rdma+bounces-15313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94775CF621A
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 01:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E23C300A3D5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 00:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75A20296E;
	Tue,  6 Jan 2026 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SqhU27a2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164431F0E29
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 00:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660961; cv=none; b=Qwv57pn/hb2hPiY15XCuKI/Ot40L9vz+ZK2ddqHpvbjJMaMVzoCAgRQiVszMwuAo0kmOfJu3qTsAxwuccUd4V0viZk8QK65eLCFXhDqhYwsCuROwOYrDuCMPAx/yvyQbs1E1e4QvFgtIEE0VaHVl/U1Ur3IiMhRHoAMpj2nJbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660961; c=relaxed/simple;
	bh=abJpD/qRRa8BSnB0k+A5D0fdC9PhsRPfE1y9bMxV0DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAhngnnpusjvEwsqhd4VbjkWrt2UfzdOM0qzxl18NlPUC/nKH0HxPrjiOdShh+421JZ635O59dbrNyBv1kJd8QQsLCFHaJPXeanlyPqOK3fSKPEb4POFqfe3TWvtI3+yzsF+CsHGWnceLso56Lm1e96RMU3kycE0MQX5OtqT69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SqhU27a2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b144ec3aa8so47689885a.2
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jan 2026 16:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767660957; x=1768265757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDaatcwxGRMydCvVRMs3UB8MyV1SGaXPU4qbydS0qdk=;
        b=SqhU27a2AkuX08eCs0gQEEHW6ijKDFiZVPsx4TlR6ITDo+Kedn3bOu6LTEli0dn0iU
         6jLXtzbaq8JxCqZckUf3WQGiQU8AoQrMqRx2XDG4RXovaZrBbNogPUY+BrFNKI4P4xg1
         Yw947i2sB+iNObXUSrfdIwId2o5/swFZICUexi/Vb2ktVurgRDLDTbcX1KSRcmpHDJ1U
         xMNZXlDzi0hDMnW/k4kmCpU160zTkq4iGcjsxULos1WjFWzooRTx8ZU34uqTqr5CCkNp
         P2DFSLdEf1m8UhSdAEIRTxXi7zOWp0P2+l+g2eytmUumx03n039TjxOp6HnDLSUx7EMQ
         ACGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660957; x=1768265757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDaatcwxGRMydCvVRMs3UB8MyV1SGaXPU4qbydS0qdk=;
        b=LmycArrOoknYyX1hCwWdmm5n79Bu3+IHlWT9WD8Doyyqz60cu11tNC9MxGPi8p13jo
         AXO61McTZeRtXMTMPxoFmBXDl90vHE4HQrTpCWq+UHuy9Pa1+wGcWTTfwpXipHGZImA5
         4rSAMV4VhfM/Ydma/GRKU0xQ+O2JwtWz/zxGx6u8uRbZ7vje6g3nbo/EaqIiYp0hmip4
         3PQVPaDHz69WFfd5JwTR3dwo7NL6hWhcr1h4U9rHKNCUfg5ePqz/axdcG1aJIdoHj6iA
         yja037QmAXSLnKFn7R9I+0XqmrCDi4iQjSruMLrB0zBjHN26RwHfzEbMI+OPL5p/ErVZ
         eBtw==
X-Forwarded-Encrypted: i=1; AJvYcCUb/VBuv4bofqRMBbj4RNTfNqAXfVouvxWOIG8Vg7SCuFpAW3fl2V3j7HlggDiuuqQMNLZSZEs36YyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwjH9l2tzMKf2bnHef0SAXcWPt8C4b6ucFJ3rXo3WT41tJIXdfT
	TkJBRhjYLAajjQ8oSyMNgEemKgrsE1IppeXGJpQypwFbIWzZSxbTGY4bboJizsEfnxY=
X-Gm-Gg: AY/fxX4Bapriy+vU3kpsIR20JNuS/KD/5CtVu4RzjY0z1gTepzAChkj7f7AcR2bkh87
	w1Eo3JycI3eLdVrZE2Hfb26XhFK7eZ/NUN0aVnpsyCtC3rESx9oD/B70VU6T/70tGdQgr/vwE3F
	iW1WspJZGvZn0QcUF9mvKWfzQkTgSlTIomdU81DUNMca8FcefbKsPegl8fy040UnjL5/sq3c9/t
	mSCdcD2O55tNipI4RH20Vl4zMQTxDjFjqRMl1mmzNUtSsgzBSHT5w+zpVrbPATwmVXZBwmf3Ol0
	c+Yir+mFridxKwOPRHeSTZBvtC6kwiYEKaII0nskfsFeExz37hNvFDDBvMfQROUaKSsF5EQebPq
	LgzOTKRdUweo6QEq5LaIpbt8orDBUOQjPN/WBLqIPrD9ljQGtl37JzJU0W6mgGec4gn7iPPSOXF
	UQI7a4gKj74WUQTpttItEgCLBvYuNX8PP2LiE0riXHyPL8C2pwK3/5rtQGM9aq3mrI/Rw=
X-Google-Smtp-Source: AGHT+IHkp3tvc1TSQLjXfwX1R/16djzCewcOTCUqfELaiw90lDY/HdFwxvMQJsz2/fprn33eK02RsQ==
X-Received: by 2002:a05:620a:4494:b0:8b2:d2c9:f73 with SMTP id af79cd13be357-8c37ebba292mr183184685a.41.1767660957054;
        Mon, 05 Jan 2026 16:55:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f53129fsm63537585a.44.2026.01.05.16.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:55:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvMZ-00000001EVK-3aKl;
	Mon, 05 Jan 2026 20:55:55 -0400
Date: Mon, 5 Jan 2026 20:55:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jang Ingyu <ingyujang25@korea.ac.kr>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband/core: Fix logic error in
 ib_get_gids_from_rdma_hdr()
Message-ID: <20260106005555.GL125261@ziepe.ca>
References: <20251219041508.1725947-1-ingyujang25@korea.ac.kr>
 <20251221092418.GF13030@unreal>
 <20251221093038.GG13030@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251221093038.GG13030@unreal>

On Sun, Dec 21, 2025 at 11:30:38AM +0200, Leon Romanovsky wrote:
> On Sun, Dec 21, 2025 at 11:24:18AM +0200, Leon Romanovsky wrote:
> > On Fri, Dec 19, 2025 at 01:15:08PM +0900, Jang Ingyu wrote:
> > > Fix missing comparison operator for RDMA_NETWORK_ROCE_V1 in the
> > > conditional statement. The constant was used directly instead of
> > > being compared with net_type, causing the condition to always
> > > evaluate to true.
> > 
> > In current code, it doesn't matter as network type can be one of four
> > possible values, and this "else if" will be always true anyway.
> > 
> > I changed your patch to this and added Fixes line:
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index ee390928511ae..256f81c5803ff 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -737,14 +737,11 @@ int ib_get_gids_from_rdma_hdr(const union rdma_network_hdr *hdr,
> >                 ipv6_addr_set_v4mapped(dst_saddr,
> >                                        (struct in6_addr *)dgid);
> >                 return 0;
> > -       } else if (net_type == RDMA_NETWORK_IPV6 ||
> > -                  net_type == RDMA_NETWORK_IB || net_type == RDMA_NETWORK_ROCE_V1) {
> > -               *dgid = hdr->ibgrh.dgid;
> > -               *sgid = hdr->ibgrh.sgid;
> > -               return 0;
> > -       } else {
> > -               return -EINVAL;
> >         }
> > +
> > +       *dgid = hdr->ibgrh.dgid;
> > +       *sgid = hdr->ibgrh.sgid;
> > +       return 0;
> >  }
> >  EXPORT_SYMBOL(ib_get_gids_from_rdma_hdr);
> 
> After some additional consideration, I'll keep your patch as is.
> 
> My change is technically correct, but it's risky since some drivers  
> use non‑conformant values.

I don't think it is that risky because it is what has been happening
all this time anyhow.

> > >  	} else if (net_type == RDMA_NETWORK_IPV6 ||
> > > -		   net_type == RDMA_NETWORK_IB || RDMA_NETWORK_ROCE_V1) {

That expression is always true

Conversely with the "correct" patch if we have a net type of
RDMA_NETWORK_IPV4 we now get an EINVAL that we didn't get before..

I guess we will see if this turns into a problem or not..

Jason

