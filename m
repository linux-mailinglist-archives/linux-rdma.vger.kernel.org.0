Return-Path: <linux-rdma+bounces-19513-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPPwACla6mmgyQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19513-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 19:43:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF0455ABD
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ED3C3092CBA
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F5A3A872C;
	Thu, 23 Apr 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4S2E5EW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYTmrDui"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639B3033DF
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966017; cv=none; b=uuIHKpOYrNUPbcjn29vl+99J2IPmIGpi2rF+saU3tY1dazL8aMmbZKjBzwZIb3w6bZ/+tGfvh7OB+mukd+/11iYUCErN/lw+SM8xuDNlEyQTM5pjqWXHXdfOMGL+yrkdIw3YCd0NwNqMYFO2EcLnVj5w7blMG3FKzU1d2zjbUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966017; c=relaxed/simple;
	bh=KQAh+QMuqAhpvDHw88zlMyK4p+lE6/dqHN69iRlOpJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oHX9SJmRCLniHR50tm6V9gry3/igxylamORBMtb6PBzXBNLRbu3WRDmHhoTqFL7JVGND+/a030MZt8lcukee7cDfHzPR6HSBA/d5YIvP0oee/0SgKboUPQsNUYkwT5GYTDERt2k/4bf2xA2wEN55cjdKMLQmmZg2TkvU01ImxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4S2E5EW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYTmrDui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776966014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCdvgZToTbAv0JLg8/PC704VUmnH0RtfX94TlcMSW4g=;
	b=Y4S2E5EWpZp5UVWmNFoXr4ay2FKQkEY6aBMmlPv4QUDtionv/ABhShDxZW/C29Iz25DWQ5
	Z9C+wtutUCfTKpEFQikILDLTDb9NtgL9EaK0dythru9O0dklVO77OyQsS837jLSrHFouRY
	y5ZGbt+Hk51ZTtpahUwCOlTzjpZZhcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ZTtlKaccMu6rTdyrSBdpiQ-1; Thu, 23 Apr 2026 13:40:13 -0400
X-MC-Unique: ZTtlKaccMu6rTdyrSBdpiQ-1
X-Mimecast-MFC-AGG-ID: ZTtlKaccMu6rTdyrSBdpiQ_1776966012
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so40686615e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776966012; x=1777570812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCdvgZToTbAv0JLg8/PC704VUmnH0RtfX94TlcMSW4g=;
        b=DYTmrDuic9G8SOGwboCazIucKkemKCzSNrF2QLPuhV3bhPbsVrkD5+aCxE4I+H67gj
         FTXnP8XJri4E1qVPjgrT+aDhC452niCzW+fJo0yMcbAVc43ymJqNPR2JC09OcyNyRpDw
         Ogq+gRCB8gmmdrbVPZD7SP5FBXvBT2EYNXvpoJzuJEqktuEMACEWzS5hpRWkwG/Dbp6s
         FHdVHsLgEsjhn9O/+MdVxaOH3SoxwUxiaF1E4OqZQyHPFpvFZatwTV42X1YAcW9I6RSd
         d8AUfBCaNPw/7AtRywe8KZKJ2Gc1IvI4ieBcd6bMKa9T8YAyfE/GJEWHoKqvleAuJnGf
         G5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966012; x=1777570812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCdvgZToTbAv0JLg8/PC704VUmnH0RtfX94TlcMSW4g=;
        b=L68ssQyYhkoQN+gy/9XKXPGemUnGK45pIBKNUsurRX/cD0j4be9yrxTl2NpnxpX34l
         hzijrrSm8j+g3jd1Sj1UvSPuhU5KJKonqn0zlLAQtZcTfd8Ic4PhAFVvPgvhQsX+nDwH
         EL+ACKzziWrhuDl8UUkTG4p4fvXdivbv3Z3D9yr4a7tDX5hwkJLmqxWgMvlpYGy5NrQv
         g2tDNUJdSgygA9rAR/lAChQCNP8+eXew2SKmJ++bN7bUdYVs1BEyJh1efKODLoeaYCs1
         VdUu9lSqojCX6JEUpYce2Q4nK1IsS2t26/mjVty/yzUwL3io6NY/0uzUumiQBvsMffrl
         xCpg==
