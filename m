Return-Path: <linux-rdma+bounces-23123-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IwusFsnXVGrZfgAAu9opvQ
	(envelope-from <linux-rdma+bounces-23123-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:19:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3E74ADBF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=dzL+F479;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23123-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23123-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 123163019FF3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38E3FD970;
	Mon, 13 Jul 2026 12:18:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB093F4DEA
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 12:18:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945134; cv=none; b=Ex7jg094SpTRkwwyCDSRuDciirnDiQItA4hjpVSfpudCPRpSum8DY8dnXBW75NRao/W32ZkUFHxge7AuG6V9ZnX6XCQRAocop+E2Pw2WM3u/S3KGh+iL6KY8n0mE2ANwtjFQhV/4vkVa4MuMdK2Zy5E+C296dOUyYA1eAF6UCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945134; c=relaxed/simple;
	bh=v8K1RZjqsuuTkvZLOcZtaxbyBp3qpIOADeJsSZnjUXg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm7YAYSqmBdlUg1vfpCDHQfZaSU7zN+f06giCQe9IcxMhoQgkfhewfr5mtjFZgUJvYP5g75/URzFF005eW2QGgBoB4iHUYS+jFl7sIPQ15Aj5Twv2qX9azFV+ejv8r60BA31XdIiyzutqRlDNh64Cpk1mBFERrm15EHt8k8lfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dzL+F479; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783945133; x=1815481133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oPNMzxcMnpmXVvQYtZ2ugB80SgODB2VhYp3YVBMA2CQ=;
  b=dzL+F479W6SwtNa5HuCihVmJOkmy2rpgC5ANpf0tMiKQQbHa120yKhdY
   5A+7bI41ikM1N4q66spyOV9a3MYGR8ctGoImrRmiD0ItRY5sKHERZ3U1v
   7CxQrWINzqGajnam3KVwVOa33u1DDIE+c1GF1UgeCDO1Aelsmh3PnxoIY
   Q/VeZ1Jyjs6FPeiQB82e3mjAqZhIJFEfHS8IngHwTPWvX8qTkhDq7fMga
   Q25O9YpVG8qqjTAeWXhbkjw9lH8Q2fZKxk2LZZKNzqGXZoirWrIRtwtVZ
   ISY2v7wHSzCi+vwoNvwRM2EDOr1SAjKhpQQCIN+hgDvz2YmRCsxOo3wpx
   A==;
X-CSE-ConnectionGUID: bVfN1HF9S4C/f8iTs+iuuQ==
X-CSE-MsgGUID: hvnp83dqSKCTBNbkHleTYQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23455761"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 12:18:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:6745]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525] with esmtp (Farcaster)
 id 74b2adc8-f70c-4fc6-aa8b-ad9aef56b710; Mon, 13 Jul 2026 12:18:50 +0000 (UTC)
X-Farcaster-Flow-ID: 74b2adc8-f70c-4fc6-aa8b-ad9aef56b710
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 13 Jul 2026 12:18:49 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Mon, 13 Jul 2026
 12:18:48 +0000
Date: Mon, 13 Jul 2026 12:18:40 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Yonatan Nachum
	<ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/2] RDMA/efa: Extend page-shift field in MR
 registration
Message-ID: <20260713121840.GA2442@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260712134413.19226-1-mrgolin@amazon.com>
 <20260712134413.19226-2-mrgolin@amazon.com>
 <20260713093118.GK33197@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260713093118.GK33197@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23123-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4B3E74ADBF

On Mon, Jul 13, 2026 at 12:31:18PM +0300, Leon Romanovsky wrote:
> On Sun, Jul 12, 2026 at 01:44:12PM +0000, Michael Margolin wrote:
> > Update device interface adding one more bit from reserved to enable
> > >4GB page sizes that can be supported on 0xefa4 devices.
> > 
> > Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> > Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> > index 826790ca9d83..3eb3a4de8912 100644
> > --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> > +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> > @@ -367,10 +367,10 @@ struct efa_admin_reg_mr_cmd {
> >  
> >  	/*
> >  	 * flags and page size
> > -	 * 4:0 : phys_page_size_shift - page size is (1 <<
> > +	 * 5:0 : phys_page_size_shift - page size is (1 <<
> >  	 *    phys_page_size_shift). Page size is used for
> >  	 *    building the Virtual to Physical address mapping
> > -	 * 6:5 : reserved - MBZ
> > +	 * 6 : reserved - MBZ
> >  	 * 7 : mem_addr_phy_mode_en - Enable bit for physical
> >  	 *    memory registration (no translation), can be used
> >  	 *    only by privileged clients. If set, PBL must
> > @@ -1103,7 +1103,7 @@ struct efa_admin_host_info {
> >  #define EFA_ADMIN_MODIFY_QP_CMD_RNR_RETRY_MASK              BIT(5)
> >  
> >  /* reg_mr_cmd */
> > -#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
> > +#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(5, 0)
> 
> How will the new kernel behave on non-0xefa4 devices? The new
> kernel sets one additional bit that these devices do not expect.

In the kernel, it is handled by using the supported page sizes mask
returned by the device (page_size_cap) when calling
ib_umem_find_best_pgsz(), so the kernel should never set this bit on
non supporting devices. In parallel, the device validates inputs on its
end.

Michael

> 
> Thanks

