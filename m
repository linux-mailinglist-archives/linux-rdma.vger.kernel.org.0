Return-Path: <linux-rdma+bounces-22782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zZtwJuJmSmr4CQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:14:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 437CF70A447
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:14:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IlSDMdQZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22782-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22782-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD9D300C924
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A83815CA;
	Sun,  5 Jul 2026 14:14:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991E2C15A5
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 14:14:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260892; cv=none; b=TTLaXVGvJE7pnUrtx08BOk09sPHo792XDlkCY6VUQgvu7FPK0gbmnoj43UO2QGzWojIW1yAqFX4jWsB6f7FKFuBFbOyb95bIn0CMvSn+O2Z4xO+zjdlgJb83bvees5x3L+PksLktETeaequyrtlKQMOrt2sBBDrgLSvavn0q3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260892; c=relaxed/simple;
	bh=Fq9Qx0mXiFuYZ2ghX6ytJcl+73+WMQRarD7pP1Pcpes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQczOryiRmNYroPO2P4N5z6iKv8EGnlaNUgl9tZwfgVMQ9nT86x7+wRbTSLzA9TMBJpg7EZ2fdEcyvdQsCjwQgWnRdLJNn0D9W9JY/r3zGe/OZLxNWNOuMLnptNxXg4Vz1D30lk6v9V/g5qR+snE7+YFr+Kw2k66n3vhyH9Sws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlSDMdQZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327EF1F000E9;
	Sun,  5 Jul 2026 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260891;
	bh=Gglwp5u39yEO5ySnAziY38Qycfv3qWfUa6p+GKDcOsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IlSDMdQZwc2lNyhs4elDGXhvIhY0ox7IfoLN7T2LtKlTaw4OUFhtrZA5jy8Qde2kT
	 x60gfMW/tBdjITgDy1Qshirq/iGFhXVNpRWiOenuajQAMiW9IINMo2CySRX73YP29x
	 lTzXFpvCgZztotjXzpW7XAWs3SJ54k1y77fChqHQIyg2LIvkZSincqMqp0xQzZqLFt
	 NBTGGhD8B/PoSRpR3GQpRcFUrVgAHXBw6WmQaQY7vYDgsc2z5MY3z1bN9KS5qDqFEn
	 nMnBH9AeDPLLQGlSxyY3mmq11SouRkRo9WusotJkrkDzFL5nln+wnC2PnPYHoaWD8+
	 oAIrkjYcN1k8w==
Date: Sun, 5 Jul 2026 17:14:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-next 22/24] RDMA/hfi2: Make it build and add TODO
 list
Message-ID: <20260705141445.GH15188@unreal>
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
 <178257760571.371918.16037129577290305717.stgit@awdrv-04>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178257760571.371918.16037129577290305717.stgit@awdrv-04>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22782-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 437CF70A447

