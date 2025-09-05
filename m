Return-Path: <linux-rdma+bounces-13131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE86B45E16
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678085C788C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8652F7AC5;
	Fri,  5 Sep 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oc+RQ8U/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8F31D750
	for <linux-rdma@vger.kernel.org>; Fri,  5 Sep 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089609; cv=none; b=Uv3ZQz4DqcjPPenHX0cnVToaGdb0x6nVJ41Yj911zwqzZe1Mgr+9SmTM9wJNERq4lYtM2hr2omIc2QuKpee5uTSR3Ea8CQhhITRkE/GN6M4skwfa6OowP2FWiEgsohaNw9ajJpTGQAkuRoRcW8gCq0wYly2XkmK2R+rXLrvPYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089609; c=relaxed/simple;
	bh=2PS5JRt8rYq8ZdgH2QfqyI1JjO6i3QNO1FmCz8ytBWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX2wFLqBWmo8C3Ofdpryy8w6GAcJPLBi7lxXidpV1CAYASRj7GV9HWhbTQcV+4vtajyefW9BiBj7dvfFbQMxKacEkY+RADdDQfwXirBDFuUcBtyeVFBMJx27ZAwtihdursLEys41SdtHoOmXnd7zeRswxzigWjxoNVHmVHqv7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oc+RQ8U/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-726549f81a6so24436826d6.2
        for <linux-rdma@vger.kernel.org>; Fri, 05 Sep 2025 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757089607; x=1757694407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PS5JRt8rYq8ZdgH2QfqyI1JjO6i3QNO1FmCz8ytBWQ=;
        b=oc+RQ8U/IdmF+raFPFWc4kfmsKJNExqLun3iNBIUl0A4ii6A8l6Q7wvjRUAguQMX3j
         GlPZ1rUO8tqor4vjIPtnnXDDY4kj24DmYtD12p/Mbw22zko17G71NdYGW1B8zKTdvwne
         +U7h168qIibNrc0uLLlc2VhC/utpDCEvoDQroiWwdsBl3kyyXVCkFgASOsxR7IMgbYAr
         5SUD0pFVQWQzzq+dMEW9dJOfjaGMN6YC55TduXwWB0eoc/emupmTQq1xSCTQ9GHLAlWY
         Ct/4O1pOeclbTXVvpSVhZ3yXM7n3WWlRAmvRi/RZt3SooPt4yBx1szAhz/P7g530y2io
         ZGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089607; x=1757694407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PS5JRt8rYq8ZdgH2QfqyI1JjO6i3QNO1FmCz8ytBWQ=;
        b=AqdFrv3XSUE+iOaVJxZEA2i8bTNuUy1GIeKQ2erTKmzqG4FjIhYkmxQYr6FqnMSf4l
         6t3kMU76KR7P1ZQWkl5lFet9cC9rUWjPi6VhloAVBNZvs3SXwEuRKrbjxaYM1LAlMyay
         qIJdp98XEnm2Tg0iRv8LH9MGcx0zGAmdR3kUB2KL1NCZ1z7y9bZ0zxdxfsH6CeD72KQi
         fY83pZxFP96FpPhOiK4rAv2FlYN7ONt8zCSQgsu1zvqQ/ZqHJe21SpnLJz3oMjOwwevl
         zi43Rzz+VkGq9Kc2lCp5IHk6fIgK5MZlAVpD196/c4RlCKXMI5F9uaSm3XiQsVxsYbyf
         eYfg==
X-Forwarded-Encrypted: i=1; AJvYcCV/jkDImVi+V+DC09ZgvYRVy92ynCj9NXOwnPR8db0j/GoGFihG6qRFM5a+mFYavDUqj+CHhj77izw9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nmnQVY6aEETdPTEJ6UpuOP5VA7vUUFoeAZ+4CcUWBr47xorv
	PWLP46diQ9b0GQTIfTYHUXSiJd3ITA3dLR69m7YNtM39FJlXB+gkL2OXfeS1VrdzAdQ=
X-Gm-Gg: ASbGncuOqT4lTHdqMP9dpiVR2SJ7JkqECXAuuU5eQ1M5i72nM8qtwaMQyEcuTyYTIrF
	hvBYDlUZCkDjjq0IWzsoNC9cQD/8uPHa92j4btRLkeckzlB2FEfaKKct4xDk5hLBzkmuJivbFoQ
	tkbf7fbPY1FvQ2u7TyvbJhLkMC9Hft6meLdLQO8ed2MaVMhXQxns4AIRTUPr6JNaitqWUNlB45G
	LMck4eGJW8dJQA6+nH5oVPTRWfcOC/MLrTd9J3qq2nTUSZeft2tQUVBTOpToqBzBkdW9/PFMdo/
	y/yZzK6bpiNMRCJI2y9gNn4kAYGAocUBVb6GvqjcYL2mRk8JLat58n0CoKHQNq7NTjPrVBJpUie
	RHShiYDPbLRVeTgvBTE6gmTrzZlCkeIV9r7MKqr42B98XilO+1jMDrYPNqsRbNEPmvJ+K
X-Google-Smtp-Source: AGHT+IFSn5HY+WeJUt1wAviTMKOBWm+lvLAThCgWpXgEcnXeGVtNLDN/lb9+gdaDyGFY+W25tA/JJg==
X-Received: by 2002:a05:6214:301e:b0:70d:6df4:1b21 with SMTP id 6a1803df08f44-70fac920713mr231386786d6.62.1757089606848;
        Fri, 05 Sep 2025 09:26:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16e723sm68417896d6.9.2025.09.05.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:26:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uuZGv-00000002sYM-3KbU;
	Fri, 05 Sep 2025 13:26:45 -0300
Date: Fri, 5 Sep 2025 13:26:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, stable@vger.kernel.org,
	Nick Child <nchild@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/rdmavt: Fix lock dependency in rvt_send/recv_cq
Message-ID: <20250905162645.GB483339@ziepe.ca>
References: <175708273545.611781.8035611015794018890.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175708273545.611781.8035611015794018890.stgit@awdrv-04.cornelisnetworks.com>

On Fri, Sep 05, 2025 at 10:32:15AM -0400, Dennis Dalessandro wrote:

> Note there are cases when callers only held the s lock. In order to
> prevent further ABBA spinlocks we must not attempt to grab the r lock
> while someone else holds it. If someone holds it we must drop the s lock
> and grab r then s.

That's horrible, please don't do this.

If the caller holds a lock across a function then the function
shouldn't randomly unlock it, it destroys any data consistency the
caller may have had or relied on.

If the caller doesn't actually need the lock after calling this new
callchain then have the function return with the lock unlocked. This
is ugly too, but at least it does not expose the caller to a subtle
bug class.

Also, this seems too big and complicated for -rc at this point :\

Jason

