Return-Path: <linux-rdma+bounces-19529-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBvZHw2B62lLNgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19529-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 16:41:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D377E46052F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06EA53005D13
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06903DBD5A;
	Fri, 24 Apr 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gk5/578C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018F1A275
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041423; cv=none; b=Lz6OlXX1Em2TRVO1e7ao5xIrxuKeKusrkBEZa/sb1GWyHkjt87/pS8U3CF6j9IAmYhxDv1xje35QtTqzxFmtaZkDSUbkEywVkE2FOr0xZSVccayl6TS6oyk3akKHfvt2mnU1/Sxu1TsHuMnUa5KZxT3VesOJlzHjjw7CK3Dpq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041423; c=relaxed/simple;
	bh=76nKh3i23EjlkNzmH8d9CYaZ2dV4o8mzFNlCMiEglmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ/FA0vSFzCwgOXojWEq84qmE0ZiBoZ+zpVfRN3UAGAaC1ZcxlLtFVm/Evdi3l8gGKffZ4ayDVht/Rs2wjUugozc1m2k+NAvOTTHllTCXicyAUu15nv3DgJsgQTfCMgaExh4qNIvsYchuSlyHmTkB6aT8XaVDQvDI9Qf7j+doKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gk5/578C; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-956995b5bb6so2118364241.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777041421; x=1777646221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVxwU9yFbi/K4Jo+cFGOYYQkit0NaUdDkbPJRpS4nEM=;
        b=Gk5/578CRAcaaLpC75jMJb7ol6BQfDgskLaQII0tjPWyWhLVHVJ7/gECYEIpVexQgn
         tCnZ3DGgjqyrXLkVe5PSuwSfL2TuXD7ULjZ9KJ6yv48Igssbn1WiQXa25EVrY+m00SR6
         wbA67PfYWLwF1RNwlnpgXFJSz1Xuvv1gqAOrkRXrjmGhB81LEmr69kqzReYMn6x6HlEA
         7CA4yquJyDRPDp3TT7lSHXKCPUvsQX62dR5MUdxUPzm5KHtZTwbTZObHeVJNwFVa1PVS
         EHPCDQKCwKGUIhqYWqI5DWsNiECYG3O/1bE2Dp5HwJo/+Oy8y5n/HCUO2sJFVuI1Dj/T
         cuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041421; x=1777646221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVxwU9yFbi/K4Jo+cFGOYYQkit0NaUdDkbPJRpS4nEM=;
        b=LDHcV77gmzJ7SBA4QuZGrvMU0nEws21IamdhPVFVDghdi7zpjrANYAP34B72XeNJyI
         CcwFdOBNwd+F3oGZZRmky0NnlaNiOc3/uzuACtUZBWeOZ+ewI7laxmjFYdPFbVx0gGk/
         9FYz9wB3O2ZdiMnELqtjyYKjZCq1f48+VonLsgywMFgbkhdKeqef5UH2Bns4dMemE/QS
         aZIJbQA43NFUD9YITD+f1ylp5g4ZyMTCeuOCHtMTDqFisuSNlTmCCnX/pYeE+IspA0jx
         HTU3NSS621Ho2q6at72NEkkKS+Lstw+9q4mmtTL6fvguX6BNMVtWbfKBPv7Jjb0HLQfU
         RnsA==
X-Forwarded-Encrypted: i=1; AFNElJ8eJxLieYVXFkWaCiWyDzFifRhDKLTPpGdrPOu9BGwsyUY80kE0jM05EURLUt22BMmKklILhVbXWoMM@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQESbWOVPWLaB0YxxP0Ok4KsAK4PglotxRzKagAYk5et8wxWJ
	gmpuz8KamKV37HKwM53eRXCB9TTk0PUozs24eJanmWvbnxOqBpYIVLYeHULf7uja6iI=
X-Gm-Gg: AeBDietpnHL4AH911QRTASYsziRWab//0mK7AiF/TmCoUSJtcQ78AjCf3inr3WjZ60U
	6WPsABvDk+B7tf7wwJ2wQun+DQh8EnKNjiok8wFvkvnvNNJiUAnN0VtXueieeYQLMFU2LUFWOhZ
	xYIO8q81Ld0j5VwDd45KlvkHD/aiXrB83nBQwCIupqr05RbWIHUrcJYu5QQFcdOQLUyn0xd4zJQ
	Uw3G+mSF6u9zJgQFzb8QMIOhT7n2SGFlkU6D9aBb9APpWY+71A8o+rE+ZuI61NZkP2N6zMTBUOV
	QphGeXm7Nh/3EmU2mkPnePE/dgDwFA92OCgh4YDyoHC5ZSNtNlEpmOyb7L42qzVODKQ2waI2Ox7
	YMC4mnJ0tu1boZLtNOVFfoSAH5qyne8lyZYiwkMmRd8ueID6qMVaVXKCW7vQEQgrRto1MzJHj30
	M7i1/zSMt6HJLYxueZxygCjTxsICDUc4YF6auJ6kZQGWte6Qs7L5kWXG96SCYZPUEyuCmcDwQWI
	hjzj8UCLfWISgrc/xkj3yLGKlI=
X-Received: by 2002:a05:6122:3a0b:b0:56c:d66b:7516 with SMTP id 71dfb90a1353d-56fa5a2c0e2mr16382499e0c.13.1777041421200;
        Fri, 24 Apr 2026 07:37:01 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae797eesm185484816d6.34.2026.04.24.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:37:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGHeN-00000002nvW-43Eu;
	Fri, 24 Apr 2026 11:36:59 -0300
Date: Fri, 24 Apr 2026 11:36:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Jacob Moroni <jmoroni@google.com>
Subject: Re: rdma-core user space irdma
Message-ID: <20260424143659.GC3611611@ziepe.ca>
References: <IA1PR11MB7727AFB5228A90E1C7115C21CB2C2@IA1PR11MB7727.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB7727AFB5228A90E1C7115C21CB2C2@IA1PR11MB7727.namprd11.prod.outlook.com>
X-Rspamd-Queue-Id: D377E46052F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19529-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]

On Tue, Apr 21, 2026 at 05:32:50PM +0000, Nikolova, Tatyana E wrote:
> Hi Jason and Leon,
> 
> Could you please review the irdma user space PR at https://github.com/linux-rdma/rdma-core/pull/1640 and provide guidance on how to proceed with it?
> I have rebased it and the required kernel patches have been merged. 

Is it ready now? I admit to being confused what its state is over all
this time?

Jason

