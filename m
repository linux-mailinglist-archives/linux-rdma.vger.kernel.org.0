Return-Path: <linux-rdma+bounces-15530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C697ED1A9F4
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1AD3302C139
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FD350293;
	Tue, 13 Jan 2026 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OMV1SKEI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6634FF75
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325299; cv=none; b=nU/n7GaVfE14ehAZm3iRCqqI/EmwEYc8WDQobwCXkSw7SJlCvYihR+b1EFFHUAEA3leCDMvWzolT3V7KgEJy3ixmclhJJJhCB/riu7JUbOKkD/pPaAHreC7ClMAT34s+9H7mDa7t2768EEkTn4N59IbPc1SiGDzRq353GbmBJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325299; c=relaxed/simple;
	bh=hCRtjQOhDlzRy2y0/fh5IruV7UsvNqwz2v/FSxquP8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqNoPCEWYoW4z+maygY+caHioSKT53qi9TwTx/QK/DgawLLLRhGYXOEIVeZKa9tVEvMDR6v/3DAVa7WDV3VTguIaQdDzf4pKJKz7MTjHkH02YLscTp483nQvbngtUs9Piu6oWowpxnBTBwpOmoVeziA1ongyfdARqiuKpLGCZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OMV1SKEI; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-890228ed342so81323516d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768325295; x=1768930095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCRtjQOhDlzRy2y0/fh5IruV7UsvNqwz2v/FSxquP8U=;
        b=OMV1SKEI1bJRUJSYdeYy02CFp4RzIP61BBGS3WH9dpKtD7RbBanc1BBwZ0IeJKzYLj
         6QnBmfNveilxklddOWmmhr2pq5RcpBlbjogGxpSupqtRWYA1xwbCZv3s9ORbWiz4FzDQ
         RKGEscBsAKdCqQRCZldIHSrvFVjdqvusCh8sIooSFmkQdyl01UX6CG8p+YjQHQFBuojc
         TpWYOAzDpYtMdxG1+osEDK/LI7KS3yGdtJAQczCq0R29VeRFDL/gjGJdC8ZTeRKNTuca
         AvVULKsFQrCsQe7lrRGsZArWxic+/P9yvhRrM+zdc0F4Es2ZGx2oiVHLMGiBmVM5j3g4
         TGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325295; x=1768930095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCRtjQOhDlzRy2y0/fh5IruV7UsvNqwz2v/FSxquP8U=;
        b=CmnPYCPt2pwUiOXbzNGGe2geAYN8qhSep0JYSC4hwtyjmBsg5ACqzAZ3tLkoEPIRLi
         8YHPRMSbuajghJSmifSA3r1TlFUopC2r8VhjzAbMPZy+Zh7ykrKR5VDFP0joOGBLIfo5
         lo6bNYpL5/8V+JUVETrNWzoZzBQ/lXmWwbtN+ZDaY4DduFpZ768qLAuhnqpALMgDe+0y
         jg7AKU59TG+lzjdcLkRxTaKQqCj3yfwXumuiulPbZsSQxGioXMe/fsfmqGorBYIGyiut
         eNTerZXw9g2sMczzKKU4Ap4wp306dwRm/BfN2TZGHrO+8ihYElTzI1aoV98Ts9AF5DeI
         GZAw==
X-Forwarded-Encrypted: i=1; AJvYcCVjYZC4t2MqCzOSCN+BfHEUZz03iQCcm9YWn1a+PgMFTGNvv+on5J5DCfEUQMuMSkrjW4Xj68OnU4qu@vger.kernel.org
X-Gm-Message-State: AOJu0YyKh/A017jmU6akm3NSpEPPFhfB+P7NMWgaaIrcUWvZOUhpJjac
	8aPWMyaQCrPNSB9ShOKUUGTGolTVgu8XyEfGzkflMPFdw1qdQy8JbvmvEfHhM2bbAkQ1PfUt3WQ
	cdxXy
X-Gm-Gg: AY/fxX5pkcEWvfjDo2+my4UgpYYrrKYN+TGmRUjhBMdYTYevtdZfFOvUq0FUp9pBhl9
	CF4R83aM+7NOQKH8DqN+KJwqoQheHxgZFqQgZ/+OzB/Q9AgWWoNLphgSY1LRdde87HdxtNbr/Aj
	VAAiD7JZbTH1/6fvhPmHKCTaByMWl07LMu6ppY1QNVWtGu9RiJSlwCaybG+zLq8AGYSRES3bide
	MezQj7zhmQN+l1p9FGwRMH7ggDtI85LaHjUYB90rC5VaDaVbMuJiYcc0oA74p5MDo9vopfWOv3r
	qM1XrWxRP6wBw/+Ruw59J6yCudFFOXnaiINb/KqMx9crd8pkJYs8gmuUitkS3aCwjogPbwnlQgR
	i1uGyuanyRxpe77rUA/qQTG9ibk65LQoXM7D0xZetE4sv8LCbff9S2W8hcMnEaXkf08BEvgC7IW
	o1jBAyA6k/1zVWHXbGeWpLrg/Ah4fx2jZ7grmhV9HGIwJ+aJEyKY1+1uQTuzjfLRozWFc=
X-Google-Smtp-Source: AGHT+IEwMFtRiioeN2Uu86K4fQG5fS6ej++DNU1IN2xN11q+H1PJWycQz/M4+7h5g4VTEBxtneZxWg==
X-Received: by 2002:a0c:f40f:0:b0:882:6d42:53a7 with SMTP id 6a1803df08f44-890842dc0ffmr298533606d6.40.1768325294915;
        Tue, 13 Jan 2026 09:28:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2aa5sm162770726d6.19.2026.01.13.09.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:28:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfiBh-00000003w7t-447T;
	Tue, 13 Jan 2026 13:28:13 -0400
Date: Tue, 13 Jan 2026 13:28:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260113172813.GS745888@ziepe.ca>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com>
 <20260109193756.GP545276@ziepe.ca>
 <CAHHeUGWH6hujdXP6OheW-fFLLJ5WGjiJgcP41MYHC6sBZE+xbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGWH6hujdXP6OheW-fFLLJ5WGjiJgcP41MYHC6sBZE+xbQ@mail.gmail.com>

On Tue, Jan 13, 2026 at 10:45:22PM +0530, Sriharsha Basavapatna wrote:
> > So why doesn't bnxt_qplib_destroy_cq() do the umem release and
> > req_put_nq?
> Because bnxt_qplib_destroy_cq() deals with only the FW side and the
> wrapper function bnxt_re_dv_create_qplib_cq() calls umem_get() and
> get_nq().

So make a wrapper function for destroy too..

Jason

