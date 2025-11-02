Return-Path: <linux-rdma+bounces-14178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF4C28E81
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 12:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16503AB037
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039626D4C7;
	Sun,  2 Nov 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpHngpDF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDD21D5BC
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084428; cv=none; b=tYZiriLZOVnY4jIw5xCueRm/0uCAWrsQFARfCQk7ztob8lyX/R7lxPmuQzlC/NBnAYFAQ/QcNBrhVj+ZLxEZZsjT6fBa+XrkQFTiyqjwZKFAJ2pTwTqsEg3bF82mM4eIP0IPwBSUqQ20zM1RbEY0t/FKAfjULpzlZTbCc2RI5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084428; c=relaxed/simple;
	bh=sGkOKPOp2RmRO9SBaectK8M0a7uGg1C3x7Xwbed159I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yz8dp3u6zD5exqpABcmw6lngu1pkT7bJKWewFGTNJFxw6kV5IqyiKtdLzwTxTlF01Elorc1cH5GIIBwXv5ZhBVFHC2rxtjBDSn2JMfoJmEDEp9NRQ0DqOOqLdANKySogs1/QdOcJfRzB34BVJS03mD3o5Y33Rn5ia0Pfpkufpbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpHngpDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD7AC4CEF7;
	Sun,  2 Nov 2025 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084428;
	bh=sGkOKPOp2RmRO9SBaectK8M0a7uGg1C3x7Xwbed159I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UpHngpDFz2jP4sDPd+rtrRUYAHIHtNWSgj16b02bfwFoqpJsmM+f7eRfVXzVW6B+T
	 1+x/zqqByK/YkLhYcobq79SlLC5LdjJyNUnz9Df1j7zjyF1ajdHoK21S3ar5eoOHjA
	 aFue7PN8JZBndPHLfgODqcCGC9ugwamAxbMRKvURVOJqWeWA1M1BGI2WDFLZnq8yYL
	 0Hu5ej+V4c+8WexJHBB6qcIhXTA1WnE2QQVSFc+MNh0RAv8emFI3dvF+IeHxaPO4Ab
	 th4GVd/bAskS6BinGxLkHEi25BVzPo1zpH/jeKUbszDqd/bWDQWfmh+hOtFqdNiUBF
	 fuyCSagD3Z3jg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com, 
 Jay Bhat <jay.bhat@intel.com>
In-Reply-To: <20251031021726.1003-6-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-6-tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH] RDMA/irdma: Fix vf_id size to u16 to avoid overflow
Message-Id: <176208442534.10923.2678900203398695672.b4-ty@kernel.org>
Date: Sun, 02 Nov 2025 06:53:45 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Thu, 30 Oct 2025 21:17:25 -0500, Tatyana Nikolova wrote:
> Correctly size the vf_id to u16 to avoid overflow.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Fix vf_id size to u16 to avoid overflow
      https://git.kernel.org/rdma/rdma/c/b549c24d549d16

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


