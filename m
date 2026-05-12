Return-Path: <linux-rdma+bounces-20505-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO1gHz9cA2qE5QEAu9opvQ
	(envelope-from <linux-rdma+bounces-20505-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:58:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B9525478
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B0E4307B02B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2BE3812E3;
	Tue, 12 May 2026 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YCPSgTvZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35AF3D45DE
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604817; cv=none; b=ByV//oyqei654V71IzisEd/TwyjErRNl5XdWoAF0tmdt400n+r034lXL59gdsyCxtwUKxYIgF6sVRaBZxG3CzCYL/+0wMNqGu4X03ioMBPE3KRJ5TZzY8+rj0pt+YNjmKdWG9q2zbDcCyRhXYOAumRcLx1Aij9iF02heXrZaGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604817; c=relaxed/simple;
	bh=rG9DO6/gmWHz28jvfSltCsLoBN4ZhvPxU8qy9LstV8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0ovFm4UE+ON5i8JYf3RuLd2m6O2dMsHIyMxt/B+Uy+xOMEb0YtP79J7zk5pp92OPBNNCNy/s6Pb8NS5zXJ2ZJ3bcejHfJBbfrfMP4V6ZMync/CZCkKo1dKe/AaP4rdUNql/0ooXiUsiY7Cu3gBskVeemALt6UCZ4NAa7VUMOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YCPSgTvZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90eb7a63a30so32241485a.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778604815; x=1779209615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2r5zIqJqLi1VU5+iH1+k500ZCWysCnfLC66P4+aXNI=;
        b=YCPSgTvZdnkWUXxCA/o38A51cC8ToMtcuBwC3xoPP836wS6UfwzqmbZGPM0Hjj2KSZ
         sQzAGTMiCzbtj6Xld99OVdD//XKTa2ofxaUrk0SACeBW4fwq2+KuNIKdWkAEW7xMdy5P
         vRTZ9uQjAjOvKU890QIULf5ALqr3pIY6YzHeGOet0/qUrRY/bVR7yzCSJCGWf1si3UVR
         BBW9N3FOcjFF6eghhlCCjFULAJKqgM2RRZwSTx/SCg5lfd7RxVI5CwuvVnNaW/97h4mY
         5APE1we10nw3WCkhKAusWDcm9Gs5PNQ/qFVvaqDnAKOUOV+VrIhVDR79PAI5zac5FDYd
         TiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604815; x=1779209615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2r5zIqJqLi1VU5+iH1+k500ZCWysCnfLC66P4+aXNI=;
        b=jysAqqD3xcoqqrGBl1R+gdgNUnjdiuu8YXcCRNON6Tqa6dZstVA3qmBVP70uw100sP
         F5TsTuXkbkps0o/f9fr72FOkgVjIJEx5hOaKPWh8zfqXbmZ3qK7rKDwqbFsmzqYkWzbO
         gre8f9LiDxTovaSOYp+0ZP6K3hWCeTa/EvrSVrYJ1+aXMb2leDtuEFfACrubRdV8zFRT
         MyyOYtuaL96eUEiRKQZv31rhSuswJ3l94kcIxV2awT6w2Wz3ZfEWgU8wMOd8yp9kAtlT
         46uP4qjyu0Z1UoJsV/6VaU5lpygsaadXHQ0CoFy82/RtCa59LTB2LeHjfBQRn7lE0qot
         nEWA==
X-Forwarded-Encrypted: i=1; AFNElJ+mrANn1QLT01bRrK579YeYZsBocew4h/dUgFqiHfIfy34Qf4NxUFy2X9MI5EceOJIxFgdDUYTAQM5K@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9UEYUUvh3l1gtRX6DG6W2FJ+CGAd/tjU/PfJbJLApYgHt1kz
	E2ooF8PwBaPolzM1LSWsXa1V/hGsxpIMefkYQY92orEpsFXPb+51bmzLEhvJ0xGNnkg=
X-Gm-Gg: Acq92OGvI2Fqw+AKzMQduYJPGzua92rigvzBKHxeNRX9OVxQRaeLsRpubhHUJZ4zgSf
	xwh53qDpypoWwDW9yzHt0CkZ1R3gLAexrN+Zy5E0pJZZmd/JfgKWWxPaNVNGtWmzkbr6+Fn4MAL
	PcSvH6pLzpcbyF2IUxCT2TY+tq9Y2zOYS3Y+5N3ud5nJRNTJtGHUvSRS4qRtDv2sAM2DM06Qkmf
	Q10H2qMBsMW+xPMyBZ4wvYN0wKxwN0hQ4C4PQd1tkFoZomf/xuIuisOO2EjOheRGBaob86g4YVV
	HNofjYGps/g4s98GxKSuJKUu9MnGEyqjmSkAFmEmESIgpEjEnaLw3KiFHwTADLaoepiuDMhj3Is
	cZbZgvaFRRbMgmHNILemUY7Q+U6ivTjjOvDJRI2CE/WpLRHzi2ZHuSTBbdZBvplDKNSG1Rl1CrV
	U7rn8NqEmw4sN1B9g4M3GmLAftVYFm0t/f7HdOoV7/caGC+HTn60+4+D5Y7KLzRZmJfjQiiIjJs
	lDLqQ==
X-Received: by 2002:a05:620a:4692:b0:90c:c513:2b1b with SMTP id af79cd13be357-90cc51330b0mr737690885a.16.1778604814673;
        Tue, 12 May 2026 09:53:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90cb4181d2esm335450985a.37.2026.05.12.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:53:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMqMP-00000000K7Z-2LsX;
	Tue, 12 May 2026 13:53:33 -0300
Date: Tue, 12 May 2026 13:53:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v4 0/7] RDMA/bnxt_re: Support QP uapi extensions
Message-ID: <20260512165333.GG7702@ziepe.ca>
References: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Queue-Id: 1F5B9525478
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20505-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 02:28:51PM +0530, Sriharsha Basavapatna wrote:

> Sriharsha Basavapatna (7):
>   RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
>   RDMA/bnxt_re: Update rq depth for app allocated QPs
>   RDMA/bnxt_re: Update sq depth for app allocated QPs
>   RDMA/bnxt_re: Update msn table size for app allocated QPs
>   RDMA/bnxt_re: Update hwq depth for app allocated QPs
>   RDMA/bnxt_re: Support doorbells for app allocated QPs
>   RDMA/bnxt_re: Enable app allocated QPs

There are alot of scary sashiko warnings, I stopped at this one:

https://sashiko.dev/#/patchset/20260508085858.21060-1-sriharsha.basavapatna%40broadcom.com

 If userspace passes 0 or 1 for req->sq_npsn, qplib_qp->msn_tbl_sz will
 evaluate to 0.
 When this QP is used, userspace could trigger the kernel's send path via
 ib_uverbs_post_send(), which calls bnxt_re_post_send() and ultimately
 bnxt_qplib_post_send().
 In bnxt_qplib_fill_msn_search(), there is a modulo calculation:
    qp->msn %= qp->msn_tbl_sz;
 Could this unvalidated req->sq_npsn lead to a divide-by-zero kernel panic?

Please go through them all. Fix the things newly added in this series,
especially the uapi issues like the above

It points out a bunch of pre-existing warnings too, please prepare a
seperate series to fix them, it can go after this one.

In future please be proactive to check sahsiko.dev don't wait for us
to look on it.

Jason

