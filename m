Return-Path: <linux-rdma+bounces-19388-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGceMBHG4GmjlwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19388-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 13:20:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4F740D479
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CC1B3020D33
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E618050;
	Thu, 16 Apr 2026 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="gSJGywVb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0093914FE
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338389; cv=none; b=HE976bi93MBgpClM3+pqziUNmoU8rspKSHQS4Nj88pqBoqJSoUTKXMGwGG92s/O0rx+//gdvyi0KeaD8vnxq8P1hY0RxpNFEpNVQMt9sz4HZbX4GQMIXREKBQR0mtUHtBifj7IGNCHjOcUCQCBhFVVPnSmVWjL7115D4GtE+u0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338389; c=relaxed/simple;
	bh=z6f72kfTM9zVUWS+Z4oNN0tETh7pt5Ijhx8GPHc39+g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=nOyz0s2J1DZIKk+jmvfqNhcwY8PQA5OPHh6yrBEdgQJKYCY/wurNyAUPwp+EFQw1O5Rz1CYs0vHuC0zPN5ocvi4+okEXlDgERl7JkIO3VqwA/Ob7ukCF86p4JzSNaPcv5+PtEwWqeMSU1bu/0Mu8crqpMGSeB23DI2AQjousvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=gSJGywVb; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-51.localdomain (unknown [10.131.215.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 506963F041
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 11:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1776338379;
	bh=z6f72kfTM9zVUWS+Z4oNN0tETh7pt5Ijhx8GPHc39+g=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=gSJGywVbIxVKv2QpRCxChBRDS+yPGj19I8VJJIHiL6M7AcsR5jNS+BQfhVKghmIjs
	 8CNS/wA9ZFKxB5FAg6tjwrjLur9aF16MYgcgYOUXB8a2MWo+zj+2nsQqLdH3/OL3cg
	 2EGyxiF7Relp8QynSCkwKR3cySSfhM+zELO0rUYBGPXLNJTxigjZcOl3GWMPuMa/fB
	 /g3G+jJUrtGGvqoTHKdq4rUZ9e+MNj4m7jpGiaQlU7FXKsxKqReP8miZYH9dHJfhiA
	 Dkh5UziRfC6ir0P9TBfERtxINc5ZJAykTJ+U63tMjwkQgdQB/Emq857qZfeK/X93S7
	 BHQcYL9BQDtYQ==
Received: from [10.131.215.15] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-51.localdomain (Postfix) with ESMTP id 3D99DC10DF
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 11:19:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: MANUALDEPWAIT
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: noreply@launchpad.net
Subject: [recipe build #4030932] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <177633837918.3282238.5411771636062544828.launchpad@juju-98d295-prod-launchpad-51>
Date: Thu, 16 Apr 2026 11:19:39 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="866d07beecca8ac2e3326342adf6c1740cd3e7b3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 24238fe600229d206f2c0e65a8adb482cd9c66d3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[launchpad.net,none];
	R_DKIM_ALLOW(-0.20)[launchpad.net:s=20210803];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19388-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:replyto,launchpad.net:dkim,launchpad.net:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[launchpad.net:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noreply@launchpad.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[noreply@launchpad.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: BF4F740D479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/4030932/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-017

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/4030932
Your team Linux RDMA is the requester of the build.


