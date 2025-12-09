Return-Path: <linux-rdma+bounces-14935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBEECAE9C8
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 02:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80223012DDB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 01:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F8277026;
	Tue,  9 Dec 2025 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="orX610IJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87A270553
	for <linux-rdma@vger.kernel.org>; Tue,  9 Dec 2025 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243088; cv=none; b=jIYHz82givKwIW+XxhAMhnnKmdOxvZgIZcymmi54/vV7my+QQFy7UfTYMoG7PNq9PKycK+/b8e+NGP0sSH1GgTyZgkKfWFmmrd5+C8D2sDNno2Uu70XXoJ7lhy8RbmHH5BNVKOh6+eZdPpLTKHpyqF9ixHFhj/d4xGikxeZIsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243088; c=relaxed/simple;
	bh=qUEMAy/edX16acAYBb9LboGkSC7ImdhOF1wk7jl/cpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoA5fd4W3/YrXbZzAm0O1QgHqyM5bjOrHwc8oyMyAqJT7inntQW9fdd3hAdkhtG/0ruNSP4Qh7UKE7xzQhABCk0tHXqygYiYPurNmI5ZNAgeqFzlkFOnxbxn0HAdvizZxXQLlAGrZ9kJj+CsmjuQCeZe7ntEh3tKeWA3dVpzhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=orX610IJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=AkC1feVMdupjD3+EGVRXr4/zUnPJLvnG1rtVQMhrWjo=;
	b=orX610IJ+pS+fU1hcGS53QfE9V7J6tx9FZx9ZGiZvJ3JaXV7rj/oSF6tETPsr+
	vcMZmEB//XI51ZbtXzS6ItViIWh6xIfTgfUSOoluFm7a5XrpgbKT7GLIa79/F0QZ
	NGa7HVeKzswKFp1fdxaUMIswDBYlc5xSbx0RB8gZE0Fbc=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXSTCfeDdpQ+iUAg--.33520S2;
	Tue, 09 Dec 2025 09:17:20 +0800 (CST)
Date: Tue, 9 Dec 2025 09:17:19 +0800
From: Honggang LI <honggangli@163.com>
To: Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
	jgg@ziepe.ca, jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com
Subject: Re: [PATCH 6/9] RDMA/rtrs-srv: Add check and closure for possible
 zombie paths
Message-ID: <aTd4n-mGUSP_kk11@fedora>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-7-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208161513.127049-7-haris.iqbal@ionos.com>
X-CM-TRANSID:_____wDXSTCfeDdpQ+iUAg--.33520S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW7trW3Jw1kXw13ur47twb_yoWxZrX_Za
	1Yga92vrWDAFsrJ3ZFqrWxu3s5Ca1UX3Z3JasYgFWUZw15JrW5WFWkXr1rt34DJw1FkFnx
	WF15Ww1kXrZ3AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb2YLPUUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiFRMfRWk3c4WLYQAAse

On Mon, Dec 08, 2025 at 05:15:10PM +0100, Md Haris Iqbal wrote:
> Subject: [PATCH 6/9] RDMA/rtrs-srv: Add check and closure for possible
>  zombie paths
> From: Md Haris Iqbal <haris.iqbal@ionos.com>
> Date: Mon,  8 Dec 2025 17:15:10 +0100
> X-Mailer: git-send-email 2.43.0
> 
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -911,6 +911,13 @@ static int process_info_req(struct rtrs_srv_con *con,
>  				      tx_iu->dma_addr,
>  				      tx_iu->size, DMA_TO_DEVICE);
>  
> +	/*
> +	 * Now disable zombie connection closing. Since from the logs and code,
> +	 * we know that it can never be in CONNECTED state.
> +	 * See RNBD-3128 comments.
               ^^^^^^^^^^^^^^^^^
What is it? How to access it?

thanks


