Return-Path: <linux-rdma+bounces-9678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5EA98036
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 09:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F94C3AB467
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE3267B86;
	Wed, 23 Apr 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw0+Ibgt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD618DF9D;
	Wed, 23 Apr 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392447; cv=none; b=MZvwxxSVWbNXpAbnSpjTr5YbbL7IaA4+darG6wh7A/2qSLxoWQIALlZoatqYljAJ/bx5EUjlNOKF2VZLKsC15nt+iH9vMqyPYR+qlCDByiSzOGplOCN8XWjfPYtvAIxpQ0WGPeoAaHzVjcgQDWH4RCeWjKxaBvFELryl2hCnWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392447; c=relaxed/simple;
	bh=KIfvJQD53c6nWgTnd4tcz30y/8qZbxMV4jtzwuN6CUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD8CJN/XTWWkmM5RQDUxNRoc0X1qhQtK3dH7/NUe/gTjxYnx472BkVHbGrrWK2M6GuoTGVC40Ri9ZRdfJggMaE8rSJEaserDU57zb+pT4Sp0wE8LvtXu411H5vd6tIo00tX66cl47ZAeNtmkIXjLSPZ5BjE2IP6T1xHSEjFBpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw0+Ibgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE2DC4CEEE;
	Wed, 23 Apr 2025 07:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745392446;
	bh=KIfvJQD53c6nWgTnd4tcz30y/8qZbxMV4jtzwuN6CUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qw0+IbgtO+DuA8yiqQomvZg1nOczYvaclTGA6cVvFK4cRWpjONcwPQ1ce+4LtUeBA
	 tD3mwP0l3EdXDEMV+Yus6/+WA3CITbazHVHaSnWVt+ytZlfj6XuV7dQUk02kBeTa2b
	 R14JeAHNCu3AaI1MD9NL5P7+9CXLToluEHoO7pQm8tdPSE5s1Ex28Oz9BXBwef+knW
	 dQNfgRWV89M3BeP9SSCNJ0B4oIKX8sa7gZumnCDoE1L/TMgftB9CXPQtQ0B9s1/o0N
	 d5PbqEcmkyp7OG+Vaod8+RdboSMiAiTuDmPR/pajTKn+9rHjTevQnD7eDfYXHpyd90
	 WywPsQutgvxUQ==
Date: Wed, 23 Apr 2025 10:14:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: l1138897701 <l1138897701@163.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, luoqing@kylinos.cn,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] rdma: infiniband: Added __alloc_cq request value
 Return value non-zero value determination
Message-ID: <20250423071401.GG48485@unreal>
References: <20250407093341.3245344-1-l1138897701@163.com>
 <20250407162559.GA1562048@ziepe.ca>
 <7afc834e.5498.1965c20f9f0.Coremail.l1138897701@163.com>
 <20250422115853.GF48485@unreal>
 <2ac5915f.14aa.196604a64b6.Coremail.l1138897701@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac5915f.14aa.196604a64b6.Coremail.l1138897701@163.com>

On Wed, Apr 23, 2025 at 09:36:50AM +0800, l1138897701 wrote:
> 
> 
> 
> Thank you for your reply. 
> 
> 
> 
> 
> The ultimate goal of this patch is to confirm that if there are design flaws in the outbox driver, 
> 
> when compiling and installing it in the kernel, I personally consider that the kernel should issue a warning or report an error instead of directly panicking. 
> 
> 
> 
> 
> It is worth considering whether the kernel needs such a fault-proofing mechanism

Kernel code doesn't have such protections by design. Panic is a perfect
thing to teach users don't use out-of-tree broken modules.

Thanks

