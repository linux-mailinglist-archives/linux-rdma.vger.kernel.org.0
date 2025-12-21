Return-Path: <linux-rdma+bounces-15128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737CCD3DBD
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 10:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37BBA300A1E9
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE424677A;
	Sun, 21 Dec 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kft6JZa5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F21227BA4
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309589; cv=none; b=qleWDqNsPbLFUsR0qI4ErnO+6rwZEiPWQt1csB2MG4ksgequjE8MFX7aWDgZ9hQhxM+iUPyJaVHBZiTNUBv8VB0dfzgFASQu1aCU54mWuu+kC6o4RxxCfeS1WzQJmIRGLxppzCAFWZMod5/AUKXStxCTnhxQhU5WgCkmBv5vw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309589; c=relaxed/simple;
	bh=h7lzSfstWw21yhdsGIikiBqtadieXl3ZnzpYhyFpdx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WhPn9eMHQRUCyr1EOqWbGAO34zSxbOZCyTIyIdp5RrO6Iitc4Cg+2XoMpINAt0A0YAsMXtBOIn8ihx4+T+lzNPniZbHho7THSFhMuZuNW4JD3llMHAEl5emdr/PpxIyANs8jjdAVa87NcmwMShnzV5HJfxeoeo0Rpca0vSfL6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kft6JZa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDA8C4CEFB;
	Sun, 21 Dec 2025 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309586;
	bh=h7lzSfstWw21yhdsGIikiBqtadieXl3ZnzpYhyFpdx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kft6JZa5JZlRg7zU3Ey1c5OIXEvkzVvAo8t++ggtphuv9q65eGCkFYIH6iKJY0z4I
	 dHPk9zO7YMaU6YyWYI32JjGAoTYkjqpSJXO0hX9AZ4QFN+mt7WNKpC7cP99lj2VobG
	 uzUUZNK5V05ctm86692yB1Hu6dm6M4phUW0ynLWXoFVBOh52enEb1YLdb2HvgQqUbn
	 NuNGrz+MJKFW56ybb1XTQjwXPtLTxZtb6rqWy9YzDN1h6p8VuP5/JeXs0WiOjrvcsH
	 7Q6oJSHLI/WSSgB3fbvaD5C5JkFQuW5lNlbediMB875xxzmzhIVO6l9QRB3hOKnPen
	 /cjSorZPIUedw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, kalesh-anakkur.purayil@broadcom.com, 
 selvin.xavier@broadcom.com, linux-rdma@vger.kernel.org, 
 Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: alok.a.tiwarilinux@gmail.com
In-Reply-To: <20251217100158.752504-1-alok.a.tiwari@oracle.com>
References: <20251217100158.752504-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Fix incorrect BAR check in
 bnxt_qplib_map_creq_db()
Message-Id: <176630958412.2404173.9823044913296121202.b4-ty@kernel.org>
Date: Sun, 21 Dec 2025 04:33:04 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 17 Dec 2025 02:01:41 -0800, Alok Tiwari wrote:
> RCFW_COMM_CONS_PCI_BAR_REGION is defined as BAR 2, so checking
> !creq_db->reg.bar_id is incorrect and always false.
> 
> pci_resource_start() returns the BAR base address, and a value of 0
> indicates that the BAR is unassigned. Update the condition to test
> bar_base == 0 instead.
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Fix incorrect BAR check in bnxt_qplib_map_creq_db()
      https://git.kernel.org/rdma/rdma/c/145a417a39d7ef

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


