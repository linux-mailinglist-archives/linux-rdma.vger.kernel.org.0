Return-Path: <linux-rdma+bounces-16526-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH75L5NXg2mJlQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16526-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:28:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C52E717C
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C98E300EC9F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2429413221;
	Wed,  4 Feb 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JlW/6l3Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5EA3F0773
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215309; cv=none; b=u/lZ0gFYvhxGviSFQ0Xs0nZng86pYxpgBKNZngqM8u5CuE0/zXBQjZABRmF8DG39lXGtNlM7w3EW9Wg8gIUNFiXbnE1QwXUwniifbS3QGwU85wos7gMQUbP5+WfUC5Zm4rkd0wyQBiXJp/T9Goj4zD3Cp/Mt47q3ehndc8+t8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215309; c=relaxed/simple;
	bh=wmna5Yin0q8eNDDb0lVY/0hEZTH8aQ+t2ahLkKvE3MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uj7wY/l7S8vwd0Mb1w9TMm5KAY1ZdAAOO+TiwiXtnzMz6PkiExpBvVjQ1x3VTJEOoYJoNEubfb50jAb5cViHRmHb+W5mZhee2IFlksOsfBb+8kyIVEHuAnH78dlZ73iA4zB+IP70NB1WDzEVU/SASJVA/yz/a+DECC6U2bzU7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JlW/6l3Y; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6a50c17fdso726282885a.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 06:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770215308; x=1770820108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zue+/Z+5SNbnRMTn9TNDprwgc+Q7INcx9msJty1Thww=;
        b=JlW/6l3YcP9tRmSMezABofqgcoy/xeueFulnBuAa3zanlJolav15Poz+m4o4fbq2YE
         Xdyl+np+lFj2FbtJLOEqj1m6kzq5U+xWsYxIB20ffGVnHroB74Lf7sK5Wl7beGZSgwPu
         dXSGU03U6Fd1MGo/qQf/EbwwWD0xGCWYDTY2GMFZMrJwVCHtvuHhHBC2hMUHtzBKUX0A
         PsFv0C2aXmr1MOMkm4c2z7FlzlzDUNtc57DAjuXVyyI5AJKmrbviDAthu1p/9n4t+wAi
         aFsC/zqU/UfvnbnmjkkYiblPWFkfpt5vv51V1KLH/B5kcMuGy+9yOxMQ726B+plj/iUH
         Y97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215308; x=1770820108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zue+/Z+5SNbnRMTn9TNDprwgc+Q7INcx9msJty1Thww=;
        b=H5yzxfrdLUKs/hg43l1CuvH50jdg1250B1DaTImIxlge7kWxOqE7uLzsOcyz8qOyHA
         CQxHQ7MZG312aKHFjcS/cgaZSCQxYNuaYvNRUww8QDZz299STs2/vBtCBuiyKfEzs1S1
         9bNjaMh17047gs9c2o0yw2liuOyVI36JE+RZRvyZYFKoJooYz60Nj8KalbIIbB27b6Yv
         a+33NOCjp+KoArHnN0T1wtpFHzCt64UfDI3KyGKYGJ2ya1OZY6o2RvQWmgRbA/2Ee9mq
         99HbeqHgo29uZJMPbrA7495Nw/HAmSCLXSkqIBWI/i8vrL5r/01ssLMMB01Y5Dyy7ORk
         kiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWt0jEoukTrJwmhBVoq7126nWbX8T4Tu4FxnNOzfLppaw1iZ66Q5t0V3MdEFzv2zh4hlcIC81HL0k7J@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyBRvqeChOHslfsoh4pL5i/xqcDf5sFlRg+1IZDXm3LGuikbu
	lfUrHYLq7VLwJv1EPmtEhkUUC5GHFSfEIp3arKhojb8uGRCBKxbHVAI2FxSDotEsx9w=
X-Gm-Gg: AZuq6aKaSm8KNdxZwCZQdBQPCT2SsUGp9ao2208HjOCyyHO1Gy6OX6XQKmBaOzROZdl
	YPCH1G9UNDIjSW2HLvYPDAFha8GTTivtk7K/PHgv8uj0b6Zl0PcXPEBpzEPFraHicKhZ0X5xrAi
	WvUDA+WAT8LIYJtkw4a6WV3tfPpyzez9nNRr2Q8XTXKy5i7iY8TEjV440c931j8RqFdZ9oWwHR3
	jdmTMfBBkR5Mgx+g9k3KN/kLS1P7Sn6QSsOEM4aef12haoExmI2P4IHbKMlf6Tg256wxJdoLqwz
	KMk3GUWWXdKLY6MygrJGFRXbse6sc5R8qXXhW1BLqMtcghbXTcoT7aHFN1h8cbCvfuc82BvxIHB
	bvuzOup51foDU85dxS6DNig+AeioI3HMXd6GRXn5ZK5O3OA2f3U62kqw77VJVP4IAbf+6uzhRz0
	A7QPEOXkZADupfp1h+B24/YtJtECinANS0rcYYZxIwCEvKa3kPGBH0DgOzEViXX0wu9mQ=
X-Received: by 2002:a05:620a:7010:b0:8b2:e8a0:f4e with SMTP id af79cd13be357-8ca2fa783ccmr360281185a.77.1770215308037;
        Wed, 04 Feb 2026 06:28:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa7d7ffsm208347385a.15.2026.02.04.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:28:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vndrn-0000000H1oy-0Cvg;
	Wed, 04 Feb 2026 10:28:27 -0400
Date: Wed, 4 Feb 2026 10:28:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: return PD number to the user
Message-ID: <20260204142827.GF2328995@ziepe.ca>
References: <20260204135813.870538-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204135813.870538-1-kotaranov@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-16526-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 37C52E717C
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 05:58:13AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement returning to userspace applications PDNs of created PDs.
> Allow users to request short PDNs which are 16 bits.

Why does userspace ever need to see a PDN? Please justify that in the
commit message

Jason

