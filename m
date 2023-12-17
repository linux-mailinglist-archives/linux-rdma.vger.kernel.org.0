Return-Path: <linux-rdma+bounces-438-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D1C8161AF
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Dec 2023 19:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244FE1F21638
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Dec 2023 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37847F5E;
	Sun, 17 Dec 2023 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="b9qNC9TO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-1.canonical.com (smtp-relay-services-1.canonical.com [185.125.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0247F43
	for <linux-rdma@vger.kernel.org>; Sun, 17 Dec 2023 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 5355D3F9D6
	for <linux-rdma@vger.kernel.org>; Sun, 17 Dec 2023 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1702839024;
	bh=b0s1WernuX3kzBsB1Tfr2oEn8/3+pGAebV38Cltx/TQ=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=b9qNC9TOynxH/rwCQ5ifFqpuO8kXbspw8bAZVeLZ53QvdcXv2Q3ys/65fw8AeF/BE
	 LWxXs28d3EAlK87ZuhfQ+UZnhuYDaSb01L5Gf/DN6Xf52fFz2sxE6gEDafmKmqsy5H
	 4E9aftNnlehdDZ9zOBL7HQIsQrHv9waQlCRDxlD34UgV78weruCpm3z94h90wA7eW3
	 1P/jBQNREDfBUfj7NGOI/BpoUdYLwKOQ6L1b1TMQooSf6uYgW6uiqgI7OVZd6uV/zh
	 ekUuSogmCzXjZ8waAUpY1SEZ+g3baa99LlFJJYjL955vG1fuWPve772QY95/73OriA
	 Clsn+BNwJS22Q==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id CE2DE7EBCC
	for <linux-rdma@vger.kernel.org>; Sun, 17 Dec 2023 18:50:23 +0000 (UTC)
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
Subject: [recipe build #3651522] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170283902378.170896.11729213422854965859.launchpad@juju-98d295-prod-launchpad-15>
Date: Sun, 17 Dec 2023 18:50:23 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="e1eeab5b20e19239bd7d5f36676f7a52988db88b"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: be95f3da4ed0f68404cf5dc172cc6732a51f4afe

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 5 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3651522/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-109

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3651522
Your team Linux RDMA is the requester of the build.


