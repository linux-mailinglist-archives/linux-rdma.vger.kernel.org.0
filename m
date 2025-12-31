Return-Path: <linux-rdma+bounces-15254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CACEC11E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DC93012DC1
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A112561AB;
	Wed, 31 Dec 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="SYlBnwZT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614E1E1A3B
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767190597; cv=none; b=ix/bo4+ylmNGwDqiMyq7FNKKyWQY1M5ZkT/PuV1VuD0Cg/2iiakogcNkQ6WERr+SwZ22XDaC/ZpTULgiOTcGkuPgDE6rHVvuotUuH+XiRilCXgii6JmyLdbSBDxj3k4GZWydGKRY0lN4TmIDFodh1bqrTKoTVx0gzYrsBY0v5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767190597; c=relaxed/simple;
	bh=R8RFac9oSgfrLTrhO+NLXOWY1W+XHLaXI0oyCevvZBw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=PLw4V/JTumY7ljnho7fUaX9A62L8ESib7feGNGREyv3VDS+//Gw7Q7DhRf++oUuFtgcUe1goi5/yWeyyNT4wFInRdf4OSUhFAXh4pJOxPcUs9WRbDUhREE4rA0pL2bYGZTdh8mI5gDsE9YQcvKZik1CBRtLTrQhvwA7raHpMu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=SYlBnwZT; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 82B9F3F078
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1767190594;
	bh=R8RFac9oSgfrLTrhO+NLXOWY1W+XHLaXI0oyCevvZBw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=SYlBnwZT0E9C6UfOzZjJxKGAAWLJ2v9bWrgUM1xz1opi2fGxAb+pxxbIxYUTev8oz
	 qoA1qh0CNfXhAEBvtJ8NcWs9JWMQYcRuwCk3w9Lqgtes7fgK6taD90kV5uFHLDbqAq
	 ok6vzfJ6SSHvTPzr7Jzs5mSzXSAE/rrZCQSb+tNMeFzAcJKkY/B/JFnm+y5TSrrK+h
	 uoRzjA/+6iCM9d+uZ9/1EEfNw9dRXle2jXG0u8ZBNnKUV/Y8T1sh9lcQjjCVBGkCL9
	 p5gaDWTCinQ9+rGFWYxHU57G5TiIawbCBuNWkzuEqKlyolDvs8K8VQkV4c0IkPiyDk
	 pdwCEQaG8ydag==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 762EE7E747
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 14:16:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Creator @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: package-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: FAILEDTOBUILD
X-Launchpad-Build-Component: main
X-Launchpad-Build-Arch: armhf
X-Creator-Recipient: linux-rdma@vger.kernel.org
X-Launchpad-PPA: linux-rdma-rdma-core-daily
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: Launchpad Buildd System <noreply@launchpad.net>
Subject: [Build #32100537] armhf build of rdma-core 62.0~202512310751+git902dce1c~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176719059448.3785417.9215593116393706711.launchpad@buildd-manager.lp.internal>
Date: Wed, 31 Dec 2025 14:16:34 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 3f7cd89ad07fec2790b510bc7d0af57905e5739d


 * Source Package: rdma-core
 * Version: 62.0~202512310751+git902dce1c~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 10 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/32100537/+files/buildlog_ubuntu-bionic-armhf.rdma-core_62.0~202=
512310751+git902dce1c~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-092
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 62.0~202512310751+git902dce1c~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/32=
100537

You are receiving this email because you created this version of this
package.


