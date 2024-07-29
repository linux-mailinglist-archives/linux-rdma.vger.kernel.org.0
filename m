Return-Path: <linux-rdma+bounces-4057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1EA93F005
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2CF282E2B
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64841137905;
	Mon, 29 Jul 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxWUPBMT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC21EA91
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242555; cv=none; b=oAwwb6wRdUgCIsjX0PotSTwzlTi3SfyFgGOKTjK34qHNkLMmOAb+VoFV+k+T2I1rqg/HLw88Hg9kmNMrYmpflAdS9EW5IWvooYMevBuBo5hSnYgyYzL8XDvyJKvtJxMpGIBqlws8hBHy5GPfi+VL21kbfvYG6s54VThkbrr1Wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242555; c=relaxed/simple;
	bh=OkjFtPuETEBz+b/X6LogNSvAxXEmzrfiR2Bdhh3uA20=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sEn8qgxjg+Jh271/rb2zYEJryonsGiShOtmEU/BkBGYR5GxOF+ICndytaLPD8PpcuZJImHTHNyz8yO2+qARCvQw52N4583NhwL/FKOXwWYKVGjBrv5pb40ymTU1NBnEyLOhS85mLaGIPdDflCZpdf2J4X+ODhR6XFcIoX4G3mes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxWUPBMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4314AC32786;
	Mon, 29 Jul 2024 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722242554;
	bh=OkjFtPuETEBz+b/X6LogNSvAxXEmzrfiR2Bdhh3uA20=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FxWUPBMTvwkdL9KLscLoB+y6xqBiYnEVUek5nYmqqX5afC2sS87OIDnK8E7q6cyFW
	 v/ZLN2ZftUWPm6ILkocMP7pY28CjIIow/+2E25n4w5ERP3ljWgO86E19lB34kwktLX
	 FCvDXhnthuucdDvXhT+L1Wz4wRwv98x9SQQh+u2zjOSqKBqRk5BIhiN47NV8rnONSA
	 KLq5i/V13/mMyCqBHO4PROa5OFbEIccbvKoxd0Sh8v4524s71H7JcURRXqHrRQDXAe
	 salYHF4ZCuxzGYmkBsCyV3xaGCznsmeeozlqx0fgLNp1EsnXK5AjVtr0/f8/MaIYqC
	 djsrHZxh08m4Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: linux-rdma@vger.kernel.org, hch@lst.de, 
 Potnuri Bharat Teja <bharat@chelsio.com>
In-Reply-To: <20240716142532.97423-1-anumula@chelsio.com>
References: <20240716142532.97423-1-anumula@chelsio.com>
Subject: Re: [PATCH for-next v2] RDMA/cxgb4: use dma_mmap_coherent() for
 mapping non-contiguous memory
Message-Id: <172224255015.117427.779377877560418246.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 11:42:30 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Tue, 16 Jul 2024 19:55:32 +0530, Anumula Murali Mohan Reddy wrote:
> dma_alloc_coherent() allocates contiguous memory irrespective of
> iommu mode, but after commit f5ff79fddf0e ("dma-mapping: remove
> CONFIG_DMA_REMAP") if iommu is enabled in translate mode,
> dma_alloc_coherent() may allocate non-contiguous memory.
> Attempt to map this memory results in panic.
> This patch fixes the issue by using dma_mmap_coherent() to map each page
> to user space.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: use dma_mmap_coherent() for mapping non-contiguous memory
      https://git.kernel.org/rdma/rdma/c/75ab1533d79b04

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


