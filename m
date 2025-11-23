Return-Path: <linux-rdma+bounces-14712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0940C7E69E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 20:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAEB3A564B
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336042571D8;
	Sun, 23 Nov 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="U7qurinH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB74A35
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763926967; cv=none; b=UZorGPzwX2hs8ASy540UyTB4Bo9TDRMCSZDcO51N5F9H2Mc5eKAlI3rVzcYOZqUMf9kDY6igY3Y8WxhUD0aIa6WP+CW+2WoPsbLWgqtAVxb0o8R7I4DVQnY2HZ6iNb+5n3pWuz57evq3fKnLulmKrJW61qH3MOikT1/Txni7Y4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763926967; c=relaxed/simple;
	bh=05XO9OgV5lhgdpvjEMK7I03nZCntHxCWngH8FzmyUFs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=OXeV5jWS0JT3N4/WQvQxk7BqM0SIedVVf5KvFF0wOnAHrYyRIJO920Cj/USafmCGdvJRbOFefSNiclzFKhcUfhMfhHAUQROlp2BjR21DqeZssQeEyAJiNv75eJXZt9P8aGHHIHshkOEnCAhb2g3SgTg1+BPhVtNwQG1KayJrLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=U7qurinH; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 5AC493F8F8
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1763926609;
	bh=05XO9OgV5lhgdpvjEMK7I03nZCntHxCWngH8FzmyUFs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=U7qurinHr+YPnRUa0K4PlPLWy9MZKeEpVQdUepWsb6GDBhOQS8GjW2vOJAT6Eo4yK
	 5kXIYoJQcrs4u+zjapixX6/LBe0wAM347StNNZsSyL98hbzfM9+eMOy0ueT6Dnk/Jy
	 Z4f9kRnShKtHIpHKch9RIPOsEtQR9BLcb3RdLGYmP4ot7rftepPs01YIGurmILE0ba
	 fPBfpaFRHrx3yjVWaHQfG6OBF0/U1sR59R64LDjC8hE8SjHU264KnZVCPqd+AVf3uj
	 jPqzn9W8eMdgpUu3MSViEJuSkJM0sEVAUBnstAtpdFaxJbnWl53XRm2/pOG9W7gPzb
	 zkUTvU49LqBiA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 50CF77E7DC
	for <linux-rdma@vger.kernel.org>; Sun, 23 Nov 2025 19:36:49 +0000 (UTC)
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
Subject: [Build #31516380] armhf build of rdma-core 61.0~202511231620+git89fecd94~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176392660932.791410.17501627878452132658.launchpad@buildd-manager.lp.internal>
Date: Sun, 23 Nov 2025 19:36:49 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 53f8bb151f6959bf272a8408df0d6f91270c56e6


 * Source Package: rdma-core
 * Version: 61.0~202511231620+git89fecd94~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31516380/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
511231620+git89fecd94~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-033
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511231620+git89fecd94~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
516380

You are receiving this email because you created this version of this
package.


