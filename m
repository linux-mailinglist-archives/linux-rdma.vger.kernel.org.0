Return-Path: <linux-rdma+bounces-1365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188EA877760
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 15:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C8E1F21B03
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493533CD0;
	Sun, 10 Mar 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="FiNZ3eK/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0622324
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082431; cv=none; b=AbzQwUnRyaa1+X97NC0o3/ti+QF2iruuak6f34J+JDJZZXuQkBt3xGOqNIJeqYEBfCksq+WUn1stDmPpfsfSmQVHdLpU68WqXUULCfZbabuP9RsxJAhIg5k99CZboMmk5LOyhLed8p7Bf9YxWhl7tbZXR7J1kF+QGSzz3Nw1+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082431; c=relaxed/simple;
	bh=EaUZ51DZjqUR6KcPXG929LIZZ6GLk6Ry0Tff4HEj7xQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=NJP1xP5YXROaQXpBr9+b1nqZpf0JojUludJe4VwqWAbeXpIRkSyC3xfVvmZQUgdhoR4/eZ1ugW4YdUCu7bBfSACzIaXVnliJpJTMfuxFC7kORlmwUD8pl8XOi1d8qiRtdxsFC8qq0qh3xK0ot/tmvXK5dytpJkQGg2oD/rhfir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=FiNZ3eK/; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 71C823F64B
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710082422;
	bh=EaUZ51DZjqUR6KcPXG929LIZZ6GLk6Ry0Tff4HEj7xQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=FiNZ3eK/9q/PFESFyDaQQckebwyIduTr8gg7YGW5Wu7jk5TP6CN7BySELYbM5kGv4
	 nGtnLNz4Py7EviAUNTkOOtiKwZYPakDOniUEMzAoiNCz2rRRtYn5A6k1lcpdztEVWK
	 tqZcLfPfNL0ab0KwLuI0KKQxUz9Fvq8s620Xw7EQA58mPH1S+r9SRDjj5dKK9lWHU3
	 xSKWZY0BQfe3plhYgxbzfR4JfhtJ/3M6xPHSHd1q9bF6I1jPxI76k4lZ/Uxdh54JT+
	 7DkgoIjz6a5/X57Qc/0kmxPs6UAPHe6pOUTMvNWwg8lyMmbvFJqwi+BkPJZRKeVGZJ
	 q6QP9jQkJ+T3g==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 5D7317EBCF
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 14:53:42 +0000 (UTC)
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
Subject: [Build #27898045] armhf build of rdma-core 51.0~202403101259+git710aa556~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171008242236.1614976.11065915848964355056.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 10 Mar 2024 14:53:42 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="2e4955e3d556e61e2eb54acf7a827d17e9e46822"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 96d3100e739c0749025646c961703b91906966ff


 * Source Package: rdma-core
 * Version: 51.0~202403101259+git710aa556~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/27898045/+files/buildlog_ubuntu-bionic-armhf.rdma-core_51.0~202=
403101259+git710aa556~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos01-arm64-037
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 51.0~202403101259+git710aa556~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/27=
898045

You are receiving this email because you created this version of this
package.


