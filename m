Return-Path: <linux-rdma+bounces-8016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D1A40D67
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121373BE1BA
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDE71FC0FD;
	Sun, 23 Feb 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKcCkXUJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAA376F1
	for <linux-rdma@vger.kernel.org>; Sun, 23 Feb 2025 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740299758; cv=none; b=e+qKj1gfAkZcMTLSXf3ad/RCA4pOw12Z5SlPdY9cWfD4vs2lHlBOqZNd5lemMgPmQpQgGCSWw/jylRm/uZh07vVot96GG5LG/nyq1NP7wCltkMaT4fFtofk3+YSOlGCJkPy/vAYi/bCm2snhXByoHHxhWM9sX8Aud64frsHygms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740299758; c=relaxed/simple;
	bh=u3/gIF4R9ZKfeqgA0cPkAxz7G96C5fNZ5GQgNnnk1bA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VqmnzJ9dHWVPNe6ZRa1RpFuiyT9mZZDEIM6+8yuDk+EAyhyiYEEv/T9J6RezSbWX+b3MHRERX2wkg/8HhG3FifSpiDHs0HqJr3tq19wnLhdUdqcYCpnQ7y8oXRa6DRUm0SLiWZr1OrrpHv28YG3aPu8hy2q/D3x4qfoHhQdrB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKcCkXUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06424C4CEDD;
	Sun, 23 Feb 2025 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740299757;
	bh=u3/gIF4R9ZKfeqgA0cPkAxz7G96C5fNZ5GQgNnnk1bA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rKcCkXUJB4c0dgv7ITqkBrX6uWWIL4pCb8h5QRzv/DSKrokvV6n7V9xenioqGKxEG
	 TVP02Fyai1NCSxuOtaukpJID79oRSbQkDw3cXcIU6LSbvsZN+4tUq/o3rkW+ZV6vJB
	 iQqu35kIW/tZGm1kzjAr2seVc4J7UyAqMiRu4EGkV1aYOFiO00J5/NwS1FtpY0Mns7
	 fYJ7Y/wHrLMjH/+Xy9nYkUQLcdVIu47a3iT2VvKBhlC/eRhyjhGuNerX44aTqEAOCE
	 6ycpRzjtTOHmZpmjUmEHPMP2eXXuJ+fjSJserk63/lJ4kN/m9FJO4mbcQFPt8WdPMA
	 n0IUI/aFSJQcg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org, 
 Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <25dfefddb0ebefa668c32e06a94d84e3216257cf.1740033937.git.leon@kernel.org>
References: <25dfefddb0ebefa668c32e06a94d84e3216257cf.1740033937.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix bind QP error cleanup flow
Message-Id: <174029975417.496289.13811109051862973146.b4-ty@kernel.org>
Date: Sun, 23 Feb 2025 03:35:54 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 20 Feb 2025 08:47:10 +0200, Leon Romanovsky wrote:
> When there is a failure during bind QP, the cleanup flow destroys the
> counter regardless if it is the one that created it or not, which is
> problematic since if it isn't the one that created it, that counter could
> still be in use.
> 
> Fix that by destroying the counter only if it was created during this call.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix bind QP error cleanup flow
      https://git.kernel.org/rdma/rdma/c/e1a0bdbdfdf084

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


