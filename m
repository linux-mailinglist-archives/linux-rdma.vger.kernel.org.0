Return-Path: <linux-rdma+bounces-1948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BF8A5DD1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 00:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED7B1F220EE
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Apr 2024 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6015749B;
	Mon, 15 Apr 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="IbQJwHJj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B3156225
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221358; cv=none; b=EvW7X3wgNjIwixo96c+4ilTSPYqTAl6EebZ5lDWRCHy+FAd7tyoH3oQtUMFkN+2GKC2G72P5sqC5N+mEfyWroRHZJw2PmxEXhT0Wu9YRIPtvWHg4BYFyU8i3K1k94tajsBVlmCdUW89V7z9JOm+gEgp1TIl686g+8TSNpy6nYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221358; c=relaxed/simple;
	bh=JAVXVY3LgmuiY7ndiYyctILHjwZanJfGhpghRuqM9Mc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=SVVwu9B1QllbeRKCLTCIihh8KfFhshyEDuQyag+CI7gk9/vGvFWI79oJBxgRnPAjL59s1iKrBFWh5hE901durRFm3KPqgbufX/yuT3JqDQHyawx+j1srfaUXaX4UHyJjB0iK+2aWpeUjgJ9deNul4YLCECIrIdtFkYQQURrYsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=IbQJwHJj; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 96AE04083D
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1713220827;
	bh=JAVXVY3LgmuiY7ndiYyctILHjwZanJfGhpghRuqM9Mc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=IbQJwHJjZ5XD+nESNROjYmV/EXUPSskOjPU3SkXsOmb+tVRGeaL9hxWS51k/6nOtF
	 b/h0D1j0VVtK5ysTW7+7E3gnii+A2XnxVNhOTCaksBMlp4oWeuqpAQK+ldTIJ89gIO
	 fjfW4Ghf7Frz80BN1KpzeZhEKAPdCOGAhz9auYuHUMRdFRXWGlEntlX0MkrF7IxhJ+
	 EsmQunk7UYsf6phLibkUkYba8R7H2eXNc73LwbhuwZ1/sZroGQTiC+fSQDXEghIQe7
	 fA2zvnIatE7C6WxARp7rtZ9g4l0DMjStCY8ZGdSmAQ5qpg+xsQ+YVdklJsR8EpLztz
	 aJDULvPPYhS7w==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 05F6D7E243
	for <linux-rdma@vger.kernel.org>; Mon, 15 Apr 2024 22:40:27 +0000 (UTC)
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
Subject: [Build #28097067] armhf build of rdma-core 52.0~202404151807+git3be56612~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171322082698.3971088.6807757308587547262.launchpad@juju-98d295-prod-launchpad-15>
Date: Mon, 15 Apr 2024 22:40:26 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="67d34a19aaa1df7be4dd8bf498cbc5bbd785067b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f3d7275119140ab45bff7cd9f87c17db3f6df84b


 * Source Package: rdma-core
 * Version: 52.0~202404151807+git3be56612~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28097067/+files/buildlog_ubuntu-focal-armhf.rdma-core_52.0~2024=
04151807+git3be56612~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos01-arm64-003
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202404151807+git3be56612~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
097067

You are receiving this email because you created this version of this
package.


