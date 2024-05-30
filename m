Return-Path: <linux-rdma+bounces-2690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29398D4B68
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E327B1C229D1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF71C68B4;
	Thu, 30 May 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Ae+C8SWW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906516F0C1
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071644; cv=none; b=TJEPDuV2Tlo1Y7L6JdlD6WA1Y//eGrykyJPLHq3wLuTHBZbk9xOGvV/hI9BJkuqwA9wO8k0sn0HshaYNCldxe+2DTMOugbZ0gmMVoYeWTRHltn0Y1koIt8ZydqQFXbl4VrllMkFY1eI6exENiiyUcWppwP1pyejACQnjjkgcq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071644; c=relaxed/simple;
	bh=qjOFavhI0Fl2cmfx15kaVSt1u65po90xzfLfk13Sg/o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=r5ivK7O5BDC94Xfea1EXG2joZUDOvv7hmfX4uTaNFFJjG/EBI5xJLnbzinNXtnSxUqbFh/YI0KehIwZt5teX/KSDqF723ooebWE5o5772MzbFVh3OJaDytXJMNhrfM0NrcXmUA69hS4J+ysoTVlfA34K/aYoKSQqN8qe562pQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Ae+C8SWW; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 765B33FBEE
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1717071233;
	bh=qjOFavhI0Fl2cmfx15kaVSt1u65po90xzfLfk13Sg/o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Ae+C8SWW/J2aey7SsTPIsdQe2E0m61PMSK0lcspjNFjlBZAnB0hY1sOiRJF0PMQdQ
	 BDoM8HmZBJ78OThLcMr31vBF4E0Iw7KCVMKV+4rtNBMz/FHSEjKci6UNLbGyuVWO3Z
	 to+yA4um4dt1Wb8M+/26PT+WYW/GgAD2CiDr8kB06pIWkK2oPYdq5jCvjJRFUE6qAN
	 Scp46h7lfF9WmXAc3BwDFV/VI3WhB6EWrZTpwT6v0CMVGMN0O+zi/4LHJ2IEn/GcFo
	 BpUpxkmE2lrnN0kucvyAOUvFb8Wk7rXf79hfXTaRECRep4VnsWhNn0Sk6JeAeiQxEI
	 oF/9/zQk+WWJA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 68AC77E230
	for <linux-rdma@vger.kernel.org>; Thu, 30 May 2024 12:13:53 +0000 (UTC)
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
Subject: [Build #28502965] armhf build of rdma-core 53.0~202405300901+gitf3f84e5b~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171707123342.981272.14306457697550709477.launchpad@buildd-manager.lp.internal>
Date: Thu, 30 May 2024 12:13:53 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="a60fb269857abd7169036a2da5afd37a6a1d41e8"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 7de66dc756c3b0e4ab155935d6afc4e30eb0de68


 * Source Package: rdma-core
 * Version: 53.0~202405300901+gitf3f84e5b~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28502965/+files/buildlog_ubuntu-focal-armhf.rdma-core_53.0~2024=
05300901+gitf3f84e5b~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-055
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202405300901+gitf3f84e5b~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
502965

You are receiving this email because you created this version of this
package.


