Return-Path: <linux-rdma+bounces-3483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED4916F9C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 19:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53921C208A1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DAA177991;
	Tue, 25 Jun 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="irOX3ehx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367B176ABC
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337937; cv=none; b=cTYD5CifOGYARqKR04cTdL6kUHxtFvFkB5yF40ZHg4doyv6EGZfgCbNupwwBeejs0V2+ZZQ4xJvPS93OUbSMXXpNOHVQXVJvW6Bwdz7jYzNIpQdz3T/LeIFAlAGxEqqaZIPz2DobH/YNKS0ZH6SqX9ceWlevC7iOTRO+63xvt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337937; c=relaxed/simple;
	bh=x16rPCaq4p92QbBYKhGF85FidPrl84XTLbTaNd9JEt8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=fs5s/qzLJxWb1R7A45Bf4Gexou5QCSasqE1qSk2pFEoB3vOKRKkJd8+PgMydDhOkA/wpw4/0Y6ojl0yerPU4JfUAy92/fVw7WaE0WVaPpJHbKiDYk/eqNuwMGdPTcSJItzJsOOkY4oH1s0FTnaOqfvcgxy3Y1uusxW5x4Jk0kZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=irOX3ehx; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 5291B3F361
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1719337934;
	bh=x16rPCaq4p92QbBYKhGF85FidPrl84XTLbTaNd9JEt8=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=irOX3ehxT2n0ecnpIXlYnIet0VU7M3mHK2kBVnfoVAGBsG0X66Fdrczgq/YFfzcdA
	 aoaXqjVZs9Hcrf9CCxzaRpj9F0yXpCWoWFVUeJ4zT0eKBHOAer3k6zX7UNKWiCa3CR
	 PnI6g7d8lDX9TU4Tm+YcHWz4Pp+18oRienoC8L5lhJfQ22qigT0hiP3rJtYsAsrQ2L
	 PcukSb0396z4UDg9bHl5bjkERjUFLqvCRC1NIX8c2mgZZ6z8p7Q2XhSPTmjPg2v4d8
	 fI0Krmx9FSv1GBz7g6YLgL6hMO/uLJGlq5SQMF2CrOvSZ7ViW9rPe9qGQSBjDNssNd
	 3KdhDAFHXHyhg==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 43BA77E252
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 17:52:14 +0000 (UTC)
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
Subject: [Build #28604926] armhf build of rdma-core 53.0~202406251104+git4d318e35~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171933793427.1839645.10902664785344464205.launchpad@buildd-manager.lp.internal>
Date: Tue, 25 Jun 2024 17:52:14 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="bbfa2351d9d6a9ddfe262109428f7bf5516e65d1"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 11ea93c9afe1874d9ff8a5abc9f03c6b92c99d60


 * Source Package: rdma-core
 * Version: 53.0~202406251104+git4d318e35~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28604926/+files/buildlog_ubuntu-focal-armhf.rdma-core_53.0~2024=
06251104+git4d318e35~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos01-arm64-002
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 53.0~202406251104+git4d318e35~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
604926

You are receiving this email because you created this version of this
package.


