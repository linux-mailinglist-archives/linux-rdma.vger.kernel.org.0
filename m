Return-Path: <linux-rdma+bounces-19338-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cACHOidH3mn+pwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19338-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:54:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7D73FAC65
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A5FD3008C18
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB342D4B68;
	Tue, 14 Apr 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZK9zlpIT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333022FE0E
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174883; cv=none; b=QfkrttSSzbpq0syLok+dDs7wpbO7bSWlrx70aXzqXBfecUU31nlUlfJ+1oIPWNj6wQ2TrgZp/hkElhdgPb5GIDwMEikk9hB5ED3aMNbWuhEMCWm5HpuV1fVpBchmVFgimp9OU0KwilxmimSny/l7FXabQ2wY0poeTUQVpHYQ3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174883; c=relaxed/simple;
	bh=G+F8a2Dox1LUQq9c47mjgMJF9DdjsltH836l4nOFKwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnRLZXRtyzG1vCmWNvgemRlcIGUNCAK+WJCNB5qNirvCwcJ6j4p07b0+jqiv/zP4qd/aIn70AEsuewZ3LrQ3zUneXQ9XXro4iP57rC2FW44dvpd3aHIhho0Gu9mU6lzsqZJ1/fjbAwJ/9aBfKO4RmcTcFUr7DJVckPnUD4vXjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZK9zlpIT; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc085395fso539652085a.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776174881; x=1776779681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+F8a2Dox1LUQq9c47mjgMJF9DdjsltH836l4nOFKwE=;
        b=ZK9zlpITI8EgLihzTv3EEtKixgGsr2I7e9TOS7gbCiQhVub8qfZKTOSRS1nK9PVOCh
         UihwyHm49HI+ZNSTtNZh2hdWlqnl987R1TwgRFVh4oQse6iwCIazE7leWPaeNhxKH7XJ
         19uo7nlLTYXt6M1cDKv3+79OPEcPpFRWG9TQza8NpItzSwkYIck8SGIyv0ekYhiatpO0
         6xvQT5s3Mnbxi3HLIg5e2DMuT8fw7MC6bSzM2V4ipmUDlb7zBpGgmrF9l6ae4S4PKao2
         ZhE6+iSHHORItO0G5DG/gz/w9OUuy+SnmRbg02lGHTTKqXPQIjKD5QDXq0eCteWEiAMB
         +R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174881; x=1776779681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+F8a2Dox1LUQq9c47mjgMJF9DdjsltH836l4nOFKwE=;
        b=Iv72ceLHig/WSnXU+ikyFnNCcyNEAxJkGhn7D4lv7y1f/0dwOqJ4fgHnChApgVPFcT
         YsNJEVgqKtIVXMHG/+IlPntkHJWGXzId8K7yFAIX0o4yO5VNr9KJ3i01x/8BsJxzFzWy
         6ubH+vqrhl42d2ZeFz6hwDykK5csFgp9kjiXlZZymAMX8Xm5HV1IYMAb2yNZXm4W8E1W
         ozK9hRkaZLVaBWosVnmZF8ADwAeCkJrziUfBrCmOBAXkqFdFRZC+GxIhbIHyqpKflEh2
         /FW9t1c2jpebncxDlV4qK5bFiLl4C7d3Cvbf9siwJZvAe9X9am4R+ZDZ0D7HUqmG4I6F
         YivA==
X-Forwarded-Encrypted: i=1; AFNElJ/Fr1L++UkveVBsHb6WKOpsaJsdriImil+D/QDqkCRPpQF0874fXp7bq+OdlcGd65ROMYpCLvxFUksJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZLqtEp5WyUE9mRnzZtOai6YSJXJPBu7ECr1iF+bGYiSWi0Y9
	C7rWUQyMyLWmIHhr1MOI0iyxEBmCcIrc+aI1sp9qJe4JruFVRC4CsdIMWgSOT1xr6xyPmkFEKpR
	JS7va
X-Gm-Gg: AeBDieslGJz6E0f0366of+G5B457cEmcvETDkn+q6tav8GMMuvF+8IZQ41RoarNK9DV
	FXPgsPJXMePEwkZohGSMFE+wrha3ayEZwKAqV0H2G+0lz4RQU0PqICKW8IzjFwsx2w7CHvn+NWx
	np3RiNNuXwEdM8hZMpVqQHMkFf4vvxKuSZnLCINsRnTlC1mz3OaHWWVbyoKXiuqjnT7bBDw2uJw
	72Ks4OAgcu9fWWmbw2h+S3wENohk9ZyWuqodRR6dK0rn8qjUDCpeoiYRLR53yKpP7VJaD/tgXlz
	brHLhVX01wU12ptyFzxktWtFd0LkN6fchZiLqfSC5o50NKODaREToikI4N0Mnl7jlPmOZYHh7sL
	KXQwTketWgecXiVaIiOEfMpb+1mEUQfocWw6PXDyDXOqCHF+yuxpD7tFwkUDkvD3Kt4MzrQUVej
	hpMCgIsLc1p3obl4izjoOvp/+qSHYPnAL983ag4zxVkV70h8iFzpWVcuCiTAx67yALH4mz42A/C
	6+Vewb/JKjqarZG
X-Received: by 2002:a05:622a:a6c3:b0:50d:8727:b1da with SMTP id d75a77b69052e-50dd5b7ce21mr218219851cf.39.1776174880866;
        Tue, 14 Apr 2026 06:54:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd550036fsm105167631cf.21.2026.04.14.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:54:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCeDu-0000000B3Ha-2b0M;
	Tue, 14 Apr 2026 10:54:38 -0300
Date: Tue, 14 Apr 2026 10:54:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
Message-ID: <20260414135438.GC2577880@ziepe.ca>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
 <20260410152752.GY2551565@ziepe.ca>
 <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
 <20260414123434.GX3694781@ziepe.ca>
 <CAHHeUGVTsMSCrVQ2uSa4_1DfctNYL7Cy2y2QRPF67nW0mPFXzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGVTsMSCrVQ2uSa4_1DfctNYL7Cy2y2QRPF67nW0mPFXzQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19338-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A7D73FAC65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 07:10:41PM +0530, Sriharsha Basavapatna wrote:

> > Yes, and it's fine, you added app_qp and the only thing it does is
> > check that userspace set VARIABLE. Why?
> No, app_qp (boolean) is used to make other decisions too. It is passed
> down to other routines and all that logic is in earlier patches (2-7).
> This patch just enables it.

So list what it actually does?

Jason


