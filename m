Return-Path: <linux-rdma+bounces-20692-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WfQ7Che4BWrmaAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20692-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:55:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A772541439
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8A5530234C4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670673C2777;
	Thu, 14 May 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hkbLhbd+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8114399892;
	Thu, 14 May 2026 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759695; cv=none; b=OfZBdyW02LBzAtxAg8phfQurjin+vZLL8LSS5gGly+ORsZAVU5yTuR08+teuhGmDnW9J0iuMzHd30zMak8AE+ymXvW+Xlg4B0g55l7hdgHONoLd0Lp4bBXMw15IE7xCLYZWZ4G38UA5PFGnnVaBG4OduiQtqLyrhp7UagCkuvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759695; c=relaxed/simple;
	bh=4q9E4pQBfyWFv88a625uyZSES+gaxv7kVeA1wXDLysk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsJteh9HUPfcDVVlkuhn3BR17B/v+BbmP9PHn7BnnNFaBsNswUe/eMqy1NBXCJNf1NvO2wmOlqr+mPjiV7V6v3+Qn4RQSISyFD6lJr0NY9+0hUbjZL9UcYJMHOSqvlDRVqFUt5z0n4QsHQ127sjQpUxDWSy4HbPWQDAQ3PpI860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hkbLhbd+; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778759688; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Crp/zP/ZkY+CGJIIKJutvq9VADdvT1pHqDJLUQYH9Sk=;
	b=hkbLhbd+dzDxiIhC0mt3t+azR5BqVcBMcO74AzJMyqpuTzHlk80/qTJvK87oxthXFwhhA9aISPNd6Ej9n4i/uU8vmiKkE7kRLpj5NwlHgR0lyTacK6JrDvfObCK+vDA/XwT21SPm9w4k8i6aE4O5FicxLrtdRlFYHh3DDk1vxPs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X2wmcLj_1778759687;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X2wmcLj_1778759687 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 19:54:47 +0800
Date: Thu, 14 May 2026 19:54:46 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
	ubraun@linux.ibm.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
Message-ID: <agW4Bpp5NAka9ebS@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260511062138.2839584-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511062138.2839584-1-xmei5@asu.edu>
X-Rspamd-Queue-Id: 0A772541439
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20692-lists,linux-rdma=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com];
	R_DKIM_ALLOW(0.00)[linux.alibaba.com:s=default];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.072];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Action: no action

On 2026-05-10 23:21:38, Xiang Mei wrote:
>On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
>reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
>populates V2 entries starting at index 1, so when no V1 device is
>selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
>NULL and ism_chid[0] == 0.
>
>smc_v2_determine_accepted_chid() then matches the peer's CHID against
>the array starting from index 0 using the CHID alone. A malicious
>peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
>the empty slot, ini->ism_selected becomes 0, and the subsequent
>ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
>offsetof(struct smcd_dev, lgr_lock) == 0x68:
>
>  BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
>  Write of size 4 at addr 0000000000000068 by task exploit/144
>  Call Trace:
>   _raw_spin_lock_bh
>   smc_conn_create (net/smc/smc_core.c:1997)
>   __smc_connect (net/smc/af_smc.c:1447)
>   smc_connect (net/smc/af_smc.c:1720)
>   __sys_connect
>   __x64_sys_connect
>   do_syscall_64
>
>Require ism_dev[i] to be non-NULL before accepting a CHID match.
>
>Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
>Reported-by: Weiming Shi <bestswngs@gmail.com>
>Assisted-by: Claude:claude-opus-4-7
>Signed-off-by: Xiang Mei <xmei5@asu.edu>
>---
> net/smc/af_smc.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 185dbed7de5d..12ea3b6dbc64 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
> 	int i;
> 
> 	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
>-		if (ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
>+		if (ini->ism_dev[i] &&
>+		    ini->ism_chid[i] == ntohs(aclc->d1.chid)) {

I agree this can solve the bug you rised, but I also agree with
shashiko's comments here, we should have a better solution solving
this null-ptr-deref and use-after-free.

  Does this check leave us vulnerable to a use-after-free if the device
  is removed during the CLC handshake?
  smc_find_ism_v2_device_clnt() populates ini->ism_dev[i] with pointers to
  struct smcd_dev while holding the smcd_dev_list.mutex. However, it doesn't
  appear that struct smcd_dev has a reference counting mechanism.
  The client then drops the mutex and calls __smc_connect() ->
  smc_connect_clc(), which sleeps waiting for an ACCEPT message from the
  network peer.
  During this unbounded blocking wait, can the underlying ISM device be
  unregistered (e.g., via hardware unplug)?
  If smcd_unregister_dev() runs, it removes the device from the list and
  frees the memory using kfree(). It seems smc_smcd_terminate_all() only
  waits for fully established Link Groups, not for in-progress connection
  attempts.
  When the server accept message eventually arrives, ini->ism_dev[i] will
  still hold the dangling non-NULL pointer. This check evaluates to true,
  and the code will assign ini->ism_selected = i.
  Could this lead to smc_conn_create() actively dereferencing freed memory
  via &ini->ism_dev[ini->ism_selected]->lgr_lock?

Best regards,
Dust


> 			ini->ism_selected = i;
> 			return 0;
> 		}
>-- 
>2.43.0

