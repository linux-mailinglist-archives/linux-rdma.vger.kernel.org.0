Return-Path: <linux-rdma+bounces-17344-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADY3H990o2mwDgUAu9opvQ
	(envelope-from <linux-rdma+bounces-17344-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 00:06:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D40831C99D6
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 00:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33910301DBB9
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9F3B5316;
	Sat, 28 Feb 2026 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drBFJaXi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA186274650;
	Sat, 28 Feb 2026 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772319960; cv=none; b=HYO59SCY1adG7o/gPihJPYdyD/mQo4F/WNucxh8p3C//LK6GRzXYLhwKYMqTUtG1AEhYu/US74UZqDsgA1lBZA0lLdlQBkD+FuzGjPg2knvdbhvsmnDdTDQD5ZApUDRzpYkjwklcVTCyQmxYAnoh3OLbM3/JqpOgcYTIOXSWIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772319960; c=relaxed/simple;
	bh=A6M2iDOhmSVC++8GhnKmIQhmOUtWCEws46FWPCDoinE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcSzwWcyDC5F396YCGnn3/7JM2kHGXQZ5HJYb577lPVcDBN9IMemRGQhdiZg7S8xG31gwd4w+ioJowP0c6ZSzrR+EUogWcW4JZhWI4MHgKkS4FdPyDEQGCi4TLcJDItC+44CtbJbCQa01dAXnY714buphRc79jGGLmXbpdOD3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drBFJaXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F03C116D0;
	Sat, 28 Feb 2026 23:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772319960;
	bh=A6M2iDOhmSVC++8GhnKmIQhmOUtWCEws46FWPCDoinE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drBFJaXi3mSj4lyumQKUzSyEEhaUVEhD9gLWoHad2nQa2zc7yIdx0QHigj8silyMu
	 rjUja3m7KmTeS6mko2Qufh4SaNwt1eDBNGp9nf5fONPQOTJSTpD1U5ybU/OCeLfrC4
	 jyIwYvccHd8Iv4YoXwfqfX1zi2ETjfr2OmP/axwZFiyRX1dhx4L3zTHtvEU0Yd5PGW
	 eYf3jtfx2Asurza/kWLkfRmhgEBERaccb13rxEYrCxNCvqA0+K9IL2XjnsvjEOttwF
	 1HyjdhOG5R+5fiAkFw5wLDUP/XdrBDpN7aTXzY9YjcrdKpU27j3DhEdTvRLmpgJdPW
	 St6N2A21tLpLA==
Date: Sat, 28 Feb 2026 15:05:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, skhan@linuxfoundation.org, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 przemyslaw.kitszel@intel.com, mschmidt@redhat.com, andrew+netdev@lunn.ch,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com,
 daniel.zahka@gmail.com, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/10] documentation: networking: add shared
 devlink documentation
Message-ID: <20260228150558.46f3be36@kernel.org>
In-Reply-To: <20260225133422.290965-10-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
	<20260225133422.290965-10-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17344-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D40831C99D6
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 14:34:21 +0100 Jiri Pirko wrote:
> +Shared devlink instances allow multiple physical functions (PFs) on the same
> +chip to share an additional devlink instance for chip-wide operations. This
> +is implemented within individual drivers alongside the individual PF devlink
> +instances, not replacing them.

Sounds like you want to preclude what was the goal in the discussion
with Przemek you quoted - a shared instance _only_ case. We don't have
to implement it today, but I think it's an entirely sane direction.
So the docs should not state otherwise.

