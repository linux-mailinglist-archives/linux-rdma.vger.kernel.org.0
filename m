Return-Path: <linux-rdma+bounces-15731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB95D3B7AB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 20:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E78CD30090F0
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4CC283C89;
	Mon, 19 Jan 2026 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gLfA7C75"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC22DCF4C
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852413; cv=none; b=Monf9C4O7fbjmirPOiqYJT2BC15G9ZwhkqvdJcrYcQnfI9ovbu3JzTimEwbz7qFvFCZNbFXM26v0wxQ5HLDesyD5ds/4dO0VvKi074QjDyyxsy1XXjdQiSLjG1GA4rxomp1AyFVtabza29zYBkWNVKyisa6CXvHUQoBUf7P/h8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852413; c=relaxed/simple;
	bh=rqoI5uyocgM27IONRP5gEmMX8bQQMYkjatu0IrsfKxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSejrzI6RFV6ZEpuL2rIUwmGeBuZm3PFax1AZ/JfqlB0q7snpX+QHZrDrmTDjmWR9ZXeRfO/mE3HkzQPXKjX0o0G2sVGq5NiTh1jNSWmM5ZA998abb4VDrEFKzqvqqcH+S4LB392PIWTA7/RJFnOvAOat+DybNP5rTw0nwJjDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gLfA7C75; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c52f15c5b3so537133585a.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 11:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768852411; x=1769457211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Auqm2oRMuolYRtJcTB8WdTd3/j+UhJ4pFiILLt/xjHA=;
        b=gLfA7C75kJ1AORdn59L5v/+OpVs9328RBbGGoDIgG4wotmEAIL65SP/befkYCowaBB
         JXQ3bRVTzBvH17THMUlWW0klp4185HZTz+9odcBnr0t3+NOBpr9fB8WwITRVrChaj/fR
         BJNATmI/GK7A+Uu2s+UYnyUW76119b20DEGQ3OAyIOPSt9teQYMTnvMj3xX2zbbmCzW3
         MJNOJCEXhc77O7E3cD8h1WeD3jOOFG0xiYrDPGy6lv5ja5T+wVx/kOZHY3CpU0SzFN0L
         JFGaaqYt5t9MYv63UEZxe5eYZi0gTjsJ2FkGaqtuHjW0oigeD5ykGMAYyanHalfHJ7TT
         iAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852411; x=1769457211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Auqm2oRMuolYRtJcTB8WdTd3/j+UhJ4pFiILLt/xjHA=;
        b=sFDDCYuOHAk671dvgx5+ufr90kQVcxOON3feAcGb7onTCEadzlvYxxwtrzCY4/UNR/
         n3m6KXgQRJlF70LYCYFs4hDoK7JJFQsenvCIel2r8U0fdp26mG4l3UjH7ajD+Fc70td2
         Wb6HYP9fhJEol6J4i1FlB/2pk116bxgdvUlQm93wWjTKrTliuIGA80aR6VDHZMc/Jz60
         U5RjyfepMrRcnnU04ueY2LWB1P0psUThXwGJjoS/D6DlUXCcXLih91g4yE57KxVi5AHK
         JqP1u5jw1cys681sZ9ZNQykvY/fCON5sVfJbann7h57cQh9W/RSqKfE+SI/ckbDH2yAL
         4EaA==
X-Forwarded-Encrypted: i=1; AJvYcCVM8gDMiH3e2Aw+2SmUItAHMWQC1TafPfLuqV3gI2YVNJ6Lf0US+uuQZDa/LROgbuJt8bEL49PwatiG@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7pmcLed1wZIfnSOYedWXZozSxa7W5WKnqp6XBWFsHYvPcFOj
	l0DnQfWdwUFqe0XIXsmJdUjfD5RLtEQnSBhO+wLGfKAah/azzzYh403el+DZNk1cPSK0L0QVp0C
	lbDSe
X-Gm-Gg: AY/fxX5Tuyf1B+bt+aTZB1b44/stB4LF8Xu4WMYkAXnsyfbIqjj192FHFcRZc+YZm/1
	mlMqPmMwQobiUc2+dxTsf0W01bJuA7Dbzx2I3VsID2M0+x8JP1k4rDW7nL9+rgF3GEXlH26p9lf
	6PZxtN7cvIhzyqseNWantmwMTcCCC1tQBr7RF/W4PvfAu1pQxi6x5b9XfNP0IQuNckxDK2F9nRG
	YxqQT9mmnN7/26tQ4Z4ytiJzFWULqN0acIGCprCp15dOIAuYzbIlbHoLSyRtJAaZNtgbBbWxj9l
	H3EmHVAyEBr0kOeAf5NDLLtnj2Z+gPoLuLXdCUKJEKuP3pi6YyhEvQpZ4U7YXf+J5TDxSsNOQGp
	nhUljfGbmW3PeCot2V5Cc5mKBJIkLIZ77oMX5cDy9AW+CiGv3IaE6rPishh//WrbNeWk1iWvGdQ
	taTHliO8n8BGp1mzSXzODK+5KxwwU0GlAOlkScEzCgk/i19JOlDk6yNhGnU67NPge71zM=
X-Received: by 2002:a05:620a:178d:b0:848:81e5:446e with SMTP id af79cd13be357-8c6a67a1249mr1427854285a.72.1768852410680;
        Mon, 19 Jan 2026 11:53:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab272sm873214885a.2.2026.01.19.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:53:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhvJZ-00000005JQ9-1uZH;
	Mon, 19 Jan 2026 15:53:29 -0400
Date: Mon, 19 Jan 2026 15:53:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Cc: Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: release devices_rwsem when calling
 device_del
Message-ID: <20260119195329.GK961572@ziepe.ca>
References: <ec221ec7-6abb-41b7-9237-8e799bbb5683@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec221ec7-6abb-41b7-9237-8e799bbb5683@oracle.com>

On Mon, Jan 19, 2026 at 11:43:52AM -0800, Sharath Srinivasan wrote:
> The sync strategy in remove_all_compat_devs() can improved
> by adopting that of rdma_dev_exit_net() which releases devices_rwsem
> before calling remove_one_compat_dev()/device_del().
> 
> Also fixes a comment typo in rdma_dev_exit_net().

You cannot change this locking without writing a huge commit message
explaining in detail the reason why any change like this is safe..

Jason

