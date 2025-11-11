Return-Path: <linux-rdma+bounces-14397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF320C4E6CD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E21188C324
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19262DC328;
	Tue, 11 Nov 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="UuCdLzmX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C652DBF73
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870658; cv=none; b=A673BBLsLrJVrEJSnS9fQEGOEGKqQSvyrT5WD+VL9rC41C3UZC4NWGtHQdADXPekQ62MjWohaz8UbazyLZMnxR8hT5PCmyxKp9PYFEUMElYNNzP7ER0umQg4GBqnhx4Oo14e7CPZmb6feD5CYUavg5yLmZTKi5OuAhwyQL97VlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870658; c=relaxed/simple;
	bh=Xvq3wZo1smlBYTtvekcQwQZ3rkKvzwPjv+Q4BFWvilg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=VwhMrV3SEWQVC76D2GYz9I8mqB9RVpuN06wqOYUWMeoiG2yylgdQ6oNAxpXSlaypRd8ILEcSCQtrUfyqH0GIBHYpmQvu1mn0RnHx193idW+i4+nTqwPdNjW/utCjGj4Iy9OfMM8lenvkHkZuOMSjmbSJ4M7ET4IISjXvlst9fo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=UuCdLzmX; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id CEB4C3F26B
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762870629;
	bh=Xvq3wZo1smlBYTtvekcQwQZ3rkKvzwPjv+Q4BFWvilg=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=UuCdLzmXkymjF02KCPiIDaWsIXsaKX1BBc2KapV0Z8BR+YOqAtDVMnZ6rzYK4W0jM
	 yre3YOw75DDgQ7c/FVhF2P9nMaH0OzaY+CuUHilzIvHzSZcSoI1OVhjdihP6n66Me3
	 9MEtnFpsa58fQEiMg3h+Du3/hHPj8k8jnkZc/Hh9PZUqK9xZ5w6jHG5qVYqwrEyBNs
	 zKhECIgSzEN4gz8qA6hdo1rXr5ZCnUkjnKjAk3l72V4dxZ9y+1m0Z7+qUcEwuHgTKC
	 OgBBbJQk6ImEFRN2tk0i69w6Hp50dhB7sTbN6+Vnzn1bdSMRCPHdIkd1Quv/kkDbCE
	 o0SjE8xGillmA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id AB0227EA42
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 14:17:09 +0000 (UTC)
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
Subject: [Build #31479958] armhf build of rdma-core 61.0~202511110826+git36b662f3~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176287062969.1218157.11145134768265381420.launchpad@buildd-manager.lp.internal>
Date: Tue, 11 Nov 2025 14:17:09 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f0664914dad2be0b8d36da805d04baa0990d4f02


 * Source Package: rdma-core
 * Version: 61.0~202511110826+git36b662f3~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31479958/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
511110826+git36b662f3~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-056
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511110826+git36b662f3~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
479958

You are receiving this email because you created this version of this
package.


