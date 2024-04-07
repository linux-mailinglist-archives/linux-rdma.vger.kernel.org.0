Return-Path: <linux-rdma+bounces-1815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A66589B04B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 12:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435A5282567
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC417550;
	Sun,  7 Apr 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="g6rX2QNV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA222325
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484344; cv=none; b=jpQBfr6ctMdAWoAEB1DyGb82WITXkYNPg7tRnxmqo12BcZsE+ac79AcRrBEFSmtgSot4TIt917ZI8fe9WGxS9yr5Rn7A9jS6aa2l9IDm412byg99BZ239ioaBr7gnlNI8m4+C3ljCkC0jbk3V8sY02QPUXJvPx+IEXEP4KQy6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484344; c=relaxed/simple;
	bh=SEJTUDDBKndC+xkDEIoaFMggXeodEaB8Zti+thxlED8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=HZIqsHJhB/hYkUj7pb4tvGSK+x17uzGm9fxfu+eK5nSNdJNZZrqLBKlIjw04dffW5K7QR+IxwZSJdVDZaZs5iJq1z2aDR8Amwb/0U0OfN61Un+Bqp5hUIfSvYwzzSHhxo+40lJoHDFDFK8WuHb10idNN+UWDC99dgGV4aFJEyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=g6rX2QNV; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id E53453F95E
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1712484334;
	bh=SEJTUDDBKndC+xkDEIoaFMggXeodEaB8Zti+thxlED8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=g6rX2QNV5KTnpebDVzVlMcKmd/shbxSvU3hQyXA8kRtsviVQBTIpBJ3+LWSTutrE7
	 RIv8EKR5E23v/DW6tA7dmkyJcQG5OQJ2z/TF544NJ+xTj3udIGwm5aDhiJFNJ2aUBP
	 LPYT2u7l2V4BccZoOEO9lLl+IGTm84JbadP91MhEGQaPUrOTdCAwvtCN+CR9tF8fpI
	 Fa3V2DrO0P7X5bkT5oZFwKeruRw0vklksz2fh4UUV4qwhRx6jb5rwIZBczTfdlglts
	 WCBg9fykdxTE2BI4FXbeNQg94DVKVRms4UhWqttFQgjpWKeLccS75ihWV9/DF+ZDSQ
	 FrP0WxWBee/mg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id D45B87E231
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 10:05:34 +0000 (UTC)
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
Subject: [Build #28030852] armhf build of rdma-core 52.0~202404070746+git8364b11f~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171248433485.1551173.12715115934695628719.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 07 Apr 2024 10:05:34 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: c160e221147476a30357cc69b5a39469609f4e6f


 * Source Package: rdma-core
 * Version: 52.0~202404070746+git8364b11f~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28030852/+files/buildlog_ubuntu-bionic-armhf.rdma-core_52.0~202=
404070746+git8364b11f~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-025
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202404070746+git8364b11f~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
030852

You are receiving this email because you created this version of this
package.


