Return-Path: <linux-rdma+bounces-15315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD26CF634D
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 02:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712BB3010D6C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C5329C48;
	Tue,  6 Jan 2026 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MhgfidOF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811832939C
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661323; cv=none; b=t6lE1KEYK53pN6LqQF/Or6aUSo4runF9+fbHIDWxUrJd0qsYktegLTxB7b7CcqIwGEasT7wvjd9EEfgwekgwm9CFxdeFbfeiZw7WCJiOaA6nTuN+7m1wLWIS5SwEe8C85HzIzkIQ2xG/d4ZKgBuzH1opE6g/ltpK4wOjxk0ABqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661323; c=relaxed/simple;
	bh=q+7bY+exb0qm+GHjS9hHzlxsx0dQmAC2AoJR8E36Qiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwC4Q5TAoeEGbhbHP/SU1OuffZkPVJU10Zw+FlL3zjhjkX8zpbx9aSyGaGY51EI+iT4PoZKo7jXs8N3rarRKWHGsInn2ZSyBNOMjwhSjFuk1HhRpe5yR6sk1g/mOU6hJj+bxlfzUKfMRVX8PHIedKKDXuv9WRrzINN2h/RnYTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MhgfidOF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c2c36c10dbso42765885a.2
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jan 2026 17:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767661321; x=1768266121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQzW4rirn4MIOmr+LUUhfG1dYc0MXYA9x0YMfT3n5fg=;
        b=MhgfidOF6Y11B0vk/fVLnaC+sY4qBeGmWyTieQfMHIo9Vb3UK6t5XCmdK5cOruhb/b
         dpak2YX2mjnuXltn61ISbsn12ViFWGlaI+YUNgdjsCuaso9m+48zWgi4Z8E9Tvri3fK3
         tOtzgy5xApUopKAogd4x7P3OsUJ5d2BGwRs9mK8gldAMrYTCzwWsTVzM6YmdwgkEQ+zY
         7M+te40td+VbfAgdkUjMCVSv7PZUKvBZI+SpCNxMEjmjYsuPkcD1uVM4UrjGoML/hee0
         PpVT7t9MUj4v7MUZaUzkgvvk5xZZXsAmN58h1ynY89wZ1PCcK+l1I3TdAq5nsSVe2OCc
         4mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661321; x=1768266121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQzW4rirn4MIOmr+LUUhfG1dYc0MXYA9x0YMfT3n5fg=;
        b=llqarbIFx7Wlzqt1L4M/ZzIvs73YvRbGPv/mLbjsFYA4w8fxmKomj0DsPxnXbo+pDj
         AHUENZ9RAYHeYE+VFUC6LF/GF6Pnwyw/wBCd3AY/SFy83+qDQPTHK7eYJ6OPZflr5PZg
         ZrCpSBW9MsG8g5SLkVNT77lvcsxutBytY3/Nj5iQZCCaYnnUa5CXoaw79L5M6L7yNNCv
         tx1qa2nYQPSeajuzeYNwsW5KOikWIhOYrimVGMkiLMrs3PthDAMNQdKDT6QPdlGI6Lyr
         +0P5Or/uDZm1BfOHxMNbYxfMCQSGVAIeOTklE+RVd6F7BLgml1H6b/UVfWf6OKL0bl6v
         cUqQ==
X-Gm-Message-State: AOJu0YwoI0ETKV/R402fZwkwxVhoPbGtTPtGOTTBdlHMSj2IaZFQcPwA
	ZCC4q4ITAm5AEOdrTy6Tz5z05wAU/j2Bj9BK3tFqP/MPErahr2Lr3N60YqebD4p6Z5k=
X-Gm-Gg: AY/fxX7w4lvNMG2rYkHlwQ9K8wedYYGU+HUollfbsJ02wOE1CKKwAxpdXOOUznd7Z4F
	fq888ewqJ7CWuzEX4bWkfplMje7fVg6+sM4rsOVtWVzkyd4cxzacYfi/zidVzYsogDKq5WGQRNL
	BkeblANAMRxIvIhLSQc6UgdFHdQETl0SW3s/qXgqVab4pj8PkB0F2UXhpdHRXq3C8iWxVNCbnes
	cov5UZlzrCSLSKoZqUbTvChWlEZgY94cL+CpZTbdfMET+TeqVzRBVHabaHMp0j4a0GY3/WkwdYb
	w3Bcq5w0+a44rKo3/EopE8/B2ZVeaSCo7UOepVBDseJnyzu/b2WeEY0ldJy6n8dvK208143MhVH
	1ylHigr67DayXszL1fUb8f+iwREBj+sqAN/GQN7t9xhw4YPaKyEjpcIpCrgDIpVrdsw51huuGMz
	GrjbGk2JUert32Q8KQKOe69jpwUvUTQH2F1LxZCAya6e9vvPQgJr+8r5zFXpddoKpC2Og=
X-Google-Smtp-Source: AGHT+IH2ONeQ3y76tda+WNWC0/pCf+cOd5Rvznrfxc67P/1fs1W8W9KaGHT4A4tcFYmOHNO4nGV/2w==
X-Received: by 2002:a05:620a:7085:b0:8b2:e533:66f7 with SMTP id af79cd13be357-8c37eb353b4mr197395585a.10.1767661321015;
        Mon, 05 Jan 2026 17:02:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a9a19sm66438685a.1.2026.01.05.17.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:02:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvSR-00000001EZP-3HUW;
	Mon, 05 Jan 2026 21:01:59 -0400
Date: Mon, 5 Jan 2026 21:01:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com, leon@kernel.org,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes !=
 PAGE_SIZE
Message-ID: <20260106010159.GN125261@ziepe.ca>
References: <20251226095237.3047496-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226095237.3047496-1-lizhijian@fujitsu.com>

On Fri, Dec 26, 2025 at 05:52:37PM +0800, Li Zhijian wrote:
> The current implementation incorrectly handles memory regions (MRs) with
> page sizes different from the system PAGE_SIZE. The core issue is that
> rxe_set_page() is called with mr->page_size step increments, but the
> page_list stores individual struct page pointers, each representing
> PAGE_SIZE of memory.
> 
> Problem scenarios with concrete examples:
> 
> 1. mr->page_size > PAGE_SIZE (e.g., 64K MR with 4K system pages):

Why does RXE even have mr->page_size at all?

Real HW has this value to optimize for large page sizes, but I'm not
sure we really need this for RXE..

Jason

