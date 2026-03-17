Return-Path: <linux-rdma+bounces-18240-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAMhAuMluWm1sQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18240-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:58:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D702A7637
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CAB730398A7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F72F375F82;
	Tue, 17 Mar 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTIqKWIF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789E3A0EA6
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741279; cv=none; b=o7zo2Ea0qFY8UHU16ZHEZQ12vyWTz0iRY0PtzJVqe97K/BZC1cMcI6YrbM16UiOwqNm0Je1sqfuurlTNuMSQ2iVwN9paI90D+J+HUNmpvKvrj4C2sRT8sT3fWlqxG/+YSWivF89oUxW/nPhsGBdFkNy/0aGYHO2ehyjxhFpF9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741279; c=relaxed/simple;
	bh=KRbAB3nbYcdKPkPB5NxncRii3QmVu13aOTRGjoEfyWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwMy7MTswzGR+0Zro2eqVe9AJSUunSyulU1oovVBul3X/eMv5jFHKkj6ZuOM2vqEkwv4lfdAWkkrcdDOlRue4LFEyGLq7wsmB8AV1Aq28M5jFyasHQr6+1nznS/LMxK/T5xmpsHkdByEMUIfa/zD8M0VN4Iy3+0pEDSseYE+7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTIqKWIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA363C4CEF7;
	Tue, 17 Mar 2026 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741278;
	bh=KRbAB3nbYcdKPkPB5NxncRii3QmVu13aOTRGjoEfyWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTIqKWIFiU7NvEvvD+LemVXcF1mrRLPcpOEc/f18wud+lUCArDwTmNoCC6wYt+/wc
	 KC0PF21jCBFvarvgfyl3vMEtcY7sggO3w9Xd/gHQCHb88YVKGkfz/gaYuL8eLNgZXl
	 EHuhGK4aECpxjNQbiEqdwHBODrGG1i+AWdSao/Ww27O+/rllv6oMKyRGCCPRKZtYGT
	 rMDKxogkmM96oIPXo/QKavxyskSYbSMtk7ymxQU/t0F3iEj9lR8gLK9c7YWCbOP1MB
	 cICPEXps4BHz7YKkaaF4FqYBqbnMHWfAWDCZGY+fzPnFZ+97zyxW2MPf8r73Vs1Nvc
	 Bv8gcUjF9JWHQ==
Date: Tue, 17 Mar 2026 11:54:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next resend 07/24] RDMA/hfi2: Add system core header
 files
Message-ID: <20260317095433.GT61385@unreal>
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <177325166078.57064.16035123727786325107.stgit@awdrv-04.cornelisnetworks.com>
 <20260316155826.GD61385@unreal>
 <9ce84cf2-e916-4cac-b9a2-65f059b6508d@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce84cf2-e916-4cac-b9a2-65f059b6508d@cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18240-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:email]
X-Rspamd-Queue-Id: 56D702A7637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 05:37:30PM -0400, Dennis Dalessandro wrote:
> On 3/16/26 11:58 AM, Leon Romanovsky wrote:
> > On Wed, Mar 11, 2026 at 01:54:20PM -0400, Dennis Dalessandro wrote:
> > > Add header files for hooking into the core system, things like IRQs and
> > > affinity.
> > > 
> > > Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> > > Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> > > Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
> > > Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
> > > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > > ---
> > >   drivers/infiniband/hw/hfi2/affinity.h |   86 +++++++++++++++++++++++++++++++++
> > >   drivers/infiniband/hw/hfi2/aspm.h     |   36 ++++++++++++++
> > >   drivers/infiniband/hw/hfi2/efivar.h   |   17 +++++++
> > >   drivers/infiniband/hw/hfi2/eprom.h    |   11 ++++
> > >   drivers/infiniband/hw/hfi2/mmu_rb.h   |   78 ++++++++++++++++++++++++++++++
> > >   drivers/infiniband/hw/hfi2/msix.h     |   31 ++++++++++++
> > >   6 files changed, 259 insertions(+)
> > >   create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
> > >   create mode 100644 drivers/infiniband/hw/hfi2/aspm.h
> > >   create mode 100644 drivers/infiniband/hw/hfi2/efivar.h
> > >   create mode 100644 drivers/infiniband/hw/hfi2/eprom.h
> > >   create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.h
> > >   create mode 100644 drivers/infiniband/hw/hfi2/msix.h
> > 
> > <...>
> > 
> > > +/* Can be used for both memory and cpu */
> > > +enum affinity_flags {
> > > +	AFF_AUTO,
> > > +	AFF_NUMA_LOCAL,
> > > +	AFF_DEV_LOCAL,
> > > +	AFF_IRQ_LOCAL
> > > +};
> > 
> > Maybe I'm misremembering, but I recall we already discussed affinity
> > management in the driver in the context of hfi1, and our position at the
> > time was that handling affinity belongs in user space.
> 
> I don't recall specifically, but I do agree it should be handled in user
> space as the ultimate decider. The driver just provides hints as to where
> best to run things for optimal performance. User space is free to manage if
> it chooses.

So there is no need in all this affinity code, which looks like policy,
just use right attributes from the beginning.

Thanks

> 
> -Denny
> 

