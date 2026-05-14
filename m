Return-Path: <linux-rdma+bounces-20678-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDZAMgiiBWo1ZAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20678-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:20:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D69540527
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9780830182BF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BB395AEC;
	Thu, 14 May 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJDr6VoE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEnEIi0b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE93ACF1F
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753995; cv=none; b=JvMrZ5Jl66FMsip85UqBhlDBrJyQpGu2Ip0K3BaFxqa49R+kp2LO8lOPLMWcx5/+Tr9bIOSyR9nc3NcR3QezHDYbnhMXZsmN7qmHWMc6gn8mxM9Tg0ecD1z2eIKKvvEomOV919ppUS8t1AzcvRuy2F/c0Hl7JzZ6rzNmwZ6GtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753995; c=relaxed/simple;
	bh=0IKmOUzoumogJGoyd4uqy+VcQGNDmcN+WpyYRRIEP7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJOL6iW8DvGk/oX0Rl9vPORWVEaTlszMh5pCLhdW8kUbXbNpo+AjZhWOZXOrBrNLHAgTRQ8vScBS/P0pUakXmSdPmQOi+kkcxio2QlasF30/mPnxfUHoF/fneLYaNmOMTwHTpFqW6GHqKPK+Y+PNA2XEczUf/0M2lNTiZoQMYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJDr6VoE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEnEIi0b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778753993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
	b=UJDr6VoEIqYcvbfBwlSWQtJ/+UsyApMbeOcS0SZe3z87pYkV2/fOut5gEi3shfU9151y13
	03dk/hO0Z1uQvseKw0hvK5aDbgu490LcFT8BcsXDn5Qwbos+jKQmLBSOW+7vC4zqwHXD2y
	AuJ3dSXHSP8O8kaEpCnlN0W9mGA3Ky0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-tcxUvhVbNjaE3BPO1Ql1Zw-1; Thu, 14 May 2026 06:19:50 -0400
X-MC-Unique: tcxUvhVbNjaE3BPO1Ql1Zw-1
X-Mimecast-MFC-AGG-ID: tcxUvhVbNjaE3BPO1Ql1Zw_1778753989
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43fe791a398so7153820f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778753989; x=1779358789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
        b=QEnEIi0bXeEekfIT4LaQXPEyyWxKR/fM3yitOQvv6rbkM31EKL/vl0CMih+c11ZMQn
         MuYjbdJp8zklxo/ITCoZugDu9suHUE0LPVaGFdDonMJm3Y7CDowfmas1n8/y44WdGDGy
         jdTf8DVZOJ94hBHayPqbCA+YJc+wh8M2M8WlSlwkIQBAXPemBQXX62bAGaSQFV8SuCxe
         5TZgXcc6mNnEGFun0kpxbQ7vNmTS1iVDTN+yibj+BHPczdCUg9B+otRt/elpKp8Z9LL8
         /E1jX9BMZfJi/MCUCe4jALCppaoS0vAVi2LsV+Acu21ryxw4Rp6PbMHNcqPDtdFpiQmV
         2mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778753989; x=1779358789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZTuW1IFKHF0KTPisCHVpLQ20OQQ1KfAlq590oafrkc=;
        b=eKzWx0pW/2C5HobErzVI5T0O2GVfFdtpFkXz4OJB1WJ2IBAIfjRNtnXPM6raimv5Og
         eOCFZ1h/+FO2R5EmRA5r3H3vSev8/nlKLMkkROTJOOfMe66FW5ZCuziNnEBJ4t/makjW
         6p+opFy8qwGKpWGd8UtFK2Lk7bG3CalY6PLHm0cWEN3Lu9nSlCowMmDLZAqntjtOyevk
         tDPfWJrA5PYwVUxu6AKmxn4t0zshjfe2yto06T2mQLeNk8uovb5xi6nF+KDyvLw4emLg
         UqX+eZtcK9eJl+5pRcYPa2NkQpFPimQD4jOJzjs4sU7kuVeEeP+sWKKLZRsLGlfFq4jF
         KCEA==
