Return-Path: <linux-rdma+bounces-4593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC6961867
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 22:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF45B22DB2
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97728155A24;
	Tue, 27 Aug 2024 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdFQA4vC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED582877
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724789751; cv=none; b=sGyAl/byh6W92WFjtR5+P2njlnZvAbWwT8wtNRmB9FqiJyceyVM9YyefhpcizmeFYd6RiMr8N9ffAbDCN+tHTN9eLxFIYvqn/YiTWXTxetR6WMj8LMU0WA8lzP3GySoBsBKOO3r9KRmDpiQoHW0REZ6J+2DohcpINumrz9ixfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724789751; c=relaxed/simple;
	bh=+K94W/ALThtA6wBOfaiW4hbmTMtZQfn7rh3EWYe2YUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiAvX+HCdwzouWpBRRHpIJM9XPVAGhTVfFSUuJk6470+Mz1QoSfi9hPOsVuXALWOkfLmO2kHfyesalS1qYODRfVXM4G38VYdPZbAeAK56IJfYm5WIC4Y8WbfddwTPygVO2yS91O7IWOSg2veGHoU59xqKE95Tastb7t/vanqUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdFQA4vC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724789748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tkTEnSk5gZsoaeIIhhfIjqpUQpx+Ss4nHPGthUsVQ2s=;
	b=OdFQA4vCD6VOrD6+AXIfrutx7K+yqdIhBobY9XlaUstnviY5433jHX5K9LCg5WafEJF9S/
	kMzpnTE6pl05wIQjjBCAfIFEw9t8vrjPL5gxlPb/exJtSv/qYkqEgwyZhtMLGzEoJxVAd3
	p0K5febFEtucL9mdyrCj+lAjjt7R+94=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-QqB7TdwsOzuy_E_3XppeZQ-1; Tue, 27 Aug 2024 16:15:47 -0400
X-MC-Unique: QqB7TdwsOzuy_E_3XppeZQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c17f1a7011so37850996d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 13:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724789746; x=1725394546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkTEnSk5gZsoaeIIhhfIjqpUQpx+Ss4nHPGthUsVQ2s=;
        b=AMtFy8wPmW16K9qeRLggxBMDRAnnmkY4b2jmWYJeZM9kfSRYSzrDIHcuSVT8KSSFZe
         Q6NfiLqX4tBM/ZbgEUOJP9KKmKmlP0PK/1IzFr8ymdl+4VAbErDCqeJsfieTRPt8LV2g
         TJHyetxhEOG/IBsURspjFQfYuhbQ9w9adxnjJzZDspxVr/RjtP2DMB5y38lV8QNXZNmS
         wJky3LxNJjL85heTTHM62fQiJG/CDtMkzp02TQZaj9fhOha1Hdb4Ko1pYVuPxXDgJPnR
         qq9awEu8W4d0UQ15AQk6ymVM+5LR77T2DluCQiocHttq2oVTnRAwY8yAHOeYgdglk/WD
         kKMA==
X-Forwarded-Encrypted: i=1; AJvYcCXVXeLLYRCA2tpa+6FMYzVveC2354OyNZUc/oXtAHwTFXFsMqUjb3HV3BV1pL/ptaFraM1NYOLKvj8r@vger.kernel.org
X-Gm-Message-State: AOJu0YzI53Qp+5rYffWp14Hyv5ieLq/xbHxCRj0MEIwGOh94Jg6+5S0T
	FFisjEd/BbBX4jg6jJkhNpbFd4tm5Yqm8vfQqT1jauH/CAe2i3jiGwNXOKYwPddJ624XM8LCwjH
	t2nR9Dwu99EcseYTdQdbaf6LNUdtzqbSBx/NKNF8+hjFR9MSfS4hzRzHEgCM=
X-Received: by 2002:a05:6214:43c2:b0:6bf:888f:847 with SMTP id 6a1803df08f44-6c32b9295b3mr33720746d6.56.1724789746544;
        Tue, 27 Aug 2024 13:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8DZYWJvJrfdcJOorv+lq6yqV0CgJjtznYB7d4lBivv9t/a/sX/1JskI5MVpECD5nZlh4FXQ==
X-Received: by 2002:a05:6214:43c2:b0:6bf:888f:847 with SMTP id 6a1803df08f44-6c32b9295b3mr33720516d6.56.1724789746130;
        Tue, 27 Aug 2024 13:15:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcddadsm59545846d6.121.2024.08.27.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:15:45 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:15:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, yu.zhang@ionos.com, mgalaxy@akamai.com,
	elmar.gerdes@ionos.com, zhengchuan@huawei.com, berrange@redhat.com,
	armbru@redhat.com, lizhijian@fujitsu.com, pbonzini@redhat.com,
	mst@redhat.com, xiexiangyou@huawei.com, linux-rdma@vger.kernel.org,
	lixiao91@huawei.com, jinpu.wang@ionos.com,
	Jialin Wang <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <Zs4z7tKWif6K4EbT@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>

On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> From: Jialin Wang <wangjialin23@huawei.com>
> 
> Hi,
> 
> This patch series attempts to refactor RDMA live migration by
> introducing a new QIOChannelRDMA class based on the rsocket API.
> 
> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> detail of rdma protocol into rsocket and allows us to add support for
> some modern features like multifd more easily.
> 
> Here is the previous discussion on refactoring RDMA live migration using
> the rsocket API:
> 
> https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/
> 
> We have encountered some bugs when using rsocket and plan to submit them to
> the rdma-core community.
> 
> In addition, the use of rsocket makes our programming more convenient,
> but it must be noted that this method introduces multiple memory copies,
> which can be imagined that there will be a certain performance degradation,
> hoping that friends with RDMA network cards can help verify, thank you!
> 
> Jialin Wang (6):
>   migration: remove RDMA live migration temporarily
>   io: add QIOChannelRDMA class
>   io/channel-rdma: support working in coroutine
>   tests/unit: add test-io-channel-rdma.c
>   migration: introduce new RDMA live migration
>   migration/rdma: support multifd for RDMA migration

This series has been idle for a while; we still need to know how to move
forward.  I guess I lost the latest status quo..

Any update (from anyone..) on what stage are we in?

Thanks,

-- 
Peter Xu


