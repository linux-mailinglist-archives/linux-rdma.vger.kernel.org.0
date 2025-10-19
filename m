Return-Path: <linux-rdma+bounces-13932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD0BEE371
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C633E3014
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 11:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4728B4FD;
	Sun, 19 Oct 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPnqQNmv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE31E51FA
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871717; cv=none; b=OrfTOoPFuk5TqSznzUjEOrDJh0vnbGTkwBbzoZ1zI0hHJELi9D82DdAh72mVjO2jxZ/LVO1KI53CK7078tPiXs00fuoo+0R+wEUDI4AdKOyY9YiNXfQxi79b0NK5MaT1MB6H77B+IOvV4P41EtSvtQ7RFe6+0tUfsI0uKeBhwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871717; c=relaxed/simple;
	bh=4En01FUabUOOd0m0BsiP3HE415rq73bn1hCvpDjQO9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OMx0Vb4x8hOJCwb1Cbgthm1sJN53ASNi+ayFx9Wdb9CBBA37TD51wMEm/6op4jX06HQkMNyowkDwx6Bzocx7zer5ZGqCYhtTViorPOiaZGhbwQOYPu2/sW/QzmbCRD7mfdfMd4dEgwVIb8JtvVVDBth2tNtBdsY5LrpwC/zSkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPnqQNmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA90C4CEE7;
	Sun, 19 Oct 2025 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760871716;
	bh=4En01FUabUOOd0m0BsiP3HE415rq73bn1hCvpDjQO9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iPnqQNmvsSSfUdoAEahwuBLLyX50WySoHOrYmTG0gpjMm4NBF2bui9n51kzoFeiSm
	 9CS7Vc4+p7YvXeKBdRoZoUPb1uJoV1E3grJunIQ9XvsVpH0uhUUcSzZFgVZ2I1btSw
	 uiWuM6ICcGbQ5VmtQNY8gTjtbSMdJ3MfpkDylt+0kqvhHEKas2lW+pmaCkRTnITYFp
	 4X4fLSJS+EHLExWJK8Eg3HFl+0hUnIzolGBWoRIGxRMPkLlpN9X0E+xFN1a1cFT5nG
	 COXcsB3fq9C2cKn8fdNRHNcDFP57k7QXIJLfIWzPbJfFN0w7t+uKNqUhLixGqd3CVG
	 +GoYCw+rAgk2Q==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, Jacob Moroni <jmoroni@google.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
In-Reply-To: <20250923190850.1022773-1-jmoroni@google.com>
References: <20250923190850.1022773-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Fix SD index calculation
Message-Id: <176087171352.148920.9040275096990248019.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 07:01:53 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Tue, 23 Sep 2025 19:08:50 +0000, Jacob Moroni wrote:
> In some cases, it is possible for pble_rsrc->next_fpm_addr to be
> larger than u32, so remove the u32 cast to avoid unintentional
> truncation.
> 
> This fixes the following error that can be observed when registering
> massive memory regions:
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Fix SD index calculation
      https://git.kernel.org/rdma/rdma/c/8d158f47f1f33d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


