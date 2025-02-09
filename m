Return-Path: <linux-rdma+bounces-7585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15446A2DBC4
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1767C7A2A7A
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719711494A9;
	Sun,  9 Feb 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPTm3aQ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F09146D6A;
	Sun,  9 Feb 2025 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739092846; cv=none; b=TRk0tGJgLmVj4U/lJxhV+2eQLBu0gLmfPvxUfCLUHYnKwj5Yef1ycNiggoxrRBBJFor8NSEWefPyXGaRcDumJgNUjGl2FodUYn2c6jrm7fPetlTpsNOFLUdUcygdmiHhfhtVVsHwB9TfflcjocLtcET9VnUy9pGr/x1yJWkEC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739092846; c=relaxed/simple;
	bh=hrz2A+YytCdT85XMfIntILO+tNabyI0LPX0EuhcnVQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=keHG4Lrqy2NNumBAoW+1mWcdbjHJ8BgPOH6uYVfHCZQnIgHJzCV/HN19M/4NRLAWVH1w+3LcyxDnT51RmMoyOr4OeuUMXa1Z1q9QOkScLSiGro2yvNOB/FbN0TcyVN+ZusisjSHgwp9RYwCCg80qr15spAGNG7+O3hKkure6hXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPTm3aQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A1EC4CEDD;
	Sun,  9 Feb 2025 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739092845;
	bh=hrz2A+YytCdT85XMfIntILO+tNabyI0LPX0EuhcnVQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EPTm3aQ5TNUYOYSJmFJ4vBXT5qcRoRPIM3QDf0rJaGMA5q1NUo4BbxnY8GJoAqe6T
	 h4g/invUhUBsqevWw6F9wW4JZqYMaNJ9R9WK6dbX8MtGTX9sTyBkROdWKt+mlcrwyU
	 S8pbXmIXBMKeNA5JNwp3j+8EHfrZZaImyNYSqM71hrW9oimVkmh84SyAHrJcTxB7KV
	 7zqwHZT0KTkRy4vzM119JCMk+h4dDU8J1jpHbA3AzSrutl6gPOMykWxHyoYQCIS9Lo
	 lX7uDySTiBLmY9Yt24L/R6sjt4a3HKAFtxuI/zOhVIiA78j8LJmhHmrYyXG2MENpaK
	 +83Ow3aeI2cmA==
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250207032316.53941-1-ebiggers@kernel.org>
References: <20250207032316.53941-1-ebiggers@kernel.org>
Subject: Re: [PATCH v2] RDMA/rxe: switch to using the crc32 library
Message-Id: <173909284201.3899.16840321542122786965.b4-ty@kernel.org>
Date: Sun, 09 Feb 2025 04:20:42 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 06 Feb 2025 19:23:16 -0800, Eric Biggers wrote:
> Now that the crc32_le() library function takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32_le().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: switch to using the crc32 library
      https://git.kernel.org/rdma/rdma/c/ccca5e8aa14572

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


