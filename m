Return-Path: <linux-rdma+bounces-1308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DF874ADC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 10:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D17A281E5B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07983A03;
	Thu,  7 Mar 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgC7Zl5n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8958839E7;
	Thu,  7 Mar 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803771; cv=none; b=ej8GTN55Ky+JHhKXcQUIzDvpw8SzUml1aQl5oyOTwpJE4mMDltV2zzV2mL9vSb3CkEvXSkgWq0hkXzfpjWiYnXz2OTmEp5o8/spUr3PWGzCGavtLjE1IX+blwQZuA3azKleqIvXkap5xvK4FKFklH+ZB4NLtb/Jh2zZ5jE3q6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803771; c=relaxed/simple;
	bh=CLuoFXpG8XQClguugvlEFJk9FpIIaelRFkredGs3ESI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dakHKN17izeS6rdC7GWB69BrOh3ohNqC/JeBfnWXysBK51O7h96VzIgGe0/+w3pSm65Jq7tW05C5TSDhWrLDvuuXaiNNPhh9bvbBUdnF3VDLD+KyTFh4+GEhcePYE4+lMIotR3tsgOCrA+Y5Te0kTEGhnli1NiWf8UnnwmE3r/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgC7Zl5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC21FC433F1;
	Thu,  7 Mar 2024 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709803771;
	bh=CLuoFXpG8XQClguugvlEFJk9FpIIaelRFkredGs3ESI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EgC7Zl5nibcNs9cGOyKvc77OZfXXwuKF6CYhpEZZob15JkrGW0+4AeHcrmMsUXCwv
	 gN8N4PXJQ/9GUgfWbrTkfYqa3+/g+JPkskSThDYcHrVFvls4Z3z1hYXL5lGuesNKe4
	 RQdjlCb1JjxDF2KOqw+Uvr2+neNqd7sLPhYsyMC8RC95UX0eXuf8UyyNoN0xAM8ATh
	 Y+QLo4ZiTWp5sjdOv2+585nGH5ldo6xf5vfrqhWoqLMbV1yLSzYv400BxyTQud75V5
	 2gwMUbPXeNHuQMoMqyFKqYb5Ecb5m7WijX0WX+9pU187F6wjeElGIaSRVIWjzJ+iMY
	 Y6otCgzr56KJA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240305055257.823513-1-huangjunxian6@hisilicon.com>
References: <20240305055257.823513-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Append SCC context to the raw dump
 of QPC
Message-Id: <170980376768.111986.11910781633022974979.b4-ty@kernel.org>
Date: Thu, 07 Mar 2024 11:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 05 Mar 2024 13:52:57 +0800, Junxian Huang wrote:
> SCCC (SCC Context) is a context with QP granularity that contains
> information about congestion control. Dump SCCC and QPC together
> to improve troubleshooting.
> 
> When dumping raw QPC with rdmatool, there will be a total of 576 bytes
> data output, where the first 512 bytes is QPC and the last 64 bytes is
> SCCC. When congestion control is disabled, the 64 byte SCCC will be all 0.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Append SCC context to the raw dump of QPC
      https://git.kernel.org/rdma/rdma/c/124a9fbe43aa22

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


