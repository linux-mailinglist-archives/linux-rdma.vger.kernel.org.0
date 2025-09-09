Return-Path: <linux-rdma+bounces-13187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19366B4A8C2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D113BA8FE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C642D46AB;
	Tue,  9 Sep 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg5py91D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68982586E8;
	Tue,  9 Sep 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411365; cv=none; b=bF+ruz0uWOXvL8P/6w+WX4XVMUpmIc19vbtvi63rWWWYqQEgvCyFZ7llD1jzrTbFV5T1EstPXFYqYTPLg9C8DqWGVAlQKBJ7s5EwURb0gT566q4qOrXolL5Hno5z6x/olF2BIjFOI2ZMgLN1SvWlAXcM7YU2xfmziEIG/yKDbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411365; c=relaxed/simple;
	bh=9IcyFvIcUt5peX8BuBaGcEadOuXtbZqKJ9eky6Dbwf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S5eNx0MTx5htQgJg94j0BY23Olc+LMyHHVfi6Mq9VfvgPwCzjmm8gGuSFrunY5wtYXdlM0YWoUQZSfbFIAujCY1UWKj2WnIMrL1CGWq3ihL1AjVEbI78FB5z83Z+OXEzTgWw5QlKeG0KuOW0nj/HQmInVChIAAZgVQZ+rYK6Nfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg5py91D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB077C4CEF4;
	Tue,  9 Sep 2025 09:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411365;
	bh=9IcyFvIcUt5peX8BuBaGcEadOuXtbZqKJ9eky6Dbwf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gg5py91DM22ysEl3FLd25XXbFNtlnz4KdvrCvDkkHNuoRRL/vXndLRn94IJhHdwTQ
	 OyTFINAhsrOAuV52uqHAqIYwScSyaH9bH+yvbFTQl0A0b+12tm6/ejHcsIj23hAVMs
	 rLYo68zqhTvOCJ8ZxHBY0ZrLD+SPcj3S5/jLh1hS9FTVl+LjwQk9F9f9XckivYufGx
	 SWYUXnBRmOvkBE+rf0Ej80SLLC8IZPPEpilw+nJ0blmHHRl1wlnu0Q81ymUhGRET3r
	 LcAs+Is2KY9Woc5IdtUqGZeiX+2OjLUV5LiKmj2RWzdVHxgwhnDcG5S7mcF7SoIr78
	 eSJypcZemL/bg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Edward Srouji <edwards@nvidia.com>
Cc: michaelgur@nvidia.com, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250824144839.154717-1-edwards@nvidia.com>
References: <20250824144839.154717-1-edwards@nvidia.com>
Subject: Re: [PATCH 1/1] RDMA/mlx5: Fix page size bitmap calculation for
 KSM mode
Message-Id: <175741136219.672925.7944659041214094806.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 05:49:22 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 24 Aug 2025 17:48:39 +0300, Edward Srouji wrote:
> When using KSM (Key Scatter-gather Memory) access mode, the HW requires
> the IOVA to be aligned to the selected page size.
> Without this alignment, the HW may not function correctly.
> 
> Currently, mlx5_umem_mkc_find_best_pgsz() does not filter out page sizes
> that would result in misaligned IOVAs for KSM mode. This can lead to
> selecting page sizes that are incompatible with the given IOVA.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix page size bitmap calculation for KSM mode
      https://git.kernel.org/rdma/rdma/c/f4d365433815fd

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


