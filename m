Return-Path: <linux-rdma+bounces-14444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB9C523EF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7644EBB6B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2A329E50;
	Wed, 12 Nov 2025 12:21:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0F329C65;
	Wed, 12 Nov 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950062; cv=none; b=LTnGglxQAOu1saLPsF0Hz98t4Ak6kkZespbGfWTE7PdmbM+5IgcAVerVffbHC9tk60qzeiZl6adcoe05NAfYZnAC80JJu8cq8OeX+0mmR/BQlhZh/e0KMw5hIEFeHRcocMQQca4wS1C1CQMka2OzFmsOuX4C/8VVowKX9wPZ+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950062; c=relaxed/simple;
	bh=FbB+xWkbW/8EyCN/iTaq0044DqB+nNZncYSBF+iXaLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nc/mLLH+3VkP+gXCy3S2hQRNF74qJldTlcgyAKlpFYePzetqo5F5U/pNXbEA4oNMPeChKV+9TGbzuT1jQoJfNhkuBAVOoKq2EhANY4cNM1kwZHar+iMP3TyCeYOUESI+eKOndeed4CDnr6xf3nDHzhfmt0fdL5afTw1GtMFWN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553FDC116B1;
	Wed, 12 Nov 2025 12:21:00 +0000 (UTC)
From: Leon Romanovsky <leonro@nvidia.com>
To: krzysztof.czurylo@intel.com, tatyana.e.nikolova@intel.com, jgg@ziepe.ca, 
 leon@kernel.org, Tuo Li <islituo@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251112120253.68945-1-islituo@gmail.com>
References: <20251112120253.68945-1-islituo@gmail.com>
Subject: Re: [PATCH] RDMA/irdma: Remove redundant NULL check of udata in
 irdma_create_user_ah()
Message-Id: <176295005720.874941.2639335477052008037.b4-ty@nvidia.com>
Date: Wed, 12 Nov 2025 07:20:57 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 12 Nov 2025 20:02:53 +0800, Tuo Li wrote:
> The variable udata cannot be NULL because irdma_create_user_ah() always
> receives it. Therefore, the if() check can be safely removed.
> 
> Thank Leon Romanovsky for helpful advice.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Remove redundant NULL check of udata in irdma_create_user_ah()
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>


