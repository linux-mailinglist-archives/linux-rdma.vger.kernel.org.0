Return-Path: <linux-rdma+bounces-14737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44BC82C2D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 00:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C13234B777
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7B72512E6;
	Mon, 24 Nov 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ucZNos2R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D4158538;
	Mon, 24 Nov 2025 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025337; cv=none; b=dVgDVQr/yi/OtQrfQ/EBFKbiytp8QFeUMAkL0/BONGdLwiSmvNeCZnaBccIy3GaMGYhi8PF7L+L3/tizuyEo3ZrK6PX8VQSmBleOIG3mydzapmFqG2hqiJrCJ1TXKrolcA01j/DbbQbEXfdyw+siEeLdHp9ugC9bImpTmBX26nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025337; c=relaxed/simple;
	bh=DSLLiMuqyJEXQi6w68HGHfvxNP1ssyS17ez06L6BWDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h860t0jhoJINr03r6k5m8t0OIQZwtiENe2Eh/dJfCVRhla5azynFkO6ObDF+FBd8CPiEuXVJ+QHNU6r8XL79lCGngjQgXJE1+/t+mQP9bCz/lmZK9H0ys2C5mWa9cGg7iScPg5o6+Uo+vLqEwMljdlMlg3yjv5N0fBNsaMkDaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ucZNos2R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=phK95OiKQw9Z7woyQUoFP5sDjuUQIt00WZDTIL2asvk=; b=ucZNos2RIgZP6F8n1TZZu5e/Tn
	K6kqgDgR1ppk63CBfUckQMhWPUedRO+Ya8YVNPRCPad4Y0nbzhc9dCVoKuqXvMJglspdIMBwnSCit
	PFCj0s+n1os/IJj9Ka3P5DUQRQuo3SdOmKLyjLJqqMDlTKwcKaNwvKmyTGk6HWFTwwM42dOHuGVjC
	+I7+sKzoKunGQfXXcvRHb34Yh4T3n9w+O8n10aSrRgKGQK8K+Bt8dZiVRJFEaDCkF5kCYA/L5TQ7F
	iykQnizdzI0oZF09/DXhfJUcxYH9K8jz+/uZDlh3+V47yWJ1f/SmK/cQFhdwAfY3O+UoNDfulb3hm
	1eeY9c3w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNfZR-0000000CQRf-1Yi3;
	Mon, 24 Nov 2025 23:02:09 +0000
Message-ID: <e6ad8812-d59b-40ae-8404-4babf88ec14d@infradead.org>
Date: Mon, 24 Nov 2025 15:02:08 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 02/14] documentation: networking: add shared
 devlink documentation
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
 <1764023259-1305453-3-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1764023259-1305453-3-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/24/25 2:27 PM, Tariq Toukan wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Document shared devlink instances for multiple PFs on the same chip.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../networking/devlink/devlink-shared.rst     | 66 +++++++++++++++++++
>  Documentation/networking/devlink/index.rst    |  1 +
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/networking/devlink/devlink-shared.rst
> 
> diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
> new file mode 100644
> index 000000000000..8377d524998f
> --- /dev/null
> +++ b/Documentation/networking/devlink/devlink-shared.rst
> @@ -0,0 +1,66 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +Devlink Shared Instances
> +============================
> +
> +Overview
> +========
> +
> +Shared devlink instances allow multiple physical functions (PFs) on the same
> +chip to share an additional devlink instance for chip-wide operations. This
> +should be implemented within individual drivers alongside the individual PF
> +devlink instances, not replacing them.
> +
> +The shared devlink instance should be backed by a faux device and should
> +provide a common interface for operations that affect the entire chip
> +rather than individual PFs.
> +
> +Implementation
> +==============
> +
> +Architecture
> +------------
> +
> +The implementation should use:
> +
> +* **Faux device**: Virtual device backing the shared devlink instance
> +* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
> +* **Shared instance management**: Global list of shared instances with reference counting
> +
> +Initialization Flow
> +-------------------
> +
> +1. **PF calls shared devlink init** during driver probe
> +2. **Chip identification** using driver-specific method to determine device identity
> +3. **Lookup existing shared instance** for this chip identifier
> +4. **Create new shared instance** if none exists:
> +
> +   * Create faux device with chip identifier as name
> +   * Allocate and register devlink instance
> +   * Add to global shared instances list
> +
> +5. **Add PF to shared instance** PF list
> +6. **Set nested devlink instance** dor the PF devlink instance

s/dor/for/

> +
> +Cleanup Flow
> +------------
> +
> +1. **Cleanup** when PF is removed; destroy shared instance when last PF is removed
> +
> +Chip Identification
> +-------------------
> +
> +PFs belonging to the same chip are identified using a driver-specific method.
> +The driver is free to choose any identifier that is suitable for determining
> +whether two PFs are part of the same device. Examples include VPD serial numbers,
> +device tree properties, or other hardware-specific identifiers.
> +
> +Locking
> +-------
> +
> +A global per-driver mutex protects the shared instances list and individual shared
> +instance PF lists during registration/deregistration.
> +
> +Similarly to other nested devlink instance relationships, devlink lock of
> +the shared instance should be always taken after the devlink lock of PF.


-- 
~Randy


