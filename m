Return-Path: <linux-rdma+bounces-11989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43643AFDC06
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 02:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918D5585971
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 00:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D34137E;
	Wed,  9 Jul 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0FlczQd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E623CE;
	Wed,  9 Jul 2025 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019450; cv=none; b=GpCz2EhT+MYsDJ9KelohCCto+6v5IfbQA3MoAKmcpFFc1UepKzuI/rp84kZHci/jdRmu7Ji4msVAVNZJY1p7+pu6HRfi1FBqjb49kAFNFGq+sR1CfyTd5voP7MOjpy2fqHsvnYgLhWiKaB1H/r3JOSMTRd9NmFZmOd97O7E9nE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019450; c=relaxed/simple;
	bh=dRys3sdUOhBPL/vOgzyffW0pOXzJE7AKn6wgLAFMOOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEwfDXc8qKMj46Xk8hBrzEj9NsMF12AFJ9V1kUOicp+EjsIiMY2yhE+Sk9KPcCcirntg6cUbhhF5JqPslte3fkbb2zFYdACWP7zh7KfN8mSH5EtyFB8wQ8l93OBxlWrP9htzpFjM4v0fCyP9sdSBuACZzR5+rNmIMUOBeAGRDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0FlczQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BD8C4CEED;
	Wed,  9 Jul 2025 00:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752019449;
	bh=dRys3sdUOhBPL/vOgzyffW0pOXzJE7AKn6wgLAFMOOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0FlczQd/yB2vRzXc4nJKSXlV7rvwxROvNHsWVOBkJFt01NlsWVDHYW/zPdjxvU22
	 mRlZJnB942WBC8VJNWG4w6DoMdyfRw5+qKCijbiiBigdNSo0Ss22fUsC32iBhidcn4
	 YVL6NcRddqgU6MAOwg9z70iWcKE+IpxOaKF/vfjjwgWKA0ac/0b6VDnMpGnOkb08xh
	 E0WxocpqThpPtj3KlJFYosnwkGc6Ym9w11oSYt/Gk6cJy1XDxguL6kHhYCZ80sWqHl
	 eybTsUCDqiGsPidxTs9i99aVC/v3Q+BfEWgIwthdpYOIS1g6+0dARhlOFsJVegX4NZ
	 5XMO+qcVKQvCw==
Date: Tue, 8 Jul 2025 17:04:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, "Saeed Mahameed" <saeedm@nvidia.com>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [pull-request] mlx5-next updates 2025-07-08
Message-ID: <20250708170408.19f6ddf3@kernel.org>
In-Reply-To: <1752002102-11316-1-git-send-email-tariqt@nvidia.com>
References: <1752002102-11316-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 22:15:02 +0300 Tariq Toukan wrote:
> This is V3.

Third time is the charm :)

