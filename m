Return-Path: <linux-rdma+bounces-9780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0689CA9B9F0
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 23:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A1F3B02B0
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB351F2C56;
	Thu, 24 Apr 2025 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="GhEuiSHf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB4111BF
	for <linux-rdma@vger.kernel.org>; Thu, 24 Apr 2025 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530430; cv=none; b=rWnDo7GBOmdGwdzlktSydccjdTb+zg34ytBKprJlBM0ca+eE2Jze7WT7azA0mCIQ2ZyaBtiInqZngow1QtzEOl8XOmB0zs5y3/GbYgJiurSy7PcvJ32oECbi/bs1fkUQl0gapUGV4BBGN3+FNni9KO40X+VN43QQUkqHsBVRGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530430; c=relaxed/simple;
	bh=Z+k+5NOl33njPRTtdVNIkLLvCjppPLjMEQH4lItvJVc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=WYEg4rzrFY9ta4C6Z++yeppsF4MqsVGRNJGrLhnznmp9MkcnelEdgd6E+838jqBjj8KNhIUpoAZF2MneNnCTj5lpnrKynGizwkzciqCOWMu3VEM0cD/vllKcpmymFM+Fzto85G6erNyBQlCHdHpIO0QuyVXYO4xXuRS7QvpLku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=GhEuiSHf; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 2B0823F151
	for <linux-rdma@vger.kernel.org>; Thu, 24 Apr 2025 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1745530419;
	bh=Z+k+5NOl33njPRTtdVNIkLLvCjppPLjMEQH4lItvJVc=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=GhEuiSHf3rjfWPi8qvuBdZ9i4nMRTjfwQlXdAlCS6oOQ7WNNOLnlDnsLjJb4tpZH/
	 E+A5qtL86HIA7osqz0bL5rmZuKzyXo2AuXzkn64Nx1NPliCP5AkWo6DZY4LBVJ6qHG
	 xqQ1gSxsmZHfIQRlct/xSt7y4K6iCYQvgou9QJnSy7CvPpf2GylL8eteP9Z5Sdu04c
	 m5mCQBiidkPudsUKswuQVBEKH/EaA7eaxusvkZRYrjEkIRYTfJAIpysAq5IKVWnX7I
	 unF3ejO5DCE6hZzWZQcbhzW/6uoJ07ZhBSFy3iIAjQ6pr4/1/necDTZ01AjwlxP9na
	 FdkeE6qycfuFQ==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 10DE57E25B
	for <linux-rdma@vger.kernel.org>; Thu, 24 Apr 2025 21:33:39 +0000 (UTC)
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
Subject: [recipe build #3887521] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <174553041903.6997.17625592819595712668.launchpad@buildd-manager.lp.internal>
Date: Thu, 24 Apr 2025 21:33:39 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e76edd883483c71c468bb038e98836435de44530"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 9d814f42a6edc5d705c54d02b34a5ee1ef7753c3

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 3 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3887521/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-107

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3887521
Your team Linux RDMA is the requester of the build.


