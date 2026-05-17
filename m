Return-Path: <linux-rdma+bounces-20832-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PNsdAfGfCWqLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20832-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:01:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8616C5609D7
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 413363003359
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5134EF11;
	Sun, 17 May 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsaw7veA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC92D8DC3;
	Sun, 17 May 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779015659; cv=none; b=Gbj8mm+ge0d60a3F4l6gZyd1ksppnPeOSe/tKCGYDeKHz9i1MN7gdcVGPB8tJanxsY2wYE8ZDDco9a6e5np+AVXd0brjrg5vK6Y1Xa968P2wcPLz64PYHqAjt8oV+iig4uJWjBbtwSvEqT8btvI8smDZdBMydaPFaw8H9VbvXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779015659; c=relaxed/simple;
	bh=N8ByCkVykHc+7t2L2A+AQyDHf8DCIPz0id4L2lZZ2ck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MGbMUorM3k2hApqphHvtad5BWqnniADyLkL3zA45Jjj/lhaBk3Ifow3tKYxrX1c80canNmaTJi+9+VZI3tZhYP6qgzSqJ7hXys5oOVv2yJCWbxJMD/qVH9klEeJ4Ch3dyOc7RM9qbcaXfmKNh9S85jH1BRKJ/yN8gRnvHmovA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsaw7veA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2087C2BCB0;
	Sun, 17 May 2026 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779015659;
	bh=N8ByCkVykHc+7t2L2A+AQyDHf8DCIPz0id4L2lZZ2ck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tsaw7veAIC+xlbnS72arvAC4ktkEOhQr7i5y7QUUrghjr4doVto1yi+TWkms6y0xX
	 6LhDyEW9+kpHo1VmqMynGzNI79WrwImGn9Ito3uL7r0UsVbvemcBDz/HTWAi6JYhMg
	 W6TeBXUZkjZIcGZ7q+jYd67SxSyQq/AJrzTcIs0l7uTa12MVz73HgDSutF2Uml4rgo
	 fmV+88hTl7xtDE6pxEyZgio2h2/Y5+OeUD5dv2uOH7hip4AWDPC9BFMun5RwoCS0Zm
	 4yKjkKW3UpX1PdE+g4lu6WON34qajpo9B6EM6YEEOfHFLLsywcxffFgfZ6ltX8YLZ4
	 FPh+roJ6NDjKg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc: patches@lists.linux.dev, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 stable@vger.kernel.org
In-Reply-To: <0-v1-c4e9da262868+24d-ib_handler_fn_fix_jgg@nvidia.com>
References: <0-v1-c4e9da262868+24d-ib_handler_fn_fix_jgg@nvidia.com>
Subject: Re: [PATCH rc] RDMA/core: Do not read wild stack memory in
 uverbs_get_handler_fn()
Message-Id: <177901565641.2521316.2820854436041538240.b4-ty@kernel.org>
Date: Sun, 17 May 2026 07:00:56 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 8616C5609D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20832-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Wed, 13 May 2026 12:00:16 -0300, Jason Gunthorpe wrote:
> Sashiko points out the legacy write path in ib_uverbs_write() does
> allocate a struct uverbs_attr_bundle, but it doesn't wrap it in a
> bundle_priv so downcasting here isn't safe.
> 
> Instead lift the method_elm out of the bundle_priv and use it for the
> debug function. The legacy write path will leave it set as NULL since the
> write method_elm uses a different type.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Do not read wild stack memory in uverbs_get_handler_fn()
      (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


