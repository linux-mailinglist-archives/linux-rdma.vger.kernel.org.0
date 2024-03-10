Return-Path: <linux-rdma+bounces-1362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A099887768D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 13:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D280F1C209C9
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552220DCD;
	Sun, 10 Mar 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RPAuJPvk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E51F958;
	Sun, 10 Mar 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710072949; cv=none; b=WknA37ZQTE6IK82cVOEtvfOvIl67/bPDaF6Ld7bwsLjJtf668tovXzTI7jI2YhVgdURUZ+BawZkWM8cvxaH7y1p3h2Q6nGWWX9FZ0zm3AZN9e0crKUKTOjJrkbXEDs7mxdX4+ilg2OxKhRWLhbVdKwY6dyntXG9CliZa0IvlzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710072949; c=relaxed/simple;
	bh=PXdQJn47uPDxklgoRlzOz3Dfx+P5Ya2f6dtyNnSQMLU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oQPo54P/hmDyQoOvNFTy0EGrV4l7iBEQ5p+AzOeukpT23sbzPb1y7IGMIbUo2sGsTz9BC3CbfbX2F0irJewfj8oGlwUG8QnVr169mofA7L1lSlHCKFjt50hEruNBmi1mfWP/vU616aA2F63GdRUsvyTpjosNkkyLRGB328KiFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RPAuJPvk; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710072929; bh=PXdQJn47uPDxklgoRlzOz3Dfx+P5Ya2f6dtyNnSQMLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPAuJPvkK4xobNX+xwRZndIyQh4WYzAS31qjBqDjJRbNk+0yVsGjVU3a4WOKn9ZRC
	 X4FOirO6ekedeNQlHJkiQFU/LEpp2xub5hOmrF9Am94ALlxZBy4rUV1MIsk3s1HFtp
	 R+78Q93fUGPHsIXOYYGbb/oGTgwQALdYGv50+MNc=
Received: from localhost.localdomain ([58.213.8.163])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 3DB94874; Sun, 10 Mar 2024 20:15:27 +0800
X-QQ-mid: xmsmtpt1710072927tapy58yra
Message-ID: <tencent_49503CC554528271302D9D214218898E4206@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj8pej+XGSvtDwRXZAJYG4PotQTByHKu3P87vcDs+lwaqswZ15TZ
	 tMfY2f1P9+z7BFOwJ3XAZH0oamwPF2pIJqfLXnStARVdsggvqf8QiPsycedMyKhiUUor1TTcOc+J
	 CWBRfO8SbwZKGWp1FIYpZRGcro6OFNqU/iX5Zv0h3K2Nif35Wy1T0C8fYvmAnUzLVarTwUtsIeFh
	 VkV5JYNr7TJeMjaLUCk9Lhob3Qa8iXBobT+pzMNb8Xg8K/1Ztycsl3vJ3ZME/dcSEmQS0EKWrQaO
	 Eh+d71nFhmBI6U4ete2k2H9Apr2oLj2H/kKZ4YOBsDys0QuW4Na8u0PO3eKzJjc91dZTC0XMZ7Jc
	 0ZO1jFRKYWXcbmEkK+055Q4Axs6pfS1tnkQTUjERnYSg5LdRPJhWP/ju+xMMfddxpf5wEbxLEzIR
	 x3S1aTX4WOgYzFYB25ehb49wizcA2296rPkH0lC2N5NTCFPLSg4wC/ehwfY/U4GN3kFgMBymQkfa
	 IZAInFCK19wvsWyDDBmiOsWmi1YHSWG4YhEQRjlciqAFp9ShHie4wRf6lYXTVuAm7VXHITsZOdxo
	 L/QZWUFds70c7VcDmS4sxUvSaEh7BG3fYSPpEI6QgYRraSdqG11hayJLI58Em1jvsVXjnCeRyMm4
	 +16nmPt/DDYtPDEv0FlvQel2HvjSKKhOb6zrBqiU72osobQNz+ZWXDD8ZTlD2jbHGSglm6SJ7dHH
	 m6Hmbguu2fKucQzoPW02Q6mGfgVBWjk94tvhWSh6P0FPaY8P87Sl3QQJe19lRj9Y+j4/PbGMoX7V
	 HIx10jzI5zUb6H16fP6aMDi0TgpW3n4coMi5f1MpuFC6PYZOz9281ICh0VmRwkj2VdMHHQPFUiGw
	 as5O8xivMmWj9x6lSGIR9BNC8gAAVgwzco7ve2aUcQya/R9awt0X4fH8rf76PF0oU34JGsDUAWWZ
	 H9EC9K+X0aReb8xn85yq+3wheyosx5B1voXmpGV1+1t3WFMoTethqpY+bZCepj
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: linke li <lilinke99@qq.com>
To: leon@kernel.org
Cc: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of re-reading it
Date: Sun, 10 Mar 2024 20:15:25 +0800
X-OQ-MSGID: <20240310121525.68804-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240310113306.GF12921@unreal>
References: <20240310113306.GF12921@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to emphasize that if the value of orqe->flags has changed by the
time of the second read, the value read will not satisfy the if condition,
causing inconsistency. Given that there is already a READ_ONCE.


