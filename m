Return-Path: <linux-rdma+bounces-19100-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCZsDzYc1Wli0wcAu9opvQ
	(envelope-from <linux-rdma+bounces-19100-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 17:01:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E513B08A6
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896E930D1E08
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1607533C1BD;
	Tue,  7 Apr 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="mGSdguxW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D833ADAB;
	Tue,  7 Apr 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573721; cv=none; b=n6WDmWr77jAfyrQII0zh/MiKnwOuhQFM0Jr57ZdPAmpJiwSgm8EZQgzOXFt5XuCehHHxI/l36F9FED8ASg1Y6sEI5/RbwZob/T1HnkIAQe8SscQ4RFjuBGWrs3VciDBfnrxiNPyL3o/A5NaWQ1Zh6BmKZ3tO8WJyyfLR0OZ+VZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573721; c=relaxed/simple;
	bh=Vr7+Y9O6Lq0UctbS41Ypfr586Zm9YHBHCjGTcLSBDdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itGoXDC5r7klGlpDDiGnttCZ3q+jaWvMDvasOCkv4I7mhPFQdlgH39dUxOxJqkpxu3N8+u3pYpM4ofQvMtwdomQ+569jz6SkkkXVHABdoWJMQckSJG+aG9BI2N2AXbsMJSY/GHhF8mxdB/BQGqkC88Qnhqng6wm4kFh8W7bH8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=mGSdguxW; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=KWVlvf/fLA4JQzZbInCx2uw0d9Dz/WHGRPxlljy4Ttw=; b=mGSdguxWBFjgZo63d/t65P6+z9
	pdRGYfVK8+7ziH7WzurTclyg6OtYVeUp87NfHUeBRHrLvNioM0CJKvzRLvm0BDnSFHvfKanCIjdg6
	b5bAPDNFWNI/x3yUJqNkhvKJGj4JBdK4k0z4YzJA/KR4YWOrkJJN8za09IQv1casJmfPVsVuEJAiE
	lndPPPtc+3kWt8Gp05pufZOZEELRbOBmALl3nTVnj+IYgZOCwhRoCBe7vhg0L9QJcf3pY4nfxpDo+
	4pVXvxpp+1LMRmb/LlPyGKbufSU/A1nPRI5HrrUKBvVRVcglCZrvyrULSL1+VAVblQLHqpeYHg4S/
	26dBM3RvFU/95VIQrRMMTQ8zK0THs1SqDXR9P2enZqZntZZ+nu8HbtJf4z/tuVDUAUYsmXZYBLlZf
	+crEDXMaKSvBX0JDiI/7H7LGLNldBP+8qrzwdjv9sIN6l05JNfXnptzR9PUE99RdCJgGLrExnfSyY
	b1qKNhG09rtB8L/5pbmSMZCW;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA7hp-00000007WOO-39uS;
	Tue, 07 Apr 2026 14:47:05 +0000
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
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-next@vger.kernel.org
Subject: [PATCH 0/8] smb: add kernel internal IPPROTO_SMBDIRECT
Date: Tue,  7 Apr 2026 16:46:26 +0200
Message-ID: <cover.1775571957.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,gmail.com,talpey.com,microsoft.com,kernel.org,redhat.com,suse.com,davemloft.net,google.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-19100-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:dkim,samba.org:mid,samba.org:url]
X-Rspamd-Queue-Id: D5E513B08A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

as the work to unify the smbdirect code
between cifs.ko and ksmbd.ko into an smbdirect.ko
is in linux-next for a while this is the next
step to also share the code with userspace
e.g. Samba as client and server.

The SMBDIRECT protocol, defined in [MS-SMBD] by Microsoft.
It is used as wrapper around RDMA in order to provide a transport for SMB3,
but Microsoft also uses it as transport for other protocols.

SMBDIRECT works over Infiniband, RoCE and iWarp.  RoCEv2 is based on IP/UDP
and iWarp is based on IP/TCP, so these use IP addresses natively.
Infiniband and RoCEv1 require IPOIB in order to be used for SMBDIRECT.

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

For now the core smbdirect code still supports both
modes, direct calls in indirect via the socket layer.
The core code uses if (sc->sk.sk_family) as indication
for the new socket mode. Once cifs.ko and ksmbd.ko
are converted we can remove the old mode slowly,
but I'll deferr that to a future patchset.

There's still a way to go in order to make this
as generic as tcp and quic e.g. adding MSG_SPLICE_PAGES support or
splice_read/read_sock/read_skb.

But it's a good start, which will make changes much easier.

This patchset is based on top of the smbdirect.ko patches
in ksmbd-for-next and it's also based on netdev-next
because it needs this commit from there:
8341c989ac77d712c7d6e2bce29e8a4bcb2eeae4
"net: remove addr_len argument of recvmsg() handlers"

Patches 1-4 are some preparation fixes for the
existing smbdirect.ko patchset. We may
squash them into the existing patches before
sending them to Linus. But for now I kept
them separately. I also don't cc the network and rdma
people on these...

