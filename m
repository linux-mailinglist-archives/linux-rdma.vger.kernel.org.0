Return-Path: <linux-rdma+bounces-1408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB44879D89
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 22:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80001B22BA9
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 21:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1F143733;
	Tue, 12 Mar 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="AhhmjaD9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAB142636
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279310; cv=none; b=qfRduedIahLpZi80mJycQfqzKWUdA/InbBbluiE0GsH4UgYmYgSrlSjS2mMISGsiEbqRZysWd7n6Npvo4cpNxCFOpahVLExV+NVBcD0TUImZYc3uxdzje3PjDMozVc+5nQUs2xOgqpVFEO9AKFRnw6iZdBQyibG4rMnBRQQ9nZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279310; c=relaxed/simple;
	bh=egjTciaXIo5h1NjjkYQ28Sw3P+91OlkP3zvljUOt+aw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=J3y/W8doB3i0Yq3fGx4lcehxnjfN7QTgavMw+vwOCP9vL2s//wzjZsmLejQofsP7eYKOErPyZJ+GW4ZL5EkxxYmjls9ju2q0WzJTNKb5epr8hS/Ewlz7VirA+YT/4AHT14vWfOPc51veaaAHnStwduDSA/GmBOUpuG8cTWiLA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=AhhmjaD9; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 76B98405BD
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710279305;
	bh=egjTciaXIo5h1NjjkYQ28Sw3P+91OlkP3zvljUOt+aw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=AhhmjaD9x2kyFMubeucGrSAuVV06A6AntF0hSUH+Rxtp94WGNVCUHxgDVPFk6dmuC
	 8qbwPhLej7PUCI0p7S7TPL6ZXZw3MXpWjrB8QO/wVxqk4lutbNBHDzi8mYHSaHRfKC
	 n9zbX+xz3JXyl2kopdQ2taxgeJkj3zY5rRmrrX9FLeajoW4ujP3fYDB6M1HS2wSdm0
	 X2SuefPiLeWiQaa2d0hX3znKNEYff87zLkW+xWJcAwoNCtGRPefMqi5dEEqikZPOjx
	 WS9RZ5F4NzMFWdDq6IVvZ2livnU+3QJDh89A1f8jebpY97Fgzd+tKm8nwQuZt/zARR
	 IEO2FwC9moTYA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 680997EBCF
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 21:35:05 +0000 (UTC)
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
Subject: [Build #27908487] armhf build of rdma-core 51.0~202403121118+gitf8845855~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171027930541.1939111.6176516323761636328.launchpad@juju-98d295-prod-launchpad-15>
Date: Tue, 12 Mar 2024 21:35:05 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e4955e3d556e61e2eb54acf7a827d17e9e46822"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 9f1f38cb2e6648d0660140a49eb19c6738ddea38


 * Source Package: rdma-core
 * Version: 51.0~202403121118+gitf8845855~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/27908487/+files/buildlog_ubuntu-bionic-armhf.rdma-core_51.0~202=
403121118+gitf8845855~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos01-arm64-034
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 51.0~202403121118+gitf8845855~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/27=
908487

You are receiving this email because you created this version of this
package.


