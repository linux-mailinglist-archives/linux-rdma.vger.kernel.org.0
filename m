Return-Path: <linux-rdma+bounces-14620-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A3C70BB6
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 20:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1491334462B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375F3313281;
	Wed, 19 Nov 2025 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NTPgy5kE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22A23D28C
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579172; cv=none; b=Ppu2CsFpyHfZadqSh1MHce/xdgJQEc0tAjE7ReJDersjdbfie1Qzrt9NtFzL+AiYAsDEfJK/crM2Y3886RHFu4t8n0yEvTcWPMgKv+PV6EZc3mKGJ7+fAVkDcdvzYisQNPj+Y2lmH7J2rMAUGv5Hcdvf211rpcJsmolP8zu3eEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579172; c=relaxed/simple;
	bh=GlONXAcY3Eus9QPRs9eOdxIqsFi/VV+7r/W7fq9Jw0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gad7+7JeHIzdq3dG/xQzFJx5ZUimJsr3lXSutSJfWrcXSSuPe7YuLpx/9w3Dqf6pFKDA8wj5ceIRzDM1k5pootdSM27nntzMjCqBflhM1QrO/EAW9Q2PSOwYf4iOAr0phHlZCk1ugFievS28SNHvGI/thsll3VcIXhAux3kiMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NTPgy5kE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ea2b9631so5914785a.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763579163; x=1764183963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCzFtOBY2csmUj+JFvTdQCjSu+SL4hQeffYtn3ciK78=;
        b=NTPgy5kE+9t6SWJUi+lMMytJ7pPXk1QSc3z49zHPE5RifsfMAwzQH2URaZX1ztcBWn
         4l7eo1HIyp6S1SNolBfHk1NMivMioc9Pqpp0Hvsf256Ik0sgr2+Gj5SJhA+oKBA9NOjm
         WpURVStUgTJUzaMpjPrY2hzO7TH539d7vkf6MZ9upGQKvep85ZVGyogGJFzmo9gA8/35
         auoRk4mBR4wK2mKeimfnI4IfdgoRJZZxp8A+X1dpSR7byLQCBhXPbMsy21GR2S0gQOSU
         lcX0E+PJIJTcbkEjn2qYS51FaBm4wSuotd3uwlVYF4HosX16EZBgOW0JU1Vjd/+s43Oj
         jA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763579163; x=1764183963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCzFtOBY2csmUj+JFvTdQCjSu+SL4hQeffYtn3ciK78=;
        b=NSGWca1E+mQQc8pPmkmRo5WdoFW3ff3tr94PIZnWKhAkAFMRKtC7m8XshX5YP5Wf5v
         aMz+/SylwzNwviLCBkX7yBfd2aYpEm9V1bcA1dmO3oOl+IQCLf3twqtd1PWWFoMmLtUw
         UXCQvBgxobEUPMoaJeDP9U+j5mGmD3xCcZo9N6Rt7tCthDhNfeqJpGWQtOITxRPg2+Nh
         oiG+rMJN+fZsX6KXXcBOZE39mrHe+uN6j4L+TWm50RB5DNMRjTSaathYIq4MAsarAoyX
         JU50L6ifC+lrpvXAA7aABabmp1qgK2liyhkFxbYaE0AGRztjHE2DDKt6vXgCzdfFZLBO
         Xpqw==
X-Forwarded-Encrypted: i=1; AJvYcCWjMvuhcQCljhf6mdPgFKiRyukMcCZCmXFapLbQVVAJ6x1+9F4Omm8RtoCGH7QSzYiBwS8GoUeGYGW7@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+FdkJHgdPosTO5C30cRgLEvrYw/hY4Q+HgLWcYyIRFis28aR
	61d9YaKwdOgMHl7rscFOsrdjjsGtitbek1axMNybDIa3BhzQWWLXfJClU0UYjaPdurdvFXW+kxU
	xN2Ff
X-Gm-Gg: ASbGncsG8h8IbDGc6AvxrEeDzcYe6yxY7w96fL3FNQJVSOACnwYsbuEWDQa45AhTmHW
	QntjDkDXvyt0Opp0YVikkB/AoxMr+5af61H610f1HITbpqzd8OvmMho4T3Yp7X+/xiOeXfKcjkp
	0z++RRVprbnm7ztQhTL4fLec7aO7i12RyADIsCPugkrDV8gFV4AR0c13xfDoldICqBy/p6arKs+
	JPphwheXrBXydsWHITo5cQ1Fg4gZmVu5T2/rk8yORboGdO2EmD3aGDpEKDBlO2tTQEgEbeCkPzr
	f8+kHaHeTjQaHFdeeNnZCkX0xI2SFrQt8QxNwkAVSGb2EALEGXFVMMauOabaAeDqYJYdtgZcp82
	RpShKcT2LoSvTyIo80w/FJlOAtac1yVhaZ4zRtOYdN8wWpUyIgaTRm+yKb1XdLyV+753gSyTN5G
	jkMMQIh7cgejYI773ahzz/6iCG3pzLjpG+KV6qKv895/c9kis2esDtTD3bNEqxCAPztIg=
X-Google-Smtp-Source: AGHT+IF4bEhu4umK9J0xfxV/sqWc24d3JM3MVPEb3VuRMdOz+amDiFa7BQ3oMM2POZGhGQU22LhrrQ==
X-Received: by 2002:a05:622a:188a:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-4ee4949b722mr4776111cf.35.1763579163334;
        Wed, 19 Nov 2025 11:06:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e469825sm1235856d6.15.2025.11.19.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:06:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLnVC-00000000bQB-0jDl;
	Wed, 19 Nov 2025 15:06:02 -0400
Date: Wed, 19 Nov 2025 15:06:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	"huangjunxian6@hisilicon.com" <huangjunxian6@hisilicon.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [????] Re: [PATCH][v2] RDMA/core: Prevent soft lockup during
 large user memory region cleanup
Message-ID: <20251119190602.GN17968@ziepe.ca>
References: <20251113095317.2628-1-lirongqing@baidu.com>
 <20251117174738.GE17968@ziepe.ca>
 <02011baf337649f6997166f223417417@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02011baf337649f6997166f223417417@baidu.com>

On Wed, Nov 19, 2025 at 02:03:20AM +0000, Li,Rongqing wrote:
> > > Fix soft lockup issues by incorporating cond_resched() calls within
> > > __ib_umem_release(), and this SG entries are typically grouped in 2MB
> > > chunks on x86_64, adding cond_resched() should has minimal
> > performance
> > > impact.
> > 
> > This is not true, I think this should have been more careful to only resched
> > after larger groupings.. How much slower did you make normal 4k unpins??
> > 
> > Jason
> 
> 
> I don't see this as a issue for several reasons. First, this code
> path is not performance-critical. 

Yes it is!

> Second, the number of cond_resched
> calls added by this modification is identical to what was introduced
> in commit 928da37a229f3444, 

No its not! That loop does entire batches of pages into a PAGE_SIZE
memory buffer, this does it for every single 4k page.

> any problems. Third, as seen in commit 16c610162d1f1c, the
> cond_resched call rate was reduced to once every 16 packets - our
> current frequency remains well below this commit.

I don't know what that has to do with anything here

Jason

