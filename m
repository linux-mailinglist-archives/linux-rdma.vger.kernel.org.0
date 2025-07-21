Return-Path: <linux-rdma+bounces-12366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC585B0BF6D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 10:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613A81899812
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07B222424C;
	Mon, 21 Jul 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYE+twWZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC00A920
	for <linux-rdma@vger.kernel.org>; Mon, 21 Jul 2025 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087785; cv=none; b=u/l/IqZku9n3gewXAYdjfvfk5L9SLJ5xcX98U8IcvnQHBiGrQz1y0Rgkf3kHW5nEyG/Oji6fbTTRh6qC+CChv2GXD5V6H20TKFWjxPWpy7XgFvockosHfceCs6Cxqy38w27AndVe1veZ126xXLcz5kFoIyYVkeHrhQxPHoq/hu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087785; c=relaxed/simple;
	bh=O86pCKYYqFW3brRImFAd909wt+XrZ1IcPtW+VeAnRLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DERow9qdDZE03fA+VU1nqBEBgQgChbQqlvlpOcnbAyqGWNVatiDe1RCGmv3sKJkSnT8lsDWttCJdBE7lR9yoqcvGyYm7ZcMN6p1rdsGEXISl8CzhZ0D/hQGPKbr7ilKy7oTa5VLP5RqLyEhdAFrSR8agTZyTX4Oulc6l+lAbUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYE+twWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753087783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eEyJkY9ZcW+iRGk8l+mt+fm3yxn1zcNir5mSzl4jwkA=;
	b=RYE+twWZLmHIHlUDJqv7kPR1kKmLh6G7bvsCFgAlBX6k6hk5kPdfdb8zxWSVb5Pjm5CcJX
	t4GKikXPu5dvf7NwgwIreI/USh0pvORrHp3InngGgIR2EQKTfkC+Z6bzF53E+cG2MFO94r
	bqc97A2eDteH93YGuMiaOF8pDpe88HA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-WN4oUP1bOM6HBAUWP8sGsg-1; Mon, 21 Jul 2025 04:49:41 -0400
X-MC-Unique: WN4oUP1bOM6HBAUWP8sGsg-1
X-Mimecast-MFC-AGG-ID: WN4oUP1bOM6HBAUWP8sGsg_1753087781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso23797135e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jul 2025 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753087781; x=1753692581;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eEyJkY9ZcW+iRGk8l+mt+fm3yxn1zcNir5mSzl4jwkA=;
        b=vc5g42S4SY1qVW+9UarBVrTv/9JOPyD/7HowMZUI6mYRi8yX+hlGn93SmckT3nTDQd
         yEoAqBwsGpyE/HCvFhLcrJrQLVRbImoyU+Y2qxH8LowALWCr0BlbpGqjqVWsXe34Cd5T
         m4g8iAY+YUMvG1mWvIROv7aePGoUWhPus6IyROhHYM8rNMprZ3cIuMNu6T2V9mf36qFk
         efJj53NtyfmA66PAP4oQTnMI2nMa1BNNgPoNx/JAh8qj9C7yoJDHaXsoSu3Ib4/DyEDv
         Avq9C34s1p+gheONASb+23ciSqIuzkdxz8r1nKn0TCPxLQed5xt7mqx5eD41u93fEvfA
         3Lyw==
X-Forwarded-Encrypted: i=1; AJvYcCX1LFDOOerFVX4nvZQpjZSYxDLkSuKL7sQwpV938RHlSHpcfMCKg4HgiCTmi04eU7uG11bmqU3+IEVU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywni5GcnpH8RRKW4o+KbvnHpA88u5Je0/9kDhS5vCV61rFoo09k
	YBd7TMzNjTnwpf7tQbESTSV9XAxc0ijeqaFmQ73reS2shdVjp5c0ARDflK5DQi1l5EGn+OrX0cM
	woWX7RKuha6dRAovKiUlXaRzdRyBJa3GJdisZtxROZ94BT9dpivbrCLVaPE5tGC8=
X-Gm-Gg: ASbGncvQLfgupTSx6ADtLBlJTco8iK/LFCWP9pjpBSj7CVwLtnDbVX+MMgvOCUIJXpy
	MqmnH/fdhMil3mLPOeXM083lNZvNYYW5wBiz9Js5XW5PJPZ8+LaZKrDOrXIFzMrCtGHUyas1NeQ
	an9ppe5dcnsrWQAoug+E8+o5OZKHqf6q2/bchRYEtxBD6KC1l1t8Q09vtlHa+ZJQkaddvMYZzLt
	0EqzYvSwQ4sQAv9hDHcZRinkLFHMZR5IfhLpQw3wkhc8OYYSVYSKmJ5gvkLCefwYzePWdano90x
	ZXLV3l2MVUt9UehN/RepbmiSHl9M0lYiNF73EmSCR1BPmOpbgoUdg1xcg+8Iaa6k0aYT60giRc3
	RuDJRsFSc5KWhzmn2a2tJm0gqoiHKGhI8sut5QrBjVrWY91fLEQfjsJ80mpP2SmVY
X-Received: by 2002:a05:600c:c0d0:b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-4563a54de9amr96245085e9.14.1753087780605;
        Mon, 21 Jul 2025 01:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGDXuvG/9c+M1TgLOa2nxRpw+VaS0oi8mIDcJ1ihrrncI17JDx29cO0dxPdF5voli4IFz5OQ==
X-Received: by 2002:a05:600c:c0d0:b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-4563a54de9amr96244645e9.14.1753087780049;
        Mon, 21 Jul 2025 01:49:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d732sm9673327f8f.61.2025.07.21.01.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 01:49:39 -0700 (PDT)
Message-ID: <8b6e6547-cb39-4e64-8dff-6e16e27e7055@redhat.com>
Date: Mon, 21 Jul 2025 10:49:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
 page type
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250721054903.39833-1-byungchul@sk.com>
 <e897e784-4403-467c-b3e4-4ac4dc7b2e25@redhat.com>
 <20250721081910.GA21207@system.software.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250721081910.GA21207@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> This will not work they way you want it once you rebase on top of
>> linux-next, where we have (from mm/mm-stable)
>>
>> commit 2dfcd1608f3a96364f10de7fcfe28727c0292e5d
> 
> I just checked this.
> 
> So is it sufficient that I rebase on mm/mm-stable?  Or should I wait for
> something else?  Or should I achieve this in other ways?

Probably best to rebase (+test) to linux-next, where that commit should 
be in.

Whatever is in mm-stable is expected to go upstream in the next merge 
window (iow, soon), with stable commit ids.

-- 
Cheers,

David / dhildenb


