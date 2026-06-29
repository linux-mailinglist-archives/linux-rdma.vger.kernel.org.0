Return-Path: <linux-rdma+bounces-22559-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WRPmGGCyQmqD/wkAu9opvQ
	(envelope-from <linux-rdma+bounces-22559-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 19:58:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA876DDE84
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 19:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=XA9spOGm;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22559-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22559-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 589D3300B1A3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68837B407;
	Mon, 29 Jun 2026 17:58:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D02F8E93
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 17:58:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755931; cv=none; b=kdY79W5CLG/c6+/pr4cRaAJKE3JaehbxwvS6mPzVQvlw9Sc/R8PmSDYCpwObz7y39hUcZrlsV/MIKZQfOwy5dnWrDSr+EY19LTAU7k5ifIO09KtT9WMFnaLhU9PMi5yUICW5ROw15rlhVi0/amXir2lznKrui2QcgTjod0tvjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755931; c=relaxed/simple;
	bh=cfj8xZW+ENqyJ5Aw1O4c6Xzdac7jp2Sny9FvroMWf+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COFK46u82N+1wJDWTjNi2a6wacC6Okp6ACvWmM2KO14yCPoMQq81NGDoyY49qemOhV3snvCU0vXkEH0yn1yhLb4RdTCSa7pjRlslGavVh07Fn1l6BDMMq0EKnJlO5Hgb6046q/YIK1ILtaotN37lMQ7zMvvgQKxLWOGE1sIRLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XA9spOGm; arc=none smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517dc520840so40100691cf.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782755929; x=1783360729; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qHmWgOfoGwgBZNg6tE2OO8VaVrcfKYVyaxbMNcKoGEY=;
        b=XA9spOGmP5KMWeUZDBLi982qKYYwbPmOKKl6h8rKk1TY6NdNENeQRHwDlupVdTf7o2
         x3CJ+MddWdsEt8b+N++F3LvhLycHT/jH5/B2k39lyabALJ4bwR7Kro8Sz8bmbi+dG6iA
         ceb47nfzyUnP/brdAUiIZDsGl4pryBsMCo9W3XBNFHT6Qw7XfS5sdkIbQ+JH5bUkLmnW
         YS+MlVL4nTRm7Tweh0b/I8nnTwZ5FFOzvg8NSPApD6BfTbe+XkRbF8atdNFukU+c0ReW
         amS6fvA7yqKJ1va+MFIbWUV4crF/PzY8rJ/hvldRJ3n7HDJvl97bk3dNqKlpDfMXyESv
         LZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782755929; x=1783360729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHmWgOfoGwgBZNg6tE2OO8VaVrcfKYVyaxbMNcKoGEY=;
        b=V4WnJrmJThuya+ccJp4B87nJja56OOEcPhGZ1VhUSWj5bASi/K+7QceEgxuArFRDtS
         Bz6z77zIVcD04b2o8BZYcLHnU0iSoLowaEbAFGHRrBhbjVbOnNSuP80A74s76xo8Idqr
         yK6kiopayUpN6SEP9rztB2uagiymAdIaEFUoM4mv6xfKyGbMpyQCOS/VN2xOeXDILYDY
         fwsm/zcDXO1k3XGEWIyQNKxHetNR60rAAoxW8Li1xNSsz44Uv80LrWejLLknQ1rqmX10
         yQiV4BX+UsiHUosGt1WGvjmP+z+QNsT7pSDcXWF7s4nfo+ZX3hDNGGHkXKbBWccbOd62
         tmSA==
X-Forwarded-Encrypted: i=1; AFNElJ+jIPCH0IVE2sFEwC3BjtsQpq7AiUO5QpatxW3Jx2CmEiS9ULfvL5SghWjHj/ZwCP9ucAp1m8cNMUtI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/NGR/HgsJ21J7qAa0wSE5gXQvMN73ReMaEyX1SXcl9+53PLMG
	4ZME3jnRkyhPNcqsDg9Xs99gxT4cnGlvxl9oEntwf8YZzGnby0ZeAFPXOd4CsXl3c/Y=
X-Gm-Gg: AfdE7cmDqDmWBd1Kt36uSL4Zs3Jqvb/LKdEi1AcB98yrvX6bpLmkghSNwaGlYwFytPB
	Cw0gAwQaZT45644IJKjKqwE/n7in6doz1ylJNMtfVKXTGaH+LQ1uYEpHz7UoYfN62Ot9kelCOQw
	ww/tFBNsyk4dmtThrILDhsG9aH6Iz1db5knt8cpA1xlp/U4azeilVppag/gy3MCCeYas2NkRG9C
	PyAQRFYeGkxLCxghj4C1qhbA9RcURCD9HhpwShg5COEoHXL652yysk0LsqezvE7UOWWfxpsb7tb
	DahjJofOqL77PJp7mgzy51/XgHXdYCb4BHixX5IOydcz/VLLcHILtQYlcoGggkGE16j7qwRPjiy
	4xobyg2z1N2R0Bu5vitTBM7Tuu+cWMavEaXjILIYTqM8GYIUsbQWh5J0ydCxw/+TX7WmkCW3EK2
	MLr/BFFTFInvAblxR4BpeMrwHkdZ4yrsUht0sGixp8rvFqI4QUF79lWmJB6Zy22dCdW/E=
X-Received: by 2002:a05:622a:13d1:b0:517:9570:c1bd with SMTP id d75a77b69052e-51c10751f1fmr5467841cf.25.1782755928927;
        Mon, 29 Jun 2026 10:58:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a7b26b2csm3323366d6.45.2026.06.29.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:58:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weGFr-00000000OI1-1pXE;
	Mon, 29 Jun 2026 14:58:47 -0300
Date: Mon, 29 Jun 2026 14:58:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Douglas Miller <doug.miller@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-next 00/24] Migrate to hfi2 driver
Message-ID: <20260629175847.GA7525@ziepe.ca>
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-22559-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:arnd@arndb.de,m:doug.miller@cornelisnetworks.com,m:brendan.cunningham@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAA876DDE84

On Sat, Jun 27, 2026 at 12:24:54PM -0400, Dennis Dalessandro wrote:
> While sharing similar bones, the chip for the Cornelis Networks next
> generation fabric technology has some fundamental differences that
> resulted in a near complete re-write of the driver. It also does not
> use the private cdev interface that the hfi1 driver exposes. After
> discussing this with the RDMA maintainers we have decided to go with
> the approach of moving to a new driver and declaring hfi1 obsolete.
> 
> It is desirable to keep hfi1 around temporarily to let user APIs
> catch up to support access through the uverbs device rather than the
> private hfi1 cdev.
> 
> This driver is designed to support future products as well.
> 
> This series applies on top of the rdma/for-next branch.
> 
> This series will be followed up to pick up any remaining changes from
> hfi1 that were not yet incorporated in our internal development tree.
> 
> Changelogs in individual patches but the highligths are as follows…

You are going to have to go through a fix the relavent sashiko
things. There sure are alot :\

https://sashiko.dev/#/patchset/178257721001.371918.6610421101075283586.stgit%40awdrv-04

Jason

