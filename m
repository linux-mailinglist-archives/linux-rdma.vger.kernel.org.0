Return-Path: <linux-rdma+bounces-643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0E830631
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jan 2024 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DA11F260BE
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jan 2024 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6E1EA78;
	Wed, 17 Jan 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="AgrcUjcH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405B1EA74
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jan 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496126; cv=none; b=W85DYlz3f4vd02x4eZ3HFoYKsvKEPcRNBD44Soaj+sTcDZCkJGGA8h2KbVxjLcTIt7TCwmk4fJNwGeMpBqjBhfnjZMrM1oNfhZHXozjiUjhFIPX36IIOJZ2V+BaKqbeIJjI8vkC8rd72c/WxVRhVtZIN5Ef9SHnPukqvAQdUsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496126; c=relaxed/simple;
	bh=666bCDFJ32OL0gPs02WOJusmU7gazFlBPlcpDivgRmQ=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Launchpad-Message-Rationale:
	 X-Launchpad-Message-For:X-Launchpad-Notification-Type:
	 X-Launchpad-Archive:X-Launchpad-Build-State:To:From:Subject:
	 Message-Id:Date:Reply-To:Sender:Errors-To:Precedence:
	 X-Generated-By:X-Launchpad-Hash; b=dP2qd/mZWVkaHUjjb7r7aOr3k8lZZGVmsa4BTb46JKsBlldGMEf/o5+vS8pv3Evx2pZ3Hkzw7gYsHFgQ4L23LxLcwr4ACQk8BRVO8ywchIcpnzTj8G4Sj9fROFIsbLfehVFPxumc7gW2Zfb4gG3jeHa5n8HsdTkKkx9HYuYmP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=AgrcUjcH; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id E295F41A1F
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jan 2024 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1705495642;
	bh=666bCDFJ32OL0gPs02WOJusmU7gazFlBPlcpDivgRmQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=AgrcUjcH7q/hVBlhuJWcB/er7r5HQ2MAGDmg6GemCMj0+3xLHahwfwnBU9CcfBx/6
	 yXCL0LhCtF5OeLQwTBlKAYjgNkp+KlTRxyszJ7zbX0fpbLhHOXxLZd0QHZB1LkxYo3
	 vm4r7kp/4rbkUlfa4GsoOG/x8y3MPbdooscRiqz6hUlsl2Y1ew74+lBRxI+58qIYMS
	 DR2wWRMpLBVhTR//JPLCu7K11UCPy75eE52Nu43SVDVSbYhKUmBupLQLgQPUqJS4pl
	 MXgPAn2M3ALn7PxD2iZg0vI5Y7FWi3+HDbzTSXjQHgPwEEQNPoCrLX8cJL07NysR5D
	 OcK38CBgLqqhw==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id B534B7E011
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jan 2024 12:47:22 +0000 (UTC)
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
Subject: [recipe build #3667283] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170549564272.3242562.204726936700570813.launchpad@juju-98d295-prod-launchpad-15>
Date: Wed, 17 Jan 2024 12:47:22 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 659c7b799a77efe54958af9a64417da0defc7105

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3667283/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-037

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3667283
Your team Linux RDMA is the requester of the build.


