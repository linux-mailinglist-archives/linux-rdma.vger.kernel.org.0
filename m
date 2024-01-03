Return-Path: <linux-rdma+bounces-528-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C043822DB1
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 13:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012A7283FC7
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF018EB6;
	Wed,  3 Jan 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="kSz/155j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F31A702
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 708CF41422
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1704286062;
	bh=YOm94fhe9Qwn3gARiwP2wn6cwtTQm2n6IiX3QVX9TiA=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=kSz/155jxTJDX8w2UWb7nuM5dglpo60IHiSxPywXGyrKrmB2zYy0B95wWRzEfyl5f
	 ADJ1wM0yBNEq0RhTdXZ6Av7s2J7j7jTQzMparGVvlFqYbUNGy3vcepIGlZJ7w0ndjC
	 1b4VuoK/n/1GO8uEJJ6ZLAZZuPYdhGke8G1XDEa+yBhZvfVul6h6+g+ad5bIpIDFPF
	 Kd0xEGhPQbuhBeWBicyZSJjc011vmrj930XUUxbDym7CoeLfoNFR/EGAkw3rpTWnXj
	 0EWRFSQdjCaOHVfyYrBwXCpuTjP7K/wwF+4rhr3M7/CriQk0jWLsTUzKldhTTqATuI
	 oJa46hn0HTNxg==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id DDE367E011
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 12:46:50 +0000 (UTC)
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
Subject: [recipe build #3659434] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170428601089.3217627.7760188160655719716.launchpad@juju-98d295-prod-launchpad-15>
Date: Wed, 03 Jan 2024 12:46:50 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 60a9ed3874d9ef44f8d44b4e70946ee9e1acdc9d

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3659434/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-101

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3659434
Your team Linux RDMA is the requester of the build.


