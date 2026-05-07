Return-Path: <linux-rdma+bounces-20166-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDIAL/uq/GkNSgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20166-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:08:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CD54EACED
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A999430054D3
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848753F787B;
	Thu,  7 May 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3Y12ljE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BE3ED125;
	Thu,  7 May 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166519; cv=none; b=NaXJ1JRKuEr2v23fwZGpWWWqRzNSoF39Z5IAg+V/xCWgJm7/ujkTwgI6h2AcrVEgcMxQYC/nMHhEiIYmkcpNkMuFJvlNucmX68DIVJ5mI1h6bbrbpYHIRu/eQ7YRX7Jt38qtvrbbYPu6+7qJkVZSkI6Eis27ZV2gZ9VTNkW64BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166519; c=relaxed/simple;
	bh=BstswbHAFQcJYWj1oDqKIxOfEQKYWGQcehKXmRPQyKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnEjj4wF/jln/UYr2Cso7nGggVNKCgyF+i5wzsoxpoX3ODo7DIhmxeUjeUOttTocdjYeAXA/lBrCfUr9HuLAsjpoo/HaFU/BrQQJK0MU9jXEmWqItyBxo0CsZwgtwHFjoY2hoOKnAKqgMhl6mdhXvjNymbjJ6kM6doCCSsxT81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3Y12ljE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20FC2BCB2;
	Thu,  7 May 2026 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166519;
	bh=BstswbHAFQcJYWj1oDqKIxOfEQKYWGQcehKXmRPQyKc=;
	h=From:To:Cc:Subject:Date:From;
	b=T3Y12ljE8WAHe0ZyiFHs6fTVhcnqsVhGHaflPNLo9cjRTnL0dhNqZIWxC5yp0aP0W
	 bCtW5rbhm54wGx9isdHtN7wJoGDwCk2xVVUBU7eLrHTIb3UP6jc6NOhFSv8fVPG66W
	 0pA3T/lIPIZP6FR2Hu01dOzebv7i6Qi57tCMExrVp16JXcfjpW/+5A9RjHhKU+0sk3
	 oQ2+DqtkyXaAcfo1xtDpPYdpngZ9u9+yRT+iizvhgkMs3Ozo/uvKs/vO2XcSUEsEHQ
	 ZyLh3Uh/kGccwJgxx4jUYHg6DJYnCcyOgQhay5QnEf3GCNzEfXky/yE83ZDQ3WvNMS
	 OVXLz/QJQFmSw==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next 0/4] Allow rdma dev netns to take a pid
Date: Thu,  7 May 2026 09:08:31 -0600
Message-ID: <20260507150836.28105-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65CD54EACED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20166-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Avoid the extra hurdle of creating an entry in /var/run/netns
and allow the netns argument to be a name or a pid.

David Ahern (4):
  namespace: Add function to return fd for netns by pid
  iplink: Update iplink_parse to use netns_get_fd_pid
  rdma: Allow netns to be specified by pid
  rdma-dev: Update man page to reflect netns as a pid

 include/namespace.h |  1 +
 ip/iplink.c         | 12 +++---------
 lib/namespace.c     | 13 +++++++++++++
 man/man8/rdma-dev.8 |  3 ++-
 rdma/dev.c          | 15 ++++++++-------
 5 files changed, 27 insertions(+), 17 deletions(-)

-- 
re-send; attempt yesterday did not have Leon and linux-rdma and did not
make it to netdev.


