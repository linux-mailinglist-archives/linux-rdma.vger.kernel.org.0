Return-Path: <linux-rdma+bounces-19217-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFdPFCVh2WlqpAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19217-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 22:44:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67883DC872
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 22:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4CD4300B9E8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E639B95A;
	Fri, 10 Apr 2026 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsYuxqkm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C337F8CB;
	Fri, 10 Apr 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775853796; cv=none; b=g/zlwIDdgH1wsJDTuOx4mI7ZNIZJx2NIIXHPdK4kqAJ+6UKTihFIf33xSjF/fv8VcaZaszgZ/flB/LUgbccvY7PbKCy8wyQuqpSjYn0Bw1rwMB44wloN80wpTk9+9Y91DTA2+jeSORCW/s4OFu55b4QUVGxL4qY2mFOH1YKeRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775853796; c=relaxed/simple;
	bh=3u/q+4/gzfVwsZCIVnO01jUEdwr3mA7qoaqujKjOIDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjiMA/IJ0l2jZnChwg1gtk6xxDe8m7ZNCEH0RDEbH/2PsHISaE6vU8w5Eegmf3nZrr+dP3ZNFRjhhrC4B08eIfO2D/epme2GVQOj8QpWumrgvK6LDcDGc5lY/i99sOPVsQ7YNfc0DA+viigvLqwy+D0aUM8smmP3TbaWmEt/gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsYuxqkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17EEC19421;
	Fri, 10 Apr 2026 20:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775853795;
	bh=3u/q+4/gzfVwsZCIVnO01jUEdwr3mA7qoaqujKjOIDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AsYuxqkm/clnazhEZ730vfJqLlxMXAK8qQVcNzL4BxRBvTe+84SqBFAZZ9/5tJTHe
	 NVoiRLBEcbU6yxGLbyk3Ep773B77hzJokNShNPZMyLpMg+ZHbzlZxGgquYQE8/EC54
	 f7HlVQezua3v58p3IZLodlx7wkhFR7c7NNqCFr5L00ETB/RmHwc0PfEz762SWnjXpO
	 2UMLshqvhWQLXiXZOpVEYT+q4N+jAavlCLBnsgrqv1e0HaLaL8sW+sbNVj5d1eDcir
	 infZzgQ430uVCLTZJxkHFLnUUMwhHFKeNuxvubueq/OArJZL5Jerz+M8WFvw/DjwB1
	 tvkwRHAsDWpcA==
Date: Fri, 10 Apr 2026 13:43:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allen Hubbe <allen.hubbe@amd.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, jgg@ziepe.ca,
 leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] net: ionic: Add PHC state page for user space
 access
Message-ID: <20260410134311.785683cd@kernel.org>
In-Reply-To: <52cee89f-50e2-4569-a622-b03e711ab26b@amd.com>
References: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
	<20260401102501.3395305-3-abhijit.gangurde@amd.com>
	<20260401170600.312a23d1@kernel.org>
	<52cee89f-50e2-4569-a622-b03e711ab26b@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19217-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A67883DC872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 09:10:09 -0400 Allen Hubbe wrote:
> >> +struct ionic_phc_state {
> >> +     __u32 seq;
> >> +     __u32 rsvd;
> >> +     __aligned_u64 mask;
> >> +     __aligned_u64 tick;
> >> +     __aligned_u64 nsec;
> >> +     __aligned_u64 frac;
> >> +     __u32 mult;
> >> +     __u32 shift;
> >> +};  
> > 
> > You're just exposing kernel timecounter internals.
> > Why is this ionic uAPI and not something reusable by other drivers?  
> 
> The simple answer is just following the same approach as an existing 
> implementation.  See struct mlx5_ib_clock_info and 
> mlx5_update_clock_info_page().
> 
> Making this common might risk presuming that other implementations will 
> be a similar design.  Compare these to the sfc driver.  The clock is 
> quite different from ionic and mlx5, not using timecounter, because 
> instead of a free-running cycle counter the hardware itself provides an 
> adjustable clock for timestamping.

So your augment is basically that drivers which don't use sw timecounter
exist so we shouldn't bother creating common definitions for drivers
that do? Why do we have common implementation of timecounter in the
kernel at all then?

These are rhetorical questions.

