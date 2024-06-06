Return-Path: <linux-rdma+bounces-2964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E608FF6EF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935A6B26BF7
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E5B71B20;
	Thu,  6 Jun 2024 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="VafrFhSD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80162FC02;
	Thu,  6 Jun 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709591; cv=none; b=l4eAoZ9q/Ev7ME5Y35HXthve6rB4Q+fUsB9GfIuZt2sDplVKBbiRLzryW5II/rMh1u7TTF/vr/bDCbkjDbdF6CVOQQQN8URtsP3i8cU79KkaGFbrdsC4jFwUzgAO6/svdkecOR+Pwljj3TpJd+m5whPdVnopcvxVrmRts/+6thI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709591; c=relaxed/simple;
	bh=c4VPquM25/aAzWc+PWoefzik+kfteGxmC9v6FNbyTbM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=IoYcP12aQBzVufc6VYmCaoFcYI95EAvBJY06TghI61u1pQFGX6VlPvcUbYvBqmdeu53cuqZvzXNR4vxI4Hnz7McDuWHuFy0qbAaOGw+lgW5yEIL9M/D4eUMsLxq36uBLgRhFNFZN6Uvao2qD79v1ZwFZblWoqzlFdBMChA7MqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=VafrFhSD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=GFEw8cAaOIMPPjcIH/t2swdVfYuU+9OBnbnvT/Z34FA=; b=VafrFhSDZTiuTQ8+eqghWgRF/6
	LbImSkv5LzDfHOSEpw5N5S4ulsNiiv1TzeiftXjYmAxXH9xYRxXqV6ScNt6jpoZhUoMjpLgULTY4c
	RxEqaFL5TsOFZvWBW6uee5L1CXJlmgb8ZmEQb3c/zrxeclsuynN+yXuixJpTovirhWS9QmVDgv2Ka
	zCh7bRny2nQzn/GF+eMTU8MtnBT27kGc17jRdSPb5CgAukSJ+fhCiWh1HUL/v2CPuqd9Kw4wF00zx
	rokY8xTE011F43W7U8oQ0olgR2h94vh+ngSqC+weHVt2qqA6FxLwSBLt7mMgxdELA9RdCtvo2WLM9
	NfcCF6PQ==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1sFKj7-002BN1-1U;
	Thu, 06 Jun 2024 15:33:00 -0600
Message-ID: <bb2e5a8d-797d-406c-acc6-60e83b302ede@deltatee.com>
Date: Thu, 6 Jun 2024 15:32:39 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Valentine Sinitsyn <valesini@yandex-team.ru>, Lukas Wunner <lukas@wunner.de>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
 <20240605192934.742369-2-martin.oliveira@eideticom.com>
 <2024060658-ember-unblessed-4c74@gregkh>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <2024060658-ember-unblessed-4c74@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, martin.oliveira@eideticom.com, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, jgg@ziepe.ca, leon@kernel.org, bhelgaas@google.com, tj@kernel.org, rafael@kernel.org, akpm@linux-foundation.org, mike.marciniszyn@intel.com, michaelgur@nvidia.com, dan.j.williams@intel.com, ardb@kernel.org, valesini@yandex-team.ru, lukas@wunner.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/6] kernfs: create vm_operations_struct without
 page_mkwrite()
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Greg,

On 2024-06-06 14:54, Greg Kroah-Hartman wrote:
> On Wed, Jun 05, 2024 at 01:29:29PM -0600, Martin Oliveira wrote:
>> The standard kernfs vm_ops installs a page_mkwrite() operator which
>> modifies the file update time on write.
>>
>> This not always required (or makes sense), such as in the P2PDMA, which
>> uses the sysfs file as an allocator from userspace.
> 
> That's not a good idea, please don't do that.  sysfs binary files are
> "pass through", why would you want to use this as an allocator?

The P2PDMA code already creates a binary attribute which is used to
allocate P2PDMA memory into userspace[1]. It was done this way a couple
of years ago at the suggestion of Christoph[2]. Using a sysfs attribute
made the code substantially simpler and got rid of a bunch of pseudofs
mess that was required when mmaping a char device. The attribute already
exists and is used by userspace so it's not something we can change at
this point.

The attribute has worked well for what was needed until we wanted to use
P2PDMA memory with FOLL_LONGTERM and GUP. That path specifically denies
FOLL_LONGTERM pins when the underlying VMA has a .page_mkwrite operator,
which sysfs/kernfs forces on us. P2PDMA doesn't benefit from this
operator in any way so the simplest thing is to remove it for this use case.

>> Furthermore, having the page_mkwrite() operator causes
>> writable_file_mapping_allowed() to fail due to
>> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
>> enabling P2PDMA over RDMA.
>>
>> Fix this by adding a new boolean on kernfs_ops to differentiate between
>> the different behaviours.
> 
> This isn't going to work well.

What about it are you worried won't work well? We're open to other
suggestions.

Thanks,

Logan

[1] https://elixir.bootlin.com/linux/latest/source/drivers/pci/p2pdma.c#L164
[2] https://lore.kernel.org/all/20220705075108.GB17451@lst.de/

