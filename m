Return-Path: <linux-rdma+bounces-15888-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EBtCbYycmmadwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15888-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 15:22:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCE67DEF
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 15:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D99635EBE0F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F333F39E;
	Thu, 22 Jan 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QSnbXy6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96022EBDC0
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090866; cv=none; b=nBLoXf+c6sr1qTTnq3j7OfvGzohnBhDarGAYjfO3G0ZQwfhuy9m2Ts75+O1cXdlZwQkf2GD0SbdBEqKd/GnMZk7ObM5o0eshh76BqITBCN5oDLmx+64b4p6P6rIImA6VsIs5Bn4pdXXYPLWaDvFBXzlTrMSK2IYfykK087K3gbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090866; c=relaxed/simple;
	bh=fu2gdZ6wu90BBLLk/2vNcqc8LEX7760iNshWm++HLG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkQgzHPeoY87cSrjUfzEIz4/0TZ2rGrhG9pFdaKTSaC695RE+9rp0uFT329WNikr4A2H8vz7xF8tBLpIloZmXS6hvV0d6EeWWUXpXBNVL2MTcgx59oKauWkHrrjGukOEtdUYV6o7kZps/CZ33tRug4MDWf36f7aZ6fFVO0+/8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QSnbXy6/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5013c1850bdso8022371cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 06:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769090863; x=1769695663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WT50wBzrFLZqeY4UeI+26hXYy8MiXs2rDjnUT3Lf6Xc=;
        b=QSnbXy6/WM9trrF/PlutzBRA4TGGaty8UzUjY9O2Ybv78fpkhKcfdKZ575vtqIFDE+
         TYmfil1pPci09oNU4Y6AeRIwlzSDmNAodXiI82LklEpMTr6WAe8a9u3X/AbyJ36060j5
         vAVdRhuHSgqVfezb11TV3mQNSC9ZmW1xPFLaErn9cvDWkturXIdjBDNb1mbo62Gjgnqf
         ulGCnwIIviSdBKu7Fn/iG2sm2YA2pf8MJ5+78YOwN8z0q3AJ97kutuOogoYWHL5Uvm2Y
         ZfX/bCFbS2aV5UOHm2ATDuucZ0LgiAqY09mqg/yJ8MaLIDERT2FCwMQC1NdcXb+Bx2Z3
         qqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090863; x=1769695663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT50wBzrFLZqeY4UeI+26hXYy8MiXs2rDjnUT3Lf6Xc=;
        b=gICpr/d8TUutTGa0zIFL4jk9gYIU9e565ERIdu85cSSdyc7jxS682l7ZSsCbgOajhl
         eJvmDpxSOKM7JWIdHOsgWRgh2hn2TNXIvNYz8pBSnN8NYtDc2yMShiH8OD2fS63iv780
         lnUeJ3gQxwleeoU7hcP4bxPVrJLxNlmxeldP8XbTrE8UKlD6XNzcmjDpdr4iUKsNqH/d
         +f/i3ZuBfZsgotGk6M53C+Z74PaLVxUX/EKvCnu0RVZDASX2XQuM8xI96s4p5QOKs1nC
         iMsJm+YXBX9B/pxsQLrUR2YcXXUMgnAMlIkyB9O/EydSEZw/ZcQhyj+Ui4jdRMenjmsA
         eOGw==
X-Forwarded-Encrypted: i=1; AJvYcCUGRNUYWypIKoJFACMNk6EsPy42BRje/6P3Pk3h984M59B0K+4zHzK/QS2wg//qmsBdGTXpD9kaJvkn@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNhLY6+YhJrIxkkkdn7vdolPimbeUYU5/FOT30vSlLPGBbZ3u
	Z8XS54112fOAYdN3jvrwSSJPAgsoPDTCdHUV8cKTwQ2f7x3P8JLrTV6SI7kfFXt4qPmwsAalm2Z
	8T1n+
X-Gm-Gg: AZuq6aIM9IccnDt1Cvnd6Ktqr7yesTLr1Eoi+8W7po8k8Zdkz69wo2wd/AdqalF3FfC
	UgRYvSyculZp4uDjKMWyMxWZpNw5jUSm1H1lPiNVBvCmbUWDD3MfYn2jmegVjIKDPZCQIIhI55o
	wtaG9QRyfuh6JioOqVfAJPT+k0F23h9eajNUjFY48i2uXanJ/Gjsnjnw2lg5rqOA1UU7uMouVay
	jtZoj7wXDgFIBMkLDKQ1ABr6nZlxMz++amuLcLqvRpPS9BrrhSZJ9htf+hgyQJ2o3mZwNqXDIhp
	T1J6YPFPZ9JpPdLnP+WYMHY9ANLXwohvJG7OkjBPlO34S4oonwhFK7+GrGQQdkpyM4RB/CU9MsL
	eKbAWb7bqe+0JV/JO3C4RnD5+6QDT7AsYwzELM3ljnnDrbH+Ur47dE4goNah3XIBPk1Q+EBW/DM
	UcQQFhGhqINp2+kpm3HumP3QYr7O0WKR1Fi0b+pwtvqRsJN1fExwl0zqM5xJg7+mICr3k=
X-Received: by 2002:a05:622a:13d2:b0:4ed:b363:2c2 with SMTP id d75a77b69052e-502d8580a09mr109054291cf.62.1769090863474;
        Thu, 22 Jan 2026 06:07:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f1c1c4sm127472231cf.33.2026.01.22.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:07:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vivLa-00000006a8b-0wId;
	Thu, 22 Jan 2026 10:07:42 -0400
Date: Thu, 22 Jan 2026 10:07:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260122140742.GI961572@ziepe.ca>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15888-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 72BCE67DEF
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:35:34AM +0100, Jiri Pirko wrote:
> Tue, Jan 13, 2026 at 06:09:56PM +0100, sriharsha.basavapatna@broadcom.com wrote:
> >The following Direct Verbs have been implemented, by enhancing the
> >driver specific udata in existing verbs.
> >
> >CQ Direct Verbs:
> >----------------
> >- CREATE_CQ:
> >  Create a CQ using the specified udata (struct bnxt_re_cq_req).
> >  The driver maps/pins the CQ user memory and registers it with the
> >  hardware.
> >
> >- DESTROY_CQ:
> >  Unmap the user memory and destroy the CQ.
> 
> Perhaps I'm missing something, but why can't you use existing create cq
> with umem extension introduces by following commit:
> 
> commit 1a40c362ae265ca4004f7373b34c22af6810f6cb
> Author: Michael Margolin <mrgolin@amazon.com>
> Date:   Tue Jul 8 20:23:06 2025 +0000
> 
>     RDMA/uverbs: Add a common way to create CQ with umem
> 
>     Add ioctl command attributes and a common handling for the option to
>     create CQs with memory buffers passed from userspace. When required
>     attributes are supplied, create umem and provide it for driver's use.
>     The extension enables creation of CQs on top of preallocated CPU
>     virtual or device memory buffers, by supplying VA or dmabuf fd, in a
>     common way.
>     Drivers can support this flow by initializing a new create_cq_umem fp
>     field in their ops struct, with a function that can handle the new
>     parameter.
> 
>     Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>     Link: https://patch.msgid.link/20250708202308.24783-2-mrgolin@amazon.com
>     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>     Signed-off-by: Leon Romanovsky <leon@kernel.org>

Oh! I completely forgot about that, yes, that definately needs to be
used here too instead of reinventing it inside the driver!

And Jiri is correct we should do the same work for QP side as well,
the patch looks reasonable.

Jason

