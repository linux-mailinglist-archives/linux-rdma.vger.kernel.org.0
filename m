Return-Path: <linux-rdma+bounces-23003-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dKeuNModUWpP/gIAu9opvQ
	(envelope-from <linux-rdma+bounces-23003-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:28:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19C73C959
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=kzWtCM71;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23003-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23003-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5F183012E81
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50A367F36;
	Fri, 10 Jul 2026 16:27:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F93246EB
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 16:27:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700872; cv=none; b=JRqMGs/ARKkO1FhEdhX2gvr648nBBI/OIPG1GaNZTej0pamHnsTlVhBpZ/BSvr5/zvXdairvOmOpOQxkfU3jKYG/ztuBnJ8Y6FrRBhrXOkodjsl1yjrjSC+if4sdRQ+wR0m7Oy1Eo5959p/7IQFFd+Z6PydOrKneA6feQp3aHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700872; c=relaxed/simple;
	bh=zFHfJ1sc06mEROvkctmUCy8ljGsoiIWpsgO49VU7hjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmB+57aWwfzCMD74r0TrW0Jr/XlXAQYNRPnc+GMxNZddNNeaQiWAsdYNelJrHF0fweL16/kZN+X78d/4WdSXfgCy+Q4KcWVSSZzBHCh+cxj5G0JF+Si+F+1ti4cYMa3TPCeW+xTqQLYuzK1vuXYGGV/39y5C2lHex+y0Z1QQCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kzWtCM71; arc=none smtp.client-ip=209.85.219.45
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ff88549786so10835676d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783700870; x=1784305670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UNIXCm8Zus/z4nQ3xLBTLCwOawMM/+5sDMMsd2dm66E=;
        b=kzWtCM71+HYvSg5oE26kEeUnwihq3A/acXX4BVp3dJc4iGnjTsKQa4fnDYBQ6pBk5b
         29P7+Ypob7sR/qVJoC4xvQRlyVPCMjusy4b039Vp+MK0tL862RkeqyZhehuW4fn6jBFg
         BjxPS2nXse00VxL/pgQkm6gJ4jdEQwmI73lDyKnZGowzDZmOCSL17+P5Ktrf+fL6mmzf
         zxy6NhAvixXcWArIhMEK+//tQhuCNzrhiieoCnSaFt3Czfuu+cqU5kw81pvl3qkEYBbL
         S7JSGCUqPHUb7lYX8lvUJynDgusxrNxM7CH2DQtYQy3HkWF8djnbgx0z0K5075l4UiLM
         NK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700870; x=1784305670;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNIXCm8Zus/z4nQ3xLBTLCwOawMM/+5sDMMsd2dm66E=;
        b=ghE1thZcXbyV1FVOQraveoWsSHNKiolThVmI89VbYeF1CL2piczxVCkL6k9lGFsEqZ
         qWVhC1RI4EWknWLclBOJ8w9ETJFE9B3vFT17HWyN8cfD264YEP4BTLZ0iMrGN/8Xz6Mn
         Fbz0TSFQR5OWlx/wjK9Q9gPGQLY+ozJWlW6kQz2F0BSy//+OD3ejPNDlEwZ2PpIR6xph
         dwWrf9G+KvJgqBdNL5B/2Ufy0o6k8xmRRmRcYll+qZubo9UFOQgILQeDryMLNoQf8w8o
         ONpQKimkYduDhv6fy7q72f3VU6lm1fV1mxCcdBKcakVEdkD+csii51HP2nyQz3UHNi2H
         ykwA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+X7QgqgFpBGepbedL5xQN7HiDwhzR+hFdN+1tNEMXSXbEK4Um3sbtV6na/PH+/AuuwwTVRiMG8BuW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RFpfFd3L7q561FJRHPknfBTXArY6g7mVECHKObChVvZkBAN+
	31pw6iELrwfJdup6Y8Z2qZ+P+WANB9qBQsGnpqZqKNtC5szsouesIg/dEXc9xzj45F8=
X-Gm-Gg: AfdE7cm9obBynWYd+lCtqw8xC2rCk5402UzHLsC1CCLgGcJsg247xGR1OmPr9KE96pa
	mPsE1OlJkZ69nzZlpgByJl/EGl3Xvo4SMNYZwc7Rc4hchxK1SF5oIlmv6K+wTBij4wrMVP4P5Qy
	vSltbsML3dN14gm+Xlj2mJPVExbcPHBCCDR2TJvjkTiVnfVaMbuYauuCbsaQ+T6bN/I9pl1/8oc
	DL7Qp2C64hFWeeRMKpFQ1vsvAQg3RCiXvrP/eAp7zz6ajUVDn3lVYgFJedwSt9XD/NQeH5VotwQ
	BFWNOEB6eKvmbCtgoWcySiYRQCtcU24apF+/TJtqexmFoehki4IA/lxFFmN6EXwrbNup+HMtlPI
	XJE7nAyw8sy5HZYj4zRSjPokFhVj6WVzgIr2vDDDfxfv7vMVGblnkAnwyWVyHLELkPT3rA0Y=
X-Received: by 2002:a05:6214:2127:b0:8f5:eea1:6f04 with SMTP id 6a1803df08f44-8fec3522cffmr120531466d6.54.1783700870475;
        Fri, 10 Jul 2026 09:27:50 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e081dsm44781476d6.9.2026.07.10.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:27:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiE4r-00000007XPF-1WDC;
	Fri, 10 Jul 2026 13:27:49 -0300
Date: Fri, 10 Jul 2026 13:27:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org,
	decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
	kys@microsoft.com, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
	lyude@redhat.com, maarten.lankhorst@linux.intel.com,
	mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
	rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
	skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
	vbabka@kernel.org, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 2/8] mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
Message-ID: <20260710162749.GP118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345362182.660027.12809852179204464964.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345362182.660027.12809852179204464964.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23003-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D19C73C959

On Tue, Jul 07, 2026 at 12:47:01PM -0700, Stanislav Kinsburskii wrote:

> +int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
> +				     unsigned long timeout)
> +{
> +	struct mm_struct *mm = range->notifier->mm;
> +	unsigned long deadline = 0;
> +	int locked, ret;
> +
> +	if (timeout)
> +		deadline = jiffies + timeout;
> +
> +	do {
> +		if (fatal_signal_pending(current))
> +			return -EINTR;
> +
> +		if (timeout && time_after(jiffies, deadline))
> +			return -EBUSY;

I really dislike there is a timeout here, HMM is supposed to be more
deterministic. GUP doesn't have a timeout, what is this about?

Jason

