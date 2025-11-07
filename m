Return-Path: <linux-rdma+bounces-14308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E4C416B7
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 20:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9E693510C5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2555303A12;
	Fri,  7 Nov 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A+/37SaD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276719C556
	for <linux-rdma@vger.kernel.org>; Fri,  7 Nov 2025 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543072; cv=none; b=eC2mh7fSTyRi77zv3UN9Nn5EHXMp/Xj7RXwBt0VUFNWVRgnq0SFbD5AOb9Go+FCmgz1Uyiu4uW0RWyduy1w20hoFNk3O2HDbz9+flTKaqAhCzuCfW9uUkzMP0kxCtHW5B5qBPS389PWFrRAgbo1/TM9hOGDwuOvrCGLbH3vVVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543072; c=relaxed/simple;
	bh=kqQePQXMwvwZBckBBeg2xvqfNdu+QHLHTTyd85vE6ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/9zQU3n7CeBBWQQ0UBN8y1RV24ArTdRNy9MCD+e7OY8XFHTC8m95IPY+PQ7/O/bd0tc+MTEucrDJpS9hzgmTgnbEBWdwqN/FBFvAkJIW2uTgjhofiXmv+hFCHZFe++BwyezeG+xtrvYDmJJJKawSmxa2pm2nGm9ahh1v99Z6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A+/37SaD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda057f3c0so5537361cf.2
        for <linux-rdma@vger.kernel.org>; Fri, 07 Nov 2025 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762543058; x=1763147858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7IeMTE39/0sPdj0LGfZb2pj+ljiHr2LudKfvtkV0AQ=;
        b=A+/37SaD2WdxDy1F/jENqnvvKWKwstpxa7KrPTS5rQIlS28JRLYE1L9F4oGIBIF+Mx
         GIzpDDjEpEMK/ckZVzMxSUp2xCcHihqncI/BmLu92arn7SILDAzfYIeVf99foPkSRKTQ
         H4tJ7MNEIKEt6YPMmmG0fzDVxE0zgDVG1lC4GpHBFFPQpwYKC6Mv0Ys3LsZNv2xl0zEb
         k6uwAUv+QNxEaOOSJ881HJ+Kpy1e7JtqgEjRWgKqDRiwXULTuq1mnZ+3OyzB7BfuAlXO
         C9aMS4oIs7RojjtQdwWwZyKhJKjw63d0Pjy5N6V+6XkxNosXkT6uUmnqyjgMAlGdAHjQ
         8Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543058; x=1763147858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7IeMTE39/0sPdj0LGfZb2pj+ljiHr2LudKfvtkV0AQ=;
        b=Izc1e/7B2jVRgKldwQFa878KuIdGgbRY3FNYKiyB6vEzFktOpo1ldksVr9dwgm/+zZ
         6oaTpZgrvPkHTinf6jeToA9Yb01FSLBV1QDHPFD9nGQKZu7XsIhaaEgKJM4yBsq3+yZN
         QZA9cDan0fEs13LDfE+BfNvCQeoi7NA42cV/MI9irj4qy+JZYRPJc74FywwqZnj9JOrQ
         BSQBhis3eqEk5tZiPafT9k7rKDVd8K2EfoIQINp5nHWxdmpElFfed9vhUvGu4sm9h9ww
         cLOgyhPg4GIHh6YEDMOUaL1UZ+zAbRrVGcPi/yMLsPxq5XXukp4W2dGw8P66WWgLI33v
         jdlw==
X-Forwarded-Encrypted: i=1; AJvYcCUE4hFuolB4lylhP3zgJFh7eSuvOxF6HUGIZJyb2zle9UfSQvFHA+QiSOpDSSSCBBxEOIIeZuTWQ+41@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kdSrpdRCj6No+aDxOFTrlRC02zwK1M3XKJWOVLcd+pqFgX8E
	Pe2RipIHsFYca4v1yumOGjhN4BKwPwnlCH+1hC8ncXHdK/PX06h4icgf2b2t7z5tRe8=
X-Gm-Gg: ASbGncvv9uEHWwR13hihP4rRC7OXxq1QFIz73VPH5wImekta0ZDUUyq38SaiDC/Hl0B
	f593BMNRZZOgqeMO3p1VWTDbc4S+vAQ+BuLk67NYMVpHkpRCJqA7N0/Gp+PVyqO7W1wzvaq7SXy
	YNK5pQLrB5F1bjJADAazz1faygN4BO838DwX8UKKNWc9OkkrP+lNZIY1g4FV0Ifqf2aBaZUGsby
	CcmrM74L8MQPirVLPuLBwTXMAMlVceAtpoidojJaGCNrL/00H0s2rQ8rpq6EpjF9LOtF5m1aRiu
	8CLmfDVhpoFGwyVdriSmoE6wktMGgMhpjkvuILUiLSXeXEkaMcDPX1aCJLbjrKMZkk8U3vNFzS2
	6WMUv5HDv9ClKFgMD6hrm6wU8WL1yVoBgrq5PRbvC19o2tIxpURSZQ8Xqml/sbq8lDocUuSIow7
	drg2CYf4X0KwWvVQ329EWTBIBI3ZpJN/IK2khF9LwLK+8udA==
X-Google-Smtp-Source: AGHT+IFnYi9VbOBN0jRzWxp4PFJXSJ0IGLgqXdTaco6sUWpHKooODG97tKga7Flr7a24rBW8jpPYAw==
X-Received: by 2002:a05:622a:446:b0:4e8:a73c:87d8 with SMTP id d75a77b69052e-4eda4fd4c16mr2409081cf.71.1762543057925;
        Fri, 07 Nov 2025 11:17:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c206fsm456371985a.5.2025.11.07.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:17:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHRxo-00000008Lr2-49qA;
	Fri, 07 Nov 2025 15:17:36 -0400
Date: Fri, 7 Nov 2025 15:17:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>,
	Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in
 ib_nl_process_good_ip_rsep()
Message-ID: <20251107191736.GC1859178@ziepe.ca>
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
 <20251107153733.GA1859178@ziepe.ca>
 <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>

On Fri, Nov 07, 2025 at 11:11:40AM -0800, Vlad Dumitrescu wrote:
> On 11/7/25 07:37, Jason Gunthorpe wrote: 
> > The fix to whatever this is should be in ib_nl_is_good_ip_resp().
> 
> nla_parse_deprecated returns success if attrs are missing?
> 
> Other callers also check for their expected attrs to be present in tb,
> after checking nla_parse_deprecated()'s return code.

That sounds like the trouble then, the check for tb presence should be
added to the ib_nl_is_good_ip_resp..

Jason

