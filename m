Return-Path: <linux-rdma+bounces-7181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE883A19502
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856BA1882DCA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C832213E90;
	Wed, 22 Jan 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JKPKMJS5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE671213E7E
	for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559368; cv=none; b=hwKjZW5obPRi/eMYWH1cAM9JcroscAYYfChNgRcsyvrjxmS3z826l5icByQIbvxIgZSItopr1VmPdLoM6+zIg+rtnLQbFOt0mjp5eC8z9KxOD/i8HiGw5Cm1mgLh742jLXJM7TM3+JKcR3k7Kxqnsc7NvOn2T0rNAdztlOX9588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559368; c=relaxed/simple;
	bh=z4fTFVat/6yekFJqNKyRvRhN5h/Gtf22bz3dQZcoUTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/ydgBBBPfA0E0QifpD/U2hvBHjIbPtl/7jCDtVsfdbXRjFJFAQIUYdvG9BTjkDR9FVf5Gd9p/ZaUdOhxLGc66m0R8Ccr200dcEYmuGd06Q9RGbVmJct/MEMk09PJjGL9TT6o0LiZJEscI7pN0Ld4EsUPilzPN2nmykuVCcmkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JKPKMJS5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467b74a1754so86629731cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737559364; x=1738164164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QKgIHgNdjY9PT6rR2QIaW1seZe7JAkMo+tLUQykm6NA=;
        b=JKPKMJS5FG6Sb/YNcxQSmPV3hQOW+wwRwz7TySpN2gECd2HIqDIyQgIAOhhPmvCGjS
         ip7g18bWC02hPXOgSIhptVIGr3/tSxdrklxJlXu+sdmz26c7FILVUVapsNnd53g+xO0g
         d6BHR913WjVKFr0e5xYexhamfcGl8JC/soUEMTojDSqA2vlDNmdRKDZsD+17SlCtaeKx
         iu/PCdLVHS1bxHIW4TKEYOVZBW+XZsXrT0ERHQdc+aNp4J+Bf4AT1sw1BEQPJdH1AgDD
         DqtSBQJQMEU3g6mpgnmletEQGlD471K9cAyZEOtdQfgde3q//2mbFKpkOwi8fathVvHb
         UTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737559364; x=1738164164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKgIHgNdjY9PT6rR2QIaW1seZe7JAkMo+tLUQykm6NA=;
        b=lD0+Zx4RyZ+7hfdfNYwOiRuvYdTL+qXmTvFaM8D8IQ0yUvANXb3Z2/FJTjup2rg9nG
         arKiW2oiRmyxZ421jcH3aJkX+Usj1uryc0WIlG9x+3BViQWnvc3k9FRFOn9UAY9TLtrh
         m9jyIYaUtG6w/whQPBzacP5Nu34hEdChfzpAoRtNtSYkifjJF3OrOVJxvNW1SRV2Gxfx
         IrLxm5n96pKB/7BmLEB+2tyTIbBV0lj0HNhCSkdsimVGub95LagnN7hgm6mepJchoBeC
         z7iXMtdpsVNAocQY1XzE3iUvLOhnRFFidaPEdydyonzn2yrGzqil5EFR4gQBcagZI2hN
         aTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpd8h4dfVDt91raDkJBdg8EHaqbKcx65kbHyf2y3VNevaHXjhgnhpPuxrXzIKlgP6++6+OproS+Bz0@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUGZiPmprLtvs0TdyXl1kTc6b6qrUNkw6iV6kfIkaW+0XSkxf
	CjI01UfwLmsPJcUYL+vkv58K4JwpfmGORz6UAhf6YTXc8VqBvkkvxm7maBfEQrU=
X-Gm-Gg: ASbGnctYTSv87d0ZlW2nkaaqpV32ddHtudCGfgfJoH65l2ussyIObf7+BfTcxVRLaen
	O2IcdaL+c9DtaRPfksoTnUy2gAs5ClcKo383r6934ggTzneakbIWCFxvGdZ4lh8wkL9xLhoEX9l
	fOPNdJFlehK7MfTSUHviYoSE2fVZH4wIAQZh6mR71yuF4RHrdt/sbEi24DwQQ53xIRxyTK7kIME
	H+BihLw/iWvfj0ZAfsv3mW3Q3rJOvBZY44HoPCz6yeS0LB3AUNHK/ktpsGFE5ZYdOe0g81GS8fn
	bi0XGdIzBRAbbglDMQ2FlNEJQd6fDKrwvf8vL6aEB9k=
X-Google-Smtp-Source: AGHT+IHwaP+qRTY9nPW03G9BtPAV33wbWWyJ0/KUyS0oXJPgvOQ7NerEIzBAr+Ymbc4O/ZrA0Mt9vw==
X-Received: by 2002:a05:622a:1aaa:b0:464:af64:a90a with SMTP id d75a77b69052e-46e12ab6927mr321163631cf.23.1737559364545;
        Wed, 22 Jan 2025 07:22:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102fb3casm65676791cf.21.2025.01.22.07.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:22:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tacZ1-00000003pin-1SEP;
	Wed, 22 Jan 2025 11:22:43 -0400
Date: Wed, 22 Jan 2025 11:22:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: andrew.gospodarek@broadcom.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
Message-ID: <20250122152243.GU674319@ziepe.ca>
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
 <20250120164000.GO674319@ziepe.ca>
 <CA+sbYW2oDbrodgYdzOgUiSv6v+8aBcACLbfrXM+0NZGmHquUFw@mail.gmail.com>
 <20250121153127.GQ674319@ziepe.ca>
 <CA+sbYW21WJsFECZ9tWDBqZy_p1C+H2Z2chOJcv93JnJ6TdzJFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW21WJsFECZ9tWDBqZy_p1C+H2Z2chOJcv93JnJ6TdzJFA@mail.gmail.com>

On Wed, Jan 22, 2025 at 01:39:16PM +0530, Selvin Xavier wrote:
> On Tue, Jan 21, 2025 at 9:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jan 21, 2025 at 04:10:33PM +0530, Selvin Xavier wrote:
> > > On Mon, Jan 20, 2025 at 10:10 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Sun, Jan 19, 2025 at 07:45:35AM -0800, Selvin Xavier wrote:
> > > > > Implements routines to set and get different settings  of
> > > > > the congestion control. This will enable the users to modify
> > > > > the settings according to their network.
> > > >
> > > > Should something like this be in debugfs though?
> > > Since these are Broadcom specific parameters, i thought its better to
> > > be under debugfs. Also I took the reference of a similar
> > > implementation in mlx5.
> >
> > debugfs is disabled in a lot of deployments, it is a big part of why
> > we are doing fwctl. If you know it works for you cases, debugfs is
> > pretty open ended..
> The main use case for this debugfs support is for evaluation customers and
> the tuning for their network. So debugfs should be okay.

In my experience it makes no difference, if the customer is using
secure boot then they are always using secure boot expect in small lab
systems perhaps.

Are you certain this is useful not just "should be okay" ?

Jason

