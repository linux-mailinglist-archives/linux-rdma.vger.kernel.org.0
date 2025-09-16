Return-Path: <linux-rdma+bounces-13392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE569B58EAB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 08:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622B91BC2296
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 06:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E952DF137;
	Tue, 16 Sep 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeIZB9Ri"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C852C0268
	for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005556; cv=none; b=Bry11M89VbYASMrDXnR7SeAO/xzaEunZbJx/rebok9lhNGjXKKBo1nlIzXvE8V+454xF1RCdlQDPY4dxTBfWMegmqD5vFvU7jIsBL0dAHkbwMVqVu8U0Lf94FKzlKPpQ55qqgo8V24HQXrHdxzo1Dy+RnBb16hhnzDTkUST8HAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005556; c=relaxed/simple;
	bh=3vn6lJfJBg5VJIyumtH1gy9abhqa5dlapNdbnzumH/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E++QCG0Ll62neTNlAY9+dPUXo8b+MfyioKltBycxJZq5VhiH9vJBX6J2n8/UGREsXbiVFzIKXDKbSVwJ1BdB+8BKDrZIrTQub/s7JN9jyu+5bTqHK4mrpykYCOE2l0dEVsrFIbrwZwKqS/YYzK6FbIjQNbXOAjLFW/Qt+wviidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeIZB9Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39501C4CEEB;
	Tue, 16 Sep 2025 06:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758005555;
	bh=3vn6lJfJBg5VJIyumtH1gy9abhqa5dlapNdbnzumH/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeIZB9RinVvUUk4tthBlROjuW9Qfalk3af96qhCp86VeNZ8GPxtcOJlYlfQ/oCRwJ
	 neiBpIDO2uR3+flteMeZqq0SRjMDHTKpXYadG6RDPsNkJml2gg91EVw6ZjhE8/Tc6M
	 irulqc/NT6DW1aM6pAHANFf/vslJCeI9HUAUeWM1iSdSIo4CDGI+39KU/AObNJX8a1
	 7YBvZPR317Z+S3x2CDnnD59ZdsKL4KwQYOVjgqPE3/4fs9EfwBf+yUvdItgy1YgllO
	 Rx3+mhW6A5D1RN76dW76RRglsZ8ca1PD2zbiq63qMkLgmXV/Jq70owdc1mlwdk01tg
	 dgHCLNKSFWjnQ==
Date: Tue, 16 Sep 2025 09:52:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yi Liu <asatsuyu.liu@gmail.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [BUG] libibverbs: ibv_create_qp crashes when recv_cq=NULL
 (expected EINVAL)
Message-ID: <20250916065231.GA82444@unreal>
References: <CANQ=Xi0iVdA=KR89vEfJQjVzkyRoMhmNm4er8iSwNum8oVuGhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQ=Xi0iVdA=KR89vEfJQjVzkyRoMhmNm4er8iSwNum8oVuGhA@mail.gmail.com>

On Mon, Sep 15, 2025 at 11:44:07AM +0800, Yi Liu wrote:
> Hi RDMA maintainers,
> 
> I would like to report a robustness issue in libibverbs (rdma-core).
> 
> **Environment:**
> - Distro: Ubuntu 22.04 (kernel 6.8.0-65-generic)
> - rdma-core version: 39.0-1
> - libibverbs version: 39.0-1 (package: libibverbs1:amd64)
> - Provider: rxe
> - Reproduced with both gdb and ASan
> 
> **Problem description:**
> When calling `ibv_create_qp()` with `attr.recv_cq = NULL` (while
> qp_type=IBV_QPT_RC),
> the process crashes inside `ibv_icmd_create_qp()` due to an unconditional
> dereference of `attr_ex->recv_cq->handle`.
> Instead of returning `-1` with `errno = EINVAL`, libibverbs causes a
> segmentation fault.

Garbage as an input -> garbage as an output.
It is perfectly valid to crash application if wrong input was provided
to the library.

<...>

> 
> **Security consideration**:
> This is primarily a robustness bug. In environments where applications may be
> driven by untrusted inputs (e.g. fuzzing frameworks, multi-tenant clusters),
> it could be considered a denial-of-service vulnerability.
> Please advise whether this should be treated as CVE-worthy or just a
> robustness fix.

No, there is nothing CVE related here. It is not even a bug.

Thanks

> 
> Thanks for your attention!
> 
> Best regards,
> 
> Yi Liu
> 

