Return-Path: <linux-rdma+bounces-19459-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D0SBzPD52nuAQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19459-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 20:34:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336343EB2F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 20:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C9233017A13
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D7374E55;
	Tue, 21 Apr 2026 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPR6Cwlc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BB372ECA;
	Tue, 21 Apr 2026 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796333; cv=none; b=EaLjUzb2d1goQcXl9y7oQ0Rmx1XfLM68mH74tqo3GWM3mo6XEApoOMZhXeUiffKmDJhqKTjJJm27fqIcyjT6g8rC+XmmXg3syGykWMwq0FKhB3rJPpuVEMRw3GeTLTSPRSqDtGU9Oymer4ctufTXmbOu+7CBMOGqJy5ovhi1E3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796333; c=relaxed/simple;
	bh=pUEF9CwZxyQ6JR1+1+foPNUaqYfODyMB+aCH5rB+5kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcVDW7TiQWSTbxDr3e1I7SWSE94mOu0Q3SDltQZg0a4fuUtiLZJEL+InffL2xN594r0px+BdM10apiVEpXlOq6xVBpYnxnv2tbAwlz9MVWR06h6/0xYkxB+JZ6/Q0/kmbB7bW2lFLMpMI6+hx56vSUt5meTCeb5HFo2KlEku4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPR6Cwlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5661AC2BCB0;
	Tue, 21 Apr 2026 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776796332;
	bh=pUEF9CwZxyQ6JR1+1+foPNUaqYfODyMB+aCH5rB+5kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPR6CwlcnrPIYjzhIFUEixtHX+nxIj/RfkXMawWvMkEaC6oT9LJMj4c+QXgcvIKaZ
	 9QHFLD6jWzRWLorPTdPoQ8u61KvjcwfPPi8FF8snKOr9FJE9298TH5JJ3Xz5rSQn71
	 EqRyhEq4eFpb2GHrTJc3qXvFPEWSycrp6j7AYjEWFr0LZ1fVN7ip+UmXV94HCA1Gii
	 RaAJK1osI3D6wledZZdZsQmV4MejHnBKUw8HlHxZkjN8wC5AoW+RlG2afyXYShvadW
	 dOH0r/EL+Aox67/lB2b1row7vCsW9JsAJRBPCsVwrwbbKM915chpZ8kNTF9qJLD9XW
	 kbwPco8AaO8Og==
Date: Tue, 21 Apr 2026 11:32:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
 <willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
 <leon@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "edumazet@google.com"
 <edumazet@google.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 "kees@kernel.org" <kees@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Message-ID: <20260421113210.4f6a8eb6@kernel.org>
In-Reply-To: <6d96452f67d5b58578f67f97f750101abd4af9f6.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	<20260418190848.204170-1-kuba@kernel.org>
	<d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	<20260420100917.1e4be22a@kernel.org>
	<f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
	<20260421072609.4b15e7b9@kernel.org>
	<3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
	<20260421080951.570e6e49@kernel.org>
	<6d96452f67d5b58578f67f97f750101abd4af9f6.camel@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-19459-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3336343EB2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 17:34:32 +0000 Cosmin Ratiu wrote:
> > No, the normal thing to do is to propagate errors.
> > If you want to diverge from that _you_ should have a reason,
> > a better reason than a vague "kernel can fail".
> > I'd prefer for the driver to fail in an obvious way.
> > Which will be immediately spotted by the operator, not 2 weeks
> > later when 10% of the fleet is upgraded already.
> > The only exception I'd make is to keep devlink registered in
> > case the fix is to flash a different FW.  
> 
> In this case, PSP not working would be spotted on the next PSP dev-get
> op which produces zilch instead of working devices.

When you have X vendors times Y device generations times Z FW versions
in your fleet dev-get returning nothing is not a failure. It just means
you're running on a machine that's not capable. Best you can do to
spot a buggy kernel is to notice that the fraction of PSP traffic is
decreasing over time. After significant portion of the fleet is already
on the bad kernel.

> But I understand what you want. You'd like the netdevice to either be
> fully initialized with all supported+configured protocols or fail the
> open operation. No intermediate/partial states. This is a non-trivial
> refactor for mlx5, because mlx5_nic_enable() returns nothing.
> Refactoring seems possible though, its only caller is
> mlx5e_attach_netdev(), which returns errors. It's certainly not
> something that should be done for a net fix though.
> 
> I have a series pending for net-next where the PSP configuration is
> hooked to mlx5e_psp_set_config(). I will look into implementing what
> you propose there and propagate errors.
> 
> Meanwhile, do you want to take these fixes (1 and 2) or maybe just 2
> for net or not?

Can you call mlx5e_psp_cleanup() when register fails for now?

