Return-Path: <linux-rdma+bounces-6708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD49FB06E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 15:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0352A188271B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802D61B0F1B;
	Mon, 23 Dec 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ2GsBOa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399481AF4EA;
	Mon, 23 Dec 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734965931; cv=none; b=tQCo59wvyEhj4yGXfLrB41JfKe882yVrAkkMYWI6tSZEDR2zL25J4VczF4NieYRdLSNFtt3LFHi1N7gPvkbfKIR1JetweXMDDy2jsxEtrJIMc3fSgUu15t77/UHdjlRP8OngnfWhOPyjaMx3m/z8nhNoA7D5TdpBbc50xhiJ/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734965931; c=relaxed/simple;
	bh=iYhyQizMirt/FjQcdFJs/eEmiwQCA1ukl8tEOFTVoWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qySm4CHmdfpMROXQCdxxJIZwRu1tYhPTsbx6cGxGTWsUPmf9Y6YyhhLVwvGMwhhXYQ4TKM66Zoe+cmgxvp9FQFDh2p8Aw9rZctiTk2L+JjCZfr4R8m0UNqeStNzdQDtkWBADNpYs4N73JNeRREAFV1VNaW7Gxk+QtlHH2JFR9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ2GsBOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A656C4CED3;
	Mon, 23 Dec 2024 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734965930;
	bh=iYhyQizMirt/FjQcdFJs/eEmiwQCA1ukl8tEOFTVoWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TZ2GsBOaXvSrJdZfepmFC2MKMkeOnxFx54pUi3M5F8HZVyHRuPSlDe9Kv7B0x8j1J
	 SWOeHCAo/5VTdlUBxEh+dFIQvfh8LhJMVhXPcHHUrcYI79XctNn59lBY84G81a3yGt
	 PFUJ9osGArKiF0JkaJU9ujyxiikqeOpMmrx8KSELpOBynocAPlHpfkUN4tZR7W3RiK
	 xwKoLIfdnoTIEiitdzhxnFKQ21ftpEUoM5w/yubMvEEQhjoOnDckkwvVJxl2hiwL46
	 f6zcfY3Lciei6R5J7UstBel1BAqgdfE8ByI1ry5zVGMOgg9PPI2+f0jcUZSoviVK90
	 FtfSJi+V5espA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
In-Reply-To: <20241220055249.146943-1-huangjunxian6@hisilicon.com>
References: <20241220055249.146943-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/4] RDMA/hns: Bugfixes
Message-Id: <173496592736.403699.6324840157920941971.b4-ty@kernel.org>
Date: Mon, 23 Dec 2024 09:58:47 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 20 Dec 2024 13:52:45 +0800, Junxian Huang wrote:
> Here are some recent bugfixes for hns.
> 
> Chengchang Tang (3):
>   RDMA/hns: Fix accessing invalid dip_ctx during destroying QP
>   RDMA/hns: Fix warning storm caused by invalid input in IO path
>   RDMA/hns: Fix missing flush CQE for DWQE
> 
> [...]

Applied, thanks!

[1/4] RDMA/hns: Fix mapping error of zero-hop WQE buffer
      https://git.kernel.org/rdma/rdma/c/8673a6c2d9e483
[2/4] RDMA/hns: Fix accessing invalid dip_ctx during destroying QP
      https://git.kernel.org/rdma/rdma/c/0572eccf239ce4
[3/4] RDMA/hns: Fix warning storm caused by invalid input in IO path
      https://git.kernel.org/rdma/rdma/c/fa5c4ba8cdbfd2
[4/4] RDMA/hns: Fix missing flush CQE for DWQE
      https://git.kernel.org/rdma/rdma/c/e3debdd48423d3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


