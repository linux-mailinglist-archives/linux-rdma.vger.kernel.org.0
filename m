Return-Path: <linux-rdma+bounces-854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE720845443
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E451C20D73
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62C15AABD;
	Thu,  1 Feb 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJEuApAc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542D4D9F4
	for <linux-rdma@vger.kernel.org>; Thu,  1 Feb 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780364; cv=none; b=IMVUqlmb7JElsrYjGy+3zeYZgUz4JcIeUJE4FgqszB5957X/w/aWEzIDPQHaVA1zNrN4Fj14CmTrzy7usIBV/eVh5mWalZxeJP1Iq6Mp2ODGHsrzA5XSs0qsKBvZxJJX95IFAo1DuU2d208ldHnZJ8WT2fwnkADWeSStDC/75ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780364; c=relaxed/simple;
	bh=iVB9Pw91ZQiqJxhflZjdTstz9BhoeMHXkV4VjV5TLUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3N1wLBvBW1zKmLhMKpakvYivvZfmDK0NLWg69/U0PTA6vW+y4RBIt4lylNesVSr6gtwwjArbuXgv324+Rq/1st+FpA+M5mc16O66xKLZje2oyQrOylSBqH6BIWG0ZuJKTghxG7W8VtJy1iZzOxUY6bFJe3wQ5VBxmpauknpokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJEuApAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706780361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iVB9Pw91ZQiqJxhflZjdTstz9BhoeMHXkV4VjV5TLUw=;
	b=LJEuApAcNUvEJGh6jYdqsr2jSMbXcbWaQTvL0e2TQxHyJ928bgtgtxAlp10qblQH7Qz1JG
	h88ZVhXQxga7RcAWd3M8WySsktwN74xWYVSDO9TfNnnHBqZUcyq1dCcw/tWS1KY0MoBUwl
	edGVEEdkd3AIN/HM52x8VqbjpFeBNvc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-4FQ0f_EpMS2v_yolK8TGvw-1; Thu, 01 Feb 2024 04:39:20 -0500
X-MC-Unique: 4FQ0f_EpMS2v_yolK8TGvw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5111638f3e0so218136e87.0
        for <linux-rdma@vger.kernel.org>; Thu, 01 Feb 2024 01:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780358; x=1707385158;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVB9Pw91ZQiqJxhflZjdTstz9BhoeMHXkV4VjV5TLUw=;
        b=TaeASrIPCzPf9xDF4pXmFTAznVZmgR4a7LVfYPRylySq/uCkGyTjRFHg5kRZ/I9x/K
         q80xAEGfAxgSrVDkLXuFQ89ulNDPZSHnppAQ1r4rvAJOH0KKUMNVTojqe/kIjBg9FNCi
         bw5QL8HR8HGI01ZfeOur1NHZQi6qZi6cp3MmTg8hygCJ6V7i7LPX6hohMUpzBV9mx9IC
         WQe6sGOv7mh+MCPhw7Hov1lXNXonyPoMMYxg7Y6N4QT3mO1K7vG+H70CEzPdvZjXzjPJ
         ltoqcVoPaIza8dDu+NM1blS8uDXKoM2AR1JpkChnVEvpOWjHuo98qUnPS7JqLEEa84CP
         iicw==
X-Forwarded-Encrypted: i=0; AJvYcCWyex25SqdtllbojNeVbEDy288ron75IQVQIyZiTqHKp9zsI261JzXw+0ai8swFcZAxoD2mf8xVGu93YoIuZrs82snVuCmkl7HxxA==
X-Gm-Message-State: AOJu0YzOtFPefGjsPQpxpnJemAnzCImFUFx9t4yG6HH8KuhQbsWrjgSp
	LYbcKeYA7POJ9bs8UdPnAbgkfLvv+cRoiCKwPyu0jrRM4d+/NDrhKpvugX/L84YwjgV7Jn54fWg
	5klVLlKdXCmvonVuaB+NI4oShCC2pbTusTICSodZmPxe2kV5ioj4CErssF00=
X-Received: by 2002:a19:2d11:0:b0:510:1410:5a72 with SMTP id k17-20020a192d11000000b0051014105a72mr2416294lfj.2.1706780358539;
        Thu, 01 Feb 2024 01:39:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPFvjM/R79ElxB+pS6LxWp1kK0YWlG+lxmIeW/pjgJw8faukKSgsRksDo0xlrbAnl/r2evfQ==
X-Received: by 2002:a19:2d11:0:b0:510:1410:5a72 with SMTP id k17-20020a192d11000000b0051014105a72mr2416266lfj.2.1706780358163;
        Thu, 01 Feb 2024 01:39:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c260c00b0040d87100733sm3800016wma.39.2024.02.01.01.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:39:17 -0800 (PST)
Message-ID: <9cb2ec106f3f7864d0128102f9f49f3dbe0e58f7.camel@redhat.com>
Subject: Re: [PATCH 1/4 V3 net-next] cpumask: add cpumask_weight_andnot()
From: Paolo Abeni <pabeni@redhat.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, longli@microsoft.com,  yury.norov@gmail.com,
 leon@kernel.org, cai.huoqing@linux.dev,  ssengar@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de,  linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com, paulros@microsoft.com
Date: Thu, 01 Feb 2024 10:39:16 +0100
In-Reply-To: <1706509267-17754-2-git-send-email-schakrabarti@linux.microsoft.com>
References: 
	<1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
	 <1706509267-17754-2-git-send-email-schakrabarti@linux.microsoft.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-28 at 22:21 -0800, Souradeep Chakrabarti wrote:
> From: Yury Norov <yury.norov@gmail.com>
>=20
> Similarly to cpumask_weight_and(), cpumask_weight_andnot() is a handy
> helper that may help to avoid creating an intermediate mask just to
> calculate number of bits that set in a 1st given mask, and clear in 2nd
> one.
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

@Yury, I guess you are fine with this patch (and the next one) going
through the net-next tree, but could you confirm that?=20

Thanks!

Paolo


