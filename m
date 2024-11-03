Return-Path: <linux-rdma+bounces-5706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F19BA675
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 16:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AE11F213A1
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B771716EC0E;
	Sun,  3 Nov 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGaF6FwK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB14A1D
	for <linux-rdma@vger.kernel.org>; Sun,  3 Nov 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649049; cv=none; b=YYBI0A3hGNSCCPm5UZalb4xgPWydhlhbq260walrzLkwW3F8I3btBU/wMoGX8ULaHfsmUfsruOzsqo7ZaApfmbu99aRP9/lUfGNjd/GKyWKhzJx/e5QZQXPPk/xivPW/W1OMAS1vc7fr+IdyKaRnAwbCDVM5PqIcpUlPtfJSCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649049; c=relaxed/simple;
	bh=qA17RjaJ80OnouGLsMGlcuWJgv8qNIUeUQK7maFLdQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mGQSIuxvpfAiBr7JrukfPsQKVyrCfQoLu4etBBKLrlNVO0hZROa+i/VYra9GKUMdFtMdr8qm2G8GmwNi9Kkrda2AC+VLDwe1Z47GC4slj0oID10E1UjJaG3+BUoR+CiAo0av4aroKPr0faKxO5PrJO1NpSnEQ/Suyv6oKHtr2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGaF6FwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9772C4CECD;
	Sun,  3 Nov 2024 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730649049;
	bh=qA17RjaJ80OnouGLsMGlcuWJgv8qNIUeUQK7maFLdQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jGaF6FwKPmh1o8gjODCZmuwudKwwgU46vSCa5T27nZM16xGcGPpKk+BZ/CJNbVxy7
	 cwSrlD2crmPD366OosRdBydKouIf2VYeWjitaDsNVyUpjQ2yN5e62Kky0Rj1QWZRN1
	 OklRzokcOeAA6UtUUeDf8YmP1omSlG4UQ8QHZn9e8rgoaMMSBpY89Jdzvqv4j/Nm5D
	 hBQzQQs0EpRKuV4g2qk9LrzD+U/kal//baSb8vH2mlFn+Po/bm/ZjX7j41/DeTCr5y
	 EwdZzap4WZhKKmxu/O+l9i1Q7eZp14sqs3VtTAkZ815SIJzH/WXmt/DoyKviJ8+nZE
	 otOXRU0EqRn9Q==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com, kashyap.desai@broadcom.com
In-Reply-To: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2 0/4] RDMA/bnxt_re: Debug enhancements for
 bnxt_re driver
Message-Id: <173064904584.148087.4757398801398806469.b4-ty@kernel.org>
Date: Sun, 03 Nov 2024 10:50:45 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 31 Oct 2024 19:34:39 -0700, Selvin Xavier wrote:
> This series is the first set that enables few debug
> options in bnxt_re driver. Implements the basic driver
> data collection using the rdma tool. Also, implements
> raw data query option to get some of the Hardware specific
> information for analysis. Added a debugfs folder for bnxt_re
> corresponding to each PCI device to display some of the
> driver specific information. This will be enhanced in future
> series.
> 
> [...]

Applied, thanks!

[1/4] RDMA/bnxt_re: Support driver specific data collection using rdma tool
      https://git.kernel.org/rdma/rdma/c/955e80fc08c2ae
[2/4] RDMA/bnxt_re: Add support for querying HW contexts
      https://git.kernel.org/rdma/rdma/c/c25a9c4e132418
[3/4] RDMA/bnxt_re: Support raw data query for each resources
      https://git.kernel.org/rdma/rdma/c/fe937d11b6062d
[4/4] RDMA/bnxt_re: Add debugfs hook in the driver
      https://git.kernel.org/rdma/rdma/c/07849569546ff8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


