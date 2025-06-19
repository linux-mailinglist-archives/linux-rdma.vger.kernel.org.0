Return-Path: <linux-rdma+bounces-11471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C509AE0820
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E163188CD83
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5730526F47D;
	Thu, 19 Jun 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6y4+5et"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FE1AA782;
	Thu, 19 Jun 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341523; cv=none; b=jibjeOKhBGy9lOhWQiDgBuEMB9CJjlF8k///c6eBS4DxBZBk4yEc0Skyak6km3pJgcKCLVg8jAIGhjlHL2yttYbE6yVWBSw4O/SbqXJ8ET2p3JuBmJE5yQO+LzuBAgF0oAx5BUp9TigGCQk+eMzdzKhsrsT3CIe6/4CQ1K53Jbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341523; c=relaxed/simple;
	bh=GDlioqxxN8NGdDtnsKLnPJ31zIPGVdTjxbnTBqw8700=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxNRtYNBNVGmiBUslhfAg165XnUehVCBTd3t7NIkLRKiDA32t6Q68WW/Ry9uonvWF74qiPbUUlElQifw7bfDZVgmgob5OkECEuFm5L2/IwPRM8kUrXvjUTjiaFuwxvat/LHwzOWqFCueE1I4wdoqFTotXI1Mkt5Oor+F6hf2dHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6y4+5et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB28C4CEF0;
	Thu, 19 Jun 2025 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750341522;
	bh=GDlioqxxN8NGdDtnsKLnPJ31zIPGVdTjxbnTBqw8700=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p6y4+5etk+0MrH2UDjixUKYj48W5OKoLsS5QluoZJQYG2B3hP7GdG9nsRWcSyUhoi
	 ZSR4ASyVc0i15aESmXPwaexCFKjmZhGrzdcOBdOvvh9R4BKpEj248o7nNq6f0OJF5o
	 1+Yn+Xak3RBYAYQUeOODlP2dgqkFRFaktwV46LcoO4yW93dEmx80w9sQDziKF3Jwon
	 wd0trwjhvrTQ8yIPUgkf7oOOokKiCoiG58nh+gKsX12cmJGIYeiaVMa/DoUtjzD5b8
	 2Foj3GmTwCWJIfsAK0P8eD2FmmKVeu/ssE7QxWDhggmj3oZsSUSanq+uLG90PqnZAX
	 hijhitTflclFg==
From: Simon Horman <horms@kernel.org>
Date: Thu, 19 Jun 2025 14:58:32 +0100
Subject: [PATCH net-next 1/2] rds: Correct endian annotation of port and
 addr assignments
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-rds-minor-v1-1-86d2ee3a98b9@kernel.org>
References: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
In-Reply-To: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

Correct the endianness annotation of port assignments:

  A host byte order value (RDS_TCP_PORT) is correctly converted to
  network byte order (big endian) using htons. But it is then cast back to
  host byte order before assigning to a variable that expects a big endian
  value.  Address this by dropping the cast.

  This is not a bug because, while the endian annotation is changed by
  this patch, the assigned value is unchanged.

Also correct the endianness of address assignment.

  A host byte order value (INADDR_ANY) is incorrectly assigned as-is to
  a variable that expects a big endian value. Address this by converting
  the value to network byte order (big endian).

  This is not a bug because INADDR_ANY is 0, which is isomorphic
  with regards to endian conversions. IOW, while the endian annotation
  is changed by this patch, the assigned value is unchanged.

Incorrect endian annotations appear to date back to IPv4-only code added
by commit 70041088e3b9 ("RDS: Add TCP transport to RDS").

Flagged by Sparse.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/rds/tcp_listen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d89bd8d0c354..b5c801c629a4 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -298,15 +298,15 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		sin6 = (struct sockaddr_in6 *)&ss;
 		sin6->sin6_family = PF_INET6;
 		sin6->sin6_addr = in6addr_any;
-		sin6->sin6_port = (__force u16)htons(RDS_TCP_PORT);
+		sin6->sin6_port = htons(RDS_TCP_PORT);
 		sin6->sin6_scope_id = 0;
 		sin6->sin6_flowinfo = 0;
 		addr_len = sizeof(*sin6);
 	} else {
 		sin = (struct sockaddr_in *)&ss;
 		sin->sin_family = PF_INET;
-		sin->sin_addr.s_addr = INADDR_ANY;
-		sin->sin_port = (__force u16)htons(RDS_TCP_PORT);
+		sin->sin_addr.s_addr = htonl(INADDR_ANY);
+		sin->sin_port = htons(RDS_TCP_PORT);
 		addr_len = sizeof(*sin);
 	}
 

-- 
2.47.2


