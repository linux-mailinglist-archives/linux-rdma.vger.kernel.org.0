Return-Path: <linux-rdma+bounces-5184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1CC98DFF7
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35EBCB2C2D1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44D1D1741;
	Wed,  2 Oct 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L177WDs5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A91D151F;
	Wed,  2 Oct 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884097; cv=none; b=VkfXMJ7IaDgyGZlIwkj+VfLnVmDGZBoQV02O4tsLMWKipvVYZBdNb4dVU1joOLzVlN9bqzPvSRYHHtlTLfPc+iB3DsQwAqEwp4QjA45ucretlAbQ6qFKSJbBpOsCK7ZwKW7Hbf0rDag49rs+Iuw89cVJAThKpU1CnXAi64PDQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884097; c=relaxed/simple;
	bh=DOSGnvLndaQWvSvy8Wng9RxZHlHRJS5gAkm5ih4Ualk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSxW9ODSqme8jkg0WsuVgFa2INagCsELdzIJ1+QPcsRWu9kQJJFBtL61K9JGvscsXq+Otm6pBbTwv9FG3Cvs6EgzDwpzpa51JtLc1TlOWawrqxsuHo8lGiwsO39UDGbS9yaA+fXfL6Qnf50XLDeos4ofBgvdjRNLqc+ygPUd15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L177WDs5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso54547925e9.1;
        Wed, 02 Oct 2024 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727884094; x=1728488894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otCikT8NLkr+o7//xyaZx0+pIP+DAzBS0pRoHFmSGnI=;
        b=L177WDs551r7vAj827NWizARFvLmx2SIgcMwT/n7X1DrXKKqWEN3CyHKlriPYLDLf5
         3B+Qs1AJSJoKtjwKUq0ZGF4AJyTF4OUdUEenj4bhdkOLxqUrNr1RCdkLbblIOipEoDKa
         pGzpbgPIU7N5BvZybF+hou1vu2NjVyRr8gwaZKSv355hQkZ3K/3BA1vFYvsvkLHYBOkX
         6G6DTypEW1d7clZFaoCiaN9vYvNJ5HkCBCibc2H/dV/37gBZGjAZCNVcKckAFkbr5wba
         KbDBI7NGHYwm5qJLNY/zvUh45ATdohy5jSZAOEi6Q1Zdk0klOnMpek2+05O1Zk86mdyI
         YUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884094; x=1728488894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otCikT8NLkr+o7//xyaZx0+pIP+DAzBS0pRoHFmSGnI=;
        b=HXHup/MrbdgEfuGZYw6k65863wUtPLdvAMNbYXP/5GtlTK49WLbAz1jpwOb1gZzWGw
         0xboq+Xi5Ka4C/vJa69c5g1eRf8EmTLvx9NbJnJwKfAylKaO1Ipc1pwRF995IjIKUITF
         CUXDicga9ArTBnQIH+6iJN8aYdia6b2u0wMQyYEQotpC5rA+QRwUQdDaHug1LWQ9H3Sk
         helx0BWAVFniNdZAg4ekK6grptQEbOUlDvyP9OoG9kldnvkWTSYygtojr034oVYlJcx8
         bt6jUNhADGbkm5ekI2b3Tis9wx+TIw3bM5Bl2hKa53eftP3eIFpGNPJbrgeiIcBoQLvf
         eSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1izRMEuFr+JxZ5WnANERzbI/hVDb/pvUE8mjIcvOeAlAsRxBb1S82vbnj3pD5cINcb9c5T6os@vger.kernel.org, AJvYcCVOv9PnPS01oD2TfmRsOAmXnlTtpkvvYFrYqIpgEpIZpI1X0LHpSYVMAmNYXAHOgmM9/pbxsCyCc0ErikD5YQE=@vger.kernel.org, AJvYcCWEsyb7R68qHrCqqvC64YXRD8CX5G3t12PEXdxu3z+Q+cA8Sd7GUg3u2w0p3UvofebZEpJBXDtIOGJoVQ==@vger.kernel.org, AJvYcCXCnrApKFiLV6OYJUSsBO11l1NmqI0OXs8Tlpkpz12Y67Mr/zGchUS27wCnXarrKaBREKtGHw3RcaRU4i5Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xh5/Dsl9qtzD0Rqar/+AG0plvtjFcZbxMfJxogEIvN9Vxvny
	ccRggCTrtnWmpKz26LTsHZ+0H7BS/E4xz1och4/cdDfBd1692y1K
X-Google-Smtp-Source: AGHT+IGFmLAHIyp6PKfxD7hKDrPBwsfVE1H+xFInjYaedHXn48kn9ymEH60zvft4xr6oEkXDO6gQ0w==
X-Received: by 2002:a05:600c:1d26:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-42f777b0b18mr27867415e9.1.1727884094011;
        Wed, 02 Oct 2024 08:48:14 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79fc9032sm21706145e9.25.2024.10.02.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:48:13 -0700 (PDT)
Date: Wed, 2 Oct 2024 18:48:10 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] net/mlx5: Fix typos
Message-ID: <Zv1rOgyJj4rx4nUf@void.void>
References: <20240915114225.99680-1-algonell@gmail.com>
 <20241002134811.GI1310185@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002134811.GI1310185@kernel.org>

On Wed, Oct 02, 2024 at 02:48:11PM +0100, Simon Horman wrote:
> On Sun, Sep 15, 2024 at 02:42:25PM +0300, Andrew Kreimer wrote:
> > Fix typos in comments.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> 
> In the meantime, net-next has reopened, so could you consider reposting
> your patch. If you do so please mark it as v2 or repost of something like
> that. And please include the target tree, net-next, in the subject.
> 
Thank you, on it.

