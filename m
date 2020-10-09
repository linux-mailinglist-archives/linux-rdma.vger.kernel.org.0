Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37535288C7B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbgJIPXi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgJIPXi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:23:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCAC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:23:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b193so6539168pga.6
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c8xZl7T1GwDetBJIEuEDltwZmxcccOLID8cs8i2GrR8=;
        b=u9zDRu5/0O8YBGU+Qr3cMWbIQ1ImkSAL95PA8QBtL34MtmD8OOBH1WZ3zGm0A6qtlg
         Pvoba7/rvi9CpHobTYIF2jRI+cGFrmHYiXFFNUfhqKeKLG5p4uVzFM1dPGThcnsdpTt5
         z3sQy7++45xUUCChplzblS6I5+JPqHAk9i6PGCCWqIDoGuu8y0q5SxL2RkzXCZPFfzQ4
         gKzCSzwFFYEwZjXwcA/StJauRhgzWOAd327TLmDmU2wrlhrQPReQPfri8yULGV5VHRfg
         NI9UEQN+5RVjq+GAE0iQAPZojJ43+8GOp+QKOlZhs754J5n0IrDHt7v2V2Byk77SMInk
         jSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c8xZl7T1GwDetBJIEuEDltwZmxcccOLID8cs8i2GrR8=;
        b=mDUETmIDvbo8dPrEUUDdLoW+Xk6XwGhjswNr8bJQ/pArZLim+VBhFrXpQZqZhVr9KC
         STemjsEPI+kebAvHQUUKjLGq0CUD3NuJf15a2oK2KZhz1SXf1d4VX1ruzKpGWtS+xKy8
         +GWxMac7rijh9hmg8B/fMM6ldNFV+yUSBDsumzqPPL1wxDxzDY+IGCYhY57uk+vS+O78
         bYSYNk0773mqxansw2+pUkxBsJaOTbpgExW0etz9/PymKJEh58TgPEK/BnqnotlXa046
         PvFUKI/ZPV/r/pF4JSZNqo7OHrAr70QaQ/lZDdEGXgk3Pt7rXuXV5REEAkH7/wxXUJO+
         nFag==
X-Gm-Message-State: AOAM531RT18NimNecTrxQf5n/W8wowIPr1gF7MH7QNwp4rcWxZSvJi5P
        RrT7b8NCLSKD+r0sHSpEVtg=
X-Google-Smtp-Source: ABdhPJzxkirtSfTIGxSh7BTVBJHB/xR+XLPF9mKehL+YSiZxubVIvebG5Ws5T1H/dTKjsUrg2gjS7g==
X-Received: by 2002:a65:4bcc:: with SMTP id p12mr3654135pgr.353.1602257016057;
        Fri, 09 Oct 2020 08:23:36 -0700 (PDT)
Received: from [10.75.201.17] ([129.126.144.50])
        by smtp.gmail.com with ESMTPSA id k15sm10877549pfp.217.2020.10.09.08.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:23:35 -0700 (PDT)
Subject: Re: [PATCH for-next v2] rdma_rxe: fix bug rejecting multicast packets
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20201008212753.265249-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <0e89cd73-e3ea-81fc-c5eb-be7521b10415@gmail.com>
Date:   Fri, 9 Oct 2020 23:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201008212753.265249-1-rpearson@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/9/2020 5:27 AM, Bob Pearson wrote:
>    - Fix a bug in rxe_rcv that causes all multicast packets to be
>      dropped. Currently rxe_match_dgid is called for each packet
>      to verify that the destination IP address matches one of the
>      entries in the port source GID table. This is incorrect for
>      IP multicast addresses since they do not appear in the GID table.
>    - Add code to detect multicast addresses.
>    - Change function name to rxe_chk_dgid which is clearer.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_recv.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index a3eed4da1540..b6fee61b2aee 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -280,7 +280,17 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>   	kfree_skb(skb);
>   }
>   
> -static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
> +/**
> + * rxe_chk_dgid - validate destination IP address
> + * @rxe: rxe device that received packet
> + * @skb: the received packet buffer
> + *
> + * Accept any loopback packets

About loopback packets, will rdma_find_gid_by_port return correct value?

In my tests, to loopback packets, sometimes rdma_find_gid_by_port return 
incorrect value.

Then the packets will be freed.

Zhu Yanjun

> + * Extract IP address from packet and
> + * Accept if multicast packet
> + * Accept if matches an SGID table entry
> + */
> +static int rxe_chk_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
>   {
>   	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
>   	const struct ib_gid_attr *gid_attr;
> @@ -298,6 +308,9 @@ static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
>   		pdgid = (union ib_gid *)&ipv6_hdr(skb)->daddr;
>   	}
>   
> +	if (rdma_is_multicast_addr((struct in6_addr *)pdgid))
> +		return 0;
> +
>   	gid_attr = rdma_find_gid_by_port(&rxe->ib_dev, pdgid,
>   					 IB_GID_TYPE_ROCE_UDP_ENCAP,
>   					 1, skb->dev);
> @@ -322,8 +335,8 @@ void rxe_rcv(struct sk_buff *skb)
>   	if (unlikely(skb->len < pkt->offset + RXE_BTH_BYTES))
>   		goto drop;
>   
> -	if (rxe_match_dgid(rxe, skb) < 0) {
> -		pr_warn_ratelimited("failed matching dgid\n");
> +	if (rxe_chk_dgid(rxe, skb) < 0) {
> +		pr_warn_ratelimited("failed checking dgid\n");
>   		goto drop;
>   	}
>   


