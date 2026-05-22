Return-Path: <linux-rdma+bounces-21146-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OsnLWDfD2rQQwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21146-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 06:45:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BFC5AEC0D
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 06:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 843363020EB4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 04:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8E347515;
	Fri, 22 May 2026 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Z/7pYuXj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSFeIUJj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC822E3E9;
	Fri, 22 May 2026 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425087; cv=none; b=Xz1NWy1lJBzFSxh6fCmCltV57tNGwEtymF2aMW29T/irh3tD2h0V0+LmAEt0qHM4ADjHGwi65hBqKNzCWuclzWwC+SOTR/4jjX/Lh5xGmuDVAu0kh/zKkjcDbin/0HNuAzorJ7hXfcs56RR+AGNfIWUO4ttxpD8UGraeuIgqctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425087; c=relaxed/simple;
	bh=A2iwVa+JfXcMyDSVVnLV/EE4aDQxemLxskO2NRdDyIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRtmiJNtZiqPPS3F3qv+OGK+VEhQvymFQcBbM9nEfdNXCjgyZ0Q8qenWBxuYK9XnAL9zXkR/LIQNDdMlokWiaw/mcYYTaIsvfXTgBbAMSC0f6BK7NMuhbrY4e55R1Fr6r73VLazdSGSE6Wr29vis13PTpNeZNzZCbWF0ZRdp46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Z/7pYuXj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSFeIUJj; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 721E27A00A4;
	Fri, 22 May 2026 00:44:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 00:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779425084; x=1779511484; bh=9BRLcK4fb6
	9mi1+15hYmmA6GtamMCSVNkvbyUWdeZRQ=; b=Z/7pYuXjmP9AqfBkbE2Gzoz4Bv
	BxNjHhbpLf0e3We/omeDLfGyI/Ga6vVx6diWQuVS91Whathb2R0SpDtmg2LtOJin
	O5QuxMd8BBJ111OIWn7zO9qYV4vbrp5Uc83MgZaClfYBpaJopQm5h0+z4PhbTfRX
	n2tuzvYl7+cUeRl/uoPtM8U1FwxWblmD8zC3gwuBYXY7rwOnHS3aLVp3zYEqPusE
	85v5pGB/QMjv0RLhVGg0c9RBu0vM/Hiq1XXjTtElpPiMbDbgest1v1GjfRZQomBv
	C7pCCmlz+tD1DK8W1dnV2fPJN8wGPgYkZ3/M0WF53pchgMPJ+4mmQvwqD5ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779425084; x=1779511484; bh=9BRLcK4fb69mi1+15hYmmA6GtamMCSVNkvb
	yUWdeZRQ=; b=dSFeIUJjEObVpZBY5MGP+KximEdJpHhZEP5FM3C5CHdi6i+pH3a
	oNE6/6cx9reJ2d0aBUwfdU8T7LaTSCrxRboYRB2rsEHqyJhuhbXbtt04J1D2l4EA
	Fh/F7MMtCt09o2a2QuO8c5rJnGWaEN2evCoirZljFLP5bJ0uWUsfsyMPmrmwUARB
	S0ZHLj1j2tCBfCxzflt5KZb3yG8M9Nf4xSmyAWRf+UVBz1Bxi007q2uALjR+acaH
	vIsJcefCqRygw/yhLfnAWthKncd/JuwS4QkCXlaAWFB/h4krUbwluRn9UWq+9xq0
	HWbAY16EGarhjdst6IufgUq6JTVDMHSiJBw==
X-ME-Sender: <xms:PN8Pap_gvizK4yX6_O2uvaPp_bXmvaukBH6IWVY9fW3jdBp7uKn5qw>
    <xme:PN8PakH8EtI2O1OxM4YaE9JgASnxL7wQ_IeL_5uAN1RqyW9vfpdZ9NLb6yIch16-5
    l27hbGwa9UElIIzId-iIw1R8qTMTWgP91e3eI9iAL1n2l4P>
