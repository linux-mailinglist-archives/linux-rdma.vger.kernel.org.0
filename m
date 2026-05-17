Return-Path: <linux-rdma+bounces-20828-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEgNNSSACWoecwQAu9opvQ
	(envelope-from <linux-rdma+bounces-20828-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 10:45:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B7D560044
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A509F300BCA0
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418E346AC5;
	Sun, 17 May 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suUfAOEt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9434A76F;
	Sun, 17 May 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779007517; cv=none; b=iNeynG+bT/TVz47KeQvHW1SjIwQaJDCICW4oLclBswh7JTP/YE3tbGEDHIYrfUQImEP9MStPwAncOK8Q23JbycIT52GNXwlHwu9gRv+baE6PvKaPIzbe52/TeuNukZ2es5o2e4wtXIghlcNmW/fCi1ahX6vP9Q/BkKyNJjFPHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779007517; c=relaxed/simple;
	bh=JCEMetkZW7cgevDGH7f1eHrAyDf6CeeVwkjMDn6Mjnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfALjsOfR0jSYPB8MkiO88Wn+YW22NczXyvE8Jo5UlT8mk+/HzmpP00aCUKNVzKqcsNY29/+WeE4YZlXfEPNX6mMsSVQpdfiY3gp45A+vR28z5unZdOSoW/Tb8LNFPthlUpOUxB3FDB4W1UqCxJ0dWn2XK5ecNeDO18QzzZP3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suUfAOEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F94C2BCB0;
	Sun, 17 May 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779007517;
	bh=JCEMetkZW7cgevDGH7f1eHrAyDf6CeeVwkjMDn6Mjnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suUfAOEtHHB2BiVHgZCCMYJtS9B3x2ClWrAW4W5+PZzz8q8lSBM4MWhNFz8r1WSUg
	 +0Y0BRm/y4IL0Z5ZFi7dv5vo32mCTVB6EAklXucK/v3eBdjjCMkERpVjMUPO40kTtA
	 BfZQH6y3w3u0L0LIyf8Q00AQYC5NXUYRn9VHNjjBBS0i5v2pLEp/uTFg0zQtnGOl/j
	 L4AbyOL+obFxBAgDMmDR6iqVbCCw8BZPxIK+/Qifx1MZwTwZc8tphy5G1NrxKxIj71
	 FvOS/REbLbafiGqqjbcHYKhF4IgTVxwfRSYGIl6b0Gk9V2TUU36mCChisledd2GWBz
	 fcU71svIP72ng==
Date: Sun, 17 May 2026 11:45:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Xiang Mei <xmei5@asu.edu>, alibuda@linux.alibaba.com
Cc: netdev@vger.kernel.org, dust.li@linux.alibaba.com, wenjia@linux.ibm.com,
	sidraya@linux.ibm.com, tonylu@linux.alibaba.com,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	bestswngs@gmail.com
Subject: Re: [PATCH net] net/smc: avoid NULL deref of conn->lnk in
 smc_msg_event tracepoint
Message-ID: <20260517084513.GA33515@unreal>
References: <20260510222640.1230720-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510222640.1230720-1-xmei5@asu.edu>
X-Rspamd-Queue-Id: 83B7D560044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,linux.ibm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-20828-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 03:26:40PM -0700, Xiang Mei wrote:
> The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
> smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:
> 
> 	__string(name, smc->conn.lnk->ibname)

My comment is not directly related to this patch, but it was triggered
while reviewing it. The ibname should not be cached, as users can rename
it through rdmatool or udev.

For example, this function is racy:
   552 static int smc_nl_handle_smcr_dev(struct smc_ib_device *smcibdev,
   553                                   struct sk_buff *skb,
   554                                   struct netlink_callback *cb)
   555 {
   ...
   582         snprintf(smc_ibname, sizeof(smc_ibname), "%s", smcibdev->ibdev->name);

Thanks

