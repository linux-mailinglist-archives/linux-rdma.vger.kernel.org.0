Return-Path: <linux-rdma+bounces-2999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA3D900A28
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E026C1F251F7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83219AD48;
	Fri,  7 Jun 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BBIh0yCR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624119AA63;
	Fri,  7 Jun 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777049; cv=none; b=DTseyb3ghVdANX5oLmXd5vMTGxzfb74SM702vlhL1vZF6zmnmvwUBVC9yT+yxAoFb5b3nnMljZfWcyXmWh7KatkvLAMV6dA0+uKQOWmgxf6+ThFaltItKFVhdn6bx67i39Cyd2yBD4HFGOMakfcEDXXdBlyKcOyCwkXALvKOnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777049; c=relaxed/simple;
	bh=QfF9Bb7X32F8nICu81y4HThudduzWvXoFg1jEZTpPhE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=NjQlgc/e/wYsgH5HdTzU1q2tHcUZgYoWwBZlXwBS++87Z2uFLEWpSJQTdffGMna6AnHDztmYSolAohUvBvtrjE6ka2yYPDVbGAJInnZxoEzBUNUQlpR+NLSKxYuOqbm0IIR1RGoBxY6NaimzO5cFZlRaHOEEOy96R2wE/Ar9jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=BBIh0yCR; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=qkDEkc3600QydwZ7dLx85k/1FneEqzK/z4bkuCI+5S8=; b=BBIh0yCRXnuFy/KVqsXSN0Ylfu
	RvrfX04VdJB3Fw2avS7C17nDPoTwlpTf9XQi3wuBbfvzX3ZFNHVCl1NwYu2/PPOGLE7QkR2tET3Iq
	B5ktVUDPG8MF7I3G89kYngU4gEfVeHZXrG3i1NMqVinkvy8Pzh9+q9QZRhpQYxeYyvN+wwFTlmGHE
	dp7tguHBZtRWbAX+rITl46AsNMZ/uAofdIz8MGNGDSIF/A/sI6fT37NqJOUFeKQbzlybKJT1QWEIg
	rHMS8X2tz+58WNHlo7DNN9t+cGoZGKYId1dXBKtTy+E4tdiT3RNoJqNdo9RRG7v4Qe2GcxlNJg/eP
	VofAp7tA==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1sFcHC-002ro5-1t;
	Fri, 07 Jun 2024 10:17:15 -0600
Message-ID: <69dc6610-e70a-46ca-a6e9-7ca183eb055c@deltatee.com>
Date: Fri, 7 Jun 2024 10:16:58 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Oliveira <martin.oliveira@eideticom.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <2024060658-ember-unblessed-4c74@gregkh> <ZmKUpXQmMLpH8vf5@infradead.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <ZmKUpXQmMLpH8vf5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: hch@infradead.org, gregkh@linuxfoundation.org, martin.oliveira@eideticom.com, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, jgg@ziepe.ca, leon@kernel.org, bhelgaas@google.com, tj@kernel.org, rafael@kernel.org, akpm@linux-foundation.org, mike.marciniszyn@intel.com, michaelgur@nvidia.com, dan.j.williams@intel.com, ardb@kernel.org, valesini@yandex-team.ru, lukas@wunner.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/6] kernfs: create vm_operations_struct without
 page_mkwrite()
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-06-06 23:03, Christoph Hellwig wrote:
> On Thu, Jun 06, 2024 at 10:54:06PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Jun 05, 2024 at 01:29:29PM -0600, Martin Oliveira wrote:
>>> The standard kernfs vm_ops installs a page_mkwrite() operator which
>>> modifies the file update time on write.
>>>
>>> This not always required (or makes sense), such as in the P2PDMA, which
>>> uses the sysfs file as an allocator from userspace.
>>
>> That's not a good idea, please don't do that.  sysfs binary files are
>> "pass through", why would you want to use this as an allocator?
> 
> I think the real question is why sysfs binary files implement
> page_mkwrite by default.  page_mkwrite is needed for file systems that
> need to allocate space from a free space pool, which seems odd for
> sysfs.

The default page_mkwrite in kernfs just calls file_update_time() but, as
I understand it, the fault code should call file_update_time() if
page_mkwrite isn't set. So perhaps the easiest thing is to simply not
add a page_mkwrite unless the vm_ops adds one.

It's not the easiest thing to trace, but as best as I can tell there are
no kernfs binary attributes that use page_mkwrite. So alternatively,
perhaps we could just disallow page_mkwrite in kernfs entirely?

Logan

