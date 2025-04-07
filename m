Return-Path: <linux-rdma+bounces-9218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8885DA7EBD1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 21:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B27A5DAB
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508232222DA;
	Mon,  7 Apr 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kKg7YfyT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9132222D0
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050474; cv=none; b=Upo414sSuPHBDHzNK0ZCMBv5HpaKBtPg2WENHqymM6VjMLBtbZFMnOnrKrFosmwGZ71L8r1xzqPd6r7Ka4KX6U9/sVUmJySmksdvHVqMmhsrcQFfmd7js++qc9zk6P9H3+gZL+8fqdKPloOCQri6JmrLzWWw+emfYdmOt3JzJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050474; c=relaxed/simple;
	bh=ILO2pDkDATVl5xlVItoRt9kbG9feenEnlD3ixktoGDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roBVnz8ebQVDGG0mZ0+D/mmM7UyvCHR0yro86b71w/mqbuIyHkfwmC9w3ejGMHl6cFWW1vnTVCru8ni/hGaepRJG7If+O9uy5H4MWu8x9dkpWa0nvd48pQexCY4Vr7DRzxoOzoRChYY7d1hRSmgF29RSjXDxutD8eEQCaJG+DcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kKg7YfyT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-477282401b3so48524331cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 07 Apr 2025 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744050472; x=1744655272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LipqWD1+mRA3ccfnYHF9wzUPGn6IorpYD8/e+3VH2Y0=;
        b=kKg7YfyTNF4cEGz6srxHV9pDdxGPsMs/PUwZwgqQzft9kT0gmBNCuMz6QxUTVApbE3
         W0+7HkgR06PVqkz0WcUq+BtjKduKbAiAD1wnLeYYCghkfJmnbgJWjUy8WW6p7bPpDHuG
         MNRW0dIwzbGPBNfUSFVhdYAHAK2Kv//4KRvwki3uInfKRj6C2jfpVUv1f68N1ELwPDU/
         HR5Y1x8GM+hCHRaAym9c+roWM6cTDS2oLN1F2judIvqtegI9JU70WnNtVXdj2Du7yIp4
         4RqTSpXHe6912HgNLMDn406Ic1iKU9GMV+EsjgcdWrFw85AnsMABvZmuc6hT2Fj0Cvbr
         sl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744050472; x=1744655272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LipqWD1+mRA3ccfnYHF9wzUPGn6IorpYD8/e+3VH2Y0=;
        b=U+wi+8Tkoj9WIx1dq+gPPO89hBwKmK9fUfehceXl/KJDs+1kCujqn4JA38JM+RkGzo
         lp7u9gtVSVvbMMHrEi1P9m9VXUHHtjkXi5jF0SAv71mROxG+HeLv7hBdGtbwlUM2yKj5
         BEZho2aQZXbLvRUnh9wACWisYqBQJNqtOXrRPU3YX58B8eKBAftJx1CZq5Oaw00gFAc2
         iMTqkqlfOL8n+QhmvBeAR5aCXdNP9ySlawuGLHLi+U5XcOb2isE3CpLV5v2jpzUcXBkq
         VVtq6sQdu0tsinePFdOfD9Xk6hl8K+bDwdRpTxyEtdDwn79InGsFFN39Cd6Z3IPCtfR9
         vYtA==
X-Forwarded-Encrypted: i=1; AJvYcCVbsTzWB+a4JQAkV+5oc3qW0RdsCdwcQETcUgowsRFSMNp/YE+8J3OhXrLwKdwLI61+sBsLKryh5wfP@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlJYrFj3Zz/4bTLpXaIMCK/FuWj/7DjmTmcnZi9Jnk1FusG0Y
	j0O+8Gy3AooREkRx/g7RZBrA3tuTNY8l71VpbqVT6TYPb0VrQmZhx5WRT7J9uqU=
X-Gm-Gg: ASbGncsiRn5SEXKHle8IJnjDiW7dlNUGZOuLVgO2CRpbD1jxGlLVD5A1U825909oP1l
	lJfQ7zDIKkKWr6hw/FGeudhSWT7/Q1odlGK/V71nhaF/vgaHh5hmnB3gJslKIVGvPbXCkGK8brJ
	cAxs1I0j8fzOVyb5RM4/HxO3Y+5Pg8Uim6y1KzQHZ4kSuwt49/Etdq5mg9gj7hvjJR7RMyxEoZN
	fyOoA78esXDiKphZMrZNofL/HJ6davK0+1NOA4/bF/hBpPUz/CgAyQECZw3dJQSdGQdjAt+tfAy
	utxy8Di9xTYNJE9GM4Fieu0LfqrsXQNAWmlu/nQKZL0x9MRyOS+KcnndM4uNzzkJ61lBKs2g7Z5
	0SKWpFR8yxFln1KrcFarVoTg=
X-Google-Smtp-Source: AGHT+IE/m8/Fdsf69NCfrjgfUS4jJCYgvOivQ5nUV/iyctDTmBmE5TpokwkCVsL1qlBP7xetviS9Og==
X-Received: by 2002:a05:622a:1211:b0:476:7018:9ae4 with SMTP id d75a77b69052e-47930fc2e7dmr153017351cf.16.1744050471657;
        Mon, 07 Apr 2025 11:27:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b0876easm63483561cf.34.2025.04.07.11.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:27:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u1rCI-00000007Qnx-1UJD;
	Mon, 07 Apr 2025 15:27:50 -0300
Date: Mon, 7 Apr 2025 15:27:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: use a struct group to avoid warning
Message-ID: <20250407182750.GA1727154@ziepe.ca>
References: <20250403144801.3779379-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144801.3779379-1-arnd@kernel.org>

On Thu, Apr 03, 2025 at 04:47:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On gcc-11 and earlier, the driver sometimes produces a warning
> for memset:
> 
> In file included from include/linux/string.h:392,
>                  from drivers/infiniband/hw/hfi1/mad.c:6:
> In function 'fortify_memset_chk',
>     inlined from '__subn_get_opa_hfi1_cong_log' at drivers/infiniband/hw/hfi1/mad.c:3873:2,
>     inlined from 'subn_get_opa_sma' at drivers/infiniband/hw/hfi1/mad.c:4114:9:
> include/linux/fortify-string.h:480:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]
>     __write_overflow_field(p_size_field, size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This seems to be a false positive, and I found no nice way to rewrite
> the code to avoid the warning, but adding a a struct group works.

Er.. so do we really want to fix it or just ignore this on gcc-11? Or
is there really a compile bug here and it is mis-generating the code?

The unneeded struct group seems ugly to me?

Jason

