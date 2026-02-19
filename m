Return-Path: <linux-rdma+bounces-17017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKuBAHojl2lvvAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 15:51:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E315FC61
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 15:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3718302A073
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13033F8A3;
	Thu, 19 Feb 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6rYwGr+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmiA52kq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D08271A7C
	for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512658; cv=none; b=E42e7wObLsBrni3VptwIoi3FDCqIe5upgBN5kd4ybNG68XurfsKZrhMsEmsklPH1Ry2hvkka2o0eF4HD/mpdbiEH6uTOrJ2ISjMa+DDIK64TqZvsEd4U6YH6cEwSEoFFpwgJBXWvDk0bfhUKAPOzUQgv1bjPFLPNh7euFjZgKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512658; c=relaxed/simple;
	bh=IUKUe8GoHBuGzxepuqMAXSFVIp+TGQPP0FqUh2pe8x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MheuEME8c78Dn0sVMGhJo4+c1/JjapQLJPwz+3HH9RYy7j0KdgxjkahS4Gyj75eyHm6ITVd9eD/lY4RAonT+1gRi/06UqkvhPqbIlDnuaJ1jhvIhbm3UPY01/dHzmhsZSATC5/aW3yTegL31hpwvF34W2IuXBHsXpyktDaRPwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6rYwGr+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmiA52kq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771512655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2WZ9tx3rIcSueP45jXVYlGnSogEcFBgeLMEKKVsSp8=;
	b=Q6rYwGr+mKtNnsDxtzXngVkq9HkrvGg1dleC6ouiHdHIpEYbswy6qSHzfQPskT3hrMWlSL
	u+YcvxaMgQmdYMGDZUOIjls95CRW7hqOxhY6nRWxpOk7PxsdEOvYaVmBtZCi449YaTKjru
	R45ftMogB8/0XwnWkO7b/MtDR7ZZzB4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-cuEbaK7JMneB6SbiLGhhSg-1; Thu, 19 Feb 2026 09:50:52 -0500
X-MC-Unique: cuEbaK7JMneB6SbiLGhhSg-1
X-Mimecast-MFC-AGG-ID: cuEbaK7JMneB6SbiLGhhSg_1771512652
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435db9425ebso1060103f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771512651; x=1772117451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2WZ9tx3rIcSueP45jXVYlGnSogEcFBgeLMEKKVsSp8=;
        b=TmiA52kqMeu5qwKsnYstfro5xY25JB1T+goGwLIs6nYRqpnAzPGtl+Q1DN2KQf99d/
         /XO+snDVC/eVkblKazVKK0i8s4lny6cBIY26LAr1F/Ugq6yv5JzudEjU9Q0gV9srECgy
         P3AV7Nk41T3BJIXmv2glOxeUckKX1UEd5SA7pGIKGfvMfAqJHlTr7wZRpuP4sNFsXaV6
         1uhIufVF/6Shon9FYZRJbh+VD4hutDaDis4u8ZEk56iC1NGfN2x/KmJh2EDptAYLENb6
         lPKjFwO9uuFUtQ0qHmTwiKzsAbmWHXDa867EeH+9+D6VymuqjRjH+zcwdKoH6+5SLI2c
         2wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512651; x=1772117451;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2WZ9tx3rIcSueP45jXVYlGnSogEcFBgeLMEKKVsSp8=;
        b=J46m7rEnl2DDk+ER6IyHzCfOdDXdogoQyYMgRhh9KxO7FN2DpCspo2yzoFHW/KYCdP
         zCKwUaZTC+tdj+DgSeLc5Ykvo7Hw/IFfI9/psJq06Z1LzLSCKlml2LNtW1LdGQj4038w
         mJS9uyn1tmjrZ2YQKEYd5xFm7V1CiYOmPfipAiGvw1eMDKpuqXd1xj949BNUFVMe7TNx
         44jB0wBLEDMfDplfNh3pY9bO0Si3TSuQOyAIpmJ4gdxODeASecHAsUsgj0VhHun+pXc+
         MzYT+gceaHPZPEm35DHpkyh4HJH7s9zH5m/BK7LJrle/aPR6vjIzbUepOzo6q2qqDHiS
         CE3g==
X-Forwarded-Encrypted: i=1; AJvYcCW1DzLBYNbw+IYie0sXY1+G21AgP9LchsNY4k8DSj4jfw4a1DlBnvvathd31eF3ajWRwKtVX2NEp8C5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/XWuarwfispQV0wcHL4RTJKrivrXIeSHCd3GCPH8tnJT7E8H
	DAdBmR1EBjUqtgIVWb8qo7Y7P2mPQSs/ZjoYx+yQWaWWBPeeQzadJEeWZV4SFlQ9+bibgWoRoqN
	HNG4ROmFLI6AyHcP3oBrcfiQBUtR3mP/kEC1XNGIvhDtJ3c5Abdb1mAb2Q4SylOs=
X-Gm-Gg: AZuq6aJ5A6BEyWF5hzdLGnmBxB017sAUMgm1WsAHdjU9uligNHvH5yuVAYNaUTgugZD
	KWvhYkajiqs+zJwws82GMpxDTVZi0pwHXhxOKQ4avlXEik2zjeGHCKO8nMkgR03iGHrwEUL/m/L
	cOFIBg9AeMigjw6i5F+/H8QFuLktUQIwXEa0d+YSByOxvaWmJj215Gikkc7Sb55v1nOaWpjmJSg
	BljNxEyMcKhVQFXQbH66yWtoUMg9V3kVxoZk4NwYerHLAsv6otrvqq3XyP42G4w2s4JJInQEe6V
	7VYFIlLL5wx3zV3SXEzyY4SeD+wlrwiPuqeUdR56JcqYvQkTSMgrxqJhheEo6FREh1+Gxj2WkNp
	mBxzZIyxASsNOfqY2fOsbIg3R
X-Received: by 2002:a05:6000:2003:b0:437:6dfe:1b89 with SMTP id ffacd0b85a97d-43958e58522mr10231006f8f.61.1771512651533;
        Thu, 19 Feb 2026 06:50:51 -0800 (PST)
X-Received: by 2002:a05:6000:2003:b0:437:6dfe:1b89 with SMTP id ffacd0b85a97d-43958e58522mr10230941f8f.61.1771512650975;
        Thu, 19 Feb 2026 06:50:50 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439567aad3csm15691609f8f.36.2026.02.19.06.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:50:50 -0800 (PST)
Message-ID: <62393422-bc8f-4676-bf3c-4d1be15ab800@redhat.com>
Date: Thu, 19 Feb 2026 15:50:48 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, parav@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
 <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
Cc: shenjian15@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 linyunsheng@huawei.com, mst@redhat.com, jasowang@redhat.com,
 salil.mehta@huawei.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, Jason_Livingood@comcast.com,
 cheshire@apple.com, rs.ietf@gmx.at, vidhi_goel@apple.com, kuba@kernel.org
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,lunn.ch,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,comcast.com,apple.com,gmx.at];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17017-lists,linux-rdma=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[nokia-bell-labs.com:server fail,sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 683E315FC61
X-Rspamd-Action: no action

On 2/16/26 9:51 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index efcfcddab376..64fb829e1f0f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1137,7 +1137,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;

Is the above enough or will later segmentation lead to wrong results? I
think/guess the firmware is (still) aggregating the wire frames using
the ECN schema, i.e. the first wire packet has CWR == 1, the later CWR==0.

Later segmentation of this GSO packet will emit CWR == 1 on all the
packets, making the egress stream different from ingress.

The above question is mostly for Mellanox person, I guess..

/P


