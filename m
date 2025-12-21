Return-Path: <linux-rdma+bounces-15121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D655CD3C9D
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42238300D406
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B24237A4F;
	Sun, 21 Dec 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWkZeuNX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFA1C69D;
	Sun, 21 Dec 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766304067; cv=none; b=X+v3kal+AWT1YaFig8tQPZGjc0le2RzaP9lKvAahXvysRPSknV9Xdr6mSSSUzl836PQa4l9b9jAs/c5/AUD0qt8eJaJJBePzZKWnbNYWgD29qMdgo9i+HmC6ALOa2KW5TYCmOcmB8VvYCXqL/JECmwnCdEJg4JPHgBnyg3IafFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766304067; c=relaxed/simple;
	bh=g9JVYGVcNLrTpc1fFB0FQyN2TUtqS94BqakPPSX84VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGVB3HAXO8/z4eCVs/8h+BbNlSId5n0nv1hETTWRmP2zkzzXAUgmZOEO4oFX4QLWatRgseR+VmhBf8b8gBg3UKFtdrtVaiI4aK+HB7DTylgGwcRBtYq4dHenQ0eAAPQp4klLa/nHsg2wGUC1Vy+Efa5iHjHNHTYky9AdXogDVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWkZeuNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B795CC4CEFB;
	Sun, 21 Dec 2025 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766304064;
	bh=g9JVYGVcNLrTpc1fFB0FQyN2TUtqS94BqakPPSX84VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWkZeuNXUlDMI0cV+2jfHGi8JGSRkn8YxqAMPgilK/I9bHCmr4n97VU5ScE0d1cGf
	 Aao3XbilUApV1A3diZYGu8GkmI+SFE6W4YxQ5nFdVgc/ACggNOa7IYFpiP3sJztJ1e
	 lmj5a7ZSTBZCZ/Wz/+kPcpeeahLNPYBwQAPapYCq2Vlgzo9VaKjTglDY1u9SqtZ4Kw
	 qD5+ameAIj6SK9p31nBje+kd2zmZVSbJsJUDpbdiu37VkR/6uMDr9m13rx9DJTfXSw
	 X0OamnqVTlLdIM3ohCqbnv5EPZ+jRWoQvULrsFWmF86iI6Q6r92zK6NOEE+/aq6FWb
	 lesGs0b783w5A==
Date: Sun, 21 Dec 2025 10:00:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ding Hui <dinghui@sangfor.com.cn>, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	saravanan.vajravel@broadcom.com, vasuthevan.maheswaran@broadcom.com
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhengyingying@sangfor.com.cn, jgg@ziepe.ca
Subject: Re: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in
 bnxt_re_copy_err_stats()
Message-ID: <20251221080059.GB13030@unreal>
References: <20251208072110.28874-1-dinghui@sangfor.com.cn>
 <022b32b6-6ed5-465d-af01-a52deea16d62@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022b32b6-6ed5-465d-af01-a52deea16d62@sangfor.com.cn>

On Thu, Dec 18, 2025 at 10:16:02AM +0800, Ding Hui wrote:
> Friendly ping.

I'm waiting for some sort of response from Broadcom people.

Thanks

> 
> On 2025/12/8 15:21, Ding Hui wrote:
> > Recently we encountered an OOB write issue on BCM957414A4142CC with outbox
> > NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
> > we found the inbox driver from upstream maybe have the same issue.
> > 
> > The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters
> > update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ_ERR.
> > 
> > However, BNXT_RE_OUT_OF_SEQ_ERR serves as a boundary marker for allocating
> > hw stats with different num_counters for chip_gen_p5_p7 hardware.
> > 
> > For BNXT_RE_NUM_STD_COUNTERS allocated hw_stats, leading to an
> > out-of-bounds write in bnxt_re_copy_err_stats().
> > 
> > It seems like that the BNXT_RE_REQ_CQE_ERROR, BNXT_RE_RESP_CQE_ERROR,
> > and BNXT_RE_RESP_REMOTE_ACCESS_ERRS can be updated for generic hardware,
> > not only for p5/p7 hardware.
> > 
> > Fix this by moving them before BNXT_RE_OUT_OF_SEQ_ERR so they become
> > part of the generic counter.
> > 
> > Compile tested only.
> > 
> > Fixes: ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters update")
> > Reported-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
> > Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> > ---
> >   drivers/infiniband/hw/bnxt_re/hw_counters.h | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
> > index 09d371d442aa..cebec033f4a0 100644
> > --- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
> > +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
> > @@ -89,6 +89,9 @@ enum bnxt_re_hw_stats {
> >   	BNXT_RE_RES_SRQ_LOAD_ERR,
> >   	BNXT_RE_RES_TX_PCI_ERR,
> >   	BNXT_RE_RES_RX_PCI_ERR,
> > +	BNXT_RE_REQ_CQE_ERROR,
> > +	BNXT_RE_RESP_CQE_ERROR,
> > +	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
> >   	BNXT_RE_OUT_OF_SEQ_ERR,
> >   	BNXT_RE_TX_ATOMIC_REQ,
> >   	BNXT_RE_TX_READ_REQ,
> > @@ -110,9 +113,6 @@ enum bnxt_re_hw_stats {
> >   	BNXT_RE_TX_CNP,
> >   	BNXT_RE_RX_CNP,
> >   	BNXT_RE_RX_ECN,
> > -	BNXT_RE_REQ_CQE_ERROR,
> > -	BNXT_RE_RESP_CQE_ERROR,
> > -	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
> >   	BNXT_RE_NUM_EXT_COUNTERS
> >   };
> 
> -- 
> Thanks,
> - Ding Hui
> 
> 

