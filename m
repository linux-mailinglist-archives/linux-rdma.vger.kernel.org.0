Return-Path: <linux-rdma+bounces-22895-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1xDDOcVFTmr/JwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22895-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 14:42:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06A726661
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 14:42:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=dkH2ywJB;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22895-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22895-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02163032073
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A244CF40;
	Wed,  8 Jul 2026 12:36:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A644CAFB
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 12:36:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514215; cv=none; b=XjBPPUBq9QMIJcqKpOf7mUp5g8uP67AyyOVSlI5c5wIUDuYS5z2Gs1dNPuTWzC6zoDq803hCa3TlwHbf5VRn+1L+A116CrOAAiSTUsaBdvy5KSwtG71ESmIx/Aoqbo5GeUepnHdcq4o3KvAbdc5ZfYsbehaKAHAXLSPT+m+en8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514215; c=relaxed/simple;
	bh=me1bLjmSs3LVsaNhmg1bKd/rZ7YLmtq8am85apxRzCc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rivvc8vwbm2JQCzSS8AYXsA1J+kbU2Jgo+weuddkh8Qewr58wJzM9PkM9CHc28l07itezgXxCeG0uMbOYlOpdXBvpI+ZCr22nEytCPS6UrUx500vDEpoZW+z8SLjvUdkW2QdnEWGm+34dErSHy6KxOBtxLPf6TaxZ/fOLQG2GAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dkH2ywJB; arc=none smtp.client-ip=52.42.203.116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783514212; x=1815050212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JU+Q6ddPYgM8RYTpJlxSmv36hOf6HV7YVXcN1LGtofk=;
  b=dkH2ywJBOT6DGXPCbNndnahov8tvmTIi6pfOo4MJ+ZBAIkUEFqXVEKLh
   u3D7cKze9yVcFB+yIbUJGBZ3VN6G1LHTi1NOQYuU7CBj3+kw2HSYXGFVf
   X+YvoBBZk62RofUH/cQ7FaofaFnYD+0GjaOga89hBowyKSByw5yGiulfV
   yuqE8KXy69ouQSIyiRCPTzNgca0XgEPmeJn8itsDhoABXEOlapL/hpyEW
   nZrxnHDExQ+rbzc5Cl2R49UuzFiFEBMX2C3dRmKMQ2qYJDCuhNCDjmdMe
   oGU+RzYqYDql8vDSbetzg91EJYAvaCXmyLMC4G97S0s4byo78WdMbPh6E
   Q==;
X-CSE-ConnectionGUID: yrKg9SpqRzGqFsVnRQBZQg==
X-CSE-MsgGUID: uvI7/bSIQvOE7JbihKyxNA==
X-IronPort-AV: E=Sophos;i="6.25,153,1779148800"; 
   d="scan'208";a="23306962"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:36:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:10970]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.2:2525] with esmtp (Farcaster)
 id 74139147-6b28-487e-98ba-275784eb0a22; Wed, 8 Jul 2026 12:36:49 +0000 (UTC)
X-Farcaster-Flow-ID: 74139147-6b28-487e-98ba-275784eb0a22
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 8 Jul 2026 12:36:49 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Wed, 8 Jul 2026
 12:36:47 +0000