Patch 5 defines IPPROTO_SMBDIRECT and SOL_SMBDIRECT
constants (and also reserve the number 288 for SOL_QUIC
as applications are already using that and we don't
want to conflict)

Patch 6 adds basic IPPROTO_SMBDIRECT layering
on top of the existing smbdirect code.
This is just enough in order to let cifs.ko
and ksmbd.ko use it in the following commits,
so userspace still sees -EPROTONOSUPPORT.

Patch 7 converts cifs.ko to use IPPROTO_SMBDIRECT
as much as currently possible.
Using sock_sendmsg is not yet possible, because of the
tcp_sock_set_cork usage, but that will change in future.

Patch 8 converts ksmbd.ko to use IPPROTO_SMBDIRECT.

Because of the need for netdev-next commit
8341c989ac77d712c7d6e2bce29e8a4bcb2eeae4
"net: remove addr_len argument of recvmsg() handlers"
it's a bit tricky to prepare something that would not
cause problems in linux-next.

We could merge in netdev-next completely,
but I saw commit 00f03539e3d97af925abf42992d8c46167d54243
in next-20260406, indicates some resolved conflicts
with (at least) the rdma tree, which comes
just before netdev-next, while ksmbd-for-next is merged
before all of them. So merging netdev-next into
ksmbd-for-next changes the order of netdev-next vs. rdma.

Or we add a new branch smbdirect-for-next that's
merged into linux-next after netdev-next.

Or a bit hacky but likely easier, ksmbd-for-next
just cherry-picks 8341c989ac77d712c7d6e2bce29e8a4bcb2eeae4
"net: remove addr_len argument of recvmsg() handlers"
and that cherry picked commit is reverted as
last commit in ksmbd-for-next, or only in linux-next
right before netdev-next is merged.

For now I have the patches in a branch with a
cherry picked version of the needed commit only, see
for-7.1/ipproto-smbdirect-20260407-v1 at commit:
e1972e6f1fda9842c5724b7daf4a2aa7779901a5
git fetch https://git.samba.org/metze/linux/wip.git for-7.1/ipproto-smbdirect-20260407-v1
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/for-7.1/ipproto-smbdirect-20260407-v1

It would be great to get this somehow into linux-next soon :-)

Stefan Metzmacher (8):
  smb: smbdirect: change
    smbdirect_socket_parameters.{initiator_depth,responder_resources} to
    __u16
  smb: smbdirect: fix copyright header of smbdirect.h
  smb: smbdirect: fix the logic in smbdirect_socket_destroy_sync()
    without an error
  smb: smbdirect: let smbdirect_connection_deregister_mr_io unlock while
    waiting
  net: define IPPROTO_SMBDIRECT and SOL_SMBDIRECT constants
  smb: smbdirect: add in kernel only support for IPPROTO_SMBDIRECT
  smb: client: make use of IPPROTO_SMBDIRECT sockets
  smb: server: make use of IPPROTO_SMBDIRECT sockets

 fs/smb/client/cifs_debug.c                    |    2 +-
 fs/smb/client/cifsfs.c                        |    2 +-
 fs/smb/client/cifsglob.h                      |    7 +-
 fs/smb/client/connect.c                       |  123 +-
 fs/smb/client/file.c                          |    8 +-
 fs/smb/client/sess.c                          |    4 +-
 fs/smb/client/smb2ops.c                       |    8 +-
 fs/smb/client/smb2pdu.c                       |   10 +-
 fs/smb/client/smbdirect.c                     |  275 +--
 fs/smb/client/smbdirect.h                     |   27 +-
 fs/smb/client/transport.c                     |    2 +-
 fs/smb/common/smbdirect/Makefile              |    1 +
 fs/smb/common/smbdirect/smbdirect.h           |   69 +-
 fs/smb/common/smbdirect/smbdirect_accept.c    |   14 +-
 .../common/smbdirect/smbdirect_connection.c   |   58 +
 fs/smb/common/smbdirect/smbdirect_devices.c   |    2 +-
 fs/smb/common/smbdirect/smbdirect_internal.h  |   59 +-
 fs/smb/common/smbdirect/smbdirect_listen.c    |   49 +-
 fs/smb/common/smbdirect/smbdirect_main.c      |   45 +
 fs/smb/common/smbdirect/smbdirect_mr.c        |   18 +
 fs/smb/common/smbdirect/smbdirect_proto.c     | 1549 +++++++++++++++++
 fs/smb/common/smbdirect/smbdirect_public.h    |    3 +
 fs/smb/common/smbdirect/smbdirect_rw.c        |   29 +-
 fs/smb/common/smbdirect/smbdirect_socket.c    |  180 +-
 fs/smb/common/smbdirect/smbdirect_socket.h    |   26 +-
 fs/smb/server/transport_rdma.c                |  119 +-
 include/linux/socket.h                        |    2 +
 include/uapi/linux/in.h                       |    2 +
 28 files changed, 2320 insertions(+), 373 deletions(-)
 create mode 100644 fs/smb/common/smbdirect/smbdirect_proto.c

-- 
2.43.0


