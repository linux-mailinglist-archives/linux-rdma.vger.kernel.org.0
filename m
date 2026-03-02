Return-Path: <linux-rdma+bounces-17395-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FHjC23ipWkvHgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17395-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:18:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D341DEC2D
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C4443038D1B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 19:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9D330656;
	Mon,  2 Mar 2026 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdeDgTyo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA02E2DF3;
	Mon,  2 Mar 2026 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479030; cv=none; b=qnT+4ndnNztCGtMIqbnkdQ2eyH/4LkeQO3gntkP/Vn0mAe90AIDl0+ou0UvMMlh56AH3CgTMkiO21OenLTzhVPkl2AS+mh//pWP3wOaMRO86B7FzfjOB/3NyVlNmn8FpN5v3bJRv4DXEmewZk3Nn/UoJf2PME+feqRTxBNPnszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479030; c=relaxed/simple;
	bh=mruQiU+bwyhGOWwpvAKISnjsAj3ASUF2/R2Vqg+n81I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDcX8lkavpPIGHhpPAfwBS83GXF6VK13RaU9Wsfw9lAq1LPxNYjsU+vUbeQZmtzeVCPjb81UitZbYMR694EDT54B3bB7JfB8mwBpaDdTmIx4FsU3ks0f9/RT11z2dfNR+iU6uAi9k244ro6B0EUhlX/CU5lW3MAP2lXBbHkUb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdeDgTyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA6CC19423;
	Mon,  2 Mar 2026 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772479030;
	bh=mruQiU+bwyhGOWwpvAKISnjsAj3ASUF2/R2Vqg+n81I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdeDgTyogZBAX95L9mUePCKuXJvVRaxu5Ro0OcsDvzXEAbp8IX5X6R+lbI+M/tFvr
	 iM9b78PyxKII1XJxzacv5ylMr7M+TSjrIpJEmtfvzNevjDs3fLgYaehr+OG+HubEwK
	 s3JCYJvvK2uIJ8NvxHOPLHYDEwqqJF/slx717HRGBNAsiNzZv2mrrklvJIsIDIZZqh
	 xldO1GiVlOLMqEZadN4oVpc6xpacA+fm8GR3ZUc8s+mwyj1pJW1Bzh82OLSwe5dXFn
	 vU7Mzaw7c9FpMYVXpUZ7ahpeI4U+KQITv/rmWSQ9T/es8n59tl9M5yPN9ZALQFns2h
	 fags9BAH7+g5Q==
Date: Mon, 2 Mar 2026 21:17:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot+53cf317e7803e4ef2f33@syzkaller.appspotmail.com,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [syzbot] [rdma?] kernel BUG in ib_device_get_by_index
Message-ID: <20260302191705.GR12611@unreal>
References: <69a27146.050a0220.3a55be.002e.GAE@google.com>
 <14d97798-6cfa-4c2a-b1ab-391e4b823b1d@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d97798-6cfa-4c2a-b1ab-391e4b823b1d@I-love.SAKURA.ne.jp>
X-Rspamd-Queue-Id: E5D341DEC2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17395-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,53cf317e7803e4ef2f33];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 02:07:46PM +0900, Tetsuo Handa wrote:
> Hmm, this assertion was wrong because ib_device_get_by_index()
> might be called before enable_device_and_get() is called.
> 
> #syz invalid

I think this is a valid syzkaller report. As you correctly noted, the device
was inserted into the xarray database in assign_name(), but its refcount was
only set later in enable_device_and_get().

The proper fix can be something like that:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c7b227e2e657..5fc2604ec482 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -321,7 +321,7 @@ struct ib_device *ib_device_get_by_index(const struct net *net, u32 index)

        down_read(&devices_rwsem);
        device = xa_load(&devices, index);
-       if (device) {
+       if (device && xa_get_mark(&devices, index, DEVICE_REGISTERED)) {
                if (!rdma_dev_access_netns(device, net)) {
                        device = NULL;
                        goto out;

Thanks

