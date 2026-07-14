Return-Path: <linux-rdma+bounces-23232-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pNjMF1GrVmre/wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23232-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 23:34:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C54BF759022
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 23:34:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SLrF5G+b;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23232-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23232-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ADEE301CC7F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2E42B75D;
	Tue, 14 Jul 2026 21:34:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151E429CFE
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 21:33:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064842; cv=none; b=UiHodZIVNHP1iPZl624vQqZFikYdt9dw3oCVT5+z9EdW/H2qYrcRlczPgbIiL++RoexoTi4D0NgOVD4RXSgaRn4BtMw+N7c4w5TCt5R6CI88JoTJaJZVkoXOD28jBOgC7AJmAIwrB2stxueaAZxKphaQc5NN5ngBFXgEjNsU2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064842; c=relaxed/simple;
	bh=tb1NJ6THbO4fGAOt71qmHzyuduWdHm5vzycR/NKaFuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctJD+YSXJ8WyLXbUki9VxZEgopxusAdY7qFqO3ycfrYjZx3/MWcvIW2OLoDsJ1JBJvmwiwlElIy9n6RH1JTw/xFARRCsgj2su03juRRv69xy3fmQYr5sjyKDgXkWxA3wxR0GLvYVTpLlGoZ+prZhdJ2RueIk3xhSH90g+c9W5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLrF5G+b; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ced3386430so13090415ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784064837; x=1784669637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zebbIro5mkXbuDBJ5TKnPBr9hFGew4CMfA/H27lS0KU=;
        b=SLrF5G+b5i9n/3C+1ZCCGVOL+lo2aSb4ZZhaf/rOZiKtc9rVJfvZKeHs2nrXG+wB3x
         tiCGoJwbkDuR/llcQ3wcdd1xxS9UcpyE8YlGZjA9fiKSz7ICkEK8V3rFElngGU3OTq6v
         Iy8hsiYVV83MwrwEjbBXfpgu3CQPHa11v8Uf+n5T9Hoz05Zp6NdbU/4uzpe+B5JVU6gN
         S5cesmj/yjPfUXsPIf29kOL9A4rHxMDZhPI5f2vKUsMj9lCCFPyEFzAPF7sQWd/y+hA1
         jzCX2Gnl+XvAR7uu/KLQXeM78j3wMGuS6xo/xfxQk911dNDqI4Vn+8B7AwMYQbw0Y661
         b08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064837; x=1784669637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zebbIro5mkXbuDBJ5TKnPBr9hFGew4CMfA/H27lS0KU=;
        b=jlgRXQtZYfgr30PgtXRw2K8zygrJUfQzZJLmBixfiWQKmFKdkbzeqfbypXRdwxDXgH
         NmdH0g37b8qzDu2ivz+g5Ja4rch/kMLiTX8/xqN1GBY0DSonz7EBJ7G2x471cobt0C0i
         fTsufOqt6gQgI9vg62zeNlGfUACktlg+EmUWBRfwa9f+U3sceZfkcThyVqCR23hUXFRs
         RzjTvLUNrGbsiSmZ6O7WrkJGT8qPOolhC3Vuswu+8Au3Nv1+DNDAJYo7SIt9u6FI9LIR
         piq9TloRoFqbFGHrLSTpeZeEBFAsnu5kva3j5TwNbzxU8PYNs7RM2kpiJcBy5+z6Jw6F
         GERw==
X-Forwarded-Encrypted: i=1; AHgh+RpLu4u//NRJMozU6siK1iuHi+p1fd5b0SZxUb/X6C84a2qDAwlsUxK/8wBo8CwL69nNoa9YZWpPhFVS@vger.kernel.org
X-Gm-Message-State: AOJu0YxaO4gAEmVkUlYSeAT9h+kdInKehtFBYK/RLsTHrOro8US3gs3q
	B/GL/RWKYSHJLefEC2hWRFznbz98opzupjaQff6SZ6AQM4S3aOdMrL/W
