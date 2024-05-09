Return-Path: <linux-rdma+bounces-2365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC98C0C32
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A71F22F32
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97AF14A085;
	Thu,  9 May 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/HzUbKH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C925149E07
	for <linux-rdma@vger.kernel.org>; Thu,  9 May 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715241572; cv=none; b=IsmZMFBW0kpnXkvVSuj3Nu2xPJHYFqdNiO4Olp986Uq6Aqy4ysZL0zasSPRuXA3dvjA+lIAn1Tp7Nx1l46KzdNTa24c6yzggRTNOyTCp2q1amI9FrDfTS5sMp+dPz5zgPqTfruHIEC1bIvAAIZOaqMpZlH6kkERc0r9w+yWM6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715241572; c=relaxed/simple;
	bh=0jZ43QwfPkiBipK0twPxmlWJCKVbIdNETVAtX95REhk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHADNc+4rwC0YWGA+hdHKRSoMW9qd/yVsYKshslHrSnZ024QYHyUvQGsAYLbTyAE6TOO1l3x8ps2qE/KrCZ+43hZi9qpKfD1ha253JvVuko+rjf9y242qKNWxbVjOTQ9QOITrX3YqjEzgO7X/uiiLpTWuZMqVUiTm+wCxllBQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/HzUbKH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715241570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yjn42W/o/LOj/jSJgIWj/Vg3N4yLF7R5ejTMZiQDXvM=;
	b=N/HzUbKHa8P+14B3OF/3l96PG/HWioo2PJYtE1OEJaQBMp+znIkQ5wiVJSxgcoVmEmBAum
	vM0/5NqAXmf+3fOnBfuww6tGSan4gCLsVtFeypfOF2jvzipQd/RE9rGjeA19XU6P/z9/ZD
	AEbg/yWLSAwhdtOEkXLEZwhZJubonyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-mvS8NlhrOhmemWCANo4uEA-1; Thu, 09 May 2024 03:59:27 -0400
X-MC-Unique: mvS8NlhrOhmemWCANo4uEA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34ef7d11a78so78781f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 00:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715241566; x=1715846366;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjn42W/o/LOj/jSJgIWj/Vg3N4yLF7R5ejTMZiQDXvM=;
        b=m9UYRleFe1Of0gZu1UQujU6AKDjdgUNbB8DAZUmvoD6KKl/FtORSZyABfMWqW7NAdL
         JLlOJQz2WMFNPmz12Ae37dhJoo/VUo20uMikGYnivJV50jtcJzQhJ421v2XBCXvED3qW
         4YjG5/x5fWh5itvmzPEP3dx0EQTR0a4K87BrVmRRXzddBKMMFqirgBIQvPDqU6xNZxEG
         rpdL3esEbDSF3SNru1aCTHoNIYb8UNdYkBj4N8xhVmL1ehLC2CGSZeVSIrNg19UAvpo2
         Wb18vGrLai7WUJnjAz1E1WHid5OiQe/tFqQBtutSRq3GdFP6TiksodYX4cBbk5cXNas7
         4Qlg==
X-Forwarded-Encrypted: i=1; AJvYcCWtZyn4JPB/JG93tzUygNnvK3Upo5EBANXH712/yvM5VFTMGmOV8uONzE+WxFH08NXCt1KRO4UZ5OXimfnwSoLJJDnetqb02RXdWg==
X-Gm-Message-State: AOJu0YyiAZvQy0O98z5WVrVGzPwpxfr071RUlmMG5JkEl/F8+ontGrGQ
	SmhCyRpxnqTSmY6L5egoIMU07M6JMcgfJeJ/JfDcxo3rpW8DCEJxCW79rnUjzBEOl3P1YE+MpQ4
	XnurDFx5bp/mm3tAmre0mCjfrRJcdTNQurbjGL6L+Rgg5L1SZuLqQDYnSY64=
X-Received: by 2002:a05:600c:b44:b0:41f:cfe6:3648 with SMTP id 5b1f17b1804b1-41fcfe63810mr6921405e9.1.1715241566712;
        Thu, 09 May 2024 00:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwrk8LgSZgMX3L0wE/e/4bo7w9alQYn6RfI6mS+/NPJ8rwhS/tbGTF5kFnddiBXFQPikowKA==
X-Received: by 2002:a05:600c:b44:b0:41f:cfe6:3648 with SMTP id 5b1f17b1804b1-41fcfe63810mr6921195e9.1.1715241566345;
        Thu, 09 May 2024 00:59:26 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10:ff61:41fd:2ae4:da3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fb5sm15844475e9.9.2024.05.09.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:59:25 -0700 (PDT)
Message-ID: <e9633d41d0d004db3ec6e2b6d9dcb95d029dbb94.camel@redhat.com>
Subject: Re: [PATCH 1/1] [RFC] ethernet: Convert from tasklet to BH workqueue
From: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>, Allen <allen.lkml@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Allen Pais
 <apais@linux.microsoft.com>, netdev@vger.kernel.org,
 jes@trained-monkey.org,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kda@linux-powerpc.org,  cai.huoqing@linux.dev,
 dougmill@linux.ibm.com, npiggin@gmail.com,  christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, 
 nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, 
 marcin.s.wojtas@gmail.com, mlindner@marvell.com,
 stephen@networkplumber.org,  nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,  matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,  borisp@nvidia.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
 louis.peens@corigine.com, richardcochran@gmail.com,
 linux-rdma@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk,  linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,  linux-mediatek@lists.infradead.org,
 oss-drivers@corigine.com,  linux-net-drivers@amd.com
Date: Thu, 09 May 2024 09:59:22 +0200
In-Reply-To: <20240508201654.GA2248333@kernel.org>
References: <20240507190111.16710-1-apais@linux.microsoft.com>
	 <20240507190111.16710-2-apais@linux.microsoft.com>
	 <Zjp/kgBE2ddjV044@shell.armlinux.org.uk>
	 <CAOMdWSKfkT4K9MAOn-rL44pycHPhVDj4CtiYkru5y_s0S-sPeQ@mail.gmail.com>
	 <20240508201654.GA2248333@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-08 at 21:16 +0100, Simon Horman wrote:
> * As this patch seems to involve many non-trivial changes
>   it seems to me that it would be best to break it up somehow.
>   To allow proper review.

I would like to stress this latest point: it looks like the changes to
all the drivers are completely independent. If so, you have to break
the series on a per driver basis. Since the total number of patch will
be higher then 15 (maximum size allowed on netdev) you will have to
split this in several smaller series.

Beyond making the change reviewable, it will allow eventually reverting
the changes individually, should that cause any regressions.

Thanks,

Paolo


