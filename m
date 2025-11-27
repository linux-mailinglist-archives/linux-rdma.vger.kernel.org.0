Return-Path: <linux-rdma+bounces-14803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E013C8E33F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C96934C2B2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF6632E69F;
	Thu, 27 Nov 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvBOuKP9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31CD32B9AB;
	Thu, 27 Nov 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245414; cv=none; b=ZSVM2GqORQblEnAn6YzDQwmPz236kBjZFEOQ+o8gyOJMuPSLMy0SO6Sg9+wkoWIBH5P8tSM3BM8MfxsQ57NCjqhwc8iid6hZxhnhoHZR1zUilCMLscNBVIDdnzfAvjLTqHwE+ysLUVLDr16o/1uhn+KGRlxn24o2NJi+n8Cb6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245414; c=relaxed/simple;
	bh=C7MVLvgjgS9a0L9qwa1j+bF+TVGED+r0Nji9vIH+zOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O939FoiE3kZ/AdAmX8c48y9zPPTYE+nxpkX7HdKHdk3ezKg6fm9VbMSRaz9fXH9HcA467EsWDEbCwAD+z0/JQ7yxokRLo3wUvbg2252wsIJOwqqKPV+IxOzwHeU0x/wgD+3U6YWFDDjT/TcY3+27YO1UA07IoOh57vKJb3DKdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvBOuKP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C511CC4CEF8;
	Thu, 27 Nov 2025 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764245414;
	bh=C7MVLvgjgS9a0L9qwa1j+bF+TVGED+r0Nji9vIH+zOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YvBOuKP9HpqWLMGBdXEknJfm+KH/82MMdqtTjarygEBS23Uzb67F4pm8JLpJXQkR9
	 pOOjAnnxZowXT53bzbN+fOpbYxTT5sskcpZ+BxbmJgkiuqmAWNDnq5dVL47atfNwPd
	 ONzthabtx7l1GdAgWBIO2HAZ6KiqwYheVDzVkTnNXHWumG1dNP2Ev/Z5zEGa/JdSEj
	 l4xxyuK845wart7W6npz5IRhiJa2tJq+Pme6NBentZbEMNOmxv87moofnSA2Fn44/5
	 8kkNuVeXCEpUPVdQ3WRmhy56pyZY7QXBlWOS1vTuk2pRSU0yC+I2PYdBd6pKt1U5WE
	 FhNAELA30d0Jg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bernard.metzler@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org, 
 linux-cifs@vger.kernel.org
In-Reply-To: <20251126150842.1837072-1-metze@samba.org>
References: <20251126150842.1837072-1-metze@samba.org>
Subject: Re: [PATCH v2] RDMA/siw: reclassify sockets in order to avoid
 false positives from lockdep
Message-Id: <176424541100.1853134.12455314070226986319.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 07:10:11 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 26 Nov 2025 16:08:42 +0100, Stefan Metzmacher wrote:
> While developing IPPROTO_SMBDIRECT support for the code
> under fs/smb/common/smbdirect [1], I noticed false positives like this:
> 
> [T79] ======================================================
> [T79] WARNING: possible circular locking dependency detected
> [T79] 6.18.0-rc4-metze-kasan-lockdep.01+ #1 Tainted: G           OE
> [T79] ------------------------------------------------------
> [T79] kworker/2:0/79 is trying to acquire lock:
> [T79] ffff88801f968278 (sk_lock-AF_INET){+.+.}-{0:0},
>                         at: sock_set_reuseaddr+0x14/0x70
> [T79]
>         but task is already holding lock:
> [T79] ffffffffc10f7230 (lock#9){+.+.}-{4:4},
>                         at: rdma_listen+0x3d2/0x740 [rdma_cm]
> [T79]
>         which lock already depends on the new lock.
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: reclassify sockets in order to avoid false positives from lockdep
      https://git.kernel.org/rdma/rdma/c/3a2c32d357db8d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


