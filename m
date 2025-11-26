Return-Path: <linux-rdma+bounces-14779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E48C886A3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 08:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0741F354654
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 07:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040428D83F;
	Wed, 26 Nov 2025 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t74ZQjbw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C0288520
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141999; cv=none; b=TyxDAzzZc9d2en7k+cMxY2GXKJ+c/BYbjNK1KuAw9ZUSYcXouQDHCUuFCaDrALeWQf5MEAI4Zf0hN9ycVTTIZVU1g/vEL9wXhXCF+oy862/XGcKQE7yT3J4qBUEMLhPFdcQdVIrJ5dzZQM6cXJqMhmT+gMmLt/TIGfh2kqqqR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141999; c=relaxed/simple;
	bh=f/dW+yvnf6fQjEfIHF8GG4mQhV3eQ8rGqN7wpMKSgG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i4GmRqKw9ukCMMy+Rz2b4xUT3rvs3qStARxY4A0aiH+nr0OSVGkuu9TPXGwujWrfDoHrhy8C1zvhSGKmbpCuFU8bfj4lSsl+T8bgquFYrZU/guc97oH/Pwy16vZDTzq4G3uRHNqii2JCl9ZJ+XWhJg9md7yOkG7tHOiRmJ1EIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t74ZQjbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83453C113D0;
	Wed, 26 Nov 2025 07:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764141999;
	bh=f/dW+yvnf6fQjEfIHF8GG4mQhV3eQ8rGqN7wpMKSgG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t74ZQjbwrNt7cHGtLKTNRXcil84g11n6I5LQWXCGLwh2DHKjDtI9jSgC3c0V8YGu/
	 F4hUG87hJg5rCS4aVp5cr/YYREvY12bNVCEsZi7fieoVQokvMwqZuF4l2wmhc76PRW
	 8N6HFX0wsuK8lUAFEQFrijq1Gm4iyHMHXz1c7BCUej8qU/y3EAhfw3GfthPc1EpVJE
	 e9PVG8em+3xKAYZLIYB2FZ/eD9zdFt47mt599JuBb00TvFoFLc6gtVJUHFsriJ3OQP
	 DkY8AZljRFc1edQXGfOceL51p2S6/yxfNxtQq9JJeh6k5fZNwMIRZlWbb4wqmxDJp7
	 Wu3J1ZkkWSQ/g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com, 
 jmoroni@google.com
In-Reply-To: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
References: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
Subject: Re: [PATCH 0/9] RDMA/irdma: A few fixes related to GEN3 Support
Message-Id: <176414199591.1821759.2802321086632048487.b4-ty@kernel.org>
Date: Wed, 26 Nov 2025 02:26:35 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 24 Nov 2025 20:53:41 -0600, Tatyana Nikolova wrote:
> This series includes a few fixes found after the addition of GEN3 Support.
> 
> Anil Samal (1):
>   RDMA/irdma: Add missing mutex destroy
> 
> Jacob Moroni (3):
>   RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY
>   RDMA/irdma: Do not set IBK_LOCAL_DMA_LKEY for GEN3+
>   RDMA/irdma: Remove doorbell elision logic
> 
> [...]

Applied, thanks!

[1/9] RDMA/irdma: Fix data race in irdma_sc_ccq_arm
      https://git.kernel.org/rdma/rdma/c/a521928164433d
[2/9] RDMA/irdma: Fix data race in irdma_free_pble
      https://git.kernel.org/rdma/rdma/c/81f44409fb4f02
[3/9] RDMA/irdma: Add a missing kfree of struct irdma_pci_f for GEN2
      https://git.kernel.org/rdma/rdma/c/9e13d880ebae5d
[4/9] RDMA/irdma: Fix SIGBUS in AEQ destroy
      https://git.kernel.org/rdma/rdma/c/5eff1ecce30143
[5/9] RDMA/irdma: Add missing mutex destroy
      https://git.kernel.org/rdma/rdma/c/35bd787babd1f5
[6/9] RDMA/irdma: Do not directly rely on IB_PD_UNSAFE_GLOBAL_RKEY
      https://git.kernel.org/rdma/rdma/c/71d3bdae5eab21
[7/9] RDMA/irdma: Do not set IBK_LOCAL_DMA_LKEY for GEN3+
      https://git.kernel.org/rdma/rdma/c/eef3ad030b08c0
[8/9] RDMA/irdma: Remove doorbell elision logic
      https://git.kernel.org/rdma/rdma/c/62356fccb195f8
[9/9] RDMA/irdma: Fix SRQ shadow area address initialization
      https://git.kernel.org/rdma/rdma/c/01dad9ca37c60d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


