Return-Path: <linux-rdma+bounces-11470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E896BAE0817
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963BA3A4F89
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2E226D17;
	Thu, 19 Jun 2025 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDRP89Vc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106371AA782;
	Thu, 19 Jun 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341521; cv=none; b=eXfbzmcqXB75xhB03r+5ZVqH8QPdxYx+Zs46X38oRFAHdoGoQQOqLiMCWT4gWgt4Ko4FibjkVy+Wt1+yLux/ZTaFvBD7sQrXkhsFDndxY/qcnJ/OAyubFgB/rGOD+3igUg2lD7fbsS/Il2bZXnSWke4fRnFN25QYwXcLolKvyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341521; c=relaxed/simple;
	bh=nXF2I2bKb1tLkvFrrhKJ32SL+pq8UGfs2ifze+p2r44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a+7WLGs1FIMXCTeysK+cBY++PcfB8LCNBJRRIB/fA+9hG1BE7HNb3TVg0+b2Ya6nKF3Q3c6e+vtNzLF7zDAc9AK403PvZPcmGcKbOaQbt9P/cLFXZ3O08jaCrOH4sFxRXs34SHuZ0+ETgZgzyW/u7igKK8a3fJlIe9TqT9VjxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDRP89Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB096C4CEEA;
	Thu, 19 Jun 2025 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750341520;
	bh=nXF2I2bKb1tLkvFrrhKJ32SL+pq8UGfs2ifze+p2r44=;
	h=From:Subject:Date:To:Cc:From;
	b=pDRP89VcjXWboquArSDH/q9akILkiMo4fwhbfRklT0j+dKQneUxB8QbVoP2wEWgT3
	 9Blu3hoDPjiBcyvXiKfxtSDo0dA4Tdl8f0+hNUflMBnP0hhhRl46TTnCvwKQCqkXhK
	 5lJ9eU8v45fiAQM9Te1bSmXPf116ZLU61HsTP2dQi2U7jHCvjr2VMcCTmgUpiBy1SI
	 MflinMGL8j6fvmYVyu0vN5A/nI5D+TmaEg0DF8iFu3upSX96mFlfLkjrtqKpjEHVy7
	 YC5rzakpCavhCtYpbAbVdkCunXENGkW0jZ7D9aFqmOJxxaCMu0YF4DO7J/NAGkNHR8
	 P6dqX1epKmuDA==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/2] rds: Minor updates for spelling and endian
Date: Thu, 19 Jun 2025 14:58:31 +0100
Message-Id: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIcXVGgC/x3MMQqAMAxA0atIZgNt0WK9ijiIpprBKKmIIL27x
 fHB57+QSJkS9NULSjcnPqTA1hXM2yQrIS/F4IxrjbcBdUm4sxyKLjat6XxogvVQ+lMp8vO/BhC
 6UOi5YMz5A+zlgUllAAAA
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

Hi,

This short series addressses some cosmetic issues in rds.

1. Some spelling errors, as flagged by spellcheck
2. Some endianness annotation errors, which are not bugs,
   flagged by Sparse

---
Simon Horman (2):
      rds: Correct endian annotation of port and addr assignments
      rds: Correct spelling

 net/rds/af_rds.c     | 2 +-
 net/rds/send.c       | 2 +-
 net/rds/tcp_listen.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

base-commit: fc4842cd0f117042a648cf565da4db0c04a604be


