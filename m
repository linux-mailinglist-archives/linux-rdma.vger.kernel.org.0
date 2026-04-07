Return-Path: <linux-rdma+bounces-19096-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB7wDIca1Wli0wcAu9opvQ
	(envelope-from <linux-rdma+bounces-19096-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:53:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E1A3B0698
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB4D230A7607
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0CA31E85D;
	Tue,  7 Apr 2026 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="PdabcU2C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC830E829;
	Tue,  7 Apr 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573274; cv=none; b=hv6PR1Pzq6hYwS2sC0dPl/ytbwK9wVNcXBKpoC8C8AP5//KiWsr8CjuMi0yz0wy6gOAvBimtzWvtTGkfpF5/aeYi3ItdMdpuwfcVy19IVpEjMqxh8uyCKvm1td2T5PQ8g0Q8SMBNEMV4Q6MDT8FmaO2rktNMSlDrxpTMFByAFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573274; c=relaxed/simple;
	bh=xrvT2BDaA5SFez0aDTLDjj0BwuqdsyP0j0A2SL+Esl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grK71iFNyyl08gDJJpFKXgRH0r0m0ziQbJCaX73YYM6GJrTMzrE/S/+kI4vbskpKFawhfZry3/mDojzABFvuxidetRgT+8gSASPMQA3sQ+ysrIzA2FNGr66vhYuntuM0sPGddPc6HX8ST+v0ahJe04/bL8/92bSqs6KAuk59+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=PdabcU2C; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=/Qnvvf4nMiAoasVPPUTakHvzknwGpNRpuP5FHaL0NIA=; b=PdabcU2CFHHmEzMnsALWMLIY0f
	1E/y40SnNckW26a1js7wuKxoW9nQKYPYn5KBFPbPVi1IfQ6rJlcVlNDSN/HINEz+Ht+cnFMHnWOG2
	lCIbOrl0zlDbtJqrFTomITYjmyzXshDKxIZrODN+o+ypkre+g6OMoGLZArDktv0lOhjR22F0ZqEdf
	27AphlOtzNMwaA8ntuspixxNDaF42d3i9NxUNy25Y/V/mzwibYUTJWrFJstoifvehPFPNt9YbPshe
	34zgyuX5WPCGDazWW8M2cZ09hkkuoKFH4+NQOQv2um7gCirEvCBibf/OIFFz737Rky8OaD8mLOMRQ
	QNoBLJUxyIbVUOr5twXskPNlStUQhz4CNVO5vrEOY93BT3R/bAuVUvFOoazBOGztSgZfAGHMIfx4H
	jC2qipLuEbOcK90Jnpor9z+fzDkLqtCI9wGeos7DbuL+9+E4hUofyrfLYhcLXL7Gs6ual4z4cEfUP
	11MdfVPsTZ8fs73O/Bp1AZri;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA7iN-00000007WR1-3BJl;
	Tue, 07 Apr 2026 14:47:40 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	quic@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] smb: smbdirect: add in kernel only support for IPPROTO_SMBDIRECT
Date: Tue,  7 Apr 2026 16:46:32 +0200
Message-ID: <4563333e367417d98a32779ae1358c0964eb6e79.1775571957.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775571957.git.metze@samba.org>
References: <cover.1775571957.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,gmail.com,talpey.com,microsoft.com,kernel.org,redhat.com,suse.com,davemloft.net,google.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-19096-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70E1A3B0698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For userspace callers of socket() still get -EPROTONOSUPPORT,
so we are sure we'll only have in kernel callers, cifs.ko and
ksmbd.ko, for now. This makes it possible to relax the
constrains generic stream socket consumers would otherwise
assume.

There's a prototype for userspace sockets on top of
this and there's working userspace code for Samba as
client and server, so this is just the first step,
but a very important one.

The SMBDIRECT protocol is defined in [MS-SMBD] by Microsoft.
It is used as wrapper around RDMA in order to provide a transport for SMB3,
but Microsoft also uses it as transport for other protocols.

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
cifs.ko and ksmbd.ko to be moved behind the socket layer,
so that there's less special handling. Only sock_sendmsg()
sock_recvmsg() are used, so that the main stream handling
is done all the same for tcp, smbdirect and later also quic.

The special RDMA read/write handling will be via direct
function calls as they are currently done for the in kernel
consumers.

For now the core smbdirect code still supports both
modes, direct calls in indirect via the socket layer.
The core code uses if (sc->sk.sk_family) as indication
for the new socket mode. Once cifs.ko and ksmbd.ko
are converted we can remove the old mode slowly,
but I'll deferr that to a future patchset.

There's still a way to go in order to make this
as generic as tcp and quic e.g. adding MSG_SPLICE_PAGES support or
splice_read/read_sock/read_skb.

But it's a good start, which will make changes
much easier.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>
Cc: quic@lists.linux.dev
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/common/smbdirect/Makefile              |    1 +
 fs/smb/common/smbdirect/smbdirect.h           |   62 +
 fs/smb/common/smbdirect/smbdirect_accept.c    |   14 +-
 .../common/smbdirect/smbdirect_connection.c   |   58 +
 fs/smb/common/smbdirect/smbdirect_devices.c   |    2 +-
 fs/smb/common/smbdirect/smbdirect_internal.h  |   59 +-
 fs/smb/common/smbdirect/smbdirect_listen.c    |   49 +-
 fs/smb/common/smbdirect/smbdirect_main.c      |   45 +
 fs/smb/common/smbdirect/smbdirect_mr.c        |   10 +
 fs/smb/common/smbdirect/smbdirect_proto.c     | 1549 +++++++++++++++++
 fs/smb/common/smbdirect/smbdirect_public.h    |    3 +
 fs/smb/common/smbdirect/smbdirect_rw.c        |   29 +-
 fs/smb/common/smbdirect/smbdirect_socket.c    |  147 ++
 fs/smb/common/smbdirect/smbdirect_socket.h    |   26 +-
 14 files changed, 2039 insertions(+), 15 deletions(-)
 create mode 100644 fs/smb/common/smbdirect/smbdirect_proto.c

diff --git a/fs/smb/common/smbdirect/Makefile b/fs/smb/common/smbdirect/Makefile
index 423f533e1002..fcff485d7c45 100644
--- a/fs/smb/common/smbdirect/Makefile
+++ b/fs/smb/common/smbdirect/Makefile
@@ -10,6 +10,7 @@ smbdirect-y := \
 	smbdirect_connection.o	\
 	smbdirect_mr.o		\
 	smbdirect_rw.o		\
+	smbdirect_proto.o	\
 	smbdirect_debug.o	\
 	smbdirect_connect.o	\
 	smbdirect_listen.o	\
diff --git a/fs/smb/common/smbdirect/smbdirect.h b/fs/smb/common/smbdirect/smbdirect.h
index bbab5f7f7cc9..cf3d4957f94c 100644
--- a/fs/smb/common/smbdirect/smbdirect.h
+++ b/fs/smb/common/smbdirect/smbdirect.h
@@ -6,7 +6,10 @@
 #ifndef __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_H__
 #define __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_H__
 
