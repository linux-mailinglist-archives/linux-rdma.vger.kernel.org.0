Return-Path: <linux-rdma+bounces-2432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0298C3638
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 13:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F7328164A
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B71CD24;
	Sun, 12 May 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="PJ+9KCYP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A81CA96
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715513644; cv=none; b=Ok5u6XCorl6cofPQQt46q+nJkXTWtpl9kUqAEzMN6b8skLsZ92VvlJ5JlWm4NWsxULF69eUeaJwy5Z3qvsLF3MtQ1lBlagxYOc/L4vw9mh2rEZozsJNILoi2X0rZ/jC5rUZh7hTYb5nIysT8PHQuPTINPQOMwDgbhb9o7mbjl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715513644; c=relaxed/simple;
	bh=4Z/bN+MkB5jomEdsaU5FJOqLKjG1yvWJlbTT0DwtUEY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=CrgES7fBdTu6eEfpbpEm9vIeQQJ0zj+XEHGMSMlg25HnVdx1isvUA0pOruCeoFMlrv55hOHnsc71xKPhrrQ3grs2GuK7YFw6aK7eUJvjKQ0hC53Yz75VigxrEeH/1zmOZ6zYPMx0ov4fGY89ZBIgG8L4KYQHvOUhWMQVszu2wvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=PJ+9KCYP; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 684A83F1C5
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1715513635;
	bh=4Z/bN+MkB5jomEdsaU5FJOqLKjG1yvWJlbTT0DwtUEY=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=PJ+9KCYPBl7K3fnjIRpfa+QcUol8eyjgBb1va+eB7oqBiGvTAPO1TehJKEGFcH0Hm
	 d8yPShqEDUCjuDy0gvTGbaFZBKqvkcFojXPbNjNMbX7WK7FMkDzSlELthsH8Ght42R
	 KvQEpWAkSSE27NWzB5CjhJhwuVFXPSDBXL435TTTmnpYXkeil33ugmEnXeys4Gmkd/
	 6/xxBchmcVku8hX3tlWzvjEoToikg5MohvLqWhrwYErw/AxwjrBs3kiNW41aejsejO
	 b38YNdIi4gGeqqo8yqD7pmP9zmfhhj1dybQPqJ10ln7HrVCypVOGaMySnUSe1mYNXf
	 ulas0gqNoeAYA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 532FE7E259
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 11:33:55 +0000 (UTC)
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
Subject: [Build #28440490] armhf build of rdma-core 52.0~202405120732+gite533dec0~ubuntu20.04.1 in ubuntu focal RELEASE [~linux-rdma/ubuntu/rdma-core-daily]
Message-Id: <171551363526.2844614.13425694716861953265.launchpad@buildd-manager.lp.internal>
Date: Sun, 12 May 2024 11:33:55 -0000
Reply-To: Launchpad Buildd System <noreply@launchpad.net>
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="0e1f616671af724398db43b36ddfb3ed1f2682ec"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: b4def990698c590f0667e0a5f4e835880fd021b2


 * Source Package: rdma-core
 * Version: 52.0~202405120732+gite533dec0~ubuntu20.04.1
 * Architecture: armhf
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Component: main
 * State: Failed to build
 * Duration: 14 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+build/28440490/+files/buildlog_ubuntu-focal-armhf.rdma-core_52.0~2024=
05120732+gite533dec0~ubuntu20.04.1_BUILDING.txt.gz
 * Builder: https://launchpad.net/builders/bos02-arm64-010
 * Source: not available



If you want further information about this situation, feel free to
contact us by asking a question on Launchpad
(https://answers.launchpad.net/launchpad/+addquestion).

--=20
armhf build of rdma-core 52.0~202405120732+gite533dec0~ubuntu20.04.1 in ubu=
ntu focal RELEASE
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+build/28=
440490

You are receiving this email because you created this version of this
package.


