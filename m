Return-Path: <linux-rdma+bounces-7719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5791DA33F56
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 13:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207F37A1BA8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C6221566;
	Thu, 13 Feb 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHyowcVK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD5221541;
	Thu, 13 Feb 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450569; cv=none; b=p+EuXfKo5K2TZA1jHuQi01IIGLT8VhkAqCi1uQ6Du6fFO01W5R2ysYj7hnEV17gDSnp9RvxQ/CEPz76DB1gobIMLl2/FBvS2IRHnETSdipgjmDnPqJ0skTVTZeITPDmI7vV3CZng83K7BaCS9XGHvOGpKmpLxYpKVHd06PEURCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450569; c=relaxed/simple;
	bh=0UOqsPNSd8QjfqnZ0I94+XzPbovVP5EH7nkOfN1zMkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o7AfQCU2qu4FkzFR+mm+8YEruFzshaYaRB+XGEIgrtGHcikkveygnkB0QPYhtXAgdNTBIpBLEqx4l0+NGD7iPlLttRfzQ5xplv+hEpJSGjVq7XFYDepuZp9hVzacrGIB9nRBBQuSwfspSHehGJxC3GsMkm58gnxEpirtZteFFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHyowcVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C58DC4CED1;
	Thu, 13 Feb 2025 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739450568;
	bh=0UOqsPNSd8QjfqnZ0I94+XzPbovVP5EH7nkOfN1zMkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hHyowcVK3rsNgbELPxMyHgzf0PZ6BpIryi4EhcvkP7KT5OxwdNiPvcM+YylU3Cg5/
	 KTH9vc2D/sWaxJeMbs8OsmtlLC8karHtsPKnElKeUACEkHdYyJ9M3UrYsyd9+4P0dU
	 O6Zl87MC81Y94Tx706wbygX7pAJDEm9WV+lFcfMCRBlCHwjpuYGf1Aifuf6kOva+tF
	 AI/JH2mDx5yTAzJ2qElEI9BdIT3zG4DLXYXkwnCcaC6k2CpPsOT/DsqGiswzernlxP
	 h8e6X67FfJHjWPcMofxyZiUWJ3AlBk3DWPTURehRbJV3+ea2AC8Cd0Z5UgUTjmeEc5
	 v4yne9tT6EhSw==
From: Leon Romanovsky <leon@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250207040816.69163-1-ebiggers@kernel.org>
References: <20250207040816.69163-1-ebiggers@kernel.org>
Subject: Re: [PATCH v3] RDMA/irdma: switch to using the crc32c library
Message-Id: <173945056532.293287.14692956092199432239.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 07:42:45 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 06 Feb 2025 20:08:16 -0800, Eric Biggers wrote:
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Note that for crc32c the equivalent of crypto_shash_digest() is
> cpu_to_le32(~crc32c(~0, ...)), considering that crypto_shash_digest()
> had before and inversions as well as a cpu_to_le32() built-in.  This
> means that this driver is using u32 for fixed-endian types; this patch
> does not try to fix that but rather just keep the exact same behavior.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: switch to using the crc32c library
      https://git.kernel.org/rdma/rdma/c/7fed5876df3d02

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


