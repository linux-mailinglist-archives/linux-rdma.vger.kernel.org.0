Return-Path: <linux-rdma+bounces-1493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F9880E2B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 10:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B066B20FEB
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Mar 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA236137;
	Wed, 20 Mar 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Bl+eGuOe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED239FC3
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925123; cv=none; b=NZtSn6CYsCFRy7gMe+87qIr+Q7XOXgjdlIOFStL3MFMn/OyW4mUGrgqp/mIGnem/2jc3FiZAx5KYoDkwTwi6xwGcXkQFCCZ9a2G7Z9wqs+pJBrUKPcztRtLDU3bye6AdF7oORuj8GQ/nmp/GRyxNPcqQsCwt5KDk1PIxQ6NCdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925123; c=relaxed/simple;
	bh=79Qc5r0aDvGs14ZBKYL2iaKt++QM7ZPT2veE4ZPX1jY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=mFUxih4oRH+09MdFz06yTUid9Gaa95W1CaoCoKuydEVT3A1dXtPdcPtPCcFfOQfFGaOdCLXxOKdjVHG/o3UdPj4t2S9eotsxeLphQgysi7MNN4j2BhZST00aM0xqOxkTYLv1QnxJ0se4Wjo7Km/nCerPr19DbHuTTj8rQB4VADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Bl+eGuOe; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id D1E7042C30
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1710925118;
	bh=79Qc5r0aDvGs14ZBKYL2iaKt++QM7ZPT2veE4ZPX1jY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Bl+eGuOekZYsZaqyRhfelAhnvkcioRjub98AAz4Ao5qy2FTad2RTA2FoaK149kgO6
	 QeIcUcQG0aa/vGXLo0kujRRQM5VwJxyOgAtYtT2oaLTC6+GVIMMOAvf343ujN3ZRMN
	 6K3uFxxzMCq+ZU/h5TxuJqXSL72FBrIh92BXnBIZKZ2dp52IqQDHcWJtsKfsIGbIP1
	 xT7vY1mvgUrUUrcyVD9gC6RoIFm5wRM+x5Ditq+QwfA0rnAj2fSxVrxzZbVBzcDONc
	 hOQ1RWENsOvxhwvCIbkc2Nyscxwl5KkIYFXDnDOHtQL1NvjGwn+FRvAoPH1DCgZ8jl
	 vi3YKmEXNI+Xg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id B7AA07E23B
	for <linux-rdma@vger.kernel.org>; Wed, 20 Mar 2024 08:58:38 +0000 (UTC)
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
Subject: [Build #27943648] armhf build of rdma-core 51.0~202403200825+gitb51ef55f~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171092511873.2452654.16930339878088818311.launchpad@juju-98d295-prod-launchpad-15>
Date: Wed, 20 Mar 2024 08:58:38 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: f9613a6c7fcf62b107fcb95cd8b87df9bb263b28


 * Source Package: rdma-core
 * Version: 51.0~202403200825+gitb51ef55f~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 10 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/27943648/+files/buildlog_ubuntu-focal-armhf.rdma-core_51.0~2024=
03200825+gitb51ef55f~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-080
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 51.0~202403200825+gitb51ef55f~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/27=
943648

You are receiving this email because you created this version of this
package.


