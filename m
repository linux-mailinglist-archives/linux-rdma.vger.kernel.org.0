Return-Path: <linux-rdma+bounces-3434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B216C9148F5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 13:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FCE1C21E42
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61313AA45;
	Mon, 24 Jun 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="MjzT/HZ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E413A894
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229191; cv=none; b=JfHvYZbh8eaDQyG3XWMQJSL6wmlYrGaIwQ23TeVJBGv8hgiNlmTNuqnsxf4YOHCVwz1woCC7yZHGhAk/U8R1y+ml7jGEZt8Ck6UBMLVqtUvqhrGfNrbem/2psFitI9aY2YuYUJiq5QKGeXBjiTdCnbjXbccNDUg8Atb2LRc7nxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229191; c=relaxed/simple;
	bh=8IEhD1K0v6PA19GHjF1i08Ys4/7JK5mUqNvjZe2wh/I=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=cwPp0BLxy7+luuFqE/XY7xsm3zmsOSo4naH//FyVhh808zDuEc+IjrERa6i27USABZ+M4jvkxFVM8mCZskJkRM7GLGTy1soHCoYc0MA0TwCR8cZyTY6HS+MeeDD6WQWUbjEnKj+mn1K9VpJRIovBapAhXmDsGrzQe3mBq2FECBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=MjzT/HZ/; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 15E8B41A49
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719228771;
	bh=8IEhD1K0v6PA19GHjF1i08Ys4/7JK5mUqNvjZe2wh/I=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=MjzT/HZ/z6VGqW3NdKhl4rVB7u8lQwIuy411T7Uhna/7F+86VjmF1hh8+hEcgIaTO
	 gcFFP+VMci9PveHOxKte6ZvjLJCM6Ez+SUhFHeUEMRRWxMxytnGr92LQOeqbgWDYA8
	 cfcov+U8DskLPgNIkEDCbxv/T0yFCv4EXmVS/MgaQZ+YT8XEsJRZYY4ixDtToS0qBW
	 blsVDmIOowkuc6RDcPKOlpQTsfcYhfEybKl8m3yF7+j371Te8VPnDD6xpxYmyk8v/h
	 czcfFjxYDjAuMJezrgubU4umQzt/FPpxlX8FT6HkAVMWywe4piwKihOLBWXML+Rf0s
	 g14zypeKfbqyg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 0104D7E280
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 11:32:51 +0000 (UTC)
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
Subject: [recipe build #3747074] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <171922877100.701.2888873711633803598.launchpad@buildd-manager.lp.internal>
Date: Mon, 24 Jun 2024 11:32:51 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: e77b8213430b936d0dfe26b3fc645203e7ee181d

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3747074/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-084

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3747074
Your team Linux RDMA is the requester of the build.


