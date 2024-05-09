Return-Path: <linux-rdma+bounces-2374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB078C146B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BABB1F220E1
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F0770FA;
	Thu,  9 May 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="qyIg2OFG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02232A1D6;
	Thu,  9 May 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277780; cv=none; b=miATHtpibwnK5RLaFgE4RUZcNz/ikoRsxj3GFgDBobUQa2cysrKtGCXz2aGFZ1i/PDaWV5glZ/9gaiSAXcZ/+xr29QAyJWyg6zQmP3sbMuSVosrpr3n0oWy756Bu2Kny3kyZJERUSwHpm4fQB+shreXNVcHPXQxjYD+u6DHULRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277780; c=relaxed/simple;
	bh=KLv7MyynT4KBKlYpMAeljvNPeKJkIWm6jSoOqlGHsOk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Content-Type:Subject; b=p81AScE7JX5KdhKvtEp/BrvywZFeJQtdik2f9vuP6DRT1U7o+dOczOM+Lg2GJVMsjOnpe6WsEfGuPyQtdTX3Y8kWIUXUhLr6G2JusajS1yBnlwVS64sxhPooOywoeUbtsA3gLN+XkhygmziiRI5EpzthFp5bOwsX4XbZ7AkRkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=qyIg2OFG; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:From:Cc:To:MIME-Version:Date:Message-ID
	:references:content-disposition:in-reply-to;
	bh=KLv7MyynT4KBKlYpMAeljvNPeKJkIWm6jSoOqlGHsOk=; b=qyIg2OFGPzM51pjipX4C+EC6qj
	2l74tDOz8G9T0E66R4Zp5fo5B56QPOZL34MdAMsVZQpBXkFGucgJTkR3wxnL2EtDnzXBKssNeBszL
	ob3hr7t6+D2ePbiCBGuLeLyCUffY/8szTtEe3Ung3q2ebRxw1JOEW0qu/rO7gU2/gQNohgZjF1/RS
	QQy0vuKSJwY2IJJvwhYbCKfagJUCrLw3Tf834fSgR84t9FgBVrzoXIckTXR+wNSCq6/IMBr7gewG6
	zE96Eu0IrqXy1Rhai0/ETTCYVwoYPVwpXr9S4H94lcV8iyuhHShtUmxfeziMz58jVA31MEcCG1aov
	kEzWxT3A==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1s57cN-00ELue-Q8; Thu, 09 May 2024 11:31:44 -0600
Message-ID: <fa2d39cf-b0df-4674-979d-b775d5077bce@deltatee.com>
Date: Thu, 9 May 2024 11:31:33 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Martin Oliveira <Martin.Oliveira@eideticom.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
From: Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, Martin.Oliveira@eideticom.com, hch@lst.de, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: P2PDMA in Userspace RDMA
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Jason,

We've become interested again in enabling P2PDMA transactions with
userspace RDMA and the NVMe CMBs we are already exporting to userspace
from our previous work.

Enabling FOLL_PCI_P2PDMA in ib_umem_get is almost a trivial change, but
there are two issues holding us back.

The biggest issue is that we disallowed FOLL_LONGTERM with
FOLL_PCI_P2PDMA out of concern that P2PDMA had the same problem as
fs-dax. See [1] to review the discussion from 2 years ago. However, in
trying to understand the problem again, I'm not sure that concern was
valid. In P2PDMA, unmap_mapping_range() is strictly only called on
driver unbind when everything is getting torn down[2]. The next thing
that happens immediately after the unmap is the tear down of the pgmap
which drops the elevated reference on the pages and waits for all page's
reference counts to go back to zero. This will effectively wait until
all longterm pins involving the memory have been released. This can
cause a hang on unbind but, in your words, its "annoying not critical".

Even if unmap_mapping_range() was happening outside of teardown, the
P2PDMA code isn't like a regular filesystem in that it fully supports
the elevated reference counts in the pgmap code and pages cannot be
reused until the pin releases its reference counts and the count returns
back to one. So I don't really see how there can be a UAF concern with this.

Unless I'm really missing something, it seems P2PDMA does not have the
same concern as fs-dax and I think it is safe to remove that
restriction. Any objections?

The other issue we hit when enabling this feature is the check for
vma_needs_dirty_tracking() in writable_file_mapping_allowed() during the
gup flow. This hits because the p2pdma code is using the common
sysfs/kernfs infrastructure to create the VMA which installs a
page_mkwrite operator()[4] to change the file update time on write. I
don't think this feature really makes any sense for the P2PDMA sysfs
file which is really operating as an allocator in userspace -- the time
on the file does not really need to reflect the last write of some
process that wrote to memory allocated using it. So I think removing the
operator for P2PDMA makes sense, it's just a matter of creating the
plumbing that allows P2PDMA to indicate this to kernfs. There may be a
certain amount of bikeshedding on how this might be done, but it doesn't
seem terribly complicated.

Thoughts?

Logan

[1] https://lore.kernel.org/all/Yy4Ot5MoOhsgYLTQ@ziepe.ca/T/#u
[2] https://elixir.bootlin.com/linux/v6.8.8/source/drivers/pci/p2pdma.c#L333
[3] https://elixir.bootlin.com/linux/v6.8.8/source/mm/gup.c#L1029
[4] https://elixir.bootlin.com/linux/v6.8.8/source/fs/kernfs/file.c#L435

