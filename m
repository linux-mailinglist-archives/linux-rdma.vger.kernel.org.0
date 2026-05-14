Return-Path: <linux-rdma+bounces-20693-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NcnDZ24BWpZaAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20693-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:57:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C178E541477
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6056301744F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8F3C378F;
	Thu, 14 May 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VarKm4WV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48838B7D4;
	Thu, 14 May 2026 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759831; cv=none; b=kb/t+1FwyP/7q/hZnW0vjdtpRjDefyaw4GYOv9+7FaFzP3F3VlVQHUTKd2Oy+w1nu4agog7Ivd7a4sa+reHJAvd+e4Rd1wgpilhG7WDNb0m9y54QhXBHh2r8i034hjoDLRDsCnJKmFZibqqTVDkLAw9pso8XjrqBOtDciZ8suTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759831; c=relaxed/simple;
	bh=MEnui99AOC05ZMNns0Dg5NkxafvMhTMW7fEeeHHtj+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIsvfFBQ7Lx9h8xZB1UJwhBIUijlobgT7LMXvGHsz09NjrVs7xotEMepbTivfJK00Tjf2SY4NRYnfNAjgruIDl0ao467GiB3/V8d2cBzjv41xvQQLtdBIxHpBB0/u7B6m4cHW2upCB+Kca5c63R0w8p12TZmf/6v1tqKtUv8ZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VarKm4WV; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778759826; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=oX5ZBN+zeOjBNWXh/1Siqm5vdi/Yhm3ou9XNJ8IS0Qs=;
	b=VarKm4WVtCnKjp07ANXWtjvaBPJHTQiQEaztr05cpShEGYfeAS00wKDaky4w4ZMRrenFf/gJnu/+U6HKG6EcXycp5D0p5zipLgsktrUwVSlg0jCOuEsmU8PkOnWmT3MvERkEa4AOjFV18+mkjqkCz/V5wppXVmQDWpZsjFX6gwY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X2wk-cb_1778759825;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X2wk-cb_1778759825 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 19:57:05 +0800
Date: Thu, 14 May 2026 19:57:05 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>, Xiang Mei <xmei5@asu.edu>,
	netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
	ubraun@linux.ibm.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
Message-ID: <agW4kfDB5JjpPD-r@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260511062138.2839584-1-xmei5@asu.edu>
 <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
X-Rspamd-Queue-Id: C178E541477
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-20693-lists,linux-rdma=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.alibaba.com:s=default];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.431];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Action: no action

On 2026-05-14 12:19:46, Paolo Abeni wrote:
>On 5/11/26 8:21 AM, Xiang Mei wrote:
>> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
>> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
>> populates V2 entries starting at index 1, so when no V1 device is
>> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
>> NULL and ism_chid[0] == 0.
>> 
>> smc_v2_determine_accepted_chid() then matches the peer's CHID against
>> the array starting from index 0 using the CHID alone. A malicious
>> peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
>> the empty slot, ini->ism_selected becomes 0, and the subsequent
>> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
>> offsetof(struct smcd_dev, lgr_lock) == 0x68:
>> 
>>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
>>   Write of size 4 at addr 0000000000000068 by task exploit/144
>>   Call Trace:
>>    _raw_spin_lock_bh
>>    smc_conn_create (net/smc/smc_core.c:1997)
>>    __smc_connect (net/smc/af_smc.c:1447)
>>    smc_connect (net/smc/af_smc.c:1720)
>>    __sys_connect
>>    __x64_sys_connect
>>    do_syscall_64
>> 
>> Require ism_dev[i] to be non-NULL before accepting a CHID match.
>> 
>> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
>> ---
>>  net/smc/af_smc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 185dbed7de5d..12ea3b6dbc64 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
>>  	int i;
>>  
>>  	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
>> -		if (ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
>> +		if (ini->ism_dev[i] &&
>> +		    ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
>>  			ini->ism_selected = i;
>>  			return 0;
>>  		}
>
>Patch LGTM, thanks!
>
>@smc maintainers, please note that sashiko reviews:
>
>https://sashiko.dev/#/patchset/20260511062138.2839584-1-xmei5%40asu.edu
>
>pointed to another pre-existing issue in this area you may want to address.
>
>/P

I agree. Apologies, I overlooked your comments prior to replying to
Xiang Mei's patch.

Best regards,
Dust

