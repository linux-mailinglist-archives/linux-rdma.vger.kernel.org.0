Return-Path: <linux-rdma+bounces-9834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E37A9E2DB
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614A518972CD
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Apr 2025 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA8252900;
	Sun, 27 Apr 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0GrFQVK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD292528F3;
	Sun, 27 Apr 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745754701; cv=none; b=d1B8ahSVQVa+AHUuTIwzCkymZsbIYMY24V/xBvCS2EikucpEBkcxHK9j51vU+abgBGC0oeSESa7y1YpnKocnsWtYPcM3v+jes191xC9fvVjcYzaZMsdlqNb03kst8QRSXwaHQgXoUyWumeAkQFZGRbnKVB/MP0LUiarceWYyxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745754701; c=relaxed/simple;
	bh=1k+xOpUEfnhtcxBkF6lYKZOL8VcrasBDIMWwD+uGyBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=raGFeHTcLuEVGu7A/Nn61ll14bOzhEeMmoHD68fbvrxAlu3aUHzqTK55+6jgkvcj5cvWrjewiglcNtnVBJUPPYl/1cLy7BhfEVZFSKbDgpnHAr7MYVkDkNslC/eXx9ARxnhiAiXeohvW+845G5bTO7wS0ca6kLFqLRKBcCG2dPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0GrFQVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B93C4CEEA;
	Sun, 27 Apr 2025 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745754700;
	bh=1k+xOpUEfnhtcxBkF6lYKZOL8VcrasBDIMWwD+uGyBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N0GrFQVKFslLbx1ODGWXGi04icoFMfeh0SGFyjoFSWsDXZrVer7NMcocy5thXtZb3
	 svdfi80/eyNRHg+GDFOyf79Pktn5E9Od3K7dkOgNoI/wv/pjkbL0Pn1v6DO6Jj+cYX
	 yYh94adyQUx1x/K3dYGc3kufMJdoYPa0302jyd73SkOkEUvOAep1hpBWI3+vhAid1w
	 Hcgv7fVTZppxCsUtpCsTzv6x2exoHabuwIGkG4pX4xptD5UH3uXm7hdD+OtxtdjAy4
	 PSwNt/XNrvKv+UUiUZ0/Ijmed08DDpjMSTGVfaXmxjxgAcedrRFLS7xhKBJaqO+VPk
	 42sqFsj8/OYPQ==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Kees Cook <kees@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250426061247.work.261-kees@kernel.org>
References: <20250426061247.work.261-kees@kernel.org>
Subject: Re: [PATCH] IB/hfi1: Adjust fd->entry_to_rb allocation type
Message-Id: <174575469757.624502.17135732008958282347.b4-ty@kernel.org>
Date: Sun, 27 Apr 2025 07:51:37 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 25 Apr 2025 23:12:48 -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct tid_rb_node **", but the return type will be
> "struct rb_node **". These are the same allocation size (pointer size),
> but the types do not match. Adjust the allocation type to match the
> assignment.
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: Adjust fd->entry_to_rb allocation type
      https://git.kernel.org/rdma/rdma/c/3db60cf9b7da4a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


