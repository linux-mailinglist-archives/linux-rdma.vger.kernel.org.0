Return-Path: <linux-rdma+bounces-1021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7E854BEE
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 15:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E34283955
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83A5B1F4;
	Wed, 14 Feb 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="MP4TrBhA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AC5B1F3
	for <linux-rdma@vger.kernel.org>; Wed, 14 Feb 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922510; cv=none; b=KswmF625q4WzFitf2MTci0j9LqnfAlyGPIfCJwyQedbukxmqaNC34CF4olt+nv7LF9iJ9EJ8F3/P3O2L5GGP7pJ+rfNUoh5NVLCkxL/1eNsy0hf+kmODC8y0p7pECKnClW/rfS4zhzYSOmY20/pvb3vx7idtFXAZo10EkPrebzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922510; c=relaxed/simple;
	bh=vEYnt4jhBck72timy2Oq4Q7fwKrXXLKiDmgvhERvpzY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=YtfCJ5hJDzgIa68erPY8iQSMxC7Rt+cJLKqaJqUlcnUZH0sEHlrOm3JrXgEPktTeLYyciT+l5N/A6ZCs952MXBEDTsDJdpYWr1F0l21AOomoOShIobKxx16Z2TMOf49S3fMijGGby1U9PLuC7Guvo+M4xAvZKgWMM4+7uSdYX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=MP4TrBhA; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 602D541960
	for <linux-rdma@vger.kernel.org>; Wed, 14 Feb 2024 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1707922048;
	bh=vEYnt4jhBck72timy2Oq4Q7fwKrXXLKiDmgvhERvpzY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=MP4TrBhAkBMC7JClwqE2CwJDbcebn9l5hxQzxZ35oksbFJUrYasalA79a8rBu6aVk
	 x0Q2SSW9ddtclwW5iXrXxT0B5Di8UisejUYV5HEALKOaNCO2lOjs3v9/5kPqB5Xznv
	 Kq9K9ymdHo4cL1QXQDWX0gIfaJyqLxN8yBpMC5RqfIjoiIR/+1GCyTS3vB85m0lSRj
	 52VvS2l9jwwzcX95UtVfPgXY51MYN5Grh2pOTqhtQV/EbgdvRBCuhCXtOSaznLoqTH
	 vRwRk++egj9tNO+pUdI1UuuuIRMRqq2cQG8CI7lqAn5fk+xbv4a4w4UiLS0QligCHw
	 VpmLfDUvWQp8w==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 1757C7E24D
	for <linux-rdma@vger.kernel.org>; Wed, 14 Feb 2024 14:47:28 +0000 (UTC)
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
Subject: [recipe build #3683153] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170792204805.33713.11406881235278964204.launchpad@juju-98d295-prod-launchpad-15>
Date: Wed, 14 Feb 2024 14:47:28 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9643586c585856148a18782148972ae9c1179d06"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 00cffee072a475e4be820d8f0a4aa6089ce3d715

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3683153/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-014

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3683153
Your team Linux RDMA is the requester of the build.


