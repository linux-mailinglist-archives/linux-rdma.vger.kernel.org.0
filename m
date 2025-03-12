Return-Path: <linux-rdma+bounces-8595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0BBA5D914
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 10:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAE0167B17
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DBA2397B9;
	Wed, 12 Mar 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="th1PN2Vw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9C238179
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770970; cv=none; b=YiW+LjJL1g+qsYSMKBVrRfOmyDCaeyU8a/IHBkleZiHGpu/vcEIAfyR6BQHBST/4wyrrTDoqh21X1hAYCSxbxhlOmmPc1OtUKgTD7j791Xe5NrFJZ4lQ4Va1kuvqu1EfwkwVCUsaWxOqpGIS+S8c4gAwmW6AXgEAucJp/jWticM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770970; c=relaxed/simple;
	bh=sIDMvwzuoLYsU8MulLues+AREztPfKS7a5K7A6AM84s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8AGBoNJiifHA5klkPlVMfg638n6gARSH0BYePoHpJPjqpPsfVwMypMSo0TbZkl2ASPi4iURG9NyIUbRs5grAYkRGnk96qOfMfJvFHqEzxuccYPLodHkf8boJPTxC48HkaE8vYKJCK3P4+RGZ3xaDt7Qg/SmkDktlJ+K1AXFCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=th1PN2Vw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39133f709f5so2592565f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741770965; x=1742375765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvJ2Xzj0eyzn8CYIMkRwS7Z/Lt3ehRH3BLoMLX8lXYk=;
        b=th1PN2VwUTMWs99CnSfHTXU4bozLM5DZ/qT0NfntRnPlYCNABpH84/ZDE/wcZqyh+M
         y3jad0CGgPxkY3vfdtPYtFip/9tDpMa1WNR2g3SqCbgRFX6FR4CcVXDiLRgZLkZIJmKx
         74Zsv9XF56bgpQSKFI4kLisO6l9uMolK6KE7Wznee27NiPN4llqksbFo+dQQ+5/coFUT
         B67fs5GJN67EE71dY++tbEGqfQrWtENYgsal7MudXyRDOwVjQ1DxIz0yFtionM4aqP7L
         QGScrczjXYlDAyzgpz1GpIC7rtOxYc/lXFZ9a/wYo3jKIz9qGCrlif9FFmgzilIQIC4V
         ob3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741770965; x=1742375765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvJ2Xzj0eyzn8CYIMkRwS7Z/Lt3ehRH3BLoMLX8lXYk=;
        b=OPRYdgOHH0vseWxxLL1r6pN8sDKNaSB6F8SL7XY7KBWCKkO7iLZ5JjgC14IPJwen+g
         tfH47tg9iP01f3GZYqa9L7p7UIogsXKiGceiT7LxPd2WpzympTuqqS5CaY1sg7T+QYs2
         HP9jIivLYcSF8sx/rO++S5MfwE8M9K0mvLP/gp7NIPstf6f/J1g2Ne7Dt/AIt0dJFzHY
         AeD2I3dLmoKcqH5NQr6F5x46n1e5eByjJvdDvIA+M6364IYfm2B+5uEqFSN5HUNXJPeg
         xMbHgBIFD6ER2X9nFfbDSIFZVgQEc2mEbXr2JgQcJw1qX0dl1QL+WrWs4+Q/IWKfN76H
         OHWA==
X-Forwarded-Encrypted: i=1; AJvYcCVgi6qJ2eZzSW5sHZt1yoU8t8OkRsIJQ3DNZ7QbQEGHUCkaUotVPtwumU5Mzw8EB96PpwAP3fQgClTD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Kk2THYP0bhQXTIxUE/C7HLYnHaMbkn92mtjLGge/RFxPhJRo
	RUGAfQM4aV/bsgIBi/L0H0e4sRHm4AQqqsmI+G90TkpTI8lq4VO0zg3A7lGaZ20=
X-Gm-Gg: ASbGncvKkH7Ei4+GvF+Bd6/6KxLkA0PRbCTu/cN6CTQIf8zjoqQWKS9Dh8KmUY9a57g
	4lBkzKEfXZbh7b7vHvv4MerEyNwrTfG+ESgjmzLCtSYlTttm6v/vMs67lwKgjD2Ssd5th5ubPtM
	OyTy++Oc+BQ5QeJe8d10VroXfAI7MXJRuwBmLilF8xvvN2a8jt3wqO+9zcgn1On30seDiiOCYFX
	HgmyrFiSbBdBVWxWMVmuqsJ+kfmHEfRRB5NuAF/hjZm/g5UD9R4/88kagXiPKFSSX8nrEHJaAUo
	Td7oYTEP0vCqH2Eo0BlW2jgxwSgm5Rq9wxqnbPWlO+4FFmrDxg==
X-Google-Smtp-Source: AGHT+IH8KA7dBbMYUtNaewqvmBU8TZSP/ovXaOjXLdjqAfQbTR66dZxa3HH+YoPjAXJSTo/R22qA3w==
X-Received: by 2002:a5d:59a8:0:b0:390:f55b:ba94 with SMTP id ffacd0b85a97d-39132d31f55mr16028038f8f.13.1741770965540;
        Wed, 12 Mar 2025 02:16:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3947a24449bsm1183144f8f.45.2025.03.12.02.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:16:05 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:16:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/uverbs: Introduce UCAP (User CAPabilities) API
Message-ID: <e3037a31-9685-472b-8ef5-23a241ff20ac@stanley.mountain>
References: <9f676f55-f5d7-4be5-88a5-4f1f5c5c997a@stanley.mountain>
 <20250312080717.GH7027@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312080717.GH7027@unreal>

On Wed, Mar 12, 2025 at 10:07:17AM +0200, Leon Romanovsky wrote:
> On Wed, Mar 12, 2025 at 09:53:17AM +0300, Dan Carpenter wrote:
> > Hello Chiara Meiohas,
> > 
> > Commit 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities)
> > API") from Mar 6, 2025 (linux-next), leads to the following Smatch
> > static checker warning:
> > 
> > 	drivers/infiniband/core/ucaps.c:209 ib_release_ucap()
> > 	error: buffer overflow 'ucaps_list' 2 <= 2 (assuming for loop doesn't break)
> 
> The thing is that we must have "break", so writing if(WARN_ON(type ==
> "RDMA_UCAP_MAX)) return;" instead of existing WARN_ON is very
> misleading.
> 

Ah, never mind.  I got confused between kref_put() and kobject_put().
It's the kobject_release() function that can optionally do the release in
another thread.  Sorry for the noise.

regards,
dan carpenter


