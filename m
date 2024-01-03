Return-Path: <linux-rdma+bounces-534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE918234E0
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 19:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E08E1F25683
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCA1C6BA;
	Wed,  3 Jan 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LmiPGfC+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860641CA85
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbd721384c0so8849361276.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jan 2024 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704307686; x=1704912486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhPl6n+gaHRZqX878lSuSjjHaJIqMMwAsnd88hKX+7k=;
        b=LmiPGfC+MKvX6Fgcq0PEdfR/GO8u7NK9swKzUJAyJFbyg4kOlbrbN+j3ioyjfUu0Pr
         dZLOJ7PylQLsdTnuyW7bHi0mG5UF2uf6SZwAnLoZ7v0Vp5heXF6dp76rpE2qTp5v9lqU
         vMo89V+1Z3ZZeMECWOk9mi6y+kxBCqpLhzliZIV1FBaMXsgXIgP1xnhb0fPbfDUCopak
         RlZYt96xqfhCuFCKGrSk7EosEz/dzPguegK3fpqj9i5zqAUwhCkRMKLZQqZyhZ2MyLG4
         GDHSNQz3AzTGx+sV9qfTvXFh3AFiPrinHAfh7Iea4kirKE0+RHUUJXv6ANeBhvX7EtTW
         KQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307686; x=1704912486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhPl6n+gaHRZqX878lSuSjjHaJIqMMwAsnd88hKX+7k=;
        b=fl8flFvQgwy95X5+vxZxcAXrESQ+fGHXhEPvWFYVopRDvi/UzvfuvEBPxHY20MDkXf
         MIM2dOEyuZ/0IaWvzwer5uop2dGgvcVJFv3AsjqvfM3nhafKlznaVIeHHM9q3gjRwWCO
         4RILDZXvDkfaowVdq3117U7gJW3Ug7tgj6KcOm6fjhA3X3bqglxxCqviPol8+41NHxYg
         sGMZe+jfQvir1QAYOi+HxiRYhTBl5Zi9DrxEO8ELE6gOJfEjfRkqUsSxbecSyGxTMlG+
         07FymixmKHBqubp0Jmndkx+dr7ZlMUNPxuLgwlgsCQrFZmPM8NU8o38lPpvGpqrGoQ+Q
         60Bw==
X-Gm-Message-State: AOJu0Yw+5zU5kFjBBQP5wI9fj9wuRdS0ObuRZbT9YnwdjRlfwdH8vx/0
	DTGSsqb2WKkPng9PSXgogGK6NLFkfOKHtQ==
X-Google-Smtp-Source: AGHT+IHKWGLvLZUPJL8bZ4+1PfDyD4XSImEoClSZMSeMX+NcmH91Do12c+kWsJ2zb3rFDLDm/c6U0A==
X-Received: by 2002:a5b:810:0:b0:dbe:82bc:5676 with SMTP id x16-20020a5b0810000000b00dbe82bc5676mr2344620ybp.11.1704307686377;
        Wed, 03 Jan 2024 10:48:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id cq5-20020a05622a424500b004181e5a724csm14393361qtb.88.2024.01.03.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:48:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rL6Hc-0013gY-Hm;
	Wed, 03 Jan 2024 14:48:04 -0400
Date: Wed, 3 Jan 2024 14:48:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng1992@126.com>
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
Message-ID: <20240103184804.GB50608@ziepe.ca>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102034335.34842-1-lishifeng@sangfor.com.cn>

On Mon, Jan 01, 2024 at 07:43:35PM -0800, Shifeng Li wrote:
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 67bcea7a153c..85782786993d 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1315,12 +1315,6 @@ static int enable_device_and_get(struct ib_device *device)
>  	down_write(&devices_rwsem);
>  	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);
>  
> -	/*
> -	 * By using downgrade_write() we ensure that no other thread can clear
> -	 * DEVICE_REGISTERED while we are completing the client setup.
> -	 */
> -	downgrade_write(&devices_rwsem);
> -
>  	if (device->ops.enable_driver) {
>  		ret = device->ops.enable_driver(device);
>  		if (ret)
> @@ -1337,7 +1331,7 @@ static int enable_device_and_get(struct ib_device *device)
>  	if (!ret)
>  		ret = add_compat_devs(device);
>  out:
> -	up_read(&devices_rwsem);
> +	up_write(&devices_rwsem);
>  	return ret;
>  }

I don't think messing with the devices_rwsem here is a great idea, it
would be better to address this on the clients_rwsem side like:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 67bcea7a153c6a..b956c9f8e62d34 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1730,7 +1730,7 @@ static int assign_client_id(struct ib_client *client)
 {
 	int ret;
 
-	down_write(&clients_rwsem);
+	lockdep_assert_held(&clients_rwsem);
 	/*
 	 * The add/remove callbacks must be called in FIFO/LIFO order. To
 	 * achieve this we assign client_ids so they are sorted in
@@ -1739,14 +1739,11 @@ static int assign_client_id(struct ib_client *client)
 	client->client_id = highest_client_id;
 	ret = xa_insert(&clients, client->client_id, client, GFP_KERNEL);
 	if (ret)
-		goto out;
+		return ret;
 
 	highest_client_id++;
 	xa_set_mark(&clients, client->client_id, CLIENT_REGISTERED);
-
-out:
-	up_write(&clients_rwsem);
-	return ret;
+	return 0;
 }
 
 static void remove_client_id(struct ib_client *client)
@@ -1776,25 +1773,31 @@ int ib_register_client(struct ib_client *client)
 {
 	struct ib_device *device;
 	unsigned long index;
+	bool need_unreg = false;
 	int ret;
 
 	refcount_set(&client->uses, 1);
 	init_completion(&client->uses_zero);
-	ret = assign_client_id(client);
-	if (ret)
-		return ret;
 
 	down_read(&devices_rwsem);
+	down_write(&clients_rwsem);
+	ret = assign_client_id(client);
+	if (ret)
+		goto out;
+
+	need_unreg = true;
 	xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
 		ret = add_client_context(device, client);
-		if (ret) {
-			up_read(&devices_rwsem);
-			ib_unregister_client(client);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
+	ret = 0;
+out:
+	up_write(&clients_rwsem);
 	up_read(&devices_rwsem);
-	return 0;
+	if (need_unreg && ret)
+		ib_unregister_client(client);
+	return ret;
 }
 EXPORT_SYMBOL(ib_register_client);
 

