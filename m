Return-Path: <linux-rdma+bounces-3008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEDD900F1F
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2024 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3044281A3A
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2024 01:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9D8836;
	Sat,  8 Jun 2024 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXshVeAc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6CA31;
	Sat,  8 Jun 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717810999; cv=none; b=sRlEIqpytEnTBOdcMjFy4epowIYZwogt1Y61G7FFZFdPzIUHOUZZ9YRby84iC1BX3K93WQCPYsJ57USzm/P3Mt6q8JJpCRi2lHRFpqY2UeAWHgs92de/zfuBKUPUkDDY0w/3WszBK8p32Poy2n5RWRAVY4f8fmZpJFRWxsdBNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717810999; c=relaxed/simple;
	bh=kxTnolzJBJlaeajOHehBVJOrauutsVcuiot/859aDlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggni0GVopScEOQPXt1dRsaVGgFf98Yqj8dx/OLcvXibotW3feSR1FNiPemtTPOybbFnQLw/RzGQJp4S7TuP75nqAU4g7kiiLlACCPl+dhHrot48tXbkwKD0F9rliDjZZ7sHmlcIeoRyIbAjVUl4KbLwbRuHREHHoyDA/mntouxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXshVeAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43AAC2BBFC;
	Sat,  8 Jun 2024 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717810998;
	bh=kxTnolzJBJlaeajOHehBVJOrauutsVcuiot/859aDlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXshVeAcocmJVA6la5KLNNu3RVHp9NQk0VDB+UPV198dDOeKoyGogj3JkWLiHz+kW
	 IDSzh/fPTNSZEwpM+2UEsXu8Dwz/Y/J2enN27cwtxp1g1wD/FVR89tknEqrCmhwYSP
	 D3Clc+Aro713f6aFdSB2WK0sS8SiYZvIVhPm54qAFDBlsfYEkKCDK2x34v2eahxFwm
	 +1zFb/nvkDx8mOeb7pMp3lKYSsNhmwPktnpwp/TbLWpMancKW8wW6e81pio66Y7Lub
	 YagCtiG/jQYlFWOA+Q5lqWWL/WfXL/Tbfy8IeLD3qUsxfSoM1Jh2EWjzI4H6JRmyyJ
	 iUBuAcuo7Z2Ow==
Date: Fri, 7 Jun 2024 18:43:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Christoph Hellwig
 <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240607184316.1acdb3fd@kernel.org>
In-Reply-To: <ZmMMeIuplzZl2Iyh@nanopsycho.orion>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240605135911.GT19897@nvidia.com>
	<d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
	<20240606071811.34767cce@kernel.org>
	<ZmK3-rkibH8j4ZwM@nanopsycho.orion>
	<b023413e-d6e1-4a47-bdf2-98cc57a2e0ae@lunn.ch>
	<ZmMMeIuplzZl2Iyh@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 15:34:48 +0200 Jiri Pirko wrote:
> >For bigger, single purpose devices, it is just a switch, there is less
> >inconvenience of using just one vendor SDK, on top of the vendor
> >proscribed kernel.  
> 
> I'm aware of what you wrote and undertand it. I just thought Jakub's
> mixed experience is about the APIs more than the politics behind vedors
> adoptation process..

Not the API / implementation, just that the adoption is limited.
The benefits of using a standard Linux approach is outweighed by
the large pool of talent with experience programming using the SDK
of *the* vendor.

