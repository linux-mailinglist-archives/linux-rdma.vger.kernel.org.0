Return-Path: <linux-rdma+bounces-16928-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK1iOCM5k2mV2gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16928-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:34:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DBD145A6C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 16:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E2030626D8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D39330661;
	Mon, 16 Feb 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TaC2qqbq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CE330663;
	Mon, 16 Feb 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255852; cv=none; b=Y//LqEPq0+Y/hx98EQl9er8j7xqR6me9KZnY/qtvC5ar6FbCkbxkclfV5ulrL300O3OvfxA4DQs0EjXkuYqy9+PRqk4YX4euvWrRO0QZQjuDs9VmXDykO6DR0rzghOTXbIhkHhtjUj3KJbQ2NiiKtvp5Drywi+wZnZbf3/n/4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255852; c=relaxed/simple;
	bh=JKNHMpx3yq0jiEieeHswi3zu1UaTifUdqlYzJFKoAqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K10hk7HTEuEFRutefE2X/+WL2zNyXjgfzeXqkAcuLvJa198wcg02GqDtQquKC+RSz1Vf+ZTgxn40wfjGKzo6mLIO3W8tq8yoxR/0PGF6RkRE1itqd45T1OKhfZY3AqtPLT7CUeIBzwax+LWe8YTcf63EluuogN4iM25WB7R93no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TaC2qqbq; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771255850; x=1802791850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfyoHcCiDCW03EJ58y///IjxjOhvq51fdzKxrrdmd4Q=;
  b=TaC2qqbqp5ikKQpVCHwvXud4HSpNoe5OZz25Ac8ZU37F3sus0gcmlMeI
   H6MgNsAwN9VRrtyj3rj/Y5iYGoA8XV1fsMdTtAcdPBvLdyJZ6q2HRYBX3
   XgBZ6ewfMXHgQzo8ZVbuL2qYngtlLN2c5HjU8r6EZSZ7lC0gvC2o+Vaa9
   Fpq38Cf4DlgTaHYqXI/rnmubrWBFRREDhBMIY60V5zmaqTYtx48+NSUYM
   dVK+JimYp5OaZmXtqijtIuufSRqguchY0WfT4BW39KmyWeXgJe70lYCCF
   GOnvnxfaB5kUAYlZgMIJye36Z05NOTZE3dhyB+DpfK4p01aEJcWCwN5/+
   g==;
X-CSE-ConnectionGUID: /FbvtV2CTKet3dlJ/Pg++w==
X-CSE-MsgGUID: lHTo2/GRSnKwNqAatp9b4g==
X-IronPort-AV: E=Sophos;i="6.21,294,1763424000"; 
   d="scan'208";a="13157256"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 15:30:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:31876]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.75:2525] with esmtp (Farcaster)
 id 13cb868a-ded5-4244-8ed7-092409e5b678; Mon, 16 Feb 2026 15:30:47 +0000 (UTC)
X-Farcaster-Flow-ID: 13cb868a-ded5-4244-8ed7-092409e5b678
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 15:30:47 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Mon, 16 Feb 2026
 15:30:44 +0000
Date: Mon, 16 Feb 2026 15:30:34 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Gal Pressman <gal.pressman@linux.dev>, Krzysztof Czurylo
	<krzysztof.czurylo@intel.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, Yossi Leybovich <sleybo@amazon.com>, "Tatyana
 Nikolova" <tatyana.e.nikolova@intel.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, Andrew Boyer
	<andrew.boyer@amd.com>, Gal Pressman <galpress@amazon.com>, Mustafa Ismail
	<mustafa.ismail@intel.com>, <patches@lists.linux.dev>, Roland Dreier
	<rolandd@cisco.com>, Shiraz Saleem <shiraz.saleem@intel.com>,
	<stable@vger.kernel.org>, Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rc 1/4] RDMA/efa: Fix typo in efa_alloc_mr()
Message-ID: <20260216153008.GA32101@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
 <1-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16928-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91DBD145A6C
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 11:02:47AM -0400, Jason Gunthorpe wrote:w3esq23

> The pattern is to check the entire driver request space, not just
> sizeof something unrelated.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 22d3e25c3b9d11..c066cd84aa6407 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1667,7 +1667,7 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
>  	struct efa_mr *mr;
>  
>  	if (udata && udata->inlen &&
> -	    !ib_is_udata_cleared(udata, 0, sizeof(udata->inlen))) {
> +	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
>  		ibdev_dbg(&dev->ibdev,
>  			  "Incompatible ABI params, udata not cleared\n");
>  		return ERR_PTR(-EINVAL);
> -- 
> 2.43.0
>

Thanks!

Acked-by: Michael Margolin <mrgolin@amazon.com>

