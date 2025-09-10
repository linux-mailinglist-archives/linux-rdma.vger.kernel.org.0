Return-Path: <linux-rdma+bounces-13229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0EB512FC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF571C82FB6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F47315794;
	Wed, 10 Sep 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlksrzDW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BD3148B7
	for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497446; cv=none; b=aMu19uk9khcl5wxz3h2Nx2mgIuVKBN7OGApqrarBXNRJ088z5hletmeAf6GkuzWl96eXFQrvC9qdD0JQ04p4v7k5M21Jom4YO1jZXN+TFaURUwW18+Q2cjDyV5QZ2NYHvZtvlXsKhP0S2lrJJbH03ke8vAgiYAqkXCA1EpT+8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497446; c=relaxed/simple;
	bh=yeNFurvzwGJX7PCw6Lavr2UqniplBdG6YBCxe1xJjys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IlGKDmHAzSaWtgA31mQLCELYXHmBBxEH9QDOhkAYGCDRYgmH4aSla/q1JwuNnCmhWHAvijUKgHIAYuqY2/GMztMbVu3DH/HRSZTnFLitepxHYAROCLVb0xg1NQMAr1/mHqcdfubJkAq+V3MWK5FGTsY8xRCw8n3QQIuA9uesQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlksrzDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B302CC4CEF5;
	Wed, 10 Sep 2025 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757497446;
	bh=yeNFurvzwGJX7PCw6Lavr2UqniplBdG6YBCxe1xJjys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PlksrzDWi/rLXw68U27n/2lk8h/65UkiDNpmzHdnk7WQ8Zs+36zDHJNwsPR00chOp
	 MCq1raFmW92e6422JA+mAvfhyUM2dRIedgPRcICfM43bBMTUbZKJJhDeIrHcyQlHCM
	 pgRoYzM66BTXiKGoupTuPlDN2q/PEOH7gpC1UfBvn1XseWUT0pvRQBq/5GB+I3sRQq
	 RMF74QDdT1T2WnY2e1Jd8R7O7WLdRnrezsbubxQGLgObRWrkwxaTH+aO3LVt2iYlm+
	 079HGkzmxHrMii1EZUFtDO3QHF5asVVtuxtt4/Gp5/FxYA3LwzzsQL92mPvLhIsUlq
	 URewUtJ6JnLUg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com
In-Reply-To: <20250908094516.18222-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250908094516.18222-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH V2 rdma-next 0/2] RDMA/bnxt_re: bnxt_re enhancements
Message-Id: <175749744294.919138.14962363715758025837.b4-ty@kernel.org>
Date: Wed, 10 Sep 2025 05:44:02 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 08 Sep 2025 15:15:14 +0530, Kalesh AP wrote:
> These 2 patches were part of an earlier patchset.
> Since the patchset got merged already, resending them
> with the comments incorporated.
> 
> Please review and apply.
> 
> V1->V2:
> Patch#1:
> Fixed to use sysfs_emit() instead of scnprintf()
> V1: https://patchwork.kernel.org/project/linux-rdma/patch/20250814112555.221665-2-kalesh-anakkur.purayil@broadcom.com/
> 
> [...]

Applied, thanks!

[1/2] RDMA/bnxt_re: Update sysfs entries with appropriate data
      https://git.kernel.org/rdma/rdma/c/32536dafd4d42d
[2/2] RDMA/bnxt_re: Avoid GID level QoS update from the driver
      https://git.kernel.org/rdma/rdma/c/689aad4d07d0f3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


