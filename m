Return-Path: <linux-rdma+bounces-16957-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLqEEPxzlGlMEAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16957-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 14:58:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82D14CDCD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 14:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3FC33015178
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A7436E478;
	Tue, 17 Feb 2026 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnA7tQCh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217B36D4FD
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336496; cv=none; b=plmwdsDKfCOk0323Ah5HDK8KulmSymcRNxDraWv7gaXRnn4I95c1Fb8l2OFPejZPFVCkuFCiOQycEfB/iJn6w5O9q4HhmXJBJoLpnN/E+W1V0YrUfD2ZyCoQZP3kR+8Tm7YXeUuQVfcr7VNK9DhhyDPW6ZsvkZ+kZb0LTGm2hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336496; c=relaxed/simple;
	bh=tpVz+/9KZhMiHs88YAAeN8j1bHrbz5eQ3HN+VNf5ImU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlRsw70Adv78mvxZFSWBlzJhGidK4fOeGpkWYePrqGmhIfRAhwNfsIguAOo9RFrQyGtx9JYrn4qw6Uls8MUisz3D+qjzKToD8XSVKhAddsTSzBCV51l0dgafRwBbIOigOAbjvEPD+Jo4BW3tWuNts+z7kZf8Ec64UVv3SHbNY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnA7tQCh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so39912485e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 05:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771336493; x=1771941293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/Db8GHeRwj5/JWbCcVvx6pqqRvI6zmNzmG5BE40n8U=;
        b=LnA7tQChJjVFuMVz2uv9kN5bp4ZrKtmIO/ltHP6mhlpfgYZ6pB8BgiYSVD40Ym5oBZ
         oBMLCoIbDsyc/ZOlz8KMq0lwk4+Pk+M2qdgPQ1fuxnpayM5bTz/ugEorif8cSQYFjjM3
         i+Yjj8bxv+OYNInlZChXTPcpILkb7tie/+1+TwnCn7gCJwb1RRaiV5Is6RCyrs8qgHAK
         +LhLDRjtsUbe0e2KNtFmA/te3GHSQBLWll3RbC2CjpLASW4owSIToSsPN5HCKLoR/3Dl
         Aermv9Y2Ys6By+HS0inXPK5Cy1v+mTN4MyrQM9+MWQttQT7tBeyqweSiqfQ6aIiX4X44
         UxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771336493; x=1771941293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/Db8GHeRwj5/JWbCcVvx6pqqRvI6zmNzmG5BE40n8U=;
        b=lU0wr2c8liXcJ8drdePxI2iDc6Vv/2DWwRAKWO7OW6l1Gh+9PBBHKyL85I73ENMO0p
         Mw+8vPfMsxLu5G/ZaypXXjJJXdte0mMqHkvmbz/h4hSwXZMBaAPGX554jCszPRHbchCx
         aQeN9moeE7PTNEHpzpVl1Hv3dl7CcuB/aVDGVLwcLAOLL6aIgthBDe8vHiaqlv4ft+0T
         KvV1vq3uOMbXGlzSYt39g/1ndJEUkwTXBLTNOEIVkvJhPF5wG8oYpojllWVndnZsccSV
         YpB/1+ewxj9vl2+4VKNmjR/dPSnKDRtUbOhua+DxqGw/UxK6EGp5a9s77De2Qs4gIOUS
         y8zA==
X-Forwarded-Encrypted: i=1; AJvYcCVsVvSYtSF4IQ0NTtXdwV9jKaJHlqOFT404fmpgejbcaiK+pWeseDSepXMX7t70aKZBU2lVVHjwWd36@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUXHDj/lRb5JpBM5z03lmN4QbwyhVO5M8nWJZW8XKzp8P+SVw
	e0cXEw57dc+GjvQL7dRnFTKtfTp4Sv8r6vUr1/4IcgK9DwQr25Wr/2qd
X-Gm-Gg: AZuq6aKM1JZk5wMvCf3PJBZPXpdxWZ/23NmVm55MIs44PrDqhdVpXCP3rJDsHUOnvIy
	28QTtNaO5TWJFEMlTXeYhtpRKRDqLgieU7P42HCywgSJPGHrtIgJJ8NwL0iCNqkTFtl84vGrNOr
	kPX0rjKFluvW1bqww7ge+4jOGG0q4M3WFJ4tiJRhSLfpATV12qZ+HHwCWwj7/Ap9ndJ9U7IxEDb
	jiHym9cQFkOhNxeOEI90ZZvzS/98V6B5uOyZrjjWRhVBC7yZZVVRicfkYx4aThvcjH+9xkj40aj
	0yTLXhOVPPJlTbhMCbaD7earXU8vOJ7NEBD0vOpt/JWccaM3mTpn3QZmjsN1RslC/IS4ddHMzVr
	nVjcywYq4plK9mHMPnfsKyAMWXWfi85qHvN9sZp9Frg7FDDWz7BF3vOleX916n9c9bydtWcPVNY
	UntegS6swf7ex9r7qfmzy/eiMbAPj3kwG11fjvEoRkJRO57OoAsmY9nl7ziXD4ipTTMA==
X-Received: by 2002:a05:600c:524d:b0:483:4807:210c with SMTP id 5b1f17b1804b1-48373a5d7a0mr285729075e9.24.1771336492692;
        Tue, 17 Feb 2026 05:54:52 -0800 (PST)
Received: from tabrez-VivoBook-ASUSLaptop-X513UA-KM513UA.. ([27.4.206.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b07fsm33993120f8f.2.2026.02.17.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:54:51 -0800 (PST)
From: Tabrez Ahmed <tabreztalks@gmail.com>
To: allison.henderson@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gerd.rausch@oracle.com,
	charmitro@posteo.net,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tabrez Ahmed <tabreztalks@gmail.com>,
	syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Subject: [PATCH net v2] rds: tcp: fix uninit-value in __inet_bind
Date: Tue, 17 Feb 2026 19:23:49 +0530
Message-ID: <20260217135350.33641-1-tabreztalks@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,posteo.net,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-16957-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabreztalks@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,aae646f09192f72a68dc];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 5C82D14CDCD
X-Rspamd-Action: no action

KMSAN reported an uninit-value access in __inet_bind() when binding
an RDS TCP socket.

The uninitialized memory originates from rds_tcp_conn_alloc(),
which uses kmem_cache_alloc() to allocate the rds_tcp_connection structure.

Specifically, the field 't_client_port_group' is incremented in
rds_tcp_conn_path_connect() without being initialized first:

    if (++tc->t_client_port_group >= port_groups)

Since kmem_cache_alloc() does not zero the memory, this field contains
garbage, leading to the KMSAN report.

Fix this by using kmem_cache_zalloc() to ensure the structure is
zero-initialized upon allocation.

Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
Tested-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Fixes: a20a6992558f ("net/rds: Encode cp_index in TCP source port")

Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
---
v2:
 - Updated Fixes tag to point to commit a20a6992558f as requested by
   Charalampos Mitrodimas and Allison Henderson.
 - Explicitly mentioned 't_client_port_group' in the commit message.
 - Fixed line wrapping to be under 75 characters. 

 net/rds/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 45484a93d75f..04f310255692 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -373,7 +373,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 	int ret = 0;
 
 	for (i = 0; i < RDS_MPATH_WORKERS; i++) {
-		tc = kmem_cache_alloc(rds_tcp_conn_slab, gfp);
+		tc = kmem_cache_zalloc(rds_tcp_conn_slab, gfp);
 		if (!tc) {
 			ret = -ENOMEM;
 			goto fail;
-- 
2.43.0


