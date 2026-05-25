Return-Path: <linux-rdma+bounces-21233-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDo4HCFSFGryMQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21233-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 15:44:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 702975CB516
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 15:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3696530074C3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154E387566;
	Mon, 25 May 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BK1QOEnU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E4386C39
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716599; cv=none; b=m4Y1lDYhLvb0LnAvG/G3LU+hjWQA3zfGh9pIXPX5yTUnCz5MH6laKe0KznehZwGIPuwavcR9nJzeGTQaUAFkOnUSxcS7pB9/TNpfN6CAquP8FvKI6RkW1Bv5LwbDWsGV8v+119UK2FVrV7h8UjzdXNRrqIKsM4eG6WSyLcq8iRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716599; c=relaxed/simple;
	bh=rX5ujaAoQWVMDzAqpuns3YL5+t9b3MSp0k3Vn18HmDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERUjO6waGqO1dOVphgSvMiTj7KkyZxDIjq+jTyNii/1LzHPZX7KrLrbIH2XIHdVZ9LZQz94WrQt7tZDGEl/zBRoIDpk5JUIy6V9bcHmMUUag2dICDX/+QqwWWcCaFhqSMXrDQ0Njc4KWnBLQetw/LcyXWqoFqZUCvZXHRaSHJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BK1QOEnU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516df90c167so23828051cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779716596; x=1780321396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qbww/jwqpcTz4eQTSyik03DnGb34+sYwBbk3jakvlU=;
        b=BK1QOEnUdDCW6W7P+IIQjbnpym/hmuGj6DZK+pP2Qqc4F+smR9teys3SozYf0h2Jrs
         O5stmLBFyojeQbTnkfbul1/zfx3q22q2fZAAEVQwW/afZbjlu/fBmHjBOJqBkaUkG5TT
         oP66h/WO/R/FA1xrsMX1QKzmxX7NEZbrBVG+ymP6mVh+2CPf+pEN/WISd1E+IO8K+Y5L
         PEA2DZ61l23Z0MtbbExHzUoHztgjpkPgij1RGeyvXyFM0vuzQTRN6jxBWTYSYKPHYqIa
         EZz/qaPOkdnk5ACNHjR9yLKvtnvehKEWkCTYNmqKCYdTOl3uD64w0jfiDF/9fL/gRvge
         Bvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779716596; x=1780321396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Qbww/jwqpcTz4eQTSyik03DnGb34+sYwBbk3jakvlU=;
        b=Hja770XxscBOmKc1IFpKBhnrdRX9+DRqagpOib0luwXfLus8Ux2o8nKzFt1MYkiyJo
         8PcuGDS2yuy6InxB5rFez0t5PO6mVbMT0DwWk8BIeBKYVSwbYGNWyJ/NtIk9BlHEpj5w
         DXgvomQtxmOnTM+4QRol974/6YsgKay4QPsumwtz2HWbmuSGes33pw7a5r8S5RBgL8ZS
         GOXAlfsKrAjgnExb0LPTX9VlNuOCvuy7dmaLNGrLlYIALIHi2yb72MU7n3KO0wHTzOYj
         EZ4FPJWyIfHU1zf5PDpwHkDdf1deCVBzirbl851EvCEoxY1xwdtekRMRHOLixepc+odW
         dFZw==
X-Forwarded-Encrypted: i=1; AFNElJ/IJx3AjxNdNgK4HHm7RGTKFarcq7BiNt1ffKYOEMyb8j39odCEAliDGgnTH+B5fPpBagfU/9q7SP6W@vger.kernel.org
X-Gm-Message-State: AOJu0YyrfJiMqY5ajYUNqZyNcxHI5pZbYfYots0uuNiTudwDIo9YunxK
	u3zlauRc8hSoswXOH1SRJeh1CzahxFDVkCXWsdNSWz6rDlDchSjJlKSFWpAsTHLS6v+9/tqBJHR
	X2sEh
X-Gm-Gg: Acq92OFcPrCXumZWAjWsVYUFfpf5sbEF6aCkS25S9CW8nTRFkQ9UnH8Sdr2vIZJ+7zF
	3V/Fdm9hpbF2jYXDQKpRlS9eprZ92WKrCxa8W4Hs2zVcAeVOr+DPQYsPKv/7Dpos9U/0OjT7yVb
	1hFd2tSOqUGakCz6DakLEGaHJk0IGWooeN2vweSA9/QhZ4JF96PhIw+IBCFBrNPRylLlJIHO0y/
	xVxT5aH8vp7ZvCWqu5/lTb1HXwPZQRjl/xPpjSQs63ZPF5OOU+PZTe4dkiYkegQce3Se7qXGxPZ
	yO9IUg/33fs3KfG+SgsJHHUCNTfsXdMIx2re7A7+vh4F50q9XJ8vp42fBiI4mM4PwOI2weG1AFK
	zXVqOWAiDvmPVUrAtNUbesmQuJsu2+6H54C1AhRb9mwbvuBsfvguAxaL7OCh9lVi97jGQ5dvg5i
	0fgqPA7Gt2jwBmRwzQN1YxBQMAGX6dY1d4PPYschDho9pgopN1bBp7QYO44qxFA/S/cFhwdMznv
	BSMiw==
X-Received: by 2002:ac8:594e:0:b0:50f:1b95:675a with SMTP id d75a77b69052e-516d566e649mr166000971cf.4.1779716596256;
        Mon, 25 May 2026 06:43:16 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d895ed9esm94690781cf.0.2026.05.25.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 06:43:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wRVaM-0000000ADBd-2lhB;
	Mon, 25 May 2026 10:43:14 -0300
Date: Mon, 25 May 2026 10:43:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cuitao@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH rdma-next 0/5] cgroup/rdma: add per-type resource
 accounting for QP, MR and MR memory
Message-ID: <20260525134314.GI7702@ziepe.ca>
References: <20260525055506.2002985-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525055506.2002985-1-cuitao@kylinos.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-21233-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 702975CB516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:55:01PM +0800, Tao Cui wrote:
> Currently the RDMA cgroup only tracks two aggregate counters:
> hca_handle and hca_object.  This is too coarse for real-world
> deployment: a tenant can exhaust all HCA objects by creating nothing
> but QPs, while the administrator has no way to impose separate limits
> on QP count, MR count, or the cumulative memory registered through
> MRs.

This was a deliberate choice.

>   - qp      - Queue Pair count
>   - mr      - Memory Region count
>   - mr_mem  - Cumulative MR memory size in bytes

I would agree to mr_mem as a reasonable extension, but not splitting
out objects to finer grains. There are endless objects we don't want a
100 different cgroup knobs, it is not usable.

Jason

