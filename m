Return-Path: <linux-rdma+bounces-11992-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DCAFE030
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FEB1BC8978
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 06:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CE0272E71;
	Wed,  9 Jul 2025 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZPqrncE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60C272E54;
	Wed,  9 Jul 2025 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043344; cv=none; b=KQuW5R+yaSLwKpoqXxTeEqgvRB79jnj0lnWQdcvJTJ+1WwmDaNUH+KwhqbR4MESD1LdgWT67i8TcP9g7qOuLLEMmN6JbR46xRSulN5KFQNwIarhzi/Z/5LlD5D/gPvQBn4ePxvKRS85d9tZSldv4bkCqzkjTOfqqC224uy73eI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043344; c=relaxed/simple;
	bh=fDsAX1WE2fnZBdHvvagihDKLN5a8ILk8LO2XelAbMKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6AZ0rd3JgwCgoU60z6ctsbwcnU9qyMuJ6j9MztAvaI7zsGWKLw8sF9yP9RntVfJQORZ+i7ixdmLSGkDKa5Cf8zZ2oXjW6JV0xXSf8LHeQAEOvldv4G1pYxhkiWC/OnwLbhRqKHDjBpUzgLwDvb42Fwr/hBfL5vD60UMm1uvbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZPqrncE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C3C4CEF1;
	Wed,  9 Jul 2025 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043343;
	bh=fDsAX1WE2fnZBdHvvagihDKLN5a8ILk8LO2XelAbMKw=;
	h=From:To:Cc:Subject:Date:From;
	b=lZPqrncEEDSEEhFzdUBbjNdoPEYlIGUEB8h9OcXeikQ5LjqVG0b/p5C3ibM7TRIV/
	 U3pqjkMFoehSpwd8AwRiayk2Q99l+zeraS2GLkZQSnvYexvEPg4iowHYFJBNC9lPan
	 P4m3Q0vwAXVt9R9p5KUgxRrS+GzIJpJhGx+ZW4GK/CDjAg8WxBh7ffMIkLw8UJgsKX
	 U+aRDGLpWIuPdTc7BWd0b9fVD207ZXScnnX/Mgf/AOlw6PRqWnvSYXD2ApoAdEDFcZ
	 H2Ni2gjcl8vv7q/3tfbrR9L/C0ThhPFFIrbBNQW5IlkdHq/QnULF58x/48RAu0mgvh
	 AmG6A3UuFybZA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 0/4] Optimize DMABUF mkey page size in mlx5
Date: Wed,  9 Jul 2025 09:42:07 +0300
Message-ID: <cover.1751979184.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From Edward:

This patch series enables the mlx5 driver to dynamically choose the
optimal page size for a DMABUF-based memory key (mkey), rather than
always registering with a fixed page size.

Previously, DMABUF memory registration used a fixed 4K page size for
mkeys which could lead to suboptimal performance when the underlying
memory layout may offer better page sizes.

This approach did not take advantage of larger page size capabilities
advertised by the HCA, and the driver was not setting the proper page
size mask in the mkey mask when performing page size changes, potentially
leading to invalid registrations when updating to a very large pages.

This series improves DMABUF performance by dynamically selecting the
best page size for a given memory region (MR) both at creation time and
on page fault occurrences, based on the underlying layout and fixing
related gaps and bugs.

By doing so, we reduce the number of page table entries (and thus MTT/
KSM descriptors) that the HCA must traverse, which in turn reduces
cache-line fetches.

Thanks

Edward Srouji (2):
  RDMA/mlx5: Fix UMR modifying of mkey page size
  RDMA/mlx5: Optimize DMABUF mkey page size

Michael Guralnik (2):
  net/mlx5: Expose HCA capability bits for mkey max page size
  RDMA/mlx5: Align mkc page size capability check to PRM

 drivers/infiniband/hw/mlx5/mlx5_ib.h |  77 +++++--
 drivers/infiniband/hw/mlx5/mr.c      |  10 +-
 drivers/infiniband/hw/mlx5/odp.c     |  31 ++-
 drivers/infiniband/hw/mlx5/umr.c     | 306 ++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/umr.h     |  13 +-
 include/linux/mlx5/device.h          |   1 +
 include/linux/mlx5/mlx5_ifc.h        |   4 +-
 7 files changed, 387 insertions(+), 55 deletions(-)

-- 
2.50.0


