Return-Path: <linux-rdma+bounces-425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0A813A55
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Dec 2023 19:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07F7B20DCA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Dec 2023 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9768B92;
	Thu, 14 Dec 2023 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="JGbj60Kz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECF010E
	for <linux-rdma@vger.kernel.org>; Thu, 14 Dec 2023 10:49:35 -0800 (PST)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id A72BC41C1F
	for <linux-rdma@vger.kernel.org>; Thu, 14 Dec 2023 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1702579773;
	bh=e5X7YIDhmfLDsO+O07DrkTP57Ut0JZ44oglte3lSqqc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=JGbj60Kzv+ZHF4HaP/gNzSoolJ0OsycL0hJ2QsX3a0W6mlu91oGDqBeB/67KyrZcC
	 EJtLzUmHwT+X6Ik2tUfRPKlhi4AFluEWjOKChKPAwVpN+ExwYku4c6pE7HICZkjFzg
	 mFTuwUt5vgVp4m6C6KoiLillezvY67M/vi3L6LQOqY8a+Xnyq5eOm2HARI0KkzyGR+
	 uMllRbNWbyRSC1V9zSzdLPBF0FgOB+1GBPQLyhVuIUeAuegz54LZGOoN9GABRuQg7E
	 pMjUOM5NbhqUaC92TN8ar7AKzkRXAcE2ZtYDpBAyhuzt4N8WvHPFzq5ARCJMKK0AG7
	 gfvsArKI8tP3A==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 91E497EBC7
	for <linux-rdma@vger.kernel.org>; Thu, 14 Dec 2023 18:49:33 +0000 (UTC)
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
Subject: [recipe build #3650231] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170257977355.616799.13396947593557756092.launchpad@juju-98d295-prod-launchpad-15>
Date: Thu, 14 Dec 2023 18:49:33 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: dab710ab77db9725b182cacbca395d89a1144c82

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3650231/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-061

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3650231
Your team Linux RDMA is the requester of the build.


