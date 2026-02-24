Return-Path: <linux-rdma+bounces-17102-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDHCOSdpnWnBPwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17102-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:02:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5D1842E9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3060830A7F1E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 08:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF336998A;
	Tue, 24 Feb 2026 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogbfRVaV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6B369974
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923591; cv=none; b=kBw40V2ZOV0mdGK0e6gebWQDBn1NVZm2WxhP07T6TNqnrxcFOYuKdElinLnwvPlolxJgngNeEx7xlsoz2PGG+JJ1iKy9JHF57x6BfTS3XfiIIT9zcKxp+9CDBV6HEutFsN54WgENSqyJF/8K7ENN7hIBtUGj5f/rxk7WGQ+CjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923591; c=relaxed/simple;
	bh=ZpYPYYOCaujYywm/NG/iicgwa1Bn8xLvdGuLm27LpbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WTOlTyttL8Xl3SUzUXF/w87TMJAoYz8IPegxTMauLUCut7CKd4r3aDM+ux4Lq/EjfGw0aof2bdDZOum0N2fOrX0apu6xUOdGkJxcIIocqEaDR8LCVVmeChJ4QutTGkAh0I4SHXDqVq3en8KzA3aeiCcPUd45i7wOTpNOVso58lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogbfRVaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B36C19424;
	Tue, 24 Feb 2026 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771923591;
	bh=ZpYPYYOCaujYywm/NG/iicgwa1Bn8xLvdGuLm27LpbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ogbfRVaVklK/aJ/MNF+kCnw5Uch7s3DpKW/6CivyJ4FbolN12mpnxD8Q/KSZ6eFjL
	 1t6I3DUT8NuYEhF82G+5s7hIeiXIsZkNyiPE109CCG9i4KNm8Mcs//UDzaNyMDXt4F
	 /cUp8jfx/if+tX5RlvfagkJ6lMvg9JjlcIKxqV2soFlHf/GqBcn94ru+I9NF2jAPNH
	 x4KxxdzMNgcK2EF1NXJgm3c5MK8VljuVca2iVoJBUZtBxkaeXzOeWvL3VbOJyi/4YF
	 /8xEP+ayKdGJA9VhDJfCzBCmXn2A34aeyAYdrazQMcBHEnq7ms4vCMgYGIurKfStAY
	 dNvY5sG3G9NOg==
From: Leon Romanovsky <leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260218091246.1764808-1-siva.kallam@broadcom.com>
References: <20260218091246.1764808-1-siva.kallam@broadcom.com>
Subject: Re: [PATCH v3 0/2] bng_re misc fixes
Message-Id: <177192358863.744161.18271337279062491533.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 03:59:48 -0500
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17102-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAA5D1842E9
X-Rspamd-Action: no action


On Wed, 18 Feb 2026 09:12:44 +0000, Siva Reddy Kallam wrote:
> This patchset provides fixes for below smatch warnings in bng_re.
> drivers/infiniband/hw/bng_re/bng_dev.c:113
> bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
> (see line 107)
> drivers/infiniband/hw/bng_re/bng_dev.c:270
> bng_re_dev_init() warn: missing unwind goto?
> 
> [...]

Applied, thanks!

[1/2] RDMA/bng_re: Remove unnessary validity checks
      (no commit info)
[2/2] RDMA/bng_re: Unwind bng_re_dev_init properly
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


