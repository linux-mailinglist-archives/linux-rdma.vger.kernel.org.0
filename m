Return-Path: <linux-rdma+bounces-5969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06629C7FF9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 02:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2971EB224F5
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113851E3DD1;
	Thu, 14 Nov 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PLTZ9bG8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6404B225A8;
	Thu, 14 Nov 2024 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547674; cv=none; b=gzWbCGA7ccGSBO6kYFhMtHdV9HvvcCCtsZOAkcw5ijzoC23VauD2G3Kk2taEN2gCxB14HjngACAyRlBjgtTVP5Pxt5FS1U6e7ujW6McOuY/vsyJHdeKvZp4RSI6MZoNdlObTsel85th8Fwgv2q3Qxq3CyJAnjWETzgebXv2yoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547674; c=relaxed/simple;
	bh=hJWgq4YSdX2Cm1S/yH1rvxMW0mDIRnD1eSjNgWDCqnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFiXLeZsg4n11fadhlZSy3PmYeGZXGMeQeBTmk/tnJf8mEuFxs/6X1t77li9D44mitmo6DZdAIdbNCV2MT4EoM8jTq+E/1EuvatumjdBRReGo9x1ifJ//nF3pBgE4Bj+I7eQtOd45RaN5UDmjVKRgSaIKZGAoP0Gsa8t/cKPf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PLTZ9bG8; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731547663; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=QeGsQ9G+bbUhA72CZZFmOPWxyoATDhaOHmm8LCJk+yg=;
	b=PLTZ9bG8ijhS1hXYBvCsoVHXm4M++5xK1xA/w561t9JgnvZJPLlLkkWZRSyTR2MLbBoP5HeX8Z0Vdvub7PwOO7fm3zsG160ZkZs/DVape7bXkBwoFsnQg4P/wpz4NNzPEhjT7UgKXdaxA9CHpvF3/M6pz5oXPucdjAk/N1o7k04=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WJMPbAA_1731547661 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 09:27:42 +0800
Date: Thu, 14 Nov 2024 09:27:41 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 0/3] Reduce locks scope of-smc_xxx_lgr_pending
Message-ID: <20241114012741.GD89669@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241113071405.67421-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113071405.67421-1-alibuda@linux.alibaba.com>

On 2024-11-13 15:14:02, D. Wythe wrote:
>This patch set attempts to optimize the parallelism of SMC-R connections by reducing
>locks scope of-smc_xxx_lgr_pending. This is a balance between large-scale refactoring
>and performance optimization, where this patch attempts to achieve performance optimization
>with as few changes as possible to minimize unexpected impacts.

I think one of the main benefits you missed here is isolating the lock across
different network namespaces when the RDMA device is exclusive. This
isolation is crucial when managing multiple containers, each with its
own RDMA device.

With the global smc_server_lgr_pending lock, if one container holds this
lock, all other containers must wait.

Worse still, a malicious client could exploit this by forcing the server
to create new link groups according to the SMC-R protocol. In other
words, an attacker could easily compel the server to continuously create
new link groups and hold the smc_server_lgr_pending lock, causing all
SMC connections targeting other containers on the same server to wait.
This scenario effectively constitutes a denial-of-service (DoS) attack.

>
>Although there are still many bottlenecks that affect the connection performance of SMC, 
>This also has a certain performance improvement after this patches.
>
>Short-lived conenction wrk/nginx benchmark test:
>
>+--------------+--------+--------+--------+-------+-------+-------+-------+
>|conns/qps     |   c8   |  c16   |  c32   |  c64  | c512  | c1024 | c2048 |
>+--------------+--------+--------+--------+-------+-------+-------+-------+
>|SMC-R before  |10481.84|10761.04|10283.01|9006.88|9140.88|9255.41|7296.20|
         ^^^ after ?


>+--------------+--------+--------+--------+-------+-------+-------+-------+
>|SMC-R origin  |7328.86 |7256.99 |7288.53 |7239.55|5787.56|5371.17|3065.74|
>+--------------+--------+--------+--------+-------+-------+-------+-------+
>
>D. Wythe (3):
>  net/smc: refactoring lgr pending lock
>  net/smc: reduce locks scope of smc_xxx_lgr_pending
>  net/smc: Isolate the smc_xxx_lgr_pending with ib_device
>
> net/smc/af_smc.c   | 36 +++++++++++++++++++-----------------
> net/smc/smc_core.c | 17 +++++++++++++++--
> net/smc/smc_core.h | 29 +++++++++++++++++++++++++++++
> net/smc/smc_ib.c   |  2 ++
> net/smc/smc_ib.h   |  2 ++
> 5 files changed, 67 insertions(+), 19 deletions(-)
>
>-- 
>2.45.0
>

