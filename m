Return-Path: <linux-rdma+bounces-5994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48169CD638
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 05:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9A4282B8B
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 04:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1715B0FE;
	Fri, 15 Nov 2024 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7TW1z54"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE528366;
	Fri, 15 Nov 2024 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645178; cv=none; b=Hk02jZ058qYmPfXY+87K/Au8WNq/MXBjgLiADNkJs+Hrk/mgsNjb4iFacPir6D5juqzDqfYJGp5MJcWguFaekOrTxEpRzxxn3mHb/UPO+Nk24K5IXrD2cnuiKP1RYr+YNgQ8Hp3K0CJiCb1s9zJpxMmdaP9tdyFYJhI6XOrTCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645178; c=relaxed/simple;
	bh=Kt8JJ2EzNGwvHpwBGZfylQDeIunpNHowQDYBOsuGkAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+Njb3FEr9ypnOul4hig8SEWfAUji8KSjpGULFwFeUFBKmnSkVsEahKj4b/z2u+f5ZRvzGebjT2pN90vzWy4UgN4tl1J+cTc248j3YwN34Jr4c6dMlJ0KEEN2gdXkqLG+0JF1es+tITW0jLFXRNL04BJ2Lcytrg/TSU+NF6cGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7TW1z54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4593BC4CECF;
	Fri, 15 Nov 2024 04:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731645177;
	bh=Kt8JJ2EzNGwvHpwBGZfylQDeIunpNHowQDYBOsuGkAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7TW1z544xaOOk6ZX1LOiRlfeVKJq01lLTZIfQS2tBic7vT2IcxhPMw4RGDEzmfTB
	 LVq+cVPu1siCsaJrjKT30Wk9+fowe5M/wEPHKqXRYgW7Q8kC9cQNuFhu1H0FumdoeU
	 RpPgesRNdhAwApZe1pdrKLDZuGRzsYvmEDNV9SduNC/RMQZPQWdTAMuxMablXxmyka
	 uE/jTmDkgFwoazD1pbqmBEMy3xUM5CVf7cTA+CRmoyuDK5JabxFWJ6/8nTJ29N4lmO
	 x+H/YNEO540obAz0bQByi6NhWZRUulNeZ1CZOlHqkRDLMjxpLCsyUDCKnJUfsZO3P4
	 pkf66mXLUlUNg==
Date: Thu, 14 Nov 2024 20:32:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ttoukan.linux@gmail.com, gal@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <20241114203256.3f0f2de2@kernel.org>
In-Reply-To: <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
	<20241114182750.0678f9ed@kernel.org>
	<CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:56:38 +0800 Yafang Shao wrote:
> > On Thu, 14 Nov 2024 10:17:11 +0800 Yafang Shao wrote:  
> > > - *   Not recommended for use in drivers for high speed interfaces.  
> >
> > I thought I suggested we provide clear guidance on this counter being
> > related to processing pipeline being to slow, vs host backpressure.
> > Just deleting the line that says "don't use" is not going to cut it :|  
> 
> Hello Jakub,
> 
> After investigating other network drivers, I found that they all
> report this metric to rx_missed_errors:
> 
> - i40e
>   The corresponding ethtool metric is port.rx_discards, which was
> mapped to rx_missed_errors in commit 5337d2949733 ("i40e: Add
> rx_missed_errors for buffer exhaustion").
> 
> - broadcom
>   The equivalent metric is rx_total_discard_pkts, reported as
> rx_missed_errors in commit c0c050c58d84 ("bnxt_en: New Broadcom
> ethernet driver")
> 
> Given this, it seems we should align with the standard practice and
> report this metric to rx_missed_errors.
> 
> Tariq, what are your thoughts?

mlx5 already reports rx_missed_errors and AFAIU rx_discards_phy are very
different kind of drops than the drops reported as 'missed'.
The distinction is useful in production in my experience working with
mlx5 devices.

