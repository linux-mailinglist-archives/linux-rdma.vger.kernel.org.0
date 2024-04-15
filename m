Return-Path: <linux-rdma+bounces-1940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732E8A4727
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 04:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CC11C20D82
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0028B18E02;
	Mon, 15 Apr 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y2tpKM3R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAB17C6D
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149731; cv=none; b=SR/SBvH7mmAGH7ed7mUwN7lUNDu7jduNBvnl7Mj591MxYIqA+d3Oy9cSWfWIpDyHScT/3RXySl/rSTLppVLsCoklApzTNHnaGS8phB9vpe41BnjTNhU/PJk/qkhFol/6CbK7B825JNHc1cLOznJ18kT4mjUvhDmy4Q24eR1JvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149731; c=relaxed/simple;
	bh=T3x0WQpAZCi2yivHlFX+HNBVpsGtrS8OqSlLj1JgOG0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hWC7pTPdJZnZYHeTHB9CkSiifrh6YHW97OHZjdqbmeAx/ipau8Ded2cS6h9wvic2dQzRCYtmIMd5CUz6PAAYTnjk4PsBVRMIJIz6m5N1gpafCjAlpUKWwidBtHSjQ0tDGfEtD4bum35MdLzokbBpyMB1uqB0CHZzDze2GjDgbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y2tpKM3R; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=6yjv2FBVBgeUNkKvYO5qIAJ369bfKTRO9maGwUzlCHg=;
	b=Y2tpKM3RmtYkZhBfJZi2pgBLNR3/H/EqLqt/kW0TNCW2WP5PpviKE+sUJF1MBS
	8mgrGw7jj6IwHmabW86cR90i2MZ+sHi7sQaUDSkFfwANWeaxj8wLfxaxx8ByBK6v
	vXKuyOrr2D+vigEWSKOYZKGK2LmZq/XpDorR9x8h2L2NM=
Received: from localhost (unknown [183.81.182.182])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDnN94RlxxmYQJBAQ--.34734S2;
	Mon, 15 Apr 2024 10:55:14 +0800 (CST)
Date: Mon, 15 Apr 2024 10:55:12 +0800
From: Honggang LI <honggangli@163.com>
To: linux-rdma@vger.kernel.org
Subject: Question about extra 40 bytes needed for UD receive buffer
Message-ID: <ZhyXEOC9SMIxjXP1@fc39>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wDnN94RlxxmYQJBAQ--.34734S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4rGr1xXw43uF1fuw18Grg_yoW8ZryDpF
	4rKrsxJF1kW347A3W8ua1kJ34xC3ZYy3W5Cay8Wr48uw15Ww10gFy3KrWYva1DZr1Fkayj
	qr1Y9r4rCFn0vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRwL0rUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDxbBRWVODSrfyQAAsH

hi,

According to volume 1 of IBAT specification of release 1.4,

1) 11.4.1.2 POST RECEIVE REQUEST
Note that for UD QPs, the first 40 bytes of the buffer(s) referred
to by the Scatter/Gather list will contain the GRH of the incoming message.
If no GRH is present, the contents of first 40 bytes of the buffer(s) will
be undefined. The presence of the GRH will be indicated by a bit in the
Work Completion.

2) 11.4.2.1 POLL FOR COMPLETION
GRH Present indicator, for UD RQs only. If this indicator is
set, the first 40 bytes of the buffer(s) referred to by the Scatter/Gather
list will contain the GRH of the incoming message. If it is not set, the
contents of first 40 bytes of the buffer(s) will be undefined. Contents 
of the payload of the message will begin after the first 40 bytes

3) A17.4.5.2 SCATTERING OF THE L3 HEADER IN UD
The first 40 bytes of user posted UD Receive Buffers are reserved for the
L3 header of the incoming packet (as per the InfiniBand Spec Section
11.4.1.2). In RoCEv2, this area is filled up with the IP header. IPv6 header
uses the entire 40 bytes. IPv4 headers use the 20 bytes in the second half
of the reserved 40 bytes area (i.e. offset 20 from the beginning of the
receive buffer). In this case, the content of the first 20 bytes is undefined.



After function `ibv_poll_cq` return 1, the dump of receive buffer of
`ibv_ud_pingpong` shows there is 40 bytes GRH in the head of receive
buffer. The first 20 bytes are zeros and the second 20 bytes is a valid
IP header. At this point, everything works as required by the
specification rules 1), 2) and 3).

However, I'm confused by the dump of `mckey` receive buffer. The flag
`IBV_WC_GRH` is set in `ibv_wc.wc_flags`, but there is no GRH in
the receive buffer. Received data starts from the *first* byte of
receive buffer. As multicast over UD QP only, can someone please explian
why there is no GRH in receive buffer and the data starts from the first
bytes of receive buffer with `IBV_WC_GRH` was set?

Thanks


