Return-Path: <linux-rdma+bounces-23214-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tA90HV5fVmon4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-23214-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:10:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F9756D1F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:10:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=adsEe1DE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23214-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23214-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC8A330158AF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6FB4A341D;
	Tue, 14 Jul 2026 16:10:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1A4A3416
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 16:09:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045400; cv=none; b=m8IFh88e9XDW1hZuZvJVFht3XpYQt1a+/b2k+yGM5AghKPZdvMw4Ciznny9mbXiaPRoLEiVgbOZt8GN/4PsMge0UDBecogTmcfx84gtwIuOxsvP/iZpXaHfTt3Oj1ym1hGOAxpZRikCG7Q6RR2v9WrW/Tco/KOh20lAdza+s4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045400; c=relaxed/simple;
	bh=PokQTL8gKyIzQEad2vUCz8s8DGEcDYbE8wLb9vQv8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzKCarwjcn9BW8l4l9Ij9St4caBrNpPEP3/TTB5hREgHc9PmkyPTJVZ5g90YGiaXUsx/7iutCctyfKT6oOihBPNS40Xg+N2WWiyja7vAAY08EhzeNqmvQ3iQK1NWx1jEIRSV9jy72zgLVzYMB1cEUoNfqwT/D+YUxmL6gH0FZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adsEe1DE; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8484f229529so941682b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784045396; x=1784650196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdgMbrcVylxaBaGAreEv3T5etD7pXeCq9ZAv6P049TQ=;
        b=adsEe1DEk/lQbNlt7CMipTaRrAjllsitccpAqt7lKLZ8bEgmNSiM08Mo2EXx0ei46C
         nHVHhLWZCePMsVQUf6iuwTu+qwTXGWznTeIqlb8VkWEGEKIBOyeLAwfWkWZLaTgm/A32
         jmyflxyCUrN+Wng4hT7Ir8FkdSgdduXm7Q/7gVmMMRFEet4ns45rWwJl+YV/ILufGWej
         iv3wLn9AiIXP1b9zMRksoYbc8QrI8PB6Khk7VoSnMt+D1pBrRBXMn/G6oUpaKrqJVqfy
         yy5l9galu0zbFD9EhEaGp32tlaCq268GIo973Zn9tRYtiFv985SmkWEokM0TcNaPywKv
         AHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784045396; x=1784650196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kdgMbrcVylxaBaGAreEv3T5etD7pXeCq9ZAv6P049TQ=;
        b=Rj6HXN41o04ErAv6cHpASKJDf2h/atRR56AIPVvjAJP8/eHxHe6MWsZ+L0zZQn3eMQ
         2vnf9JIUOhU/kGYAu6rVYrly8tSa/7N3NImibVofRnOoA+5r3b+NFeaz9sCzMCpl3Sfi
         533AHIyS5VB15tf49wMpEL6kSyZl/SPyNBvEClBpZLSvUH2bj907I0d6d/2OdJ4aeqQ8
         TxwjMO1GsN54u5il8StNi3doThSgQOET/VYP0o8z3BM81KLKoE03GpTmNS2UkFDuLzs7
         vHwSZhuQKYGGxOQXNlxqRBKaXit1MtaTqmER9Bc3gycfV08I3KYLC56kNZXuYs9mrQIC
         vNtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVqzjyZAT5G0r+PLzUnPIjtPqTCrVxQMzqBMDmi81IpwE9d8rytfY848eyL7GWtkQGow9olGSBp0su@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7yBHFLu9Nev9YU6QI3r1vH/ryjmgFfbg1xHxH/eiWYz/M6aC
	zU3V3xh88w15ixfwrl1M0gprRWzXF6tBWQiBsOIUqhbiKsierwevPOpF
X-Gm-Gg: AfdE7cmLyI3ZKgqGS8anrpT4jvpW+Yar1DNLgoCxLfh8wCPCLfaOZlHDlU16zLRm8hX
	MAQJIeROy1shMwFudU7rQEny7YP7s5t/UH4hcXK26PrpLAoE8wqwALKn54QAmWbxhKCsHy4654v
	SavG25TJd1WKlAdx6b/Xtt/LXvC35Nku+ekXDfzIdkwz81KbKsXsRMOAXRPVFaH5ZeuDnbI4kyn
	0FHpj5zwxsxzbMrQpdQKLDavKN09clPM4zm7r12c9NUPK47Yvx/CqwR4lGApTTlqGjfmQV/58IK
	Cc2zBRbKF5hrrnaqWxDTEtcRrjbWipu1nHzhqyJInbRqU06zdSHtdtF5FfOdqFPNzXc0YiagvTQ
	pnuKWp/54yayB3+taL9MwzHtTmniEki/gDRbi6YXrH6djcMV/S1QQmOgnN/hc76QfymdUBJZ3oV
	DVXxaUXvnQIldubC5yxTpIP37bJCD0UXkWKRESiquRYiRbzprTYnACg3c=
X-Received: by 2002:a05:6a20:d70a:b0:3c0:b55a:80ff with SMTP id adf61e73a8af0-3c11063d595mr15198722637.24.1784045395651;
        Tue, 14 Jul 2026 09:09:55 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm10020860a12.19.2026.07.14.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:09:54 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:09:51 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
	dakr@kernel.org, david@kernel.org, decui@microsoft.com,
	haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
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
Subject: Re: [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-ID: <alZfTxfypj39OrCE@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
 <alG2-RSitzPWClAX@skinsburskii>
 <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
 <alVRU38lMfvmUFqJ@skinsburskii>
 <20260713154535.7656b3a630e2f6f076b4e76e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713154535.7656b3a630e2f6f076b4e76e@linux-foundation.org>
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
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-23214-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,skinsburskii:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E24F9756D1F

On Mon, Jul 13, 2026 at 03:45:35PM -0700, Andrew Morton wrote:
> On Mon, 13 Jul 2026 13:57:55 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > > > I rebased this series on top of mm-new right before sending it out.
> > > > Should I have used a different branch?
> > > 
> > > mm-new is good - Sashiko attempts that.  But it's changing rapidly at
> > > this point in the development cycle.
> > > 
> > 
> > I’d like to send another revision addressing a few comments and also
> > replace the `max/max_t` check with something simpler.
> > 
> > Which branch should I base it on so that Sashiko can apply it
> > successfully?
> 
> mainline Linus would be safest.
> 

Looks like linux-next/master has been updated with the v8 of the series.

I have v9 with a few small fixes, but it is too late to send it out already?

If it's not, then what should I base it on?

Thanks,
Stanislav

> > Or would it be better to send fixups against `mm-new`?
> 
> That should work as well, but it doesn't give us a Sashiko scan of the
> whole patchset.

