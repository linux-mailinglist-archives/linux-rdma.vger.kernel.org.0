Return-Path: <linux-rdma+bounces-18932-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIauOZbOzWnghgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18932-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 04:04:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A41DA382834
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 04:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E68E130F70C8
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3D332EA0;
	Thu,  2 Apr 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1ISt/OL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758972C21DF;
	Thu,  2 Apr 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095227; cv=none; b=bVd/Hn+9KMzOZHcezKVX5IJ+jVhDElU3A/WNNf+I3dW/Bi9gCTjCPE3M6CDPX9vNlOzGJir19xbM7D84KK+8I1qfEPgQ5NZFB5QjN8ht1ZTk1dxdNOTS7T/iUmENpwtForliH4ZZhjjeCvEN721zveOPn7uYyb58rPlSEiIzauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095227; c=relaxed/simple;
	bh=B1P50xXIR20pcrrFSRYniKhfNsrcUuNjIUPaNY6Hbk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mI8zEHQ+L0pV2RHTcXZlzLwjXBJX34PkAJ8FClxDcuRuNQAneUMTDSl6BYpyK11noWuS0B/9X40CTOiNFOvvAbLEEzNfZLNib7eeyLi1p81xi5Dl6RQ1wHCd0huPSgh6irV9MBLqYREaOZjukXbySQybPBiivBScbH7im/e2Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1ISt/OL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE02C116C6;
	Thu,  2 Apr 2026 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095227;
	bh=B1P50xXIR20pcrrFSRYniKhfNsrcUuNjIUPaNY6Hbk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m1ISt/OLTANcenuzyL99Gz6QnWhrQK0CVHNkjvrFKuufA7v2FUnWdTKu2t/IN5u8D
	 bNE0QpGxH6AehIkZ2ifYlZbEzu9Kh0w6iDNsJccG3RzgfkUkRhy6xr24VchrDzh1aE
	 ckHR5nOj5C/348IRqFhRvlZWHkSYy1fboKjbW2vSwDhGCG8vK5u0/BcoKnvEbQBbno
	 IC8nCWV3vvDWz/8VqF0G2joPL7mBoW2w1eHknfWnmkfLv+0/Gh2sk+Cy8x/QNLdzFN
	 9B6L6GfUe6kfjV6zKbdlj1F6XuIrxh8gXTCp8rfDy/n8WKmGNpYXpnVxpXAzbz1Qgl
	 PzhQ7/QKSv77g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F2F3808203;
	Thu,  2 Apr 2026 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rds: ib: reject FRMR registration before IB
 connection is
 established
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509520956.3948497.3083161529511693686.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:00:09 +0000
References: <20260330163237.2752440-2-bestswngs@gmail.com>
In-Reply-To: <20260330163237.2752440-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, xmei5@asu.edu
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18932-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A41DA382834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Mar 2026 00:32:38 +0800 you wrote:
> rds_ib_get_mr() extracts the rds_ib_connection from conn->c_transport_data
> and passes it to rds_ib_reg_frmr() for FRWR memory registration. On a
> fresh outgoing connection, ic is allocated in rds_ib_conn_alloc() with
> i_cm_id = NULL because the connection worker has not yet called
> rds_ib_conn_path_connect() to create the rdma_cm_id. When sendmsg() with
> RDS_CMSG_RDMA_MAP is called on such a connection, the sendmsg path parses
> the control message before any connection establishment, allowing
> rds_ib_post_reg_frmr() to dereference ic->i_cm_id->qp and crash the
> kernel.
> 
> [...]

Here is the summary with links:
  - [net] rds: ib: reject FRMR registration before IB connection is established
    https://git.kernel.org/netdev/net/c/a54ecccfae62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



