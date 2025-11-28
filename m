Return-Path: <linux-rdma+bounces-14815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE5C90D2C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 05:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C14034F430
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33382FC899;
	Fri, 28 Nov 2025 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhDG0e7M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E321CC64;
	Fri, 28 Nov 2025 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764303408; cv=none; b=J25N48jl8smF2fR/K8Du8CUH5N7yvOBTqXB0XdCEjzDrczrhAc1MZBQX7GavulclxA5yRDtfCJiNK8Lwf7J4EkU0qO3IQler7Rqj/BGiOTTwsbyN5TrLBg7abBThnYfYv4+yEX3rxpzh68gQ9XiUzCzcoEcK5sOFwHW+7CYjwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764303408; c=relaxed/simple;
	bh=LuWc4OPdwOePNFT72nG7ZLXUHvAW3UEQTHkrGj7af+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVQq2ewfmxSzD0IakA2j3+WdoBRwQOfjU31Xztnm3JAhNaOZm/WoNY0MeIlv1fz3z4SmiTWHQAFuN7GC0r8ZQBdZLdnpr8E6oQH0pqG2ecOn2E9/QRlJBzy4eyZN78S4pvka83RI4WJ8vCsv69b9YGOk8O7ZRtVHNNET3jnSRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhDG0e7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7EEC4CEF1;
	Fri, 28 Nov 2025 04:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764303407;
	bh=LuWc4OPdwOePNFT72nG7ZLXUHvAW3UEQTHkrGj7af+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FhDG0e7MLVVidQgSV2u34kGymZf2UUB7vXAOvbHGQrEkaHqN1JRQuR4U6S2aoz7MH
	 xtuA2lSF4bFoVMWkZjrY321+3bnU0OdrPDOrB0zk6PfiLNkJdiy/Lyo6Q2MizTi7EY
	 xrxEWJBkDydW1VSkYMIWwdX2hHr7ks/u4gw/1AEO8iYgM6YzS2Dr+YxgaOArI23UGz
	 dn5rzJJM/R9iOYlL7gbygOuU7h6WE/ClT34ZlNWLHYTRD7ikgkNdjXDYvbA6iXhJmO
	 aWMRwY9n99AgFrafBcDW34CHC/sMUJY79cy+apPOFuD490M2RF92iR/A+0lRM+WWsC
	 YUegCD27q+G+Q==
Date: Thu, 27 Nov 2025 20:16:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 02/14] documentation: networking: add shared
 devlink documentation
Message-ID: <20251127201645.3d7a10f6@kernel.org>
In-Reply-To: <1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	<1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 22:06:01 +0200 Tariq Toukan wrote:
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
> index 000000000000..be9dd6f295df
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

If we go with this we must state very clearly that this is a crutch and
_not_ the recommended configuration...

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
> +6. **Set nested devlink instance** for the PF devlink instance

... because presumably we could use this infra to manage a single
devlink instance? Which is what I asked for initially.

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

Why can't this mutex live in the core?

> +Similarly to other nested devlink instance relationships, devlink lock of
> +the shared instance should be always taken after the devlink lock of PF.
> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index 35b12a2bfeba..f7ba7dcf477d 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -68,6 +68,7 @@ general.
>     devlink-resource
>     devlink-selftests
>     devlink-trap
> +   devlink-shared
>  
>  Driver-specific documentation
>  -----------------------------