X-Forwarded-Encrypted: i=1; AFNElJ9p0Aj6JBz7SRJ6u3uM3AWWpp515SCmp+xczM4HEvqdDlnaU5WH0nSdt7JLvxkpVIBRUGJ4qZL1Az57@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2O7eZeZR3D6QpVaFON232W/PrzToXmlKbYk/2sm6oMZtHlVqr
	bA+t9aHuld9o48pN7jkUa9b9CXguZW8QtMqN49b5N92mnLU4OkB9E1YndOwP3hAR/dBPJ1roJR+
	SYNwLdoLrJs/CBBNnaZx7osRWO9LzQKam/et4skaTvuLRNmoAAyUVRSFkljxt64OpjCqcmFk=
X-Gm-Gg: Acq92OEnGEECiDZIazNDvsNzNA924BieBXSX8gBqkN68s+kXX+L8koI8Kzdld1ij9ug
	KDkMjCgJ606vF7D/D4L0qcrCUP5RsZiIDZHLT/S2I2qaEpVJ3G+SqH5llmnW2yNNmBXJSYfELKs
	x2bC1jIWgXXiVC9jYMlhDe7xwTKHirGqwRvakpMAP2zM4R1oIFXzgcYLcutgXKIiN++u/N+knLK
	6OeCqSzJ9z7l4NKUXiM3iD1Zitj0nerr8pWYV5N6nkDpRS5VtScZI3a+XwEK5BjSaZgv0+5cqyY
	eYM7LmD7zlCHsV+NzgobfR1WoTcTXYtkBN1igP59v7lHdDJOKfIFtkKfvD73yIHo7IAvXbMM0FZ
	bpRuyvrPSSiNvRkjPiErd+7efr9uPtYWH1jBhGkdLF7wKS/0g03ZOAdk=
X-Received: by 2002:a05:600c:1f85:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe1accbf4mr11294135e9.10.1778753988918;
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1f85:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe1accbf4mr11293815e9.10.1778753988485;
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6276741sm26923115e9.0.2026.05.14.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:19:48 -0700 (PDT)
Message-ID: <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
Date: Thu, 14 May 2026 12:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, ubraun@linux.ibm.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, bestswngs@gmail.com
References: <20260511062138.2839584-1-xmei5@asu.edu>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260511062138.2839584-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 26D69540527
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	TAGGED_FROM(0.00)[bounces-20678-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.482];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 8:21 AM, Xiang Mei wrote:
> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
> populates V2 entries starting at index 1, so when no V1 device is
> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
> NULL and ism_chid[0] == 0.
> 
> smc_v2_determine_accepted_chid() then matches the peer's CHID against
> the array starting from index 0 using the CHID alone. A malicious
> peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
> the empty slot, ini->ism_selected becomes 0, and the subsequent
> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
> offsetof(struct smcd_dev, lgr_lock) == 0x68:
> 
>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
>   Write of size 4 at addr 0000000000000068 by task exploit/144
>   Call Trace:
>    _raw_spin_lock_bh
>    smc_conn_create (net/smc/smc_core.c:1997)
>    __smc_connect (net/smc/af_smc.c:1447)
>    smc_connect (net/smc/af_smc.c:1720)
>    __sys_connect
>    __x64_sys_connect
>    do_syscall_64
> 
> Require ism_dev[i] to be non-NULL before accepting a CHID match.
> 
> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/af_smc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 185dbed7de5d..12ea3b6dbc64 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
>  	int i;
>  
>  	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
> -		if (ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
> +		if (ini->ism_dev[i] &&
> +		    ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
>  			ini->ism_selected = i;
>  			return 0;
>  		}

Patch LGTM, thanks!

@smc maintainers, please note that sashiko reviews:

https://sashiko.dev/#/patchset/20260511062138.2839584-1-xmei5%40asu.edu

pointed to another pre-existing issue in this area you may want to address.

/P


