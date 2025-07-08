Return-Path: <linux-rdma+bounces-11948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D3BAFC066
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 04:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0351BC0F0E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D40321FF2A;
	Tue,  8 Jul 2025 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kEnFOwcL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450C21D3E2;
	Tue,  8 Jul 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940087; cv=none; b=sMbNHDCy2lbNP9EARjGtiUzLYgRuoVhLGBGUKQlyY2HJ7jXachhaNuZSAwtdADYcxmO50fawcdYru+91JRs5XybFWhIAW+nKVNvKg8/UXdv6c6N1EBPbZNMslb6ZBbUh9KplEnuS9DdrXSEgNO6wyQzVjTfvowLRBNOwuULlzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940087; c=relaxed/simple;
	bh=vdenrLS+6YN2aEQcaYc5Lh42yH2LI08mDnidM+eFRp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTXrY7szFKvn9z1pjlemiTkd0h3DGofpQV+9tqvSWmtWe9vUIKPIep7Nj9vL+ZGQeVsxXNGPnGXZATVcMv82obDW1D3DkwA20CwP9mMOnqvZ7teT+ClzND/xihqjIR8BDsxGmr17pYlmKufUOK+2AUCDkqeX00CgBtbfgctfIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kEnFOwcL; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751940081; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=30BX8zo3tqsnhx5SV2GQKzrU9gHS62rwrKyEO3a8EYU=;
	b=kEnFOwcL8HJMxFpaDXAMwl8kqnTQFhvzKtVOE9ONC1BPMWHu0Wx+WJEKmltgdl1RbGCOxtMrt3bNpi2fnbxDoWkYmduIIQt7FldhOjWp7+/v5NAxK5bBm9QB2SRI4oV1a0e7xhuUEwqkcC0Zv9ZqTq+tvL3jWQzD6ygYYCiq4pY=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WiIMpoe_1751940080 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:01:20 +0800
Date: Tue, 8 Jul 2025 10:01:20 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/smc: convert timeouts to
 secs_to_jiffies()
Message-ID: <20250708020120.GA21846@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
 <20250707-netdev-secs-to-jiffies-part-2-v2-1-b7817036342f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-netdev-secs-to-jiffies-part-2-v2-1-b7817036342f@linux.microsoft.com>

On 2025-07-07 15:03:32, Easwar Hariharan wrote:
>Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>secs_to_jiffies().  As the value here is a multiple of 1000, use
>secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
>
>This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>the following Coccinelle rules:
>
>@depends on patch@
>expression E;
>@@
>
>-msecs_to_jiffies(E * 1000)
>+secs_to_jiffies(E)
>
>-msecs_to_jiffies(E * MSEC_PER_SEC)
>+secs_to_jiffies(E)
>
>Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust


