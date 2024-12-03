Return-Path: <linux-rdma+bounces-6188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0779E1A99
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 12:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B12B62126
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA91E0E18;
	Tue,  3 Dec 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os4/fbpq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B71E009F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219347; cv=none; b=MT3gxtqGUZldxVeqKAav/DGkBF4e1/ZSsylWV4G2EnWsS9m+wupO946BYLtSjll1Zd1ogPWdSvMqvE5OEo5o0qnw8MD7hfT+cy5c4mpooEgpRB7ped4lFFOqvduX681cbR6bHn2hFof1WiNWrcOywnuZpsZU2V3M93dhJ7lwanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219347; c=relaxed/simple;
	bh=66C7X0y5JSIvmxFiooKiDwrInLALIuU1cghHxsv7Mrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJpZKhHYH75ZrX204/oc+NE1RbDnVl+JquYGY5YGOmOzJgBJOK/M1q3e63xVlWdky2oBRlX58LiZbYKuqHRX5X6ko4QNoXolhxTTM11yduJSt8MrkWHau8edMHlZlRMjdZUsH8vfsyKVuO1gKoClUFAgvbK9G795Zca7fBfMTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Os4/fbpq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a95095efso36604275e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733219344; x=1733824144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5m6hg1T/8NDguGzINl2AjokycuEBlMQVbW4nuTy6h4=;
        b=Os4/fbpq6FR4D2jx0XLq3ouYACEKaboZsV3uXhNT/xJhqFPFoyLunsdtORGF58ChM8
         MaJn26loszUFyLfcPYRkAIba5cWHzYOOPc9xWOVvSGpB64fr9Hmhcr3FjyVKFw91hL14
         hYvmmddyHfYzHLNWckwX8WS+WGINd1/4wEm55inotYVykwIFSIzHXhAwpvdY1WcV7P9Y
         Z6uqGPV4S3lBBFGAJ5ys3fhvq0ij6cpV4/FP3P3PaE4+Tq2BJXnJ5a5Vb5m8ujCyt+24
         FAfmipDS+n/qxQXyzd2/Pbu/T+AB6VIlCOSbavxepgTlStwtF77macYegLPA80Pr3QrG
         xWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219344; x=1733824144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5m6hg1T/8NDguGzINl2AjokycuEBlMQVbW4nuTy6h4=;
        b=cGNGPIppWxsU8DlQxFcwkuA1NPc5Hir/P5GSfgwMu6ZmHTWu9pqx5swjwIzSBErlNi
         QfHctdGi7MOI8Lkpas8sOLy0N3Ckecv7t7n1PDgRuIkbMdWJ6ZCEsohyFee4X4cv5k/W
         eXmFvhctXkO/34AiX71Z+D9Gq4SwI7fV2g0TiSTG+CVLbmtgeUCLexVH+QEzGiNiFhYv
         OZInqZrpdG03c4mEou5Bikl2QgJ51Pd3bCYqjswH+3o0Xk8gQd++XkXjKeMlte1T4mcc
         BP8+wQIZfHywULYj9BACroQUChT8aolX/oEoGMsVIFNJ0sD1H/7/ZoK3xN2aUeYGdPGp
         bmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2mdDJQyJuAfFm2uM9kVVf1kFS0N4sZrvEGXXGd12KERMD350B+Ic3MK5gmrkbFE5Atngl5ShtRlzC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7/1BG4JXFEmBAjryUTXGBCkSmIToEvHGj+dr83IxQKU8tYxl
	QyzKS5U10pk7ONhMeA1AlvrVAhoxy6zCBVaOvSzDnQ3XqjRVbNCZjShg9uunFmg=
X-Gm-Gg: ASbGncu9EhuaiwXlXpgWLmVVb5a4G51ZeIxp1KukvRQAte5jycNoY5Xb5EedvkQaPDg
	G8k6YyZqWJiTGvocqlF5vOy2tBDGKNHe5//SBrpKB9iLsLb6lMJhqk8oyOvYS6ibFFO1ODEC660
	S83nGPODeBiCrS1dSigkjDppGZ4zrfwOYlBWq84DW1w8IeEGTJnHaYXZHUtIsaZSUh1gKVJ2os6
	bQ5u7dyfbD+n6gtsEpa4lGnX5xMCdny1XNVIE4eHGlhA0apxeWtKiA=
X-Google-Smtp-Source: AGHT+IGiq5MfIfBd9OA4L42VqbX8iZSuCB9pKeFGXwzXoQE5bTKyZlB+OEQ8WGkhd7IzIABfKHMT6w==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr189287195e9.8.1733219344634;
        Tue, 03 Dec 2024 01:49:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d04e7380sm15910995e9.0.2024.12.03.01.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:49:04 -0800 (PST)
Date: Tue, 3 Dec 2024 12:49:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <46a97b8a-042c-4903-817f-efe3be5afabc@stanley.mountain>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
 <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
 <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>

On Tue, Dec 03, 2024 at 11:44:12AM +0200, Yevgeny Kliteynik wrote:
> On 03-Dec-24 11:39, Dan Carpenter wrote:
> > On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
> > > 
> > > 
> > > On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> > > > The dr_domain_add_vport_cap() function genereally returns NULL on error
> > > 
> > > Typo. Should be "generally"
> > > 
> > 
> > Sure.
> > 
> > > > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > > > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> > > 
> > > Please remove unnecessary space.
> > > 
> > 
> > What are you talking about?
> 
> Oh, I see it :)
> Double space between "retry." and "The"

I'm old.  I'm still using fixed width fonts in my editor so I still use
the old school rules.

regards,
dan carpenter


