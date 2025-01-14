Return-Path: <linux-rdma+bounces-7007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397AA1054B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E429A3A41B5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921D231C9A;
	Tue, 14 Jan 2025 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvpaSlay"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A220F97C
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853973; cv=none; b=OP1DHmIyAD9dEv9Ckrv6jB8bZMUTUhQ04hqU4Iyx3Ab2Efb5ZsVCBxFWeVPY0o2PULTgksz+C6Wt/71lLHa2GetlVs7GLsZwZw2HNTSrK+RrEbEEqaMcjrctQ2aLi4tN55nODh+ojUZrEM71ijhx4ycvnONNPX9XQQZOg1xSl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853973; c=relaxed/simple;
	bh=hJ2kTpoGJlKsLJAS4cGRwMUtYNQ1Alg3bL2KAMnbX0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oUroIR7V89P3okCDtjyXtPggQbwBOUEHSSbk3+hVBdHFMvEelsS/K8NxU7EgUVUk1iEeAEqNT9YOIJcX5oYKsvGkOk/59qCawhGtOW53GAsfLp0+7IQzlAzjHL90qGuT0kdhFgpkxoS2+Y4sc2+BKLJMwQeQc/hFJDl4OQfqeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvpaSlay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18588C4CEDD;
	Tue, 14 Jan 2025 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736853972;
	bh=hJ2kTpoGJlKsLJAS4cGRwMUtYNQ1Alg3bL2KAMnbX0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cvpaSlaytt5m+THD5KEhpNAT0IYdTdkMcJ/CxoR66XfFnLFnAh4XFjdr8LJyItt7+
	 GamkRFTL7onczFckeXVI95w9gcN2yI8UIeOvm2PncwVcT8h7e3McBArwv8h96dE+1m
	 euEBPJNuJ7AC9wYNXixPYMUerA4BjRUTBveuzdCpq7oKSMYD7TnC/4rFvacw/KReA8
	 ao2VZegNBi4Ccu/Qsu/0KREUr8x+Tmh11NlTVoBAI6HFDd+/MkGmSuOL1lW3G8qcbk
	 yvc6mKQAe7zztjU0qqcFUsqucZYc5Xc3yDFXHnRP2Sz7p5qkrwqvYHiOPFbBF3i6gJ
	 YADgqeStufo7w==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
References: <1736446693-6692-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 0/2] RDMA/bnxt_re: Driver update
Message-Id: <173685396901.1201524.8407787627052331408.b4-ty@kernel.org>
Date: Tue, 14 Jan 2025 06:26:09 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 09 Jan 2025 10:18:11 -0800, Selvin Xavier wrote:
> Generic updates to bnxt_re driver. Pass the info that indicates
> the context of the caller in ulp_irq_stop. Also, code reorganization
> to optimize the device data structure.
> 
> This series is created on top of the changes from Kalesh
> https://patchwork.kernel.org/project/linux-rdma/list/?series=922731
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Pass the context for ulp_irq_stop
      https://git.kernel.org/rdma/rdma/c/57e6464c221c7f
[2/2] RDMA/bnxt_re: Allocate dev_attr information dynamically
      https://git.kernel.org/rdma/rdma/c/9264cd6aa8f194

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


