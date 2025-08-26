Return-Path: <linux-rdma+bounces-12932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471CB3593D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A85E0053
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB33090F9;
	Tue, 26 Aug 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KFwwnzEJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD720296A;
	Tue, 26 Aug 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201311; cv=none; b=g4GshgRGS423opfXI/ivVGpnW6egII/phz+tcceCbJdh7T6IFnkDS28WpAG9GnS3aAxEHBcDFHaBkN9oX9JQOWcUj8ktaVOqACBCWmCm7VaYUE4VFeYhveq5rH9AVqOKz1xjGtH7iReokSKK3A25o1dLn85zfblgxyarpiYsw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201311; c=relaxed/simple;
	bh=pbYYpp1LAr+XsA8jw4TaHNHdtZ8ZJPAkZGYMfRowu1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9y0yo33MyXznx2kpxVsVHVkpXT+d9pbJmf3A1hIhOYf3GY/zoYJEh09f621CUZegF4nRnmYrkYQqO1INo80z4cPUW6dI7GQ+m3jB2DEH283Edy6vCh0TdMm1j1P/jtc6FoRkOIDqzJUxPG9cvHiajrhwfFDE75d9zGsQ0FYQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KFwwnzEJ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756201299; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=L5aHxQGsGMmU/bD0hzyPYIFWvb2aDwchPgHzI2tmZ+g=;
	b=KFwwnzEJuGn+H8hGraI4anbY8nW7jhv+rF/fj4BBk/wTAP1bd6AIhSLJzwB/hP4zvxR7feSBGEXfMYiW7sfTkQjIzhm07jh9d7Vl0+SiKIK698tVT6xdF5jvcuGa/v2zM17qnQovGE4LeMy8OiRVf7oFOHP4OsDMMCx1tFPlQ90=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WmeU8Zt_1756201298 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Aug 2025 17:41:39 +0800
Date: Tue, 26 Aug 2025 17:41:38 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Liu Jian <liujian56@huawei.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	guangguan.wang@linux.alibaba.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
Message-ID: <20250826094138.GA67990@j66a10360.sqa.eu95>
References: <20250826084442.322587-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826084442.322587-1-liujian56@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Aug 26, 2025 at 04:44:42PM +0800, Liu Jian wrote:
> BUG: kernel NULL pointer dereference, address: 00000000000002ec
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 28 UID: 0 PID: 343 Comm: kworker/28:1 Kdump: loaded Tainted: G        OE       6.17.0-rc2+ #9 NONE
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> Workqueue: smc_hs_wq smc_listen_work [smc]
> RIP: 0010:smc_ib_is_sg_need_sync+0x9e/0xd0 [smc]
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 53828833a3f7..85501d2c1f1b 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -747,6 +747,8 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
>  		    buf_slot->sgt[lnk->link_idx].nents, i) {
>  		if (!sg_dma_len(sg))
>  			break;
> +		if (!lnk->smcibdev->ibdev->dma_device)
> +			break;

Why check it inside the loop?

