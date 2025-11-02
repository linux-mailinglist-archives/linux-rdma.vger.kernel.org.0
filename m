Return-Path: <linux-rdma+bounces-14184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F06C295EC
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 20:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 635C34E3250
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A7245023;
	Sun,  2 Nov 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Vwhb9bGg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB0282EB
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111424; cv=none; b=aOC7G3hFgepUp9QSMarRmpuBk2c/FyFZ3GP2D6pR2JQP0VSP57UQ2lmjWAlvosZQzGlTcBM0UqR41PQMAZ/U9uKhcgzp8nz94TimQZ9XNNHFsX7Yv1LH/NozpihA4UlTdAE3/WwnB6ApFXJelSzTF0018ZaEI4tNB9jAhafXajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111424; c=relaxed/simple;
	bh=LaqI1lHtDcBQ1n4BIQnzthEu9oPj+qX3vzXzs80zfzM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=hk/SAx0Ef10iSjPzLPHfKiwEcH32f63M8WcIo8BPjYSL67aIKxMyPZdOHILB1lH3TH/yemaM/wUVcuxeMRnbVKtGofA+W4qIoDlrG/SQlVd35hX6JuYEzJyelW0pK2G4mMD4V2UvHc8FL0Eo/gC31cykALOVrd1JuXZi7r8l/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Vwhb9bGg; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 605F542227
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1762111421;
	bh=LaqI1lHtDcBQ1n4BIQnzthEu9oPj+qX3vzXzs80zfzM=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Vwhb9bGgm+/1PIeDWlnyrbs2IrurGU2B/oMuGNNok0xBkS9SarLbAVxAcYP54Cs+F
	 K1UJPemBSP/ReMpkqKdFAGoGVoc955JXFFKuMbw6qEyvG5uH7TGbbicT7iNhJ4032u
	 gFkbN2OufjgFGUxjrBhjyRKNmdxjLrwiioJyOgh2r0G9Z3pTB+YaAs1AQuPGSC3zdC
	 YwoBBkGTFXesU67LHT7oBhwDJSKIA3Lwfm2n6sCPexnw/FKp2yeA5qOu9v/5QIPLrD
	 bBIhT9d+uYJF0MjoUvE1ArW62FWsS1h+jQTkxCdXK6FVZwW4N8GCdwEG0edtpGLezI
	 WbOO0MJbUxMjw==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 443747EA5D
	for <linux-rdma@vger.kernel.org>; Sun,  2 Nov 2025 19:23:41 +0000 (UTC)
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
Subject: [Build #31456853] armhf build of rdma-core 61.0~202511021427+git0d977c57~ubuntu18.04.1 in ubuntu bionic RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <176211142127.1218157.17623072460053973209.launchpad@buildd-manager.lp.internal>
Date: Sun, 02 Nov 2025 19:23:41 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 60b37c58cbdbc4e161bb2fed5404308383293576


 * Source Package: rdma-core
 * Version: 61.0~202511021427+git0d977c57~ubuntu18.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 6 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/31456853/+files/buildlog_ubuntu-bionic-armhf.rdma-core_61.0~202=
511021427+git0d977c57~ubuntu18.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos03-arm64-087
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 61.0~202511021427+git0d977c57~ubuntu18.04.1 in ubu=
ntu bionic RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/31=
456853

You are receiving this email because you created this version of this
package.


