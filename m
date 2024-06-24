Return-Path: <linux-rdma+bounces-3435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73C91490A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716A01F24CE6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E913A86A;
	Mon, 24 Jun 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="jKMTW77y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07C130A79
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229388; cv=none; b=SXwkmF1g3JjGOvaLedVEBnMKD1YYrUzbe30D3/zYiBWfxfNVzuBWHk1uf69Jom/fpGf4OiniLULrB6MkEYSxPH/nuxRwSJ6uZvHSH2GT3vKdXnJgwdLxRnq5h+saZbZGzsRvvvF1YrP6IWYekE3fBy/uSydqS9LuYr5J7MdrT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229388; c=relaxed/simple;
	bh=NONV+j+S5l9HF/j9cterpwHNuv4Y5XV9iAPe8xf3aWU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=mWDbULP3TaVciuWay+2VyLP7n7+j5qmQykJVEuW844O4QELmOQ8QxZye8hAtkX3cgMUJe2Tb/MLwmQJ0EY1rApKCMzaan9AVJckSkcDja79fm87x/zvhNE38zn29CV9WiZLCeu1NLWc8AzuJadrw88nFAXlC1wJRW0bSHEFpRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=jKMTW77y; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id F40F243C89
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719229385;
	bh=NONV+j+S5l9HF/j9cterpwHNuv4Y5XV9iAPe8xf3aWU=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=jKMTW77yD9XD+0UDFHWwWUqVkApwXpmC0gKFGM83RGzOAt9o2h2yFhtIBG85twHcu
	 0cUWUMtiQe/fuArheQoU7Wu0gavls/A/6I+zoq4XyTgAqCbT/nxmwKmgAsTqPMeSxj
	 5bDDYbC7osR1CGOmygwaXl2gSpoD1EHsa9XnhQm3zNbcnVUq6sg4AvSeIAStaAXnup
	 WjfP1oc9QjaMbLBzfhy9vB1UsfQl1gNkiqDjAhshvhP22a4bofwDCXdMzBZMudbAkC
	 a5YkcLt1DpLnHmm+a0HB3sFpM0qDcHPGZwbiI2zxwCG+mTxMlRozyxxJ/I6ZzTcPxK
	 eQx+Jxi9aGfSA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id DEC827E280
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:43:04 +0000 (UTC)
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
Subject: [Build #28601314] armhf build of rdma-core 53.0~202406240732+gitb4018780~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171922938490.701.5419445624264368286.launchpad@buildd-manager.lp.internal>
Date: Mon, 24 Jun 2024 11:43:04 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: c5f9848172b7f34dff8c1fe6f2ff0403a2123e0a


 * Source Package: rdma-core
 * Version: 53.0~202406240732+gitb4018780~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28601314/+files/buildlog_ubuntu-focal-armhf.rdma-core_53.0~2024=
06240732+gitb4018780~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-053
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406240732+gitb4018780~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
601314

You are receiving this email because you created this version of this
package.


