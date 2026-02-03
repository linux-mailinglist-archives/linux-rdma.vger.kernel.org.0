Return-Path: <linux-rdma+bounces-16444-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LpJDlzKgWl1JwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16444-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:13:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A225CD7630
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80D60301A434
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A2939C64A;
	Tue,  3 Feb 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SoKVqs9w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8703241665
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113623; cv=none; b=Upyz2lmRGPMoLt8aAP5FolNPKGhiCJkBzkT0eILexSrbadBcWbJ3E7f5r3635ykoVR5sezNdqpvk7dkQcty3XGXna+Tkwe8bVwv5LypvcX1Ba+szw9khZLKQhqzEk5f3WjZ6I0oyVAlSejAQMBryLrM2nK+FlA3uq77bSOr7JWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113623; c=relaxed/simple;
	bh=TeKZGOc9Xvz25crrC20NSAEadK0ejDklNsjXNkboATI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD3m3eYQZThmGxD92cGmxG6T9eMNPf7yA4ZchOy8ypEr3uCn6bvniEtEsDK9HUkkokjR6M1caX5v1OTigyRvCLBZdK0Lx0OmT1X9ssfdSJY7eBv+XM5SAjQT+uU/tHPGYZ5QiVmKIejfJJl4toizijzRGnMZEDXK8Ofcv9TmyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SoKVqs9w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso25637305e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 02:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770113620; x=1770718420; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi69d8zzokYhgp+qw3Zk2njXeiMqfE747MZMvYSJbDE=;
        b=SoKVqs9wpteCg6nsk4nzC1/PMbopbteKlE/Jah0f2+Ef6wgJs2Xkxsx+SVdyO+8GuB
         N2FYig1cZCNEBZIlMn/WhiGS+4gDKC1LMhfIkuEzukB1+AZ2Yxn+0waZdksZdx56qpSL
         qZgzzbAAOEWedWa+IV5pCjmfoqtmXiEfSs5vzi4KYlFrTW8hZcwOGRfZTVaciRWn13Vv
         Ylyx0HQfdF97vbtNE4Ax6y4A4Jm1FAAydTv9+kjtrkAuRZytDWhlRe0bETYWapSqmM9x
         DQ8GJJ8QI0UIrsfQp6eom6UlOgwCMhJUeAx3PcNUvAVoabYkgcwiBE5piisdpZpeBC5W
         06Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113620; x=1770718420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi69d8zzokYhgp+qw3Zk2njXeiMqfE747MZMvYSJbDE=;
        b=bAXZ8fl2GXGqmyGD+QZGQNzwZUTvdiKj1dGVFj62CG4fFGUYyq91xYNHrOZfVZmcuf
         X5qoQSXvv3yFLhao6GgbxQ2KrzjD4HShSAO4op7i3oZdC3NErm8ygMU6ipxTJZKRxTjk
         Zld44uPk0Htm97rOT3iCeLWr9AKm4j1Y3V5A3sWPhdkBC8hdjGkvMnJiHMZmhZgvOb46
         eEWGbgy5nG4QxtSuiOsdPcRkuTwNMWkWo+Yh9q0IVIGJxygNaBjTuD4IlFUDq8GhtvRz
         McPQ3T/K93V+xyYH7uNLQVL83/bwgOy+PdRUpaVCE0zHh3hQFCRIdKjCaEvV/RKO4h9i
         FEkA==
X-Gm-Message-State: AOJu0Yw7+2sZSCwE6VTTV/HhjjlBnpvDQJJmjgNfcUTKss5HftAzCoel
	5023FFuDJARjz9lD9PPst57obyyUcHUAu7BSsI8I6BHxdl+TVcsgJ1tr9CvEHcojw64=
X-Gm-Gg: AZuq6aJdPBhM9wBy5CY/lnBq1y1wojeAEByGmRKQar+YZuOtTi9JpmNqGjCJyAGMAfY
	Iv8+63kkpdYnqkJOop7djr+d/MG1nbv7GswKgrN8gcgvcf9DluiaeP5ETKrNQhi+z1muv/wsKmc
	JA2K29/0eIqf+TNqlnrPzuvyd2t15uonzhAiG1nVs+CfsdBmQrrgz/ViSIPCU3KxAfqXjMHUz4X
	mTi4kYfCpCVvNwkuMoW4mYX+ad17HICLxtUHPfMGqDtvB6YV5bOhpi8ZouslhB4OWtrNT6Q5j4k
	6AT9F//c7xOyfrLg1mSyipRJQz7hKTetciZuiaXOzpCpN13zXoyC6ThqbT+vtEDeDWIaiJF6Yqz
	2OO0wbmvmOqFXnXx0FSdXiCcrDzV2qKPKKJVQmFEyl85st35pj50rAZu6sfmPgtMGleh9U97Nde
	/XZQOMxmbpV7QzM6Ar8c8RXLo=
X-Received: by 2002:a05:600c:1da8:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-482db493ff1mr208350515e9.3.1770113620102;
        Tue, 03 Feb 2026 02:13:40 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm53545758f8f.38.2026.02.03.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:13:39 -0800 (PST)
Date: Tue, 3 Feb 2026 11:13:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, wangliang74@huawei.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 00/10] RDMA: Extend uverbs umem support for QP
 buffers and doorbell records
Message-ID: <n2lj2rw5slpmar6m66jw7pdbwcubpsisjvokawtmlxpka7yaks@fiyzcfwetjtz>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203095933.GR34749@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203095933.GR34749@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16444-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: A225CD7630
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 10:59:33AM +0100, leon@kernel.org wrote:
>On Tue, Feb 03, 2026 at 09:49:52AM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> This patchset extends the existing CQ umem buffer infrastructure to QP
>> creation and adds doorbell record (DBR) umem support for both CQ and QP.
>> 
>> The kernel already supports CQ creation with externally provided umem
>> buffers. This patchset:
>> 
>> 1. Adds umem reference counting to simplify memory lifecycle management.
>> 2. Adds mlx5 driver implementation for the existing CQ buffer umem support.
>> 3. Extends QP creation to support external SQ/RQ buffer umems.
>> 4. Adds doorbell record umem support for both CQ and QP.
>> 5. Implements all extensions in mlx5 driver.
>> 
>> This enables integration with dmabuf exporters for specialized memory
>> types, such as GPU memory for GPU-direct RDMA scenarios.
>
>What do you mean by that?
>
>Are you referring to the RDMA dma‑buf exporter from Yishai?  
>The GPU dma‑buf exporters already work correctly with the existing  
>RDMA importer.

Basically it allows you to use any DMA-buf exported memory for CQ/QP/DBR
purposes. Currently, only MR works with DMA-buf exported memory.

