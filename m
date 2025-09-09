Return-Path: <linux-rdma+bounces-13171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 819A2B49EDF
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 03:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11A41B27383
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625923B615;
	Tue,  9 Sep 2025 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GgfGFxGO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26870830;
	Tue,  9 Sep 2025 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382857; cv=none; b=nnvOGiy8AEAyHKzlNW/1TY9fcm1XuXM9F5ZhM9TXbT8G+9b++LfYK0BpwqylAzbK2MvGZUxecXkac7rmgVj3NzjXaaJnXahhWfGKSWKy3C+zHJpiQVi8mQQ8MRjE8jvt+9kcR5Kv28tTVlK3eioJ1/f6EgFYGl74Ww4Ti0zRvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382857; c=relaxed/simple;
	bh=DUV0VbC0IispzH18xs6mxDQDf2FUPLvedX7XB0qlw/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBuad6tGJZOAa60BgIr5hYxGzLIR0KrYZ8AY3SQsuW1c8fPw2v0FTlzRRPjz9EVrpAiD3ZRCNCsIBH9RFHeYKeckEQnBhbqdArBQH7NgTlAkAjWKwiH7O1eyDaiKu7usYYT20esPYFkdCx/8Grvl+w6IFjPoC5NuQcGwIjcD2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GgfGFxGO; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757382850; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=BHNzWY7LLHrhrHNzpP3tvkmBTEprGJ4zhMbAFa1FifU=;
	b=GgfGFxGOdFGw7xMdZrF/A/KI+F002hANbr2IFcOIAfHu9qsa9gJrOA1zt7siERvSByQgYN8g0Bu3PQGO4Cy95z/rdCaR5USLH3/QDp1JW/8+fwqjQj3RDqW0yucjMWQjS814K1aWDeSUb1bvNgY0tEqZojse9oF8pRnne6AAWgU=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wnbr8Bw_1757382849 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 09:54:09 +0800
Date: Tue, 9 Sep 2025 09:54:09 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 03/14] net/dibs: Create net/dibs
Message-ID: <aL-IwWQN7ZUNdjky@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
 <20250905145428.1962105-4-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905145428.1962105-4-wintera@linux.ibm.com>

On 2025-09-05 16:54:16, Alexandra Winter wrote:
>Create an 'DIBS' shim layer that will provide generic functionality and
>declarations for dibs device drivers and dibs clients.
>
>Following patches will add functionality.
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>---
> MAINTAINERS          |  7 +++++++
> include/linux/dibs.h | 42 ++++++++++++++++++++++++++++++++++++++++++
> net/Kconfig          |  1 +
> net/Makefile         |  1 +
> net/dibs/Kconfig     | 12 ++++++++++++
> net/dibs/Makefile    |  7 +++++++
> net/dibs/dibs_main.c | 37 +++++++++++++++++++++++++++++++++++++
> 7 files changed, 107 insertions(+)
> create mode 100644 include/linux/dibs.h
> create mode 100644 net/dibs/Kconfig
> create mode 100644 net/dibs/Makefile
> create mode 100644 net/dibs/dibs_main.c

I recall we previously discussed the issue of which directory to place
it in, and I don't have any strong preference regarding this. However,
I'm not sure whether we reached an agreement on this point. In my
opinion, placing it under the drivers/ directory seems more reasonable.
But if net/ is OK, that works for me too.

Best regards,
Dust


