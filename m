Return-Path: <linux-rdma+bounces-18290-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGkjK9xKummWTwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18290-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 07:49:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0FF2B68CA
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 07:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B51BB3010621
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B094736493A;
	Wed, 18 Mar 2026 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbT3p7Iw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51E337B81
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816538; cv=none; b=tf9hXKJV9SSZHp7biNmQyJ65cxlNmZhwU7sD//g1neHtQtq33NWyGUVt73/1ii6aRjuLa2vkOsz8eOIunRxPOz9HtRDHi5TzWPgzDr1Rom7dfNsS5gK0sfKc1jAXHXhtEqDKwbGzjYP1v+Ap1ab4uFiNj34Iyqjby2dzoyEZXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816538; c=relaxed/simple;
	bh=Qj1QkGketFTLM6FhMiga1uXkk9E+QIhjnrMOjTAq2ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fV7o3v/Jvyq6o2Hed4rMPpq/+i3MJ8H3/1jmdjPnWSphzVB/TQ1LeB/s4BBtd9vrxMnrT18eBfM5whMD5YgfpyWzAXf31mDKTDq7kkj8hD/CzEWkSn1Pv4ihtD8YIaTIcbJkDe0mLsdx4H5ZLnszGna2pglPQEQR8fGsgS0koUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbT3p7Iw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad21f437eeso5964675ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773816537; x=1774421337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwVGV5+seuNEQDXpmjKxLE/WMiIEl6PzK6G5vJJXXZA=;
        b=YbT3p7IwofRR4B71gvIvW4EYvPkkHFAZKnxd325boEmEBFUL/kF+aumEjLzU6wTeVi
         J4wJ1MlBDsN9y0A5iwvtdSJ6WmSy1fgLfWvB1FcCA0c8hEajcFDp+KLme9ciDi1sDa9W
         wnj86JwfQquO42V7nWuafBoYJRLPlLE19MJG+CpRN+HqUHcmgB/T5sXbp7udQ4DobENp
         Xa/wkzsznNFEVBZm/0k3L+K7vwji1nj4hG6WTj/rGJcx2MP6k5mzBQJ72ADF+v+qddPj
         LNIAfnrimodMiZ9rkFX+rnCICM9/mmWOs4sgDi4BOs8m1Dd4IA6kPtUJd0AnV3ZN6DcP
         1olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773816537; x=1774421337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwVGV5+seuNEQDXpmjKxLE/WMiIEl6PzK6G5vJJXXZA=;
        b=knqzR2jexkpWlPBtzW29s/mY561jRjVHxZviFMLs0Lh3Njif5LIc9F2edZnbxkVWzZ
         WAdJSCDlhIq3uqFxe3cSkbeiaMuhz6NghoOZT/WUdijy1PELwQ5pPpelFi7I5jHXy/Hz
         us0pPI7U6X7rqq0l4u/pJOYT3EGOMenDgBIEkRPuEEj7MYCZdm3Ce43JfOeAFYPXMte7
         f0mQMOWAOKKRs5jNAi/s5PWSDAaJM+aenflWgrfaqZu27gKeU+lj+RazYQbqXjrg9b3+
         syUAsp1U5/VP0MUdX78ADth5M0O/eZJusGTLj71xn0RZVL30qWoj4s1/9vFp44TY3xZc
         kjTA==
X-Forwarded-Encrypted: i=1; AJvYcCVjlo2GBQLjyQIC2drYChRFMKOhih1joPVV41t6naWdHkmLZS01eUyFUupemfuJtDetNMV9EcRdxI2k@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkkq1BSsKnu99aaKgebmb9ObJH27TW4uhoynP6l8VufprdO+mk
	OqzmYczHSJTBZ4ROb9YogN4i/zpqsg1G583d8/wZSEdm+rRfFx2WxK6Jdq/9tCVUKrJZgQ==
