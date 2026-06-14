Return-Path: <linux-rdma+bounces-22202-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 93xHK3NULmrotQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22202-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 09:12:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DD680831
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 09:12:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=IP7qcTjV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22202-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22202-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92CCD30134B2
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6FC253340;
	Sun, 14 Jun 2026 07:12:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3013E02A
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jun 2026 07:12:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421168; cv=none; b=L+FyF2dE7EW5ev6Pu6QaflQ0La0zLbcm9PNmJf1EcAAssioxHTqau4044ocS173YHOmgeeMX1bvJnb/u3WY5T39liHVbMXIlhYDJd94bSXCU1aoPdzuarLt6b/Ami3Cd8+ibRbMKIl11D9sSV+T5UqMCdOP8mKqt6kcKpW2Eh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421168; c=relaxed/simple;
	bh=95mlDRW/9KGEhwL26fK2xKyXkIsct9yPZiMRTIvgvuk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPhFAae7xBJjlFthAqjLEme7/4hgAObL55EcVNoClhmXeckONvieubRIqpaLVzso+YxLfpsol/aALNSvN4QpHX16BhTFJs7+9KtFXP6a0VZzE/fT1nPdKbyvjeHsrJl6PpFoP4ZJ0fkmrw1JZhdGBV4twOZhqyVQjpbvCxFMye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IP7qcTjV; arc=none smtp.client-ip=44.246.68.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781421167; x=1812957167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lVEvEJzlelGB/eiWvkpcFVVVSPdiGQoCu6Cmzdkfcf0=;
  b=IP7qcTjVTIBZBDprsIvzsO566rc5MpKXjPVH41pGnWFkeat9oHPMsABD
   bFof8GcSVriO9CbiB0krd+exDs6jr44NDreC5+ykNkXBIvZI1DxkE8hJ5
   hi7rsbGQGJ4zEujdN0TU9xgjEBSJ8EJGfO0c9z0BW1aTvJdy/4HGv5FCo
   pKGA/TL4hoNAZ10l1aRo2oh+4EoZ5svRb+3E7tWj3bsEjvvnRUZB/bnGY
   6NrRBXsHh7v2K0/vSF2cJOmmdPcJfsaUKns96KPHv2GQl6SW70KF9RO6J
   7Qgdk9BekOEty5Ey3ESzlTYsdz+9iUMQaqwVMolZRkEqpq95zALEOW0ab
   A==;
X-CSE-ConnectionGUID: S0kc5PxSSP2esslTDqTUjw==
X-CSE-MsgGUID: K2Wpu/7dQAKm4qloUysQqg==
X-IronPort-AV: E=Sophos;i="6.24,204,1774310400"; 
   d="scan'208";a="21730350"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 07:12:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:4917]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.146:2525] with esmtp (Farcaster)
 id 0246f2ef-b528-49c8-9768-0caf0e41d602; Sun, 14 Jun 2026 07:12:44 +0000 (UTC)
X-Farcaster-Flow-ID: 0246f2ef-b528-49c8-9768-0caf0e41d602
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 14 Jun 2026 07:12:44 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sun, 14 Jun 2026
 07:12:42 +0000
Date: Sun, 14 Jun 2026 07:12:29 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>
Subject: Re: [PATCH for-next v4 0/2] RDMA/efa: Add AH cache for AH reuse
Message-ID: <20260614071229.GA29713@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260608071620.1909543-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260608071620.1909543-1-ynachum@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22202-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF9DD680831

On Mon, Jun 08, 2026 at 07:16:18AM +0000, Yonatan Nachum wrote:
> Changelog:
> v4:
>  * Use kzalloc_obj for AH cache entry allocation instead of kzalloc
> v3: https://lore.kernel.org/all/20260607161753.1607559-1-ynachum@amazon.com/
>  * Address Sashiko comments in:
>    https://sashiko.dev/#/patchset/20260512061121.2177521-1-ynachum%40amazon.com
> v2: https://lore.kernel.org/all/20260512061121.2177521-1-ynachum@amazon.com/
>  * Zero-initialize AH cache key on cache lookup.
> v1: https://lore.kernel.org/all/20260510083035.458081-1-ynachum@amazon.com/
> 
> -------------------------------------------------------------------------
> New EFA devices don't support the creation of multiple AHs to the same
> remote on the same PD. To overcome this limitation, introduce an AH
> cache that manages AH reuse transparently.
> 
> The cache uses an rhashtable keyed by (PD, GID) to track active address
> handles with refcounts. On create AH, the driver returns an existing AH
> number if one is already cached, or creates a new one and caches it. On
> destroy AH, the driver only issues the device destroy command when the
> last reference is dropped.
> 
> A per-entry mutex serializes concurrent device commands on the same
> cache entry, preventing create-before-destroy races on the device.
> 
> Yonatan Nachum (2):
>   RDMA/efa: Add initialization of AH cache rhashtable
>   RDMA/efa: Add AH cache handling on create and destroy AH
> 
>  drivers/infiniband/hw/efa/Makefile       |   4 +-
>  drivers/infiniband/hw/efa/efa_ah_cache.c | 163 +++++++++++++++++++++++
>  drivers/infiniband/hw/efa/efa_ah_cache.h |  42 ++++++
>  drivers/infiniband/hw/efa/efa_com.c      |  12 +-
>  drivers/infiniband/hw/efa/efa_com.h      |   3 +
>  drivers/infiniband/hw/efa/efa_com_cmd.c  |  73 +++++++---
>  drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
>  drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
>  8 files changed, 281 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
>  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> 
> -- 
> 2.50.1
>

Hi, kind reminder.
This series blocks merging EFAv4 device ID and we would want it to land
for the next merge window if possible.

I reviewed the last Sashiko comment and it's not relevant since on
destroy AH failure, we keep the entry in the hashtable.

Thanks
 

