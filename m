Return-Path: <linux-rdma+bounces-22793-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E09RBP9uS2pgRQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22793-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 11:01:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37C70E65E
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 11:01:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kCHIlE31;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22793-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22793-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7EC43038118
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068333A718;
	Mon,  6 Jul 2026 08:50:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9653B5821;
	Mon,  6 Jul 2026 08:50:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327852; cv=none; b=Qkj0ix/uWBJgSRIB+8HShea1G6WKUYy9n2a5P5jbqmJTEEjVZ6HPvB2RFs9yxwGbWQqsfWTesZzAxRbE12G+Th61IAqOMM6by6Y6YmhZQZc13jZaPRE6i586vUbauERlzldJRoB1iWHeVdXlL+GxT0r91c9k56o+WiShToG5LOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327852; c=relaxed/simple;
	bh=hWup9gA8sPCnA13J+yJWxxyTMbU7sGR6m6gwxBveUGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XnHU3CCeH8av2bE6qWJvkl0g0oWV+y4QbNezPipKtYpH6OfSYNdeaH5TNWcSXmXsXDFVmGyE9UMGpPRBCIB3CNWUHQbcoqPLKK09ZVkLf01rM5+402lcsQxKUWahaIy9TKhIf+uRgx7bEGzUa3v0hY+neor1Q4peKIBU6PIBgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCHIlE31; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9631F00A3D;
	Mon,  6 Jul 2026 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783327844;
	bh=jTUIm1tORoIMmZWrTVmwM1YfxLd0AKVtQztkrJeClIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kCHIlE31rQ5XPVK1Vs45QGGqF29OASswjBCwppeKtAa3dvuRGJ1puilirl6htP9FU
	 T6U6XnAdYxfCNM6b3LFYVb9eLKvJeWeWHysHKwss31LdomfrI6uMA0h5swFy8i62g8
	 7boMf4SUwz/XDvX2H0wVDJgIRwbHs4SXkm16OhfYPEu8vq+mlTfg4jMNoaAMo9EQ1i
	 KjfiHKgMLi+lGZTTuLdFpCGSRv7Eug5g4+7uUTEjcwemktE9GDnVOvw39mDM3IpBIL
	 94Ba+wjnfwe5TVu4Y+0arwmL9/REdup0zD7SEwkdLoSJ6W59D3FCWAA6tSITh4ySPI
	 ZFFLPZLZbxkkg==
From: Leon Romanovsky <leon@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260625003614.27515-1-pengpeng@iscas.ac.cn>
References: <20260625003614.27515-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] RDMA/bng_re: return a timeout when firmware responses
 stall
Message-Id: <178332784169.1040247.15205002231588689405.b4-ty@kernel.org>
Date: Mon, 06 Jul 2026 04:50:41 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:siva.kallam@broadcom.com,m:pengpeng@iscas.ac.cn,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22793-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B37C70E65E


On Thu, 25 Jun 2026 08:36:14 +0800, Pengpeng Hou wrote:
> __wait_for_resp() documents that it returns a non-zero error when a
> firmware command does not complete, and bng_re_rcfw_send_message() already
> marks the firmware as stalled when the helper returns -ENODEV.
> 
> However, the helper ignores wait_event_timeout() expiry.  If the response
> slot remains in use after the timeout and after the polled CREQ service
> attempt, the loop starts another full timeout period and can repeat
> forever.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bng_re: return a timeout when firmware responses stall
      https://git.kernel.org/rdma/rdma/c/5f9576c6734abc

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


