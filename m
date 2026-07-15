Return-Path: <linux-rdma+bounces-23254-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id quZ9J185V2qjHgEAu9opvQ
	(envelope-from <linux-rdma+bounces-23254-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:40:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F95375B862
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:40:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=dVNBla6e;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23254-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23254-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80A6B300F5EC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E8C3C3791;
	Wed, 15 Jul 2026 07:40:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BE3B840E
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 07:40:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101213; cv=none; b=X5ghYFw3ZJe+fxInywPHNoqyuTk+tUo2cqB0/wY3PA/i3MzSby8VA1lWTZnoA86YYjXB0SG0ts63tjH46Ojvn92xJno03ToMwomXLTdSb9It/yjTIF156AFxoPvLBs9p750Fsz1WaXOULtQfynt94MtcWc7QUcoceNkGMb18728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101213; c=relaxed/simple;
	bh=FQaDkcKNlhV2gCO7MgNjwR8yxAfCXGJCo7/zsZsOsRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVJXl98Ll51+aLuEJ+24UwNMLm6Q+Wo8uYoAMXEuWnuiax/uBUWAYSuswcFXiIkdv8tON+VCdQho4vfrupmB0vvkqKwIj0fGHvRXs3zz5+jKMoEC9VmQqeJ5WhYwjg1ZLsfWvT8eBRxbPmVInVMQxVByf0+85+TMWduQIpLTJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dVNBla6e; arc=none smtp.client-ip=35.83.148.184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784101212; x=1815637212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/QdDPHYKfF514WqUIPtTStwRULR+s5cTjuAJvqywOhQ=;
  b=dVNBla6eEyvMM6ak/wlexVNcTcngonN6AOsQcDDKQKKfE4Kdub1OZQ/R
   P4BzIhd+quIzeBUhfADZ9dwwZu7lhFR0aU6rlho7Fh9a90EkEsg0O5w7G
   8yw+xvTNKh28Iq8eKmL4+RblY1iYTQrdW/DShPdq0JN176z86i064GPVU
   o2I0Y+rCJV9yMcsPKrc/xTF5N4SmxRrL1XrQRwqzytWHJfqg5hlWptjFP
   gAppEec/G56Wh1ipvjRwu54Vrji2vbLnoAzEoLyjViWiLnnGFLbLMzXmu
   yCam3cPR1q2Q7sB1h2IAifZiAZHHiiLYKbk5GcAjshcJ3cwg3d3s2g3nV
   w==;
X-CSE-ConnectionGUID: tGSZRkFISEeBO5Il/p9hlw==
X-CSE-MsgGUID: izQUiNvkSAa5t+fRkyGuDg==
X-IronPort-AV: E=Sophos;i="6.25,165,1779148800"; 
   d="scan'208";a="23487394"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:40:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:12023]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525] with esmtp (Farcaster)
 id 1b1f8bd2-3897-4587-b1d2-ae01154c47a1; Wed, 15 Jul 2026 07:40:08 +0000 (UTC)
X-Farcaster-Flow-ID: 1b1f8bd2-3897-4587-b1d2-ae01154c47a1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 15 Jul 2026 07:40:08 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Wed, 15 Jul 2026
 07:40:07 +0000
