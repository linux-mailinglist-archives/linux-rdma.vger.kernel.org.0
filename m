Return-Path: <linux-rdma+bounces-3902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37D934DAD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 15:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014BD1C229DD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7111DFC7;
	Thu, 18 Jul 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="ESqn3Sgd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D613C9DC
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jul 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307761; cv=none; b=OXlQLWnR5cK9ignChs0NrPOmRIbhUdw77K5i1lslphd3jgKix0xwOBWPSeWvqCwbtB4SAnwD6186PTbiCV+AdGJcOpehc3EuC5zdnwoUsgJMqS6mge1LmiEowCmCS0vBm/LcrbiTm9QwDSIBcQK3Lt8L78XMgCcDWkMgtwzMnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307761; c=relaxed/simple;
	bh=lxZP2LLDaJoIQcTL5p/cgBIg+tySm9NlI6M+hfc6xEA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=kx1vLsdZidAp4VSqounwqhC6jv+PWCoSP9UA8P08PWQ9389dZ/Zrx4T5zLf6Quj9eKjxZpu8mjG4GERQxAlVZaZ4DszB5Uc8KH04I4TgsFeZfYXCPon9Pb4Jr53K6KpJQ1LFOq0XC+9e7Z6/gaLEez6uQjJIYhmqtma2krJaRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=ESqn3Sgd; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 34B5A3F060
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jul 2024 13:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1721307745;
	bh=lxZP2LLDaJoIQcTL5p/cgBIg+tySm9NlI6M+hfc6xEA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=ESqn3SgdZmP4SMcYSZU1imi0Cwiq8R7ZcIGOjO6/E+lF4BQwsTFzRjliNwdKiME/O
	 sG9ar6Y/0IzDBHB6g3V0zcF2xEN4LpKDIuSpPatBHnnNoxYK3NoCFe0mu6H7RDV7E/
	 3xirzz+oRbSRMRzjwDxviJrxy/OIVin4wWXeLrjNLIQnu2ukxowjHz+lSZdyHqDQbh
	 IZJVEkjibsHPkHPmd4/r0+G7ZENad2FOPA5ZfgDc0q8/OAmgS3zyiXx8Y+nBPhi9SV
	 wqGsQsbWRX3Y5jC2t7A9Rr18ox2IKNM8+wGgdOlY+U9lGkRfBXkt5skJHG6nF1nCPD
	 NhGWiUvl+n6kQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 251C27E252
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jul 2024 13:02:25 +0000 (UTC)
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
Subject: [recipe build #3757849] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <172130774512.1591207.10158933938292764685.launchpad@buildd-manager.lp.internal>
Date: Thu, 18 Jul 2024 13:02:25 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 6b5bcf22a7fc7e281377070ebfa7edb7f5956d2f

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3757849/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-103

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3757849
Your team Linux RDMA is the requester of the build.


