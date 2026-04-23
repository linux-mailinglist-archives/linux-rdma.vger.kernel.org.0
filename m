Return-Path: <linux-rdma+bounces-19489-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLPgHLvK6WnAkAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19489-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 09:31:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE044DFD8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A6130120D1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DF2FD681;
	Thu, 23 Apr 2026 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4OPni3x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et9GL2ag"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643023AB9D
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929457; cv=none; b=p7KiLF9y37YcCP16bbUvBqE2k0N3h4LX91DH0F7r74vF2frImFJtpSUgl99+aoSk4VEfsC7WKR0BdAlQ3OMSBDeA5mfckQu/V96UnYUG2MW9jms7l6WPDzfKfI4ewJ+ZiaSRM/l8v2ZL3akFD0/GF+cBk6P3b7tEvN4IMBuBJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929457; c=relaxed/simple;
	bh=cZZnB85C1jBA3mp/5zy8LbVQVH4qbWdytWi0irVH5UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m4T/zi3hh+OCseg+TDEXDiWBneHyKVpHzlmYVHQe67NElm5Smersw+VJd88ZS41R3v/CtoWMxZ+LSO0cwPm6Anst1qx0ubW0SoaDARtDJgIs3VCsnGFpBbuI94ZzxZrWLUj7wsv2LOMyz1Mg//t2QLZ/nww8KX3vQ/UBOZjEPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4OPni3x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Et9GL2ag; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776929454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLbD7/ECvoRRH75TnJICcJPpJ48ZpuSj80cuAJHg7hk=;
	b=O4OPni3xOBpni0JZpNupbMWVnvNO8qyf6lRf3TUB8dSDxtluRZbQnoejQK1zspranIMiXi
	u9x2+EWbXdMw52e4M/xpq1GLUmAAMsM4zC6julgIMuCRj5INVPMmZke3VcP5cZvXKmJOv+
	nELjcD8j7s8ravroE3vmViQ1AG9pIWE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-bSXJM8NCPQm4y0qMk73YBw-1; Thu, 23 Apr 2026 03:30:52 -0400
X-MC-Unique: bSXJM8NCPQm4y0qMk73YBw-1
X-Mimecast-MFC-AGG-ID: bSXJM8NCPQm4y0qMk73YBw_1776929451
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48919890a95so30092075e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776929451; x=1777534251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLbD7/ECvoRRH75TnJICcJPpJ48ZpuSj80cuAJHg7hk=;
        b=Et9GL2agBpFkGmRZYThECAB/L/EluQUAfkPrflVn/zBFU1DsGsz9kbbkx6493HcmHw
         hn0MkFb7bDFjryegy/0JfgBgD1lFrZ3atG3JDARm19gUhnOUOF4vk7Km6EXH+amz/Cuh
         5lQaTKe+Nqfv3QlLL+io3DVIuVp95GSOStHpJUMlNVgjFsDtk+X6XPan1cSj+rCKuDC8
         ZonM2dDHL2MYzNM9RO6h3xmnfLH3undAMWYlLKP2P1OWLwQ0PfX86pR5bik/M+0oEQVC
         hkedCDS3dVh+fcnUbQvhK2ICjUN6yKsXQFUYXO+47i0uPudtyf+GyO1ZhFiuE3Nup3cy
         WYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929451; x=1777534251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLbD7/ECvoRRH75TnJICcJPpJ48ZpuSj80cuAJHg7hk=;
        b=j/rB5DdWCRrXW45Wvl0mXv+D39gA0NHfEcKrpYosELAKM7eJ2mKq7plEZRo1VyHspV
         aLmGLEyLESeJVtAGqtXDsp1HC99nxkMyoCTh69Ly0iBUcB1LPtuURQqehoOBRntctmiJ
         02Mq+WKBu+Vw7tHSfZvfXyTPqPnvwA44wTOi3hlxTUumvXOIq0+mTdVzzYlXG51qSVvF
         IlEAb2tLUjNPfVMLOmanKmBbSsbR+KdFFanaNqHnN082CwKN4sGwQLHFlPrG7tNnsIoK
         lvoNNnnQWnqw5VUKJOmNa6hZbxxaPF6Ij01ugL7cVRNDoo0vV+Y0iqqvCgOY3/swc6tj
         pztg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zoothk/pSy4a8ev2BCCu8QM3SJfVZi1AnKR96s93JS9KBQn3rKcdvZ57FoGAYGtDnHERQPMdB1Ryk@vger.kernel.org
