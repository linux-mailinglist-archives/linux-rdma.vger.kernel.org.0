Return-Path: <linux-rdma+bounces-2152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA78B6F78
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1D71F24452
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F96813D257;
	Tue, 30 Apr 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICX2Cigd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7213C8E9;
	Tue, 30 Apr 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472317; cv=none; b=r1v+dffdPZeHl7rFRKbHiZsU1GqVAL/F2HavQYuZM40vQNebO5q/nfB5GtJ04My9Dh1hAmTTkpXF+tiCRND+4l/lK/S04M114GT0pmXvnNzttVe354b3I2Kf2Pf6myXx4xna5SwoOj+4ZIVV8R/tMGGDOnoJRuiHqaqwO6Vtpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472317; c=relaxed/simple;
	bh=LEbDsZpEXt7V6w2COx1sw01ELviITYWcN/T61UpCyjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sToIAz/mjrgqNRGDeuF6K7DmqyT+5i/GAF6QF92sBsBjUglsftp2mA2BVSyg1CWRHdG9CHG6tAJWyCiiW5rQn9I9RW+zSHqMSTpAD3uNYgza/pbMsHZiTIpP8HSE+9XMByh3E0VCpbXVoP00EyGqPoltnBBQDy2F7tYvSwXGGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICX2Cigd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D482FC2BBFC;
	Tue, 30 Apr 2024 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714472317;
	bh=LEbDsZpEXt7V6w2COx1sw01ELviITYWcN/T61UpCyjY=;
	h=From:To:Cc:Subject:Date:From;
	b=ICX2CigddwrDGCc3lf5CiY1tPXtt9B/uWNe54fSDnv8IU+34jA+Gu8BRSenAftLks
	 jcdacH00n4dPBwZIeun5q+4alb86mmohYfl/hwP0KDGLL3u4H8wpXDlUPtksVNqIZG
	 6jtOnHiVAuLcrTkpltlrnwLfGVZUNphY3PGM1YQ6jy6/o2yUc4eT5TW7q6rd11NRW5
	 0tQtuhhLtAtnrTpu+ddfzMRbfguosE9DFbax0GVqCpa0/nG62Ay6HY5cT6vTPdOErM
	 UIdhZhHFftpfc/KI2DW4Ko9V3/ZA/XG9+GurAe2EnfcH9xUzd3YXPk53FsFhT458pR
	 f4MJtTwm82riw==
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-netdev <netdev@vger.kernel.org>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH iproute2-next 0/2] Extend rdmatool to print driver QPs too
Date: Tue, 30 Apr 2024 13:18:18 +0300
Message-ID: <cover.1714472040.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

This series is complimentary to the kernel patches that exposed to the
userspace the driver-specific QPs. 

https://lore.kernel.org/all/2607bb3ddec3cae3443c2ea19e9f700825d20a98.1713268997.git.leon@kernel.org

Thanks

Chiara Meiohas (2):
  rdma: update uapi header
  rdma: Add an option to display driver-specific QPs in the rdma tool

 rdma/include/uapi/rdma/rdma_netlink.h |  6 ++++++
 rdma/res-qp.c                         | 15 +++++++++++++++
 rdma/res.c                            |  5 +++++
 rdma/utils.c                          |  1 +
 4 files changed, 27 insertions(+)

-- 
2.44.0


