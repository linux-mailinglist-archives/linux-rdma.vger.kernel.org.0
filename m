Return-Path: <linux-rdma+bounces-1030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48467856686
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0402428C3B3
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Feb 2024 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF8A132484;
	Thu, 15 Feb 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b="gmNF22Fr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-services-0.canonical.com (smtp-relay-services-0.canonical.com [185.125.188.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECC13664D
	for <linux-rdma@vger.kernel.org>; Thu, 15 Feb 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008422; cv=none; b=VIYxRuLc03OZ4dv7H385TiWQbdWPUqIoeZJ9sHM3Fu2tBvaZApbWl4jCE+sYjp2iH9zkUXAw22EUg7yyZ03w3qtN1/NYPykdMNetqMGmz5odz2RI9hD3G96UCaxtuewPjVC/2I8q/FezN6eQV2tqye+7CgVwRS+P1JZIhyCwTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008422; c=relaxed/simple;
	bh=aJ3H24mPFWHWb/UfoHCtwXZAc4/gh0KzoFsrJmVggLw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date; b=EEbJFp76bRLlraC1xkzkvLc+2d2rNyBacyCvfeWz1y/4nQtA5WgXtS7h8jpbEcFBe33FiO6NYzgyoUNsvgOU6qtAeHVoPts9wsy5do5ht3wn8SP/HGE2TnyfPy8sVFmxF4gw6vzbKk/NsXuiuAo1gVmXBcLM86dMEGT5eOXrpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net; spf=pass smtp.mailfrom=launchpad.net; dkim=pass (2048-bit key) header.d=launchpad.net header.i=@launchpad.net header.b=gmNF22Fr; arc=none smtp.client-ip=185.125.188.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=launchpad.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchpad.net
Received: from juju-98d295-prod-launchpad-15.localdomain (buildd-manager.lp.internal [10.131.215.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 080363F89E
	for <linux-rdma@vger.kernel.org>; Thu, 15 Feb 2024 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
	s=20210803; t=1708008417;
	bh=aJ3H24mPFWHWb/UfoHCtwXZAc4/gh0KzoFsrJmVggLw=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-Id:Date:
	 Reply-To;
	b=gmNF22FrhGUNd1B8vE4GW5SQJP21YoNgV3IKByH1/xi4RFoaPlPjaLskHpy778gPg
	 KVSLNsSXzmubfgwEo11hkPafuNw+5Y10F859TWMaaV185K3eUheUgvrJI9UMzqV82Q
	 24usj8bMOyrUS1f8/HrYgd7D4UJkCcsdGSlXYF+IKZm/bKV562AnPQ9veRGe2QxSNE
	 t+kkuREiaS3sa9YBQfo14aAkhNRUJnEwRh1DJAnwVcCdmZZhkr6xVQ/kNbIfuHmFDT
	 JkdN39ETJ0V4TRDH51Bg4p89flj7keAALMPqznhLzVmFcAnWtaPwNAL/qS8Iu1akAP
	 sHJTZ40hCq5wA==
Received: from [10.131.215.202] (localhost [127.0.0.1])
	by juju-98d295-prod-launchpad-15.localdomain (Postfix) with ESMTP id 502727E5D0
	for <linux-rdma@vger.kernel.org>; Thu, 15 Feb 2024 14:46:56 +0000 (UTC)
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
Subject: [recipe build #3683611] of ~linux-rdma rdma-core-daily in xenial: Dependency wait
Message-Id: <170800841627.3580314.12865330614329961588.launchpad@juju-98d295-prod-launchpad-15>
Date: Thu, 15 Feb 2024 14:46:56 -0000
Reply-To: noreply@launchpad.net
Sender: noreply@launchpad.net
Errors-To: noreply@launchpad.net
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="9643586c585856148a18782148972ae9c1179d06"; Instance="launchpad-buildd-manager"
X-Launchpad-Hash: 5343ac196198a9871f8723a700c60534500dc710

 * State: Dependency wait
 * Recipe: linux-rdma/rdma-core-daily
 * Archive: ~linux-rdma/ubuntu/rdma-core-daily
 * Distroseries: xenial
 * Duration: 2 minutes
 * Build Log: https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-d=
aily/+recipebuild/3683611/+files/buildlog.txt.gz
 * Upload Log:=20
 * Builder: https://launchpad.net/builders/lcy02-amd64-020

--=20
https://launchpad.net/~linux-rdma/+archive/ubuntu/rdma-core-daily/+recipebu=
ild/3683611
Your team Linux RDMA is the requester of the build.


