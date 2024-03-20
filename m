Return-Path: <linux-rdma+bounces-1491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213DA880DE6
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 09:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE2A28294F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816C3A1DC;
	Wed, 20 Mar 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="RkwwLfTu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B739FF2
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924775; cv=none; b=pxyfr+kOZBisHdENzf1F9Bf8QkAjBC4nGqS6Ax01jFNnwJg5Zf1Sez6SDZVlqy47Yl5Bc9m3KUvasqneZlLZWGHeRqVGtMMXO4X8W1zZ3laFklvyfpbDCjp+8f6hy+W3kYUvVD4zA/6EsPbChmUe173mkd7zX1TaBORyfNlNJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924775; c=relaxed/simple;
	bh=3RzGN2AxdaboK/g57s20SfAsmANqunB5qsPiqCh9ziQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=O56A6wZO8KtlPoH91sMR8V2PfSaZyXuk6v6zX2gBe/lpiFf2wCpqG6aTH7KTnoQxq5VehbcYI37oyyR9TWkRiuPQsHgFqVA7t0kyOQ0+NatJG8bShoAkWMBPPgivxzpuRI4jSTkvqsIc8AyT3pale55OKnNCs3OySmyyo6uwh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=RkwwLfTu; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C04713F57D
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710924769;
	bh=3RzGN2AxdaboK/g57s20SfAsmANqunB5qsPiqCh9ziQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=RkwwLfTu3V9muauVxFeN3/X2GomKgyEJStDYe1mmJf13PY0r6dKGQD+3iqdwswdm7
	 4oQjmjLahAHvk7pOCjABXluLuPyPd+9QumxagViimrkJrNmfnLQ8GouYP19YFYux29
	 VEaEI7fDJM3lFcfOasv4uFyU96VINAVWovyFgDHsmunFTGVpqKq6PIrafrIWeMnTbm
	 XnIuSGMXhcO4LiYRNWEkQj9h6Xg7AOZO+VadTM2qF4h2Zvy5u/LrCt48OMSkKmZLRn
	 5fvimrW5kHp0ZBFgX6SCjjuAt4swJcm7V45Ehjm3F4wkTB0iQ5ufDMVNJMSmhC3DWO
	 EpJWTRDl872tg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 347827E23B
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:52:49 +0000 (UTC)
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
Subject: [Build #27943642] armhf build of rdma-core 51.0~202403200825+gitb51ef55f~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171092476920.2452654.18340045137405198373.launchpad@juju-98d295-prod-launchpad-15>
Date: Wed, 20 Mar 2024 08:52:49 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 92ac9cde5bd7dbab8420d45c76f13511a958951b


 * Source Package: rdma-core
 * Version: 51.0~202403200825+gitb51ef55f~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/27943642/+files/buildlog_ubuntu-bionic-armhf.rdma-core_51.0~202=
403200825+gitb51ef55f~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-036
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 51.0~202403200825+gitb51ef55f~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/27=
943642

You are receiving this email because you created this version of this
package.


