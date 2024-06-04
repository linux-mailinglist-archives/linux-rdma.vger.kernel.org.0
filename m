Return-Path: <linux-rdma+bounces-2854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B78FBA7E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892CA1C23C92
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63914A090;
	Tue,  4 Jun 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Qojg0c/I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA24149E17;
	Tue,  4 Jun 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522382; cv=none; b=EXLXBsXn3RiQh4bUTOOQSmgvbSvBZMMQxpcETPl4J3p/K9vVWDRGPUYLTGCx1T6a6ko9S3HOywyQpIgMqXYMZidAHneSHM6KYmW8MRGM4sGwwzUl/wb7hr6LxqJAawyLmh+ZDgN6DykTqRjl4c80M/5MObcKPbKu9NiuCrTBXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522382; c=relaxed/simple;
	bh=RzABj9/ViIb/5cWbePvdyBm+IOiixikDKivx+zn+Jcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX6cq5UDNmBI987WDH9s2YmY+NDJg7updDl4TjDCyTnCksTXBFGEOhh2stKmlTfT/nx1O1C0MIlCbnyq9EldbVn8QQVWtMDfSHJ6IAF7aBhzhgUsgEavsZEcdH2Xj9ndW5qQropsiupgQ+f1DpXWWdi4RRyLjyAdw+RLwjLh8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Qojg0c/I; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=OQfWHf3Pvts+1g7ugAMVKgzKYiTfpMZo3slFDwJYOlU=; b=Qojg0c/IKr7DG6Ld
	3vj/LAbX1s4ktiSlviyC9s9xh8E36PX4nKFr4BPPvkjTfPuxbx52RPgF7aY4D6UGcNwYOA/rkvSW2
	ZPzzZFYQiFabaK3RsBrFsx0fmgnPaeGi9Qr8G9hysJKYEW+E3JH6WFhOmmkQNybSOsI5Ko2OhcdNG
	LiS9aH3c7KOBwnPdwr7fgStytaYTufoeNep0PhV7VPWAWLRS6jkkrx3p6mJqeLs+DqHQgCeS3CRu+
	PGoan0Tyi8WdgZLwxIvmOtvOKVsCoLvFDeiXyjJlWmvnccF4JzJualDYC+K7rhiGeew/HApxZ8lUk
	XLJikqyzbdmftAxAVQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sEY1Z-004FwI-1c;
	Tue, 04 Jun 2024 17:32:41 +0000
Date: Tue, 4 Jun 2024 17:32:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Simon Horman <horms@kernel.org>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Message-ID: <Zl9PuZUMU_9bUfxQ@gallifrey>
References: <20240531233307.302571-1-linux@treblig.org>
 <20240604170802.GC791188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240604170802.GC791188@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:30:45 up 27 days,  4:44,  1 user,  load average: 0.08, 0.02, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Simon Horman (horms@kernel.org) wrote:
> On Sat, Jun 01, 2024 at 12:33:07AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'rds_ib_dereg_odp_mr' has been unused since the original
> > commit 2eafa1746f17 ("net/rds: Handle ODP mr
> > registration/unregistration").
> 
> nit: Maybe commit lines are best not line-wrapped.
>      I'm unsure.

Yeh I wasn't too sure, checkpatch seems to have code
to deal with it, so it is expecting it could be wrapped:

  # A commit match can span multiple lines so this block attempts to find a
  # complete typical commit on a maximum of 3 lines

> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> The above not withstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks!

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

