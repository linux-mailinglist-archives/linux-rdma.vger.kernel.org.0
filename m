Return-Path: <linux-rdma+bounces-12975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01BAB39BA2
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 13:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562EB3B1F06
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8BC30E85E;
	Thu, 28 Aug 2025 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y00ACjZx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6++6OaBQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y00ACjZx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6++6OaBQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E030CD9D
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380789; cv=none; b=KkUCQEo7E7vnySlCuwoSSyItddf+/RrcGZXRlY5OP9WQ6oIY2/tg9Ms8vbuR73xMpF5Z0bWk2EpjLWfrZtXVCmZKXkjvRwq/xDDvCywmSR9F5dzBqkFahCRftzcBxnkSs3hnFySUkmQm5YKYNA28tBFmdG/bdihzmEz6fyg91xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380789; c=relaxed/simple;
	bh=+TQQc6mh+HwTWTWoKqBarEkj1nKwweW26x4pr0Mnjq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVGkk4ucAmU00vGNigjQePQZaRphbZEKQS6753ksW1yOPi/KHgx6TLktEgQ6njO4kfDA0ESAn4TQOibMFhsK+WMTNFcWxt8+CA9gCSZyurfjOJDvwL9sgHZCwVSn3OYYXzNEPxezv59CJSQjMqXE19Q3kEZyeyalmzs9LHk7SuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y00ACjZx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6++6OaBQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y00ACjZx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6++6OaBQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8ACEE21E00;
	Thu, 28 Aug 2025 11:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756380785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDBbpYYqSB5yXQjk2/9a0sEktjKGihTIib3At2S16rY=;
	b=Y00ACjZx0/M0I+BO8pj890eiofCwNE31j3jd9WLCaXzfinz0IGMFs+SX9gkgxUm1SSYKr0
	l0LGRH4Bbz13Z2c3zB1V6t8xJz+GM1Mfs/hw6kkh0fh0Xu997GYVO2euajn8Guv1Pg3zLx
	rSxy+V517gTlibqyAdfCT4YUwMZR6dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756380785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDBbpYYqSB5yXQjk2/9a0sEktjKGihTIib3At2S16rY=;
	b=6++6OaBQXt4evqnG5Z9K9jLAcBl/ylDZMmc3F+OxuVCDBZrmizaGEEH7T0NeptMjgHQCcI
	OSkmlzdrmy68hOBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756380785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDBbpYYqSB5yXQjk2/9a0sEktjKGihTIib3At2S16rY=;
	b=Y00ACjZx0/M0I+BO8pj890eiofCwNE31j3jd9WLCaXzfinz0IGMFs+SX9gkgxUm1SSYKr0
	l0LGRH4Bbz13Z2c3zB1V6t8xJz+GM1Mfs/hw6kkh0fh0Xu997GYVO2euajn8Guv1Pg3zLx
	rSxy+V517gTlibqyAdfCT4YUwMZR6dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756380785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDBbpYYqSB5yXQjk2/9a0sEktjKGihTIib3At2S16rY=;
	b=6++6OaBQXt4evqnG5Z9K9jLAcBl/ylDZMmc3F+OxuVCDBZrmizaGEEH7T0NeptMjgHQCcI
	OSkmlzdrmy68hOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BA3613326;
	Thu, 28 Aug 2025 11:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id POZmHXE+sGgMaAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 28 Aug 2025 11:33:05 +0000
Date: Thu, 28 Aug 2025 13:33:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h2ijb4czulrzbkl4"
Content-Disposition: inline
In-Reply-To: <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30


--h2ijb4czulrzbkl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2025 at 05:55:06AM +0000, Shinichiro Kawasaki wrote:
> On Aug 27, 2025 / 12:10, Daniel Wagner wrote:
> > On Wed, Aug 13, 2025 at 10:50:34AM +0000, Shinichiro Kawasaki wrote:
> > > #4: nvme/061 (fc transport)
> > > 
> > >     The test case nvme/061 sometimes fails for fc transport due to a WARN and
> > >     refcount message "refcount_t: underflow; use-after-free." Refer to the
> > >     report for the v6.15 kernel [5].
> > > 
> > >     [5]
> > >     https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk/
> > 
> > This one might be fixed with
> > 
> > https://lore.kernel.org/linux-nvme/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org/
> 
> I applied this patch on top of v6.17-rc3 kernel, but still I observe the
> refcount WARN at nvme/061 with.

Thanks for testing and I was able to reproduce it also. The problem is
that it's possible that an association is scheduled for deletion twice.

Would you mind to give the attached patch a try? It fixes the problem I
was able to reproduce.

> Said that, I like the patch. This week, I noticed that nvme/030 hangs with fc
> transport. This hang is rare, but it is recreated in stable manner when I
> repeat the test case. I tried the fix patch, and it avoided this hang :)
> Thanks for the fix!

Ah, nice so at least this one is fixed by the first patch :)

--h2ijb4czulrzbkl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-nvmet-fc-avoid-scheduling-association-deletion-twice.patch"

From b0db044f5e828d5c12c368fecd17327f7a6e854d Mon Sep 17 00:00:00 2001
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 28 Aug 2025 13:18:21 +0200
Subject: [PATCH] nvmet-fc: avoid scheduling association deletion twice

When forcefully shutting down a port via the configfs interface,
nvmet_port_subsys_drop_link() first calls nvmet_port_del_ctrls() and
then nvmet_disable_port(). Both functions will eventually schedule all
remaining associations for deletion.

The current implementation checks whether an association is about to be
removed, but only after the work item has already been scheduled. As a
result, it is possible for the first scheduled work item to free all
resources, and then for the same work item to be scheduled again for
deletion.

Because the association list is an RCU list, it is not possible to take
a lock and remove the list entry directly, so it cannot be looked up
again. Instead, a flag (terminating) must be used to determine whether
the association is already in the process of being deleted.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6725c34dd7c9..7d84527d5a43 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1075,6 +1075,14 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
+	int terminating;
+
+	terminating = atomic_xchg(&assoc->terminating, 1);
+
+	/* if already terminating, do nothing */
+	if (terminating)
+		return;
+
 	nvmet_fc_tgtport_get(assoc->tgtport);
 	if (!queue_work(nvmet_wq, &assoc->del_work))
 		nvmet_fc_tgtport_put(assoc->tgtport);
@@ -1202,13 +1210,7 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	unsigned long flags;
-	int i, terminating;
-
-	terminating = atomic_xchg(&assoc->terminating, 1);
-
-	/* if already terminating, do nothing */
-	if (terminating)
-		return;
+	int i;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_del_rcu(&assoc->a_list);
-- 
2.51.0


--h2ijb4czulrzbkl4--