X-Gm-Gg: AfdE7cmGxeX9XmkC/RycFUUOXEHs7ytIxp49aGWFTR7jZZPnvg98O5Pm83yGitnPoeo
	/TQyLe3XZu79/kahmj1jrtEFv6jjFeQOlMNnSe2NrXqWxHz2/jkWrw85U+nev4RgJQJF/yfOBSo
	cffSdz03qndmflPOD1JDEht7nDLlfLYWyaGZzU0hr7PAhxAoKq8mx9m5d2FqpFS9RCGCjX16yU6
	suaweTtT+KqCoP79YAp8s16pvWM2W5RvJ9Iru8p9cO9LAlDj/ckeZJk2M2P9ILcQ93ZQKh9Z2Jc
	7WuU4gf0A70gtKE+nVkRpZ1UitXwJBQAJWXdP587O0Ol/jhntSG4rk2+oOCVFaVh2wIhLFQOgMw
	+RCRtCjNQ2OT7pFul9M9L46U4Lk2wU507m75nlSUYNNadPLfVtYgjCyamu4EmjUS+Bup8+U38fn
	Sxl2+VgJ8oVKQ4QAjxyyaQrJz950f0BBns1XX0/6RHQsrJ0XgO7vGxXPOUjE9m1HKMOg==
X-Received: by 2002:a17:903:240c:b0:2c8:1c05:16bb with SMTP id d9443c01a7336-2ce9ec0f108mr142192545ad.24.1784064836947;
        Tue, 14 Jul 2026 14:33:56 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cea6507b5csm55058005ad.72.2026.07.14.14.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:33:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:33:53 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org, jgg@ziepe.ca,
	kees@kernel.org, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, lyude@redhat.com,
	maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
	mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
	ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
	shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
	surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/4] fixup! drm/nouveau: use
 hmm_range_fault_unlocked_timeout() for SVM faults
Message-ID: <alarQbmnjwtgdBUB@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
 <178406001808.1082778.17299764648397654220.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178406001808.1082778.17299764648397654220.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:jgg@ziepe.ca,m:kees@kernel.org,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-23232-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C54BF759022

On Tue, Jul 14, 2026 at 01:13:38PM -0700, Stanislav Kinsburskii wrote:
> nouveau_range_fault() now uses hmm_range_fault_unlocked_timeout() for
> the HMM fault path. The timeout passed to that helper is meant to bound
> HMM's internal mmu-notifier retry loop, not the whole nouveau retry loop
> around mmu_interval_read_retry().
> 
> Pass the full relative HMM_RANGE_DEFAULT_TIMEOUT value to
> hmm_range_fault_unlocked_timeout() on each attempt, and retry from the
> nouveau-side mmu_interval_read_retry() check with a fresh HMM retry
> budget. This lets HMM continue when it has made progress, while still
> preserving a timeout for repeated notifier invalidation retries inside
> one HMM fault attempt.
> 
> This also removes the open-coded absolute deadline and remaining-time
> calculation from nouveau_range_fault().
> 

Sashiko is right. I'll need to do it differently.
There will be a v2 of this series.

Thanks,
Stanislav


> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c |   30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 4cfb6eb7c771..b1415c2e49fc 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -655,8 +655,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  			       unsigned long hmm_flags,
>  			       struct svm_notifier *notifier)
>  {
> -	unsigned long timeout =
> -		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>  	/* Have HMM fault pages within the fault window to the GPU. */
>  	unsigned long hmm_pfns[1];
>  	struct hmm_range range = {
> @@ -677,25 +676,16 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  	range.start = notifier->notifier.interval_tree.start;
>  	range.end = notifier->notifier.interval_tree.last + 1;
>  
> -	while (true) {
> -		if (time_after(jiffies, timeout)) {
> -			ret = -EBUSY;
> -			goto out;
> -		}
> -
> -		ret = hmm_range_fault_unlocked_timeout(&range,
> -						       max(timeout - jiffies,
> -							   1L));
> -		if (ret)
> -			goto out;
> +again:
> +	ret = hmm_range_fault_unlocked_timeout(&range, timeout);
> +	if (ret)
> +		goto out;
>  
> -		mutex_lock(&svmm->mutex);
> -		if (mmu_interval_read_retry(range.notifier,
> -					    range.notifier_seq)) {
> -			mutex_unlock(&svmm->mutex);
> -			continue;
> -		}
> -		break;
> +	mutex_lock(&svmm->mutex);
> +	if (mmu_interval_read_retry(range.notifier,
> +				    range.notifier_seq)) {
> +		mutex_unlock(&svmm->mutex);
> +		goto again;
>  	}
>  
>  	nouveau_hmm_convert_pfn(drm, &range, args);
> 
> 

