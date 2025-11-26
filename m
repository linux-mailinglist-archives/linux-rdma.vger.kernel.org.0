Return-Path: <linux-rdma+bounces-14788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E24C8976E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 12:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CA4F3533E5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EE83203A1;
	Wed, 26 Nov 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="ZXRUy89u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD0219A86;
	Wed, 26 Nov 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155667; cv=none; b=JkI6nXF/0eNjGE9K4brluRlBJYZZQpmkKMiwyi4bTenVwPtlmTrjG76wApiTJcWUJyrz4yJ6uljLA8l1qg66NrQaDZe0Ba9jLBcqg1KYTOn5egM32I28K/G8Y2Q5y4a4JYXJWH2zKxW+Svp6BvmxUffpe7XDLSi9yyLVtNqx4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155667; c=relaxed/simple;
	bh=3kB3VPNFQAhuxGa6tM1C5udkJOUKs5pLTNOekPXiELc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfw/yoD4twRT60dxpLw6E3TOyxVBSA7cUy6HYvBonmNp153hqMaYNuSGTUnGuq4waltr8kHBdJ6vNBCHOvjcnIHdcfC6z3tYCzybIJawdHQeHI73n6oP/SgyX9BZQSAOEhAMrICL2r9Zo/AyOZHkBZM/PSrDjNYVPNeS6yYY3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=ZXRUy89u; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=w8d8HkGlrqvwcgdedF2R9zrbiIWX+UmAkB48YnlIjUY=; b=ZXRUy89ujMdpZlfRBgYAZZ4KAQ
	N8vm91aRdV0nshI3bSrJ//DFt0C0vd52bqlFFYj3OXLe80Si21a297z2JzmWso/xw08BayVyfPSKO
	3Z2HQfAa+aI1vCq/0rrEouUKdT3AHH93vq/YR4P7RBLq8m/bLRQKk4gTLto/cndSUVp1jlo1cksBm
	S/LU4SGK1e3D9jScHfbs/PgAIrcC1A7c6lC9gnm7bXZ8/KRzY0P6fwtdq3Tfeu/zxjM7ofjnF8iKp
	XvBWhZGsfikg7ny7r0xEoz8SVO1zT96iuRFGk+/B32OVYimfeS8TcPkwTIyiUTT+3Yxztw1fesqdF
	vI7Ukv5uJLcIPAM6NacG6+uAeZuwQOCL7EP9I2wYG5WLpf+BNFPevmvz+aU8KJkThFnzRq8nk8JjO
	cczkNwMTVEKZX7knsLQCs1+kNkUMRJR1yczqFAB4MOsxeq176menwXq/1a1YP1r3YzLRjGzBeITcg
	DXJFWlWye10K4d2qtaep9uQs;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vODTZ-00FpBW-0F;
	Wed, 26 Nov 2025 11:14:21 +0000
From: Stefan Metzmacher <metze@samba.org>
To: netdev@vger.kernel.org
Cc: metze@samba.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH] net: define IPPROTO_SMBDIRECT and SOL_SMBDIRECT constants
Date: Wed, 26 Nov 2025 12:14:06 +0100
Message-ID: <20251126111407.1786854-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds IPPROTO_SMBDIRECT and SOL_SMBDIRECT constants to the
networking subsystem. These definitions are essential for applications
to set socket options and protocol identifiers related to the SMBDIRECT
protocol, defined in [MS-SMBD] by Microsoft. It is used as wrapper
around RDMA in order to provide a transport for SMB3, but Microsoft also
uses it as transport for other protocols.

SMBDIRECT works over Infiniband, RoCE and iWarp.
RoCEv2 is based on IP/UDP and iWarp is based on IP/TCP,
so these use IP addresses natively.
Infiniband and RoCEv1 require IPOIB in order to be used for
SMBDIRECT.

So instead of adding a PF_SMBDIRECT, which would only use AF_INET[6],
we use IPPROTO_SMBDIRECT instead, this uses a number not
allocated from IANA, as it would not appear in an IP header.

This is similar to IPPROTO_SMC, IPPROTO_MPTCP and IPPROTO_QUIC,
which are linux specific values for the socket() syscall.

  socket(AF_INET, SOCK_STREAM, IPPROTO_SMBDIRECT);
  socket(AF_INET6, SOCK_STREAM, IPPROTO_SMBDIRECT);

This will allow the existing smbdirect code used by
cifs.ko and ksmbd.ko to be moved behind the socket layer [1],
so that there's less special handling. Only sock_sendmsg()
sock_recvmsg() are used, so that the main stream handling
is done all the same for tcp, smbdirect and later also quic.

The special RDMA read/write handling will be via direct
function calls as they are currently done for the in kernel
consumers.

As a start __sock_create(kern=0)/sk->sk_kern_sock == 0 will
still cause a -EPROTONOSUPPORT. So only in kernel consumers
will be supported for now.

Once I have developed a stable interface for the RDMA read/write
handling using sendmsg/recvmsg with MSG_OOB and msg_control,
it will also exposed to userspace in order to allow Samba to
use it.

[1]
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/master-ipproto-smbdirect

Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>

---

In order to avoid conflicts with the addition of IPPROTO_QUIC,
the patch is based on netdev-next/main + the patch adding
IPPROTO_QUIC and SOL_QUIC [2].

[2]
https://lore.kernel.org/quic/0cb58f6fcf35ac988660e42704dae9960744a0a7.1763994509.git.lucien.xin@gmail.com/T/#u

As the numbers of IPPROTO_QUIC and SOL_QUIC are already used
in various userspace applications it would be good to have
this merged to netdev-next/main even if the actual
implementation is still waiting for review.

Having IPPROTO_SMBDIRECT+SOL_SMBDIRECT merged would also make
thinks easier for me.
---
 include/linux/socket.h  | 1 +
 include/uapi/linux/in.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index b4563ffe552b..350a579a87da 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -402,6 +402,7 @@ struct ucred {
 #define SOL_SMC		286
 #define SOL_VSOCK	287
 #define SOL_QUIC	288
+#define SOL_SMBDIRECT	289
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 34becd90d3a6..b30caa6db8ca 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -85,6 +85,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
 #define IPPROTO_SMC		IPPROTO_SMC
+  IPPROTO_SMBDIRECT = 257,	/* RDMA based transport (mostly used by SMB3) */
+#define IPPROTO_SMBDIRECT	IPPROTO_SMBDIRECT
   IPPROTO_QUIC = 261,		/* A UDP-Based Multiplexed and Secure Transport	*/
 #define IPPROTO_QUIC		IPPROTO_QUIC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
-- 
2.43.0