On Sat, Jun 27, 2026 at 12:26:45PM -0400, Dennis Dalessandro wrote:
> Fix various compilation errors found when building the full driver for
> the first time: correct kzalloc_obj() dereference calls throughout,
> fix miscellaneous type and reference errors across multiple files, and
> update Kconfig entries for both hfi1 (Gen1/WFR) and hfi2 (Gen2/JKR)
> to clarify hardware scope. Also add a TODO list file.
> 
> Assisted-by: Claude:claude-sonnet-4-5
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> ---
> Changes since v3:
> - Add TODO file
> Changes since v2:
> - Restrict hfi2 PCI device table to JKR (CN5000) only; WFR (Intel 0x24f0/0x24f1)
>   is handled exclusively by hfi1. This separation is temporary: hfi2 will
>   eventually support both WFR and JKR at which point hfi1 will be removed.
> - Update Kconfig title and help text to reflect JKR-only scope.
> ---
>  drivers/infiniband/hw/hfi1/Kconfig        |    5 -
>  drivers/infiniband/hw/hfi2/Kconfig        |   32 ++++
>  drivers/infiniband/hw/hfi2/TODO           |    6 +
>  drivers/infiniband/hw/hfi2/chip.c         |    2 
>  drivers/infiniband/hw/hfi2/chip_gen.c     |    2 
>  drivers/infiniband/hw/hfi2/cport.c        |    4 
>  drivers/infiniband/hw/hfi2/fault.c        |    2 
>  drivers/infiniband/hw/hfi2/file_ops.c     |  123 ++------------
>  drivers/infiniband/hw/hfi2/file_ops.h     |    5 -
>  drivers/infiniband/hw/hfi2/hfi2.h         |    2 
>  drivers/infiniband/hw/hfi2/init.c         |    6 -
>  drivers/infiniband/hw/hfi2/mad.c          |    4 
>  drivers/infiniband/hw/hfi2/pin_system.c   |    2 
>  drivers/infiniband/hw/hfi2/qsfp.c         |    2 
>  drivers/infiniband/hw/hfi2/sdma.c         |    4 
>  drivers/infiniband/hw/hfi2/tid_rdma.c     |    2 
>  drivers/infiniband/hw/hfi2/tid_system.c   |    2 
>  drivers/infiniband/hw/hfi2/user_exp_rcv.c |    2 
>  drivers/infiniband/hw/hfi2/uverbs.c       |  262 +++++++++++++++++++++++------
>  drivers/infiniband/hw/hfi2/uverbs.h       |   24 +++
>  drivers/infiniband/hw/hfi2/verbs.c        |    6 +
>  drivers/infiniband/hw/hfi2/vf2pf_lb.c     |    2 
>  22 files changed, 317 insertions(+), 184 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hfi2/Kconfig
>  create mode 100644 drivers/infiniband/hw/hfi2/TODO
> 
> diff --git a/drivers/infiniband/hw/hfi1/Kconfig b/drivers/infiniband/hw/hfi1/Kconfig
> index 14b92e12bf29..a006dd112966 100644
> --- a/drivers/infiniband/hw/hfi1/Kconfig
> +++ b/drivers/infiniband/hw/hfi1/Kconfig
> @@ -1,12 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config INFINIBAND_HFI1
> -	tristate "Cornelis OPX Gen1 support"
> +	tristate "Cornelis OPX Gen1 (WFR) support"
>  	depends on X86_64 && INFINIBAND_RDMAVT && I2C && !UML
>  	select MMU_NOTIFIER
>  	select CRC32
>  	select I2C_ALGOBIT
>  	help
> -	This is a low-level driver for Cornelis OPX Gen1 adapter.
> +	This is a low-level driver for Cornelis OPX Gen1 (WFR) adapters.
> +	For Gen2 (JKR) adapters use INFINIBAND_HFI2.
>  config HFI1_DEBUG_SDMA_ORDER
>  	bool "HFI1 SDMA Order debug"
>  	depends on INFINIBAND_HFI1
> diff --git a/drivers/infiniband/hw/hfi2/Kconfig b/drivers/infiniband/hw/hfi2/Kconfig
> new file mode 100644
> index 000000000000..7e3d80b3c459
> --- /dev/null
> +++ b/drivers/infiniband/hw/hfi2/Kconfig
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright(c) 2025-2026 Cornelis Networks, Inc.
> +config INFINIBAND_HFI2
> +	tristate "Cornelis OPX Gen2 (JKR) support"
> +	depends on X86_64 && INFINIBAND_RDMAVT && I2C && !UML
> +	depends on PCI_IOV
> +	select MMU_NOTIFIER
> +	select CRC32
> +	select I2C_ALGOBIT
> +	help
> +	This is a low-level driver for Cornelis OPX Gen2 (JKR) adapters.
> +	For Gen1 (WFR) adapters use INFINIBAND_HFI1. This separation is
> +	temporary; hfi2 will eventually support both WFR and JKR hardware
> +	at which point hfi1 will be removed.
> +config HFI2_DEBUG_SDMA_ORDER
> +	bool "HFI2 SDMA Order debug"
> +	depends on INFINIBAND_HFI2
> +	default n
> +	help
> +	  Enable this debug flag to test for out-of-order SDMA completions
> +	  during unit testing. This option adds extra tracking to detect
> +	  when SDMA completions arrive out of sequence, which should not
> +	  happen in normal operation.
> +config HFI2_SDMA_VERBOSITY
> +	bool "Config SDMA Verbosity"
> +	depends on INFINIBAND_HFI2
> +	default n
> +	help
> +	  Enable this flag to turn on verbose SDMA debug logging. This
> +	  produces additional diagnostic output useful for debugging SDMA
> +	  issues. Should not be enabled in production as it generates
> +	  significant log output.

When working on Sashiko fixes, please add blank lines between
sections and remove "default n".

Thanks

