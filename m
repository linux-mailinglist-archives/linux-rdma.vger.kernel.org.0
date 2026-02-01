Return-Path: <linux-rdma+bounces-16302-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAk4MVAXf2nkjgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16302-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 10:05:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B609C54E7
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE9E3014967
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Feb 2026 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912931B823;
	Sun,  1 Feb 2026 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejGiy0yY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s9jbkz2e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A962E613A
	for <linux-rdma@vger.kernel.org>; Sun,  1 Feb 2026 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936713; cv=none; b=CWvf0BJqmgDdj+b9KW0REAiSoh1ABft1ZNNKM2HK/a2BuvZrpe9f54dO4+cWHP3Qm3ccjIOoB1byC1qbwzDfh1SWOkc1rcu7Q9Hx5lo+C/feXLLzy1JQvwfbujgHRRWw5dAyNCbzFpdBE7x/wbh6EcAaJtv1+kTxuqGSqAg1ItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936713; c=relaxed/simple;
	bh=QEWaTUGYIM3AUbjp29sbAba2kUUYgtptVEBxmi5dzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnSH1TGbctS6xf+hHYBpz64YluDxIN0HWLzzf0EHTF2YRmWWM7x4iDcE6OBKJSpZITupV1oM0rr8/ZDQDasXG0brp6n8Vp1godtvrlsI0fkZvP/GeqzyHVt66auTnESY60tn1IrEyyMtlQCIbLJwBWBL+kYewOKP2noby1L1w/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejGiy0yY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s9jbkz2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769936710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
	b=ejGiy0yYrlzERbxn0s2DBF3yBt8IdYwD/wc6fstiXSGud87n2f//XjK6JbPl+8sN0CqxXh
	e5RnJobBpuccb2BgpDlvWNN+Y49gydQtD8bou+OoRdNJdeCEG3plp2zxAzVxIIRU65rQn7
	fXo2u1zIfUNIwTjqlAJukEWIKD6zlN4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-3p5kUOurNFeGgoEbJiXo6A-1; Sun, 01 Feb 2026 04:05:09 -0500
X-MC-Unique: 3p5kUOurNFeGgoEbJiXo6A-1
X-Mimecast-MFC-AGG-ID: 3p5kUOurNFeGgoEbJiXo6A_1769936708
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso30187305e9.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769936708; x=1770541508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
        b=s9jbkz2eN7gN8syjeRgCFBcAIhMN4Cqa7RPo2gQzAk7QQaEaNTrdAEQ3fo0ittNrUc
         tWpHk2fyq5itdr4wZDZ8TYYruwRCJbdGhZ97rsSjgO6Cc9eHzgynsc5xxHa2kiebCW3T
         3pFO7TBti+J8H2dgL/KU+qk8Lrz36ii3SyNG5cxOC4UlsqnybTlmPXpwtEDOHdS36pJf
         J6PFL9bjzJ1oKiYQ12pzv/S0WIlfQ0H4rldQtethFVKKlCYYZBvqKSHuRhew8xL7KGmY
         sxD+oxG70O6OG90PBqxLRwTOUtfO19jRRqRlXYB/Dpt016wHR/C+9wrJztGJdDtmf4yW
         Ijog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769936708; x=1770541508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
        b=xO48E2oH2jA1tvvOcBr1TXSdvJ/nPxCUx7XJz6vXpil8Bo4aoX26qj+t1dPtyHJIMd
         cVVHlmOrBXK+I6R6RP3wEH5TeJ3pwGKN3xUCgZwb9cwmiDvQ9Zk7fjKlZkQKz4u/hfPr
         9tcfHrGm5aFLos0FQRdlaWZgRiYEnAiJWCp4H6N4ETF0nCULEtj5cJjAxgFmZK6HQJGg
         UrNFoiI0oQcMS5JeDN36hIpnm+ihKR3SnJYXv60x32zI9ci7IiX9TvlfU46g4TsXqSQz
         DkHaMlRBS6YVFl9hcX1R4hyjv4Oyw/A5Io0bXmECgyhvBSzMyfjc1Y0fAPpu8tMsnhsI
         G2zA==
X-Forwarded-Encrypted: i=1; AJvYcCXraPbGm3oKDQFYdcIZtk/icd+hIAm1jfHFrhvF3Kn0sukwC7t0C8Jz6/yWJbzl6pnyD6315SeBimIT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NmGJzpsap0mO//Q3TF3nJVHMKGRAFCVkh+aM2t5hEWT51i81
	xJ2hVa/2cinY8BlNX/x94FQKBImrORGRb+hrCRzYBIW9A2QpXZwK29IutjyfeNJKTN/nAS0GJqS
	W8Q3Hh8NyM5n5zKqeMIHCJqzIxcAy0LjA1WK5Dl0Lkr31gVEmmVugDn0jTjPi44w=
X-Gm-Gg: AZuq6aID100ZdEqd88doiZFdFYjzNf7YwrbRrMhMM/ZI6bhVsWMNNE3GZND2k8rf7r0
	8lygsqVQjefMx8nxznhONFZNYt+EDY03Mk/EP/7pGH86P/JWjwwylrLWWF1cIdxeUAyyAG6S482
	tdAJ4cflINcMCj7WCCmY98QlsIhDBCwqHO4FqK7b5mwhlOk/6nqfj/TfsfapVFHLfvQPyf3DsDH
	eu3KFtsMkN89k5RIzPgXisyVNKq/CsiCufcGBffn/l/h9Ped1FOowsHrDAmsiFnrT6I7cRs0Ogl
	awKjcxRHR4hwi8HoO7PATxphm7Mxao6VPxLV/6QZ5wV8nhGNQBqdVgB2v9MA6UGtE54U7agEXbF
	sZpSseiDY5R9xbbuiGiY+4P2oGdSp9RPoMQ==
X-Received: by 2002:a05:600c:4e56:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-482db47cd9emr108399865e9.17.1769936708027;
        Sun, 01 Feb 2026 01:05:08 -0800 (PST)
X-Received: by 2002:a05:600c:4e56:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-482db47cd9emr108399225e9.17.1769936707599;
        Sun, 01 Feb 2026 01:05:07 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e04c13a2sm61038245e9.5.2026.02.01.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:05:07 -0800 (PST)
Date: Sun, 1 Feb 2026 04:05:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
	shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
	brett.creeley@amd.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CWR
 flag when receiving GRO packet
Message-ID: <20260201040151-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
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
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16302-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 1B609C54E7
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:55:09PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> In Accurate ECN, ACE counter (AE, ECE, CWR flags) changes only when new
> CE packets arrive, while setting SKB_GSO_TCP_ECN in case of not knowing
> the ECN variant can result in header change that corrupts the ACE field.
> The new flag SKB_GSO_TCP_ACCECN is to prevent SKB_GSO_TCP_ECN or
> NETIF_F_TSO_ECN offloading to be used because they would corrupt CWR
> flag somewhere.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Not my driver, but a better format is something along the lines of:

Currently .... this is wrong because ... as the result .... fix this by ...
so that ....

the coding style does say that you should use the imperative form.



> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index a47464a22751..3a1cf4335477 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -3897,7 +3897,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>  
>  	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>  	if (th->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  
>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1fc3720d2201..d174f83478a3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1311,7 +1311,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  }
>  
>  static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
> @@ -1332,7 +1332,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  }
>  
>  static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
> -- 
> 2.34.1


