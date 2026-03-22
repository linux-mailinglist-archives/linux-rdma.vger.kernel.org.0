Return-Path: <linux-rdma+bounces-18499-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 12q9M/0wwGn/EgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18499-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:12:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 401932EA44E
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70C90300797A
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A2F371CFB;
	Sun, 22 Mar 2026 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgQ41Kmt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFE36607F;
	Sun, 22 Mar 2026 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774203128; cv=none; b=mBeaiVvyikdInl7wZcYpkAcU5az28Cgkp9IpnTaqoATBTBRdijjkwvvylJab9cW0MYD6CcGTM9ValSTiXWqKTz6JRDzeLVGGaV5Fme5MzjAiZCFs0vs8608R1iyj35bRWZlHO0i8BuG4AAriPATrdEZ2aYci1roMAbG8jcWCtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774203128; c=relaxed/simple;
	bh=xOndbYxRpVjnFwP18gaefNn7SXBjELpRuvWU0AEZJcc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kAMiDeN7YDowF8RtEXjYt7To7r19VVuzFpu3+amjohAmJajLJMrS4K5sDtnAEUSeWZef4TWIR4znPM0ORPCx9f4kflzSdnittT7b/yaD95TtwZK75P3RsK13a2Zvdndb5qHo1AhfoBNRxAhvpHLALJ9fuJDKhEE+B3BQh2cmXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgQ41Kmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC74EC19424;
	Sun, 22 Mar 2026 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774203127;
	bh=xOndbYxRpVjnFwP18gaefNn7SXBjELpRuvWU0AEZJcc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lgQ41KmtB1V6zd5e/aVer5Gy38RBnqW7h0sLeCV9tTVNmsj5h2LmabOmFHugfvWE0
	 QO/rZDXhFV8wQ5BK4QD9887jkUz1+/XMim6SJkJ04hP3Ji7S8/FkgarulZ7WI2xdJP
	 VnoZ6FU6xyRZiB/9ZsJStpbcZ9+GaKg3ePX7x2bH6pVpamai1FW9j74YBTiGoSblhO
	 7cntRp+grUlrtwZmwSZQyfJeMvnZjq7I8IHriBLue8c+ws21XoPpjH+a96b4NRe/6q
	 FKx+u1axmM33+7xoaUlCaOPEoJUcWpj8eAeIwFTNmi8t8BjFQ2S+O4g/ZUDs26ugsH
	 3IT/FE6GpVYFA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Yishai Hadas <yishaih@nvidia.com>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260319-resize_cq-cqe-v1-1-b78c6efc1def@nvidia.com>
References: <20260319-resize_cq-cqe-v1-1-b78c6efc1def@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Properly propagate the number of CQEs
 as unsigned int
Message-Id: <177420312305.2040745.701939084442446542.b4-ty@kernel.org>
Date: Sun, 22 Mar 2026 14:12:03 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18499-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,broadcom.com,intel.com,nvidia.com,cornelisnetworks.com,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 401932EA44E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 19 Mar 2026 17:22:21 +0200, Leon Romanovsky wrote:
> Instead of checking whether the number of CQEs is negative or zero, fix the
> .resize_user_cq() declaration to use unsigned int. This better reflects the
> expected value range. The sanity check is then handled correctly in ib_uvbers.

Applied, thanks!

[1/1] RDMA: Properly propagate the number of CQEs as unsigned int
      https://git.kernel.org/rdma/rdma/c/e8b64a452d0b30

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


