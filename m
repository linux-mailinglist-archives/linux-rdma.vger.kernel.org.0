Return-Path: <linux-rdma+bounces-13193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E67B4AAF8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411CB4452A6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE831CA58;
	Tue,  9 Sep 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpyZVbgA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71A23ABAF
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415363; cv=none; b=E9eVMSweDQ/cRr1liN1kFfbmvtMw8YOjhU41Gp2n8UG5vBhUdY1t+9oAbJBMIzlehuBx/K+vdCeHdGajBYiN4ef3t92YSdowi5oVIwle4+DRUY6ujZuwEnXLNIyI4Hz/YZMYBMUsVpSYsVnCnmjyxNjlmR09jMwKXSPQCzxyX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415363; c=relaxed/simple;
	bh=P+FQuJhA1PrMmXPlKv+nsJEpTrgwiKcfidU0cZC6Aa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmhTuIo32bG5qMjE4l/9H1xlQ/SjKl6BRWgdhfN1xdVoYvTL4c6x8//O9YzSXpdLq3ALSJmWuQaYseWhattKiGwjP76O4F5G8Skzw9wRtJaHocyPbY5whiv3MGAFxhq8H+aUp0pWK9GmZiS9aI91zZLz8AxSzs/VRRXUTt4eAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpyZVbgA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757415360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T1K7vaX+eZEVLfGul1pBfoS3Sr2T++RNF7So0hyGuo=;
	b=JpyZVbgA6xcE61N3y0+e7hFiwJCs9ZhXxZHLyg14eJwVJtq4unPeQWetFuzVgyZfCkKb5Q
	tEWfh5jEgYYDY8pwnXzLCbn7px2eyNszHYc3OlL6hWOSW/PakvWED+bl81kkdBBt9OYD13
	NG+m2rbuGMGTDe8VECJTSh7QKfKrP18=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-fZaraeBoMGiK95RKcd80zA-1; Tue, 09 Sep 2025 06:55:59 -0400
X-MC-Unique: fZaraeBoMGiK95RKcd80zA-1
X-Mimecast-MFC-AGG-ID: fZaraeBoMGiK95RKcd80zA_1757415358
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3df2f4aedd1so3970488f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 03:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415358; x=1758020158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T1K7vaX+eZEVLfGul1pBfoS3Sr2T++RNF7So0hyGuo=;
        b=fpLnLlLXoKKwejJJlRb/ic0s9NraTwgPIMxclwWSKwYNw+2PF1A+xp0MQu0TDEa8qw
         IZh0TDuCj5lYm3FR2Bj3AF9HWUIbLk5U7Y0b6rw3Mz+e5O+eRfNMH4BjOrJza/KS1vFx
         gnbw4dCvvyAGT4pEooJVXTtbnOT4clx8JkzmxOYaaQe9PtRTB0tOpGwwapzJbWBA8J/W
         soLYvDUA1gfYEX1GDsskARvdBkEmdB3LxF5CcMc4gH8GadaFaRptITovBlHEw4KWSvB3
         2RwYcXlzZ1BGufiqB+b4VZoeEWkqWiWU7daLRTdF647ux4fYfak6ykGPLV7Bbw40bjqO
         uGng==
X-Forwarded-Encrypted: i=1; AJvYcCUgKlp/+Z3+ZbKZnEg98CtMC3zhTQK8tP3BK8HUVpXcPTd+Q1/TOWBJpupE8CbTil/ZpNqtCOzBD7U2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tQMvBAQmpecDvZFNPBoNnxaF44w8jaFLmPCRJ7CxSy9pcb0e
	shRghRbIWKeJWrh26FeK4hKODnMreqZAaK2ZCSuQMvDwLI1+2fbzA9h9TntFFtrHsAVrkIAXMZb
	HhMUdFIlr9/7OIFz/mGPg2yLnVAq95go44F4gAYgujGdWB4FliIUoYOP0DIXrPoQ=
X-Gm-Gg: ASbGncsRyser3e++qyJElY8o7pcFrCL17MCgP0k+U/lZMELXahJYhJG90FthvK7spiy
	SwoyQgGouFR7ChIQ3sMe7tawG3zaFIp6a2q8Xsqt6vrpiZgoTg+ChkjjhWQYmfmpYUqecNT5m4J
	DldunxT0ivChv5AfbG6ZfJEzphoG2RIfzUjJAwOfBXuzdEjSdHhL2K4Y/2hZLiOQtkFJ/P1Yb7e
	7M2i5IyMVKD3vdbQeYKVIcaYoq8BvCJNHOwuHtv8ZujSeZ1lYTP9VCBpUaj86fUijBsnKX9J659
	57W3vy4vnWWbDqPGvnsnUPCMMt6niv5iMF4kpxHne8erdY9pnnZuytJDxxNaO+2IBxIJyWKlE33
	hE/cBV/pXwaw=
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id ffacd0b85a97d-3e641e3ac00mr9036211f8f.12.1757415357964;
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnmvFRwe+aQHJSfIB96YNcsk+I5KT04KIyycuSAFbcSbi1qXb6O4cvvbjLLpNmJLmEpECY3Q==
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id ffacd0b85a97d-3e641e3ac00mr9036184f8f.12.1757415357529;
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224eb27sm2177631f8f.62.2025.09.09.03.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
Message-ID: <d7026515-433f-4c45-9d24-ea529d5f04b4@redhat.com>
Date: Tue, 9 Sep 2025 12:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rds: ib: Increment i_fastreg_wrs before bailing
 out
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20250904115030.3940649-1-haakon.bugge@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904115030.3940649-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 1:50 PM, Håkon Bugge wrote:
> We need to increment i_fastreg_wrs before we bail out from
> rds_ib_post_reg_frmr().
> 
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
> Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

whoops, I replied to v1 by mistake:

https://lore.kernel.org/netdev/d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com/T/#mb92f279c773d443313f9e0951a2107060078802c

But the comments apply here as well.

Thanks,

Paolo


