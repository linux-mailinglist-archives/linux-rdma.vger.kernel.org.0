Return-Path: <linux-rdma+bounces-19277-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AcNM+q23Gm2VgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19277-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 11:27:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C93E9D4A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5FDF3010386
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F543B19D4;
	Mon, 13 Apr 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="E2Lgo5bU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418B3B19A7
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072111; cv=none; b=baMNA6eBLI+GHg2eoLNTosqxAbRu80U1yHuVjuIumJYsdqUT2/mVPp4JiPG5lBfkZAxKQGt4srHrBx5zi0FkxDgqz2IXR8GpaVs0DkjwuTuOju3YRfzWhqLuo/o1DKUFBp0DFXQMEiyQ4x2UkChyNuQYgfj0aBoI9M48ixBA09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072111; c=relaxed/simple;
	bh=1kp9MAydXVEMmAiaq0kHR1QxiJ2YMm0i+8J6gO05zqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQYkNe5CXC8eUikMhOJLOBP2cxaZ+fRlJiTeDZZ7Wrzo9xu7uxEs/qebeJrobskMAHBZYXiyKUlIhm0YfTdT2P1nFM5AN/qzMwEdSRy2t6Z0D4uKHGukY36HVgLM5vzA/PyGGkI1FlrmRGvup1g7ArLa/2KsdOrlvAdaNNedUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=E2Lgo5bU; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776072110; x=1807608110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D4U1nfz6QL1h/GlQy8fif0OV1TLyUxLk1ahx4oPbXCs=;
  b=E2Lgo5bU2goek7jaYLk6CQOK1X23dQL9Fi/lProUOI2kJeMVyY7ILDqa
   vN9d5lqMP4ksUDNX5rAMU97Ykj9p4MgQczoc1Qq8SBfEXFaDH+YwHzLoN
   eDMuXIS2TjUvNFo5lkhhKUR6vlRvz7C97IqmpLTH2sn6ObrbtYB/NIF97
   cGd8EqyVfdBcCVPB6C0XuLtW8SworhRicboxWrlEff5wSoSnplW6m01nN
   3Mzhj0sPvOXQhFmsmb1pPCLSpYDQJBB3b12KX8B9ke2pUbIpz3ye11ntq
   3P71XndegSrYHQkNO6NPebVF+m6krSDW2wzP5pSsfrTYvu59qon/4CzR1
   g==;
X-CSE-ConnectionGUID: d3WWzw+eT6SpYpotj+7pJw==
X-CSE-MsgGUID: aUAZ+ubaRWK9+2fOmvBwsA==
X-IronPort-AV: E=Sophos;i="6.23,176,1770595200"; 
   d="scan'208";a="16933109"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 09:21:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:21458]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.131:2525] with esmtp (Farcaster)
 id d2b2c853-ef48-43b8-acc0-198c3a62b8e1; Mon, 13 Apr 2026 09:21:47 +0000 (UTC)
X-Farcaster-Flow-ID: d2b2c853-ef48-43b8-acc0-198c3a62b8e1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 13 Apr 2026 09:21:45 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 13 Apr 2026
 09:21:44 +0000
Date: Mon, 13 Apr 2026 09:21:30 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/efa: Add checksum support for admin
 responses
Message-ID: <20260413092130.GA18233@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
References: <20260409074905.3126023-1-ynachum@amazon.com>
 <20260413083515.GF21470@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413083515.GF21470@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-19277-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[amazon.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F5C93E9D4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:35:15AM +0300, Leon Romanovsky wrote:
> On Thu, Apr 09, 2026 at 07:49:05AM +0000, Yonatan Nachum wrote:
> > EFA devices added support for CRC16 checksum on admin responses and to
> > expose it to the driver the API version increased to 0.2. Add a check
> > for support on device init and if supported validate the checksum on
> > each admin response the driver receives. If the checksum validation
> > failed, drop the CQE.
> > 
> > Add the CRC16 module to Kconfig to have the in-tree dependency.
> > 
> > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/Kconfig             |  3 +-
> >  .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  3 --
> >  drivers/infiniband/hw/efa/efa_admin_defs.h    | 15 +++---
> >  drivers/infiniband/hw/efa/efa_com.c           | 50 ++++++++++++++++---
> >  drivers/infiniband/hw/efa/efa_com.h           |  4 +-
> >  5 files changed, 55 insertions(+), 20 deletions(-)
> 
> <...>
> 
> > -#define EFA_ADMIN_API_VERSION_MAJOR          0
> > -#define EFA_ADMIN_API_VERSION_MINOR          1
> 
> <...>
> 
> > +#define EFA_ADMIN_API_VERSION_MAJOR          0
> > +#define EFA_ADMIN_API_VERSION_MINOR          2
> 
> <...>
> 
> > @@ -954,16 +990,16 @@ int efa_com_validate_version(struct efa_com_dev *edev)
> >  		  EFA_GET(&ver, EFA_REGS_VERSION_MAJOR_VERSION),
> >  		  EFA_GET(&ver, EFA_REGS_VERSION_MINOR_VERSION));
> >  
> > -	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION,
> > -		EFA_ADMIN_API_VERSION_MAJOR);
> > -	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION,
> > -		EFA_ADMIN_API_VERSION_MINOR);
> > +	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MAJOR);
> > +	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION, EFA_MIN_ADMIN_API_VERSION_MINOR);
> >  	if (ver < min_ver) {
> >  		ibdev_err(edev->efa_dev,
> >  			  "EFA version is lower than the minimal version the driver supports\n");
> >  		return -EOPNOTSUPP;
> >  	}
> 
> This change breaks all backward compatibility. Are you certain that every EFA
> device is running the correct firmware, including those currently deployed and
> used by customers? If not, they will stop to work after random kernel update.
> 
> Thanks

The minimum required API version for the driver to load remains 0.1
(EFA_MIN_ADMIN_API_VERSION_MINOR). The CRC16 checksum validation is only
enabled when the device reports API version >= 0.2. Devices running
firmware 0.1 will continue to work — they just won't have checksum
validation on admin responses.