X-Gm-Gg: ATEYQzxZRp0AR7xE0kA/JZiPV3grwPW1zkKnVcR9nJq+t0fjbpRAJIdwbHiS2OTBVyd
	tnm/w9WJTkrukN1sxqtdctDooIqzp86rvEiXb0aFgsUZ6IqEvvXz+WiqEqv/sGZQRpCRC1MPRV0
	jjTG1aokYVHyBWRu5UYJyOitMkVNTpqsWP1GCB8MDTxYpwCApvo24/hdTgW0rHpQQhiKKdXpRWp
	BrEHWaZzshAQVAemq2KFtnpefpQOofL5CdvCDRAD/7q0vYiORtClZOjSQNLB8gGv7EXfcc5Wuu0
	k+wzPVGPt+bffRkhAGOIiCRBIjTev3XUQz9JHzl62CZn7BGjdAgYLAjv4BcoLpAZXSjq3GeMznp
	iwR/UHGcDF/Sfoto9wvxJ7n/E/xBcheBLFGYAtKxujpgcS1/rijcbVS/e3Ezcg4BdVaZDpYEbLk
	nXi9WxD12n9ej8JIi8n9jUINQ1MoL9VgSd
X-Received: by 2002:a17:903:94b:b0:2ae:5a38:96bb with SMTP id d9443c01a7336-2b06357efd3mr61873795ad.2.1773816536783;
        Tue, 17 Mar 2026 23:48:56 -0700 (PDT)
Received: from localhost.localdomain ([101.5.20.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e6315dcsm19262845ad.80.2026.03.17.23.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:48:55 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net] net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer
Date: Wed, 18 Mar 2026 14:48:47 +0800
Message-ID: <20260318064847.23341-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18290-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F0FF2B68CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smc_rx_splice() allocates one smc_spd_priv per pipe_buffer and stores
the pointer in pipe_buffer.private.  The pipe_buf_operations for these
buffers used .get = generic_pipe_buf_get, which only increments the page
reference count when tee(2) duplicates a pipe buffer.  The smc_spd_priv
pointer itself was not handled, so after tee() both the original and the
cloned pipe_buffer share the same smc_spd_priv *.

When both pipes are subsequently released, smc_rx_pipe_buf_release() is
called twice against the same object:

  1st call: kfree(priv)  sock_put(sk)  smc_rx_update_cons()  [correct]
  2nd call: kfree(priv)  sock_put(sk)  smc_rx_update_cons()  [UAF]

KASAN reports a slab-use-after-free in smc_rx_pipe_buf_release(), which
then escalates to a NULL-pointer dereference and kernel panic via
smc_rx_update_consumer() when it chases the freed priv->smc pointer:

  BUG: KASAN: slab-use-after-free in smc_rx_pipe_buf_release+0x78/0x2a0
  Read of size 8 at addr ffff888004a45740 by task smc_splice_tee_/74
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xce/0x650
   kasan_report+0xc6/0x100
   smc_rx_pipe_buf_release+0x78/0x2a0
   free_pipe_info+0xd4/0x130
   pipe_release+0x142/0x160
   __fput+0x1c6/0x490
   __x64_sys_close+0x4f/0x90
   do_syscall_64+0xa6/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  BUG: kernel NULL pointer dereference, address: 0000000000000020
  RIP: 0010:smc_rx_update_consumer+0x8d/0x350
  Call Trace:
   <TASK>
   smc_rx_pipe_buf_release+0x121/0x2a0
   free_pipe_info+0xd4/0x130
   pipe_release+0x142/0x160
   __fput+0x1c6/0x490
   __x64_sys_close+0x4f/0x90
   do_syscall_64+0xa6/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  Kernel panic - not syncing: Fatal exception

Beyond the memory-safety problem, duplicating an SMC splice buffer is
semantically questionable: smc_rx_update_cons() would advance the
consumer cursor twice for the same data, corrupting receive-window
accounting.  A refcount on smc_spd_priv could fix the double-free, but
the cursor-accounting issue would still need to be addressed separately.

The .get callback is invoked by both tee(2) and splice_pipe_to_pipe()
for partial transfers; both will now return -EFAULT.  Users who need
to duplicate SMC socket data must use a copy-based read path.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/smc/smc_rx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index d833e36f7fd4..c1d9b923938d 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -135,9 +135,16 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 	sock_put(sk);
 }
 
+static bool smc_rx_pipe_buf_get(struct pipe_inode_info *pipe,
+				struct pipe_buffer *buf)
+{
+	/* smc_spd_priv in buf->private is not shareable; disallow cloning. */
+	return false;
+}
+
 static const struct pipe_buf_operations smc_pipe_ops = {
 	.release = smc_rx_pipe_buf_release,
-	.get = generic_pipe_buf_get
+	.get	 = smc_rx_pipe_buf_get,
 };
 
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
-- 
2.43.0


