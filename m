Return-Path: <linux-rdma+bounces-14261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D0C35CC4
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 14:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E14994F70AB
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3D31960A;
	Wed,  5 Nov 2025 13:17:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D923195FF;
	Wed,  5 Nov 2025 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348655; cv=none; b=Ew4M9vqMOIdfA6gAqdzrPQfL98F+Az/dQ8hbiU0jGrrCb0mdKxu3Y6BA93kkeUJKawWc62PBfyxcYps3t5Cm1wNKW37BygcNeNI7EQeJ1/nSOjopTUshPrs6bjHPU2eZlyuSrLj5cfndqy/HRGqrRoeSZ/G4Xhs4xcE0zrvAzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348655; c=relaxed/simple;
	bh=i24wx9gvYP107ek59FmvUJu/NTTbFUXB+uauA3zsGf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J1hX21J1Ii3z7Uee1056zfmxI4NVlLpUgp6szgAnkASXE1YShiuJPyx6EVh8i0qVNFo7K5LnLwGt5vuaYhAcCraHUjtmFRI7TiQPswqqEAK3NmHChL/eUJp8EJ2fuDxMmDFlWygKuz+HgaRDXK06gXv2l45UiwBJvtoCINOaM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACCEC4CEFB;
	Wed,  5 Nov 2025 13:17:33 +0000 (UTC)
From: Leon Romanovsky <leonro@nvidia.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20251105045127.106822-1-rdunlap@infradead.org>
References: <20251105045127.106822-1-rdunlap@infradead.org>
Subject: Re: [PATCH] IB/rdmavt: rdmavt_qp.h: clean up kernel-doc comments
Message-Id: <176234864952.11762.6085508512401726797.b4-ty@nvidia.com>
Date: Wed, 05 Nov 2025 08:17:29 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Tue, 04 Nov 2025 20:51:27 -0800, Randy Dunlap wrote:
> Correct the kernel-doc comments format to avoid around 35 kernel-doc
> warnings:
> 
> - use struct keyword to introduce struct kernel-doc comments
> - use correct variable name for some struct members
> - use correct function name in comments for some functions
> - fix spelling in a few comments
> - use a ':' instead of '-' to separate struct members from their
>   descriptions
> - add a function name heading for rvt_div_mtu()
> 
> [...]

Applied, thanks!

[1/1] IB/rdmavt: rdmavt_qp.h: clean up kernel-doc comments
      https://git.kernel.org/rdma/rdma/c/a658c6fc9cc2f0

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>


