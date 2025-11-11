Return-Path: <linux-rdma+bounces-14399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF5C4E776
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A910E4F50E6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D4307AC6;
	Tue, 11 Nov 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="gig7I6LS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098A32D7CC
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870814; cv=none; b=SBUTJOCXciws9kEZAwYaBJLJWzrtBI6ERJJEaMguwgHZM3bmBuYy1FCW7FC1Q+RUaXc64Enk1FOV6HdCyNqdQ2nHqsxJCmAUimnLjHUFW12qwdqoPdoVUAgLz/QzA5Mi+kRYm+o9hYWX6mUlsi0yH8WNvyrKAf6Y7PbtA6fztY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870814; c=relaxed/simple;
	bh=xNI8eaNSS4CvLOZ0lDFwJtondiJ6W4ES5+t9oVz/IxI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=XKvjQj/iiPh+V4X6k8T3B12LnMBNXQOS9HBBXpT0P+yXoUycHNRhraV3xXLJ+XgWRcFb1AvDaL6TDFp8cqtEn8dWyHPhMaj/4QPc3QxQmfbwN1xQiX/jpS4mJ+i16pnNSJ/tlckpIhv8K+r7U4+3Y47+eB/dVjSX4GJ3LRiamVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=gig7I6LS; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 4E2D83F26B
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762870734;
	bh=xNI8eaNSS4CvLOZ0lDFwJtondiJ6W4ES5+t9oVz/IxI=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=gig7I6LSE/qMg+zg0AsBVTTsL8UOJNwpouYk230VxWjq5HWhBz6YcXp+f5A0Gw4et
	 WQRqW9gBeGot7tNMlqfLRiIH51gN8AILYvcdov48pOpv89MKAM01N7ZSUfEuAWL8Zy
	 bMF8TVhxKWYsmq5Ypc35jAbD5tvoNUzQk1crF+5GSN8k2CT9gdAnyKCBWjd4pVtTpy
	 Mp0cacgwWXBiCb/QT8kpVjXrAG7rqTNRpdElap81SM0pO42k6sMEcs1kx2Bv0B9PMu
	 FnLdIhtStf5NCZjW/O/xjUT9+no3LPEsq7N0h+EZG2QRVwgXyGl1VoALRKf6A7Z4ya
	 cZP6h43qwvPtQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 38B7A7EA42
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 14:18:54 +0000 (UTC)
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
Subject: [Build #31479964] armhf build of rdma-core 61.0~202511110826+git36b662f3~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176287073421.1218157.708365777549268333.launchpad@buildd-manager.lp.internal>
Date: Tue, 11 Nov 2025 14:18:54 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 26c662a3a1fdae3057f9a5d7dd0e524d44f7d7de


 * Source Package: rdma-core
 * Version: 61.0~202511110826+git36b662f3~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31479964/+files/buildlog_ubuntu-focal-armhf.rdma-core_61.0~2025=
11110826+git36b662f3~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-105
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511110826+git36b662f3~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
479964

You are receiving this email because you created this version of this
package.


