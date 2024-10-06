Return-Path: <linux-rdma+bounces-5257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB9991EE0
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 16:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C229A1C2126F
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E174040;
	Sun,  6 Oct 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pKW0ASxz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB951BC5C;
	Sun,  6 Oct 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224909; cv=none; b=oke30uvCPoxYRqtVHG4ExrWJW5n2p/tx1ylYeY4JGkoozyCNgEk6odKmZxiuowOc3AlOMF5t5VOEgIODDhlWGYGrk+nXdDli3uNHZGitvmtcsEfRaqXEM27Z1+tWfbE18V0u9G3FFx17FlN5JQWuUFz8ow7jNSIZCrA7LqVuiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224909; c=relaxed/simple;
	bh=2J+HJerAn9SyRTw7kgkXQgQ6VHGpkYCkKcpdJu5CLaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoD19LnIDCyU/xOD5XPoNglsul6O4PjkHMlPMVtM7JFBDQJmtEVZkPuWlYKlgaqPltkhYnvAf8wTD3mURFMmYNYHs7ycy8qczshRgjOE9UdxOhByFwUNPUHEVx+Rg4HREuKXygf72uW7lnkq3aIVadUUiXSC8uEsQi6cd0cdLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pKW0ASxz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=BYh/uadcx7hpMbZYA5L2kaBD9nu6GyrJfQav8HzP/z4=; b=pKW0ASxzWvHn9+AQ
	Tfonil8qru3keyWNFfQql17VFACzSoq1Bc+Nzfwulmu8EiomaU5ipO7gbTzO/Xb4XPJtIyQz9FmNv
	qxr9qovQ0TfxKDfUPMbYZVn4TVVH+IyXUiuEZfZs2BMN6pVBdHRUmhUzqz5uhw1BNWP5YRCZudehg
	fQtV1GFsg8C0gG2awWrLghDI/9q4cFG8EQbOuhdEMFSHtGLmqTbm8Jifo8nO1WTt4V+HbJVu/wAWx
	Iut8CjkIA5+bD+gUo2DG3o9TDsIY3xeYABJxmaJupH/1yq0cAZ800kE7uJKh67fkA3Bive80NeUsN
	3vOuJ/ozQBs0q0f2hg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sxSFB-009GmO-03;
	Sun, 06 Oct 2024 14:28:21 +0000
Date: Sun, 6 Oct 2024 14:28:20 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: maorg@nvidia.com, bharat@chelsio.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: of c4iw_fill_res_qp_entry
Message-ID: <ZwKehJ34PzNN6FQx@gallifrey>
References: <Zv_4qAxuC0dLmgXP@gallifrey>
 <20241006140558.GF4116@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241006140558.GF4116@unreal>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:27:10 up 151 days,  1:41,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Leon Romanovsky (leon@kernel.org) wrote:
> On Fri, Oct 04, 2024 at 02:16:08PM +0000, Dr. David Alan Gilbert wrote:
> > Hi,
> >   One of my scripts noticed that c4iw_fill_res_qp_entry is not called
> > anywhere; It came from:
> > 
> > commit 5cc34116ccec60032dbaa92768f41e95ce2d8ec7
> > Author: Maor Gottlieb <maorg@mellanox.com>
> > Date:   Tue Jun 23 14:30:38 2020 +0300
> > 
> >     RDMA: Add dedicated QP resource tracker function
> >     
> > I was going to send a patch to deadcode it, but is it really a bug and
> > it should be assigned in c4iw_dev_ops in cxgb4/provider.c ?
> > 
> > (Note I know nothing about the innards of your driver, I'm just spotting
> > the unused function).

Thanks for the reply,

> It is a bug, something like that should be done.

Ah good I spotted; out of curiosity, what would be the symptom?

I don't have the hardware to test this, can I suggest that you send that patch?

Dave

> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> index 10a4c738b59f..e059f92d90fd 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -473,6 +473,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
>         .fill_res_cq_entry = c4iw_fill_res_cq_entry,
>         .fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
>         .fill_res_mr_entry = c4iw_fill_res_mr_entry,
> +       .fill_res_qp_entry = c4iw_fill_res_qp_entry,
>         .get_dev_fw_str = get_dev_fw_str,
>         .get_dma_mr = c4iw_get_dma_mr,
>         .get_hw_stats = c4iw_get_mib,
> (END)
> 
> 
> > 
> > Thoughts?
> > 
> > Dave
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

