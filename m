Return-Path: <linux-rdma+bounces-13350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4CB56FD3
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 07:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0643B6679
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972D5277CBD;
	Mon, 15 Sep 2025 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRryVl1k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C7277814;
	Mon, 15 Sep 2025 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915307; cv=none; b=SAUZUo1xvdhJbq2CX8BaMUm/9BckTJqiKdsXypb+u4UrCiQrytKIPseTLW+BwyvnmK1aYtCCaMUJUu/wuu2gjfQ7VQJ6opa4D97oMmfeDs8XgEte+2hJYiPPPILCNOjI+XRSJfavPR838PFldEcc6wEb669/q2rtKPUg1dk4kqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915307; c=relaxed/simple;
	bh=nDGZYmOVK3BHyovdEwLI+pkBn1mmcoe5MNbBS1U05Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM35SUQlEz71qDqiGPNNzO8nKoV06yJCHEL92lRqvaGzI0M4AMhrGmBDj9ObiP0wOGNBg1LCRLi3iTfPW29w1REc96f2c4icMvt5dcrDqieRzdoVWYnsvVSlSErdc7EdRUzwytwSvXPUrE3UOOAX+Bno4ol1vhbeIcFAyCAXDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRryVl1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BB7C4CEF1;
	Mon, 15 Sep 2025 05:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757915306;
	bh=nDGZYmOVK3BHyovdEwLI+pkBn1mmcoe5MNbBS1U05Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRryVl1kj48MZS2gLanXzQi1bHUnNSgCURmkRfmBVcm2y4EXJENs8ktffrEGhn5q0
	 2AYwWNMewDKF0m8hHHG/8R39U71l1qm3QTTz26ImA2eTX61gegMWJXaIVLWHufkzmt
	 6aRKund/R6fXLnWH8cZmXqar5MFD3xJLjO13QHLcVrwLRRzWPB8/ChL3r5/eB7HAph
	 go5eqPES+QPF6YFSJPjpzPfkj5vwyPHIgjwNpflGLCOq/31Jy0QfjWFjw3Kna6E6XI
	 5dtmw0RTtkDaxKl4vHdlON9Fi3DbckoBd8YJktWDzL3djvaAk3DUavi/2VwoCH1Ra1
	 iibvKzyNcnXXA==
Date: Fri, 12 Sep 2025 12:07:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>, alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy for ib_name
Message-ID: <20250912090713.GV341237@unreal>
References: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
 <20250910100100.GM341237@unreal>
 <24ced585-1b7f-4577-9cb5-8d6e60ecb363@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ced585-1b7f-4577-9cb5-8d6e60ecb363@linux.ibm.com>

On Fri, Sep 12, 2025 at 01:18:52PM +0530, Mahanta Jambigi wrote:
> On 10/09/25 3:31 pm, Leon Romanovsky wrote:
> >> --- a/net/smc/smc_pnet.c
> >> +++ b/net/smc/smc_pnet.c
> >> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
> >>  		return -ENOMEM;
> >>  	new_pe->type = SMC_PNET_IB;
> >>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
> >> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
> >> +	strscpy(new_pe->ib_name, ib_name);
> > 
> > It is worth to mention that caching ib_name is wrong as IB/core provides
> > IB device rename functionality.
> 
> In our case we hit this code path where we pass *PCI_ID*
> as the *ib_name* using *smc_pnet* tool(smc_pnet -a <pnet_name> -D
> <PCI_ID>). I believe PCI_ID will not change, so caching it here is fine.

If I remember, you are reporting that cached ib_name through netlink much later.

The caching itself is not an issue, but incorrect reported name can be seen as
a wrong thing to do.

Thanks

