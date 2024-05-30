Return-Path: <linux-rdma+bounces-2689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595828D4B5D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109A728224A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65D318509F;
	Thu, 30 May 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="suCf5AMU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566F14AD3B
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071357; cv=none; b=X8D1KZs8uzsBxdCerKgIt3pjslJG0agGgk0onFdoAgsAXGGoT2ylsyxTUNFdRK1lRHslnFxcozAGODL6apOddiRmKkTNFWPVeXxSrZ5cQA4LZuCPnMaXRF6IbQeUbnTqBv6s39618ZBWU6Z6I0sSodN3DISrpndgb6OM2uix6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071357; c=relaxed/simple;
	bh=ctX6KTKLYjD7RN/MZ+ofnFgZqu43E5TIE+HGkMyZeJA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=JYJRImTQPqa7ooIFKujXT01F95DNaZGp2dXENaFuubUGssVac9ONV5V6EnhvkZl/TFhM9DOaK2ASgSyhW14i+16N4kiUVPcNZSk5DAqEI3WRN2B5vXUvVSpyPvNp0k+wrU4d79Eer/8E7nOijpB+v6od2zcirlYE9kwZqXjPOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=suCf5AMU; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id CF9CC3FC09
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717071353;
	bh=ctX6KTKLYjD7RN/MZ+ofnFgZqu43E5TIE+HGkMyZeJA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=suCf5AMUjaHUoh9W3pf3B3dzcgqSi8r6uULtHoDi4XhyBbevt2/8y122wWmnHpXdW
	 5TIDei+lRo2/MRjQNS9beVe0BuEK734U4M8lSIYIh7VU+w/sEB1gfx44VpQl0chzRV
	 ihgpPWoeYlWuQ53ss2Vh43bajhCpa8A9lofDBclvGvn5Ln/Zfnk/MqK26i9BMaLoxG
	 Ekz1ePjOnUwBrXNnuClU/MNCZkrOTTC6WTAsNpqBCqDxd8cFek4ChP9spZWmR/ifCW
	 3wCHHd+s6++yZNJIT9bsRTrJk7D/2cef5m3QCcRlNDsOz18Ug7IOob+06W3FRDzJqt
	 ynoxj1iRowa9w==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id BB1777E230
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:15:53 +0000 (UTC)
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
Subject: [Build #28502971] armhf build of rdma-core 53.0~202405300901+gitf3f84e5b~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171707135372.981272.8198601705038998702.launchpad@buildd-manager.lp.internal>
Date: Thu, 30 May 2024 12:15:53 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="a60fb269857abd7169036a2da5afd37a6a1d41e8"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: b33c9c067d76ef74f99d761aa8c95665a732bdd8


 * Source Package: rdma-core
 * Version: 53.0~202405300901+gitf3f84e5b~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 7 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28502971/+files/buildlog_ubuntu-bionic-armhf.rdma-core_53.0~202=
405300901+gitf3f84e5b~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-004
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202405300901+gitf3f84e5b~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
502971

You are receiving this email because you created this version of this
package.


