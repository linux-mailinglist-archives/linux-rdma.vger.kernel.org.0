Return-Path: <linux-rdma+bounces-2848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E848FB95F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981F2B24DCE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AF14882B;
	Tue,  4 Jun 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vTYCXb6v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D81E501;
	Tue,  4 Jun 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519380; cv=none; b=sjGmePJskeFtjCuDWCAbD6AgQhmUAkZ70+J47HT3fisDMrhFU/ks9iBFk4FpqeWA8IDbcgQJRi2q4avbWd4ghvqDuX07wEe7+69hHK20NcPIA9KJJEyQ8nOh+Fpew4txDi9LgtbEy36ahkd5zc+puxCy6ED98xw7GaYyDQ4xgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519380; c=relaxed/simple;
	bh=AVtQe8CFoYugapmEsmqWT20D9mcrIl8sDllXLwuOlaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCErtDXhVk0ckl+Oa6PleuS03Ps0TzFLq4T33V19w42Yf9tKdB7GXJaxNPyKThMA1Me+ExX2GCXjdmGdEi22ZWSqXx51Haz4ruJYGfhgjx10QPOoIliT9HaBEDpY25EwfR6b2r4P2j9vR0kZW0e4ks8uYsZJdWg2fsvJmC3wfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vTYCXb6v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DdfadAZSfkGpxNXKZvLe0K4hYYEeYeHrSPQP31Ta2nY=; b=vTYCXb6vG/GLCadC7Z7YyQK/Pd
	ewdtAB6KOIPsO5rbPp62EYsYRXLFyaKBe62tQl78IIzrkyUdCbivxhLxp8vFtD/QYtwOOFGOgq7Yr
	fyWMLA8xoHd4i4uL/KCEfl5jha8zt0PmA0XcilzRk6F+NDkjrj1nstCrfXyqAWuo09NGBtyvDbxnL
	TP+/7ZiTdLimNXr8vCUG9EdQPAMpumgAWXbQc6aWRMxU7kZYdX/YDZaFS8BTykODSvf+aw7j9wG5r
	S7sLN5xTs7tIxy+6cCwaxvrVhqnhuyZNn8rxBhveW4lqKn+a/EGUy9enb7+ZiTbP7zTWWVUOTphfR
	JCmq3WDg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEXFM-00000003Ats-0uHJ;
	Tue, 04 Jun 2024 16:42:52 +0000
Message-ID: <68ae1ebb-90d7-4b4b-84a2-578b7217d5c5@infradead.org>
Date: Tue, 4 Jun 2024 09:42:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] fwctl: Add basic structure for a class subsystem with
 a cdev
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 8:53 AM, Jason Gunthorpe wrote:
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> new file mode 100644
> index 00000000000000..6ceee3347ae642
> --- /dev/null
> +++ b/drivers/fwctl/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig FWCTL
> +        tristate "fwctl device firmware access framework"

Use tab above instead of spaces for indentation, please.

> +	help
> +	  fwctl provides a userspace API for restricted access to communicate
> +	  with on-device firmware. The communication channel is intended to
> +	  support a wide range of lockdown compatible device behaviors including
> +	  manipulating device FLASH, debugging, and other activities that don't
> +	  fit neatly into an existing subsystem.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

