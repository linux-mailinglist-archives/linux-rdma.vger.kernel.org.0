Return-Path: <linux-rdma+bounces-1712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D014D893F7A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5211C212E7
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C247A57;
	Mon,  1 Apr 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="aaWf06hS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772A1DFFC
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988224; cv=none; b=rUGcnB4u3Zpxbwe1QMy//HffX2Jolr2GQWn8kwVbG9PQ+GbTvzRUQ8Isw8VWqlkUmozMaFIouiqfMxwLd24lHEzBq5HFYr56tG4Qw30QB38NKm0uxzzrNXfTNqDSrHkt71l33v0t2F1Ry4wScafsju6QH4xU1EN7i75DPfg2h4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988224; c=relaxed/simple;
	bh=Y+0WbgWgO+zS3wMGwwNT5ovxIf+PV0j4QOhPEIGv95o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=b67S67JNAXGqzIf1VXCRtpVakVAEwoIqoeXdA4K5jDV3l+ufvKFAF7u0YB6iQKqPUGHQNyWHM0AvEbxf9l47WWxnK/J1uurijE1AcSQIQhCgl32cw3+H/gkxW6CZDwrtjx2ADlZ5aFafJJkY2Px9pl6p7e52YnYrGrZyufkt/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=aaWf06hS; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 7FF5A41FFB
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1711987882;
	bh=Y+0WbgWgO+zS3wMGwwNT5ovxIf+PV0j4QOhPEIGv95o=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=aaWf06hSYErV2uPRWS+SRQ81t+JyhNWQ+rmStzQ9G3nvlnf15ZKgk9oh1ZlnnOKug
	 cXWtd+7dmqLiuI3KE+wvJ2oIycFDtd2l7ELqA99GIDudUXzv+8GkR/pESyL7Lp7CnL
	 rCUaP73LrmZ62s74T0jbdvy0tnnGStWuVD4LxcUt9wCsOHh8KgiTif0K+VUztAPXEp
	 Ql6YSyAK09rkR2Ijcye8ofnk3vUxe+vfnMUNWwoxWRfvgKVrxTzIocrs1spOe2ECFn
	 zKb67Zn7nlmtyv37dwJb3QIzceuy4RIr6zm1cOHES5YYGqds8sRbclT+GJCCI8TVBQ
	 eYsYz3QLJNUeA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 57F427E246
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 16:11:22 +0000 (UTC)
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
Subject: [recipe build #3705706] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171198788234.701.2080673159152959649.launchpad@juju-98d295-prod-launchpad-15>
Date: Mon, 01 Apr 2024 16:11:22 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 35a1c280678a56b6abc98fd5060aa19f26219574

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3705706/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-105

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3705706
Your team Linux RDMA is the requester of the build.


