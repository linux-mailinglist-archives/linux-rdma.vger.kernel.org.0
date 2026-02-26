Return-Path: <linux-rdma+bounces-17241-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JxSEruZoGlVlAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17241-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 20:06:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4CE1AE2B3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 20:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF70D308D4E3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1B42B731;
	Thu, 26 Feb 2026 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="A0N1iQsY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2642B724
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131800; cv=none; b=A6LM7hxgdzOecBvCzWuTdKLPvKJ61p3oEbAunNvZJonFj6hHMYdXqdMh1VSy0HJaJqEe+VP0j3TXJS0hn01zb+D8vrS46BxBm/RObP1ULu0FarRS+hHGOzdu0GzdIxwZb4CME3OA67Nn3914B3qDWmNWTYXn7Zkil1AVmUbNNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131800; c=relaxed/simple;
	bh=FpN9EERTp2cRgxv8FwIJtAYQnraM8IhyGexQqnlZvxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SorTz0D33ug4XrU05P8wtwGDGAXYEIEgwAwhHP8Q8kdRmrPmb4CVCrjSawA0iR1DN784epn3zXELWuyb0xPncq0r5+wxJbHDYO1C/LEybveBHV2IsorMdleFEHp+0tDg7hqmVWmKpuCLugl+57nFPHkt2h4prbStDZISm5a4Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=A0N1iQsY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb3bae8d3eso103770985a.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 10:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772131794; x=1772736594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNGl2PacRgY/7eEMD7XjUPhLqO/KH21uY3Hc8HdE6Yw=;
        b=A0N1iQsY42dgtKBz2p8VTyl2CrF7Df6aRgM0yWMmfR8QZ/cbjlWqs1zMIvlCxTxtdc
         zdOCyBcuNhGKejE9Il9ZQoJJg58l1s4H5ZKndsWQ3lujGuQPYRDc/VrpJRCQXPArhD9C
         iWrdZup1SmlKVbb/MfTh6wtcWWRIRGD8NVKKByA2ToyCRZAQIDGAnJaTAWyIl2vmbztU
         UMvnSh/Jr+jrIn3sBSlI4owdLBaikWOOSK5offDWHq2Lreb98SP9nL4itZseaOFSshx1
         8FToskLhvz8ccT0K6xx7HDxOX+gUzxP70T006dckRk0KxnisNTDhDc4mcusGcwXjqZ2a
         oojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131794; x=1772736594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNGl2PacRgY/7eEMD7XjUPhLqO/KH21uY3Hc8HdE6Yw=;
        b=OmePrFMTplU69kAfAH5R9RtnPyLHtP4VOXHfajVIV+pzxOfn+k5nthVPinoyGMuTlt
         JqLR0bcSlqqfI1NrT4eCgWyWTfiLyM7dlGSedhnrlyLfhlZiNuWmkiNLc/pj5UuifpUA
         eyZtdURj142JneczdJnHE+JG56Uo/96iR8MFa9etU8q0d0AQ8NIeO4CWGSbAlInYDLZI
         Jl3ENyCaKSXOp4il5C/Qk3Fx25DUstxKgktkyS0LZoxeXtwobpkwlpV/ISMxvnZ/cHsG
         tg7niPlMrh1DcXArtlhB4ap6ylfvyRfLZFwf9O5GFWCZj6nOEopvNpRozLplY4O4gnOH
         5Krw==
X-Forwarded-Encrypted: i=1; AJvYcCV23HG55297Q988JQ7W7dSgNCDw+3SJTAok0Bu5XEU89ZFSqhdX6+77Gr0Fo+KYwOBGIODkZ3msDNNL@vger.kernel.org
X-Gm-Message-State: AOJu0YxaywoSg+a9++t8uzpBUa+fxIpQB3IonZzyY8+RJFCXuNFANcd/
	oSA7ZRFIDsiM1rJvoEjaHc/2TVzLZQMWEQ87baaKKgny8pYOMYupOZwsL1ip+xy1+7Y=
X-Gm-Gg: ATEYQzwKNciHMFtIuBT6+JJNMk7E5Kee5clcTx30lnbAh9zpRDexc8g+pZMZrKTGtZd
	/rcGoW4q3ruTKbRc+0WlFWJKKPTkMzns4e3Xct+acw3cYAMTmq08ZJ1j8UED9EU86fmobcC/JTl
	5PRLi8EsuyRbm5sodgnsoDESW+MSENlYKYRuYt9wcTk9J6X80g2+RNrADJyqy6X7gtJ2uVDBOs8
	D8zcXLsuOmnJTL4M6xdRrXZLK/0lyDEq836pkt9p5X3XAqdBHPP0SBOdZ8A2WsJJp5dYyNVITWe
	ojq3saeKDMbmIXT+Cwi+4DER8bwaAsiClwKuHWLt0JqsycoO68R967H952LnJTCIl1f/FhivsIB
	NX4AtKsgGE/AQ8x6wBSD6RBFeC4aax1eiuHKxd/pbtPM1NZbAcgBzMlr5KZwsh6VgukKLt2FAXy
	E47uL9JB7R+J/qrmHgCzjSger2OHGvoM7T
X-Received: by 2002:a05:620a:25cb:b0:8cb:4f63:dac9 with SMTP id af79cd13be357-8cbc8d70e6dmr1400785a.17.1772131793718;
        Thu, 26 Feb 2026 10:49:53 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm268217885a.51.2026.02.26.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:49:53 -0800 (PST)
Date: Thu, 26 Feb 2026 13:49:49 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, ziy@nvidia.com, ilias.apalodimas@linaro.org,
	willy@infradead.org, brauner@kernel.org, kas@kernel.org,
	yuzhao@google.com, usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com, almasrymina@google.com,
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <aaCVzc2lexW0TiPf@cmpxchg.org>
References: <20260224051347.19621-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224051347.19621-1-byungchul@sk.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17241-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cmpxchg.org:mid,cmpxchg.org:dkim,cmpxchg.org:email]
X-Rspamd-Queue-Id: 4F4CE1AE2B3
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:13:47PM +0900, Byungchul Park wrote:
> @@ -1416,9 +1413,15 @@ __always_inline bool __free_pages_prepare(struct page *page,
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		folio->mapping = NULL;
>  	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		/* networking expects to clear its page type before releasing */
> +		if (unlikely(PageNetpp(page))) {

You can gate that on is_check_pages_enabled(), to avoid a new branch
in the !debug case.

Otherwise, the MM bits look good to me!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

