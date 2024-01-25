Return-Path: <linux-rdma+bounces-739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2183BE0F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192091C23EB7
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35EB1BF3C;
	Thu, 25 Jan 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbFAz3gB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C71BDE1;
	Thu, 25 Jan 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176498; cv=none; b=ZO7Z9iprIvxkebElBn27QSgcbJN9V70XO4kQ124oZNe5ae1ljq+NxEBL6xV8omhU5UPm7I/qdu3UoNDl8SBPREhMRt0gUOMo8xxNJFRIkszvk1iPZpxBINSAuMHBYhmJUhFVnhFHaSgC4Pg4KxJn7SvyyrcXo5FqaEF+kotPDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176498; c=relaxed/simple;
	bh=Pr9M3TItnO+WCp9xgNJnS3cGyPp1zUpE503a2/p7qFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=niRqTrhzC9wqhwlu+NGzbguSi0008/Q401RhBhC7HZb5k71rWqTqtjVHbR+ZkbpFuQ1hyAqyhi5P2z18am8kRxNSVJbyOS4mP+W7/fTck0u86yhiCeW00VhJ6VM8wcUcLs9Jv4D6ogu5dU9J1dMSYNI6ABxCU+/+qJF+z4k1TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbFAz3gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F30C433F1;
	Thu, 25 Jan 2024 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706176497;
	bh=Pr9M3TItnO+WCp9xgNJnS3cGyPp1zUpE503a2/p7qFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kbFAz3gBeovfkaTx7XidW930wULBscpUoBYfK1FlmJkJHXyMAZ97FhZTGL6nh4HS7
	 7YYrRjnMcLhTlWR+0Hz208l/wDr3ol+CUvCmG/QpieopCWsIqPRWxmnCODjkiwnuyn
	 cCpJsaS5FxPxLGXoK9fl1jzMNEUVhJN5FDdGwEzLHb9ZBYpwD/BsqK3wBwnvXno+Za
	 mYNz46/Wv4ZGfx7yJTpgL8zbzHVdb6K1dIPtejCbAy2W/+anGzc9on6NkhNtzCGz2w
	 ZeOJKNh0RLCEYxy9QruNosk2aAwgiLfYt3jNcsJy+bYzUGSanrL3KWdTgsm9HBnNKW
	 AvXh+sitzYr0Q==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:
 linux-rdma@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240113085935.2838701-1-huangjunxian6@hisilicon.com>
References: <20240113085935.2838701-1-huangjunxian6@hisilicon.com>
Subject:
 Re: [PATCH v2 for-next 0/6] RDMA/hns: Improvement for multi-level addressing
Message-Id: <170617649381.631892.11682073740991077040.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 11:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Sat, 13 Jan 2024 16:59:29 +0800, Junxian Huang wrote:
> This series optimizes multi-level addressing for hns.
> 
> Patch #1, #2 and #6 are optimization of multi-level addressing codes.
> 
> Patch #3 is prepared for the following optimizations.
> 
> Patch #4 and #5 introduce adaptive pagesize and hopnum to improve HW
> performance.
> 
> [...]

Applied, thanks!

[1/6] RDMA/hns: Refactor mtr find
      https://git.kernel.org/rdma/rdma/c/a4ca341080758d
[2/6] RDMA/hns: Refactor mtr_init_buf_cfg()
      https://git.kernel.org/rdma/rdma/c/4f5731b1fb2246
[3/6] RDMA/hns: Alloc MTR memory before alloc_mtt()
      https://git.kernel.org/rdma/rdma/c/6afc859518319d
[4/6] RDMA/hns: Support flexible umem page size
      https://git.kernel.org/rdma/rdma/c/0ff6c9779aafc2
[5/6] RDMA/hns: Support adaptive PBL hopnum
      https://git.kernel.org/rdma/rdma/c/2eb999b3d40ff8
[6/6] RDMA/hns: Simplify 'struct hns_roce_hem' allocation
      https://git.kernel.org/rdma/rdma/c/c00743cbf2b8f7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

