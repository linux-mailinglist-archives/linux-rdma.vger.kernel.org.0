Return-Path: <linux-rdma+bounces-4878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8A975171
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C96C1C22734
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EC187322;
	Wed, 11 Sep 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tISvkS1F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654B73477
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056434; cv=none; b=MpweYPVeutionF32h7kp2y0hUqCEIoMdk+dZP9OTug4sWHaXsdrxBoM/sOH/OjlXx6zqf6IY1bvjoDiQx5/Vc0Tr19fsdO2xopcQJvgRNzue07+KKjGGm+xBqJulox3m5v0R44V3oWe7mcFnvRi+3oMNGFBKWtRaZMNHXimou1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056434; c=relaxed/simple;
	bh=jzOnqptmSoMAV5/WP8vAjggyoJKM33TZlc7PSh198bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W2rzkArwns+Bz4fdTbVUwtA1Tllo8iEk04Y0oubLlbZllvqRY+Tfn/jR8E+y74PRAAyz/6O78TxUSxhvYjzxeAAtdWU2wmiUATvOypZQI5WtKMM9hh2Ji2oNArMsh+phBB84cVEyRBikZr3B+dM781MmdSSH/RlQF/okaEJtslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tISvkS1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82A9C4CEC5;
	Wed, 11 Sep 2024 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726056434;
	bh=jzOnqptmSoMAV5/WP8vAjggyoJKM33TZlc7PSh198bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tISvkS1F7DOoxWIjrKUnTsYvaNd9ipGZ1YJmkUJyiGNsKZBeLi2bGIRNa/imPwK5v
	 dCq+sotf6ubGZZRn6/pGzHGgbJLkIc4pyUC4f1dsn+UOmmOFdUbtHKfGVn5zq0Tvi5
	 gQx1snACf9hUI76PpIFWI6sP5A5mxBrpmysAcHPhiS2EEZF59cRzX48CT06+FTk7m1
	 taz2KDGeP/8/+3Ls41WuPoBqNPNZplflepRhHLGMLuVnc1n+crYr0VROxzFlJs9DNj
	 0XIJe1OsFV5ghsXwJmqDbZXWTgbTpZ/d/1uFRJmwhWwSVHncJH/iQbZkA4XCp5daO/
	 HHevCtrMDLWgg==
From: Leon Romanovsky <leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Guralnik <michaelgur@nvidia.com>
Cc: linux-rdma@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com
In-Reply-To: <20240909100504.29797-1-michaelgur@nvidia.com>
References: <20240909100504.29797-1-michaelgur@nvidia.com>
Subject: Re: [PATCH v2 rdma-next 0/8] Introduce mlx5 Memory Scheme ODP
Message-Id: <172605642967.3680284.18383412702856675575.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 15:07:09 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 09 Sep 2024 13:04:56 +0300, Michael Guralnik wrote:
> This series introduces a new ODP scheme in mlx5 where the FW takes the
> responsibility of parsing and providing page fault data to the driver
> to handle the fault.
> As opposed to the current ODP transport scheme where the driver is
> responsible for reading and parsing work queues and querying mkeys to
> acquire needed info to handle the page fault.
> 
> [...]

Applied, thanks!

[1/8] net/mlx5: Expand mkey page size to support 6 bits
      https://git.kernel.org/rdma/rdma/c/cef7dde8836ab0
[2/8] net/mlx5: Expose HW bits for Memory scheme ODP
      https://git.kernel.org/rdma/rdma/c/6cd9171d04cff7
[3/8] RDMA/mlx5: Add new ODP memory scheme eqe format
      https://git.kernel.org/rdma/rdma/c/64c68385a39bb6
[4/8] RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
      https://git.kernel.org/rdma/rdma/c/8c6d097d830f77
[5/8] RDMA/mlx5: Split ODP mkey search logic
      https://git.kernel.org/rdma/rdma/c/7f91510af938b4
[6/8] RDMA/mlx5: Add handling for memory scheme page fault events
      https://git.kernel.org/rdma/rdma/c/e4fda2320f8e6b
[7/8] RDMA/mlx5: Add implicit MR handling to ODP memory scheme
      https://git.kernel.org/rdma/rdma/c/6f2487bfafce5e
[8/8] net/mlx5: Handle memory scheme ODP capabilities
      https://git.kernel.org/rdma/rdma/c/5416992c011080

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


