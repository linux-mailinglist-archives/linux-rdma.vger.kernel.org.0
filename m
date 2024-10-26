Return-Path: <linux-rdma+bounces-5526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0A9B141F
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 03:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9C52831C1
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F32AD2A;
	Sat, 26 Oct 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hwYrQ3Y6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4069217F33
	for <linux-rdma@vger.kernel.org>; Sat, 26 Oct 2024 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729907919; cv=none; b=DDbkPjGiQ6xi/dXYjCCAANSeZsFjUmgxkpMMubDpjyO+baoruZBsfkkc+IrIFJZV7Q2bCIk80MLXmiMGPCG6xsv6htdo3p6947ZlM+y3dIUOUQmyxJR6ztvs8h+ektZ+ZAAG+HK2gcsPbDJ34G3+2hyuPX6/d59DdAN9T/pnSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729907919; c=relaxed/simple;
	bh=yCnCgXXkfqnGbIDwqMbfsa7PGb9OHXr/kSenDqyXqFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsokLwSTEUWd2gXbBtMNzgvsxFuYzGSBBh5YUncg4aQwjqXSfYHs3PY2eJSVZmskBL3IwTeF5MUu0APsTeSJLbqTxiEyt/s2kfpa2O7ocw0ddJU5yEfMppi+JXv730yRuo0t7AFWAwak7sm/fc6At30qaLUxuK8HsxGt41rwvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hwYrQ3Y6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=chdnx395f9v1Ftze0BSPD8tkIR0/tFhNq409RFG+3J0=;
	b=hwYrQ3Y6O5NNDDLaF5clMJ9475RDKF93jfVebMYW3xKppeFd9yeaouE83CKCcx
	JZJEW1Gg95461/EMTr2567fkIO3rPOsywqz0oBd8hVk9cQis7xbNCqBS60prjnRF
	uU5LIG+6d0nWg70fl59zRD+Dba/le4t3z3c/aupluq4nc=
Received: from localhost (unknown [125.33.14.1])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCnD0ipTBxnn8eEDQ--.14248S2;
	Sat, 26 Oct 2024 09:58:02 +0800 (CST)
Date: Sat, 26 Oct 2024 09:58:01 +0800
From: Honggang LI <honggangli@163.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the qp flush warnings in req
Message-ID: <ZxxMqWp0oCJxPq64@fc39>
References: <20241025152036.121417-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025152036.121417-1-yanjun.zhu@linux.dev>
X-CM-TRANSID:_____wCnD0ipTBxnn8eEDQ--.14248S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4kXF4rZr4fGw1ktw4rGrg_yoW3Awb_Ww
	1UA3s7JrWYkrnay347KrZ8W3y2ya1Yvr1kZw1Yqa4DZ347XF93Aa48Jr15Cw1UZF4UCr45
	Ar17Jwn3KFWkujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjpwZDUUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDw6ERWccRqpp4gAAsc

On Fri, Oct 25, 2024 at 05:20:36PM +0200, Zhu Yanjun wrote:
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 479c07e6e4ed..87a02f0deb00 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -663,10 +663,12 @@ int rxe_requester(struct rxe_qp *qp)
>  	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
>  		wqe = __req_next_wqe(qp);
>  		spin_unlock_irqrestore(&qp->state_lock, flags);
> -		if (wqe)
> +		if (wqe) {
> +			wqe->status = IB_WC_WR_FLUSH_ERR;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Why not update wqe->status in function `flush_send_wqe()` ?

thanks


