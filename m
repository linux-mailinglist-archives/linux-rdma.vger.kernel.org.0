Return-Path: <linux-rdma+bounces-3814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C768592E3E4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C061F21CF4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085DB15748A;
	Thu, 11 Jul 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz8/Is/M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29B4206C;
	Thu, 11 Jul 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691792; cv=none; b=ARzaqyRMmg0PEpMxAG8nY3azDyOHX9B/qM9KXhh/B8svSZcJDzCnYKYQ87hI6Y1pAL0zWv9rnsajbRhl3cwIIZqw3EH0/YKG1ExdzpS8Uyknr5x5Om8EEK6MPCc9nJENavuKX1yAVZ8vfsDm41OkDHZw/q6wr1JQNnhOTQJQbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691792; c=relaxed/simple;
	bh=L9jWCu8i8XpLdqWdfxP0ovGftyzVoEn0XFfVq/Li4kU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E5R4uxN9wTLhWt9Q2KlqDcloPJfucJhWzadIYKej+2fQQwtZOGGtoOiOSAM7dFZPhsDLib4qDpMQWC8ihLrxhpf8ehd/cVI4q7PTPH7/8hUWPAcFNzYwgLJF1vlmZH5dSm8exjbMi2R327JmRrPST2zG+v0ZDZmO6DTX8GuYJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz8/Is/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86C2C116B1;
	Thu, 11 Jul 2024 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720691792;
	bh=L9jWCu8i8XpLdqWdfxP0ovGftyzVoEn0XFfVq/Li4kU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nz8/Is/MDQR+6zdyY8/gOnUw2Vi+5Eeyl7Xc2WvR55R6ET3Ydo6AgVzBygFzrcHZc
	 PIG0XZih976SXunP3xijbU0AwtcgTWbBVhneywuW9bqoAmT77d6pb3xMYW9kEq7wVM
	 dUxlUrbDMLrRHB2PT/dCVpCA8CIR/kTOk58DEbLQIudbLoHzQaY2VRIF4eDQTe6r+n
	 5kUnlUoeB2PLnGeOzNjjQB2oxz7a4Wc+19zj2jqLX42LI0IxM+LGf9Uuuh0HqosBGj
	 oF6EnyrNO5t4pVyy5rZxnRMqKqf5xze31PjPh4+3sb3+jYTfM7UTtpOfQ2+c3eJVGS
	 cjrF0D4i2INXg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
References: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-rc 0/8] RDMA/hns: Bugfixes
Message-Id: <172069178813.1711020.16024582484605873294.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 12:56:28 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Wed, 10 Jul 2024 21:36:57 +0800, Junxian Huang wrote:
> Here are some bugfixes for hns driver.
> 
> v1 -> v2:
> * Drop patch #2 in v1 because Leon pointed out a problem about mailbox
>   mode, and we plan to handle it in another patchset.
> * Patch #1: put the atomic length check in set_rc_wqe(), stop processing
>   WQEs and return immediately if there is an error.
> * Patch #2: use BH workqueue instead of tasklet.
> 
> [...]

Applied, thanks!

[1/8] RDMA/hns: Check atomic wr length
      https://git.kernel.org/rdma/rdma/c/dd17883b0c242b
[2/8] RDMA/hns: Fix soft lockup under heavy CEQE load
      https://git.kernel.org/rdma/rdma/c/7aa9502ba0aaac
[3/8] RDMA/hns: Fix unmatch exception handling when init eq table fails
      https://git.kernel.org/rdma/rdma/c/e1226904317b4f
[4/8] RDMA/hns: Fix missing pagesize and alignment check in FRMR
      https://git.kernel.org/rdma/rdma/c/15d66ed71e8c51
[5/8] RDMA/hns: Fix shift-out-bounds when max_inline_data is 0
      https://git.kernel.org/rdma/rdma/c/ab7031e560372c
[6/8] RDMA/hns: Fix undifined behavior caused by invalid max_sge
      https://git.kernel.org/rdma/rdma/c/a8690d81736a00
[7/8] RDMA/hns: Fix insufficient extend DB for VFs.
      https://git.kernel.org/rdma/rdma/c/79dd1e1620f980
[8/8] RDMA/hns: Fix mbx timing out before CMD execution is completed
      https://git.kernel.org/rdma/rdma/c/4c3c4cfe0a60b1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


