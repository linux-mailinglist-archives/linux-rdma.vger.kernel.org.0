Return-Path: <linux-rdma+bounces-13879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B6BE03BD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 20:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EE824F3A76
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76791F418D;
	Wed, 15 Oct 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ShH/wgpT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373A145A05
	for <linux-rdma@vger.kernel.org>; Wed, 15 Oct 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553921; cv=none; b=bzzTEmnRNZckQ3NBE92V3ujmtA/K4lphrcJmh1hLsn0VD/iAkFjiIHHYLSYzwKAvLtSTCP2riGsplJDRk80muVEQiXAeOJCK5TqexZynALsnDyFaZx7me9ntoNkjhbrvMpbnOjdNr6lJ8RFxbJiknZ/b/kNCRtlDDFb27z2if+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553921; c=relaxed/simple;
	bh=JkmncYfreq394vWt7ZW3yfWNhxcq0/WE0DneeTjszWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcDgPugi8CdPAUg9hyu6ZYi+Gxi1TvQcq6V+gACnrzh0DTwR/TDiOgJFva2kJq0Z5Hd1L1kKgoNZiPlYyDMmoal7fPmxySQ6/8mz8zxwbA4H8Eu3w9VeGuP1+P5l16muqFTX1nlnrLRJ5+CJXCY0FBlz6mi+LbfKtUCMIyHTExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ShH/wgpT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88e456972d5so183143185a.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Oct 2025 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760553918; x=1761158718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEYZOuGRfIDWR2T00/XK+SOB6yyfdCwjHBg36UpvTHE=;
        b=ShH/wgpTHzEWsLVS+762gZcuoEsPWR2smZvLqRhUumeP8GMWoY6oFWmM4rOKIXmXgn
         CxdVYHznXtS0Owp9dKn22XUxWl0OdzzpfnRBWYfv+2hd+Hk9wdLPiEzju6q2ZRGkxAbp
         QqwwPBI/1XWRyUND8bGbm1XntPRm4YITBeKJywqO+MuDOa0U2loBXjmx4o7LYc99px10
         pAQqpB7Y1CiNaDKVQA6SpPLZ7qv3eSNAu/nuTE8yIWzZb6RABiXcDNfNby3jeFKMAomp
         yAgAeyTEKSVwUYzmQ4iiYBhqQoOXS8C9H5kzhLZxfxp8egnA617S1iIzr0B/awdFFAd3
         fC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553918; x=1761158718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEYZOuGRfIDWR2T00/XK+SOB6yyfdCwjHBg36UpvTHE=;
        b=X8wImWcbseVFYt5bOQwiNINJoHSIULY33tOJ/UgKopwAI8eYZNd2Y7uw/zWvplp4tN
         wR0Y0fwgl+IHgLrrdPzm2hx3SoEWEQg5EChDqbXlWjA3qbLaQAFA73g9Br8ayMayw1xH
         LtF+SyQR2vZpnoVNNyzpm1Lga4EQ8jnQaxo+GALxP7d4rABpRbhbk2saiPWfwsvTFJ/w
         KKNPkG45/kohNGQUI9+fvjxNM5QrdprMsvILdJb5b1jMWG1v4pSUaa/gxtfvbntDb2DI
         RMtHdQ12zbk97i18eVZFvQmjkQP0gsjAoHL3Yd/FOOxkW35yz6Dek1Ctq2HWBxHcnSfW
         LDRg==
X-Forwarded-Encrypted: i=1; AJvYcCWhQTiWWAtywxdRuC8qgjY/DWSJSCGjNWIIuZKDzDZFM19m/1yUltvTBogdVqihT/NgRf7V1cti2zpx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Lzdpr3nYgGDMUt6kwaZBp4a2GpHRh1Sf8M2tznlVTpDIbQT/
	HoNqut7xSyjyhLeU5xf/eNHcQssb6obQnEkmWV9zgUDgdDw8cwyC7Smym7jqAJKE0Fs=
X-Gm-Gg: ASbGncsLKf1KfB8Jwr1FBgyXvktg5cRlpcoHkmLh/b5etaH85w79Al/tMMy/4yvmvDE
	DT5KUIBwF3Fm/JECeyI+kG+Vu3njcpWk2pVHlvfgciWJj4xOujh2EIzGOoLnC/vFBJkl0LZtYS0
	zR9v2flQK+lyFt0jmYRoKtqbwidIx1Z462yQgU2k4jTJDJ7JsRLXC65CdZ5g6vANmvZU52QEd06
	NIANtURvZTO4SDTRzPQZMQidGRLl83yLpbJ+Ng4ugMl8rNBraAL1QYQTaLRwj9ObPnx8PEEjgyj
	KQisjeXQZTvlGfY5Gm2YPZJ93vfdX5SZeV8SpoqoK1PZ64rFHfzJfLCexQ3ZmcuWE5ZWdNOjvPI
	cviPeLmsq+dU7Yh+daLC1ExEUwg==
X-Google-Smtp-Source: AGHT+IFBkVAUF1g083sZyATHZ78uF6leTHl2rEl39CAtMYTJs+M5ig1i8oiIrUDdOJKt4GeIzWVdbg==
X-Received: by 2002:a05:622a:6088:b0:4b3:748:a75b with SMTP id d75a77b69052e-4e6ead91fedmr454909881cf.74.1760553918198;
        Wed, 15 Oct 2025 11:45:18 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c76bfesm23610181cf.10.2025.10.15.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:45:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v96Uu-0000000HVrZ-1h9I;
	Wed, 15 Oct 2025 15:45:16 -0300
Date: Wed, 15 Oct 2025 15:45:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sean Hefty <shefty@nvidia.com>
Cc: Haakon Bugge <haakon.bugge@oracle.com>,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20251015184516.GK3938986@ziepe.ca>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>

On Wed, Oct 15, 2025 at 06:34:33PM +0000, Sean Hefty wrote:
> > > With this hack, running cmtime with 10.000 connections in loopback,
> > > the "cm_destroy_id_wait_timeout: cm_id=000000007ce44ace timed out.
> > > state 6 -> 0, refcnt=1" messages are indeed produced. Had to kill
> > > cmtime because it was hanging, and then it got defunct with the
> > > following stack:
> > 
> > Seems like a bug, it should not hang forever if a MAD is lost..
> 
> The hack skipped calling ib_post_send.  But the result of that is a
> completion is never written to the CQ.  The state machine or
> reference counting is likely waiting for the completion, so it knows
> that HW is done trying to access the buffer.

That does make sense, it has to immediately trigger the completion to
be accurate. A better test would be to truncate the mad or something
so it can't be rx'd

Jason

