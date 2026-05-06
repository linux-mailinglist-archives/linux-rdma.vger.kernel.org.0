Return-Path: <linux-rdma+bounces-20085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ+ZNJ5N+2nWYwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:18:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663E4DBF68
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BCCE3003D0C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133753ED137;
	Wed,  6 May 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="PrOECl8i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170644E04A
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077083; cv=none; b=OCs2wIe1fOHk/7ZGcAtHeDZYUBMLyoPQszHH0R/98zx0vfJtQpGa+f9d9kXlYwY+qoYAynU1KOosRW1zhZxTQexykiNbV3uxQtEGiZk/InzELf9M98ohEkkF7jIndDXa+y+M6PGQ664b0f7hnxfkxowr15jSGBRumydi9yJ94lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077083; c=relaxed/simple;
	bh=RljFluWxz7hjoMd4ygRFN6xM+i6iK7ZuimWv9gXjLlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgOLfScerAolhGU8enNa8oAOsaIfPsIaic3aORo/6wbc3tEgNopOdW422COPdQ/yIzJPySCkR0YAr6h3TU5WS+xRUZW8FnZAsj5XqxYdJcagahPp7rfKPKD19/1ZczLOnY4XpwSv+SWjmbaBD1txpnJHmP5JNsBf/Tnp0yP8hV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=PrOECl8i; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso50329445e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778077077; x=1778681877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bihndA/iAmt9/IG5Z3G+Btlq8iU85LP8GEw/3/N+9Y=;
        b=PrOECl8ictWam8jRWBHlx/20iJtiJZ2PMgxbnBzj+uPB44KCMZEOwr7n0QepDzw/Tr
         F8X4sPMD8YSo18wj3ksiqj3R5ywEZR1bIQUOaVhaD80PZnQ1Vgrjd5ZyzPXKFyGxkFY0
         mLTTKPLNAtenfBISxhD75o8AMAAvQUQ2UPvO2EBTbUgYIpwmqgKqiax+8GtGYz0kjsFd
         j76M1Fw3g0rmu+B1d1nH+Xt4EkruUBRkAcP+a1edzfo4OKmANt3tt22TaUkfThdgcvOR
         ETJwdi9ZTKqA8mA40bHAXQ3iL1E2p9lulJOHaTZRUb7DUwtoYc5UnIEPciTzLhnxH80S
         mI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077077; x=1778681877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bihndA/iAmt9/IG5Z3G+Btlq8iU85LP8GEw/3/N+9Y=;
        b=kOsuiCWF7+Z/6Sc7whToF1mmbw630E1mn5kkGp8kWFDM33DlIZ+2karKh57LeXM3LP
         LdLafRBJMNODb6DTSY1h9J73pITIKxhOFVyzk7sESOw3Jxy56TuZdmrWGUFsJz41pmgV
         LryKwMMG6dJPk2EDkm/I0ILvGamyY1u2ksmkAC+GVeTjjKq5ANNyZjThzYnCRkH3C7lf
         l5n3NDrQwAGQBOSiB8U4JNzvSkodA4RIVfaYkSxD1S3X/DS6XtSHlIsvAiv+nxCE/K8J
         Qu9JJRkZ1zH5MxyGLOfGi4CGbcL2DoD6MST6Q65fEtD/H05uo0sSmFReW2B2VgfRfwyc
         IvMw==
X-Gm-Message-State: AOJu0Yxjw0DToYvA+qsYO6Kh4Uex3C6xZ09b87eeLDmB77Esb//6Siih
	sWK+iBG2MJpkllDow2G6cwY0ie9RlfVup8qlmAR/4buN1k/WtscZeAlGNg3OZZO4fFDv7qMdZX4
	FPgDx0i4=
X-Gm-Gg: AeBDieu63B7ZyPR/6KOxL+GGfg5JhruLvxX+atEEsmscHgApEhmmY5s9Q6aiexEB819
	hGa0znEho8Vj1/8m/f+TAKEJeY6bz0uDFKra78L2gqzG5sK9K6t8JnblkNr0YCQL8GeFay0CL/b
	7VIpsF7G9cCjwrcWG4RaMqjjxI2aEdN7fJjd1VeUEGFh7MufPSj3UV5/ZmogMtO/RnE1nH8jwIJ
	kmh5kjxaBDbFm/Hs3510Qacgmi9ksCh9vqILVPKbIwDLiHl+Rfxq8ql5mxhccr8HdpOsb1D5lvd
	nnHV8XsLCHmwEoY8TxDrgcTOGE+vQaS3CW5q/KPpv+mZMuuwL8dYOCvVKKYEGoGsob0AOz9VGXL
	MH4Fdflpjd+AC+BW99jVtteyu7kRx8k0UIJSIqQECtgCehJP/ziLxye/OlWMfqeuz4wD6JU4lgl
	xddj6JFe4aelvfACLcDZypmEBDe87xzrBSeF9nlAjMOFWhEiZSK1oysw==
X-Received: by 2002:a05:600c:4512:b0:488:c744:49b with SMTP id 5b1f17b1804b1-48e51f539b0mr60565325e9.7.1778077076916;
        Wed, 06 May 2026 07:17:56 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:8c0b:afdd:3d9d:e976])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538acbfcsm47058205e9.8.2026.05.06.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:17:56 -0700 (PDT)
Date: Wed, 6 May 2026 16:17:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 13/17] RDMA/uverbs: Use UMEM attributes for
 QP creation
Message-ID: <aftNP9hAAzqrPmiw@FV6GYCPJ69>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-14-jiri@resnulli.us>
 <aftFko47Y56Gvsf3@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aftFko47Y56Gvsf3@ziepe.ca>
X-Rspamd-Queue-Id: 4663E4DBF68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20085-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Wed, May 06, 2026 at 03:43:46PM +0200, jgg@ziepe.ca wrote:
>On Mon, May 04, 2026 at 03:57:27PM +0200, Jiri Pirko wrote:
>> @@ -340,6 +340,12 @@ DECLARE_UVERBS_NAMED_METHOD(
>>  	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
>>  			   UVERBS_ATTR_TYPE(u32),
>>  			   UA_MANDATORY),
>> +	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_BUF_UMEM,
>> +			 UA_OPTIONAL),
>> +	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM,
>> +			 UA_OPTIONAL),
>> +	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
>> +			 UA_OPTIONAL),
>>  	UVERBS_ATTR_UHW());
>
>could an ai make a summary of how each driver would map its existing
>umems to these - add it to the commit message?
>
>Trying to guess if it is general? RQ/SQ seem reasonable, but I'm
>wondering what drivers will use QP_BUF for...

BUF_UMEM is for shared RX/TX QP
[RS]Q_BUF_UMEM are for separete ones, like raw QP in mlx5.

Will document it.

