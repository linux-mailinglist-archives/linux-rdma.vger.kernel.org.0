Return-Path: <linux-rdma+bounces-18064-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLaHBFIysmkkJgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18064-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:26:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0E26CC56
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04F1D302FE88
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4521C386C1C;
	Thu, 12 Mar 2026 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJmC1fCE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039C346E7A;
	Thu, 12 Mar 2026 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285966; cv=none; b=uxvn4cYw2CBPqLtWG8xyHmtid8wXZv0ypgNux6pVMBFcyknf1c9+O2bjSK94Wefg65PxsK5lgxdeV5jR8mcwDYZbs8mAIuOI/f/KaAfmTWjQe+mZ77gnFaDQBd90SvUn8mTmVRLF56o8Xr+uZdn0/610JHDvrvXIbm3pQz2nHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285966; c=relaxed/simple;
	bh=q3EUBK4jLA/YX/UN7xyDj92eGsiZwUVakDFEjt10Fl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry2xxoZFhJj/FioinTw3GHrEbJRn60Li/1kCzJDvTX3mWuFl1YYslixiZL9Z1WtBVHolQwSq33pRN/K/UAJAsqJtxauf8rqOSWfV+qvcC90EyfOxlKWQ5pUr3SVLRoxOhTA4ZSQb3uhZ690pHbtfNCnwA2j4VpFLH5H0D+/Oqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJmC1fCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B7CC4CEF7;
	Thu, 12 Mar 2026 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773285965;
	bh=q3EUBK4jLA/YX/UN7xyDj92eGsiZwUVakDFEjt10Fl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MJmC1fCEFGd2aiqg/Nfeti+WGQRz0lh+Sk/uAGhMXCAbxw29f8GoDLRPaiANKC04s
	 +kYyii6goR6ZsFgjqczIEeEcqrC1kmso8KG8j4nI8mlE20P5uDSDwe0LgPrTloz0jy
	 tbi3xNalojfTbAzmba+ieKZyoh+UacDt78/Qs1tHemzJW4MJ26qBwIsGhAVLxAMq3M
	 5ha8WpdQu+UmOqqdCLTxspVe3TpXQ0VklR31/UEA2/1Y85FKsmZsfjX1NAS6lw9zm0
	 y+lFkJaJ11AEjz5V+9KU66eiHbhBscE7dts/k4nhLKSlK3uL02SpAwmKklPICRRxbm
	 Wk9QfeDNQn6Qg==
Date: Wed, 11 Mar 2026 20:26:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Jiayuan Chen
 <jiayuan.chen@shopee.com>, Jianzhou Zhao <luckd0g@163.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Or Har-Toov
 <ohartoov@nvidia.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Maher Sanalla
 <msanalla@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Kees Cook
 <kees@kernel.org>, Jang Ingyu <ingyujang25@korea.ac.kr>, Moni Shoua
 <monis@mellanox.com>, Doug Ledford <dledford@redhat.com>, Christian
 Benvenuti <benve@cisco.com>, Selvin Xavier <selvin.xavier@broadcom.com>,
 Yuval Shaia <yuval.shaia@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] IB/core: Fix use-after-free of ipvlan phy_dev in
 ib_get_eth_speed
Message-ID: <20260311202603.265198cf@kernel.org>
In-Reply-To: <20260311100313.284589-1-jiayuan.chen@linux.dev>
References: <20260311100313.284589-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,163.com,ziepe.ca,kernel.org,nvidia.com,broadcom.com,korea.ac.kr,mellanox.com,redhat.com,cisco.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-18064-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64D0E26CC56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 18:03:08 +0800 Jiayuan Chen wrote:
> Subject: [PATCH net v1] IB/core: Fix use-after-free of ipvlan phy_dev in ib_get_eth_speed

FWIW this is not a net patch (infiniband is not net)
-- 
pw-bot: nap

