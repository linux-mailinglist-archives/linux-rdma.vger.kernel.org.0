Return-Path: <linux-rdma+bounces-18239-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CkwI6EkuWm1sQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18239-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:53:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3FF2A74DB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBB613033D6D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D53A3E61;
	Tue, 17 Mar 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq3/RJbI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2623A0E80
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741113; cv=none; b=Irte3msGZbBFALfyzcbgJHLQkp2nNjItnrjcxzQpZVS6Vy4+xMAjrJJgC1nqM+cJhdUEtPwuklLuJnyvYV7U0BCuf3Nr3BQKQXpbRjZmZBEUl1tAHSmkkt6QYlh237MbQ4tSMjnU8GH0vATW8+GwO1pquBr1dxt2o5FHjYkngXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741113; c=relaxed/simple;
	bh=SQXIt/V2e26eMQkkZFpPXIoMcgR/F/5j8h+G9wgIKPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY0M9lkKYG5ZV4THIkzbXY+26bzt+CvtRuOBVrOp3wK3KIi0QwnNdTm/GH/xDqUXYsd87OSIyJaUcoGUj6aD56oKnQ173k2/QkNqUtHy/pzC8WfBEH5zDuuxbPusRQsXcBnrg6qqynZzO05JtLpcoilXaze8aTNDQLyTuhB9VCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq3/RJbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FD8C2BC9E;
	Tue, 17 Mar 2026 09:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741113;
	bh=SQXIt/V2e26eMQkkZFpPXIoMcgR/F/5j8h+G9wgIKPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zq3/RJbITj1K3mDJGTYnSsqDcl/O+orawcclDoxEXGEUYxvPclXKVeKgboA6GYT5n
	 ZAHvfrI3se9i4ot6eIRM2unSYHSYJi0VbqWw2hI+5bRYgqUhCMDbBhO7by6rV+vUKe
	 Y1wFrTDHkb1QFeJ9K6L+UwsYcorciKkQ/RmAKWIVib5Q81/u/ggG+0JCf/z3ckFty6
	 nqOse505uqSaZq9wGS5waDGJiBM4/gLOM/rMWb3xs2I7KVM+PQ+I6g8VWQYY/zFkmU
	 87EerX+XKsaikHc8gFSAOwQ8DhQ07qgpeLA+KuKutU0Zc/U5Bxvi3SiiINssBK0jun
	 gXwFIJv0SjTCA==
Date: Tue, 17 Mar 2026 11:51:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hfi2: Consolidate ABI files and setup
 uverbs access
Message-ID: <20260317095148.GS61385@unreal>
References: <177325043749.53056.7110333022279342594.stgit@awdrv-04.cornelisnetworks.com>
 <20260316142738.GB61385@unreal>
 <2ce72f8e-3a7d-46c6-9b1e-68f99c91a6d2@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce72f8e-3a7d-46c6-9b1e-68f99c91a6d2@cornelisnetworks.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18239-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 4D3FF2A74DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 05:31:40PM -0400, Dennis Dalessandro wrote:
> On 3/16/26 10:27 AM, Leon Romanovsky wrote:
> > On Wed, Mar 11, 2026 at 01:33:57PM -0400, Dennis Dalessandro wrote:
> > > hfi1 driver is being replaced eventually with an hfi2 driver. Until that
> > > happens rather than have all the duplicated code in header files, make hfi1
> > > use hfi2 variants where it can. When compatibility breaks we'll keep a
> > > separate hfi1 version.
> > > 
> > > This is the case for the <dev>_status struture. The hfi1 varaint is single
> > > port and uses a freezemsg char array while the new hfi2 chip provides
> > > multiple ports and thus needs and array of ports.
> > > 
> > > Likewise the tid info struct is expanded for hfi2 so we include both an
> > > hfi1 and hfi2 vaiant.
> > > 
> > > There is a naming conflict with the trace_hfi1_ctxt_info() call. It has been
> > > renamed to remove the 1 from the function name to keep the code readable
> > > but allow it to compile due to the #define in hfi1_ioctl.h.
> > > 
> > > The big departure from hfi1 is that we are no longer supporting access from
> > > users through a private character device. Instead we define two custom
> > > verbs ojects. dv0/1, which proivdes methods for what in hfi1 are individual
> > > IOCTLs. We have added an additional method to get stats related to page
> > > pinning done by the driver.
> > > 
> > > The reason we are not removing the hfi1_ioctl.h and hfi1_user.h header
> > > files is user application compatibility. User apps depend on having these
> > > files available. Once user apps have converted and hfi1 is removed these
> > > files will be deleted as well.
> > 
> > What are the applications that use include/uapi/rdma/hfi/hfi1_* directly?
> > I have hard time to find any application on github which includes them.
> > 
> 
> rdma-core (submitted PR but have some checkpatch type stuff to fix that was
> missed), psm2, and libfabric (opx) all use these.

At least in rdma-core, the include/uapi/rdma files are copied rather than
used directly. You will probably need to apply the same approach in the
other libraries.

My point is that you most likely do not need to keep the old
include/uapi/rdma/hfi/hfi1_* files.

Thanks

> 
> -Denny
> 

