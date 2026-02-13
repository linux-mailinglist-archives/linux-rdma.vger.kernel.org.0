Return-Path: <linux-rdma+bounces-16808-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB1DGkr1jmnDGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16808-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 10:56:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2920A134BF1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 10:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A88623040002
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894434F499;
	Fri, 13 Feb 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BUrXuVrU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ds5zlB7b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BUrXuVrU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ds5zlB7b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2B34D4FB
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976576; cv=none; b=m4svoobKxJ2mi345H2CgTBP3VyQuy42d6TuIv4LzEQgrUSWQBAkp/AfdbJLm5zt8miFODYewF8vvsZF1dtWTMyjT1ndYlT4Wruw8SN0iwGz6dDaHxMOLOrIcMhY2hb8N1GKDfLOJupF0eZ05sA9S8CCfCJa/3eou8GCR3pMRHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976576; c=relaxed/simple;
	bh=WY/dD/Y0HWJt2n1zEa25Prpk8xJdrB4VCNNbwKnasdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVxGz8eBDi4qnH31T9VgfmEzdnTH32Kf5ytNudCmLkf08AAQQ1mNQ7hDZEaASMGePOxyYmdKVELSDbWdEckE2VCbyRbCTeIQgfG3KAopk7FIXs+JDpumnvypng5IkbN5SI2MZqX40kLTKzEaqGWr4BtwraT4kPLX1AIQe03ah+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BUrXuVrU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ds5zlB7b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BUrXuVrU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ds5zlB7b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ADC45BCC4;
	Fri, 13 Feb 2026 09:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770976572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBJp+W6+w4hpK1AOjuJLBK8cne5W/Y5VssQKf43ZEcM=;
	b=BUrXuVrU4Uj6JeWVtHNxu88KEqTAApBzpLUGAKfVFe2/TCfmIgy6NE5QzmaDN7DKMBOsGG
	ZckVaiWgkkpXmcY97TGZ4774iAyr3Var34MEz9aYElUmwWpVZkMwG/fGjrNKdd43FcMP0X
	bKV/xb9tVwCcknG0GeL6ZpYq+lL8Y5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770976572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBJp+W6+w4hpK1AOjuJLBK8cne5W/Y5VssQKf43ZEcM=;
	b=Ds5zlB7bv4vIWUQYT40lau/zwk7JiXqptX+FGL1vAdKrX94QpSG11m2XlfY0lzWbZ059rP
	xa9emAAylTWn18Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BUrXuVrU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ds5zlB7b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770976572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBJp+W6+w4hpK1AOjuJLBK8cne5W/Y5VssQKf43ZEcM=;
	b=BUrXuVrU4Uj6JeWVtHNxu88KEqTAApBzpLUGAKfVFe2/TCfmIgy6NE5QzmaDN7DKMBOsGG
	ZckVaiWgkkpXmcY97TGZ4774iAyr3Var34MEz9aYElUmwWpVZkMwG/fGjrNKdd43FcMP0X
	bKV/xb9tVwCcknG0GeL6ZpYq+lL8Y5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770976572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBJp+W6+w4hpK1AOjuJLBK8cne5W/Y5VssQKf43ZEcM=;
	b=Ds5zlB7bv4vIWUQYT40lau/zwk7JiXqptX+FGL1vAdKrX94QpSG11m2XlfY0lzWbZ059rP
	xa9emAAylTWn18Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 813873EA62;
	Fri, 13 Feb 2026 09:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5S3eHjz1jmngDgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 13 Feb 2026 09:56:12 +0000
