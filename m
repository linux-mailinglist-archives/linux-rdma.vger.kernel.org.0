Return-Path: <linux-rdma+bounces-16959-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMDmI06BlGniFAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16959-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 15:55:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E489E14D545
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 15:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 138933020000
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2936C0CE;
	Tue, 17 Feb 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PHgo4Gzu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210636B068
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340080; cv=none; b=M95UpZuQee+hw/odlO+8D9aslDpTNWOx707kckZtKZVb7Fzj4b2HMOIrfWElqpn371iw8iJ6J4xB+zfvIMJW7fVrM1s+fOYTSO46PP3vZJeju953dYnekoelrppnhIbp/caSc9iwKhzsr1gRrBCPMGxpZz2FzJl3qY2BwJJzxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340080; c=relaxed/simple;
	bh=K0EN+3InKduU+8vqGdTB0dXiruZSQMh9ntbLb6+9sVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO5EotN2zzCjiwKtp+Bkh2slc1WFOyEpeQWtX+54J2e9J+JN3h/uzegiSU4u2JsaXlnhl98KwsLHDDtwBFTTshhMoDKQWFnuL3PUN+8pluBLrW/QdVdG7orJ8DMfBctdKFQN21e1pc1KN+IJHSHm1hiNdLkQfPSX0E5HnCliK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PHgo4Gzu; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771340079; x=1802876079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JPbmA2IgBCgByPukA9kPYIgOfLGOvuZqXTRD6FYdKBs=;
  b=PHgo4GzuoFeK12vAexP+27ScHhDukkVCa5GUFVxoCB/+3tmm006EUZHE
   gN1UnjgG68s01akphc9dEXYY/M6kcWuor3ZHXRWmQl2cN4MhB5Xa5aArj
   lw6X5EkTHoEGpgUdnGsdP0Jag/r+0hKwHoEexesSL/eh+A99PC2/o1S+7
   l6urTIucJurmhYlas7JyaTAXBQeOoq268VSXq0b/TKgSDrLQUHLsw7QNK
   To8pzJw1sMner19UIIPQaOF3kOLc/uR4K4Xev62zFSyV75WSECApKmwII
   c0gFCc0KreT6Tsw6EZ8wBCHuiqlICDt7JvMKzVlio6n9pzHjR+4HxuGka
   g==;
X-CSE-ConnectionGUID: csFZAlGqSA6xWQ2H08edqg==
X-CSE-MsgGUID: vl0ZwS80TVW1BLvi3/ckSg==
X-IronPort-AV: E=Sophos;i="6.21,296,1763424000"; 
   d="scan'208";a="13023249"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 14:54:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:4787]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.107:2525] with esmtp (Farcaster)
 id 6204461c-7ec7-4a3a-b161-fd64b0685ec3; Tue, 17 Feb 2026 14:54:36 +0000 (UTC)
X-Farcaster-Flow-ID: 6204461c-7ec7-4a3a-b161-fd64b0685ec3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 17 Feb 2026 14:54:35 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Tue, 17 Feb 2026
 14:54:34 +0000
Date: Tue, 17 Feb 2026 14:54:26 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Gal Pressman <gal.pressman@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
	Tom Sela <tomsela@amazon.com>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260217145426.GA9217@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
 <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
 <20260212163628.GG12887@unreal>
 <20260215134122.GA18825@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260215171543.GB12989@unreal>
 <42c8552c-eb41-43f5-bea5-fdd46edba65a@linux.dev>
 <20260215175707.GC12989@unreal>
 <20260216110853.GA6455@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260216112207.GF12989@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260216112207.GF12989@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16959-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E489E14D545
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 01:22:07PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 16, 2026 at 11:08:53AM +0000, Michael Margolin wrote:
> > On Sun, Feb 15, 2026 at 07:57:07PM +0200, Leon Romanovsky wrote:
> > > On Sun, Feb 15, 2026 at 07:23:41PM +0200, Gal Pressman wrote:
> > > > On 15/02/2026 19:15, Leon Romanovsky wrote:
> > > > >> Stats also doesn't seem as the right place
> > > > >> for this.
> > > > 
> > > > Because?
> > > > 
> > > > > 
> > > > > How can the kernel and this new counter report a different number of AH
> > > > > objects?
> > > > > 
> > > > >>
> > > > >> In a followup series we will suggest netlink counters extension to
> > > > >> support driver specific resources.
> > > > > 
> > > > > bpftrace is generally the right tool, unless you can detail why it does not  
> > > > > fit your specific debugging scenario.
> > > > 
> > > > I don't understand, how do you use bpftrace for this use case?
> > > > 
> > > > Once you get to debug a system in a certain state, bpftrace won't help
> > > > you see events that happened in the past. You won't be able to know how
> > > > many AH were created.
> > > 
> > > Their proposed counter can be implemented by counting calls to
> > > efa_com_create_ah minus calls to efa_com_destroy_ah.
> > > 
> > > You have two ways to get it:
> > > 1. run bfptrace with your reproducer
> > > 2. check FW to get their internal counter
> > > 
> > 
> > Calls to efa_com_create_ah minus calls to efa_com_destroy_ah will not
> > always result in correct number of consumed device resources as multiple
> > calls to efa_com_create_ah can return the same AH number.
> 
> bpftrace supports map and can count unique ids.
> 
> > 
> > Additionally we are looking to expose this info to customers without
> > requiring a kernel rebuild or the use of debug tools, similar to how
> > device and port statistics can be read in sysfs or through the rdma
> > tool.
> 
> BPF doesn't require any kernel rebuild. It works out-of-the-box on even
> old kernels.

I'll try to give a higher-level overview of the need.

I don't argue that bpftrace is a powerful debug tool that can be used to
collect various info from the kernel, including this one and other data
that we expose through sysfs, netlink, and rdma-core. This being said, I
don't think it should be considered as a replacement for an explicit and
stable kernel ABI.

What the proposed change is trying to do is give end users the ability
to monitor AH usage in production. Resource usage and traffic counters
are usually collected periodically (every 1-5 seconds) by dedicated
collectors (e.g., Prometheus node exporter). Such user processes can't
depend on in-kernel function names or any internal logic that might
change from time to time, and expect well-defined and solid interfaces.
I don't see how bpftrace can serve this need.

Michael


