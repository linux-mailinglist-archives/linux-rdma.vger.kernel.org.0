Return-Path: <linux-rdma+bounces-3834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7C892EFF5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 21:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189D41C21132
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 19:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F9019E802;
	Thu, 11 Jul 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jLynOA0s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082F450FA
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727454; cv=none; b=dx0c9tvuGurrCB+OALvNUjrK25y2jxy2iAW1UD4/Jjp5InKR4b8eatKw7q10kEUB3NSMTO/g/3UDAbJYDmqrIiL48yotMIEL00T4bqHSTA95as2Gzi+71pVEfFDzCbptNdS79YurpjzKPByuvwq2VN1sJ3b5mZwKmX9tvoiGeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727454; c=relaxed/simple;
	bh=25DL+Hll2lMofFyPyaRO80K0JHQq53U6mfOeNBWKvLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tuo0+KS2TRi5zDZol5Sdcjc2Es73IPCtPEkGTKGxW4SXmrJwhJZOpp0aJ9nlPettwouDMg0hHX9Phe7mWfvsh+I7eNEdOOL0ZytMKwBUcHh43m7MQRDSgPaYGvxkxnFzSwvoo1Jz4Yb8YIT5ICMzK7sAOVnAbwPt5ZlqRe9Uxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jLynOA0s; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f1828ed64so76316485a.1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720727451; x=1721332251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=viHMewM8nxycM6lp6W84EiwbzVWCYHUyxJqZugyqmt4=;
        b=jLynOA0siaqMoZaTqQl30DRjgoP47UOzMJ51p+RyUgOWM0zjzB6czGJVnLtKXbgYAH
         Vb710j5VXS4ikQRg4fYhOq5raneivD687XrGK+4EuqT/loWJlsPswNUowr/IaRPt/J5a
         wi/83N2UfncTCCOObISPC0pmRYgBgFzhs6aj8fzB/eJ7YEeFCvJl/GUwdU31h0jPgqgE
         GZ7YEPJSOEGITFEUIDDTqf7JzTkhZiLuRDcgTSsjrZRKHV1bwgPqnS1u5SznRgcT7RFr
         vcYy8lTuVhb/iB39AUSiC8J+4tswYefvuRY80Maoq0FkmAJKTU+Ou7akse+tV4skaP/D
         7KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727451; x=1721332251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viHMewM8nxycM6lp6W84EiwbzVWCYHUyxJqZugyqmt4=;
        b=U+/Rf4GbW26ibb2r6+cBqkNytOmSjXjLNObEj0wmSPy6f84pfFvuu2xdJcE09aqFo6
         7NzlGJAKmQNQfNVcoGSRaFDKXETN0HtwgjU2FsnUrxAp3pd+7+y/LDid6hHqI2109j1W
         wBNFaMRbQjKM/nNpmxfSQSZD1HDHEy8qxZyLisPGdv69LYXa+GX+PHt+fw9M1yCaqs4m
         2sqJ4VH+NoOWJFbyY4ru7m7VnpwJPDC6XXxUO+5+a8DaYG7lxpF1r9AN7TOuPJC0AJFl
         /7iRRjETjCqqe7s1QoPZxT3pzLtsNMZeWcxiSFQT1uc+H0lYsHxKO5N+/dubqZWT4WhJ
         bGKg==
X-Forwarded-Encrypted: i=1; AJvYcCWOINrvf0U+O+yjxLX5k20XnxjXmulI4JtKs11PYecuRPYj+9/RlnXuNCbomF21jm9qs+ORAwOlklB/eTL3atPTQAfao6ZV56C1uA==
X-Gm-Message-State: AOJu0YynAxdr8ZUWN1jYussPidpHM6HRh4fx8oHmg9MdlXk0nZiegutS
	RidK3H9wNkbb4eTPl3jyryfRbrywMvCgnqjcCfkl6hgEgmy+uUDdMZKz1B2W3fYL0+yUrTcG10U
	Q6mI=
X-Google-Smtp-Source: AGHT+IF2sjsiKIriN9k9MLVO9isuERZhd0Nn5O8DdxJumL8diOhEnAhV8EbrGFCbyVN+VZPDJSRBxw==
X-Received: by 2002:a05:620a:1b:b0:79f:1731:ae24 with SMTP id af79cd13be357-79f19a65363mr939365785a.32.1720727450849;
        Thu, 11 Jul 2024 12:50:50 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19015bcesm320932385a.53.2024.07.11.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 12:50:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRzoX-00Enm9-3m;
	Thu, 11 Jul 2024 16:50:49 -0300
Date: Thu, 11 Jul 2024 16:50:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Ahern <dsahern@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA: Fix netdev tracker in ib_device_set_netdev
Message-ID: <20240711195049.GO14050@ziepe.ca>
References: <20240709214455.17823-1-dsahern@kernel.org>
 <20240710060929.GI6668@unreal>
 <4f38320c-22e4-403e-8d68-ce04e504cedc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f38320c-22e4-403e-8d68-ce04e504cedc@kernel.org>

On Wed, Jul 10, 2024 at 10:59:15AM -0700, David Ahern wrote:
> On 7/10/24 12:09 AM, Leon Romanovsky wrote:
> >> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> >> index 55aa7aa32d4a..7ddaec923569 100644
> >> --- a/drivers/infiniband/core/device.c
> >> +++ b/drivers/infiniband/core/device.c
> >> @@ -2167,7 +2167,7 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
> >>  	}
> >>  
> >>  	if (old_ndev)
> >> -		netdev_tracker_free(ndev, &pdata->netdev_tracker);
> >> +		netdev_put(old_ndev, &pdata->netdev_tracker);
> > 
> > It should stay netdev_tracker_free() and not netdev_put(). We are
> > calling to __dev_put(old_ndev) later in the function.
> > 
> 
> missed that and KASAN and refcount debugging did not complain ...
> 
> Anyways, why have the 2 split apart? ie., why not remove the __dev_put
> and just do netdev_put here? old_ndev is not needed in between calls.
> Asymmetric calls like this are always confusing.

Maybe it is Ok like this:

@@ -2166,15 +2166,14 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
                return 0;
        }
 
+       rcu_assign_pointer(pdata->netdev, ndev);
        if (old_ndev)
-               netdev_tracker_free(ndev, &pdata->netdev_tracker);
+               netdev_put(old_ndev, &pdata->netdev_tracker);
        if (ndev)
                netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
-       rcu_assign_pointer(pdata->netdev, ndev);
        spin_unlock_irqrestore(&pdata->netdev_lock, flags);
 
        add_ndev_hash(pdata);
-       __dev_put(old_ndev);
 
        return 0;
 }


Don't like that we drop the ref and leave the pdata->netdev assigned
to something with no ref, even though it is OK for RCU reasons..

Jason