X-ME-Received: <xmr:PN8PajTvk-eowh4k22Ct_EH9MYRKlfyE-XPuJ_ndE1uJoKA65dfhYq_CdMXIiHHXHEkkSJJRyLu3_9BxNflclbST-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
    dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehthihmsggrrhhkjeefjedvsehprhhothho
    nhdrmhgvpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepiiihjhiihihjvddttddtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnrhhosehnvh
    hiughirgdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:PN8ParQwQ4RtKHeBiY6RLFcPxvIQX4F1cAj0ysPYTVTQ-LWT2t_c2A>
    <xmx:PN8Pam1_N0U3Ch4mguBeekCSng_VwCPflS0JhuuFLpPG_CnEXuehww>
    <xmx:PN8Palx7Q2EInUnFEpC7BNu8q9XWcizlHkf9pnKXiLEInzyE4EUdGQ>
    <xmx:PN8PaiwRTgUoUGcyBfrC7akxhRCRumeJVKdnK4-35te_CwmksJi4TA>
    <xmx:PN8Paq3z6RJSMqkHk1Ql50CPP3Ok562BaejV8wFcP8kIiIuEo2yz_vTv>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 00:44:43 -0400 (EDT)
Date: Fri, 22 May 2026 06:44:47 +0200
From: Greg KH <greg@kroah.com>
To: Tymbark7372 <tymbark7372@proton.me>
Cc: linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@nvidia.com,
	leonro@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] RDMA/rxe: Fix u64 iova+length overflow in
 mr_check_range
Message-ID: <2026052221-deceiver-grafting-58e9@gregkh>
References: <20260521194402.811-1-tymbark7372@proton.me>
 <20260521194402.811-2-tymbark7372@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521194402.811-2-tymbark7372@proton.me>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21146-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim,proton.me:email,kroah.com:dkim]
X-Rspamd-Queue-Id: 24BFC5AEC0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 07:44:08PM +0000, Tymbark7372 wrote:
> In mr_check_range(), the IB_MR_TYPE_USER and IB_MR_TYPE_MEM_REG case
> computes both iova + length and mr->ibmr.iova + mr->ibmr.length without
> overflow check.  Both iova (u64) and length (size_t) are 64-bit on
> 64-bit platforms.  An attacker setting iova = 0xFFFFFFFFFFFFFC00 and
> length = 0x400 wraps the sum to 0, so the bound check
> "iova + length > mr->ibmr.iova + mr->ibmr.length" passes.
> 
> After the bypass, rxe_mr_iova_to_index() computes a huge index value;
> WARN_ON(idx >= mr->nbuf) fires but does not abort, and
> rxe_mr_copy_xarray() then dereferences page_info[huge_idx], an
> attacker-controlled out-of-bounds slot.  In the RXE_TO_MR_OBJ
> direction this becomes an OOB write of attacker payload bytes through
> info->page + info->offset.
> 
> Use check_add_overflow() on both ends to reject any iova/length pair
> that wraps.  Also explicitly scope the local declarations introduced
> by the helper variables.
> 
> Reachable from any unprivileged local process with
> /dev/infiniband/uverbs0 open (world-rw on distros that ship the
> rdma-core udev rules) and from an unauthenticated remote peer over
> UDP/4791 (RoCEv2) when the target rkey/QPN are known.  Reproduced on
> v7.1.0-rc3 + KASAN with a single ibv_post_send(IBV_WR_RDMA_WRITE) and
> the wrap iova above; the kernel oopses in rxe_mr_copy+0x20d after
> WARN at rxe_mr_iova_to_index+0x135.
> 
> Site A in rxe_resp.c (check_rkey()) reaches mr_check_range() with
> attacker iova as well, so this patch also closes that path; Site B
> (duplicate_request, also in rxe_resp.c) has an independent inline
> check that wraps and is fixed in patch 3 of this series.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org # v4.8+
> Reported-by: Tymbark7372 <tymbark7372@proton.me>
> Signed-off-by: Tymbark7372 <tymbark7372@proton.me>

We need a real name for the From: and signed-off-by line, and no need
for the duplicate reported-by line.

thanks,

greg k-h

