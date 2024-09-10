Return-Path: <linux-rdma+bounces-4852-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2529731CC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 12:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFEAB26387
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87418EFCD;
	Tue, 10 Sep 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrW5H+1w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AC187FF9
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963039; cv=none; b=EifTYz7cO83gnMLPaOGNIooSJSCTe4F9/bQGW2EbTIVERSVw/tcZvr/RO5TVff1T5T+pGlezla2Q6RAqBC0OKkV65WqELJhyn2NEGQytpE8Lj4z2uACFhtgAwiHOTItDruhi346QNOenWm4TnUZxLOYb/ziA8ghhit20Nx2i4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963039; c=relaxed/simple;
	bh=yQgIcAICTK5FSWGbk9Lt7d2+qEYj6jpsnfuNFFZDyvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppW1t3i+WywnkqOvXKYe9pwyylm3YR7oUPxR+CCMkmE9wbZGLG5Oam8nNdhyR+cVxWFo7oJ0Q7ef+IPJPbsgQLOlyhowJ3URVUsPnq9Zvtvl6BKt2jkIP72wrSLyvU+8UhbPDXP7FbfspBUuvuy0nRSxsuH4Ia4SCCZqRtq0VmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrW5H+1w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725963037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coz659OmmUlcW3lKa0lCNSzio6M2iQCVXxig+QSR0UM=;
	b=hrW5H+1wbKRr5+l/WQ2cweyMqgdiT3f/FjBuOPWCWTShjHc0k2r00G/Dr12XplOtvZJdzL
	XyUSAZ57IJ4jNcvRmgX1YHIcsu1sgAonJBqprIR8tYB1EaT8w6AywU77z02aoVoUCXR3LG
	7Ik3+Kqtv/9lUvPPSnyPpv6EyFT5rAw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-sTQ5tNaVMACalDLKEvdeIg-1; Tue, 10 Sep 2024 06:10:36 -0400
X-MC-Unique: sTQ5tNaVMACalDLKEvdeIg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6dc3365so16085895e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963035; x=1726567835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coz659OmmUlcW3lKa0lCNSzio6M2iQCVXxig+QSR0UM=;
        b=YGAxYJjOp2m1w/cr4V+a1vK9P8wkVT3SNQIPGOR8ckOpAvVg1OxWXYzGgGwdwPsXzZ
         LTxn5xXIjeiqXPDXFtoT1IgmeTpYrNqS+PeI+wVHHKGbwF5o+FrVf3/RgC3q+cXlAbo2
         TnbBACwdvpAyHbk8OnxUR9sInHRspIRbimqgWmPhHEjJxf18Sr0mzgFlIkBWynBv7h6j
         fnU+MUYs0EZVsZWljIVDqd2ICD32VYjeNmDpo/j7qczVL1pRRVj/AXcg4q0LSwiOrHd1
         iwBAA2KHUcCBkH++qMPc3Uh3pbkk+F0UIv7LEVl5MVnroE1twBfQhI6f6k7MtRnCSYW/
         nTDw==
X-Forwarded-Encrypted: i=1; AJvYcCUIFug+NTKm62cpROYZ+4ZzzOXRLBNMrVTcH0xciKwEvlG9nb9NzK+F2jYTCCoPgi4F+SdsSdsY0ucG@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQHUaDSYFqKlIqgqGNl81qNDvvlGTsp/F1sNwjZ8TGnca6KUi
	XEAckCrjdbrdr/2YJjUloJzHMbJfvLoehSVp+bgWSyJG5JiZAWypS+tasvcecxYwZq9KajMAIky
	SmVJtrhFVhJXNr9lCy5/V73ExKMJrh9dvw+UUDwF68Xym3p6OUWkKktsfXCw=
X-Received: by 2002:a05:600c:5106:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42cba834410mr35477175e9.7.1725963034867;
        Tue, 10 Sep 2024 03:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3UJumNEoidGRa50Pqmtdr9Dobsm4P/vGruZsRioKW5XA/TzKoc4apQYmFttnD6MjWJ08qzQ==
X-Received: by 2002:a05:600c:5106:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42cba834410mr35476865e9.7.1725963034316;
        Tue, 10 Sep 2024 03:10:34 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21cdfsm105744195e9.10.2024.09.10.03.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 03:10:33 -0700 (PDT)
Message-ID: <8a1684ca-755b-4612-afe1-41340b46f2fe@redhat.com>
Date: Tue, 10 Sep 2024 12:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, edumazet@google.com
References: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 04:35, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit
> according to the pressure of SMC handshake process.
> 
> At that time, we believed that controlling the feature through netlink
> was sufficient. However, most people have realized now that netlink is
> not convenient in container scenarios, and sysctl is a more suitable
> approach.

Not blocking this patch, but could you please describe why/how NL is 
less convenient? is possibly just a matter of lack of command line tool 
to operate on NL? yaml to the rescue ;)

Cheers,

Paolo


