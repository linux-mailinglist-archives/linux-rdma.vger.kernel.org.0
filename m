Return-Path: <linux-rdma+bounces-14324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02204C429AB
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507B74E06C5
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF32E8E0C;
	Sat,  8 Nov 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ShMdOALE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE319005E
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762591237; cv=none; b=VjitnPSY53sx5m7Ny9YTbH1L+jICWkEVRLsuIUDDcRGNqcnH3ZYFoShSwFb95y94iNeVNfFhVwmi8C4Oa64kdyk/qPgvYCxm5M0KnyC93cGY/MSE3UzvpECABd+cs/2CyEBCQBScRGdVQhI8by2kuRCI0NZpEdvorJKG9bVzuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762591237; c=relaxed/simple;
	bh=FCI0ALvfskfdKDc5VaifL64YCyypioAsEydTv8Owi5M=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=YRGQJZo51vH8opD69NYapd4mcYUWXQJfHnKYrbsBwfKSO9Hiuqyg4z6JARkUfEIc9RCcv8YJbVp7xr5bVxDydBwl5OLlVwTM2vgwLPENf735fZuC6Xc7v7/KOQBk9r7N94azRVdQ/Xb+hgo/HRk6ZJlW7nSGx6vodexx08MX2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ShMdOALE; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 59EC43F150
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762591232;
	bh=FCI0ALvfskfdKDc5VaifL64YCyypioAsEydTv8Owi5M=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ShMdOALE5xrVx5dDnrK8gT1fwXRMX0JqBBsLgaZNUzbg3cBomqG9OKDqlYLsFHqUS
	 F/jwdYL9bhiFsyvGrl9CTNE54uKjp/w7x1OCAMGyMlg4qYLO7/kQbkdiPKWK2qdnZe
	 fCsDVhp5mFzxuDFe1zSScrZXIEOoEPpVE6xcEtjDVEGUNCl7PmS8dVDJhdUSnhp8L+
	 LWenwQz1Cmxf1Gaydd+9yS/lesy94O9nsOH7LznKAd/VIt7h6ZuBdPGMvaxHA+Vh0y
	 Ub2CPoiD8lpz9CDitLP92P+K/FThT+ngha8W0bFxIGr03yDMZHp8O5prUe1+DBtYAF
	 bzPGBU6rAOhLg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 4B09E7F14C
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 08:40:32 +0000 (UTC)
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
Subject: [Build #31473524] armhf build of rdma-core 61.0~202511080232+gitc3d6991a~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176259123230.1218157.24218251374812287.launchpad@buildd-manager.lp.internal>
Date: Sat, 08 Nov 2025 08:40:32 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: de8eb5570930b114f774c1f1feb0c1e99ee5d7d9


 * Source Package: rdma-core
 * Version: 61.0~202511080232+gitc3d6991a~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 7 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31473524/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
511080232+gitc3d6991a~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-031
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511080232+gitc3d6991a~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
473524

You are receiving this email because you created this version of this
package.


