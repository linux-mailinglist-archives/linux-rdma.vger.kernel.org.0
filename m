Return-Path: <linux-rdma+bounces-22427-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OlCkCHXNOWrHxgcAu9opvQ
	(envelope-from <linux-rdma+bounces-22427-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 02:04:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A8F6B2E7C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 02:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DSioLey6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22427-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22427-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D752B303B4DF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 00:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98201643B;
	Tue, 23 Jun 2026 00:03:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB4625;
	Tue, 23 Jun 2026 00:03:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173037; cv=none; b=g42NCUDUc8yFciyg2IKYpLRX5k++lawIQZiZ1rhjD+EWl4GS74DbuT3+lUCHCXOdEr/eq859lDnCrlqb0hIfl+bECx4zcf9409MjjnbsFfOMFYDi37XqqLbkMbf8WklDqzPTrkae3WwiHIpxl+FJGEUkxKstca+f9uFCj47Cp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173037; c=relaxed/simple;
	bh=MBtfmjtNsl4fI8AjSD87amZiNPakGb8VUKNeDNDbdPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1hVTYARupexk1zHDxmRcsMfqKcaPFA7bwnUdgIpqqjzUg6L9QFwuTYHqrUXwJf9cSUCKzv5fmB9MrLywB9q6OAZrnDOtUMxLdIwxH+01Z00JlMJMxG9kAQOeJX4vMUZuAYn3fx82O4Kssiqt71xLMq3P4vnbYa1ysI1ZRR6lg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSioLey6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD9F1F000E9;
	Tue, 23 Jun 2026 00:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782173036;
	bh=+6laKclz3yzidyKAlLLIkCm0CW40HGOttO4vxjnEKUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DSioLey6Remu5VpWUZ+ptoDZiudFetgbj707SZT6WK3IU8mp9DxjoHR5fh1lxOnuT
	 yZe+XUaAjst3QnA+EgmBYRnrDvvIKren4Wg7MlbDLJbvEAYNOC0tWCEgcJLE+jV3aP
	 xuhoFANOOiJLXs4l1+mao6G40KEhYhkVd323C7pLTmgvg7z3fmz3ZGPNlxfgcGL9XQ
	 0mzulD0Q1ICaHIgePUuEwTN2G3Nj8aUO77daaMC1ZH73Q4yZP1Nis8Rau1Bg5eJm1V
	 KbfCO/HVG8utpmlG1NaVEle66mj2xNPf3j0aKFMNL9ysbEL52orBV4D0cqKQpBUhuw
	 fwsSvoMLUHOHA==
Date: Mon, 22 Jun 2026 17:03:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shay Drori <shayd@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, <tariqt@nvidia.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <saeedm@nvidia.com>, <mbloch@nvidia.com>,
 <leon@kernel.org>, <ohartoov@nvidia.com>, <edwards@nvidia.com>,
 <msanalla@nvidia.com>, <phaddad@nvidia.com>, <parav@nvidia.com>,
 <gbayer@linux.ibm.com>, <kees@kernel.org>, <moshe@nvidia.com>,
 <rongweil@nvidia.com>, <jacob.e.keller@intel.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <gal@nvidia.com>
Subject: Re: [PATCH net 3/3] net/mlx5e: TC, skip peer flow cleanup when LAG
 seq is unavailable
Message-ID: <20260622170354.5f87d24b@kernel.org>
In-Reply-To: <e18662ac-413e-43f6-ac65-a4e15fd47bb7@nvidia.com>
References: <20260617063204.547427-4-tariqt@nvidia.com>
	<20260618124820.890808-3-horms@kernel.org>
	<e18662ac-413e-43f6-ac65-a4e15fd47bb7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22427-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:shayd@nvidia.com,m:horms@kernel.org,m:tariqt@nvidia.com,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:phaddad@nvidia.com,m:parav@nvidia.com,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:rongweil@nvidia.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8A8F6B2E7C

On Mon, 22 Jun 2026 09:40:44 +0300 Shay Drori wrote:
> > [Severity: Critical]
> > Does skipping the remainder of this loop prevent the flow from being
> > unlinked from the doubly-linked list?
> > 
> > By using continue here in mlx5e_tc_del_fdb_peers_flow(), we skip calling
> > mlx5e_tc_del_fdb_peer_flow(), which means flow->peer[i] is never
> > unlinked from the esw->offloads.peer_flows[original_i] list.  
> 
> only in case a LAG member is removed from ldev, mlx5_lag_get_dev_seq()
> will return error.
> before LAG member is removed, esw->devcom is cleanup, which invoke
> mlx5e_tc_clean_fdb_peer_flows(), which remove all peer flows.
> Hence, no flow remains.

Thanks for responding. That said, the series no longer applies.
-- 
pw-bot: cr

