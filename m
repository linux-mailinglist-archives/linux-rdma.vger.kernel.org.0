Return-Path: <linux-rdma+bounces-18530-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMIaK3+UwWnuTwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18530-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 20:29:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F26F2FC452
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 20:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6D19308746C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 19:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C663ACF18;
	Mon, 23 Mar 2026 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGnc2LhJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CB3AA504;
	Mon, 23 Mar 2026 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293928; cv=none; b=pjzuNG4gtmy3pky943oGTpYoOvQi5RNYQ7T/Qwks5u185n0QoJp7v0v7MxNADWpzAssAIjTIlcvjJE4mrLNCDNDBy80fXdFSh++3rzaasG081VHuMl5CD2+7z+BZmXjRbi3ZNwT29LemvqpNJqz68iTtz64SzHZvg+D8qgSayag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293928; c=relaxed/simple;
	bh=PbbzAz5GcMzF4ZwrWaRF3CThzVznzGkyBW1UzCD8xYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GMMiRm8CHrtLH6u8ZODZIFKfE8t7/o3NGW1fyK6adK4yPX9kXiW06/BH6CdpXSqjaiLs3vO16apy5u44c2+UPSVxMcR7CVfQo3ZDYAv/CVKaXIotDKyZ5kj7n28jeMFI7Ao32Zhmds54A1yKmb0j7RYvL6qW0v6kGvsgRhp6Oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGnc2LhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE49C2BC87;
	Mon, 23 Mar 2026 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774293927;
	bh=PbbzAz5GcMzF4ZwrWaRF3CThzVznzGkyBW1UzCD8xYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QGnc2LhJxCIEUPwPdv5mzgU+UMw50y0FGfO/dtzv6HfsnvK2rBEKbcBKi+/mfCbHg
	 iwYQOyYGoiqmXSDcT3GRqyP2zX6J2pYrCXrcCJ+FUslzLZrF2eZ7PMuyf6KCgrMa3E
	 cqBLxSiW9Ubl2vAkKv6QmV5/Jy9F5F696pd7F/IpQSbQD0PSm1s603VNcZUy4ejJOA
	 rkVp71cD+R+83FlopQZdYetzD7NBAnEKpNXhwCC6UBInVKBDeb8LCEWYwI3BsfrznO
	 1M5TJhUfjR1TAYKEediPJO+J/Kuf4ThibvvxeQ2/5qCMl0ykUHWPnYYvPeb6eZLCkP
	 0xyY9qILSjYOA==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
Subject: Re: [PATCH rdma-next 0/4] RDMA/bnxt_re: Miscellaneous cleanups
Message-Id: <177429392482.2367219.14593949422088253229.b4-ty@kernel.org>
Date: Mon, 23 Mar 2026 15:25:24 -0400
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18530-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F26F2FC452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 18 Mar 2026 12:08:49 +0200, Leon Romanovsky wrote:
> Perform general cleanup following the recently added CQ creation logic.

Applied, thanks!

[1/4] RDMA/bnxt_re: Simplify bnxt_re_init_depth() callers and implementation
      (no commit info)
[2/4] RDMA/bnxt_re: Remove unnecessary checks in kernel CQ creation path
      https://git.kernel.org/rdma/rdma/c/8c65d350b5bf9b
[3/4] RDMA/bnxt_re: Replace kcalloc() with kzalloc_objs()
      https://git.kernel.org/rdma/rdma/c/48730650ae101c
[4/4] RDMA/bnxt_re: Clean up uverbs CQ creation path
      https://git.kernel.org/rdma/rdma/c/1c3eaf5186228f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


