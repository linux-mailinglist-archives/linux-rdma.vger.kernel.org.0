Return-Path: <linux-rdma+bounces-4164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458E944D06
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF98B25755
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 13:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD891A01DD;
	Thu,  1 Aug 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="KnDG4xD9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766D19F475
	for <linux-rdma@vger.kernel.org>; Thu,  1 Aug 2024 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518343; cv=none; b=C2sle7dFMSUj4plFyzk+GIc+antLEwrKkGk6FehndRTN3NrrYlmUfbLB+XhL0AFaR1lsEMCTAsae9FBIa92jTTa2gj/xxrbf4TStu3JMK4BRbXuh+OoJm+OcE8Vg/I5m3UMI+RTTq+mA4TKxNbZvl/8/Csu+7eb1jtsWIYSioFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518343; c=relaxed/simple;
	bh=AWKfziUtr8PWCPPMrh4J3tK7JDtpa5F0jtftaeA5Ve4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=YFabYh1ygp5tcofXAABQ4k2BdxRg4IN7RS1rZDvY1DqZjbE/I9IA0chvN+zYrfyC4aeKmGjGEnzfMHd/PMebOQSiS3WchmZj/YrlGg3uxkp5As0l+Xy/N7dBmdO0Z6Ae4BINw9ZXCUDFBXs1Hhq1E4IJ0K/ERYcamDNDRMbnUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=KnDG4xD9; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4E04740E10
	for <linux-rdma@vger.kernel.org>; Thu,  1 Aug 2024 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1722518333;
	bh=AWKfziUtr8PWCPPMrh4J3tK7JDtpa5F0jtftaeA5Ve4=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=KnDG4xD9FLQuDVhzUCxH6c3tZLQxy/Y5poce2DQS1vGsyoF4DiTnGWPbMSuqeWQYx
	 jM3daUPu/AXCWODIcA/s1Hk+2M2DnJ3kvbrv6g6dRPs5Ayy3TsJgs4ZkP63nn+uRwn
	 /nU/nXVM1gTE32TI5lSREFsATu9u5ukTZamzt1MKuc/+huQM7xbrEJZydKKSUEFum1
	 JC3zcu5rI2j/dHx0Kzb+5KYkgZJpLmh15e6AvzyYZiaR6wv0mb78A8w6IY3SdbwzQg
	 WcpW/yTnWnB7xf0iGVVeCt0QSJApYG2WR5Xqix1Syo1DLk6bgIMkizOkyso9TAeh7f
	 YkAoxjHQMnCuw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 2D8067ED16
	for <linux-rdma@vger.kernel.org>; Thu,  1 Aug 2024 13:18:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Message-Rationale: Requester @linux-rdma
X-Launchpad-Message-For: linux-rdma
X-Launchpad-Notification-Type: recipe-build-status
X-Launchpad-Archive: ~linux-rdma/ubuntu/rdma-core-daily
X-Launchpad-Build-State: MANUALDEPWAIT
To: Linux RDMA <linux-rdma@vger.kernel.org>
From: noreply@launchpad.net
Subject: [recipe build #3765325] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172251833312.2860173.13481165621673124932.launchpad@buildd-manager.lp.internal>
Date: Thu, 01 Aug 2024 13:18:53 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e3ace39cea497a5ecb83e8fb6dd8e7e169f02939"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: daf6338bb9bd22c8d1fd1ca4aa29832dd841c40a

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3765325/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-019

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3765325
Your team Linux RDMA is the requester of the build.


