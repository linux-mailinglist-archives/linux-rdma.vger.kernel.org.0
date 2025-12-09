Return-Path: <linux-rdma+bounces-14933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B560CAE9BC
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 02:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C28F305309B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F626A1A4;
	Tue,  9 Dec 2025 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FAq2wfNw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535B26E165
	for <linux-rdma@vger.kernel.org>; Tue,  9 Dec 2025 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242823; cv=none; b=Yw8/t+sxVEz1G2U+4g5b1YNhYpjk5ugGZjcmhjXwwD5ddgj/av9eN0sIk2VuBnYzoT2vgCQIxKnOrAAURXQNhyuOVhu+l/jt6HPWnfJTfjFqoB4/baj/eHkz1svYGrxRMwxb7rtLtHnlXyPL8pn34cFVWUsTTMlMaAgL3fy3yTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242823; c=relaxed/simple;
	bh=JkRn7QKeL3hSzis0lsKTpS1UWrgTWG8dN/MwIqRm1UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILt70iUa6539VqnkOFSEjBN5mjRt6fZS+cRIsgW81PigUhAn1pCx4hVovjFkZhnYdvzgh8xQSQZm0b4zFYoNqU2KSDDsPLIqmXLobrgn8aclPL0lcEWtZB72sOBDdtXNSScPIT4naszKEp9xD7XYDZH7FpWiRx4aqBrbvO/YwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FAq2wfNw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=E4XeA0eQ3OUzWZC7hYDxCOx3v3l7qRIEp8aJ1vSAkJc=;
	b=FAq2wfNw8JkQ9wKsGZ8uvJK09uEVR+5aAcE88poDE/YFfdekF2lucNqal94sCJ
	46bsXj+6UzgoEZ8v3TeNRYE6fqdM/9Nxbju4F3QxyaNyawRj/K7kAES9YXMfyHmu
	ka+7ikPA3cJEVLGuCGl7IarqEcanYwZVgp2KpSpMTrfwI=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_4R9dzdpo5SEAg--.30003S2;
	Tue, 09 Dec 2025 09:12:32 +0800 (CST)
Date: Tue, 9 Dec 2025 09:12:28 +0800
From: Honggang LI <honggangli@163.com>
To: Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
	jgg@ziepe.ca, jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: Re: [PATCH 3/9] RDMA/rtrs: Add optional support for
 IB_MR_TYPE_SG_GAPS
Message-ID: <aTd3fOJcyRklaHGg@fedora>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-4-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208161513.127049-4-haris.iqbal@ionos.com>
X-CM-TRANSID:_____wD3_4R9dzdpo5SEAg--.30003S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUePEfDUUUU
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiFQUfRWk3c4Vt6gAAsl

On Mon, Dec 08, 2025 at 05:15:07PM +0100, Md Haris Iqbal wrote:
> Subject: [PATCH 3/9] RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_GAPS
> From: Md Haris Iqbal <haris.iqbal@ionos.com>
> Date: Mon,  8 Dec 2025 17:15:07 +0100
> X-Mailer: git-send-email 2.43.0
> 
> Support IB_MR_TYPE_SG_GAPS, which has less limitations
> than standard IB_MR_TYPE_MEM_REG, a few ULP support this.

Do you have benchmark performance difference between IB_MR_TYPE_MEM_REG
and IB_MR_TYPE_SG_GAPS?

thanks


