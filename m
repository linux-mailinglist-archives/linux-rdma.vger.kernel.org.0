Return-Path: <linux-rdma+bounces-15293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D2CF117F
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 782E03004422
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74485235063;
	Sun,  4 Jan 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCS8sri/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC51C3BF7
	for <linux-rdma@vger.kernel.org>; Sun,  4 Jan 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767539414; cv=none; b=X3B9CWmTBP0Sz35axtckVb9wx90fDTQw9JUAY46JKP2yqPx9+7RJUu6YwUfSa4V5tCK6z9OLrWPrPglp0jfhDPUHkN4iuFYnQNGNuxuesr10hiytXD61BBopYrmd6Aa/d0hJB6zBcYNB67Vv0J6y4zrnRz952Dz+HP3/FU278FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767539414; c=relaxed/simple;
	bh=RhldCz2bh5Iy9hr/TQqymjkpd1NyuNgScSp0JwXTHMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=plUAC7wVPCj6W5wld0XIx+VvQOa6hA7bs24Sq9bj6ReIA6ftooR5OaZ6RWK3apuMPAYNYWO2gxKH3h2iKuFL/Mea6qQtpT6VQYgBXSREHp02WsHmtykIDMFGMtKRdAs96vX+vTq+6+/gvrXE18P7xg9117Vnnl2BSttkFhZ6mVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCS8sri/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35061C4CEF7;
	Sun,  4 Jan 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767539413;
	bh=RhldCz2bh5Iy9hr/TQqymjkpd1NyuNgScSp0JwXTHMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XCS8sri/+ynOPd6M9H9QpBrdgQ3ZbLy8y8mFj0igXPZWfJx0tG4RD1bfVQWOdBBAo
	 +wfvkpHdEnzIY57J/p+EsP16bDIS9xV5GdHqZojawe4xH5a8NAThaqBmneJlPFE1O/
	 AzSkGfKE6Yiu1Fq1lQtjIR4/kOhPIs3XRwjOJMvMDiZ6Nnoougkq9eyE6p77KlHKDT
	 D/yYsiXvMghqJQtHISSPiBpDQOCR985+/Tusb7h41zZW9IrAwF7wMqRm5x4vA3mcAj
	 sWdZhS6pT5JpXGg1cScLnj0yDZLesN6wkQ2aqUeu2d/iADLY/B7GwACUm+/3x2T+7i
	 KdfMIr4npOB/g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
References: <20260104064057.1582216-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/4] RDMA/hns: Misc fixes
Message-Id: <176753941020.1101411.3939042023365733104.b4-ty@kernel.org>
Date: Sun, 04 Jan 2026 10:10:10 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Sun, 04 Jan 2026 14:40:53 +0800, Junxian Huang wrote:
> This patchset provides some misc bugfixes for hns.
> 
> Chengchang Tang (2):
>   RDMA/hns: Fix WQ_MEM_RECLAIM warning
>   RDMA/hns: Notify ULP of remaining soft-WCs during reset
> 
> Junxian Huang (2):
>   RDMA/hns: Return actual error code instead of fixed EINVAL
>   RDMA/hns: Fix RoCEv1 failure due to DSCP
> 
> [...]

Applied, thanks!

[1/4] RDMA/hns: Fix WQ_MEM_RECLAIM warning
      https://git.kernel.org/rdma/rdma/c/c0a26bbd3f99b7
[2/4] RDMA/hns: Return actual error code instead of fixed EINVAL
      https://git.kernel.org/rdma/rdma/c/8cda8acbb1f8c6
[3/4] RDMA/hns: Fix RoCEv1 failure due to DSCP
      https://git.kernel.org/rdma/rdma/c/84bd5d60f0a2b9
[4/4] RDMA/hns: Notify ULP of remaining soft-WCs during reset
      https://git.kernel.org/rdma/rdma/c/0789f929900d85

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