Date: Wed, 15 Jul 2026 07:39:58 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: Re: [PATCH for-next v8 0/5] Introduce Completion Counters
Message-ID: <20260715073958.GA21197@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260707203427.6923-1-mrgolin@amazon.com>
 <20260708123640.GA9082@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260708123640.GA9082@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid];
	TAGGED_FROM(0.00)[bounces-23254-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 2F95375B862

On Wed, Jul 08, 2026 at 12:36:40PM +0000, Michael Margolin wrote:
> On Tue, Jul 07, 2026 at 08:34:22PM +0000, Michael Margolin wrote:
> > Add core infrastructure for Completion Counters, a light-weight
> > alternative to polling CQ for tracking operation completions. The
> > related rdma-core support is linked in [1].
> > 
> > Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create, destroy,
> > modify and read methods for both success and error counters. Add a QP
> > attach method on the QP object to associate a completion counter with a
> > queue pair.
> > 
> > Add EFA Completion Counters support as first implementer.
> > 
> > [1] https://github.com/linux-rdma/rdma-core/pull/1701
> > 
> 
> Walked over Sashiko's comments, most of them are about usage count
> which is handled in a follow-up patch in the series. The others don't
> seem to be real issues.
> 
> https://sashiko.dev/#/patchset/20260707203427.6923-1-mrgolin%40amazon.com
> 
> Jason, Leon do you have any other comments?
> 
> Michael
>

I need your feedback on this series, specifically on the ABI changes
(and libibverbs), to unblock progress in upper layers that depend on
this support (libfabric, NCCL).

Michael

> > ---
> > Changes in v8:
> > - Added device event counter detach support and its use in attach error
> >   handling
> > - Prevented completion counters attach to wrapper QPs
> > - Added max completion counters report in nldev
> > - Link to v7: https://lore.kernel.org/all/20260701103448.17895-1-mrgolin@amazon.com/
> > Changes in v7:
> > - Rebased on latest rdma for-next
> > - Link to v6: https://lore.kernel.org/all/20260604114627.6086-1-mrgolin@amazon.com/
> > Changes in v6:
> > - Moved to using ib_umem_get_attr util
> > - Resolved additional Sashiko comments
> > - Link to v5: https://lore.kernel.org/all/20260526090712.17575-1-mrgolin@amazon.com/
> > Changes in v5:
> > - Fixed Sashiko findings
> > - Minor naming improvements
> > - Link to v4: https://lore.kernel.org/all/20260511223721.18365-1-mrgolin@amazon.com/
> > Changes in v4:
> > - Replaced inc and set commands by a single modify command
> > - Changed to passing buffers as EFA specific attributes using desc
> >   struct aligned with the suggested common method of passing and
> >   consuming umem in RDMA drivers
> > - Link to v2: https://lore.kernel.org/all/20260416212327.18191-1-mrgolin@amazon.com/
> > Changes in v3:
> > - Skipped this version because of a wrong patch list
> > Changes in v2:
> > - United set, inc and read flows for successful and error completions
> >   counters
> > - Added comp_cntr usage count
> > - Minor cleanups
> > - Link to v1: https://lore.kernel.org/all/20260407115424.13359-1-mrgolin@amazon.com/
> > 
> > Michael Margolin (5):
> >   RDMA/core: Add Completion Counters support
> >   RDMA/core: Prevent destroying in-use completion counters
> >   RDMA/core: Add Completion Counters to resource tracking
> >   RDMA/efa: Update device interface
> >   RDMA/efa: Add Completion Counters support
> > 
> >  drivers/infiniband/core/Makefile              |   1 +
> >  drivers/infiniband/core/device.c              |   6 +
> >  drivers/infiniband/core/nldev.c               |   4 +
> >  drivers/infiniband/core/rdma_core.h           |   1 +
> >  drivers/infiniband/core/restrack.c            |   2 +
> >  drivers/infiniband/core/uverbs_cmd.c          |   1 +
> >  .../core/uverbs_std_types_comp_cntr.c         | 182 +++++++++++++++
> >  drivers/infiniband/core/uverbs_std_types_qp.c |  67 +++++-
> >  drivers/infiniband/core/uverbs_uapi.c         |   1 +
> >  drivers/infiniband/core/verbs.c               |   8 +
> >  drivers/infiniband/hw/efa/efa.h               |  15 ++
> >  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 186 +++++++++++++++-
> >  drivers/infiniband/hw/efa/efa_com_cmd.c       | 134 +++++++++++
> >  drivers/infiniband/hw/efa/efa_com_cmd.h       |  44 ++++
> >  drivers/infiniband/hw/efa/efa_io_defs.h       |  20 +-
> >  drivers/infiniband/hw/efa/efa_main.c          |   5 +
> >  drivers/infiniband/hw/efa/efa_verbs.c         | 209 ++++++++++++++++++
> >  include/rdma/ib_verbs.h                       |  44 ++++
> >  include/rdma/restrack.h                       |   4 +
> >  include/uapi/rdma/efa-abi.h                   |   6 +
> >  include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 ++++
> >  include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
> >  include/uapi/rdma/ib_user_verbs.h             |   2 +-
> >  23 files changed, 993 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c
> > 
> > -- 
> > 2.47.3
> > 

