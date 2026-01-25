Return-Path: <linux-rdma+bounces-15987-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIRvB9cidmlFMQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15987-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 15:04:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6967C80EBF
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 15:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63A9D30013BE
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D31BBBE5;
	Sun, 25 Jan 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPa0Dzcj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682A158535
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769349840; cv=none; b=XXrILOt/yRM5zmuHjQa/U48eOFNXGhdInNh2kdv1WfzinB0Hydck7KE3GZ5vk1raejQY1vdJ1yW9KL8xhNpa7ny5da/YURJYklUUvixsVxhOC+K/YePFe0F5VHr0epK79bHSqVPMXHa6QF29LyKkr/ewmHfAngT5bhwdfqF4tS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769349840; c=relaxed/simple;
	bh=HhhvwjRWNpijfI86OpwrQxhPTjvkxGEnenHIQTlRyec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AWvqBWh124qlxbrnD0n34lnREDD8TbLL7nhAr17iYSM/gT1reih1xOZySKjauZrC0L+YJ3pxSMDQB63ZNMBDCTdr2TtGrPJmythHu97D4Kh+McabSWNKBIg0DQOtq72mqti9Vj1yll0b0DPjRlQoPh6wbCZ/mwnsFeARfVHwHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPa0Dzcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032D0C4CEF1;
	Sun, 25 Jan 2026 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769349839;
	bh=HhhvwjRWNpijfI86OpwrQxhPTjvkxGEnenHIQTlRyec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nPa0Dzcj/YB7gNjlQmIS4tuYCBA+Qwy0+ssr45QMUdcZs5NoTkmB9De1h4DOKSFJh
	 r82ikt7y6QGRH8G0UTe/J1Bjlqv/V5LEgojwe9TRLzx/Wv9WIkeYqiN/rrXllYQeOV
	 wU3rbyMQs9JvBuuH/VbbpZbsFUB7JYKAyXE/IHh6QLZvxfXb6LXIpvUdFXSStXcwHg
	 cik8o1azkbYp4Uuut8MC22R6YeyhlcguivYsfHf5MaS5ZB3vIk3AB3PfLnn1NoLRlA
	 cgkyoVqkho5MJpbUgrLa+U64/7+V/XhZqWZgcmfayp/HBGqUqfyNKFJzd0KF9yyNAB
	 pdxrOM4KIRcug==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, 
 Jacob Moroni <jmoroni@google.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
In-Reply-To: <20260120212546.1893076-1-jmoroni@google.com>
References: <20260120212546.1893076-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/irdma: Add enum defs for reserved
 CQs/QPs
Message-Id: <176934983614.889283.7386900738569848717.b4-ty@kernel.org>
Date: Sun, 25 Jan 2026 09:03:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15987-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6967C80EBF
X-Rspamd-Action: no action


On Tue, 20 Jan 2026 21:25:45 +0000, Jacob Moroni wrote:
> Added definitions for the special reserved CQs and QPs.
> 
> 

Applied, thanks!

[1/2] RDMA/irdma: Add enum defs for reserved CQs/QPs
      https://git.kernel.org/rdma/rdma/c/2b7c2ba1308a54
[2/2] RDMA/irdma: Use CQ ID for CEQE context
      https://git.kernel.org/rdma/rdma/c/2529aead516738

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


