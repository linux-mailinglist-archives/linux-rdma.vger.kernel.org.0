Return-Path: <linux-rdma+bounces-20080-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPiQBkhG+2lPYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20080-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:46:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A798C4DB49F
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B90243007BB4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B33EC2DB;
	Wed,  6 May 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jrL/JGy9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23236CE1E
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075203; cv=none; b=G6WK8Der8E4cGR6tc0mMQXqxo6/Ok+K5ysgHSQLJskkPTM3VEKTbrDOfFuPgDT4i98CD7X3ZzKm4rNmYai4VXJZ7S7Au1y+Q7zvXt0g92r4ZfdxH7fHKbxb5tgsdc4aBEhIlEHT4olSko6ZQqsmjZFrqKlXI9eFzQlaCpERq0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075203; c=relaxed/simple;
	bh=bka9tgHvnrNPodYpflAmSylQi16+FEtDk6Lzgi5nS7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adAn1nbAKMqqt/aKfVU1URMCcmByHewF6IDlhwdk8p9HgJta+joHzK6j//PFcN1Py5V/Ftrlib0RK/Ldr7rHgF9WAy8Xd1Q/JJAb1/jX4BaKtjJgzTcO1OsNKwnK3y0RGBvxPFq0f/5xw5+uHp56p3soeLor+aYJSbV/mLFtYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jrL/JGy9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso9565905e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778075200; x=1778680000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/y2F03fNA7Q2NlXC5kHNEZaSZbgeUD4QxinhvlJcg0U=;
        b=jrL/JGy9LfUwOIVyWhLd5/KkjZreXZaeL3TH5w+ecUl7KsbGkBYlNf05MhrL6OYoqx
         DOC7QImD7TfL4mQ5Q7xYJhhEufp253f8vybpkOp91pUgBucVc9grb2r8Y1+BxvK6wEG4
         agar5eSP4ZAvcMPhzFUPA4/3kkv78jmf4SZWHSdosAGmJt7idrfPnHt1vXHXmfIMTUYd
         Uekq60hbdzTuYLYVozq02IoyKejbQklAppigoFcayyl5aUu6acxnxk3O6FlS/GZbjYn5
         rOgHugs++Jg53jIXHXqb1TIbkgfaFJTz1uAgfdVPENDpN6ToKsjLv3b3TXavCMKeMSXA
         os6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075200; x=1778680000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/y2F03fNA7Q2NlXC5kHNEZaSZbgeUD4QxinhvlJcg0U=;
        b=lvXsClk9ZZoFTyq52Kl6TANreS5oVpaZol0vGiRejvVwHKmjvsD8pGBEMtzz2uFIl3
         p+esmKAelK2EexwYzsqBz3X8LiDMfuSTQ7mWUF6lrt61TqgRroo777uEwvaPVo9l+eGX
         IzHXv23AahUPItLAFYEhay33yQCa/4RsPO6FRNtBzVJTnPzru/JIN+lQ64lDmbRMFj5i
         hkqSZM1MnpJzFy+wIed6WbB37Qv4CTUTzrswwihgCp6K1ej9G1RDEUpV++jHI+o1DFjT
         Xm02EtYs3sJeeJlTOBAWBj99SeKbobd3rIf8z1jag7qArkMpnLyi7sras5u64HV1QI/L
         Eu/w==
X-Gm-Message-State: AOJu0YxyTBdiWbTv9AGXSlvw5uOLIyhVAAgozYiLd81rBEeNWPRhVaOg
	hRwYrbPiJRwXE8+7oACJWf3nYsyjxcTzWuRIFzV902acJecwPhsnm4N2tgWk5T6yf3c=
X-Gm-Gg: AeBDietpGhmnKI0ooX1aGlczqvbxVLB9ESaAeo6XZ3rZA+jr5XqFDEEbmKkiXzyLLiv
	S5vM6wtJfTBjvu0pZQLlsIGoGu8mzleEXRZqcH11cXUK0M0rJKtYni8d934yE2f13YfNaCRsakS
	w8zV1HOJ9ExK7n0wpp2t38vkxD8Y1m7WkEANSgl1rpPNsI409y8P7GfxH65WHzpPLN5Mq9jTrVb
	dtQuON28884dw97E3ucj6eVC1tqt+mtzFz5NiZ/C+zJHzywXeXCVmoShJ4+mya1LCRJ0hqWIdLX
	ISuZH0FKvpTwO/5j0MO8r5ejCcYYuNH4p9i8L7R5Rzfe+CoEGhK134vD0SsPisKwBdEaphlRyXc
	913PKfcXHKZXpLmpf+lVwmJnrVktEFhNQguHng1+wm6GFh3DtOYTzD43lLg/TQJR9bG+Y5bTXPG
	y42ErSG2U=
X-Received: by 2002:a05:600c:4f04:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e522c0032mr44167815e9.12.1778075200122;
        Wed, 06 May 2026 06:46:40 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b213asm17742785e9.2.2026.05.06.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:46:39 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKcaE-0001kz-36;
	Wed, 06 May 2026 10:46:38 -0300
Date: Wed, 6 May 2026 10:46:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 07/17] RDMA/uverbs: Add CQ buffer UMEM
 attribute and driver helpers
Message-ID: <aftGPjxQA1Tcc2ej@ziepe.ca>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-8-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504135731.2345383-8-jiri@resnulli.us>
X-Rspamd-Queue-Id: A798C4DB49F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20080-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]

On Mon, May 04, 2026 at 03:57:21PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add UVERBS_ATTR_CREATE_CQ_BUF_UMEM and two driver-facing
> wrappers, ib_umem_get_cq_buf() and ib_umem_get_cq_buf_or_va(),
> that pin a CQ buffer umem from it. The wrappers reuse the
> existing legacy CQ buffer-attr filler.

Did you look at converting all drivers to use
ib_umem_get_cq_buf_or_va()? Is it just a quick cocinille job?

The QP one is probably an AI job..

Jason

