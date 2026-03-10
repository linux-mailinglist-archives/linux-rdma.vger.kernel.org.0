Return-Path: <linux-rdma+bounces-17886-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ox5LA5MsGnFhgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17886-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 17:51:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC56255157
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BC7830848F2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CF3CF058;
	Tue, 10 Mar 2026 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRJWl6Cf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B93CF055
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161211; cv=none; b=RlD42u9bS0bvCplVzFnwetCk4xueZaOP/GBtazHAresm6K8/g5AnW72Zk52Dwb5rNnoLkhs41/lHpNA1uWOm34HBuwlQSw0S3sYqfE07bwbWSXU5xWYSABvh4sJoO1ydBT3lrSPfYbWah0/B2NNrnmiN2FGWSMqTGigQYq3elDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161211; c=relaxed/simple;
	bh=n/xkWgkcIU3ab/PNUnQsbPrwA6YynTe28fcrarTJNPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gREJNk4+xVhDB3oRjmYAOadzj2Y4JmJBjsHJtuf9dFHzd85qJnVwKUW1A+j/yWYXPq5UzGeiuT2D1wgaYz6MsOVY0q+HQh6ZiXM0DERAc/s13N5caV87h7lLrqDuDxLShDTGoLrKHX+A0wG7hCeE+JCxezSF2DnfvuU90E8o0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRJWl6Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2835C19423;
	Tue, 10 Mar 2026 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773161210;
	bh=n/xkWgkcIU3ab/PNUnQsbPrwA6YynTe28fcrarTJNPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gRJWl6Cfp7x7SdGJoAENF338AiNDJMnT4LS0A0+3pszv0XMteu2yFTC6tyzQF1SVS
	 K07MpY0gRqNqMu5eT+dhe3PVRP4FWHrw+9y32FN/AIow2QcEgK20N54wIF+okZngU1
	 69zbZMbD4X1TcndLMhKTV9YC1xf917s8A5q9BSNIFT93IWMRGq6npdj8uWj7h/yjMf
	 uKZ9EE46BEJf94OpQ87KBO1NszIMJH0DjgWM0mPAtHQHhzKxg52KOjZgNE7zoOew9d
	 Q5z0EyIaPNCIHZHTiUICcBVNdsrRzod2H8xdqEtNep5iERIzFC2YjmO9hhMBL6/W/q
	 e9beCi2k0FP8A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <177308912950.1280237.15051663328388849915.stgit@awdrv-04.cornelisnetworks.com>
References: <177308912950.1280237.15051663328388849915.stgit@awdrv-04.cornelisnetworks.com>
Subject: Re: [PATCH for-next] RDMA/hfi1: Remove opa_vnic
Message-Id: <177316120745.1718129.339148576956816735.b4-ty@kernel.org>
Date: Tue, 10 Mar 2026 12:46:47 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 6DC56255157
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17886-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Mon, 09 Mar 2026 16:45:29 -0400, Dennis Dalessandro wrote:
> OPA Vnic has been abandoned and left to rot. Time to excise.

Applied, thanks!

[1/1] RDMA/hfi1: Remove opa_vnic
      https://git.kernel.org/rdma/rdma/c/76ae14db9058b1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


