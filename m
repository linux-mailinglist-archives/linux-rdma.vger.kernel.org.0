Return-Path: <linux-rdma+bounces-11999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E6AFE185
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0423AAD8A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE33270EAB;
	Wed,  9 Jul 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBE/K7Mn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7E1E7C27
	for <linux-rdma@vger.kernel.org>; Wed,  9 Jul 2025 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046907; cv=none; b=CcdGLfTFF+wj4/WJt3gWWrlyCrrFLwSS1QNdCjIeIoUPsZsf9sBfYRRk3c95vwTd5nVryETaUxc68h6eS/ZTReHzREtRSssOD4MDY2l99/5GO6UfyumVkXl7TQ/Pl1W/MAUrh7K7j93ZN9PffA8BwPzrGDeuB2gVjzQJvxe6CFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046907; c=relaxed/simple;
	bh=GCV4drPw0+jat0xwnZLct0tg0Txu4LA7I88g2U5kO74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YSoY6s2XZsqJ126bhXVD2W1LuDyBCuIbDM+3SakHjJlA8AbBGFkuFUVU7pzPMyN/SLYHDnAO2B0WJ0gZWDriIlEja4bC1C4Q2Pkr1H9gENPony+Ogzjxp/HFK9y8UKpYcW1VYPkoLp3tGvdUs5CSihm1EOFO0KruxSfXKZQxdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBE/K7Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0705DC4CEF0;
	Wed,  9 Jul 2025 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752046906;
	bh=GCV4drPw0+jat0xwnZLct0tg0Txu4LA7I88g2U5kO74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QBE/K7MnBfvohlRipdpJMzCsj/OTEnNg8/zsDN6/eQsflFapUDeFRkFa5iOWf3tbv
	 hbJjAQZxDDbgIs/S/Jtz83SpUSBZbeuWKfa3SIYjXm47fTfodSjZrqlAmy2GBjKNRg
	 n62/YeglQqxoIQ8ztJYIBQkikxi/2mx8BTAg1IFSTPvRJZj7dPUtmicG1yJ7KLwmet
	 YORti9ShZC9WjKFyes5WiEb32KjgkGWoeQYaqoLAp8wf04a7jOFleXbcALd9ofkpG+
	 VKUg7ltDj+gaxZKGWmWoOiGljB8H/B7lzEeZU43ouax9pbNYpvi+tAFBgpIPrBRmZH
	 juEQ+aj6uP1iQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org, 
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org>
References: <72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Add empty
 rdma_uattrs_has_raw_cap() declaration
Message-Id: <175204690283.1576690.15545962108398586577.b4-ty@kernel.org>
Date: Wed, 09 Jul 2025 03:41:42 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 08 Jul 2025 12:31:39 +0300, Leon Romanovsky wrote:
> The call to rdma_uattrs_has_raw_cap() is placed in mlx5 fs.c file,
> which is compiled without relation to CONFIG_INFINIBAND_USER_ACCESS.
> 
> Despite the check is used only in flows with CONFIG_INFINIBAND_USER_ACCESS=y|m,
> the compilers generate the following error for CONFIG_INFINIBAND_USER_ACCESS=n
> builds.
> 
> [...]

Applied, thanks!

[1/1] RDMA/uverbs: Add empty rdma_uattrs_has_raw_cap() declaration
      https://git.kernel.org/rdma/rdma/c/98269398c02ab2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


