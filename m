Return-Path: <linux-rdma+bounces-11846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E0AF60A8
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 20:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702E71C4551F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4C330E85B;
	Wed,  2 Jul 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEvIJcox"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5DC30E84F;
	Wed,  2 Jul 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479213; cv=none; b=VJb7T2di+g9ai/Q7FpK7sukVHs1hDTdusM9XlpVmIuNCFSsz+59CKIwc1QzmDc44/PTFgPrv5Vzk2zuEk2pQJkuHMYlNCa0juz5flLC4JfLv50TfJmL3Of6tLrYCsOoVofuaSIm4L2Lg6/TgNUcaerIqhuw/vPa4VRgfT61diNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479213; c=relaxed/simple;
	bh=6z0u7i8bRrCZDEQvcwpX8KlEXe44EN02rC/5MBOZao8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Y4/2mnwbzuM+VGz6DBA2xpOBwHb5+YAuYRw0O4g935OBrZOtk3JGNvOX180qJLG8PkSlrY24USYuWCejeOkxcHUtad9tIv2eRfC3Zvs3eeiO4z3dM9vaWa5bUKtiv+U4wyZJAXh4Ae//csdu9oFtnKfB5qU1J6Ap3kamYpUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEvIJcox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C091C4CEE7;
	Wed,  2 Jul 2025 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751479212;
	bh=6z0u7i8bRrCZDEQvcwpX8KlEXe44EN02rC/5MBOZao8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEvIJcoxqFK8gxdzAoJknzErXcYSp7FXzSZgeVoW4UH1vPNRtzWW5RwzWnd7/f5ye
	 Oa9Dg9xY4f1UnyATyPtxaD4RPrJZYIsOoSUh5bYHZUFdcECYfKm9PL53KwiD9f1eJv
	 Vw8ae5k5rVi6Tbfr9Ly9HqW6CByhM5bFkS/+X+KbAwZ/bXpYl0G3XT+Tnsy8WfDtd/
	 w6Ri2JzugMuE4JpmcE8dbAja2PPZDicoHp2pALgYDk74AdBAcFlvXkFftq66oOS86/
	 ivse1+7m5UeW4PoNr5ueMOmbQyw3Ca5X7I2gpbYijRJoZEC1EY9ji0C7iVqcaLIfhK
	 NydLqt7dDK9UA==
Date: Wed, 2 Jul 2025 21:00:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Message-ID: <20250702180007.GK6278@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal>
 <20250702131803.GB904431@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702131803.GB904431@ziepe.ca>

On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
> > > +static void ionic_flush_qs(struct ionic_ibdev *dev)
> > > +{
> > > +	struct ionic_qp *qp, *qp_tmp;
> > > +	struct ionic_cq *cq, *cq_tmp;
> > > +	LIST_HEAD(flush_list);
> > > +	unsigned long index;
> > > +
> > > +	/* Flush qp send and recv */
> > > +	rcu_read_lock();
> > > +	xa_for_each(&dev->qp_tbl, index, qp) {
> > > +		kref_get(&qp->qp_kref);
> > > +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
> > > +	}
> > > +	rcu_read_unlock();
> > 
> > Same question as for CQ. What does RCU lock protect here?
> 
> It should protect the kref_get against free of qp. The qp memory must
> be RCU freed.

I'm not sure that this was intension here. Let's wait for an answer from the author.

> 
> But this pattern requires kref_get_unless_zero()
> 
> Jason

