Return-Path: <linux-rdma+bounces-12553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6EB16694
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 20:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0817AFBBA
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6332E1C5D;
	Wed, 30 Jul 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f4Xr/oHU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504F2DFF19
	for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901571; cv=none; b=jYDfwH/orHbqJG0YE885exG3PSFFwNO/x3xf3qHnMAbK2TH8CHFPOEFKf7szmdRtMchrow/4hbRoDJuMC+CAnnczg38A/z+LYAcDPpIU3jrY7D2oXfOqHhUPeabVvH7LoACKyuXlLpfrZAnFh4j/tFxSXVuJh1mXeNkhtZ/TIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901571; c=relaxed/simple;
	bh=tpddjbFeE3p3zUkTtUjkjP/V4559OzhrUQ2QMEp2efY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X70m8yyERKTYThuuu0YajUVQPR3z7eWIFeDjpdXaw8GXIFC1NHeSJE/3QujXOY3tPSTJznDHMVLt7vILU+uPiMWWkdWahSrbVRCQEj67to1TocOHVCjX+vPj+AjEuAUBSvT8Eh2VDC/95kFRPolO4UfzNISlPHaici+MP/nc8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f4Xr/oHU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af8ffa04463so19940766b.2
        for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753901567; x=1754506367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=slAyeWyqtgn0qVMjTiorxiyOrDOZnrQB9QTmFJ0CFeE=;
        b=f4Xr/oHUngMwu7U8SRiERLzaJEIRjJbFlzyoZkdQ1JvjGBD3xQp2kmlHBlleyooTyo
         MHJ6xtE5pBEFU9ef6oIyUzDTCQ8oN12puyIgNnSpSRalQejbFhtTEyLt0vYm5DKUchwi
         s/QgAi8Tjhn85DKfgenafLs6eF2eszuEZ9AFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901567; x=1754506367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slAyeWyqtgn0qVMjTiorxiyOrDOZnrQB9QTmFJ0CFeE=;
        b=FDzAYIS3GnoBythjaTqjKFKGJg8y3ueqAkmd7sROgTsbGK+ghNU0cGn2mNweRmZlkd
         mBdJwmIwwVzSZ+W06itaXMkduazsq6MIdtuDeI/0jn4FYrMbCu28/jfFtFT91VzLFaZt
         lkaqi1EZTK106n7g2Tyc/ro+16ZxfJ09BJUPTKhZ8aPtDTpOMsefRiVms350KMPUlCAy
         zdyOAX7PLoYcYtRoIKFW6Ypyks5nrULSlUmGPBv/S54E/gRv/5a9av4FhbiMRM7BeSCF
         0WSEeC2IsWLSYyM9G7IlIk2HYfxUkoOVnA1eR1FavGfSOo9RTBA0egdPmY8MDWwxZksw
         4t7w==
X-Forwarded-Encrypted: i=1; AJvYcCXedob8eBTXtaWn+B9GpaBTich2XwdADvr+UUTomAaCiAzWWMVEEkELb9RSOK2LfsDceFcEAKjEgpWO@vger.kernel.org
X-Gm-Message-State: AOJu0YyNz8LEbLIzOnRvbcI2N/14oHyDNXZ1LdQbq1eDGeQsGA5F38wI
	nqUcpCFhaoP+r+Le7MbEfMfig8bkAQm6VqHBVdmL+HTiM/gfuYZtW/1epC8W1EBZtlafH/Rl4Ld
	A8HG793E=
X-Gm-Gg: ASbGnct3CghL3g4mAUJM8Gh3Q2wca7wIHqzcC70VcUUJt1k57a+QtFG3O00iFtAXJ1T
	9NI4ntKmtcsAq1l9kwj5qXAJXaMQ7vg/b/j+npUdYlS//dcbjren6Iwc5mIFEXbb4GcQ2mX45BU
	0PdH491KPFn0X4stbLnQ+5bSkmGxZsLUnruu03+6rfyi+bfGOSBXnUN+nVp0ZX7jQkDx2JSMa6E
	lI3RhmUTbevlTarTjKs+PNby7dFYwPFTQl1jd6pqCbA72egXwYubUeHuj0ycJQbcEQnTHZfN4Nk
	eylY66jT0x9wyrPS6DfU5gebut6c2ZhBZHkWPDJfSQ4iMCJQ2HKM6Kdr4Cj/GY44IZnwPuZURJp
	lp1hwK4eU6LF3Gr3z+9TBIuiPqY9WPECv5ry5BUa+/nX2h+KGU8EeqGUdgpqKrtJkgG4VT6KzFn
	XJ7GhwiOI=
X-Google-Smtp-Source: AGHT+IGLC75ZY855hyzbTgE2cS2AsdulrSUYnT+37Wo84ernecdWgwpnRZyDJjZSG4p+O6oBpl4AtA==
X-Received: by 2002:a17:907:7f8c:b0:af6:ecd1:9e1f with SMTP id a640c23a62f3a-af8fd918fe0mr524436666b.29.1753901567543;
        Wed, 30 Jul 2025 11:52:47 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91302eabbsm23037066b.34.2025.07.30.11.52.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:52:45 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61571192c3aso83244a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 11:52:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtWrO9rge1EiWxXxfIJ3utLDi/+B8OkOpRNKwVIgdGFoVnx2W5uetuZtCDKpHy4zBc0FHjZF+D2E18@vger.kernel.org
X-Received: by 2002:a05:6402:2708:b0:612:dfdd:46fc with SMTP id
 4fb4d7f45d1cf-61586eecd21mr4741613a12.11.1753901564582; Wed, 30 Jul 2025
 11:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz> <CAHk-=wg70=mihHE3_Te=t1Fmvrh22bcEs8bvH3tDEXZd6q+4_g@mail.gmail.com>
 <20250730184724.GC89283@nvidia.com>
In-Reply-To: <20250730184724.GC89283@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 11:52:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_ukn6ESXTLKR9+g9hxVdop0sMe-Hu7AS8dinXGvYhJg@mail.gmail.com>
X-Gm-Features: Ac12FXzOpWstClby8n_gZ1wN_LSRv3bSws6YzxdQ9YiX4spwxDywE66Yp6AB2ZU
Message-ID: <CAHk-=wh_ukn6ESXTLKR9+g9hxVdop0sMe-Hu7AS8dinXGvYhJg@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.17
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	Bernard Metzler <bernard.metzler@linux.dev>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 11:47, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> I think it will be easiest for all if I send a one patch PR after you pick up
> the main RDMA PR in the next few days. siw is not so critical that we
> need to rush.

Ack, sounds good.

            Linus

