Return-Path: <linux-rdma+bounces-12250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F495B08A84
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598DA58347D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2166129992B;
	Thu, 17 Jul 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS7OKs89"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75D28BAB6
	for <linux-rdma@vger.kernel.org>; Thu, 17 Jul 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748125; cv=none; b=WL/GmolXEqQveCpnt9V21JnAtmRhEuUPD1Yt35Sv/rGpof/sbJduObFtlUIEmNr6IAMf4xlizX5vU1AEPYOl17Gh0m44NwdZDZaNBRaMaMb9+k3a+6wkWzIOe+DksuhwvQHjEZEpgWFL12ebQpC8N4w4EZTSKlkxHz2ca6lOOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748125; c=relaxed/simple;
	bh=jUdhsdYpTt1d6dMYdauSDmb89Vp8/6bJZpeXdUWuSsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffuu6lUvXBa5s1dOsssBc8JikAnrqTv/x9kwYPrsJlD2MPOdW9pCPEnAz5/v6h6v5U2i46ZjKV6bo5JFy8XliGIbwiiwLJ4bkOIxv1vO22Q3qpN03tBfp0uo37oAeeCm3xSptawm14wDqqHJ2ynzwBtwsZH76BFRGUiYpFAM4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RS7OKs89; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752748122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7gVITUafWmvL5PweD1Qd+07vmGN3UO2X3r0tdcxJLc=;
	b=RS7OKs89s+FtDGmsPmbuHsWBePCB94adjnMi64VZveCThnfNpfmBEHPbXNzBcIBf7ROLsv
	0i8sLtT/xGxXGTrDTRHbbzh2f9nAIyThirB9IdzW7cUi4MO1C+EnjykLCvE2F9exFl8QeN
	gznWB5lbuAy/6Thi6lCyjfshzMmrq5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-sPJ-ekf8MvGMJn6yTOiOIQ-1; Thu, 17 Jul 2025 06:28:41 -0400
X-MC-Unique: sPJ-ekf8MvGMJn6yTOiOIQ-1
X-Mimecast-MFC-AGG-ID: sPJ-ekf8MvGMJn6yTOiOIQ_1752748120
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626532e27so5277825e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jul 2025 03:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748120; x=1753352920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7gVITUafWmvL5PweD1Qd+07vmGN3UO2X3r0tdcxJLc=;
        b=UHsjrNATWs2fWq53hzedMQ974RwRARBYTZbYLlmKp2jz8l6KR+0+sp64dtDbgrqd7L
         Rr5IlqllFlL+uzo6J+FAAtI3Jb421lqT3Jghy2mhHtY35YXt0Cot5HDxHdJhtxBLru5y
         n17DgSMwrKW6oYmact23P4HQ2gshYoWtdKTLabWGhddIju3hNglSEwdg8jyPyi4jCmop
         7oiZfgDXnsTjqK7mysRkFuJYrA2M+KOBF6qIlRmTeLGpebo3VS9DxD72bKRVgLEqf//M
         mutnxtJGUQrZ5kFVAu/W2SGYH38jsZMoBJhT+ybBas4p2N0BzuyS9ObO6P5BvRbfrZCx
         lHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vLlsUQspUCqaSk9PlTpGe8KsPtr6OdV2AYFaZ5qShEONC7DKo2LqPckac7nikHzJA84ZgDErbp1b@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdjzNOiGJVxuK5OS3a9e5OU2IYMEzIDBasFoRzX2fq1pAWTuk
	bVnj5iPYkyJqEd7vKHO64d6kyj63wgITmltfvWx0N6ySaBgMBylzQafRBsgoqpy2VacIn6eMV3o
	iwHQUX2/wCbNDkXrFs6h0JL/KUPfGUDdmthFEq8x05O86MkFW5uRlepmgHmGgSZc=
X-Gm-Gg: ASbGnctVklvDsGlL0jnsiASljV8bbjQWwFroWQe6Z51l/lVBePQnJ5OWsnP/y+fYzZD
	FguKswtRmhBO2BcI3lQGR9zyewKFRRDWBwgWmBO+V53AZU0eon1psjMs1ZrNUEnJzXgOF6rG8l6
	zHF0pEaezZtT4Z/P0muEArX1VFdRY9RQIv2JQSGCNsJgqfND1+RcOtc1ugZgGQmdNx9hDIOt7lV
	RWyAwF2t/k5E6HK2Di7hz6L63xM/hw2LwOoQI+s7giZYNuNJO7oA2W9Q7i5usCSy+5lO2LAH/sZ
	pHBaW6GAlGET3jNFDiUaIJ0h9k3JjY8GaRE9Z23C7xbn76x1lV/Te6tnlGULifz4jpIDKpHa2Om
	9TTXi7TYiOLo=
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45636ba6679mr19417635e9.10.1752748120046;
        Thu, 17 Jul 2025 03:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOgkOEHOyVE2SiI81qsIVA8HiJTkl922ofyx4dAQycRB8e33j49uQgyInv7ji80BkcgiT9JA==
X-Received: by 2002:a05:600c:699a:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45636ba6679mr19417235e9.10.1752748119597;
        Thu, 17 Jul 2025 03:28:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd180fsm20192295f8f.2.2025.07.17.03.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:28:39 -0700 (PDT)
Message-ID: <245a03a1-a2a0-4975-a68b-c70d22d01d97@redhat.com>
Date: Thu, 17 Jul 2025 12:28:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,rdma-next 0/6][pull request] Add RDMA support for
 Intel IPU E2000 in idpf
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: tatyana.e.nikolova@intel.com, joshua.a.hay@intel.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, jgg@ziepe.ca,
 andrew+netdev@lunn.ch, leon@kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714181002.2865694-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 8:09 PM, Tony Nguyen wrote:
> This is part two in adding RDMA support for idpf.
> This shared pull request targets both net-next and rdma-next branches
> and is based on tag v6.16-rc1.
> 
> IWL reviews:
> v3: https://lore.kernel.org/all/20250708210554.1662-1-tatyana.e.nikolova@intel.com/
> v2: https://lore.kernel.org/all/20250612220002.1120-1-tatyana.e.nikolova@intel.com/
> v1 (split from previous series):
>     https://lore.kernel.org/all/20250523170435.668-1-tatyana.e.nikolova@intel.com/
> 
> v3: https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
> RFC v2: https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
> RFC: https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
> 
> ----------------------------------------------------------------
> Tatyana Nikolova says:
> 
> This idpf patch series is the second part of the staged submission for
> introducing RDMA RoCEv2 support for the IPU E2000 line of products,
> referred to as GEN3.
> 
> To support RDMA GEN3 devices, the idpf driver uses common definitions
> of the IIDC interface and implements specific device functionality in
> iidc_rdma_idpf.h.
> 
> The IPU model can host one or more logical network endpoints called
> vPorts per PCI function that are flexibly associated with a physical
> port or an internal communication port.
> 
> Other features as it pertains to GEN3 devices include:
> * MMIO learning
> * RDMA capability negotiation
> * RDMA vectors discovery between idpf and control plane
> 
> These patches are split from the submission "Add RDMA support for Intel
> IPU E2000 (GEN3)" [1]. The patches have been tested on a range of hosts
> and platforms with a variety of general RDMA applications which include
> standalone verbs (rping, perftest, etc.), storage and HPC applications.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/
> 
> ----------------------------------------------------------------

I had some conflict while pulling; the automatic resolution looked
correct, but could you please have a look?

Thanks,

Paolo

Thanks


