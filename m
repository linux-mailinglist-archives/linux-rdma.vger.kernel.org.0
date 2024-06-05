Return-Path: <linux-rdma+bounces-2917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9357A8FD752
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 22:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE63B2234F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265D0158853;
	Wed,  5 Jun 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iPNiSGR8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8B14EC6B;
	Wed,  5 Jun 2024 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618449; cv=none; b=PfjheDixxiDN4KNocesc2bZahxm5tutldgSoJE1zBRRc3e/PHH+6Sxwi2Ib35gr9w0LU1TSVhFRtGhJDAuJVtNDqSRwR8EW9YPCZ9dzx5+1xcawQMoIAJ6sAatQ7a/OkiLyonrqiW2A/g8xmTL8N/u3gWpAhJI1E6yRPgkUl8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618449; c=relaxed/simple;
	bh=WNiQKc7XInc3wxnxvdi0iSR6wuB1eYAWWFzmkvnEe9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poRwW3Jwk9sGdnfWwrsIjOgzy0JfjCnXhjUypZnopV4cbNxuw8MHud8105RcIkZ8p27Igl6RGHdHiRKwbdVXTO84B1FeP4YG8AhFG9Oskskb0rK+Ra9kQWueQOgz/PvVKtiWJqUiQ2/ggr/arDSdO26NfckAj2nvCjaT8FBcp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iPNiSGR8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CkQB+gxR77I5/qf64o4fg6uN7mw5H6bkQGa9rOQ77b0=; b=iPNiSGR8mNtPRiRaFZwa/2VmzT
	0vU6b+4CxM7tACmId1uDAc4qJYb4hJ96vVOmv0ZwVYsg/KpYJGPOaYmBgQJWL31NwVvH+NiO5zln2
	cfc7BdCoNOpUvCivmlmDagfAKeDHh98iAu/rR0fo5wC6C1o4LnBpqII2BKsm7e9owja+FoAFd1MqN
	E3O4NBLLqSerWbWthV5ZhMl2vUisI9Kum4a1UrChwAP6zxI0rMoGPQE08sYw0UbIEzIjhiUZBLAOi
	juRoLdlfRitSCgpZfPEOdIgunXc/iCaF8+ywOa2HTlxkEoEiA1U1I3B26WKeuz8jhTPny+moFaEti
	OQ3TNK/g==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEx1K-00000007QDT-3UPU;
	Wed, 05 Jun 2024 20:14:06 +0000
Message-ID: <29b4266b-4aed-4124-8c48-cc539302bf07@infradead.org>
Date: Wed, 5 Jun 2024 13:14:04 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] fwctl: Add documentation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <6-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <7a28cd2c-b5a8-4c06-b9e2-9b390d8c96e4@infradead.org>
 <20240605160336.GA1760942@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240605160336.GA1760942@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 9:03 AM, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2024 at 07:31:10PM -0700, Randy Dunlap wrote:
> 
>>> +Modern devices contain extensive amounts of FW, and in many cases, are largely
>>> +software defined pieces of hardware. The evolution of this approach is largely a
>>
>>   software-defined
> 
> Thanks a lot Randy, I picked up all your notes.
> 
>>> +While the kernel can always directly parse and restrict RPCs, it is expected
>>> +that the existing kernel pattern of allowing drivers to delegate validation to
>>> +FW to be a useful design.
>>
>> (and one that can be abused...)
> 
> I would really like to write a paragraph about this "abuse", Dan has
> some good thoughts on this as well. Did you have a specific "abuse"
> in your mind?

No, I don't. It just seems very open (but ioctls are just as open).

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