+#include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/socket.h>
+#include <asm/ioctls.h>
 
 /* SMB-DIRECT buffer descriptor V1 structure [MS-SMBD] 2.2.3.1 */
 struct smbdirect_buffer_descriptor_v1 {
@@ -49,4 +52,63 @@ struct smbdirect_socket_parameters {
 		SMBDIRECT_FLAG_PORT_RANGE_ONLY_IB | \
 		SMBDIRECT_FLAG_PORT_RANGE_ONLY_IW)
 
+enum {
+	__SMBDIRECT_BUFFER_REMOTE_INVALIDATE = 0x20,
+};
+
+struct smbdirect_cmsg_buffer {
+	uint8_t msg_control[CMSG_SPACE(24)];
+};
+
+static __always_inline
+void __smbdirect_cmsg_prepare(struct msghdr *msg,
+			      struct smbdirect_cmsg_buffer *cbuffer,
+			      int cmsg_type,
+			      const void *payload,
+			      size_t payloadlen)
+{
+	size_t cmsg_space = CMSG_SPACE(payloadlen);
+	size_t cmsg_len = CMSG_LEN(payloadlen);
+	struct cmsghdr *cmsg = NULL;
+	void *dataptr = NULL;
+
+	BUILD_BUG_ON(cmsg_space > sizeof(cbuffer->msg_control));
+
+	memset(cbuffer, 0, sizeof(*cbuffer));
+
+	msg->msg_control = cbuffer->msg_control;
+	msg->msg_controllen = cmsg_space;
+
+	cmsg = CMSG_FIRSTHDR(msg);
+	cmsg->cmsg_level = SOL_SMBDIRECT;
+	cmsg->cmsg_type = cmsg_type;
+	cmsg->cmsg_len = cmsg_len;
+	dataptr = CMSG_DATA(cmsg);
+	memcpy(dataptr, payload, payloadlen);
+	msg->msg_controllen = cmsg->cmsg_len;
+}
+
+struct smbdirect_buffer_remote_invalidate_args {
+	__u32 remote_token;
+} __packed;
+#define SMBDIRECT_BUFFER_REMOTE_INVALIDATE_CMSG_TYPE \
+	_IOW('S', __SMBDIRECT_BUFFER_REMOTE_INVALIDATE, \
+		struct smbdirect_buffer_remote_invalidate_args)
+
+static __always_inline
+void smbdirect_buffer_remote_invalidate_cmsg_prepare(struct msghdr *msg,
+						     struct smbdirect_cmsg_buffer *cbuffer,
+						     const __u32 *remote_token)
+{
+	if (remote_token) {
+		struct smbdirect_buffer_remote_invalidate_args args = {
+			.remote_token = *remote_token,
+		};
+
+		__smbdirect_cmsg_prepare(msg, cbuffer,
+					 SMBDIRECT_BUFFER_REMOTE_INVALIDATE_CMSG_TYPE,
+					 &args, sizeof(args));
+	}
+}
+
 #endif /* __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_H__ */
diff --git a/fs/smb/common/smbdirect/smbdirect_accept.c b/fs/smb/common/smbdirect/smbdirect_accept.c
index d6d5e6a3f5de..6d7d869cdbc3 100644
--- a/fs/smb/common/smbdirect/smbdirect_accept.c
+++ b/fs/smb/common/smbdirect/smbdirect_accept.c
@@ -6,7 +6,6 @@
  */
 
 #include "smbdirect_internal.h"
-#include <net/sock.h>
 #include "../../common/smb2status.h"
 
 static int smbdirect_accept_rdma_event_handler(struct rdma_cm_id *id,
@@ -460,6 +459,12 @@ static void smbdirect_accept_negotiate_recv_work(struct work_struct *work)
 		spin_lock_irqsave(&lsc->listen.lock, flags);
 		list_del(&sc->accept.list);
 		list_add_tail(&sc->accept.list, &lsc->listen.ready);
+		if (lsc->sk.sk_family) {
+			struct sock *lsk = &lsc->sk;
+
+			if (!sock_flag(lsk, SOCK_DEAD) && lsk->sk_socket)
+				lsk->sk_data_ready(lsk);
+		}
 		wake_up(&lsc->listen.wait_queue);
 		spin_unlock_irqrestore(&lsc->listen.lock, flags);
 
@@ -774,11 +779,13 @@ static long smbdirect_socket_wait_for_accept(struct smbdirect_socket *lsc, long
 {
 	long ret;
 
+	smbdirect_socket_sk_unlock(lsc);
 	ret = wait_event_interruptible_timeout(lsc->listen.wait_queue,
 					       !list_empty_careful(&lsc->listen.ready) ||
 					       lsc->status != SMBDIRECT_SOCKET_LISTENING ||
 					       lsc->first_error,
 					       timeo);
+	smbdirect_socket_sk_lock(lsc);
 	if (lsc->status != SMBDIRECT_SOCKET_LISTENING)
 		return -EINVAL;
 	if (lsc->first_error)
@@ -850,6 +857,11 @@ struct smbdirect_socket *smbdirect_socket_accept(struct smbdirect_socket *lsc,
 	 * order to grant credits to the peer.
 	 */
 	nsc->status = SMBDIRECT_SOCKET_CONNECTED;
+	if (nsc->sk.sk_family) {
+		struct sock *nsk = &nsc->sk;
+
+		inet_sk_set_state(nsk, TCP_ESTABLISHED);
+	}
 	smbdirect_accept_negotiate_finish(nsc, 0);
 
 	return nsc;
diff --git a/fs/smb/common/smbdirect/smbdirect_connection.c b/fs/smb/common/smbdirect/smbdirect_connection.c
index 1e946f78e935..2c426aefd16d 100644
--- a/fs/smb/common/smbdirect/smbdirect_connection.c
+++ b/fs/smb/common/smbdirect/smbdirect_connection.c
@@ -153,6 +153,15 @@ void smbdirect_connection_rdma_established(struct smbdirect_socket *sc)
 
 	sc->rdma.cm_id->event_handler = smbdirect_connection_rdma_event_handler;
 	sc->rdma.expected_event = RDMA_CM_EVENT_DISCONNECTED;
+
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		smbdirect_socket_sync_saddr_to_sk(sc, NULL);
+		smbdirect_socket_sync_daddr_to_sk(sc);
+
+		inet_sk_set_state(sk, TCP_SYN_RECV);
+	}
 }
 
 void smbdirect_connection_negotiation_done(struct smbdirect_socket *sc)
@@ -189,6 +198,13 @@ void smbdirect_connection_negotiation_done(struct smbdirect_socket *sc)
 		  smbdirect_socket_status_string(sc->status),
 		  SMBDIRECT_DEBUG_ERR_PTR(sc->first_error));
 	sc->status = SMBDIRECT_SOCKET_CONNECTED;
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		inet_sk_set_state(sk, TCP_ESTABLISHED);
+		if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+			sk->sk_socket->state = SS_CONNECTED;
+	}
 
 	/*
 	 * We need to setup the refill and send immediate work
@@ -203,6 +219,13 @@ void smbdirect_connection_negotiation_done(struct smbdirect_socket *sc)
 		&sc->rdma.cm_id->route.addr.src_addr,
 		&sc->rdma.cm_id->route.addr.dst_addr);
 
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+			sk->sk_state_change(sk);
+	}
+
 	wake_up(&sc->status_wait);
 }
 
@@ -739,10 +762,12 @@ int smbdirect_connection_wait_for_connected(struct smbdirect_socket *sc)
 		"waiting for connection: device: %.*s local: %pISpsfc remote: %pISpsfc\n",
 		IB_DEVICE_NAME_MAX, devname, src, dst);
 
+	smbdirect_socket_sk_unlock(sc);
 	ret = wait_event_interruptible_timeout(sc->status_wait,
 					       sc->status == SMBDIRECT_SOCKET_CONNECTED ||
 					       sc->first_error,
 					       msecs_to_jiffies(sp->negotiate_timeout_msec));
+	smbdirect_socket_sk_lock(sc);
 	if (sc->rdma.cm_id) {
 		/*
 		 * Maybe src and dev are updated in the meantime.
@@ -954,6 +979,12 @@ int smbdirect_connection_send_batch_flush(struct smbdirect_socket *sc,
 		atomic_add(batch->credit, &sc->send_io.bcredits.count);
 		batch->credit = 0;
 		wake_up(&sc->send_io.bcredits.wait_queue);
+		if (sc->sk.sk_family) {
+			struct sock *sk = &sc->sk;
+
+			if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+				sk->sk_write_space(sk);
+		}
 	}
 
 	return ret;
@@ -1091,6 +1122,8 @@ int smbdirect_connection_send_single_iter(struct smbdirect_socket *sc,
 	u32 data_length = 0;
 	int ret;
 
+	smbdirect_socket_sk_owned_by_me(sc);
+
 	if (WARN_ON_ONCE(flags))
 		return -EINVAL; /* no flags support for now */
 
@@ -1150,10 +1183,12 @@ int smbdirect_connection_send_single_iter(struct smbdirect_socket *sc,
 		 * wait until either the refill work or the peer
 		 * granted new credits
 		 */
+		smbdirect_socket_sk_unlock(sc);
 		ret = wait_event_interruptible(sc->send_io.credits.wait_queue,
 					       atomic_read(&sc->send_io.credits.count) >= 1 ||
 					       atomic_read(&sc->recv_io.credits.available) >= 1 ||
 					       sc->status != SMBDIRECT_SOCKET_CONNECTED);
+		smbdirect_socket_sk_lock(sc);
 		if (sc->status != SMBDIRECT_SOCKET_CONNECTED)
 			ret = -ENOTCONN;
 		if (ret < 0)
@@ -1268,9 +1303,11 @@ int smbdirect_connection_send_wait_zero_pending(struct smbdirect_socket *sc)
 	 * that means all the I/Os have been out and we are good to return
 	 */
 
+	smbdirect_socket_sk_unlock(sc);
 	wait_event(sc->send_io.pending.zero_wait_queue,
 		   atomic_read(&sc->send_io.pending.count) == 0 ||
 		   sc->status != SMBDIRECT_SOCKET_CONNECTED);
+	smbdirect_socket_sk_lock(sc);
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		smbdirect_log_write(sc, SMBDIRECT_LOG_ERR,
 			"status=%s first_error=%1pe => %1pe\n",
@@ -1297,6 +1334,8 @@ int smbdirect_connection_send_iter(struct smbdirect_socket *sc,
 	int error = 0;
 	__be32 hdr;
 
+	smbdirect_socket_sk_owned_by_me(sc);
+
 	if (WARN_ONCE(flags, "unexpected flags=0x%x\n", flags))
 		return -EINVAL; /* no flags support for now */
 
@@ -1448,7 +1487,9 @@ static void smbdirect_connection_send_immediate_work(struct work_struct *work)
 	smbdirect_log_keep_alive(sc, SMBDIRECT_LOG_INFO,
 		"send an empty message\n");
 	sc->statistics.send_empty++;
+	smbdirect_socket_sk_lock(sc);
 	ret = smbdirect_connection_send_single_iter(sc, NULL, NULL, 0, 0);
+	smbdirect_socket_sk_unlock(sc);
 	if (ret < 0) {
 		smbdirect_log_write(sc, SMBDIRECT_LOG_ERR,
 			"smbdirect_connection_send_single_iter ret=%1pe\n",
@@ -1632,6 +1673,12 @@ void smbdirect_connection_recv_io_done(struct ib_cq *cq, struct ib_wc *wc)
 		 * If any sender is waiting for credits, unblock it
 		 */
 		wake_up(&sc->send_io.credits.wait_queue);
+		if (sc->sk.sk_family) {
+			struct sock *sk = &sc->sk;
+
+			if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+				sk->sk_write_space(sk);
+		}
 	}
 
 	/* Send an immediate response right away if requested */
@@ -1652,6 +1699,12 @@ void smbdirect_connection_recv_io_done(struct ib_cq *cq, struct ib_wc *wc)
 
 		smbdirect_connection_reassembly_append_recv_io(sc, recv_io, data_length);
 		wake_up(&sc->recv_io.reassembly.wait_queue);
+		if (sc->sk.sk_family) {
+			struct sock *sk = &sc->sk;
+
+			if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+				sk->sk_data_ready(sk);
+		}
 	} else
 		smbdirect_connection_put_recv_io(recv_io);
 
@@ -1735,6 +1788,9 @@ int smbdirect_connection_recv_io_refill(struct smbdirect_socket *sc)
 	/*
 	 * If the last send credit is waiting for credits
 	 * it can grant we need to wake it up
+	 *
+	 * This needs to wake up smbdirect_connection_send_single_iter()
+	 * only, so we don't need sk->sk_write_space() here.
 	 */
 	if (atomic_read(&sc->send_io.bcredits.count) == 0 &&
 	    atomic_read(&sc->send_io.credits.count) == 0)
@@ -1922,9 +1978,11 @@ int smbdirect_connection_recvmsg(struct smbdirect_socket *sc,
 
 	smbdirect_log_read(sc, SMBDIRECT_LOG_INFO,
 		"wait_event on more data\n");
+	smbdirect_socket_sk_unlock(sc);
 	ret = wait_event_interruptible(sc->recv_io.reassembly.wait_queue,
 				       sc->recv_io.reassembly.data_length >= size ||
 				       sc->status != SMBDIRECT_SOCKET_CONNECTED);
+	smbdirect_socket_sk_lock(sc);
 	/* Don't return any data if interrupted */
 	if (ret)
 		return ret;
diff --git a/fs/smb/common/smbdirect/smbdirect_devices.c b/fs/smb/common/smbdirect/smbdirect_devices.c
index aaab99e9c045..da0edc104e48 100644
--- a/fs/smb/common/smbdirect/smbdirect_devices.c
+++ b/fs/smb/common/smbdirect/smbdirect_devices.c
@@ -257,7 +257,7 @@ __init int smbdirect_devices_init(void)
 	return 0;
 }
 
-__exit void smbdirect_devices_exit(void)
+__cold void smbdirect_devices_exit(void)
 {
 	struct smbdirect_device *sdev, *tmp;
 
diff --git a/fs/smb/common/smbdirect/smbdirect_internal.h b/fs/smb/common/smbdirect/smbdirect_internal.h
index 30a1b8643657..517ff0533032 100644
--- a/fs/smb/common/smbdirect/smbdirect_internal.h
+++ b/fs/smb/common/smbdirect/smbdirect_internal.h
@@ -12,8 +12,6 @@
 #include "smbdirect_pdu.h"
 #include "smbdirect_public.h"
 
-#include <linux/mutex.h>
-
 struct smbdirect_module_state {
 	struct mutex mutex;
 
@@ -30,6 +28,8 @@ struct smbdirect_module_state {
 		rwlock_t lock;
 		struct list_head list;
 	} devices;
+
+	struct smbdirect_socket_parameters default_parameters;
 };
 
 extern struct smbdirect_module_state smbdirect_globals;
@@ -46,10 +46,58 @@ struct smbdirect_device {
 	char ib_name[IB_DEVICE_NAME_MAX];
 };
 
+static __always_inline void smbdirect_socket_sk_owned_by_me(struct smbdirect_socket *sc)
+{
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		/* assert it is already locked */
+		sock_owned_by_me(sk);
+	}
+}
+
+static __always_inline void smbdirect_socket_sk_not_owned_by_me(struct smbdirect_socket *sc)
+{
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		/* assert it is not already locked */
+		sock_not_owned_by_me(sk);
+	}
+}
+
+static __always_inline void smbdirect_socket_sk_lock(struct smbdirect_socket *sc)
+{
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		/* assert it is not already locked */
+		sock_not_owned_by_me(sk);
+
+		lock_sock(sk);
+	}
+}
+
+static __always_inline void smbdirect_socket_sk_unlock(struct smbdirect_socket *sc)
+{
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		/* assert it is already locked */
+		sock_owned_by_me(sk);
+
+		release_sock(sk);
+	}
+}
+
 int smbdirect_socket_init_new(struct net *net, struct smbdirect_socket *sc);
 
 int smbdirect_socket_init_accepting(struct rdma_cm_id *id, struct smbdirect_socket *sc);
 
+int smbdirect_socket_sync_saddr_to_sk(struct smbdirect_socket *sc, bool *_is_any_addr);
+
+int smbdirect_socket_sync_daddr_to_sk(struct smbdirect_socket *sc);
+
 void __smbdirect_socket_schedule_cleanup(struct smbdirect_socket *sc,
 					 const char *macro_name,
 					 unsigned int lvl,
@@ -135,7 +183,12 @@ int smbdirect_accept_connect_request(struct smbdirect_socket *sc,
 
 void smbdirect_accept_negotiate_finish(struct smbdirect_socket *sc, u32 ntstatus);
 
+void smbdirect_sk_reclassify(struct sock *sk);
+
 __init int smbdirect_devices_init(void);
-__exit void smbdirect_devices_exit(void);
+__cold void smbdirect_devices_exit(void);
+
+__init int smbdirect_proto_init(void);
+__exit void smbdirect_proto_exit(void);
 
 #endif /* __FS_SMB_COMMON_SMBDIRECT_INTERNAL_H__ */
diff --git a/fs/smb/common/smbdirect/smbdirect_listen.c b/fs/smb/common/smbdirect/smbdirect_listen.c
index 05c7902e7020..a6e08d82dc73 100644
--- a/fs/smb/common/smbdirect/smbdirect_listen.c
+++ b/fs/smb/common/smbdirect/smbdirect_listen.c
@@ -74,6 +74,12 @@ int smbdirect_socket_listen(struct smbdirect_socket *sc, int backlog)
 	 */
 	sc->listen.backlog = backlog;
 
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		inet_sk_set_state(sk, TCP_LISTEN);
+	}
+
 	if (sc->rdma.cm_id->device)
 		smbdirect_log_rdma_event(sc, SMBDIRECT_LOG_INFO,
 			"listening on addr: %pISpsfc dev: %.*s\n",
@@ -209,6 +215,7 @@ static int smbdirect_listen_connect_request(struct smbdirect_socket *lsc,
 					    const struct rdma_cm_event *event)
 {
 	const struct smbdirect_socket_parameters *lsp = &lsc->parameters;
+	struct sock *nsk = NULL;
 	struct smbdirect_socket *nsc;
 	unsigned long flags;
 	size_t backlog = max_t(size_t, 1, lsc->listen.backlog);
@@ -265,9 +272,39 @@ static int smbdirect_listen_connect_request(struct smbdirect_socket *lsc,
 		return -EBUSY;
 	}
 
-	ret = smbdirect_socket_create_accepting(new_id, &nsc);
-	if (ret)
-		goto socket_init_failed;
+	if (lsc->sk.sk_family) {
+		struct sock *lsk = &lsc->sk;
+
+		ret = -ENOMEM;
+		nsk = sk_clone(lsk, lsk->sk_allocation, false);
+		if (!nsk)
+			goto sk_clone_failed;
+		/* sk_clone_lock() increments refcnt to 2; drop the extra. */
+		__sock_put(nsk);
+		/* sk_clone() already called sk_sockets_allocated_inc(sk); */
+		sock_prot_inuse_add(sock_net(nsk), nsk->sk_prot, 1);
+
+		smbdirect_sk_reclassify(nsk);
+		inet_sk_set_state(nsk, TCP_SYN_RECV);
+		nsc = smbdirect_socket_from_sk(nsk);
+
+		ret = smbdirect_socket_init_accepting(new_id, nsc);
+		if (ret)
+			goto socket_init_failed;
+
+		/*
+		 * Note that smbdirect_sock_accept() will set
+		 * SOCK_CUSTOM_SOCKOPT once [__]inet_accept()
+		 * called sk_set_socket() via sock_graft().
+		 */
+		WARN_ON_ONCE(nsc->orig_sk_destruct != lsc->orig_sk_destruct);
+		WARN_ON_ONCE(nsk->sk_destruct != lsk->sk_destruct);
+		WARN_ON_ONCE(nsk->sk_ipv6only != lsk->sk_ipv6only);
+	} else {
+		ret = smbdirect_socket_create_accepting(new_id, &nsc);
+		if (ret)
+			goto socket_init_failed;
+	}
 
 	nsc->logging = lsc->logging;
 	ret = smbdirect_socket_set_initial_parameters(nsc, &lsc->parameters);
@@ -302,7 +339,11 @@ static int smbdirect_listen_connect_request(struct smbdirect_socket *lsc,
 	 */
 	nsc->ib.dev = NULL;
 	nsc->rdma.cm_id = NULL;
-	smbdirect_socket_release(nsc);
+	if (!nsk)
+		smbdirect_socket_release(nsc);
 socket_init_failed:
+	if (nsk)
+		sk_free(nsk);
+sk_clone_failed:
 	return ret;
 }
diff --git a/fs/smb/common/smbdirect/smbdirect_main.c b/fs/smb/common/smbdirect/smbdirect_main.c
index fe6e8d93c34c..ccbe979332af 100644
--- a/fs/smb/common/smbdirect/smbdirect_main.c
+++ b/fs/smb/common/smbdirect/smbdirect_main.c
@@ -12,6 +12,7 @@ struct smbdirect_module_state smbdirect_globals = {
 
 static __init int smbdirect_module_init(void)
 {
+	struct smbdirect_socket_parameters *sp;
 	int ret = -ENOMEM;
 
 	pr_notice("subsystem loading...\n");
@@ -73,10 +74,52 @@ static __init int smbdirect_module_init(void)
 	if (ret)
 		goto devices_init_failed;
 
+	/*
+	 * Create the global default parameters
+	 */
+	sp = &smbdirect_globals.default_parameters;
+	sp->resolve_addr_timeout_msec = 5 * 1000;
+	sp->resolve_route_timeout_msec = 5 * 1000;
+	sp->rdma_connect_timeout_msec = 5 * 1000;
+	sp->negotiate_timeout_msec = 120 * 1000;
+	sp->initiator_depth = 1; /* the server should change this */
+	sp->responder_resources = 1; /* the client should change this */
+	sp->recv_credit_max = 255;
+	sp->send_credit_target = 255;
+	sp->max_send_size = 1364;
+	/*
+	 * The maximum fragmented upper-layer payload receive size supported
+	 *
+	 * Assume max_payload_per_credit is
+	 * smbd_max_receive_size - 24 = 1340
+	 *
+	 * The maximum number would be
+	 * smbd_receive_credit_max * max_payload_per_credit
+	 *
+	 *                       1340 * 255 = 341700 (0x536C4)
+	 *
+	 * The minimum value from the spec is 131072 (0x20000)
+	 *
+	 * For now we use the logic we used before:
+	 *                 (1364 * 255) / 2 = 173910 (0x2A756)
+	 */
+	sp->max_fragmented_recv_size = (1364 * 255) / 2;
+	sp->max_recv_size = 1364;
+	sp->max_read_write_size = 0; /* the server should change this */
+	sp->max_frmr_depth = 0; /* the client should change this */
+	sp->keepalive_interval_msec = 120 * 1000;
+	sp->keepalive_timeout_msec = 5 * 1000;
+
+	ret = smbdirect_proto_init();
+	if (ret)
+		goto proto_init_failed;
+
 	mutex_unlock(&smbdirect_globals.mutex);
 	pr_notice("subsystem loaded\n");
 	return 0;
 
+proto_init_failed:
+	smbdirect_devices_exit();
 devices_init_failed:
 	destroy_workqueue(smbdirect_globals.workqueues.cleanup);
 alloc_cleanup_wq_failed:
@@ -101,6 +144,8 @@ static __exit void smbdirect_module_exit(void)
 	pr_notice("subsystem unloading...\n");
 	mutex_lock(&smbdirect_globals.mutex);
 
+	smbdirect_proto_exit();
+
 	smbdirect_devices_exit();
 
 	destroy_workqueue(smbdirect_globals.workqueues.accept);
diff --git a/fs/smb/common/smbdirect/smbdirect_mr.c b/fs/smb/common/smbdirect/smbdirect_mr.c
index fa9be8089925..86bb72ed10ae 100644
--- a/fs/smb/common/smbdirect/smbdirect_mr.c
+++ b/fs/smb/common/smbdirect/smbdirect_mr.c
@@ -167,9 +167,11 @@ smbdirect_connection_get_mr_io(struct smbdirect_socket *sc)
 	int ret;
 
 again:
+	smbdirect_socket_sk_unlock(sc);
 	ret = wait_event_interruptible(sc->mr_io.ready.wait_queue,
 				       atomic_read(&sc->mr_io.ready.count) ||
 				       sc->status != SMBDIRECT_SOCKET_CONNECTED);
+	smbdirect_socket_sk_lock(sc);
 	if (ret) {
 		smbdirect_log_rdma_mr(sc, SMBDIRECT_LOG_ERR,
 			"wait_event_interruptible ret=%d (%1pe)\n",
@@ -281,7 +283,9 @@ smbdirect_connection_register_mr_io(struct smbdirect_socket *sc,
 		return NULL;
 	}
 
+	smbdirect_socket_sk_lock(sc);
 	mr = smbdirect_connection_get_mr_io(sc);
+	smbdirect_socket_sk_unlock(sc);
 	if (!mr) {
 		smbdirect_log_rdma_mr(sc, SMBDIRECT_LOG_ERR,
 			"smbdirect_connection_get_mr_io returning NULL\n");
@@ -415,6 +419,12 @@ void smbdirect_connection_deregister_mr_io(struct smbdirect_mr_io *mr)
 	if (mr->state == SMBDIRECT_MR_DISABLED)
 		goto put_kref;
 
+	/*
+	 * We are protected by mr->mutex
+	 * without lock_sock().
+	 */
+	smbdirect_socket_sk_not_owned_by_me(sc);
+
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		smbdirect_mr_io_disable_locked(mr);
 		goto put_kref;
diff --git a/fs/smb/common/smbdirect/smbdirect_proto.c b/fs/smb/common/smbdirect/smbdirect_proto.c
new file mode 100644
index 000000000000..1a832d52eb89
--- /dev/null
+++ b/fs/smb/common/smbdirect/smbdirect_proto.c
@@ -0,0 +1,1549 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (c) 2025 Stefan Metzmacher
+ */
+
+#include "smbdirect_internal.h"
+#include <net/protocol.h>
+#include <net/inet_common.h>
+#include <linux/bpf-cgroup.h>
+#include <linux/errname.h>
+
+#define SMBDIRECT_FN_GENERIC(__sk, __fmt, __args...) do { \
+	struct smbdirect_socket *__sc = smbdirect_socket_from_sk(__sk); \
+	__smbdirect_log_generic(__sc, SMBDIRECT_LOG_INFO, SMBDIRECT_LOG_SK, \
+		__fmt " sc=%p %s first_error=%1pe kern=%u locked=%u refs=%u dead=%u mrefs=%u\n", \
+		##__args, __sc, \
+		smbdirect_socket_status_string(__sc->status), \
+		SMBDIRECT_DEBUG_ERR_PTR(__sc->first_error), \
+		(__sk)->sk_kern_sock, \
+		sock_owned_by_user_nocheck(__sk), \
+		refcount_read(&((__sk)->sk_refcnt)), \
+		sock_flag(__sk, SOCK_DEAD), \
+		module_refcount(THIS_MODULE)); \
+} while (0)
+
+#define SMBDIRECT_FN_COMMENT(__sk, __comment) \
+	SMBDIRECT_FN_GENERIC(__sk, "%s with", __comment)
+
+#define SMBDIRECT_FN_CALLED(__sk) \
+	SMBDIRECT_FN_GENERIC(__sk, "Called for")
+
+#define SMBDIRECT_FN_RETURN_VOID(__sk) \
+	SMBDIRECT_FN_GENERIC(__sk, "Returning for")
+
+#define SMBDIRECT_FN_RETURN_POLL(__sk, __mask) \
+	SMBDIRECT_FN_GENERIC(__sk, "Returning mask=0x%x for", __mask)
+
+#define SMBDIRECT_FN_RETURN_INT(__sk, __ret) do { \
+	bool __is_err = IS_ERR(SMBDIRECT_DEBUG_ERR_PTR(__ret)); \
+	SMBDIRECT_FN_GENERIC(__sk, "Returning ret=%d%s%s%s for", \
+		(__ret), \
+		__is_err ? " (" : "", \
+		__is_err ? errname(__ret) : "", \
+		__is_err ? ")" : ""); \
+} while (0)
+
+static bool smbdirect_sk_logging_needed(struct smbdirect_socket *sc,
+					void *private_ptr,
+					unsigned int lvl,
+					unsigned int cls)
+{
+	/*
+	 * Only errors by default.
+	 */
+	if (lvl <= SMBDIRECT_LOG_ERR)
+		return true;
+	return false;
+}
+
+static void smbdirect_sk_logging_vaprintf(struct smbdirect_socket *sc,
+					  const char *func,
+					  unsigned int line,
+					  void *private_ptr,
+					  unsigned int lvl,
+					  unsigned int cls,
+					  struct va_format *vaf)
+{
+	if (lvl <= SMBDIRECT_LOG_ERR)
+		pr_err("%s:%u %pV", func, line, vaf);
+	else
+		pr_info("%s:%u %pV", func, line, vaf);
+}
+
+void smbdirect_sk_reclassify(struct sock *sk)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	static struct lock_class_key sk_key[2];
+	static struct lock_class_key slock_key[2];
+
+	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+		return;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		/*
+		 * Before we reset the owner we
+		 * need to drop the reference of the
+		 * existing module, this is only
+		 * really relevant for AF_INET,
+		 * as that is always builtin
+		 * there's no potential leak
+		 * of module references. We do it
+		 * mainly in order to match the
+		 * AF_INET6 case.
+		 */
+		sk_owner_put(sk);
+		sk_owner_clear(sk);
+
+		sock_lock_init_class_and_name(sk,
+					      "slock-AF_INET-IPPROTO-SMBDIRECT",
+					      &slock_key[0],
+					      "sk_lock-AF_INET-IPPROTO-SMBDIRECT",
+					      &sk_key[0]);
+
+		/*
+		 * Now that we reclassified the socket
+		 * we're also the new sk_owner, but that's
+		 * not needed as there's still a reference
+		 * on sk->sk_prot->owner, which is dropped
+		 * in sk_prot_free(). But in order to
+		 * avoid module reference leaks to our
+		 * own module we need to put and clear
+		 * sk_owner, in order to allow callers
+		 * to do their own reclassification.
+		 */
+		sk_owner_put(sk);
+		sk_owner_clear(sk);
+		break;
+	case AF_INET6:
+		/*
+		 * Before we reset the owner we
+		 * need to drop the reference of the
+		 * existing module.
+		 *
+		 * As we also use inet6_register_protosw()
+		 * and other symbols from a possible
+		 * ipv6.ko, we already have enough
+		 * module references in order to avoid
+		 * unloading of ipv6.ko, while smbdirect.ko
+		 * is loaded.
+		 *
+		 * However when smbdirect.ko is unloaded
+		 * we should not leak references in order
+		 * to allow ipv6.ko to be unloaded as well.
+		 */
+		sk_owner_put(sk);
+		sk_owner_clear(sk);
+
+		sock_lock_init_class_and_name(sk,
+					      "slock-AF_INET6-IPPROTO-SMBDIRECT",
+					      &slock_key[1],
+					      "sk_lock-AF_INET6-IPPROTO-SMBDIRECT",
+					      &sk_key[1]);
+
+		/*
+		 * Now that we reclassified the socket
+		 * we're also the new sk_owner, but that's
+		 * not needed as there's still a reference
+		 * on sk->sk_prot->owner, which is dropped
+		 * in sk_prot_free(). But in order to
+		 * avoid module reference leaks to our
+		 * own module we need to put and clear
+		 * sk_owner, in order to allow callers
+		 * to do their own reclassification.
+		 */
+		sk_owner_put(sk);
+		sk_owner_clear(sk);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+#endif /* CONFIG_DEBUG_LOCK_ALLOC */
+}
+
+static void smbdirect_sk_destruct(struct sock *sk)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+
+	/*
+	 * Called by sk_free()
+	 */
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	if (WARN_ON_ONCE(sc->status != SMBDIRECT_SOCKET_DESTROYED)) {
+		pr_err("Attempt to release SMBDIRECT socket in status %s sc %p\n",
+		       smbdirect_socket_status_string(sc->status), sc);
+		SMBDIRECT_FN_RETURN_VOID(sk);
+		return;
+	}
+
+	SMBDIRECT_FN_COMMENT(sk, "calling orig_sk_destruct");
+	smbdirect_log_sk(sc, SMBDIRECT_LOG_INFO,
+		"sc[%p]->orig_sk_destruct[%ps]\n",
+		sc, sc->orig_sk_destruct);
+	sc->orig_sk_destruct(sk);
+	SMBDIRECT_FN_RETURN_VOID(sk);
+}
+
+static int smbdirect_sk_init(struct sock *sk)
+{
+	struct socket *sock = sk->sk_socket;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	const struct smbdirect_socket_parameters *sp = &smbdirect_globals.default_parameters;
+	void (*orig_sk_destruct)(struct sock *sk);
+	int ret;
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	smbdirect_sk_reclassify(sk);
+
+	smbdirect_socket_init(sc);
+	smbdirect_socket_set_logging(sc,
+				     NULL,
+				     smbdirect_sk_logging_needed,
+				     smbdirect_sk_logging_vaprintf);
+
+	smbdirect_log_sk(sc, SMBDIRECT_LOG_INFO,
+		"Called for sk=%p family=%u protocol=%u type=%u\n",
+		sk, sk->sk_family, sk->sk_protocol, sk->sk_type);
+
+	sk_sockets_allocated_inc(sk);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+
+	orig_sk_destruct = sk->sk_destruct;
+	SMBDIRECT_FN_COMMENT(sk, "remembered orig_sk_destruct");
+	smbdirect_log_sk(sc, SMBDIRECT_LOG_INFO,
+		"sc[%p]->orig_sk_destruct[%ps]\n",
+		sc, orig_sk_destruct);
+	sc->orig_sk_destruct = orig_sk_destruct;
+	sk->sk_destruct = smbdirect_sk_destruct;
+
+	/*
+	 * We want to handle all sockopts explicitly
+	 * and only support what we really support.
+	 */
+	set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
+	/*
+	 * There are no legacy callers, so we are strict
+	 * regarding ipv4 vs. ipv6.
+	 */
+	sk->sk_ipv6only = true;
+
+	/*
+	 * No userspace sockets yet...
+	 */
+	if (!sk->sk_kern_sock) {
+		sc->first_error = -EPROTONOSUPPORT;
+		SMBDIRECT_FN_COMMENT(sk, "No userspace sockets");
+		return -EPROTONOSUPPORT;
+	}
+
+	ret = smbdirect_socket_init_new(sock_net(sk), sc);
+	if (ret)
+		goto socket_init_failed;
+	/*
+	 * smbdirect_socket_init_new() called smbdirect_socket_init() again,
+	 * so we need to call smbdirect_socket_set_logging() again!
+	 */
+	smbdirect_socket_set_logging(sc,
+				     NULL,
+				     smbdirect_sk_logging_needed,
+				     smbdirect_sk_logging_vaprintf);
+
+	WARN_ON_ONCE(sc->orig_sk_destruct != orig_sk_destruct);
+	WARN_ON_ONCE(sk->sk_destruct != smbdirect_sk_destruct);
+
+	ret = smbdirect_socket_set_initial_parameters(sc, sp);
+	if (ret)
+		goto set_params_failed;
+
+	ret = smbdirect_socket_set_kernel_settings(sc, IB_POLL_SOFTIRQ, sk->sk_allocation);
+	if (ret)
+		goto set_settings_failed;
+
+	SMBDIRECT_FN_RETURN_INT(sk, 0);
+	return 0;
+
+set_settings_failed:
+set_params_failed:
+socket_init_failed:
+	sc->first_error = ret;
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static void smbdirect_sk_destroy(struct sock *sk)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is already locked */
+	sock_owned_by_me(sk);
+
+	/*
+	 * For now do a sync disconnect/destroy
+	 *
+	 * SMBDIRECT_LOG_INFO is enough here
+	 * as this is the typical case where
+	 * we terminate the connection ourself.
+	 */
+	smbdirect_socket_schedule_cleanup_lvl(sc,
+					      SMBDIRECT_LOG_INFO,
+					      -ESHUTDOWN);
+	smbdirect_socket_destroy_sync(sc);
+
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	sk_sockets_allocated_dec(sk);
+
+	SMBDIRECT_FN_RETURN_VOID(sk);
+}
+
+static int smbdirect_sk_hash(struct sock *sk)
+{
+	SMBDIRECT_FN_CALLED(sk);
+	return 0;
+}
+
+static void smbdirect_sk_unhash(struct sock *sk)
+{
+	SMBDIRECT_FN_CALLED(sk);
+}
+
+static void smbdirect_sk_release_cb(struct sock *sk)
+{
+	/*
+	 * Called from release_sock()
+	 */
+	SMBDIRECT_FN_CALLED(sk);
+}
+
+static int smbdirect_sk_pre_bind(struct sock *sk,
+				 struct sockaddr_unsized *uaddr,
+				 int *addr_len,
+				 u32 *flags,
+				 u16 *port)
+{
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	if (*addr_len < sizeof(uaddr->sa_family))
+		return -EINVAL;
+
+	/* AF_UNSPEC is not allowed */
+	if (sk->sk_family != uaddr->sa_family)
+		return -EAFNOSUPPORT;
+
+	/*
+	 * BPF prog is run before any checks are done so that if the prog
+	 * changes context in a wrong way it will be caught.
+	 */
+	switch (sk->sk_family) {
+	case AF_INET:
+		if (*addr_len < sizeof(struct sockaddr_in))
+			return -EINVAL;
+
+		*port = ntohs(((struct sockaddr_in *)uaddr)->sin_port);
+
+		return BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, addr_len,
+							  CGROUP_INET4_BIND,
+							  flags);
+	case AF_INET6:
+		/*
+		 * We require a full struct sockaddr_in6 (28 bytes) instead of a
+		 * minimal size of SIN6_LEN_RFC2133 (24 bytes), as we don't
+		 * have any legacy callers in userspace and the
+		 * rdma layer also expects that.
+		 */
+		if (*addr_len < sizeof(struct sockaddr_in6))
+			return -EINVAL;
+
+		*port = ntohs(((struct sockaddr_in6 *)uaddr)->sin6_port);
+
+		return BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, addr_len,
+							  CGROUP_INET6_BIND,
+							  flags);
+	}
+
+	return -EAFNOSUPPORT;
+}
+
+static int smbdirect_sk_do_bind(struct sock *sk,
+				struct sockaddr_unsized *uaddr,
+				const u32 flags,
+				const u16 port)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	bool is_any_addr = true;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	if (flags & BIND_WITH_LOCK)
+		sock_owned_by_me(sk);
+	else
+		sock_not_owned_by_me(sk);
+
+	ret = smbdirect_socket_bind(sc, (struct sockaddr *)uaddr);
+	if (ret) {
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	ret = smbdirect_socket_sync_saddr_to_sk(sc, &is_any_addr);
+	if (ret) {
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	/* Make sure we are allowed to bind here. */
+	if (sk->sk_num && !(flags & BIND_FROM_BPF)) {
+		switch (sk->sk_family) {
+		case AF_INET:
+			ret = BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk);
+			if (ret) {
+				SMBDIRECT_FN_RETURN_INT(sk, ret);
+				return ret;
+			}
+			break;
+
+		case AF_INET6:
+			ret = BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk);
+			if (ret) {
+				SMBDIRECT_FN_RETURN_INT(sk, ret);
+				return ret;
+			}
+			break;
+		}
+	}
+
+	if (!is_any_addr)
+		sk->sk_userlocks |= SOCK_BINDADDR_LOCK;
+	if (port)
+		sk->sk_userlocks |= SOCK_BINDPORT_LOCK;
+
+	ret = 0;
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sk_bind(struct sock *sk, struct sockaddr_unsized *addr, int addr_len)
+{
+	struct net *net = sock_net(sk);
+	u32 flags = BIND_WITH_LOCK;
+	u16 port = 0;
+	u16 check_port = 0;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	ret = smbdirect_sk_pre_bind(sk, addr, &addr_len, &flags, &port);
+	if (ret) {
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	/*
+	 * treat the iwarp tcp port for
+	 * smb (5445) as the main smb port (445)
+	 * and only allow the bind if 445
+	 * would be allowed.
+	 */
+	if (port == 5445)
+		check_port = 445;
+	else
+		check_port = port;
+
+	if (!(flags & BIND_NO_CAP_NET_BIND_SERVICE) &&
+	    check_port && inet_port_requires_bind_service(net, check_port) &&
+	    !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE)) {
+		ret = -EACCES;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	if (flags & BIND_WITH_LOCK)
+		lock_sock(sk);
+
+	ret = smbdirect_sk_do_bind(sk, addr, flags, port);
+
+	if (flags & BIND_WITH_LOCK)
+		release_sock(sk);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static struct sock *smbdirect_sk_accept(struct sock *lsk, struct proto_accept_arg *arg)
+{
+	struct smbdirect_socket *lsc = smbdirect_socket_from_sk(lsk);
+	long timeo = sock_rcvtimeo(lsk, arg->flags & O_NONBLOCK);
+	struct smbdirect_socket *nsc;
+	struct sock *nsk;
+
+	SMBDIRECT_FN_CALLED(lsk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(lsk);
+
+	lock_sock(lsk);
+	nsc = smbdirect_socket_accept(lsc, timeo, arg);
+	release_sock(lsk);
+	if (!nsc) {
+		SMBDIRECT_FN_RETURN_INT(lsk, arg->err);
+		return NULL;
+	}
+	nsk = &nsc->sk;
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(nsk);
+
+	SMBDIRECT_FN_RETURN_INT(lsk, 0);
+	return nsk;
+}
+
+static int smbdirect_sk_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
+{
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is already locked */
+	sock_owned_by_me(sk);
+
+	if (addr_len < sizeof(uaddr->sa_family))
+		return -EINVAL;
+
+	if (sk->sk_family != uaddr->sa_family)
+		return -EAFNOSUPPORT;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		if (addr_len < sizeof(struct sockaddr_in))
+			return -EINVAL;
+
+		return BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, &addr_len);
+	case AF_INET6:
+		/*
+		 * We require a full struct sockaddr_in6 (28 bytes) instead of a
+		 * minimal size of SIN6_LEN_RFC2133 (24 bytes), as we don't
+		 * have any legacy callers in userspace and the
+		 * rdma layer also expects that.
+		 */
+		if (addr_len < sizeof(struct sockaddr_in6))
+			return -EINVAL;
+
+		return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
+	}
+
+	return -EAFNOSUPPORT;
+}
+
+static int smbdirect_sk_connect(struct sock *sk, struct sockaddr_unsized *addr, int addr_len)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is already locked */
+	sock_owned_by_me(sk);
+
+	ret = smbdirect_connect(sc, (struct sockaddr *)addr);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sk_setsockopt(struct sock *sk, int level, int optname,
+				   sockptr_t optval, unsigned int optlen)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	switch (level) {
+	default:
+		SMBDIRECT_FN_COMMENT(sk, "default");
+		smbdirect_log_sk(sc, SMBDIRECT_LOG_INFO,
+			"level=%d optname=%d for sk=%p\n",
+			level, optname, sk);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sk_getsockopt(struct sock *sk, int level, int optname,
+				   char __user *optval, int __user *optlen)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	switch (level) {
+	default:
+		SMBDIRECT_FN_COMMENT(sk, "default");
+		smbdirect_log_sk(sc, SMBDIRECT_LOG_INFO,
+			"level=%d optname=%d for sk=%p\n",
+			level, optname, sk);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sk_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	switch (cmd) {
+	default:
+		SMBDIRECT_FN_COMMENT(sk, "default");
+		smbdirect_log_sk(sc, SMBDIRECT_LOG_INFO,
+			"cmd=%d (0x%x) for sk=%p\n",
+			cmd, cmd, sk);
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static inline size_t smbdirect_cmsg_count(const struct msghdr *_msg,
+					  int *first_sol_smbdirect_type)
+{
+	struct msghdr *msg = (struct msghdr *)(uintptr_t)(const void *)_msg;
+	struct cmsghdr *cmsg = NULL;
+	size_t count = 0;
+
+	if (first_sol_smbdirect_type != NULL)
+		*first_sol_smbdirect_type = -1;
+
+	for (cmsg = CMSG_FIRSTHDR(msg);
+	     cmsg != NULL;
+	     cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		count++;
+		if (cmsg->cmsg_level != SOL_SMBDIRECT)
+			continue;
+		if (first_sol_smbdirect_type != NULL) {
+			*first_sol_smbdirect_type = cmsg->cmsg_type;
+			first_sol_smbdirect_type = NULL;
+		}
+	}
+
+	return count;
+}
+
+static __always_inline
+ssize_t __smbdirect_cmsg_extract(const struct msghdr *_msg,
+				 int cmsg_type,
+				 void *_payload,
+				 size_t payloadmin,
+				 size_t payloadmax)
+{
+	struct msghdr *msg = (struct msghdr *)(uintptr_t)(const void *)_msg;
+	size_t cmsg_len_min = CMSG_LEN(payloadmin);
+	size_t cmsg_len_max = CMSG_LEN(payloadmax);
+	const size_t cmsg_len_hdr = CMSG_LEN(0);
+	uint8_t *payload = (uint8_t *)_payload;
+	struct cmsghdr *cmsg = NULL;
+	size_t payloadlen;
+
+	BUILD_BUG_ON(cmsg_len_min > cmsg_len_max);
+	if (WARN_ON_ONCE(cmsg_len_min > cmsg_len_max))
+		return -EBADMSG;
+
+	for (cmsg = CMSG_FIRSTHDR(msg);
+	     cmsg != NULL;
+	     cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		if (cmsg->cmsg_level != SOL_SMBDIRECT)
+			continue;
+
+		if (cmsg->cmsg_type != cmsg_type)
+			continue;
+
+		if (cmsg->cmsg_len < cmsg_len_min)
+			return -EBADMSG;
+
+		if (cmsg->cmsg_len > cmsg_len_max)
+			return -EMSGSIZE;
+
+		payloadlen = cmsg->cmsg_len - cmsg_len_hdr;
+		if (payloadlen > 0)
+			memcpy(payload, CMSG_DATA(cmsg), payloadlen);
+		if (payloadlen < payloadmax)
+			memset(payload + payloadlen, 0, payloadmax - payloadlen);
+		return payloadlen;
+	}
+
+	return -ENOMSG;
+}
+
+static __always_inline
+int smbdirect_buffer_remote_invalidate_cmsg_extract(const struct msghdr *msg,
+						    u32 *remote_token)
+{
+	struct smbdirect_buffer_remote_invalidate_args args = {
+		.remote_token = 0,
+	};
+	ssize_t ret;
+
+	ret = __smbdirect_cmsg_extract(msg,
+				       SMBDIRECT_BUFFER_REMOTE_INVALIDATE_CMSG_TYPE,
+				       &args, sizeof(args), sizeof(args));
+	if (ret < 0)
+		return ret;
+
+	*remote_token = args.remote_token;
+	return 0;
+}
+
+static int smbdirect_sk_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t msg_len)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	struct iov_iter *iter = &msg->msg_iter;
+	unsigned int flags = msg->msg_flags;
+	size_t cmsg_count = 0;
+	int cmsg_type = -1;
+	bool need_invalidate = false;
+	u32 remote_key = 0;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is already locked */
+	sock_owned_by_me(sk);
+
+	cmsg_count = smbdirect_cmsg_count(msg, &cmsg_type);
+	if (cmsg_count > 1) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	if (flags & ~(MSG_DONTWAIT|MSG_WAITALL|MSG_NOSIGNAL)) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	if (cmsg_type == SMBDIRECT_BUFFER_REMOTE_INVALIDATE_CMSG_TYPE) {
+		ret = smbdirect_buffer_remote_invalidate_cmsg_extract(msg, &remote_key);
+		if (!ret)
+			need_invalidate = true; /* remote_key is valid */
+		else if (ret != -ENOMSG) {
+			SMBDIRECT_FN_RETURN_INT(sk, ret);
+			return ret;
+		}
+	} else if (cmsg_count) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(iov_iter_rw(iter) != ITER_SOURCE)) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(iov_iter_count(iter) != msg_len)) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	if (flags & MSG_DONTWAIT) {
+		if (!sc->first_error && msg_len && atomic_read(&sc->send_io.credits.count) == 0) {
+			ret = -EAGAIN;
+			SMBDIRECT_FN_RETURN_INT(sk, ret);
+			return ret;
+		}
+	}
+	flags &= ~(MSG_DONTWAIT|MSG_WAITALL|MSG_NOSIGNAL);
+
+	ret = smbdirect_connection_send_iter(sc,
+					     iter,
+					     flags,
+					     need_invalidate,
+					     remote_key);
+	if (ret < 0)
+		/* Handle error and possibly send SIGPIPE. */
+		ret = sk_stream_error(sk, msg->msg_flags, ret);
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sk_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
+{
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	lock_sock(sk);
+	ret = smbdirect_sk_sendmsg_locked(sk, msg, msg_len);
+	release_sock(sk);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sk_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	struct iov_iter *iter = &msg->msg_iter;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	if (flags & ~(MSG_DONTWAIT|MSG_WAITALL|MSG_NOSIGNAL)) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(iov_iter_rw(iter) != ITER_DEST)) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	/*
+	 * For now smbdirect_connection_recvmsg() relies
+	 * on this assertion and the current in kernel
+	 * users are working that way.
+	 */
+	if (WARN_ON_ONCE(iov_iter_count(iter) != len)) {
+		ret = -EINVAL;
+		SMBDIRECT_FN_RETURN_INT(sk, ret);
+		return ret;
+	}
+
+	lock_sock(sk);
+	if (flags & MSG_DONTWAIT) {
+		if (!sc->first_error && len && sc->recv_io.reassembly.data_length == 0) {
+			ret = -EAGAIN;
+			release_sock(sk);
+			SMBDIRECT_FN_RETURN_INT(sk, ret);
+			return ret;
+		}
+	}
+	flags &= ~(MSG_DONTWAIT|MSG_WAITALL|MSG_NOSIGNAL);
+	ret = smbdirect_connection_recvmsg(sc, msg, flags);
+	if (msg->msg_get_inq && ret >= 0)
+		msg->msg_inq = sc->recv_io.reassembly.data_length;
+	release_sock(sk);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static void smbdirect_sk_shutdown(struct sock *sk, int how)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is already locked */
+	sock_owned_by_me(sk);
+
+	smbdirect_socket_schedule_cleanup(sc, -ESHUTDOWN);
+
+	SMBDIRECT_FN_RETURN_VOID(sk);
+}
+
+static int smbdirect_sk_disconnect(struct sock *sk, int flags)
+{
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is already locked */
+	sock_owned_by_me(sk);
+
+	smbdirect_socket_schedule_cleanup(sc, -ESHUTDOWN);
+
+	if (flags & O_NONBLOCK) {
+		if (sc->status >= SMBDIRECT_SOCKET_DISCONNECTED) {
+			SMBDIRECT_FN_RETURN_INT(sk, 0);
+			return 0;
+		}
+
+		/*
+		 * This will cause SS_DISCONNECTING in
+		 * smbdirect_sock_connect_locked().
+		 */
+		SMBDIRECT_FN_RETURN_INT(sk, sc->first_error);
+		return sc->first_error;
+	}
+
+	smbdirect_socket_destroy_sync(sc);
+
+	SMBDIRECT_FN_RETURN_INT(sk, 0);
+	return 0;
+}
+
+static void smbdirect_sk_close(struct sock *sk, long timeout)
+{
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	/*
+	 * We hold an additional reference so
+	 * that the sock_put() in sk_common_release()
+	 * doesn't call sk_free(), that is potentially
+	 * deferred to our sock_put() after release_sock().
+	 *
+	 * Note that sk_common_release() calls
+	 * smbdirect_sk_destroy() as the first thing.
+	 */
+	sock_hold(sk);
+	lock_sock(sk);
+	sk_common_release(sk);
+	release_sock(sk);
+	SMBDIRECT_FN_COMMENT(sk, "before sock_put()");
+	sock_put(sk);
+}
+
+static struct percpu_counter smbdirect_sockets_allocated;
+
+static struct proto smbdirect_prot = {
+	.name			= "smbdirect",
+	.owner			= THIS_MODULE,
+	.obj_size		= sizeof(struct smbdirect_socket),
+	.ipv6_pinfo_offset	= offsetof(struct smbdirect_socket, inet6),
+	.init			= smbdirect_sk_init,
+	.destroy		= smbdirect_sk_destroy,
+	.hash			= smbdirect_sk_hash,
+	.unhash			= smbdirect_sk_unhash,
+	.release_cb		= smbdirect_sk_release_cb,
+	.bind			= smbdirect_sk_bind,
+	.accept			= smbdirect_sk_accept,
+	.pre_connect		= smbdirect_sk_pre_connect,
+	.connect		= smbdirect_sk_connect,
+	.setsockopt		= smbdirect_sk_setsockopt,
+	.getsockopt		= smbdirect_sk_getsockopt,
+	.ioctl			= smbdirect_sk_ioctl,
+	.sendmsg		= smbdirect_sk_sendmsg,
+	.recvmsg		= smbdirect_sk_recvmsg,
+	.shutdown		= smbdirect_sk_shutdown,
+	.disconnect		= smbdirect_sk_disconnect,
+	.close			= smbdirect_sk_close,
+	.sockets_allocated	= &smbdirect_sockets_allocated,
+};
+
+static int smbdirect_sock_release(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not locked */
+	sock_not_owned_by_me(sk);
+	WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		SMBDIRECT_FN_COMMENT(sk, "calling inet_release()");
+		ret = inet_release(sock);
+		break;
+	case AF_INET6:
+#if IS_ENABLED(CONFIG_IPV6)
+		SMBDIRECT_FN_COMMENT(sk, "calling inet6_release()");
+		ret = inet6_release(sock);
+#else
+		ret = -EAFNOSUPPORT;
+#endif
+		break;
+	default:
+		ret = -EAFNOSUPPORT;
+		break;
+	}
+
+	return ret;
+}
+
+static int smbdirect_sock_bind(struct socket *sock, struct sockaddr_unsized *saddr, int len)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		ret = inet_bind(sock, saddr, len);
+		break;
+	case AF_INET6:
+#if IS_ENABLED(CONFIG_IPV6)
+		ret = inet6_bind(sock, saddr, len);
+#else
+		ret = -EAFNOSUPPORT;
+#endif
+		break;
+	default:
+		ret = -EAFNOSUPPORT;
+		break;
+	}
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_connect_locked(struct socket *sock,
+					 struct sockaddr_unsized *uaddr,
+					 int addr_len, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is already locked */
+	sock_owned_by_me(sk);
+
+	if (addr_len < sizeof(uaddr->sa_family))
+		return -EINVAL;
+
+	if (sk->sk_family != uaddr->sa_family)
+		return -EAFNOSUPPORT;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		if (addr_len < sizeof(struct sockaddr_in))
+			return -EINVAL;
+		break;
+	case AF_INET6:
+		/*
+		 * We require a full struct sockaddr_in6 (28 bytes) instead of a
+		 * minimal size of SIN6_LEN_RFC2133 (24 bytes), as we don't
+		 * have any legacy callers in userspace and the
+		 * rdma layer also expects that.
+		 */
+		if (addr_len < sizeof(struct sockaddr_in6))
+			return -EINVAL;
+		break;
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	switch (sock->state) {
+	case SS_CONNECTED:
+		return -EISCONN;
+	case SS_CONNECTING:
+		return -EALREADY;
+	case SS_UNCONNECTED:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (sc->status == SMBDIRECT_SOCKET_CONNECTED)
+		return -EISCONN;
+
+	if (sc->status != SMBDIRECT_SOCKET_CREATED)
+		return -EINVAL;
+
+	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
+		ret = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
+		if (ret)
+			return ret;
+	}
+
+	ret = sk->sk_prot->connect(sk, uaddr, addr_len);
+	if (ret < 0)
+		return ret;
+
+	inet_sk_set_state(sk, TCP_SYN_SENT);
+	sock->state = SS_CONNECTING;
+
+	if (flags & O_NONBLOCK)
+		return -EINPROGRESS;
+
+	ret = smbdirect_connection_wait_for_connected(sc);
+	if (ret)
+		goto sock_error;
+
+	return 0;
+
+sock_error:
+	sock->state = SS_UNCONNECTED;
+	sk->sk_disconnects++;
+	if (sk->sk_prot->disconnect(sk, flags))
+		sock->state = SS_DISCONNECTING;
+	return ret;
+}
+
+static int smbdirect_sock_connect(struct socket *sock,
+				  struct sockaddr_unsized *uaddr,
+				  int addr_len, int flags)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	lock_sock(sk);
+	ret = smbdirect_sock_connect_locked(sock, uaddr, addr_len, flags);
+	release_sock(sk);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_listen(struct socket *sock, int backlog)
+{
+	struct sock *sk = sock->sk;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	lock_sock(sk);
+	ret = smbdirect_socket_listen(sc, backlog);
+	release_sock(sk);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_accept(struct socket *lsock, struct socket *nsock,
+				 struct proto_accept_arg *arg)
+{
+	struct sock *lsk = lsock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(lsk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(lsk);
+
+	ret = inet_accept(lsock, nsock, arg);
+	if (!ret)
+		/*
+		 * We want to handle all sockopts explicitly
+		 * and only support what we really support.
+		 */
+		set_bit(SOCK_CUSTOM_SOCKOPT, &nsock->flags);
+
+	SMBDIRECT_FN_RETURN_INT(lsk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		ret = inet_getname(sock, uaddr, peer);
+		break;
+	case AF_INET6:
+#if IS_ENABLED(CONFIG_IPV6)
+		ret = inet6_getname(sock, uaddr, peer);
+#else
+		ret = -EAFNOSUPPORT;
+#endif
+		break;
+	default:
+		ret = -EAFNOSUPPORT;
+		break;
+	}
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static __poll_t smbdirect_sock_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	struct sock *sk = sock->sk;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sk(sk);
+	__poll_t mask = 0;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	sock_poll_wait(file, sock, wait);
+
+	if (sc->status == SMBDIRECT_SOCKET_LISTENING) {
+		if (!list_empty_careful(&sc->listen.ready))
+			mask |= EPOLLIN | EPOLLRDNORM;
+		SMBDIRECT_FN_RETURN_POLL(sk, mask);
+		return mask;
+	}
+
+	if (sc->first_error) {
+		/*
+		 * A broken connection should report almost everything in order to let
+		 * applications to detect it reliable.
+		 */
+		mask |= EPOLLHUP;
+		mask |= EPOLLERR;
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
+		mask |= EPOLLOUT | EPOLLWRNORM;
+		SMBDIRECT_FN_RETURN_POLL(sk, mask);
+		return mask;
+	}
+
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
+		/*
+		 * A just created socket.
+		 */
+		SMBDIRECT_FN_RETURN_POLL(sk, mask);
+		return mask;
+	}
+
+	if (sc->recv_io.reassembly.data_length > 0)
+		mask |= EPOLLIN | EPOLLRDNORM;
+
+	if (atomic_read(&sc->send_io.bcredits.count) > 0 &&
+	    atomic_read(&sc->send_io.lcredits.count) > 0 &&
+	    atomic_read(&sc->send_io.credits.count) > 0)
+		mask |= EPOLLOUT | EPOLLWRNORM;
+	else {
+		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+
+		/*
+		 * Race breaker. If space is freed after
+		 * wspace test but before the flags are set,
+		 * IO signal will be lost. Memory barrier
+		 * pairs with the input side.
+		 */
+		smp_mb__after_atomic();
+		if (atomic_read(&sc->send_io.bcredits.count) > 0 &&
+		    atomic_read(&sc->send_io.lcredits.count) > 0 &&
+		    atomic_read(&sc->send_io.credits.count) > 0)
+			mask |= EPOLLOUT | EPOLLWRNORM;
+	}
+
+	SMBDIRECT_FN_RETURN_POLL(sk, mask);
+	return mask;
+}
+
+static int smbdirect_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	/*
+	 * We may need to handle some here as
+	 * smbirect_sk_ioctl() only gets a kernel
+	 * int pointer as arg, but we may
+	 * need to the whole struct
+	 */
+	switch (cmd) {
+	default:
+		/*
+		 * Note this has some special handling for
+		 * sk->sk_type == SOCK_RAW, in case we ever
+		 * implement SOCK_RAW...
+		 *
+		 * It calls smbdirect_sk_ioctl()...
+		 */
+		ret = sk_ioctl(sk, cmd, (void __user *)arg);
+		break;
+	}
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+	int ret = 0;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	/*
+	 * We have these from userspace:
+	 * SHUT_RD = 0, SHUT_WR = 1 and SHUT_RDWR = 2
+	 *
+	 * And we map them to SHUTDOWN_MASK = 3
+	 * RCV_SHUTDOWN = 1, SEND_SHUTDOWN = 2, BOTH = 3
+	 */
+	how++;
+	if ((how & ~SHUTDOWN_MASK) || !how)	/* MAXINT->0 */
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	switch (sk->sk_state) {
+	case TCP_CLOSE:
+		ret = -ENOTCONN;
+		fallthrough;
+	default:
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
+		sk->sk_prot->shutdown(sk, how);
+		break;
+
+	case TCP_SYN_SENT:
+	case TCP_SYN_RECV:
+		ret = sk->sk_prot->disconnect(sk, O_NONBLOCK);
+		break;
+	}
+
+	/* Wake up anyone sleeping in poll. */
+	sk->sk_state_change(sk);
+	release_sock(sk);
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_setsockopt(struct socket *sock, int level, int optname,
+				     sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	ret = sock_common_setsockopt(sock, level, optname, optval, optlen);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_getsockopt(struct socket *sock, int level, int optname,
+				     char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	ret = sock_common_getsockopt(sock, level, optname, optval, optlen);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	ret = sk->sk_prot->sendmsg(sk, msg, len);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static int smbdirect_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
+				  int flags)
+{
+	struct sock *sk = sock->sk;
+	int ret;
+
+	SMBDIRECT_FN_CALLED(sk);
+
+	/* assert it is not already locked */
+	sock_not_owned_by_me(sk);
+
+	ret = sock_common_recvmsg(sock, msg, size, flags);
+
+	SMBDIRECT_FN_RETURN_INT(sk, ret);
+	return ret;
+}
+
+static const struct proto_ops smbdirect_inet_proto_ops = {
+	.family			= PF_INET,
+	.owner			= THIS_MODULE,
+	.release		= smbdirect_sock_release,
+	.bind			= smbdirect_sock_bind,
+	.connect		= smbdirect_sock_connect,
+	.socketpair		= sock_no_socketpair,
+	.listen			= smbdirect_sock_listen,
+	.accept			= smbdirect_sock_accept,
+	.getname		= smbdirect_sock_getname,
+	.poll			= smbdirect_sock_poll,
+	.ioctl			= smbdirect_sock_ioctl,
+	.shutdown		= smbdirect_sock_shutdown,
+	.setsockopt		= smbdirect_sock_setsockopt,
+	.getsockopt		= smbdirect_sock_getsockopt,
+	.sendmsg		= smbdirect_sock_sendmsg,
+	.sendmsg_locked		= smbdirect_sk_sendmsg_locked,
+	.recvmsg		= smbdirect_sock_recvmsg,
+	.mmap			= sock_no_mmap,
+};
+
+#if IS_ENABLED(CONFIG_IPV6)
+static const struct proto_ops smbdirect_inet6_proto_ops = {
+	.family			= PF_INET6,
+	.owner			= THIS_MODULE,
+	.release		= smbdirect_sock_release,
+	.bind			= smbdirect_sock_bind,
+	.connect		= smbdirect_sock_connect,
+	.socketpair		= sock_no_socketpair,
+	.listen			= smbdirect_sock_listen,
+	.accept			= smbdirect_sock_accept,
+	.getname		= smbdirect_sock_getname,
+	.poll			= smbdirect_sock_poll,
+	.ioctl			= smbdirect_sock_ioctl,
+	.shutdown		= smbdirect_sock_shutdown,
+	.setsockopt		= smbdirect_sock_setsockopt,
+	.getsockopt		= smbdirect_sock_getsockopt,
+	.sendmsg		= smbdirect_sock_sendmsg,
+	.sendmsg_locked		= smbdirect_sk_sendmsg_locked,
+	.recvmsg		= smbdirect_sock_recvmsg,
+	.mmap			= sock_no_mmap,
+};
+#endif
+
+static struct inet_protosw smbdirect_inet_stream_protosw = {
+	.type		= SOCK_STREAM,
+	.protocol	= IPPROTO_SMBDIRECT,
+	.prot		= &smbdirect_prot,
+	.ops		= &smbdirect_inet_proto_ops,
+};
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct inet_protosw smbdirect_inet6_stream_protosw = {
+	.type		= SOCK_STREAM,
+	.protocol	= IPPROTO_SMBDIRECT,
+	.prot		= &smbdirect_prot,
+	.ops		= &smbdirect_inet6_proto_ops,
+};
+#endif
+
+struct smbdirect_socket *smbdirect_socket_from_sock(const struct socket *sock)
+{
+	if (!sock ||
+	    !sock->sk ||
+	    sock->sk->sk_protocol != IPPROTO_SMBDIRECT)
+		return NULL;
+
+	if (WARN_ON_ONCE(sock->sk->sk_destruct != smbdirect_sk_destruct))
+		return NULL;
+
+	return smbdirect_socket_from_sk(sock->sk);
+}
+__SMBDIRECT_EXPORT_SYMBOL__(smbdirect_socket_from_sock);
+
+static __init int smbdirect_protosw_init(void)
+{
+	int err;
+
+	err = proto_register(&smbdirect_prot, 1);
+	if (err)
+		return err;
+
+	inet_register_protosw(&smbdirect_inet_stream_protosw);
+#if IS_ENABLED(CONFIG_IPV6)
+	inet6_register_protosw(&smbdirect_inet6_stream_protosw);
+#endif
+
+	return 0;
+}
+
+static __exit void smbdirect_protosw_exit(void)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	inet6_unregister_protosw(&smbdirect_inet6_stream_protosw);
+#endif
+	inet_unregister_protosw(&smbdirect_inet_stream_protosw);
+
+	proto_unregister(&smbdirect_prot);
+}
+
+__init int smbdirect_proto_init(void)
+{
+	int err;
+
+	err = percpu_counter_init(&smbdirect_sockets_allocated, 0, GFP_KERNEL);
+	if (err)
+		goto err_percpu_counter;
+
+	err = smbdirect_protosw_init();
+	if (err)
+		goto err_protosw;
+
+	return 0;
+
+err_protosw:
+	percpu_counter_destroy(&smbdirect_sockets_allocated);
+err_percpu_counter:
+	return err;
+}
+
+__exit void smbdirect_proto_exit(void)
+{
+	smbdirect_protosw_exit();
+	percpu_counter_destroy(&smbdirect_sockets_allocated);
+}
+
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 257 /* IPPROTO_SMBDIRECT */, SOCK_STREAM);
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 257 /* IPPROTO_SMBDIRECT */, SOCK_STREAM);
diff --git a/fs/smb/common/smbdirect/smbdirect_public.h b/fs/smb/common/smbdirect/smbdirect_public.h
index 50088155e7c3..9f96c66bbe32 100644
--- a/fs/smb/common/smbdirect/smbdirect_public.h
+++ b/fs/smb/common/smbdirect/smbdirect_public.h
@@ -49,6 +49,7 @@ int smbdirect_socket_set_kernel_settings(struct smbdirect_socket *sc,
 #define SMBDIRECT_LOG_RDMA_MR			0x100
 #define SMBDIRECT_LOG_RDMA_RW			0x200
 #define SMBDIRECT_LOG_NEGOTIATE			0x400
+#define SMBDIRECT_LOG_SK			0x800
 void smbdirect_socket_set_logging(struct smbdirect_socket *sc,
 				  void *private_ptr,
 				  bool (*needed)(struct smbdirect_socket *sc,
@@ -145,4 +146,6 @@ void smbdirect_connection_legacy_debug_proc_show(struct smbdirect_socket *sc,
 						 unsigned int rdma_readwrite_threshold,
 						 struct seq_file *m);
 
+struct smbdirect_socket *smbdirect_socket_from_sock(const struct socket *sock);
+
 #endif /* __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_PUBLIC_H__ */
diff --git a/fs/smb/common/smbdirect/smbdirect_rw.c b/fs/smb/common/smbdirect/smbdirect_rw.c
index 3b2eb8c48efc..154339955617 100644
--- a/fs/smb/common/smbdirect/smbdirect_rw.c
+++ b/fs/smb/common/smbdirect/smbdirect_rw.c
@@ -105,11 +105,11 @@ static void smbdirect_connection_rdma_write_done(struct ib_cq *cq, struct ib_wc
 	smbdirect_connection_rdma_rw_done(cq, wc, DMA_TO_DEVICE);
 }
 
-int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
-				   void *buf, size_t buf_len,
-				   struct smbdirect_buffer_descriptor_v1 *desc,
-				   size_t desc_len,
-				   bool is_read)
+static int smbdirect_connection_rdma_xmit_locked(struct smbdirect_socket *sc,
+						 void *buf, size_t buf_len,
+						 struct smbdirect_buffer_descriptor_v1 *desc,
+						 size_t desc_len,
+						 bool is_read)
 {
 	const struct smbdirect_socket_parameters *sp = &sc->parameters;
 	enum dma_data_direction direction = is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
@@ -123,6 +123,8 @@ int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
 	int credits_needed;
 	size_t desc_buf_len, desc_num = 0;
 
+	smbdirect_socket_sk_owned_by_me(sc);
+
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED)
 		return -ENOTCONN;
 
@@ -235,7 +237,9 @@ int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
 	}
 
 	msg = list_last_entry(&msg_list, struct smbdirect_rw_io, list);
+	smbdirect_socket_sk_unlock(sc);
 	wait_for_completion(&completion);
+	smbdirect_socket_sk_lock(sc);
 	ret = msg->error;
 out:
 	list_for_each_entry_safe(msg, next_msg, &msg_list, list) {
@@ -252,4 +256,19 @@ int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
 	kfree(msg);
 	goto out;
 }
+
+int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
+				   void *buf, size_t buf_len,
+				   struct smbdirect_buffer_descriptor_v1 *desc,
+				   size_t desc_len,
+				   bool is_read)
+{
+	int ret;
+
+	smbdirect_socket_sk_lock(sc);
+	ret = smbdirect_connection_rdma_xmit_locked(sc, buf, buf_len, desc, desc_len, is_read);
+	smbdirect_socket_sk_unlock(sc);
+
+	return ret;
+}
 __SMBDIRECT_EXPORT_SYMBOL__(smbdirect_connection_rdma_xmit);
