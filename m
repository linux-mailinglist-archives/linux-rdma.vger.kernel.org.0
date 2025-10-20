Return-Path: <linux-rdma+bounces-13950-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCDBF2351
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1912B3B1421
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8CE2750ED;
	Mon, 20 Oct 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjVKEsOV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E5274FEB;
	Mon, 20 Oct 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975160; cv=none; b=hZzf7bltKHWz5miBTw5cEuSBjs5im7HyUIXfe3lArLHojq+T7FKNqVeiej3lZPloL6F31sasE81mjW1K+tmlNjdvCfiI1dBE2KhmogX5t1xQbhtZPRK5c4EPWmhY1Dj9YtQhKlcriNAzqkR66oIGeG0+1wWQag4367otdpxZrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975160; c=relaxed/simple;
	bh=H8cn2O1JRaxPBijwkulh4VUiHadh8z33IQtXsxuF6Ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OYXnsjUoZVwv7uPnrDuhbGfBLtoadO8v89i1JnhY1+P3PuowPq3mk8kuIxAmub9bXRCS7U6/hbcxk7eDovEWf7FP5AUE60opsrA1GaOALf9YjyQuJEcRNascKzpLWkjaoXOEZiEPmwpURojyYBX5BOpG3xd4CBxBIEGGbs85QCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjVKEsOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CA8C4CEF9;
	Mon, 20 Oct 2025 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975159;
	bh=H8cn2O1JRaxPBijwkulh4VUiHadh8z33IQtXsxuF6Ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jjVKEsOVQdA5p7qWhAfM055zuIIlB2KrMdIZYEoEHvzOJYHZlnmVb/PsY/qVPBc8i
	 yAY8E+jA0IENCRrf32jHgRTmu96E/JzAC0Goz+xt7678xolbHjwKRcDM7Qed16wr0l
	 ImXS5HE5GnbXSS7CDGZHmrT2v0MxpVfklel9bZEhqespgy/dpMrzSqOY1BCle7VxuT
	 bNXq/i6+sQ8D1gi1ZVw1OV5huF+6hrtTEdeRWWdNSFddph+wfpjhogbaGkpEodqVqz
	 OBO4krFSFjX2OXTIPb5KVF4mfuEXSOeWCeMnaTJIMeFbAOdORkosXt6MUvrJKBNCJc
	 R5JMiYQBEPxRA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <20251020034320.3011094-1-rdunlap@infradead.org>
References: <20251020034320.3011094-1-rdunlap@infradead.org>
Subject: Re: [PATCH] RDMA/uverbs: fix some kernel-doc warnings
Message-Id: <176097515612.343859.12543106218321557373.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 11:45:56 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Sun, 19 Oct 2025 20:43:20 -0700, Randy Dunlap wrote:
> Fix 49 kernel-doc warnings in ib_verbs.h:
> 
> - Add struct short description for rdma_stat_desc, rdma_hw_stats.
> - Fix kernel-doc format for struct members (use ':' instead of '-') for
>   several structs.
> - Don't use "/**" kernel-doc notation for struct members in ib_device_ops
>   (most members are not documented and most of the kernel-doc was
>   not formatted correctly).
> - Spell function parameters correctly in ib_dma_map_sgtable_attrs(),
>   ib_device_try_get(), rdma_roce_rescan_device().
> - Add kernel-doc for the function parameter in
>   rdma_flow_label_to_udp_sport().
> 
> [...]

Applied, thanks!

[1/1] RDMA/uverbs: fix some kernel-doc warnings
      https://git.kernel.org/rdma/rdma/c/be180c847a6db6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


