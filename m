Return-Path: <linux-rdma+bounces-16074-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLGDItmveGlasAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16074-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 13:30:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A32CE94588
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 13:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E561300372D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64353350D42;
	Tue, 27 Jan 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ltJyof6X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743F3502BA
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517012; cv=none; b=Ivf+8wCWjpgNmtXx95nqnGrKL9I1IL6nBB8WNaNI55NQbc43HUb4MnYsbLls8YRVahbqb7eC3wmOXPbAYfKlFU9EuhsyBax4WJ8I5DQLgqG1Rmvh9iHPMPY0bhAnUcHJ20FwCg5raG79Wdv08p4dJSoxgl61aztImZYENVcb58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517012; c=relaxed/simple;
	bh=gC/Qbs/UjBmEVREaATKtToRZnQ74ATstXDShzpx9DAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0urX5eO1MLctuFokyg4/C6gfr2z0g5LzZnyBHFi2x/H+63rxxgk4DLQ5fIx7GnfI9q0K0Iq4CsuHj5YP5faLMhz8Yb3n6RIGJjgxVh7sNett3RlFQmZ6oA7q3mXk3NaUa1gIze8cxEHh1p9y3ecaE1/gT/yyT9pDpHkwdmfAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ltJyof6X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso57009125e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 04:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769517005; x=1770121805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5N9xujYcbfHdktc32ZLm1wNTUARj0aYDTBM30nfb9I=;
        b=ltJyof6XwRqO9m6WA5Vf3zNo/pM/qyIe4Mh+eJA8Cd7VAA8Plc2OiM+n1IpiJYlYyp
         +D2viUTTEbIqzTlw70X1W94FwsuuDJ6x1LkLy9LeWDr6RKojKpio7VowNTab7qQzUz4i
         JaoyYaaOIxEf2DNBwsxkI46CCFWasSejlEGxOs+PEnYe0Ah3r1FIxU6kmA0g3Hw7lJdA
         XWtXDneLiAJEq6lL3nH9JuJmEXczjWLZ07/DVhaPnpnz+QfSdZnnzmtZLWaqtuMBZQh7
         jW0++llZm5fsbs37qIo4EYq5wL7fYfXDJriRIjUBoLQib4VtjIIHD/VJMmo1Q2nnIAPv
         31Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769517005; x=1770121805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5N9xujYcbfHdktc32ZLm1wNTUARj0aYDTBM30nfb9I=;
        b=iX+FgUCw0LnS8H8UgN/nM+9zVkR2ptfVbv23gkE8qCVaoY23b605ctJigv8tCnqlX/
         71bAd/c4rgIS2nbRMQ7IKT/wFm74r1Se4pAirinGJpb/yuZqY+UPLBGhWTSS+DC9E2c9
         11S2RBiUZFdknZ667JbAMoQX1UiuQiPV4zakUof/J6XfDNJQdEP9m4lhRSjuOREZKqMS
         sfcSk3NQIMfJ8k2lTZv0tHy9EKVlcTLEqN3LZF3H5e4QUh0OpMUIrsu8tmAhAZDYw59S
         xmkkFxIMTAraCUvw5PPcEfaErPzXxxKqOr3rPf+sYdKdh+DAy+/xw33NyFw1MB2GHYwg
         VA+g==
X-Forwarded-Encrypted: i=1; AJvYcCW+geE556s0WK8FkFDjN1OOWzhGloEvqIzDcfEkvxaePmxOqx6IAlcxLdObrtYO//n4YlGsamVhRqEt@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZ0D9ftqPvVL7rB+A9jDNAMX1Gx4JH5dMADalfvHf0IveFVjz
	hFSjuh9Fq23/7PuvcOXMQsF0A92osO7BlfFB/wYtATQ6Xd5OVPTRfX/fiFATVLN3/kU=
X-Gm-Gg: AZuq6aIBxP6eA5yxkM2lrU8CPIKURgyIGy2EYBkIM+j6c0Ao7lBvfU81t8C/MzwidlK
	yI4YLghmydtULzxeWdNsdNp3R3MAef/Uyf3wxGyh5ZoFk5W2o6vJ/joaQDMENt20n+YFYcpVEsk
	VZuNrIANJ//zdrx8QhXr/jJPUfOqhhEFMZlhsXyhslPKLu/nndIu8LjB/Mhm1EN85oHvRMkdbeA
	S6tMP10M87k3oYGPpg5bYI4M2qQjqpbnWbYzvmCYvjBYINHDnHYMv1uJr377bz5aAr4sjxPdfo3
	ZUj4Q99ecxEyvZ3+HF+1/ejcHRxuT0jpm+EbMQvLvC5ciueK8yzVMNiX39YFuVOV2qVE1SiqpTn
	raVyfb3GhmWk/RdQbuIM1fjpcn/n/SyM2ifdWggDjwmqNogmBCVpZXLtm++YbV5j42DZuGeIQbV
	AcBf7twFdb23mc9G/ZNm6tswU=
X-Received: by 2002:a05:600c:4689:b0:47e:e7e5:ff32 with SMTP id 5b1f17b1804b1-48069c6077fmr18198785e9.34.1769517005263;
        Tue, 27 Jan 2026 04:30:05 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c05edbsm61365205e9.12.2026.01.27.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:30:04 -0800 (PST)
Date: Tue, 27 Jan 2026 13:30:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 4/5] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <pynbf5lh5azbblvoygivvzxjcmnvffrtdz5zbjzsg4rccbpvud@277svcow3ra4>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127103109.32163-5-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-16074-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A32CE94588
X-Rspamd-Action: no action

Tue, Jan 27, 2026 at 11:31:08AM +0100, sriharsha.basavapatna@broadcom.com wrote:
>From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>
>The following Direct Verbs (DV) methods have been implemented in
>this patch.
>
>Doorbell Region Direct Verbs:
>-----------------------------
>- BNXT_RE_METHOD_DBR_ALLOC:
>  This will allow the appliation to create extra doorbell regions
>  and use the associated doorbell page index in DV_CREATE_QP and
>  use the associated DB address while ringing the doorbell.
>
>- BNXT_RE_METHOD_DBR_FREE:
>  Free the allocated doorbell region.
>
>- BNXT_RE_METHOD_GET_DEFAULT_DBR:
>  Return the default doorbell page index and doorbell page address
>  associated with the ucontext.
>

Similar to CQ/QP, why this is bnxt specific? I know a little about rdma,
but I believe we use it in mlx5 too, no?

