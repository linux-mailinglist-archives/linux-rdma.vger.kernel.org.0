Return-Path: <linux-rdma+bounces-2946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2A8FED7E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201C22814BD
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58C1BB6BD;
	Thu,  6 Jun 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uraj3xoY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E7198E8F;
	Thu,  6 Jun 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683493; cv=none; b=Tgg8jNrBRPGEekpa051kppgnau2MdahTQq9SkWf/e+MSous5bw1kAgmHn3FbJcHpT+VKSIzlnw9KC6sl/b53wFQkXET9sbIOteUQkrOKE5+gViR9sb2Eo/YkxnkRfFUpZ6F+ZqW8NzNyv4XTKti472tuz+GIJEuvUrlNGAvtc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683493; c=relaxed/simple;
	bh=AeUve0wcCHzZ/ya7iVe+9dU6zUKTasjJqfTW1aFfmQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry8df4lMJ4VhNBrOS0760j7mZSNToXWF6bIertw7czuXVAISYX3XeL59aYVtyen/RnitbBn8cgBINJc1NmSw0mqjEnP0mTo+bLd1w5SL/R8wTVMhweAeclE+v197N5L0PTUtd/HgwStXnh+KxGxmM189g1W8UrvJTkZ+JsZlKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uraj3xoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C252C32781;
	Thu,  6 Jun 2024 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717683492;
	bh=AeUve0wcCHzZ/ya7iVe+9dU6zUKTasjJqfTW1aFfmQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uraj3xoYulOn0jk1kDTQHQoYmnfemcAaOwIGyB+mgXm5nh9KbPsWrWzXG2y8Uawif
	 NLmwAxhxqrG4ECzpyzF0eoWYHPXN4Kdm7A5oKObaCnCeXuWap9+FLYCvHrUYMqmD0t
	 oJ95qWXQljh9lTu5vfXTGs8nWNN963yb86X+hxLHh/abFr6V2ZU0zXOeyYGIe8L3KJ
	 mze3o9yCRs0JDeibX8RjxdohXdU0fyNzCrP3n6CFrh65xf1xbSuwyn9yW1FngX/UcC
	 gH72i2KedF7d4qJbl94UGnE3pI/H7cnRaW0sFBXsT/m4jss9vnwjTL8mx+A0WO2uu+
	 dWIE1pE6fXzjw==
Date: Thu, 6 Jun 2024 07:18:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>, Itay Avraham
 <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Christoph Hellwig <hch@infradead.org>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240606071811.34767cce@kernel.org>
In-Reply-To: <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240605135911.GT19897@nvidia.com>
	<d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 20:35:49 -0600 David Ahern wrote:
> Until a feature is standardized and/or commoditized, it does not make
> sense to create a uapi for every H/W vendor whim.

This is not about non-standard features. I work with multiple vendors
as my day job. I ask them how to set basic link configuration and the
support person gives me a link to the vendor tools! I wish I could show
you the emails.

> All of them are attempting to solve real problems; some of them will
> stick. We know which features are valuable when customers use them,

Yes, once customers deploy a feature implemented via a vendor API
they will definitely migrate to a different API. Customers like risk
and wasting their engineering resources reimplementing and redeploying
things? And we have so much success move users to new APIs in Linux!

> ask for them and other vendors copy them. Until then it is a 1-off by
> a vendor basically proposing a solution.

Certainly. Because... who exactly will ask the second vendor to
implement the common API? 

And the second vendor will most certainly not mind the extra delay and
inconvenience having their product shipped via the publicly reviewed,
and slow to deploy kernel, while the first one is happily selling
the same feature already.

> Not all ideas are good ideas, and we do not need the burden of a uapi
> or the burden of out of tree drivers.

This API gives user space SDKs a trivial way of implementing all
switching, routing, filtering, QoS offloads etc.
An argument can be made that given somewhat mixed switchdev experience
we should just stay out of the way and let that happen. But just make
that argument then, instead of pretending the use of this API will be
limited to custom very vendor specific things.

Again, if someone needs this to ship their custom CXL/Infiniband 
AI fabric magic, which is un-interoperable by design -- none of 
my concern. But keep TCP/IP networking out of this :|

