Return-Path: <linux-rdma+bounces-7238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA89A1D50C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 12:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9934E16556E
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13561FE45E;
	Mon, 27 Jan 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="Yxw0xQLQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101A1FECDE
	for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975500; cv=none; b=TfuV1WkYe68aBhJ9StTa1mUZbqd70fnJuH5F587+EmvUC4nMnZT4UJ1QaaLQbEocHfw4bKW0obM5kLESLcMtI3vtzJhEN4Gju1KS8IZ39zojsin6QRwgd6iXsxrDf72RG0TBPM74VS0CpXujVRvS5do+vcb7bBsoV30BtUP2HLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975500; c=relaxed/simple;
	bh=p+HNU0YpYLSH/y2oSVVb+tA8Yn1lkv5HHePD9UerXQs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=eG8YHQal6+125h2aNdq9OocOqp4PC/WPKduoQ/EwJvlccuVXGt/5UNhFM4+Th81n0jexZESJ2+lbkWyl5/EGYCQ7mXUfh5Bqsa5ReJFnsrxkUIi4bPnmlShMJitcePbgs5vosGC1JilPq0GyXuInKXa+nBwJwd6SPrapE15n7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=Yxw0xQLQ; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from buildd-manager.lp.internal (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 385A43F727
	for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2025 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1737974972;
	bh=p+HNU0YpYLSH/y2oSVVb+tA8Yn1lkv5HHePD9UerXQs=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=Yxw0xQLQ1EYgqUa0KNyQ90a5uLJJ/q5mq3Xh9uNgmJnvhATz0ubLk02yyNEQdQ+uU
	 SXfYd/kApueNlqxLvN91f7AaV4lSf0J5MykJGqLayc7+C7nMTouIDghv/xiYaUwIDc
	 qP7JkRedPMFdFbTvHn7sgpK8Osm6AEeEh1wXCQSfqOR3a4di9vjixMVn0pt8hw4IQn
	 SYis1taqnEWWCxdVQV+0TZP2pZV+t+qca+gAnCc3oVydI7k83B0BRjcEnbuP939Cmq
	 ZW+XSxwB6FxzX/QP6JhW5zgpsNHuHTkFvvM6YiAJ13DbNJs+oJ98QKRAV3PJWrHnOz
	 dJQAGP+FMI6iA==
Received: from buildd-manager.lp.internal (localhost [127.0.0.1])
	by buildd-manager.lp.internal (Postfix) with ESMTP id 1FD097E598
	for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2025 10:49:32 +0000 (UTC)
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
Subject: [recipe build #3844838] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <173797497212.1953142.6990041433997390101.launchpad@buildd-manager.lp.internal>
Date: Mon, 27 Jan 2025 10:49:32 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="4d55102f8b4a0cc5b78cab67520e07e127d0612e"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 890f13da484baf7430a58e33b09992d26d29670b

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3844838/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-097

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3844838
Your team Linux RDMA is the requester of the build.