X-Forwarded-Encrypted: i=1; AFNElJ8bye/c5kvY4SnRS392sOfOs3kXBbWCTkgACJYXoefvuHQTgdoxIJM8wumbTHPkFNcRBOSbxQxgquyn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrm3Cux2wruH84j3ErUB4jNE5s5B+iF/w9cgNLHiYSaIsgrZ9N
	CRM19NrujMj5x/L+sKb7GpaB0B3Twj5VBUL9LxlZX6nJfhUHr16PChW23/p4cImhcOXvtAo29B4
	jWE1Pb2Y10+LUfMgEO1/BtlslhCJYAP+lJ7yznSQUQpeMqNOOG2fKp/yilVFCyZQ=
X-Gm-Gg: AeBDievSVynUnKwjOxT0k4Xf7/2Yyz/jngHdN6kAeQ6tcUnpx9WR7NpCd0Ov4a25haR
	PfGbnDzTDEb2aVEkLh5RYTy1GvMxYwNPsKAlZ+NK1cIG6EyWTq0YNP6+hWaofktvweT1rJbaNIw
	ZYdasNGWtqx8/lnVjo8Ud5Z84Cg57F8V8QjdEwLT+UFTEUTszxTvqkkhS6+ChyZTIWFyM9U/gO+
	hZRW/c5MsciV8AxesngqPOMACrtK7cfFoa/Hy0TFq/6S5UGl7l9dzdth2AcGM9IyvZtOKxqk+eA
	C7XV5lpu5adWXSDx6mx8IUZF2nDxr96PKmIAX/10Sr/Hm/a65YUkZ/cOcdIqTRLUWo2LeJSzrPN
	mpelxy6n+Vq3T/MYTxa1vIBVUqDPQEJt53gHyaSly0omXL6vuQdHwIMWiCr3xbFZ2UFM=
X-Received: by 2002:a05:600c:64c8:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488fb7a0d24mr426776565e9.30.1776966011857;
        Thu, 23 Apr 2026 10:40:11 -0700 (PDT)
X-Received: by 2002:a05:600c:64c8:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488fb7a0d24mr426776145e9.30.1776966011366;
        Thu, 23 Apr 2026 10:40:11 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2634sm168387025e9.28.2026.04.23.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 10:40:10 -0700 (PDT)
Message-ID: <e6aa13f1-4284-4ae0-9dda-1a506e729156@redhat.com>
Date: Thu, 23 Apr 2026 19:40:08 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: Dragos Tatulea <dtatulea@nvidia.com>, chia-yu.chang@nokia-bell-labs.com,
 linyunsheng@huawei.com, andrew+netdev@lunn.ch, parav@nvidia.com,
 jasowang@redhat.com, mst@redhat.com, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
 <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
 <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19513-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,nokia-bell-labs.com,huawei.com,lunn.ch,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ECF0455ABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 4:19 PM, Dragos Tatulea wrote:
> On 23.04.26 09:30, Paolo Abeni wrote:
> [...]
>>> ---
>>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> index 5b60aa47c75b..9b1c80079532 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> @@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>>  
>>>  	if (tcp->cwr)
>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>>
>> Here there is an open question for nVidia:
>>
> Sorry for missing this question in v3.
> 
>> Is the above enough or will later segmentation lead to the wrong
>> results? I think/guess the firmware is (still) aggregating the wire
>> frames using the ECN schema, i.e. the first wire packet has CWR == 1,
>> the later CWR==0.
>>
> For mlx5 HW-GRO a packet with the CWR flag will flush the previous GRO session
> and will not start a GRO session for this packet (napi_gro_receive() will be
> called on this single segment skb).
> 
> So this change won't impact the current GRO behavior from the mlx5 driver/hw side.

OK, thanks!

For my education: doesn't the above also means that mlx5 will never
build GSO packets with CWR set (and so the above statement should never
be reached)?

/P


