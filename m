Return-Path: <linux-rdma+bounces-15127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F2ACD3DB7
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 10:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B951B3007695
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E327B34E;
	Sun, 21 Dec 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYs2q8VF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202222F755;
	Sun, 21 Dec 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309475; cv=none; b=BW40Ebw79LFsNWi04aeuEoWKe6/W6rapvXTKj6J40Ct253XFtjdpM9PfogdXNhhNJ6BcnXllg0rhHDywwR1MfHAoGjOchXOHFIn6u9iU+61uY3vfINkz9Qd7rlcllWdKCaLNXd8YNb2YkHxVVV2sxj5Wh10RIABrGP5P1YpOH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309475; c=relaxed/simple;
	bh=0fFkgphsH1o0TEyWvtJIfc7DWPoF9vtAxrgjuEqcC7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H66lVjUA9Fc5Xg82phDEZkG4gd5jJYpXeXdBlLDf+U9jxBYJeff1ZbZl35NvTRqbbLr2fMJnQdULIcq1jbdcv8JmT85hlR9V7U7yakuQde3FRNe8NuqxDkdkuYwuoN0i3NtVQsxygGgOOgVO5dxJHlPj8uozr7qezNFIXk5USm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYs2q8VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7314DC4CEFB;
	Sun, 21 Dec 2025 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309473;
	bh=0fFkgphsH1o0TEyWvtJIfc7DWPoF9vtAxrgjuEqcC7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nYs2q8VFtgPZo9w4ihXMHk7DIqnhYoAsCJY3+CpjwztktIy/G+vv1udD4U6UX1kr4
	 PRzQXPJsW7xVhPc8JuHg2qSPDlqPtJUAT2RTy7gEOfbj5tQBZ6ojPda/EuJ2jeQl51
	 uxFs2k78uGambEvfu8yMp6GIo51kCQurJRELqQLM5jQY71O4HtyejdX8UL/Ddk3R39
	 QkhV6O5qE3IAJ4Y6bIkV8awKmi+HevnuuzZaxojr9cjn8oWg+D0pSOj/nbIKMFCSfs
	 6Do8if30ejhUWI9jmIhSbXo59KvmJmxcyoeI5+N1q/1LaS/AURl5fE8Qk8UingNQmR
	 0YnW2zhGa4hjQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Jang Ingyu <ingyujang25@korea.ac.kr>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251219041508.1725947-1-ingyujang25@korea.ac.kr>
References: <20251219041508.1725947-1-ingyujang25@korea.ac.kr>
Subject: Re: [PATCH] infiniband/core: Fix logic error in
 ib_get_gids_from_rdma_hdr()
Message-Id: <176630947091.2403900.16362203873754408569.b4-ty@kernel.org>
Date: Sun, 21 Dec 2025 04:31:10 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Fri, 19 Dec 2025 13:15:08 +0900, Jang Ingyu wrote:
> Fix missing comparison operator for RDMA_NETWORK_ROCE_V1 in the
> conditional statement. The constant was used directly instead of
> being compared with net_type, causing the condition to always
> evaluate to true.
> 
> 

Applied, thanks!

[1/1] infiniband/core: Fix logic error in ib_get_gids_from_rdma_hdr()
      https://git.kernel.org/rdma/rdma/c/8aaa848eaddd9e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