Date: Fri, 13 Feb 2026 10:56:11 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.19 kernel
Message-ID: <6ad314f7-f3d2-495a-b1ef-a81a06498952@flourine.local>
References: <aY7ZBfMjVIhe_wh3@shinmob>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY7ZBfMjVIhe_wh3@shinmob>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16808-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwagner@suse.de,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 2920A134BF1
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 07:57:58AM +0000, Shinichiro Kawasaki wrote:
> [3] lockdep WARN during nvme/058 with fc transport
> 
> [  409.028219] [     T95] ============================================
> [  409.029133] [     T95] WARNING: possible recursive locking detected
> [  409.030058] [     T95] 6.19.0+ #575 Not tainted
> [  409.030892] [     T95] --------------------------------------------
> [  409.031801] [     T95] kworker/u16:9/95 is trying to acquire lock:
> [  409.032691] [     T95] ffff88813ba54948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7e/0x1a0
> [  409.033869] [     T95] 
>                           but task is already holding lock:
> [  409.035254] [     T95] ffff88813ba54948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0xeef/0x1480
> [  409.036383] [     T95] 
>                           other info that might help us debug this:
> [  409.037769] [     T95]  Possible unsafe locking scenario:
> 
> [  409.039113] [     T95]        CPU0
> [  409.039781] [     T95]        ----
> [  409.040406] [     T95]   lock((wq_completion)nvmet-wq);
> [  409.041154] [     T95]   lock((wq_completion)nvmet-wq);
> [  409.041898] [     T95] 
>                            *** DEADLOCK ***
> 
> [  409.043609] [     T95]  May be due to missing lock nesting notation
> 
> [  409.044960] [     T95] 3 locks held by kworker/u16:9/95:
> [  409.045721] [     T95]  #0: ffff88813ba54948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0xeef/0x1480
> [  409.046845] [     T95]  #1: ffff888109797ca8 ((work_completion)(&assoc->del_work)){+.+.}-{0:0}, at: process_one_work+0x7e4/0x1480
> [  409.048063] [     T95]  #2: ffffffffac481480 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xe3/0xc70
> [  409.049128] [     T95] 
>                           stack backtrace:
> [  409.050366] [     T95] CPU: 1 UID: 0 PID: 95 Comm: kworker/u16:9 Not tainted 6.19.0+ #575 PREEMPT(voluntary) 
> [  409.050370] [     T95] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
> [  409.050373] [     T95] Workqueue: nvmet-wq nvmet_fc_delete_assoc_work [nvmet_fc]
> [  409.050384] [     T95] Call Trace:
> [  409.050386] [     T95]  <TASK>
> [  409.050388] [     T95]  dump_stack_lvl+0x6a/0x90
> [  409.050393] [     T95]  print_deadlock_bug.cold+0xc0/0xcd
> [  409.050401] [     T95]  __lock_acquire+0x1312/0x2230
> [  409.050408] [     T95]  ? lockdep_unlock+0x5e/0xc0
> [  409.050410] [     T95]  ? __lock_acquire+0xd03/0x2230
> [  409.050413] [     T95]  lock_acquire+0x170/0x300
> [  409.050415] [     T95]  ? touch_wq_lockdep_map+0x7e/0x1a0
> [  409.050418] [     T95]  ? __flush_work+0x4e8/0xc70
> [  409.050420] [     T95]  ? find_held_lock+0x2b/0x80
> [  409.050423] [     T95]  ? touch_wq_lockdep_map+0x7e/0x1a0
> [  409.050425] [     T95]  touch_wq_lockdep_map+0x97/0x1a0
> [  409.050428] [     T95]  ? touch_wq_lockdep_map+0x7e/0x1a0
> [  409.050430] [     T95]  ? __flush_work+0x4e8/0xc70
> [  409.050432] [     T95]  __flush_work+0x5c1/0xc70
> [  409.050434] [     T95]  ? __pfx___flush_work+0x10/0x10
> [  409.050436] [     T95]  ? __pfx___flush_work+0x10/0x10
> [  409.050439] [     T95]  ? __pfx_wq_barrier_func+0x10/0x10
> [  409.050444] [     T95]  ? __pfx___might_resched+0x10/0x10
> [  409.050454] [     T95]  nvmet_ctrl_free+0x2e9/0x810 [nvmet]
> [  409.050474] [     T95]  ? __pfx___cancel_work+0x10/0x10
> [  409.050479] [     T95]  ? __pfx_nvmet_ctrl_free+0x10/0x10 [nvmet]
> [  409.050498] [     T95]  nvmet_cq_put+0x136/0x180 [nvmet]
> [  409.050515] [     T95]  nvmet_fc_target_assoc_free+0x398/0x2040 [nvmet_fc]
> [  409.050522] [     T95]  ? __pfx_nvmet_fc_target_assoc_free+0x10/0x10 [nvmet_fc]
> [  409.050528] [     T95]  nvmet_fc_delete_assoc_work.cold+0x82/0xff [nvmet_fc]
> [  409.050533] [     T95]  process_one_work+0x868/0x1480
> [  409.050538] [     T95]  ? __pfx_process_one_work+0x10/0x10
> [  409.050541] [     T95]  ? lock_acquire+0x170/0x300
> [  409.050545] [     T95]  ? assign_work+0x156/0x390
> [  409.050548] [     T95]  worker_thread+0x5ee/0xfd0
> [  409.050553] [     T95]  ? __pfx_worker_thread+0x10/0x10
> [  409.050555] [     T95]  kthread+0x3af/0x770
> [  409.050560] [     T95]  ? lock_acquire+0x180/0x300
> [  409.050563] [     T95]  ? __pfx_kthread+0x10/0x10
> [  409.050565] [     T95]  ? __pfx_kthread+0x10/0x10
> [  409.050568] [     T95]  ? ret_from_fork+0x6e/0x810
> [  409.050576] [     T95]  ? lock_release+0x1ab/0x2f0
> [  409.050578] [     T95]  ? rcu_is_watching+0x11/0xb0
> [  409.050582] [     T95]  ? __pfx_kthread+0x10/0x10
> [  409.050585] [     T95]  ret_from_fork+0x55c/0x810
> [  409.050588] [     T95]  ? __pfx_ret_from_fork+0x10/0x10
> [  409.050590] [     T95]  ? __switch_to+0x10a/0xda0
> [  409.050598] [     T95]  ? __switch_to_asm+0x33/0x70
> [  409.050602] [     T95]  ? __pfx_kthread+0x10/0x10
> [  409.050605] [     T95]  ret_from_fork_asm+0x1a/0x30
> [  409.050610] [     T95]  </TASK>

nvmet_fc_target_assoc_free runs in the nvmet_wq context and calls

  nvmet_fc_delete_target_queue
    nvmet_cq_put
      nvmet_cq_destroy
        nvmet_ctrl_put
         nvmet_ctrl_free
           flush_work(&ctrl->async_event_work);
           cancel_work_sync(&ctrl->fatal_err_work);
 
The async_event_work could be running on nvmet_wq. So this deadlock is
real. No idea how to fix it yet.

> [4] WARN during nvme/058 fc transport
> 
> [ 1410.913156] [   T1369] WARNING: block/genhd.c:463 at __add_disk+0x87b/0xd50, CPU#0: kworker/u16:12/1369

	/*
	 * If the driver provides an explicit major number it also must provide
	 * the number of minors numbers supported, and those will be used to
	 * setup the gendisk.
	 * Otherwise just allocate the device numbers for both the whole device
	 * and all partitions from the extended dev_t space.
	 */
	ret = -EINVAL;
	if (disk->major) {
		if (WARN_ON(!disk->minors))
			goto out;

If I read the correct, the gendisk is allocated in nvme_mpath_alloc_disk
and then added due the ANA change in nvme_update_ana_state. Not sure if
this is really fc related but I haven't really figured out how this part
of the code yet.

