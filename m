Return-Path: <linux-rdma+bounces-11680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB12AE9D4C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55EF7B5CAA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FC2750EC;
	Thu, 26 Jun 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8QD50c8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799B20FABC
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940070; cv=none; b=mRKxYHG9ZyJsSnihhfahsYYXuuzrTyghd0IagNBFfX792KVukDGuyjmAC+A8EFjd2jXujOxZMlPBGgKPr3AZV5u2YeYfPPx9MA0p07AHTiq9N50UpbOw5BV0qQNgctImxBeQ2EJSZ7Y0ViK5U7C4Hu2404kjIU28GRfNZ7SDG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940070; c=relaxed/simple;
	bh=PWXkwh2+emJR+KPJRBn0KdEgOhDidqcXLoJZ6yBy5ew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TlMRxrCRzPanrRzqcIGUlyBb9PgEX2+baUrFhA6CNfchUYlwGuvgJvx806z3KU/LC8Iy1QhHToeUEsAY3pCaZnxlId75aLLitOmp24G0FxeJG+3aXCKuwrtwdutWJeHAlyaCQeJkI2TvWUSBy7W73MXYOzUOLK1AZIBbH/otNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8QD50c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8491DC4CEEE;
	Thu, 26 Jun 2025 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750940069;
	bh=PWXkwh2+emJR+KPJRBn0KdEgOhDidqcXLoJZ6yBy5ew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g8QD50c8odJscuqd3MCEbFw9w+RW6+wIThHsCdsFHVIdD7qKA/2ofgWcqMZjf4qYh
	 UEATYj6Yin88hLPbibDLE/1Eyh5SOnHJswEh0RWsQGOF9eLJ5O2GBUJaf9KIY0rT4K
	 w/ik/USKwoctzxEF80CUbK53e2UHhYxSG8Lk/TbooUqehZMy+/81QJTnnmmrBzqJdz
	 gDh+Vx2OvKZynEzxMKfgmt9j4wfVWKpFCgLQW7hOvcz/JMJkveCfJECuhFMXL4KeS+
	 Q5kyUa7RucE2lJiKiC3bkvQ2YZquSdwgFDwG/8RyJPOiOfwDdWOH0UXyzB1Tro6ex6
	 K5Ah4xlSN1VUw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>
In-Reply-To: <cover.1750149405.git.leon@kernel.org>
References: <cover.1750149405.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/3] Add net namespace awareness to device
 registration
Message-Id: <175094006703.824609.16848118654001479272.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 08:14:27 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 17 Jun 2025 11:44:00 +0300, Leon Romanovsky wrote:
> >From Mark:
> Introduces net namespace awareness to RDMA device registration and update
> relevant users accordingly.
> 
> Currently, RDMA devices are always registered in the initial network namespace,
> for example even when their associated devlink devices have been moved to
> a different namespace via devlink reload.
> 
> [...]

Applied, thanks!

[1/3] RDMA/core: Extend RDMA device registration to be net namespace aware
      https://git.kernel.org/rdma/rdma/c/8cffca866ba86c
[2/3] RDMA/mlx5: Allocate IB device with net namespace supplied from core dev
      https://git.kernel.org/rdma/rdma/c/611d08207d3135
[3/3] RDMA/ipoib: Use parent rdma device net namespace
      https://git.kernel.org/rdma/rdma/c/f1208b05574f63

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