diff --git a/fs/smb/common/smbdirect/smbdirect_socket.c b/fs/smb/common/smbdirect/smbdirect_socket.c
index 9153e1dbf53d..76e406999588 100644
--- a/fs/smb/common/smbdirect/smbdirect_socket.c
+++ b/fs/smb/common/smbdirect/smbdirect_socket.c
@@ -5,6 +5,7 @@
  */
 
 #include "smbdirect_internal.h"
+#include <net/transp_v6.h>
 
 bool smbdirect_frwr_is_supported(const struct ib_device_attr *attrs)
 {
@@ -217,6 +218,7 @@ int smbdirect_socket_set_kernel_settings(struct smbdirect_socket *sc,
 	sc->send_io.mem.gfp_mask = gfp_mask;
 	sc->recv_io.mem.gfp_mask = gfp_mask;
 	sc->rw_io.mem.gfp_mask = gfp_mask;
+	sc->sk.sk_allocation = gfp_mask;
 
 	return 0;
 }
@@ -242,6 +244,106 @@ void smbdirect_socket_set_logging(struct smbdirect_socket *sc,
 }
 __SMBDIRECT_EXPORT_SYMBOL__(smbdirect_socket_set_logging);
 
+int smbdirect_socket_sync_saddr_to_sk(struct smbdirect_socket *sc, bool *_is_any_addr)
+{
+	struct sock *sk = &sc->sk;
+	const struct sockaddr_storage *saddr;
+	const struct sockaddr_in *sin;
+	const struct sockaddr_in6 *sin6;
+	struct in_addr sin_addr = { .s_addr = htonl(INADDR_ANY), };
+	struct in6_addr sin6_addr = in6addr_any;
+	__be32 sin6_flowinfo = 0;
+	bool is_any_addr = true;
+	u16 sport = 0;
+	int ret;
+
+	saddr = &sc->rdma.cm_id->route.addr.src_addr;
+
+	if (WARN_ON_ONCE(saddr->ss_family != sk->sk_family)) {
+		ret = -EINVAL;
+		return ret;
+	}
+
+	switch (saddr->ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)saddr;
+		sport = ntohs(sin->sin_port);
+		sin_addr = sin->sin_addr;
+		is_any_addr = (sin_addr.s_addr == htonl(INADDR_ANY));
+		break;
+
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)saddr;
+		sport = ntohs(sin6->sin6_port);
+		sin_addr.s_addr = LOOPBACK4_IPV6;
+		sin6_addr = sin6->sin6_addr;
+		is_any_addr = ipv6_addr_any(&sin6_addr);
+		sin6_flowinfo = sin6->sin6_flowinfo;
+		break;
+	}
+
+	sk->sk_bound_dev_if = sc->rdma.cm_id->route.addr.dev_addr.bound_dev_if;
+	sk->sk_rcv_saddr = sc->inet.inet_saddr = sin_addr.s_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+	sk->sk_v6_rcv_saddr = sc->inet6.saddr = sin6_addr;
+#else
+	sc->inet6.saddr = sin6_addr;
+#endif
+	sc->inet6.flow_label = sin6_flowinfo;
+	sk->sk_num = sport;
+	sc->inet.inet_sport = htons(sport);
+
+	if (_is_any_addr)
+		*_is_any_addr = is_any_addr;
+	return 0;
+}
+
+int smbdirect_socket_sync_daddr_to_sk(struct smbdirect_socket *sc)
+{
+	struct sock *sk = &sc->sk;
+	const struct sockaddr_storage *daddr;
+	const struct sockaddr_in *sin;
+	const struct sockaddr_in6 *sin6;
+	struct in_addr sin_addr = { .s_addr = htonl(INADDR_ANY), };
+#if IS_ENABLED(CONFIG_IPV6)
+	struct in6_addr sin6_addr = in6addr_any;
+#endif
+	u16 dport = 0;
+	int ret;
+
+	daddr = &sc->rdma.cm_id->route.addr.dst_addr;
+
+	if (WARN_ON_ONCE(daddr->ss_family != sk->sk_family)) {
+		ret = -EINVAL;
+		return ret;
+	}
+
+	switch (daddr->ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)daddr;
+		dport = ntohs(sin->sin_port);
+		sin_addr = sin->sin_addr;
+		break;
+
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)daddr;
+		dport = ntohs(sin6->sin6_port);
+		sin_addr.s_addr = LOOPBACK4_IPV6;
+#if IS_ENABLED(CONFIG_IPV6)
+		sin6_addr = sin6->sin6_addr;
+#endif
+		break;
+	}
+
+	sk->sk_daddr = sc->inet.inet_daddr = sin_addr.s_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+	sk->sk_v6_daddr = sin6_addr;
+#endif
+	sk->sk_dport = sc->inet.inet_dport = htons(dport);
+
+	return 0;
+}
+
 static void smbdirect_socket_wake_up_all(struct smbdirect_socket *sc)
 {
 	/*
@@ -257,6 +359,38 @@ static void smbdirect_socket_wake_up_all(struct smbdirect_socket *sc)
 	wake_up_all(&sc->recv_io.reassembly.wait_queue);
 	wake_up_all(&sc->rw_io.credits.wait_queue);
 	wake_up_all(&sc->mr_io.ready.wait_queue);
+
+	if (sc->sk.sk_family) {
+		struct sock *sk = &sc->sk;
+
+		WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
+
+		WARN_ON_ONCE(sc->first_error == 0);
+		if (sc->first_error < 0)
+			WRITE_ONCE(sk->sk_err, -sc->first_error);
+		else
+			WRITE_ONCE(sk->sk_err, sc->first_error);
+
+		if (sc->status >= SMBDIRECT_SOCKET_DISCONNECTED) {
+			inet_sk_set_state(sk, TCP_CLOSE);
+			if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+				sk->sk_socket->state = SS_UNCONNECTED;
+		} else {
+			inet_sk_set_state(sk, TCP_CLOSING);
+			if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+				sk->sk_socket->state = SS_DISCONNECTING;
+		}
+
+		/*
+		 * Note tcp_done_with_error() also calls both
+		 * sk->sk_state_change(sk) via tcp_done()
+		 * and sk_error_report() directly.
+		 */
+		if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+			sk->sk_state_change(sk);
+		if (!sock_flag(sk, SOCK_DEAD) && sk->sk_socket)
+			sk_error_report(sk);
+	}
 }
 
 void __smbdirect_socket_schedule_cleanup(struct smbdirect_socket *sc,
@@ -510,11 +644,13 @@ static void smbdirect_socket_destroy(struct smbdirect_socket *sc)
 	 */
 	smbdirect_socket_wake_up_all(sc);
 
+	smbdirect_socket_sk_unlock(sc);
 	disable_work_sync(&sc->disconnect_work);
 	disable_work_sync(&sc->connect.work);
 	disable_work_sync(&sc->recv_io.posted.refill_work);
 	disable_work_sync(&sc->idle.immediate_work);
 	disable_delayed_work_sync(&sc->idle.timer_work);
+	smbdirect_socket_sk_lock(sc);
 
 	if (sc->rdma.cm_id)
 		rdma_lock_handler(sc->rdma.cm_id);
@@ -600,6 +736,8 @@ void smbdirect_socket_destroy_sync(struct smbdirect_socket *sc)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
+	smbdirect_socket_sk_owned_by_me(sc);
+
 	/*
 	 * First we try to disable the work
 	 * without disable_work_sync() in a
@@ -625,7 +763,9 @@ void smbdirect_socket_destroy_sync(struct smbdirect_socket *sc)
 
 	smbdirect_log_rdma_event(sc, SMBDIRECT_LOG_INFO,
 		"cancelling and disable disconnect_work\n");
+	smbdirect_socket_sk_unlock(sc);
 	disable_work_sync(&sc->disconnect_work);
+	smbdirect_socket_sk_lock(sc);
 
 	smbdirect_log_rdma_event(sc, SMBDIRECT_LOG_INFO,
 		"destroying rdma session\n");
@@ -634,7 +774,9 @@ void smbdirect_socket_destroy_sync(struct smbdirect_socket *sc)
 	if (sc->status < SMBDIRECT_SOCKET_DISCONNECTED) {
 		smbdirect_log_rdma_event(sc, SMBDIRECT_LOG_INFO,
 			"wait for transport being disconnected\n");
+		smbdirect_socket_sk_unlock(sc);
 		wait_event(sc->status_wait, sc->status == SMBDIRECT_SOCKET_DISCONNECTED);
+		smbdirect_socket_sk_lock(sc);
 		smbdirect_log_rdma_event(sc, SMBDIRECT_LOG_INFO,
 			"waited for transport being disconnected\n");
 	}
@@ -723,6 +865,8 @@ int smbdirect_socket_wait_for_credits(struct smbdirect_socket *sc,
 {
 	int ret;
 
+	smbdirect_socket_sk_owned_by_me(sc);
+
 	if (WARN_ON_ONCE(needed < 0))
 		return -EINVAL;
 
@@ -731,9 +875,12 @@ int smbdirect_socket_wait_for_credits(struct smbdirect_socket *sc,
 			return 0;
 
 		atomic_add(needed, total_credits);
+
+		smbdirect_socket_sk_unlock(sc);
 		ret = wait_event_interruptible(*waitq,
 					       atomic_read(total_credits) >= needed ||
 					       sc->status != expected_status);
+		smbdirect_socket_sk_lock(sc);
 
 		if (sc->status != expected_status)
 			return unexpected_errno;
diff --git a/fs/smb/common/smbdirect/smbdirect_socket.h b/fs/smb/common/smbdirect/smbdirect_socket.h
index c09eddd8ad16..6bb201683259 100644
--- a/fs/smb/common/smbdirect/smbdirect_socket.h
+++ b/fs/smb/common/smbdirect/smbdirect_socket.h
@@ -104,6 +104,18 @@ enum smbdirect_keepalive_status {
 };
 
 struct smbdirect_socket {
+	union {
+		struct sock sk;
+		struct inet_sock inet;
+	};
+	/* needed by inet6_create() */
+	struct ipv6_pinfo inet6;
+	void (*orig_sk_destruct)(struct sock *sk);
+
+	/*
+	 * This is the first element that is
+	 * initialized in smbdirect_socket_init()
+	 */
 	enum smbdirect_socket_status status;
 	wait_queue_head_t status_wait;
 	int first_error;
@@ -548,14 +560,18 @@ static void __smbdirect_log_printf(struct smbdirect_socket *sc,
 		__smbdirect_log_generic(sc, lvl, SMBDIRECT_LOG_RDMA_RW, fmt, ##args)
 #define smbdirect_log_negotiate(sc, lvl, fmt, args...) \
 		__smbdirect_log_generic(sc, lvl, SMBDIRECT_LOG_NEGOTIATE, fmt, ##args)
+#define smbdirect_log_sk(sc, lvl, fmt, args...) \
+		__smbdirect_log_generic(sc, lvl, SMBDIRECT_LOG_SK, fmt, ##args)
 
 static __always_inline void smbdirect_socket_init(struct smbdirect_socket *sc)
 {
+	const size_t status_offset = offsetof(struct smbdirect_socket, status);
+
 	/*
 	 * This also sets status = SMBDIRECT_SOCKET_CREATED
 	 */
 	BUILD_BUG_ON(SMBDIRECT_SOCKET_CREATED != 0);
-	memset(sc, 0, sizeof(*sc));
+	memset(((u8 *)sc)+status_offset, 0, sizeof(*sc)-status_offset);
 
 	init_waitqueue_head(&sc->status_wait);
 
@@ -700,6 +716,14 @@ static __always_inline void smbdirect_socket_init(struct smbdirect_socket *sc)
 	__SMBDIRECT_CHECK_STATUS_WARN(__sc, __expected_status, \
 		__SMBDIRECT_SOCKET_DISCONNECT(__sc);)
 
+static __always_inline struct smbdirect_socket *
+smbdirect_socket_from_sk(const struct sock *sk)
+{
+	WARN_ON_ONCE(!sk);
+	BUILD_BUG_ON(offsetof(struct smbdirect_socket, sk) != 0);
+	return container_of(sk, struct smbdirect_socket, sk);
+}
+
 struct smbdirect_send_io {
 	struct smbdirect_socket *socket;
 	struct ib_cqe cqe;
-- 
2.43.0


