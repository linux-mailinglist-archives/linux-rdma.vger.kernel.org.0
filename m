Return-Path: <linux-rdma+bounces-20789-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD6+AbmiB2rP/QIAu9opvQ
	(envelope-from <linux-rdma+bounces-20789-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 00:48:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A70F95590D2
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 00:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7BE93047059
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAB53F5BF1;
	Fri, 15 May 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls6ka9XG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102A3F076E;
	Fri, 15 May 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884903; cv=none; b=ccw+uJrxbenlB32WmhmZ6dp/OMzSPFa40U128aN+6JJKvPXmdeG2FsOIevaE8kvKnMv4aqsK8aPyeZL0DHCL/2pTgmKjTwbR7SrlKxQg17BnVz2/YQf3QLwHdNyITC0wy9FIuYwLvprczQQ8C713gRGUJDzpQPOBSyxojCtCBKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884903; c=relaxed/simple;
	bh=5DWLXzgfr2ZE3/FhL345QIxYPUXZLODTfxkYRqqzhQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9Aeq+7xYaqG1PSXbJkfTJyKRL7+nMbSOBSkfzYFoQnIewrVdMArOn6SmGmFBX6R5BMyu+PCZV6iOvmCCMQSKjmSZRk7nHkUIa+JE4zOHy2mpSyd3BwonY0mpegHEyZXndCE9GEZ2USWmyd1+iZ/CUndoYHparzSUzK8+x/qJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls6ka9XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD5DC2BCB0;
	Fri, 15 May 2026 22:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778884903;
	bh=5DWLXzgfr2ZE3/FhL345QIxYPUXZLODTfxkYRqqzhQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ls6ka9XG7FQvigNkAPMxAwKSR9SOFzNFsFLrEhbI/JuCmttNr5XkmTMdARgCG0JUD
	 TavVHNWb2Rb73wfO5lnBW9STbh5p0c7FxjcTwnsOKjVb3QZgply2XOFOCz6IOZY+BM
	 PgNFKnJOCve9ttWL5XHJB8nebfOwKUfqfrQpUj3WtxT6EWCsHDrgwH6YezClP71xcd
	 xlYE/C6i8nZaNsQFdXFdeaPGzsxR8jfkOX+Fg7RpnK1dfZi1wqogYZu7YVmy8C/4MJ
	 0d0mjWuvIxxsCQYlu+qVLl1CVoSYo2QCL5O3Nue0HM16AMIbJbhgiYKIr/9uFyiRz3
	 3fy4uOkXNCuiQ==
Date: Fri, 15 May 2026 15:41:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, "Akiva Goldberger" <agoldberger@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure
 for satellite PF support
Message-ID: <20260515154141.17645943@kernel.org>
In-Reply-To: <e5e1ae53-a458-4248-87b9-aa1e1a241571@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
	<20260513192539.7fd96592@kernel.org>
	<639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
	<20260514161649.7a59a547@kernel.org>
	<e5e1ae53-a458-4248-87b9-aa1e1a241571@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A70F95590D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20789-lists,linux-rdma=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 12:36:50 +0300 Moshe Shemesh wrote:
> Now we have a new Smartnic configuration that adds another physical 
> function, on the DPU, that is not eswitch manager and not page manager. 
> The new PF can have its own SFs and the customer can passthrough this 
> Satellite PF to a VM on the DPU and give it to a user that should not 
> have access to the ECPF privileged function.
> As will be shown in the next patchset, the ECPF handles the Satellite PF 
> and the Host PF in a similar way, using the same management framework.

Makes sense! Please respin with this in the cover letter and the
clarification in patch 2. Thanks!

