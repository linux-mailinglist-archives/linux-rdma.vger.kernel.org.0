Return-Path: <linux-rdma+bounces-13017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6833EB3DD8B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E835189F366
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9B3054D6;
	Mon,  1 Sep 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kEqJM6ny";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5FxxqrJO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kEqJM6ny";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5FxxqrJO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431E30506B
	for <linux-rdma@vger.kernel.org>; Mon,  1 Sep 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717343; cv=none; b=gkMlYfk0UbMxh8pyxdxrBzrAy6cTTxI/VieYq5rhJWd4Kx5RwZkaN0AJ8QuJUDAG6abv7+Z+wFuYO2r8areMvPpov5u91/YB4kTyu5AxHx5heYVNpLdcA23GpxWfrZLJ8QYPZ4fQ+xt7P1oSytw+trl+3RIBrG+RreJX4vxIyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717343; c=relaxed/simple;
	bh=/I7E2fk1T0Aqgi6iRHMY63UidkJpRR/LHgnlOMO4SIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHq07QSayLTEPMVHMS2LWofxdy/1IJ6NzjPjoi/Zo07j5PN2TulesJFUleSJjHvQ2Jh7u8uwypvobqIX95yqPjVMZxX2dI+ABX+yQ4ZifE6YZsHFMuSN8i4ZjMe+JvzAYd2DGuDv6E1B9gZkcJETgXYL3caoLd6A9KXmUK4Wnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kEqJM6ny; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5FxxqrJO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kEqJM6ny; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5FxxqrJO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3047C1F388;
	Mon,  1 Sep 2025 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756717336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=kEqJM6nywEAUgYQb4LPOCS9x9CjMVjfT2pnsMCSV9DTx/jgNqP8IZLV2t+plzC1sP9wMaL
	GOhKuDM0yWqpfeHp0cfONI9h9TLcBAWteTn9V0Or7jy/w+iMKKO2kGC6yzLNhG0hF6mwka
	bdi0JTTtuJOsZkiBNVwarHRzIqGBH18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756717336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=5FxxqrJOXYxi7cIuJhJkfSbGklr2EzNlJDQByDz2Au4l+Js2PvkmKMv5kolMeUygTW4FHp
	T+tOdYG8QsLfJEDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756717336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=kEqJM6nywEAUgYQb4LPOCS9x9CjMVjfT2pnsMCSV9DTx/jgNqP8IZLV2t+plzC1sP9wMaL
	GOhKuDM0yWqpfeHp0cfONI9h9TLcBAWteTn9V0Or7jy/w+iMKKO2kGC6yzLNhG0hF6mwka
	bdi0JTTtuJOsZkiBNVwarHRzIqGBH18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756717336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=5FxxqrJOXYxi7cIuJhJkfSbGklr2EzNlJDQByDz2Au4l+Js2PvkmKMv5kolMeUygTW4FHp
	T+tOdYG8QsLfJEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 200681378C;
	Mon,  1 Sep 2025 09:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZJoTBxhhtWgnZgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Sep 2025 09:02:16 +0000
Date: Mon, 1 Sep 2025 11:02:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <7a773833-a193-4243-80f4-fc52243883a9@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
 <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
 <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
 <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Mon, Sep 01, 2025 at 10:34:23AM +0200, Daniel Wagner wrote:
> The test is removing the ports while the host driver is about to
> reconnect and accesses a stale pointer.
> 
> nvme_fc_create_association is calling nvme_fc_ctlr_inactive_on_rport in
> the error path. The problem is that nvme_fc_create_association gets half
> through the setup and then fails. In the cleanup path
> 
> 	dev_warn(ctrl->ctrl.device,
> 		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
> 		ctrl->cnum, ctrl->association_id, ret);
> 
> is issued and then nvme_fc_ctlr_inactive_on_rport is called. And there
> is the log message above, so it's clear the error path is taken.
> 
> But the thing is fcloop is not supposed to remove the ports when the
> host driver is still using it. So there is a race window where it's
> possible to enter nvme_fc_create_assocation and fcloop removing the
> ports.
> 
> So between nvme_fc_create_assocation and nvme_fc_ctlr_active_on_rport.

I think the problem is that nvme_fc_create_association is not holding
the rport locks when checking the port_state and marking the rport
active. This races with nvme_fc_unregister_remoteport.

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e12d4683ac7..03987f497a5b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3032,11 +3032,17 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)

 	++ctrl->ctrl.nr_reconnects;

-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENODEV;
+	}

-	if (nvme_fc_ctlr_active_on_rport(ctrl))
+	if (nvme_fc_ctlr_active_on_rport(ctrl)) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENOTUNIQ;
+	}
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);

 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: create association : host wwpn 0x%016llx "

I'll to reproduce it and see if this patch does make a difference.

