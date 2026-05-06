Return-Path: <linux-rdma+bounces-20060-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAMXJHMI+2mbVQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20060-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:22:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA04D88F1
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA31C301E95D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC8A3DDDC6;
	Wed,  6 May 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="qIVZI0CH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F13DA5BC
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059213; cv=none; b=VutDoL+oh+SQ6MS64RlKmWZMbPI5H6dEInhGyTxL+W1QZ35kKZlv5aIAGftjjg+d9rM7HwOMYcRt51J8O1gK3BCIkVtm2RpESQjbn+SDzLHaRhAP3Ibn9HvgZ+NTx1X13YdS7Qf4JWN9egRFa89qAp7IHeNc3P1Dj/HwrxCNnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059213; c=relaxed/simple;
	bh=5i8UC0lpMa9fh3G7aNamvEqxgdkaKdfUlQdF9wJf4jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbQFXqVgaeJVVWon9lSi//y64RX/iIAEOz5/uJltRKsLH25UaA1TjiOxiKjZOR+1MRLgTsbDqb8MzC3BK0XbtCqyL01UtoF1Ccu7dsyO2K3vABF+bOFicNHKCiIRJiLC+pcaB7ePbPwoB2t3akDZWRsh+E+c1ZFOKgDVhoYJvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=qIVZI0CH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-449de065cb3so3836241f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778059209; x=1778664009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5i8UC0lpMa9fh3G7aNamvEqxgdkaKdfUlQdF9wJf4jc=;
        b=qIVZI0CHb+v4VaUYGSrZPAIjRE4wn/hEuHIaQ2/ax4TAonzYzlHF4IF4fV2BgP7jgI
         fbT7PgfGj3+AEaDTFCBBeViFBCRBDALcAmxhb35TK9gsJe7W8YqS3g7WuRx1Rs50GM4n
         E6rcgFaRoP+5sMsZn/FDLOGagMuEyLgZPJzVbPoB7DbuYyoL9S+obxYa0TSKGvrwGK5e
         nRvedryRkfgiLD1pyHLuEc6juiDlakhuXYGFqIkoovm48fxLuI4G+aJiku4k7TruWD8r
         M2YerT4673SZAly1tiBYNpFbuTDH5sGqHjLcCqG3D2uLKdv3KEtI7smrOmgtyL48GWax
         /hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059209; x=1778664009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i8UC0lpMa9fh3G7aNamvEqxgdkaKdfUlQdF9wJf4jc=;
        b=VpJETfjW9QfhV0P1W5IIfR+K8+P8wwo6BwCMIJj2WLpIr0WqekADmQUPGMoJ2fppto
         pJrdBCbQjp6/4ojzssqBc16I7Om5ZemkOxZHhMg2K83e9ah5PlRQrsHkw4JybH2RUUue
         eUQx+/XFOwzad69uI6G0+Vx+016UI6EC4oAQWyf1wbssj9YeKsIU9RPBkbV8abyesQ4r
         UvShb1qFMemZG3TSA+9Jn8fb00sF8fN1Pj8/mY1s5JyZVbNQwfysDB+d1/fWXEBS6CNP
         /eB8rWaFsqLyHiRY85nUE13cGMmyBXfekjnU8K6HXNZbkR+TI9U0r1EfTnQuH+cs6XmV
         MztA==
X-Forwarded-Encrypted: i=1; AFNElJ+g7Q2fcxtTB1ZAGAfe08udawPslLKTrtTzrgX/mX0RHEXeV+YUej1/TmD93DcIQ5XuaEU411dl60BE@vger.kernel.org
X-Gm-Message-State: AOJu0YxXNLpu3GcgyB4Zoxoj2GdW33oowsdGTX5DY4OFTTXebMJlMLSn
	8rhSDhioHwQw1+pNsiY9gkBeMFdkBNMLtnxLHhELSLSAYNxGQ/MBHuS02EwZcREmu1Q=
X-Gm-Gg: AeBDiet0DywdNy9p4kN+rk4RImlzM0vI4/EBrQqqJXvfrDBTufE8PQJE0rECV4ZutoN
	Dg6SVY1qx52ejSHa2oriZU8MzLEyJ8kNa5sNSqSDc2zn93jvSXPDPiiocrqBqMj42MSh6cJjnFr
	zfhdKhBXzyc+s3ocr7EVsIF89Gu5FzAZrCnb/Xif/uFSo6WUwCHpKgM2O0FwDJ4U2YPQe+7yIis
	1JQAslEp6MtB7t9mxO39F23wUyDyK5OYLz7j3ZQm+MdidH1bxWXPuh66D/1P21Syo2qucbaYiRt
	XVv1Km58QIAma/5/FcsY6x14eDkC+S0AA5qX3B37C0II6hnxCqjRqb00rs84ICP2CbjHCOnTZKb
	BNeq31GWsSq9CQJc/Dq83FDhgyIfS3QrKydQDUocTv6Ain0n0UBTRORuch92hXuWOSXPoLRUM5k
	kiQDQ8aUreIlaKRmkTmaNVOgt0x8Ktr1YRSebFtQkhxQ==
X-Received: by 2002:a05:6000:24c9:b0:448:ee7c:2991 with SMTP id ffacd0b85a97d-4515da95366mr4457669f8f.38.1778059209413;
        Wed, 06 May 2026 02:20:09 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a488d8sm10997420f8f.12.2026.05.06.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:20:08 -0700 (PDT)
Date: Wed, 6 May 2026 11:20:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Moroni <jmoroni@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	leon@kernel.org, edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, 
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com, 
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <afsHZruJqMDhNdQt@FV6GYCPJ69>
References: <20260505061149.2361536-1-jiri@resnulli.us>
 <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
 <afoUqiDgZmhE4Kog@ziepe.ca>
 <CAHYDg1RpqHxz_hYzHvsYzPpHG-WQA+7L_OPauB2DTuSJTuq1ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1RpqHxz_hYzHvsYzPpHG-WQA+7L_OPauB2DTuSJTuq1ZQ@mail.gmail.com>
X-Rspamd-Queue-Id: E7AA04D88F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20060-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

Tue, May 05, 2026 at 08:17:06PM +0200, jmoroni@google.com wrote:
>> Jiri has been looking at both options, but kernel side irdma must be
>> upgraded to accept a dmabuf for every kind of userspace memory.
>
>I think changing the irdma kernel driver to support dmabufs for the rings may
>be a relatively straightforward change if we can adopt an approach similar to
>how it's currently done using normal mrs (which are explicitly registered during
>the QP/CQ creation process). If so, it may just amount to adding a ptr attr to
>pass a struct irdma_mem_reg_req and using ibv_cmd_reg_dmabuf_mr instead
>of ibv_cmd_reg_mr.

After this patchset merged https://lore.kernel.org/all/20260504135731.2345383-1-jiri@resnulli.us/
it should be very easy for irdma to add support for dma-buf backed
qps/cqs

