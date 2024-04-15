Return-Path: <linux-rdma+bounces-1943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A28A4C4C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D333289200
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AA55C13;
	Mon, 15 Apr 2024 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bXufvXnX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F57535DE
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175843; cv=none; b=kqoNo4n/XhSOWjUb2+vTxdHhELRijkNSUikoSXaBi60QZF10ADWuKWokKBcSIHuISt1V4YObK61Mb40Q8JI9KuDyCMSULyX2EgTte916mTRBAL9X9vUOhDTu3UZBOpdwxqrjrWeyUzwVaunngoEcLdogWY5IUpoJnLdsl+oUnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175843; c=relaxed/simple;
	bh=xtEvJXeB7TFIKE1VSuFziriDSPPc8slBHNGUqnsibA8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuM523fERl12v/0prN+tjG/UxFoSE3HOSOiUpvA1IVl/ZJjLyCxFeRvHDpG7BSgLtPLBP2VGcOwRL5AMuJXGhRmSrTAmx6sbw4h3JtYcrAG4Goyy39xxEWuaBj7NLvreCevbM2wgdjYBgCtxGc4n/LBB/CZk9TApkZuRHQq+29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bXufvXnX; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=b3HAD4ydMoQfpSaOVQmz9wRl5t2xMfb3rTewFQHV5lQ=;
	b=bXufvXnXxll1Dasid2WxB8u9Pm3SIOmQuFCgxvYsrtYF59C+Onx5RdgFwvenTj
	6oWhCd+cdQ0hZSOlLOo1AJcQGv0Ux1xd5WlgXxwJL2vRgXBjDtQ7tE8IwwuyGdLh
	TFDQa20KPpYkFrGtnqYH6C1Qy5EP/rHTFXEb1vJSn3JWk=
Received: from localhost (unknown [183.81.182.182])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDnL50S_RxmJRxpAQ--.8924S2;
	Mon, 15 Apr 2024 18:10:27 +0800 (CST)
Date: Mon, 15 Apr 2024 18:10:26 +0800
From: Honggang LI <honggangli@163.com>
To: linux-rdma@vger.kernel.org
Subject: Re: Question about extra 40 bytes needed for UD receive buffer
Message-ID: <Zhz9EkBFTZjzp4Wg@fc39>
References: <ZhyXEOC9SMIxjXP1@fc39>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhyXEOC9SMIxjXP1@fc39>
X-CM-TRANSID:_____wDnL50S_RxmJRxpAQ--.8924S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4xJF18Kw17WFWDKw45ZFb_yoW3GrXEkF
	Z7ur1DJ3W7Xr4Utw1Iyw45JrW2ya9xCrWF9r1xWrnYkryfKr45ZFn8WF9Ykw15CF4S9Fy5
	WryfGw18ZwnxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtyxR7UUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiWxXBRWV4IPM4DQAAsx

On Mon, Apr 15, 2024 at 10:55:12AM +0800, Honggang LI wrote:
> Subject: Question about extra 40 bytes needed for UD receive buffer
> From: Honggang LI <honggangli@163.com>
> Date: Mon, 15 Apr 2024 10:55:12 +0800
> 
> However, I'm confused by the dump of `mckey` receive buffer. The flag
> `IBV_WC_GRH` is set in `ibv_wc.wc_flags`, but there is no GRH in
> the receive buffer. Received data starts from the *first* byte of
> receive buffer. As multicast over UD QP only, can someone please explian
> why there is no GRH in receive buffer and the data starts from the first
> bytes of receive buffer with `IBV_WC_GRH` was set?

Please ignore this. I made a mistake with the offset of the grh.

There is a valid IP header in the receive buffer of 'mckey'.


