Return-Path: <linux-rdma+bounces-13192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407BB4AAF0
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B847AA58A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D631B819;
	Tue,  9 Sep 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpCxW0qh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33A23A98D
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415259; cv=none; b=PrvrwRB52W0HuFYgm212gsTCb100rmsHMVTfLhSFBsLZ1J7Hh+GNjF/4ZacDCf4eGkcg1fzpkn/9IdjkqnWBA2lhtG9n74ThH4aYeB6iJHe/5rXJh6PNko3FUGrGQhaj9bZ1OoAjwnsJBbFxhc0NqDXFHimkIHBtalr8LlD/JSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415259; c=relaxed/simple;
	bh=HM2NMJxMcYEfNGGq/oJ04HVM1ReMtP0pTKiI9lNtLO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAz84rEFzvRmrrN+nWiBgNrlU3YF8FqJO9WpaoQSG1KW6/WMxDVt34uRsGfNfEw/2d8faZ6BkpTKVy3S6PnAslYylABx20MGT5Q3M5ObToeLQ7GQpUZnGzQqs10dAGsTc/iQzSQ74V9CsSXKTfA/4l8R9XKrzZQGd1yhhAwgS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpCxW0qh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757415256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2SErD9VoCde/QEnC3d+sTghHLcsV0IuUj/e7Q9rJMM=;
	b=gpCxW0qhk1uEeLDpM1/pUgAl4AyIW8/ZxoWq40S02nC66SRj/MnFM2sdqdzlqSL1rBBvvr
	WoX9GE4wlUYeeSEsucKpC59fp9ozXtcoXfakWqtuaODoT0VQaoUiPprs/eMVLmqaZILXax
	vzMrX7rob1OeU464ifRvloqM7u1APZQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-tUEwF0EIOUGRfV2KPyfxxw-1; Tue, 09 Sep 2025 06:54:15 -0400
X-MC-Unique: tUEwF0EIOUGRfV2KPyfxxw-1
X-Mimecast-MFC-AGG-ID: tUEwF0EIOUGRfV2KPyfxxw_1757415254
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de14da365so22975435e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 03:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415254; x=1758020054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2SErD9VoCde/QEnC3d+sTghHLcsV0IuUj/e7Q9rJMM=;
        b=iYUPBOsf2atiE5O2qYDEQ+gP6YsoqYLDvsCFRrzNBEyKbAl/wQwGaeS9F0zz5UB7ZG
         egGpiXYVkLSZ3RpEeDAaftuv79ctEVozcoPlZJ5foC9C7GTq4h97XKCB3OewjPW5iaFI
         Y+EurIh3QBs6+sZR58BaB2R+EUe/+yaLZ0fnqi+eHOwq0XLas+DL5fmRfVDU7R+9JQat
         18SPFnpIHugNzfRZAYG0OZQlE7fw4sA6gIX6Lzr5rkLG9NlBAGi6CG8Tc07222qGQ7hM
         Dxlad/YhAyX8T/otTuWGNxxhamBIUawpxvPZ2MwJNMtNVb/QwnYc1J4wkhHGiqUl1GM7
         YDYw==
X-Forwarded-Encrypted: i=1; AJvYcCVweg5KbEd4Lbe7yLKPgx64OSA0kICBVHeYsVKRQ6C2LW54g1T2T5jNBblgibocB18SP6khY28EKBXl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0f54m+AY9hZo0AZy9DngkkIFZ6oQVg1x60n9SU72VRQkST26t
	MXVzEMJqdUD8LlvT96lSLXM8jueP7tOhBP40l1+U64yFQ/7LEWIMtJR6da7PPoU5yhU5cRye5p6
	XjgBUG2/T5R1CUe9XVRoOF0XtjHgZifHtRuL7EiJgQsC0SaqpnNCx2Tt8v7/aCWk=
X-Gm-Gg: ASbGncvtF8GpYo8STswuHbml48e2fxt4elj5daB0QABSb9OBScGvXBe2aDwhyqsEcg9
	6JXWkKrZishd+G4fW+3YtTdjNemHPS5TKSv1an7mVoFR1PmRQERPvNQgUZaU+riXZ2tnoDxRaXe
	RZrOE3H7FVRPDRTcpawrr5vWvEBRLYIqOhqyL0w26x3IXgxXqDy9biKJe9QODk77za7O+jK/3Av
	Y2JGmMvLuNtz/xf59rvgVspSTL53Hq7IageHvWe9pFWGHuGuaRGqXoOCHMNDLbpkToSteiklUnL
	n0awsc4w0x5vAula+fmWtCgdXBaF2DDQw/sUvVeaqYkt4i7nqWZdJXjZa19bkksckyABuqFPHOa
	txvUN8+cKkeY=
X-Received: by 2002:a05:6000:40cc:b0:3cd:edee:c7f8 with SMTP id ffacd0b85a97d-3e646257898mr10576942f8f.29.1757415254077;
        Tue, 09 Sep 2025 03:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaDykjIB4jgP7Ave7E3MW1xUfG9vBdncrD27nwwsMpPlkFkaSDsK+O0VNW6P6FuPNrXfZBbA==
X-Received: by 2002:a05:6000:40cc:b0:3cd:edee:c7f8 with SMTP id ffacd0b85a97d-3e646257898mr10576920f8f.29.1757415253634;
        Tue, 09 Sep 2025 03:54:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca22esm2336206f8f.18.2025.09.09.03.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:54:13 -0700 (PDT)
Message-ID: <d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com>
Date: Tue, 9 Sep 2025 12:54:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing
 out
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250903163140.3864215-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/25 6:31 PM, Håkon Bugge wrote:
> We need to increment i_fastreg_wrs before we bail out from
> rds_ib_post_reg_frmr().

Elaborating a bit more on the `why` could help the review.

> 
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
> Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

[...]
@@ -178,9 +181,11 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
>  	 * being accessed while registration is still pending.
>  	 */
>  	wait_event(frmr->fr_reg_done, !frmr->fr_reg);
> -
>  out:
> +	return ret;
>  
> +out_inc:
> +	atomic_inc(&ibmr->ic->i_fastreg_wrs);

The existing error path on ib_post_send() is left untouched. I think it
would be cleaner and less error prone to let it use the above label, too.

/P


