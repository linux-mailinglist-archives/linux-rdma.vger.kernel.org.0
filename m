Return-Path: <linux-rdma+bounces-14063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84095C0D2AE
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040AE3A3AA6
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FCA2FAC06;
	Mon, 27 Oct 2025 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfnQoZN+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78902FAC09;
	Mon, 27 Oct 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565013; cv=none; b=p36SvGjrZ8AjQzOcS5A0xT0YP0Ko81QwlxfJPIhAlx6u6pAlyO8km7YK+u0mwNRxjKzOC7jfJNS4cbzldTxYcNHj8m9iH650rBhl62l+eFUKHJQIOZVH2Sr4F5HTqo0n3EpkWDAd4YD3zwKbr3gv0VX+AhSOAoKAvtqRC/ZbWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565013; c=relaxed/simple;
	bh=GR9p7sJmgdRpfFp4lXDp4Qj9+w0WDpc9bzpGxSfqLzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oFQ6aGHxZ3Cn5u5EQfLe5VZbY/AUJXuWMW2xCDow+ojpkIkxbNsYrJnR1RlH0J3cnTZA2f0cePWU1CaWV9j867DsBuYeAmSL9Un6EsVMvEmurrTNVgaj2bP8WQwaQCNFv6eALGefwCFye/zyk+RD4iuox0kcRAoR+SkGp0rZcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfnQoZN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5F0C4AF0B;
	Mon, 27 Oct 2025 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761565012;
	bh=GR9p7sJmgdRpfFp4lXDp4Qj9+w0WDpc9bzpGxSfqLzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hfnQoZN+LhQnCdYNuGEpTU1gxBjch34hFrWZzO+aRAOXouvkfBb4eKmjIqrMKzig2
	 KkKGdzI4gM3ZZ34X04hxc4qo/l++QZ1F2syos3jrU9k4nE8uNwy+VPp1AvdDU8S/jn
	 s1y7k0iFuJbzoNI8QqnaH2Nl/Ecl01ogDz3hFxwCt5Y4UUpdH8rcsx9KyCrg2Ld8cc
	 KxSCYiq+N5jc5VbXijX2w433ed3JMn1CRnFzIKbbAmzH1Tn/ZquOJ9HxAAVSztS+k6
	 6QowQ4BOATczGIJgSbQPypAhyJVkt6kXF1Vfta5zjPwXEtZAmm83lbGgaYC9rwl0gV
	 gwFzU1oM4j4Gw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sean Hefty <shefty@nvidia.com>, 
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
 Jacob Moroni <jmoroni@google.com>, 
 Manjunath Patil <manjunath.b.patil@oracle.com>, 
 =?utf-8?q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251021132738.4179604-1-haakon.bugge@oracle.com>
References: <20251021132738.4179604-1-haakon.bugge@oracle.com>
Subject: Re: [PATCH for-next] RDMA/cm: Base cm_id destruction timeout on
 CMA values
Message-Id: <176156500963.450375.15935808694605364471.b4-ty@kernel.org>
Date: Mon, 27 Oct 2025 07:36:49 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev


On Tue, 21 Oct 2025 15:27:33 +0200, Håkon Bugge wrote:
> When a GSI MAD packet is sent on the QP, it will potentially be
> retried CMA_MAX_CM_RETRIES times with a timeout value of:
> 
>     4.096usec * 2 ^ CMA_CM_RESPONSE_TIMEOUT
> 
> The above equates to ~64 seconds using the default CMA values.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cm: Base cm_id destruction timeout on CMA values
      https://git.kernel.org/rdma/rdma/c/58aca1f3de059c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


