Return-Path: <linux-rdma+bounces-1776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2990897E22
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 06:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E323D1C21846
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 04:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C01CFB5;
	Thu,  4 Apr 2024 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="mvHFDtRh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9E1CD3D
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203326; cv=none; b=Ww8e3HzTJm6F492BV50XLsFuBFefF7PTLmCa+mONeGl0UHz1M7GxAO8KcNvrvr3U8Xd/zpe69TF3Ey+7Jnp+9gLRCp51EAkhi26z4pLpFLp/kePtknfVvB05da4gpqoz+/7R7lKD8aAEzTNOSFj9PzU7LdqRn+Q5ZWW52cceRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203326; c=relaxed/simple;
	bh=94Nvm1692n8wFfQTRka9H0mkZpI3a/qCS3OHUcYj+8I=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=pnZOYB6L4HutiXsbA2sjLW9WQpeXw0XHBJyewc9me9iwtvNRemqhEKookEcaBu4kgU5/KkhQtFDc+dWP0IwJUpsmanmeO797pd5imi4LBtzEuSR+YkIZLjNaOTaI48JgEOkG6MRlgRl3oac/QYowMwp7LLvo8nnfR/FqChULVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=mvHFDtRh; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id C4DED4D5AD
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 04:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1712203314;
	bh=94Nvm1692n8wFfQTRka9H0mkZpI3a/qCS3OHUcYj+8I=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=mvHFDtRhS8ABdIdoMmYN9waubT8YlHFwJIKFCOfIkfIQZCUF7rKih3zhYqEE6nCh0
	 toyCvtsWb65yzi+yVhUIMCikbnQ9AqvpxzS2MhIHaz7asGlN99Aew9u/PtQV2D5L72
	 XvyW6OeA9gxHBXqT8CX366YSwL1MGj2VkRtnn2FoijZdP3RJ+XCARXmf29J/2XT+A2
	 hJKiKZ66kCYNO9gFawL1M6N8colYQ4R5zE6pWs1iqrGKnrx/DQC70To0KJawVO8V1t
	 3E2HchFegGaVPABkLLEwcX5rvs+kBqh1isGsERJ3J7OPzB0pm8w+cfXsBmDggW3ZUW
	 UelkiSPFKATUA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 7CD397E5D0
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 04:01:43 +0000 (UTC)
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
Subject: [Build #28023176] armhf build of rdma-core 52.0~202404031838+git4b08a22a~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171220330348.701.16591450250535874606.launchpad@juju-98d295-prod-launchpad-15>
Date: Thu, 04 Apr 2024 04:01:43 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: ce9cdda97e0f2ff2d33b1a089f581cd6afc02dbc


 * Source Package: rdma-core
 * Version: 52.0~202404031838+git4b08a22a~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 8 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28023176/+files/buildlog_ubuntu-focal-armhf.rdma-core_52.0~2024=
04031838+git4b08a22a~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos01-arm64-030
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202404031838+git4b08a22a~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
023176

You are receiving this email because you created this version of this
package.


