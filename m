Return-Path: <linux-rdma+bounces-11636-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C3AE8C20
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 20:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCD34A5920
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ECD2701D8;
	Wed, 25 Jun 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPPcSper"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB31CAA7B
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875367; cv=none; b=WDy2dCXk4ufgHlcnYYGaVHMUHmwqrLopKXhghvUmnct+pXn1WN77IpwDST3vi0CYsaOmR2wzI2xEKY2vxRdKfn/XSYOomnZRGPoYISNdoo6peCFwGb4DWtDGOE3yozMcz0w+1BWc+0woONXFEv2Jf+8UfFcTxcy+zTDatoxr0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875367; c=relaxed/simple;
	bh=ZSQflvI+dx87BWX5Pgy2pUuHWdmrEEUEEodE17ummQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyQGJSZAX2s/ixE052JRfN0hJS1MolNR1CgvggFINIpcTbUOOgUTwna+CiNGocRs5Plst7T346KYQzb2QrrHsQ+8ulviCFbnQZaaUJb0hggayAxBJGLXd1vkHoNN8nfiII5akcWTUDjLw6k6ednqsXq9aUMTO2uxRXqgN0G4I4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPPcSper; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60f24b478e3so108384eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750875364; x=1751480164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ds43cq5VKAjGEF+paeGIlgb/AFk3oLXyjpiFzhP73Y=;
        b=DPPcSpercp4r/aOl5y9k16f8NU5xJO+DSdNQ851mDfEMcEQ6Xqx0Bs9F3eA3iOAefa
         62Kjm054hOuQO3WGNEU3ycgIVylV494sv/Nm/vL5M42dqzEnqEyHpmFSir/krBI2GzyN
         0huQ1IPtIPvzcg68p1uYRZRGPkhuH7aeX29vm9xvwl4htyAGs8GWdnnUHJGyxo9NtQ6D
         uCJo9rDUq39KwZ7uUbmX3MQ+ARbBIgjrFXSUzaK5aOhKRmY1rLAwPSYucRqz9J7c8dcq
         dEMNDHV+Iwd9YKkfu7RVRDtfb6dKG3KxYsEmnpWrFUqqODfzh2EsE+OwBZLG/Q9i4LFw
         F1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875364; x=1751480164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ds43cq5VKAjGEF+paeGIlgb/AFk3oLXyjpiFzhP73Y=;
        b=Rj5CPXc0yOrc8D7dE0WEVX/UHfTNbbOn0wuIoixp3wpMDxITBfHelidquNnWhsNcbG
         SkaXNA1I+dk1x6guJlfrhOCl8tcMnTE6Y+q9K87s6As9Hoi0NnErA5dYDyi7uev0LkCF
         BFudbZa7vGWGU4AkYrYajAR+hzqAlDRVMP51OqEvUjllUtpU9VoO8Oabn8Lgr/iFTYTH
         2lwPUvIg6HuB43CfKPkl6F4cw6j5Z/ZPtoN5YM9Dq4DTxmHsknk/QDvSfww70IXm8w0s
         uuI/sjSkmWlC26c2/64nCsv9KLnnKFrEfZr5lu03KHz7RZtzfnyq5k1D52qcC5xxvjXd
         2bPA==
X-Forwarded-Encrypted: i=1; AJvYcCXj9Qu/JUyYj+wVYCMgiZg8QxLdYEZwMMQ4v1oUOfTP5lQN0BmbCoOaTVRCtZvyZwPZun5EHRZEd0Iz@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQzLNtroUM2Od2QaPLZL+oPRmzB7V8JehOQMLDLZ88OiyFdJb
	hkHJC8UZDX+FXf0olQ17MUG/mamZyibL1NzXY2r1g+Kr5OaWbKZ0kYj0EsPH1DVUuE8=
X-Gm-Gg: ASbGncvfuum5o/1yO8I1XzmXosCjV1bZV+i14cdnd7c8XySBZBf0gJN+BAZZ27mtZGs
	V1zHjaxfAalWjVByKf/+gb/wOIliivFkYP2sCMePC7y3couonCIou+/BeGXhs2z+RlJ1RnVXJ1f
	QHK4IYUNAEKSn2pD93hbwOcEMekXeaNWmucr803K8ArURFdNvSeYqVTJzXuDqNVJD1KkcT6zZzc
	yaCjG9JolKxBfPM0ZVXm7tQIBKyLSdol4tPVcBU8hlqfmxI3ZtyZ9TPiGmx+LmpHmn5k7eDyhSS
	T6xHdi4GfOfWcqoEimXoWFTZailDaxx88KQvJooS35XvHptFEDzL7LF5/GaOPEAPcV8=
X-Google-Smtp-Source: AGHT+IGF3ONiUBg2GiFgTNyAb79DvhkSUQXKM5ohgb+SGOD3VQHjY/8ghJi/h7Q6a9PKmKmPwyOewg==
X-Received: by 2002:a05:6820:1527:b0:611:a527:226a with SMTP id 006d021491bc7-611a5272cf5mr1890255eaf.5.1750875364473;
        Wed, 25 Jun 2025 11:16:04 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6115b6c80adsm1637262eaf.12.2025.06.25.11.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:16:04 -0700 (PDT)
Date: Wed, 25 Jun 2025 21:16:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Daisuke Matsuda <dskmtsd@gmail.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix a couple IS_ERR() vs NULL bugs
Message-ID: <d4adeb54-e218-430e-b156-e0220005404f@suswa.mountain>
References: <685c1430.050a0220.18b0ef.da83@mx.google.com>
 <d72af2c1-2faf-46db-b212-0b800040c311@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72af2c1-2faf-46db-b212-0b800040c311@linux.dev>

On Wed, Jun 25, 2025 at 11:03:49AM -0700, yanjun.zhu wrote:
> On 6/25/25 8:22 AM, Dan Carpenter wrote:
> > The lookup_mr() function returns NULL on error.  It never returns error
> > pointers.
> 
> Yes, I agree with you. However, this commit is intended to fix an issue in
> the rdma-next tree. The corresponding repository is:
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git.
> 
> Therefore, the subject should be: [PATCH rdma-next]
> 

Yeah...  I moved to a different machine and copied an older version
of my patching scripts.  Normally, my scripts would put [PATCH next] in
the subject.

regards,
dan carpenter


