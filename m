Return-Path: <linux-rdma+bounces-3636-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF0926E9C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 06:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1417D1C21C47
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 04:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78C12E1C1;
	Thu,  4 Jul 2024 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2UK4/4I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8161B963
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720069037; cv=none; b=BNpfgTYl6SOKu7hn0vxkclAPlMDIUEcqBVr7bcF5WzirsRp42fAUWF0zkM2T+xtCykEI4GfGMMBbUk5JeagsusesWPJVFJc4wgCf3P0ULhKt/IRLaUY1U2dZR41whusym2z9/eYwvNtKbvemvSI8RIJMY3NCLYKLDOxQp8bYPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720069037; c=relaxed/simple;
	bh=CCnSQKngaIrbHQTeZ6O4CU0VH5rwuXUACT/LC8H1RXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JCWDSmZWLmbnSvR76jKMjT6kwoETxGxOkPmi6zXhNaTSrEjI7ezYqMHBqRPGCX3k5BE3uqNkypSHRp4FJq9YsjP5LiKCsaN4+qAwhHtJBqylmYh2agVYD8JZQfyCxkxjvTxgxLER4CguQNzhOmz75GV2iVqy3BsPEdkVeb007Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2UK4/4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D07C3277B;
	Thu,  4 Jul 2024 04:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720069037;
	bh=CCnSQKngaIrbHQTeZ6O4CU0VH5rwuXUACT/LC8H1RXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c2UK4/4IiQYJCMFdZ6f4HZuIqL8HQt/Yl7x9EcBRjFTwB3YERoohDXIY/Jb2FueJO
	 3siWN3Nzgfz1zEx1uB76F2DRr7PkUxHtoDgK7ln3U5lxjVgamDRuW66tn9p4rsQPf0
	 7/sbZF8TxngRWOyy6NzbNGHgzIItalGvNBk9tvRFOZnMFrdldupG0hLXCAf8GVQF0g
	 XfbpTwgtWWSM1tFnceooknw+/+gaymyNMZ2O975L2Izai0i/snEuBLfS9w0VgL0EEp
	 YTKjsk9rCJ/gmBpVncEEAsrcnzGp+i77jT8DKewe5QPEnRbv8ozFVfTMmdawVmIFMk
	 PgS7iptbU3Ozg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
References: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] RDMA/qib: Fix truncation compilation
 warnings in qib_init.c
Message-Id: <172006903262.578444.8393830029454500717.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 07:57:12 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-13183


On Mon, 01 Jul 2024 15:42:28 +0300, Leon Romanovsky wrote:
> drivers/infiniband/hw/qib/qib_init.c: In function ‘qib_init_one’:
> drivers/infiniband/hw/qib/qib_init.c:586:67: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 3 [-Werror=format-truncation=]
>   586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
>       |                                                                   ^~
> In function ‘qib_create_workqueues’,
>     inlined from ‘qib_init_one’ at drivers/infiniband/hw/qib/qib_init.c:1438:8:
> drivers/infiniband/hw/qib/qib_init.c:586:60: note: directive argument in the range [-2147483643, 254]
>   586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
>       |                                                            ^~~~~~~~~~
> drivers/infiniband/hw/qib/qib_init.c:586:25: note: ‘snprintf’ output between 7 and 27 bytes into a destination of size 8
>   586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   587 |                                 dd->unit, pidx);
>       |                                 ~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> [...]

Applied, thanks!

[1/2] RDMA/qib: Fix truncation compilation warnings in qib_init.c
      https://git.kernel.org/rdma/rdma/c/1b8ca05469315e
[2/2] RDMA/qib: Fix truncation compilation warnings in qib_verbs.c
      https://git.kernel.org/rdma/rdma/c/f802078d3cb882

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


