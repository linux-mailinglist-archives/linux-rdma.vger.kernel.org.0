Return-Path: <linux-rdma+bounces-15142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED55CD5354
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A9F1300E3F7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611930EF7C;
	Mon, 22 Dec 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kASa6Ycv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4828E579;
	Mon, 22 Dec 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393793; cv=none; b=KH3tcwIPKgUauOIETfy1vEhoM3Ab1gFrHVRZY8tmdd4nhBK3tJnobskesOQuLFKWdKUGEL9ErRKF4O1EZBYMMZEXNcz7zrjAYlqIuUh4jXNbBBiVHXEhGzg+Xr0SlwuafkGoW2ClvxvNQzl+6vxlw6xAh3dSPtOgiovWTmMMBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393793; c=relaxed/simple;
	bh=BEHjMy7vUVs/73lX6qquEsmM0W2KvgMI4iADBFTOgcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRlibiLxLuHqHwM3kCSejzmpeZZPHdHxBJAzoUhY+iP+ttNhhPqbrrKfNiQr5aMnmjKNjlyj8kmLlqtrm6/2PtgAyzuRoYKzMVT2vIknBC2+8xJVt+5eTLAcUKENUxIJUnC35JEBkhdAhypv8iFAE5AfZL8t257YcQF+Sv3oTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kASa6Ycv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1E5C4CEF1;
	Mon, 22 Dec 2025 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766393792;
	bh=BEHjMy7vUVs/73lX6qquEsmM0W2KvgMI4iADBFTOgcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kASa6YcvcMArbdRKDPXEVGOjjW9ltHVRJzEVW7ifzX4tvECI0g24kBpXLKqz0id2f
	 c2tFXyU59rKo1HHh1GWm/8wKcFx9VjOsDgkQ5dHvkFZC7sgCqveSni8TnYmHFXFQu8
	 IUNDdFPnIdY803RTA3tdD1Rl4xTJSDCr8eyvPsLuLAlq3TS4F9ME2v4YoArEbnKT0V
	 JW5vpXV5T3GalcvPqzDWyaNAQz0hG265V9djytz90X/0InZEvISWqiefjDbHDDqliI
	 OJgBK/Qb3/YRYJgcCUdHJcFTTBmCfUuBKjU5WQYXvhtU2k37cOLwnz8CVK7ef/2CYg
	 METGo8Ndl23Yw==
Date: Mon, 22 Dec 2025 10:56:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	selvin.xavier@broadcom.com, jgg@ziepe.ca,
	saravanan.vajravel@broadcom.com, vasuthevan.maheswaran@broadcom.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhengyingying@sangfor.com.cn
Subject: Re: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in
 bnxt_re_copy_err_stats()
Message-ID: <20251222085627.GB13529@unreal>
References: <20251208072110.28874-1-dinghui@sangfor.com.cn>
 <CAH-L+nMzQ9Xcm0WukZjJM4owJ5+wXoF31arRxPs=5-k=Y5LQfQ@mail.gmail.com>
 <51ecb35a-4caf-43c6-b5ac-bc4b94462577@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51ecb35a-4caf-43c6-b5ac-bc4b94462577@sangfor.com.cn>

On Mon, Dec 22, 2025 at 02:33:59PM +0800, Ding Hui wrote:
> On 2025/12/21 23:47, Kalesh Anakkur Purayil wrote:
> > On Mon, Dec 8, 2025 at 12:52 PM Ding Hui <dinghui@sangfor.com.cn> wrote:
> > > 
> > > Recently we encountered an OOB write issue on BCM957414A4142CC with outbox
> > > NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
> > > we found the inbox driver from upstream maybe have the same issue.
> > > 
> > > The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters
> > > update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ_ERR.
> > > 
> > > However, BNXT_RE_OUT_OF_SEQ_ERR serves as a boundary marker for allocating
> > > hw stats with different num_counters for chip_gen_p5_p7 hardware.
> > > 
> > > For BNXT_RE_NUM_STD_COUNTERS allocated hw_stats, leading to an
> > > out-of-bounds write in bnxt_re_copy_err_stats().
> > > 
> > > It seems like that the BNXT_RE_REQ_CQE_ERROR, BNXT_RE_RESP_CQE_ERROR,
> > > and BNXT_RE_RESP_REMOTE_ACCESS_ERRS can be updated for generic hardware,
> > > not only for p5/p7 hardware.
> > > 
> > > Fix this by moving them before BNXT_RE_OUT_OF_SEQ_ERR so they become
> > > part of the generic counter.
> > > 
> > > Compile tested only.
> > > 
> > > Fixes: ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters update")
> > > Reported-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
> > > Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> > 
> > Thank you Ding, the fix looks good to me and I have verified it locally.
> > 
> 
> Thanks for confirming.
> 
> Do I need to resend the patch without RFC prefix and update some commit log,
> such as getting rid of the first paragraph about the outbox driver?

No, there is no need. I'll fix it locally.

Thanks

> 
> > Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > Tested-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > 
> 
> -- 
> Thanks,
> - Ding Hui
> 

