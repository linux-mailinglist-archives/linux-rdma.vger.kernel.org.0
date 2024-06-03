Return-Path: <linux-rdma+bounces-2781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D88D8478
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1D71C22288
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DC12DD9E;
	Mon,  3 Jun 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Ntqww4TR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C711E4A2
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422948; cv=none; b=BCWOnNue4O/6ds7gtg3ozrlfwUMJ5vci0oSl+qVdBolO5Ngd9LP9haoWRLD9drpEDgxg/mTfudw7MGe7cERX2m2NIiIqoCMLgT+exX1AgkHXuVrMdryMxc6zNNDbIhp5DUHzJrwwcTTjPtA6e+9RbvrQqK/RVUkm2qGWpbVCtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422948; c=relaxed/simple;
	bh=titmP6jWkbcA3y3dGZ+J6HdzPJZ8Ce+7x6qzQIrb+kw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=a80kN76VvML9nxjSdj7bT7DJMCo+6Q56IkiwTRyfYwlfaVjhQRzaMBV9cMThLEhP53FJvt25tdmqS6uJ9ZKO8YH9dFBqRWHMHza9t6x4G+OzV8YFVMaNXIrMKnYSvWixIaoNoScAkM6Sjc2xy+Id4dKFK2Ewdq5xKHHICcneH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Ntqww4TR; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 82EDD41EF0
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717422945;
	bh=titmP6jWkbcA3y3dGZ+J6HdzPJZ8Ce+7x6qzQIrb+kw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Ntqww4TRezz2msJyzwskAKbXen789zsgO7PneDGE2TW2xSBwm75U4UucNjzKZmY+6
	 vHHjBflITjw6rJSo/yAR9AD3dET9HHhZ6+nX2XM720zPscm9klR7meJnNB27Udxyiy
	 tdedTavAg09zKaxkXM5rx/2ujxacp601o45mxuJZdEkVQkKRPv7sMbtoVNennGAw2z
	 5tihJW3YOkBINjQyqdA4X7wPohOaXx3BNhOd30LM2w3bvflNCaw/6qOgu8KzgFjqqH
	 OLmk3g5SYWewKsf96yiRXgEe7vkiB3uOXhcbMIv96+eQWq/3CpQWDmJNVy6kXHGF8R
	 Dpcrv02mN0DTw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 76BE97E230
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 13:55:45 +0000 (UTC)
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
Subject: [Build #28512739] armhf build of rdma-core 53.0~202406031027+git4b0c93a6~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171742294548.3361349.7338483739411581143.launchpad@buildd-manager.lp.internal>
Date: Mon, 03 Jun 2024 13:55:45 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4d1350fd3710dfe10d207fa9961e224cc481dca3"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5920e990f805631662ef8944af502064db2beb0e


 * Source Package: rdma-core
 * Version: 53.0~202406031027+git4b0c93a6~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 7 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28512739/+files/buildlog_ubuntu-bionic-armhf.rdma-core_53.0~202=
406031027+git4b0c93a6~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-067
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406031027+git4b0c93a6~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
512739

You are receiving this email because you created this version of this
package.


