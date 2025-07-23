Return-Path: <linux-rdma+bounces-12422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC5B0F01D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 12:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A553A17BFF8
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C928C2C3;
	Wed, 23 Jul 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NKBM1xd5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fsknoIhp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z0m8UJ27";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xCNm0FJi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B5286887
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267305; cv=none; b=q7yWGa2EdNlTmDPwiyyac8lTuRqXGpibzJzy3z75reWCJqVQT+aoBEvDbAqCgcoAAuIxyCCHh7hbB0ciugqRVbq0thhkJ0wcxPQ5mqumS/eLCLZwDCSwRfnVZUpDEFHAoNlIWDCcNZeicqlQkPLWh8oyL/6zI0IMzodhufBLi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267305; c=relaxed/simple;
	bh=gPY+utJPoK4qXzF64aQZa7JY6601chZq5rW3jJ0PDZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0jGxRz1002t3KDxgAjmxobw8ce9MPkdN1KLCA/5pRRj81TFP1lzf2GbAIgfxT4MYaYoaksGm98gxn4kuwj9idPYOYZdUlJ9MozJsyJUmEWLeIu9RC9dHAe0GJyruNXLu2ibCBEh8aiCAxbyeeLIOXqkZeYu3+07WkErTHqs9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NKBM1xd5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fsknoIhp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z0m8UJ27; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xCNm0FJi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E77722175B;
	Wed, 23 Jul 2025 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753267302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cYDispgFJbcU9UzWuoS/ot0t3xMqhlGClFolkxdcuek=;
	b=NKBM1xd5hhTzbTqPiSyk5QXJkcG61Dqusg27TViwKYbLIS08gyHj03IMZxCROsZxjvN8O0
	RBGFlc6StQ2nYf/Hy6ui4z0p+mvq9h5MCdnGDv5xM/BZysG2XzNTMt1Uuq726a9FoEip3s
	h+oodcYtGRud5Czr+Bn0HiA8qC4IPzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753267302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cYDispgFJbcU9UzWuoS/ot0t3xMqhlGClFolkxdcuek=;
	b=fsknoIhppO56VFd6H3bw8yT50VVyKKpMwyAyvFBVWZ+zHvR/WN/Rv1Sh28eKhe9f3/TjLv
	e10LCKM9A7eteIDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753267301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cYDispgFJbcU9UzWuoS/ot0t3xMqhlGClFolkxdcuek=;
	b=Z0m8UJ27XSzMXQKk79q7WGSW7TcWfKiQ2J66nsA2YY2izT3H8iU0XPZoZJCriuKne3UBZM
	PfuVs5yrRsN1lmZvNBVnXHw9yx1f6Tuy1c01cZW04qjGkZUxhx1hiTieGzP2pvrtx+MoZY
	1vV67SnMZ9PnADaJa+UWiWox48lIin4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753267301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cYDispgFJbcU9UzWuoS/ot0t3xMqhlGClFolkxdcuek=;
	b=xCNm0FJiM3wqrOGGEIYAVmUhudcOoLDjUxopgEP5QhS5XGvt2DxI8LNg3IcgemTldGzFxN
	/LQ0ilrJzWzg6ABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A34513302;
	Wed, 23 Jul 2025 10:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tkwmA2W8gGhdbAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 23 Jul 2025 10:41:41 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Jakub Kicinski <kuba@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages
Date: Wed, 23 Jul 2025 11:41:23 +0100
Message-ID: <20250723104123.190518-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Ever since commit c2ff29e99a76 ("siw: Inline do_tcp_sendpages()"),
we have been doing this:

static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
                             size_t size)
[...]
        /* Calculate the number of bytes we need to push, for this page
         * specifically */
        size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
        /* If we can't splice it, then copy it in, as normal */
        if (!sendpage_ok(page[i]))
                msg.msg_flags &= ~MSG_SPLICE_PAGES;
        /* Set the bvec pointing to the page, with len $bytes */
        bvec_set_page(&bvec, page[i], bytes, offset);
        /* Set the iter to $size, aka the size of the whole sendpages (!!!) */
        iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
try_page_again:
        lock_sock(sk);
        /* Sendmsg with $size size (!!!) */
        rv = tcp_sendmsg_locked(sk, &msg, size);

This means we've been sending oversized iov_iters and tcp_sendmsg calls
for a while. This has a been a benign bug because sendpage_ok() always
returned true. With the recent slab allocator changes being slowly
introduced into next (that disallow sendpage on large kmalloc
allocations), we have recently hit out-of-bounds crashes, due to slight
differences in iov_iter behavior between the MSG_SPLICE_PAGES and
"regular" copy paths:

(MSG_SPLICE_PAGES)
skb_splice_from_iter
  iov_iter_extract_pages
    iov_iter_extract_bvec_pages
      uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
  skb_splice_from_iter gets a "short" read

(!MSG_SPLICE_PAGES)
skb_copy_to_page_nocache copy=iov_iter_count
 [...]
   copy_from_iter
        /* this doesn't help */
        if (unlikely(iter->count < len))
                len = iter->count;
          iterate_bvec
            ... and we run off the bvecs

Fix this by properly setting the iov_iter's byte count, plus sending the
correct byte count to tcp_sendmsg_locked.

Cc: stable@vger.kernel.org
Fixes: c2ff29e99a76 ("siw: Inline do_tcp_sendpages()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507220801.50a7210-lkp@intel.com
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 3a08f57d2211..9576a2b766c4 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -340,11 +340,11 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 		if (!sendpage_ok(page[i]))
 			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 		bvec_set_page(&bvec, page[i], bytes, offset);
-		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
 
 try_page_again:
 		lock_sock(sk);
-		rv = tcp_sendmsg_locked(sk, &msg, size);
+		rv = tcp_sendmsg_locked(sk, &msg, bytes);
 		release_sock(sk);
 
 		if (rv > 0) {
-- 
2.50.1


