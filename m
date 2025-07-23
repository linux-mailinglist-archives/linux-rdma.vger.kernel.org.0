Return-Path: <linux-rdma+bounces-12403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6928B0E95F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 05:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B561C2774B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 03:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700B6205AB6;
	Wed, 23 Jul 2025 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TdYtpK/j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2B2AE72
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242927; cv=none; b=spBM6ewfl6Ad8jzCuKkEQCSTtawDuaIB0muikhLcujsRMtxISXJ+oZtudS6EaCcLIONtnfwKleWJPLLad65gWMYdiIpAUFqrWXlCIcVA5xGBmF7HeQVMJjlvTPpNsJD+ISTqSYRFogkh3VET27cm2RtCO/NL+cZ0lj2s1wmJe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242927; c=relaxed/simple;
	bh=oQ+IyC0IUpkjFuIs/HtICSp+AEWKOXH6EW1IhNu7Ld8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d68hMAtHmOosryAQxgpHE1MDjKAzlts4bLjpD3F3UDfQycTU2gN+jcqD/MNhMMnUcnUf6bheo0bioEsSa1Rtg05Mg/boSV8MKsUOLkwR5OUZFEaleN0CBPbu3EU6zwG9C1V0fHcAigCRBIWPulo0Xmefjx+CQsWI4zxdtSF6n4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TdYtpK/j; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167b30so58011805ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jul 2025 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753242925; x=1753847725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YRcngTOmImRVZlU/kPn2yZwK6WlVIM67jiQ/OO/PWc=;
        b=TdYtpK/ja6XLYd9NQtf//5MQPb8UnwDsEeQi04MnwyhzkkHnxMkfrbhxZmiroOK8cA
         +bFf2kVmWcAGsXNrBrXkEVGlSkqqoFXNXWTSuQHMwdXygEViJ3knoZeFVP6q09z+Bkfc
         hoV+L49dtPDYqojW3nvgod68JLc9U2hyJDhDDHZTfZVBHfNeg/arjRrCaQBuuT0WO1Ro
         XAOOKIyB2w1ZvEVtuiUrXWG38ihnPS7GwnXA03jcyeAOzpxbKKqCTl0g3Lx7779kuPR9
         5ZBuAwX61zDnGnOfes1IBeOu7qMxDuV3lEXi6Q0qZ1rSQzNl8EG65RpfUwAZ65iuyQFu
         ohGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242925; x=1753847725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YRcngTOmImRVZlU/kPn2yZwK6WlVIM67jiQ/OO/PWc=;
        b=LbBFQlukMdntWSs84wYyCfaP9T0iCX+4ksmn0+yfEnqz1ZLMmalVNsKARfsUr4HvlP
         6NRTzQZ2/J1CaAIgEZ70wZB3wLYLOZXdScpd8aMvBgJZt7Uxe+1r1vpp9meeZGTxj6Ba
         VAS9+dPI5XMntsAwu4VorX7vzBAjzrv93RAqgjSAAqg2fqnA84WHxev8slaDt2OkVsTq
         dxesHdpyTZxoyVxlFPTFFZqnCrGSTLKsxtOPoapZNHiYi5tuqKIqHjS+J5M2Ht7P1UOS
         j0ju0LZTumzV9y6xpJzutbftxvmNaCoa9G1R7k0J90lei4LPuRpV4/WqIBbQFMo2C62O
         7Udg==
X-Forwarded-Encrypted: i=1; AJvYcCV+TXDPBRQHSV+xBV5GX0dQNRXkkw5MdxymB0JlebfMyXaU600VEl3EAp3p1qPPcD5CSGVYZg/N7GdV@vger.kernel.org
X-Gm-Message-State: AOJu0YwdR6mEX8p88qN91MyjWeyzlWe3MQm8ux0D7DNx0TQrfsAgfG+8
	1FQFYO+XA2y23Z4gbWbq+iu3vnNFB1nTZqs6GIcu9E439q1cv/TV4Z6nVKiPvIgWL1I=
X-Gm-Gg: ASbGncvsVwxXhhjwn+C+CYCA4BCrdMkaq83zufoKYXW5jJHNmCG5QlEEUqDs/N901It
	boXjBHghK2+0puSnOI3/yRn4QxusBWagt9D/iokBi2ThXegM0q1ZWsPJ7/PW0+SQbzI/g5RBQIa
	wB8taU8Dw6Mbpiz5MIDoJmgG82Ec0KSPGH1sFJHpR1x9UyE5jLbOVE4y7t93zFT7FKSzGvem27K
	M8P+rf2v2sySXhLeRRCaKYK3+LmT83+qH+8Vfwxhg6jM1DpSkQzYCl5FEanhYzZSxNOclQt8hrz
	be2WHaHmft64AB/xAwckYclJMuAK47vbFvtUmBG7tCizkfDkDY/Ra2nwTKWSBXkYkhuCdyEEYx6
	NZNqXelag4zef25CTUG9bA1otlggofp0G28AB/+lzk3XSug==
X-Google-Smtp-Source: AGHT+IFPdkG2Deg66tYuBh/VvcuRb6SoC/z/9RlnC+W1ttjW1jVLRuT1P2yag8dd/CsKREgJkG37KA==
X-Received: by 2002:a17:902:e747:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-23f98164db9mr18866095ad.3.1753242924942;
        Tue, 22 Jul 2025 20:55:24 -0700 (PDT)
Received: from ziepe.ca (S010670037e345dea.cg.shawcable.net. [68.146.128.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6efb69sm85898495ad.195.2025.07.22.20.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:55:23 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ueQZe-0003Gp-Gf;
	Wed, 23 Jul 2025 00:55:22 -0300
Date: Wed, 23 Jul 2025 00:55:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 4/5] RDMA/mlx5: Enable P2P DMA with fallback mechanism
Message-ID: <aIBdKhzft4umCGZO@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-5-ymaman@nvidia.com>
 <aH3mTZP7w8KnMLx1@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH3mTZP7w8KnMLx1@infradead.org>

On Mon, Jul 21, 2025 at 12:03:41AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 18, 2025 at 02:51:11PM +0300, Yonatan Maman wrote:
> > From: Yonatan Maman <Ymaman@Nvidia.com>
> > 
> > Add support for P2P for MLX5 NIC devices with automatic fallback to
> > standard DMA when P2P mapping fails.
> 
> That's now how the P2P API works.  You need to check the P2P availability
> higher up.

How do you mean?

This looks OKish to me, for ODP and HMM it has to check the P2P
availability on a page by page basis because every single page can be
a different origin device.

There isn't really a higher up here...

Jason

