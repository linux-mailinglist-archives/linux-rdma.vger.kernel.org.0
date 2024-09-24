Return-Path: <linux-rdma+bounces-5067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A9984727
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46ED31F23CA4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA261A7265;
	Tue, 24 Sep 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFwUkwRt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2714F124
	for <linux-rdma@vger.kernel.org>; Tue, 24 Sep 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186431; cv=none; b=FjpB0tODsPeNNJ55otdYT3U5PXjF+RkSetWBkgWzteKpRUx5OJAke6v09Fz80wrx1W7Cvp8rwJ3FVOki2TUCunWm+OgmzhPeWfh218iAUOI5PpBFhdV8ehLLGtR+WT2WKGJTjVG3oVnzk2QV+MV6RKtJ+hGTyvQ7KKjjPSnuz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186431; c=relaxed/simple;
	bh=fixrlPHEgUA0vFgbRgg4LkKH0q/ZNvRtE7c3tbD2k8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h36GEmP0pT9UDevy7HnXKSJqOjpMhgfVdket4RmPmcMDrR4wLKytHtSBLxGpXk2ngx4cVO7daYDAiGwKUNvsCi4sVEK1j93Wsqzqx9QOZMGUsyFlsiRCFsLTDiSk7oQIVQOBhsLOJeVgJxMkujK4YBosbH//rgZYBONcPYuCQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFwUkwRt; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ad540cb-bf1b-456b-be2d-6c35999bdaa8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727186426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLj2Ln7J0S/EN+yRyPUamFxxGpjK5Shh/dBbx2aJWZ8=;
	b=gFwUkwRt6LD+M2xlJMJa6SEVpw/h5u7spymcDMrY3Pgnnh0rS0Z9XL2aUQGzZweaecdKcg
	5SAghNMdDQ4DIcEZx8ypqsqGG2PD3IvHg7VDP0/3nBnAVRzn69cBoB8Y/aI6SaG5gJewm0
	3We5NcDuvdzFwzx5Wt+W7REpfr4sGQc=
Date: Tue, 24 Sep 2024 21:59:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
To: Christoph Hellwig <hch@infradead.org>
Cc: Haakon Bugge <haakon.bugge@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
 <ZvFY_4mCGq2upmFl@infradead.org>
 <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
 <ZvJiKGtuX62jkIwY@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZvJiKGtuX62jkIwY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/24 14:54, Christoph Hellwig 写道:
> On Tue, Sep 24, 2024 at 09:58:24AM +0800, Zhu Yanjun wrote:
>> The users that I mentioned is not in the kernel tree.
> 
> And why do you think that would matter the slightest?

I noticed that the same cq functions are used. And I also made tests 
with this patch series. Without this patch series, dim mechanism will 
not be invoked.

Zhu Yanjun

> 


