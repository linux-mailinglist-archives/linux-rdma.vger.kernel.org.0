Return-Path: <linux-rdma+bounces-1364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BBF87775F
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 15:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB0D1C21202
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574712D79D;
	Sun, 10 Mar 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="vIBtjWFP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8C1E485
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082031; cv=none; b=ml4zRtJUBZFpYGB6eJbvdxNMsZTpL/D2/ciikqgIg5XB5HH9muHWlZz1U1PwgcAOFvPTIZX3PIp1CgPZKl9+LJBM2o9XoECH/eH1BZZR204JBWRM1XHCcHV4m4PFB+GwicR4BcXdefr4K9T69WKPxjlR7qQ5Z/0gmovQIHHKmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082031; c=relaxed/simple;
	bh=VQ7l+p51xTP5tmxBdEbYU0ohw0ypktclQfEZB5xXKyo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=u2IubWY/IE27WMGwj7nLVbasyiela5u3OZUxSh7mv6nkeA0uhy8CLYX0IvYy3bsUcil2aEDitTrdzprEDS5aM9mIpqIr47IJfxHbYEPy+dgFyHByNoDpudK7uCdNb6xKcPpd2T5hXELwcrooCCmn/R2otKFvZfggLIIttgkUNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=vIBtjWFP; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 06F1C3F164
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710082021;
	bh=VQ7l+p51xTP5tmxBdEbYU0ohw0ypktclQfEZB5xXKyo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=vIBtjWFP30aX0/zd0oCyeGWtN1qZlUiL0eco3Tr+Y/XUgHe5PdhunVKrQ7cYJNPUq
	 DoUKSFfQsqXrnANTPNwxfWak4fG5TbxMNaqu8RW2e9BvAP/UNgCXQcP1RIrzFmqZkB
	 /zdyX6lBFJoi6xmxQGMUXdAYZ1xEHdzfsSw0ou6oENn8KYrSgQuQhgLC09Pj+L201v
	 12P+suFEwVhbPpLNyiWzoG/dsl6AMEYc3RttKodsAtu+efnk3IX9Fis90OOvKx+8Xu
	 LYGE9qm3OcqspPgyj/MKhZWdM7YMOYkcnnGcwXIvEXH4ceE0JAxlE8bnX/R+voOobe
	 DH6uysozyGgOQ==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 61A047EBCF
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:47:00 +0000 (UTC)
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
Subject: [recipe build #3695446] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171008202035.1614976.6717040009382595350.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 10 Mar 2024 14:47:00 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e4955e3d556e61e2eb54acf7a827d17e9e46822"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d8f9bbfca8b9f7b004e2eccd49c4648cf0a7050e

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3695446/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-005

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3695446
Your team Linux RDMA is the requester of the build.


