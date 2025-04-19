Return-Path: <linux-rdma+bounces-9604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02781A94396
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Apr 2025 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3679117DC73
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Apr 2025 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99AA1D5141;
	Sat, 19 Apr 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="E7RzjPvu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA9647;
	Sat, 19 Apr 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745069291; cv=none; b=erFzAkrcvAk6/tjLYi5jSREJZJMYq3F/SL92wQnT2LY4zAHl2siUyPcxmTkzTyiQjt2CAJfgFuj+AbYgKuqmC1Od6UIE9D6JMUmB/wfFPIowKnhzWN7ZTL6zCiTXyTkQZJTg78/gOOV4WCAKdiyA3YTZjzXvnFc08CrQtQ9m2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745069291; c=relaxed/simple;
	bh=9+MUCOkMNe7ZGVgFobC7L30f9g9LsTmflVbc/x2KK0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJGMt95heb8z9TDTfBUvuh7EiGS9qpWd0w3QfOrWTkvSRdyBMJMObqVoGmoAC3n3izUu8hTIybjbGYWNW59x4lnk8C+z6FgGi/xiczGr00Ms1yatnO1d6JysAUhB3qd8cwOHYt1XwgFCmERDEExO2Ou2MRzjS6FxppwqXBnvwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=E7RzjPvu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=sk3WbHpmlLdAK/d30vMNt7YLt8OIuLlvE8a6+eKsOuc=; b=E7RzjPvuH7p5UObn
	Onai09uGmjku+kCixEEtoGp0LoAr9+VGZ0dQDkdssdfFao2XsM0gWJuv7mXLdu4kgyWOEdenKa7jL
	KCh9xbwj9MRIZmY5tTQnfYONspaHmlUypOc8SCZkPlEIoWNw/sBHr//BBZH2EUh5SCT1XoBJ533qj
	WQIGSmeXRH9Yw2uwncJW8p5qFnKX01mBl2ovZgdDDw+jPSk9fD/2QOx1AhLxsqg4i+xQ8I2v2hUMe
	I1nLgL6y911kBUGhuqTVu2SnqI/YtCW5fpcuckR4JWBrtBJUrE8IKB80obV8W8SSdq7ivwA8kuAel
	AwKl0F5Y54WXiqUwPg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1u68Eo-00CeU1-2z;
	Sat, 19 Apr 2025 13:28:06 +0000
Date: Sat, 19 Apr 2025 13:28:06 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Remove unused rxe_run_task
Message-ID: <aAOk5iI8oyatlz4R@gallifrey>
References: <20250418165948.241433-1-linux@treblig.org>
 <bf07ce66-32e8-4069-894a-7eff120a07ff@linux.dev>
 <aALsrZxAqhwxDD7d@gallifrey>
 <7ca8fd94-da46-40ad-8ced-31fe033ee100@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ca8fd94-da46-40ad-8ced-31fe033ee100@linux.dev>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:27:51 up 346 days, 41 min,  1 user,  load average: 0.07, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Zhu Yanjun (yanjun.zhu@linux.dev) wrote:
> 在 2025/4/19 2:22, Dr. David Alan Gilbert 写道:
> > 
> > Hi,
> > 
> > > Thanks a lot. Please add the Fixes tags.
> > > Fixes: 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")
> > 
> > Thanks for the review;  I've tended to avoid the fixes tag because
> > people use 'Fixes' to automatically pull in patches to stable or
> > downstream kernels, and there is no need for them to do that for
> > a cleanup patch.
> > 
> > > And in the following comments, the function rxe_run_task is still mentioned.
> > > "
> > >   86 /* do_task is a wrapper for the three tasks (requester,
> > >   87  * completer, responder) and calls them in a loop until
> > >   88  * they return a non-zero value. It is called either
> > >   89  * directly by rxe_run_task or indirectly if rxe_sched_task
> > >   90  * schedules the task. They must call __reserve_if_idle to
> > >   91  * move the task to busy before calling or scheduling.
> > >   92  * The task can also be moved to drained or invalid
> > >   93  * by calls to rxe_cleanup_task or rxe_disable_task.
> > >   94  * In that case tasks which get here are not executed but
> > >   95  * just flushed. The tasks are designed to look to see if
> > >   96  * there is work to do and then do part of it before returning
> > >   97  * here with a return value of zero until all the work
> > >   98  * has been consumed then it returns a non-zero value.
> > >   99  * The number of times the task can be run is limited by
> > > 100  * max iterations so one task cannot hold the cpu forever.
> > > 101  * If the limit is hit and work remains the task is rescheduled.
> > > 102  */
> > > "
> > > Not sure if you like to modify the above comments to remove rxe_run_task or
> > > not.
> > 
> > Would it be correct to just reword:
> > >   88  *                               It is called either
> > >   89  * directly by rxe_run_task or indirectly if rxe_sched_task
> > >   90  * schedules the task.
> > 
> > to:
> >     It is called indirectly when rxe_sched_task schedules the task.
> 
> I am fine with it. Thanks a lot.

Thanks, v2 sent.

Dave

> Zhu Yanjun
> 
> > 
> > > Except the above, I am fine with this commit.
> > 
> > Thanks!
> > 
> > > Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > Dave
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

