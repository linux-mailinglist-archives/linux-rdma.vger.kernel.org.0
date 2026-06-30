Return-Path: <linux-rdma+bounces-22606-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IOu5EVgARGqYnAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22606-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 19:43:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 831076E7010
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 19:43:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=g6umSD22;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22606-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22606-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8B9B3046C79
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA73DDDD9;
	Tue, 30 Jun 2026 17:43:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492D548EE
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 17:43:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841417; cv=none; b=qfm2RzoMk1YrTlQTaVs9/9CCYvsYnWiwvRSUn/WsUQ+iD0pHMWboiBqvAgA3/qoyU42+aaR5/yDCqo4ycTJ0Jogfl7JwnJUq0uhIS8oPgaqoeOnwqI933moNq67MGX3ni08Vj1NrnoEh1tc6y3mUMSGLdicoQ5/N94fhAzpSC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841417; c=relaxed/simple;
	bh=cGDjF+1iSntgyov7TuLaYsyN4Q+ZgysmfzqG+Qz59fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbZN/S15Z4qitl8xqboXrOn2RVmliSbxGbblBoy8cJZ+WqZyntEN6K972otVR5H2WJlBAmn5z9lfSjZxVazVFHfOu8uHWF1T12VPwIXicnUBSFrm26+m/90VWBIbflHDxbz4LaBWY9JCv3c2VQcb0mo9T9BumzYWnYzRcHvUccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g6umSD22; arc=none smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c1d487f2cso4640461cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 10:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782841416; x=1783446216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6X+k3UAV056qCFrn+18+ztFYqkBID6NXUzr/C5r1g1Q=;
        b=g6umSD22+BE9xHM2JUWFdjROnFP/xQFsQkkNeJri/JuPJVyZKyG6UceBSRaDDHT1PN
         1sXacXeD/1bBp42QkU4DfODWNohZplZkkG1g0GhuWj+bfaazDVER1+96Yq5DxhF/msNp
         DodwDdTLwrmHkvYMG25R8pf2vPhEGDvT/3KLxENsavUHCl0CU/QzPMOSKwqUvj0XLlJh
         g3ls2nHBeIWWGUaYSj4a9LipBY3uvSDUBTLlOAHTqZcnQjA5duyTzv4rI1LetN+JxPXI
         MHzxiThB5HsXLrs90ulH4GKvebT39PKyffgDMgz6jSibmWBDyAFQLElUwiAQaguF4W3c
         TpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841416; x=1783446216;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6X+k3UAV056qCFrn+18+ztFYqkBID6NXUzr/C5r1g1Q=;
        b=fJHwk2OYbWhT3dwWB5jvChzZwYXdsg8+FCz9yRVEDnYq+A/k9MnXsqNpmOwqZHbaZg
         gzG9PSJ3gBuXE+j9lTiAfsvDGO8c+ptakmIMFMBHC9h6Hp4/V3q56k1vNzV0qiu3DajR
         vN0utlG60tQEjQxoaZ2Pr/zAsql9zxd/L1JnqmfZu+ygJE2TexjmT+bK2bpruCenhvl6
         incn1t4VNJ0wOxN39Kc8C5vqEl9XNIc6hhlrJ1HBK11lmMdWen3WSNI6Dhtpt7Gg4n7+
         0nF/JKs6uyj5GPBJIDKOomWf+/4r1FTqdFkGouzejq37t1ulP/p5+5xhOuiQMYW2q145
         86Xw==
X-Forwarded-Encrypted: i=1; AFNElJ9ydqOQY0XIHEh9uQKueaTn5RHRAi1as8zlK9L+2f2a07JBG+N2byeXfpc9iiENGOVmOYGMT34P9Jns@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OCV/vOe/BrIzKSMJtg5pnF6j745uW3yw3Fu+zFOv5OMd4uau
	bv1RFwLYD1M2d0vLE/tYwrl9pBMeDYUPIOhmEUj5/Y00BtPJ3R0QGMOP6VD3D3Measg=
X-Gm-Gg: AfdE7ck6cukJI0jg3jvKMUrUOQmOghQc/DqCBY4NJPVqdXefHruFbvv/U7dpyH9TNRT
	GTgSG1flX3rvc/zh0SMSyrMZPGboFlY2yCKnCiJR+xYUOrzNre/uMfWNWAmx7QIvqSEYnc12DIp
	c/3cAGa6ijjCiefzgCVQydQF6h/Y/DDI+VQHXDn6QswtCIWb0lNnjeaFbwjHE+sTSeGJNYme9EH
	dVEWR32oBzBKTw8JrN+8eIK46BbZbq+zTF7kBWVbrgxflD5/Qdf0Mi7nW0ZpNFjhJ7ivInu4zST
	rN5Tf2GYnnLDKv10RWuseVuCc1ioqoJuVYRSRT8WvlOBXIJ095DUctd2AvXzL7s5GyQyZLGGrqZ
	YLnuiJhhMnB2Epy5fI16s8p0k2wQL2iGf89lnQdk2wSGdYBOpJ5nvhmnW2CyaDdju9LQT380P/K
	1gF8A96bgQ8YGnDJYN+EiKRzvv+FAUClQHlal9tqUSDb/oGMPQSglVvqlz/LwAAeXSOMo=
X-Received: by 2002:ac8:7c54:0:b0:516:ed02:c85d with SMTP id d75a77b69052e-51c1075101dmr58826801cf.3.1782841414970;
        Tue, 30 Jun 2026 10:43:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1099a2edsm23248741cf.19.2026.06.30.10.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:43:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wecUf-00000002FPL-37Ve;
	Tue, 30 Jun 2026 14:43:33 -0300
Date: Tue, 30 Jun 2026 14:43:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/mthca: Check for null udata during reg_user_mr
Message-ID: <20260630174333.GL7525@ziepe.ca>
References: <20260630155505.1707193-1-jmoroni@google.com>
 <20260630155921.GH7525@ziepe.ca>
 <CAHYDg1TOGxRGZrS69d4Y--Shj_DZv0nJuM73iHUBwBM70g_t3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1TOGxRGZrS69d4Y--Shj_DZv0nJuM73iHUBwBM70g_t3Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22606-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 831076E7010

On Tue, Jun 30, 2026 at 12:04:45PM -0400, Jacob Moroni wrote:
> For irdma at least, I was able to trigger it with a one-off test binary
> that directly invokes the UVERBS_METHOD_REG_MR ioctl.
> 
> The handler in the kernel then calls ops.reg_user_mr with null as
> the last argument.
> 
> drivers/infiniband/core/uverbs_std_types_mr.c#L366

I think that is a bug, would need to research why it turned out like
that.

"user mr" should always have an attrs.

Jason

