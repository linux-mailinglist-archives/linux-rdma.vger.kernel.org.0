Return-Path: <linux-rdma+bounces-21274-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LD9IQFTFWqmUQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21274-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 10:00:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D795D22AA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 10:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB3A3046378
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CE3CCFC3;
	Tue, 26 May 2026 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgPyLX33";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VH9/Lbkk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B443CC337
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782222; cv=none; b=sN92I5d9NpWoC4dEf4mRrlgf54a5/rXLuLiIylmmAcj+NrOJEyuJHNf6uIeR3vAb3pd2OGQ49ZalJLrGz1nkc2B4BoM2J7BAKwvPfGsm6tfzj93rxcx5By3JhIlg/o2OZyvr3Ltf9uxCRfD8FRdzJ1ERBxa/OuRjx2QtoWdBaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782222; c=relaxed/simple;
	bh=/PP9KzfPgPPYnf2CrAWDmtazkrFsrTswwQu774a4yhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwx+5FTzxD56BU2iD/34DW6cUx7Y+M6y4pTk6yZXgZRUCTQu1ilstT5YzjMxONMZH2i+J72HDE7BEkp/lKQqOND0xbbAQcgAqUZnk9blhaZ9PQ9CEetTgZedKdndnZY94dgWxjkFhjBXJ9u+xO5i9UbX3YTx8yFoNkIExmCa78M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgPyLX33; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VH9/Lbkk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779782220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY7mocn0KmK7ngWOScBkr1Rtj5DdaTsx0/KZ/kJfr9c=;
	b=IgPyLX33s/b/IOUvARHD0oXqIfJNxDFT/QeiDUJ+pfGayc/0Du3wQKoe9qVOpnz3dfovaZ
	+YbAcM01chNX8nEkQbZ485jRlhPDYlPE0Cd/chW+ygSBfpjC93AVNi8hvFKfcPn6SDBqkr
	R5vPj5qFA/Vd0uIq8VRQrdRCYui0AgQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-8fKiYLBjMJyuHDu1fc4EwA-1; Tue, 26 May 2026 03:56:58 -0400
X-MC-Unique: 8fKiYLBjMJyuHDu1fc4EwA-1
X-Mimecast-MFC-AGG-ID: 8fKiYLBjMJyuHDu1fc4EwA_1779782217
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd33b4921so66518575e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779782217; x=1780387017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xY7mocn0KmK7ngWOScBkr1Rtj5DdaTsx0/KZ/kJfr9c=;
        b=VH9/LbkkwS0NbcLcsLN7YRwBlTeWuxFwtIaKrqB79eMwECjIdNus0UxxWUecS2QfrG
         6qsHfHvvlLq8YIaA94GjA0AG7pzaz9VS3RT6D8IuFT7D3XqN2qsSkn7t47HkKeyr8bPr
         LWqkRerrmpTh9Ltbi9L52Dce161lmnz0b///4udVT5xxGlfND8meHV6KeM3jT09feH0q
         mJu+ezHC6w/tPJny48v3Ej7WlrMMTVTOadmQXmBzOcFOzwkxrkbWjFwmiZ9OQNfV9qNs
         Eb2tcTX2jF6vZss7DD412m6GZAm6nJN5eIJKH0m5K5Fpun5S1acDVz6Ujr0XAm735mhA
         swnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779782217; x=1780387017;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY7mocn0KmK7ngWOScBkr1Rtj5DdaTsx0/KZ/kJfr9c=;
        b=XH24xogbehEPxmyicsyf/9GUL683603c5Ht8FNtk50cuRIaHHS6P7MdQm/XusGYqya
         IFknxQQFNDud965T9HoJ8HPoz4oqzNCp4YDXxXpmGAzYGAVIze9wl8cMndaBGcUHO7H5
         I7FjQXNsi0444l36CyQ05h4sSCkN+g1l8jVvJ7x/jx9fe9l9t8iDok2T7JWcO7HesiRO
         HiAuVPi4WTUsdeWZnauMuPHtcohnSOU7rX2Il2frE2MdUIl1tNR6/FBi7+3uy6KhDu2i
         vEZx5sqHnDmvjRa2IqKQy6gi9Jiyv09N1uFb3p7FUBuNsQknveRCQJCAoAnc6pSdqRao
         k1uQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SFS5O0b+7YfjAid9cjJEgdp5L0Au0QHCDCO4A7Bs7h93KIw1O7ApAbnRq4ldIQlKTSjA17VEDoKxd@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWf0bw1fRZ4gWNf1ZaWL08lx4KDhQw1oYHVSUhrUuxdwzaKs/
	t6YwsMoDFmel2H95cog4lY2cmvvVy1cnr7ZVkn42RMu7cnU7w8/k/v3p0P7BKTooxEoDpjP+EDz
	o+I/DDZimEBep7WD5IN1GAcWnR0ctfGZdCDQ2tD5gVfwyo4bxfx3fWPIgB2QmYUmric3ZBF4=