X-Gm-Message-State: AOJu0YxClhpb3wZBz7zAfR385vAOC0/ue8T6MB2Ic5E505wW5lHS2ZYc
	gRhJojGu8zYVmyKJvwF1frQi7AZirLj+GJAnt9RU7Ztf/YQkFIG93eZLb4oHbkF4Wrh+FgL/dOA
	bRI7D/MSZD4LyRYsPb9t1WUGeDrb3h4GQu/gaoZzR4SA4jUXjAwDLLNcR/LZZTzw=
X-Gm-Gg: AeBDiesJrsY/nzrjC0XtYFr4+CiEgMXh0DvVzQXdHlylR0s1PgC7nob4GDdOy4HpBLM
	M5lv0Cu/QXN1K6qW1E8CwgHPAPCXX4gp0Ikluqsu0vQS9tqlqtHf4CmAakiQqhwbJ4W55mXgWN0
	rPsHcKKtxW6c/JccRHUcHiOLVADQSIn9b1zN+IyNwuxqS4IB2EUNxnvooZDg8aESVO8sR/NmviN
	nwCwlo/+T5Y2BHfOMa0K3cExf05Ty9AUAe7k8fxqCfiUZoxJcVUR2uJyc/rbXbaFb3AvA5OYefY
	IlaGl04b0oKBtR6swhKja5Vo5atvCbIscxdJEZYLdTXdB/zzkxR6YaRgtxhNdDPGZ2iM8QKWdTL
	l0Kbam/nR8NtGvm9QzX9WRj1Fs5YqO09oOI/fL+SnH0l4bEpnheYYp8d1OHkBcXSHrkA=
X-Received: by 2002:a05:600c:a416:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-488fb73a9b8mr301932225e9.1.1776929451159;
        Thu, 23 Apr 2026 00:30:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a416:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-488fb73a9b8mr301931675e9.1.1776929450661;
        Thu, 23 Apr 2026 00:30:50 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4896c2a1804sm126727665e9.4.2026.04.23.00.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:30:49 -0700 (PDT)
Message-ID: <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
Date: Thu, 23 Apr 2026 09:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, linyunsheng@huawei.com,
 andrew+netdev@lunn.ch, parav@nvidia.com, jasowang@redhat.com,
 mst@redhat.com, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19489-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 17DE044DFD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 5:26 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Currently, mlx5 Rx paths use the SKB_GSO_TCP_ECN flag when a TCP segment
> with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
> valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
> offload to clear the CWR flag. As a result, incoming TCP segments
> may lose their ACE signal integrity required for AccECN (RFC9768),
> especially when the packet is forwarded and later re-segmented by GSO.
> 
> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
> flag set. SKB_GSO_TCP_ACCECN ensures that RFC3168 ECN offload will
> not clear the CWR flag, therefore preserving the ACE signal.
> 
> Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 5b60aa47c75b..9b1c80079532 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;

Here there is an open question for nVidia:

Is the above enough or will later segmentation lead to the wrong
results? I think/guess the firmware is (still) aggregating the wire
frames using the ECN schema, i.e. the first wire packet has CWR == 1,
the later CWR==0.

If so, later segmentation of this GSO packet will emit CWR == 1 on all
the packets, making the egress stream different from ingress.

@Saeed, Leon, Tariq: could you please have a look here?

I guess that with a more conservative approach drivers update should be
omitted, and the updated documentation should be less forceful (i.e.
"TCP_ECN should not be used in RX")

/P

Thanks,

Paolo


