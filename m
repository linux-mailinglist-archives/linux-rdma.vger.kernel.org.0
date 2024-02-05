Return-Path: <linux-rdma+bounces-912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82E849B52
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 14:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20D3B28F35
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374F1CA9B;
	Mon,  5 Feb 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="d21cq4i8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383635EF1
	for <linux-rdma@vger.kernel.org>; Mon,  5 Feb 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137848; cv=none; b=EFFrlh/qXQZOmsMJ0DSpdi9TXXnQKi5S1GItIGuwbD+7PDYef6cOVRVDA8Wd1FhJcph7R0Vq5Pdq7oKtZv4A11R0GkpR9lJ+dCKukffhYEd7GNBsxWgEYDa5GgogsDd6jWlh5pLYn+p9O1RcNYV7HAeDIwCHF+ENx0RSqE3dzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137848; c=relaxed/simple;
	bh=vkMrc/xDkw32vCIl9tRuM3hPEAuFeHp3YP2bDbQXHgE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=HzH00THXz6djuMeeTzNVj8YXGqVPHcSXYtgbzR/iH+iqK7RmDdKCjlHs3HUgrD2RrAU0D6acGZx9brrNiR3cB1KvlCBcafHr4tdZ8UZW3AgS5nZhLU9tXuZCCLCTSBnHrusG1bjEBhhOMnU4PjCJL/neJNSRZ6RCpG6yYgDaF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=d21cq4i8; arc=none smtp.client-ip=185.125.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id C3A1E3FF4B
	for <linux-rdma@vger.kernel.org>; Mon,  5 Feb 2024 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1707137339;
	bh=vkMrc/xDkw32vCIl9tRuM3hPEAuFeHp3YP2bDbQXHgE=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=d21cq4i8072zrlaTaxR6ImplVuSYbS/lpzanV5Rt2zKJ6igaVvwH8bP2tlzf7VNQK
	 znN90UrkFZy/bNm4tIl66JlkdWaW4pmUdCgH+F7NdeSB4pip0xLK4de94TLRRk7Dk2
	 4eWlU4qYuolsa6D/ZchwwSmD2SGNmDyGcgrRZMKtLohhdg9yU8Q4yyoEDI4xWtNG6o
	 kQNfIcJuqhklbYj9+JV3DNZwuwAERhFO6OScqIDvOdNciDJ9pmWNAgqhFfqLgLoEgY
	 kdc9urhiM74WAqrcxPyAwLFNjy7cJLKpU0cN8vJ3wwHw3XyhVpOkxTzN2Cyx8wO7g6
	 xonkB+GIMtTRw==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 9131B7E249
	for <linux-rdma@vger.kernel.org>; Mon,  5 Feb 2024 12:48:59 +0000 (UTC)
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
Subject: [recipe build #3678402] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170713733958.656566.11474362014186487404.launchpad@juju-98d295-prod-launchpad-15>
Date: Mon, 05 Feb 2024 12:48:59 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9643586c585856148a18782148972ae9c1179d06"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: d207f3b6c9885a37b919be0ff56540f0ba1cc965

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 4 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3678402/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-079

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3678402
Your team Linux RDMA is the requester of the build.


