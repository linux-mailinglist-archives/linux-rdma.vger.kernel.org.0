Return-Path: <linux-rdma+bounces-1700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C16893AB3
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E305D1C20DD2
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A722606;
	Mon,  1 Apr 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNae2ONi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAD225D7
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711971983; cv=none; b=OQa60kxb2p/vDSe+KO1jhQo+6mzTd4sPsl9n3HjVNeBpzI0x6/j/aJ+qAdABSwlTz7s3fMML1THmXUDo1FjpRrZabHXSs473sHy9UiTxSVnkgw0TrplJSU1uRB3QKqJlLm6duMyKO5oOTNOyXWnUOf0I7BLa5xCyGCZYkbO0bqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711971983; c=relaxed/simple;
	bh=p3FLl48QI8WsmAMuExlnzjdZRpq5TrUha9Ktiz4KcuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nLsk3oKzSt7Dz8s+W0lamuHVZdYPaTaRBp6yX1GHaMfyUYF0GWq72gIQPfc0FgPaKlqcMzULaSKUYH4aw9ZWx/M6q3ThbEJgpT+wJQcQ0tkz9XWRF/MGNG6O8RTybrPc4BCoV5ZmhnEFi+eU+WvHISgJCj3JYeuNWO7iCyXIJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNae2ONi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30558C433C7;
	Mon,  1 Apr 2024 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711971982;
	bh=p3FLl48QI8WsmAMuExlnzjdZRpq5TrUha9Ktiz4KcuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TNae2ONiRXeShT/BiNunwn8Ow6mq1FdCmRHzhZy7rp6A2MHhB4NErae/GW2/5dsNt
	 cwPoFp3UWBH5wg4SOqemW9WY1jXdEoBR+lruiItoQ87qhg6BydjyBU/9Us7N3JZHu1
	 r8fmvCXqP+eUTgKfFoWBf/RpGpreO3HsRUgOFObi6ChBIglKHTaFUMSmswTzWpgX4s
	 zVi79KmrVd8sAAPAjIYD9R51wnuMHYJRf0g+whBYZgImOjdpWnXIB3yNe5I59DmJ6+
	 ojHqzUo+iom+erkz7xFtRu+Au0Q6FTIBUfTplGcw4LfpwChfOwbCwdM8hMJLnQ1lHy
	 VYU64W3e1CRuQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Boshi Yu <boshiyu@alibaba-inc.com>
Cc: linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com, 
 KaiShen@linux.alibaba.com
In-Reply-To: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: A series of fixes for the
 erdma driver
Message-Id: <171197197896.75440.14731934945577717446.b4-ty@kernel.org>
Date: Mon, 01 Apr 2024 14:46:18 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 11 Mar 2024 19:38:18 +0800, Boshi Yu wrote:
> This series of patchs introduce a new dma pool named db_pool for doorbell
> record allocation. Besides, we unify the names related to doorbell records
> into dbrec for simplicity. By the way, we also remove the uncessary
> __GFP_ZERO flag when calling dma_alloc_coherent().
> 
> - #1 introduces the dma pool named db_pool and allocates all doorbell
>   records from it.
> - #2 unifies the names related to doorbell record into dbrec.
> - #3 remove the unnecessary __GFP_ZERO flag when calling
>   dma_alloc_coherent().
> 
> [...]

Applied, thanks!

[1/3] RDMA/erdma: Allocate doorbell records from dma pool
      https://git.kernel.org/rdma/rdma/c/f0697bf078368d
[2/3] RDMA/erdma: Unify the names related to doorbell records
      https://git.kernel.org/rdma/rdma/c/fdb09ed15f272a
[3/3] RDMA/erdma: Remove unnecessary __GFP_ZERO flag
      https://git.kernel.org/rdma/rdma/c/df0e16bab5c7f1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


