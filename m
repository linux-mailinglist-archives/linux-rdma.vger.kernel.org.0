Return-Path: <linux-rdma+bounces-16964-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCfRBKTqlGnUIwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16964-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:24:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B19FD1516DD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E0A30214EE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E93148D2;
	Tue, 17 Feb 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwSrmyEs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81428641F;
	Tue, 17 Feb 2026 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367071; cv=none; b=VwUNys7oGhPscHWiZweJ3F330zApTTXypuc9IyugGLZNpkI7Fq94WYYAgf6h60kWYJUC5eE8p3kQR4nqibsYJpYQ7bp6S3SRRSdh5XlmGLUYvfagU1n7A1K4/8lTatQ/1ei4rUyAo4Z93QQXYsV/w2l8Jpq6lqXCJXyiLVbj7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367071; c=relaxed/simple;
	bh=KbBp7ZGFZUKm1zv8UcR0RDREWlKTzcJOIc68SKR0XP8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XmoylIGPNSuaqgG9iHf3HUoG789LCzfwe8XHt4fm1dTqh2rBbSCGqQjQwSUUJKu9ZYvMZ3vCo20XKS5plVtdUhtyGP6f/ufQ03Dv2/uxQYM0s20GcrzzmSBSJ8yC9dfVWB54t/pMO++HbA2/GD8M5MUsBi/n7r8cFxZG6wTbrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwSrmyEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B661C4CEF7;
	Tue, 17 Feb 2026 22:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367070;
	bh=KbBp7ZGFZUKm1zv8UcR0RDREWlKTzcJOIc68SKR0XP8=;
	h=Date:From:Subject:To:Cc:From;
	b=fwSrmyEssGYDFr7KdXWcpac5kgtfLX3/QLEOKJ3HSzJ1ohs5/JWhneeq00uAg9gsE
	 X3cjMkq0Sc/5uNNkdk4X8XUu2NS6HdCoeeF4FfL6xUHD/yV9/2PxRxCdjaR1Cji7QU
	 tsmdMb8CiQEn+dlA7EjYE+TXicaSSI+2cdEV382CogKc6rldJcxCn1kDFhSR2DSsLc
	 q+CoWed0yJLUh91PRPnl4hIyRckkXTKntHIzaiPY+Gg/LR5+NwBnCOmth/7//hTug6
	 QbFk6XtuzGoQOgXMTihGDbbzN5uOO4EeNs3D9JU2doU+Z60K7UVO3axQS7kEE5jMA6
	 /XcA1Imtx3/2Q==
Message-ID: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
Date: Tue, 17 Feb 2026 23:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkall@kernel.org>
Subject: [PATCH RFC 00/10] driver core: constify groups arrays in several
 structs
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: driver-core@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16964-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkall@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B19FD1516DD
X-Rspamd-Action: no action

This series constifies the attribute group groups arrays in a number
of structs, plus some preparation work. This allows to assign constant
arrays, w/o "discards const qualifier" compiler warning.
This is a step towards to goal to e.g. create constant arrays in macro
__ATTRIBUTE_GROUPS().

There may be drivers not covered by my test scenarios which conflict
with this series. Therefore I send it as RFC for now.
Hopefully some CI checking this series provides additional hints.

Heiner Kallweit (10):
  IB/core: Prepare for immutable device groups
  rtc: prepare for struct device member groups becoming a constant array
  sysfs: constify group arrays in function arguments
  driver: core: constify groups array argument in device_add_groups and
    device_remove_groups
  driver core: make struct device member groups a constant array
  driver core: make struct device_type member groups a constant array
  driver core: make struct bus_type groups members constant arrays
  driver core: make struct class groups members constant arrays
  driver core: make struct device_driver groups members contact arrays
  kobject: make struct kobject member default_groups a constant array

 drivers/base/base.h              |  6 ++++--
 drivers/base/core.c              |  5 +++--
 drivers/base/driver.c            |  4 ++--
 drivers/infiniband/core/device.c |  9 ++++-----
 drivers/rtc/sysfs.c              |  8 ++++----
 fs/sysfs/group.c                 | 10 +++++-----
 include/linux/device.h           |  8 ++++----
 include/linux/device/bus.h       |  6 +++---
 include/linux/device/class.h     |  4 ++--
 include/linux/device/driver.h    |  4 ++--
 include/linux/kobject.h          |  2 +-
 include/linux/sysfs.h            | 16 ++++++++--------
 12 files changed, 42 insertions(+), 40 deletions(-)

-- 
2.53.0


