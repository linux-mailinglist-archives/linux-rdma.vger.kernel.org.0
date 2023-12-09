Return-Path: <linux-rdma+bounces-338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7F80B5EC
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Dec 2023 19:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852441C20752
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Dec 2023 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968B1775E;
	Sat,  9 Dec 2023 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="mbb+vT9f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07FB11F
	for <linux-rdma@vger.kernel.org>; Sat,  9 Dec 2023 10:46:33 -0800 (PST)
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id A56E43F470
	for <linux-rdma@vger.kernel.org>; Sat,  9 Dec 2023 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1702147589;
	bh=l0FIR6C63/AiYW0SY95XGYJ597cPFLrC+X9ZzAWoMpo=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=mbb+vT9f6vSRGDYL9MsDbkNu5JBRs8MV1Ne8EhB3/MT4CX51oJ/BXIu2eSXUrThLQ
	 +iXc86sKx8uoyZuxpUDoC0vCq83NU+gJrFMc9ltPJkL1rY+AOhfqX9BvLTWGcCLrBG
	 Ud7cP/NKl/etvRgXkqBxI6WXW+zwc5O8xoS9N9NOibB8txadHaNbsft4QWzbiwLgkj
	 mtCiNMMoYjRYjGDH9kn0YN4PNaUHFwv1C2VMQi8l8OfftlZ8etJmIN7Yc8tbvPpEp1
	 t6DY9Jr5R3nug81LtW9nEBCRNqJil5pVECgtENUsre7jRI83Rcgl6JuC37YdmdU9TN
	 Z6fS+clZ3/j6g==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id B4BDF7EBC7
	for <linux-rdma@vger.kernel.org>; Sat,  9 Dec 2023 18:46:28 +0000 (UTC)
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
Subject: [recipe build #3647832] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170214758870.616799.15201648439698222561.launchpad@juju-98d295-prod-launchpad-15>
Date: Sat, 09 Dec 2023 18:46:28 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 03e611d405ee1e636dbca0d305cbcc417369185c

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 1 minute
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3647832/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-041

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3647832
Your team Linux RDMA is the requester of the build.


