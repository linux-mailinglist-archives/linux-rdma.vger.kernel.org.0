Return-Path: <linux-rdma+bounces-13203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA095B4FB62
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82BE7A21DE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B783375B9;
	Tue,  9 Sep 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FJS4dV/Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1B322C67;
	Tue,  9 Sep 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421418; cv=none; b=p6Y4t4A3sH7UYjuymgNyxFYoCK3E5GqgIwV/MYXNQSRxyORUh+wDYv7kHyW1lWWSleDGPiw9e7DywctXdd2V9VM+REsXuy2C/umFo8cQ3C2/IQEh2aRtZiBdhQng63kaSViU/94y5yLchdtbVw1iBX/blnRzdpRwydUDiY7NizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421418; c=relaxed/simple;
	bh=OE9PPZLsxRCIoQbYUx3sEkmOYfHCMAJ8vEXu2ZsW+es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgqssqzbQUZTqfHUA+9642L5825XubMJ+VQA5cz2kJpYBHd5I9oFQxVWSSiYiDTWReddAhxFRwgrKOsPKtzaR7kD3iGo432/JKk6b4g3wBZdOkYoBoCLiDprlr90X8RtE+T12j48RXV2iYsUVWe8e4GQJiLCcvfUubG7innXmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FJS4dV/Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cPRW62VS5R4qpqyRM77zTED0HPd4w2ydDiojjTHXIHc=; b=FJS4dV/Q4TV6Uwq7EGD2bqAe9j
	6oBGWpF3hflR1vQc4CybmJ3xcJPyyHGPfhy1SW02BjcUIdqMnJf27QTIQ2oBhR1/TXnsLbn/4G/jP
	jlQgjCVdkdfnZKR5XhXEiL0wY99xl4IXcjSGbw2LJetnqqXg5CJ2hBk9hLghzrpwPx18=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvxaV-007nQN-Tx; Tue, 09 Sep 2025 14:36:43 +0200
Date: Tue, 9 Sep 2025 14:36:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: dust.li@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com, pasic@linux.ibm.com, horms@kernel.org,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Remove unused argument from 2 SMC functions
Message-ID: <6492e952-6763-447c-b491-135f5b94a6d6@lunn.ch>
References: <20250909071145.2440407-1-mjambigi@linux.ibm.com>
 <aMAR8q4mc3Lhkovw@linux.alibaba.com>
 <8bc987c9-a79d-42ec-8279-da8b407cfd2c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc987c9-a79d-42ec-8279-da8b407cfd2c@linux.ibm.com>

> > But I don't think this is a bugfix.
> 
> Yeah, its more of a clean up code. Should I use net-next? How should I
> got about this.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

   It must either fix a real bug that bothers people....

	Andrew