Date: Wed, 8 Jul 2026 12:36:40 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: Re: [PATCH for-next v8 0/5] Introduce Completion Counters
Message-ID: <20260708123640.GA9082@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260707203427.6923-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260707203427.6923-1-mrgolin@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url];
	TAGGED_FROM(0.00)[bounces-22895-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A06A726661

On Tue, Jul 07, 2026 at 08:34:22PM +0000, Michael Margolin wrote:
> Add core infrastructure for Completion Counters, a light-weight
> alternative to polling CQ for tracking operation completions. The
> related rdma-core support is linked in [1].
> 
> Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create, destroy,
> modify and read methods for both success and error counters. Add a QP
> attach method on the QP object to associate a completion counter with a
> queue pair.
> 
> Add EFA Completion Counters support as first implementer.
> 
> [1] https://github.com/linux-rdma/rdma-core/pull/1701
> 

Walked over Sashiko's comments, most of them are about usage count
which is handled in a follow-up patch in the series. The others don't
seem to be real issues.

https://sashiko.dev/#/patchset/20260707203427.6923-1-mrgolin%40amazon.com

Jason, Leon do you have any other comments?

Michael

> ---
> Changes in v8:
> - Added device event counter detach support and its use in attach error
>   handling
> - Prevented completion counters attach to wrapper QPs
> - Added max completion counters report in nldev
> - Link to v7: https://lore.kernel.org/all/20260701103448.17895-1-mrgolin@amazon.com/
> Changes in v7:
> - Rebased on latest rdma for-next
> - Link to v6: https://lore.kernel.org/all/20260604114627.6086-1-mrgolin@amazon.com/
> Changes in v6:
> - Moved to using ib_umem_get_attr util
> - Resolved additional Sashiko comments
> - Link to v5: https://lore.kernel.org/all/20260526090712.17575-1-mrgolin@amazon.com/
> Changes in v5:
> - Fixed Sashiko findings
> - Minor naming improvements
> - Link to v4: https://lore.kernel.org/all/20260511223721.18365-1-mrgolin@amazon.com/
> Changes in v4:
> - Replaced inc and set commands by a single modify command
> - Changed to passing buffers as EFA specific attributes using desc
>   struct aligned with the suggested common method of passing and
>   consuming umem in RDMA drivers
> - Link to v2: https://lore.kernel.org/all/20260416212327.18191-1-mrgolin@amazon.com/
> Changes in v3:
> - Skipped this version because of a wrong patch list
> Changes in v2:
> - United set, inc and read flows for successful and error completions
>   counters
> - Added comp_cntr usage count
> - Minor cleanups
> - Link to v1: https://lore.kernel.org/all/20260407115424.13359-1-mrgolin@amazon.com/
> 
> Michael Margolin (5):
>   RDMA/core: Add Completion Counters support
>   RDMA/core: Prevent destroying in-use completion counters
>   RDMA/core: Add Completion Counters to resource tracking
>   RDMA/efa: Update device interface
>   RDMA/efa: Add Completion Counters support
> 
>  drivers/infiniband/core/Makefile              |   1 +
>  drivers/infiniband/core/device.c              |   6 +
>  drivers/infiniband/core/nldev.c               |   4 +
>  drivers/infiniband/core/rdma_core.h           |   1 +
>  drivers/infiniband/core/restrack.c            |   2 +
>  drivers/infiniband/core/uverbs_cmd.c          |   1 +
>  .../core/uverbs_std_types_comp_cntr.c         | 182 +++++++++++++++
>  drivers/infiniband/core/uverbs_std_types_qp.c |  67 +++++-
>  drivers/infiniband/core/uverbs_uapi.c         |   1 +
>  drivers/infiniband/core/verbs.c               |   8 +
>  drivers/infiniband/hw/efa/efa.h               |  15 ++
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 186 +++++++++++++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c       | 134 +++++++++++
>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  44 ++++
>  drivers/infiniband/hw/efa/efa_io_defs.h       |  20 +-
>  drivers/infiniband/hw/efa/efa_main.c          |   5 +
>  drivers/infiniband/hw/efa/efa_verbs.c         | 209 ++++++++++++++++++
>  include/rdma/ib_verbs.h                       |  44 ++++
>  include/rdma/restrack.h                       |   4 +
>  include/uapi/rdma/efa-abi.h                   |   6 +
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 ++++
>  include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
>  include/uapi/rdma/ib_user_verbs.h             |   2 +-
>  23 files changed, 993 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c
> 
> -- 
> 2.47.3
> 

