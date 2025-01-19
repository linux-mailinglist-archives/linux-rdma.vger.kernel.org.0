Return-Path: <linux-rdma+bounces-7082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C0A160ED
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 09:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBFD3A6618
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DEB18C910;
	Sun, 19 Jan 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEwrqCjZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A844A21;
	Sun, 19 Jan 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737277169; cv=none; b=U1TCOW91LOMtQWODNoo/dXhg+apDdRX4vY/QhBE/GZAo4TnF36cdrD/wTxB1BWuWBiGuLUVaPOkozopGNjb7G+1tm624UGNejAQCSZhy9zTnsK1YtbXW5fycUHrDEmY5AB//Mdb7ejp6F3Aamzt8OVW2Tpf5+RS46BwbA7H+jpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737277169; c=relaxed/simple;
	bh=XhAai9AlkBkXlmp3DAptbWz9Kzm/KGtM17rWsvjR/Xg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=imXg0nQFjNyoQ9thV8yy3nMpORDZR/rHcYsm2nOQINOcOLCKuOHGlFuYW1mhHJ/SQxMWxNLDvdixLgrT/GLZt7WRgztJ8xd4hdrLFZmLaalkxFTmwXA2LGIrcRvrtzEG1NkL3qI5LOkKPhtwmvQXmwbm7srcT1uli7dtHPW2QJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEwrqCjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B23C4CED6;
	Sun, 19 Jan 2025 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737277169;
	bh=XhAai9AlkBkXlmp3DAptbWz9Kzm/KGtM17rWsvjR/Xg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jEwrqCjZVRKsc8Nht6mcvNX8Q7Z9dN08tPmOq9nfaDDPfKztPVuQKSC5GixOLHMX4
	 ieumiCWUqYXEnb85Z2zinyKgIKDzDp8sCB3ujDwauZmOV0Ix7AXr61hPxAM0j6nrNK
	 bII+8GjHPyzyAmdSbexJwMoSTXy8nCGZny+if5Ie3v3T1dAeg+fT9lxXhH1WaDZKkE
	 J1eGhVK3KRrCts98H35H5MVS6xBiU8DZyQ0vjZ5iZXqXe+VaQkOfK/hex2teRThMbo
	 UHruCFSNqAZnRLrIbeNp+mCDeki3xOt8bfi3yVh6iI9FOtm6wNdPjeWIJpsiXNR/Vq
	 AHiziAxoOopKw==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250114-sysfs-const-bin_attr-infiniband-v1-0-397aaa94d453@weissschuh.net>
References: <20250114-sysfs-const-bin_attr-infiniband-v1-0-397aaa94d453@weissschuh.net>
Subject: Re: [PATCH 0/2] RDMA: Constify 'struct bin_attribute'
Message-Id: <173727716456.1545968.12610025315572607297.b4-ty@kernel.org>
Date: Sun, 19 Jan 2025 03:59:24 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811


On Tue, 14 Jan 2025 22:32:12 +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> 

Applied, thanks!

[1/2] RDMA/hfi1: Constify 'struct bin_attribute'
      https://git.kernel.org/rdma/rdma/c/39d772f6654a17
[2/2] RDMA/qib: Constify 'struct bin_attribute'
      https://git.kernel.org/rdma/rdma/c/f5f01c5c409e69

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