X-Gm-Gg: Acq92OGgLillH/yBBf8jExpGS2ofNeGqQJHUAEt5qtFdxxHuyOExilCMxgsqA0S7aL2
	vazP3+w0LCZUif2Hi1royNrmhHdk2fN9J5Mm3HW/Ln2KyMCNmVIOUTlOZOZJRgtwaUZAF0IdJW/
	SOmoowu9OsLhDUv+Vz9RKd8InBs55TWwaOejH1XURk80Z/kFbF1J03bB86PnpPUfxiQfUnT0i8D
	448LPsOjUybmwG5WDZUSRZyWVD19soe4mcrBsQH6x5/uRj2DDnDc9ypyw4Q0iGSc9n8R+qcR1ZI
	hoxExGt/5uhckgYNcDBcRR6RpxJCaYq+cSbD7x7v5HqXwXsO9L/4NY/I9Q9qmNNDEpatYuubpH3
	PZkr9YsCAmrOGsV7c3IUKHzcEI+aod+m6DGNWM+BEW7i4TCVcISb5JPJ8ZQ==
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-4904248ad4cmr214893675e9.4.1779782217130;
        Tue, 26 May 2026 00:56:57 -0700 (PDT)
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-4904248ad4cmr214893345e9.4.1779782216746;
        Tue, 26 May 2026 00:56:56 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm322436755e9.9.2026.05.26.00.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 00:56:56 -0700 (PDT)
Message-ID: <caa33c6c-2864-47c1-a111-06422d3723c9@redhat.com>
Date: Tue, 26 May 2026 09:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
To: Tariq Toukan <tariqt@nvidia.com>, Yao Sang <sangyao@kylinos.cn>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260520102130.423044-1-sangyao@kylinos.cn>
 <31260e8f-15c3-4738-b5b6-67b0ea2d3b0e@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <31260e8f-15c3-4738-b5b6-67b0ea2d3b0e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21274-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: D5D795D22AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 12:47 PM, Tariq Toukan wrote:
> On 20/05/2026 13:21, Yao Sang wrote:
>> mlx4_init_user_cqes() allocates a single PAGE_SIZE buffer and fills it
>> with the CQE initialization pattern. When entries_per_copy >= entries,
>> the function copies array_size(entries, cqe_size) bytes from that buffer
>> to userspace.
>>
>> That copy is actually bounded by PAGE_SIZE in the else branch because
>> entries_per_copy >= entries implies entries * cqe_size <= PAGE_SIZE.
>> However, GCC 10 does not derive that constraint and falsely triggers
>> __bad_copy_from() in mlx4_init_user_cqes().
>>
>> Cap the single copy_to_user() length to PAGE_SIZE to make that bound
>> explicit and avoid the GCC 10 false positive.
>>
>> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
>> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
>> index e130e7259275..7b024a5e13c8 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
>> @@ -314,8 +314,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>>   			buf += PAGE_SIZE;
>>   		}
>>   	} else {
>> +		size_t copy_bytes = min_t(size_t, array_size(entries, cqe_size),
>> +					 PAGE_SIZE);
>> +
>>   		err = copy_to_user((void __user *)buf, init_ents,
>> -				   array_size(entries, cqe_size)) ?
>> +				   copy_bytes) ?
>>   			-EFAULT : 0;
>>   	}
>>   
> 
> Thanks for your patch.
> 
> This is a compiler issue.
> Did you try fixing it there first?

AFAICS gcc 10 is a supported version, the kernel should build correctly
with it, right?

Also AFAICS this is not fastpath so an additional check should not be
problematic? Perhaps a warn instead would be more palatable?

		if (WARN_ON_ONCE(array_size(entries, cqe_size) > PAGE_SIZE))
			// ...

/P


