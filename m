Return-Path: <linux-rdma+bounces-5611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224449B62BE
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 13:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A011EB23DB7
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69451E884B;
	Wed, 30 Oct 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qboeUIeN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4011E8849;
	Wed, 30 Oct 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290457; cv=none; b=j98f5X2vABP904m4oqExe8zdHjQT8CYKH2ObuGAcmJct2VlYY0QQn1DBsU6i2EAfD6gslCGflyio4QTK6SzuODBAUqYEnZwrY20r8BGf4DdK9IwuXoaF6G8lYZzjlxhW9HxQIhez79yzBl3nMQtXDaIHESYui6HmnDb8aku8J0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290457; c=relaxed/simple;
	bh=E1waqaljvmeuCK69VUwSbhAMyNmFJXiH8O/T3EHdJbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QZz6wNSmTUs0qKgTcDR2ZX5pUql7VNe9VTdjhcQfTWRVHv5YrMjcD+Q2wTwxm2SwYFeB1O5Q7HJUSCv3YZcV9XOtviwyx15pY7TvNdxFUEz5LUDxd2jIMaOkSXxuI3yavLFR39iXQj4IR0xxrYJXLG1X5QC/lMucs2O73mOid1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qboeUIeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF591C4CEE3;
	Wed, 30 Oct 2024 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730290457;
	bh=E1waqaljvmeuCK69VUwSbhAMyNmFJXiH8O/T3EHdJbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qboeUIeNuRAWcPxZ0vO7peVotwLR5Gd2vg6iQXbk5gxisWpBQktWASgnU8CTnGBaR
	 i/O3OagtFIPr16ERSeuFSamjWksQqfbBlJx1+xIBRvzQDQ6NqGvxAQuLhC3jiCEEt0
	 imk6TYVBjMetYWLHw9vHYSLmd8IwE7rG456AQeY41AmOU2WQaTHr5t0y4onP9ZslIW
	 +2sH2d0zaJOcuSAI4KqhakJ0gJe5rNB9W+ITSHjaDvaHI29ltliXeYLJ0C0njignhU
	 gpckKOgPKy/N3GNgl/GlHa2kq9mcywuO0w2F5sk9ic3BMJLC1Qsr8l3zPsSWxfWCJk
	 3Ahm5/+kCEG5g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
In-Reply-To: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-rc 0/5] RDMA/hns: Bugfixes
Message-Id: <173029045313.59867.17041043920057577100.b4-ty@kernel.org>
Date: Wed, 30 Oct 2024 14:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 24 Oct 2024 20:39:55 +0800, Junxian Huang wrote:
> Some hns bugfixes.
> Patch #5 has been sent once before:
> https://lore.kernel.org/lkml/4c202653-1ad7-d885-55b7-07c77a549b09@hisilicon.com/T/#m05883778af8e39438d864e9c0fb9062aa09f362c
> 
> v1 -> v2:
> * Add spin_lock_init() for the newly-added flush_lock in patch #2.
> 
> [...]

Applied, thanks!

[1/5] RDMA/hns: Fix an AEQE overflow error caused by untimely update of eq_db_ci
      https://git.kernel.org/rdma/rdma/c/571e4ab8a45e53
[2/5] RDMA/hns: Fix flush cqe error when racing with destroy qp
      https://git.kernel.org/rdma/rdma/c/377a2097705b91
[3/5] RDMA/hns: Modify debugfs name
      https://git.kernel.org/rdma/rdma/c/370a9351bf84af
[4/5] RDMA/hns: Use dev_* printings in hem code instead of ibdev_*
      https://git.kernel.org/rdma/rdma/c/d81fb6511abf18
[5/5] RDMA/hns: Fix cpu stuck caused by printings during reset
      https://git.kernel.org/rdma/rdma/c/323275ac2ff15b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


