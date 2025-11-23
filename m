Return-Path: <linux-rdma+bounces-14700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8353C7DDFB
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 09:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EFE94E1DE5
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0A28489B;
	Sun, 23 Nov 2025 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbvVrdpK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7C21A449
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763886976; cv=none; b=TWQhKrwsvdc6wAo0BoQ+hKjku/LOqGsPQgbpftFRRTBTLOvs2c4s2PiChp366DMrUf1tIB3rYfDDlhRpLXUJjh3sqW+1E0+jv7ZcU1Q4rCWzvrkIHUUnTdKtQ4ToR3/YGd8tqNRqSi/VGo+lBqyHPoptbE7H25qFk8drEmtnpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763886976; c=relaxed/simple;
	bh=acvCBwhGKf71JE/uFJ8URI63jkutd2+s/xJ9eWOzm30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U2dbT86krJ3nn9fMeLbXqU2ANTr2fLyeEzwCTCNPipODZiy268KsW1hILFypG9ZGMkgU8uPNDJ/7Trg9nnziapuvMsTQELE1ruDCZ9dzaI+9hTQRTd8dRA0xbdKzLM4peER1t1VB+B7010lQAkL1hOyIXNX/Plc01R/T8/Nf1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbvVrdpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9CCC113D0;
	Sun, 23 Nov 2025 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763886975;
	bh=acvCBwhGKf71JE/uFJ8URI63jkutd2+s/xJ9eWOzm30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rbvVrdpKhgjVcLhgq9Fai9NgXgAKvxUqCbLC9KejLmY25Tz3rO1IydNxxvcMPBfVc
	 71KYQTvaM32A3Ce0RZRxyHZO3roVgCcZVoGYQFQqO3GturDqcGev6qpS5n7hzkfQlT
	 MLRTTtqnpmiA8SCyjCltGYqmqxQxWR9dKooyVpu9n6e4OH6Y0edYwL4ImLKe3mxSWK
	 vch8nf7UiPFbEa9DbOA0MuSYxcRk4KuuJNJv36Q4gchZyB7trHTdo5JTEgi8+1d5mc
	 7WZpkDOkUr4ONrXezDJk0TLBSgLYRkFN7UzgJeNV9IG5Gw4a9Drl8pXhH5eqWpmvrM
	 HpaL67vE6uhAg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20251112093510.3696363-1-huangjunxian6@hisilicon.com>
References: <20251112093510.3696363-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v3 for-next 0/8] RDMA/hns: Support RoCE bonding
Message-Id: <176388697253.1782849.16149251557488712036.b4-ty@kernel.org>
Date: Sun, 23 Nov 2025 03:36:12 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 12 Nov 2025 17:35:02 +0800, Junxian Huang wrote:
> This series adds support for RoCE bonding. The bond mode is active
> when multiple PF netdevs are enslaved to a bond master while all
> following rules are met:
>   * All the slaves are on the same card, i.e., they share the same
>     bus number.
>   * The bond mode are set to mode 1 (active-backup), 2 (XOR) or
>     4 (802.3ad).
>   * None of the slaves have generated a VF.
> 
> [...]

Applied, thanks!

[1/8] RDMA/hns: Add helpers to obtain netdev and bus_num from hr_dev
      https://git.kernel.org/rdma/rdma/c/c1f6bb0b902987
[2/8] RDMA/hns: Initialize bonding resources
      https://git.kernel.org/rdma/rdma/c/e7866309b37d76
[3/8] RDMA/hns: Add bonding event handler
      https://git.kernel.org/rdma/rdma/c/8cecb218f01a7a
[4/8] RDMA/hns: Add bonding cmds
      https://git.kernel.org/rdma/rdma/c/8ffde55747b796
[5/8] RDMA/hns: Implement bonding init/uninit process
      https://git.kernel.org/rdma/rdma/c/4e10539fb33546
[6/8] RDMA/hns: Add delayed work for bonding
      https://git.kernel.org/rdma/rdma/c/bffb0934602694
[7/8] RDMA/hns: Support link state reporting for bond
      https://git.kernel.org/rdma/rdma/c/44c2d40340ac30
[8/8] RDMA/hns: Support reset recovery for bond
      https://git.kernel.org/rdma/rdma/c/c7d2ba8b19256c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


