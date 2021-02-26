Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AC326A63
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Feb 2021 00:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZX33 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Feb 2021 18:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZX3Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Feb 2021 18:29:24 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC141C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 15:28:43 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id g8so7048112otk.4
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M96sqn81EqzVVV7VWvd48XWz6RKrEw2yIs/x7IhfaCI=;
        b=tuBM0xRpfokgjxACj5lSa9otqAMEsI9+rkbByNsps3OPNrIWWeUPhCsfHkHeS9yegJ
         tnODaqoZujKI47BFKFEimUZIYpz5ARmejQLPLZCC1+64aQiXU/OpSgJNGFhSO070b250
         bsLypmg8L1iFpufBiuDbRKvzy6EfV/rxNolLwcRGEknbvJ5xbJLdC/2jEMV43dJUqQiq
         sJXfc0fJfyg9Y/vqTlONb71F3VfbF8s4r5uVX1CcKdFRF6z/XCx6B8U4eMngeHgY9JGi
         WunNP5TTZ5ab57wfDEbXYnOSsSMX58GMeKvLjHGHrvAdz/tDm0M98kuJgvdJQeFD1IdF
         EEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M96sqn81EqzVVV7VWvd48XWz6RKrEw2yIs/x7IhfaCI=;
        b=CG2pzKat+d3Jci+iszjrfmT9juqea2UH/x8f+FKx9lhQQ3/WawvqxqrM2Ta6AqTGt8
         3kaxTJruNcbdNUHk2OBUMCWWyEVMRVbvQ1srqAnGWwQS/JQmDnFaqao9eGy/WwjWjgTW
         WcWbZ0A5stsN340Fy2JtEeY3uuGcbzxK0kDErCNno2UPs9fXo3GMx4IE60ZZbTbuAIzV
         XJZAvuHPK+tEUx6v/OEEFwhB1pVuMCZ0KUf/l8B5kz4/ptAqC59rJXNH8QzjYHE9dUun
         YelyI1L5r/qG8OXxbfjPSkdJqk0WaPLaSiIxMb0Q+0QIuxQe5RJD6cJM8TLj8nKSaMFh
         mL9g==
X-Gm-Message-State: AOAM533CiKE4FnXh5HtEmSOXUcqPhkv5zwcJgpDtp8f0jWKxHTkHtR/j
        tiTnnKjXtIBlyDxsAS9TdAWqXHQmUyNVUQ==
X-Google-Smtp-Source: ABdhPJxuCrD61d5fh4eBVvZBoykzpcHLhpkvmmHHVqofsDYhsjQbkJLycxiHBwXkFsaJcXgMWewILA==
X-Received: by 2002:a9d:2247:: with SMTP id o65mr4231038ota.344.1614382122741;
        Fri, 26 Feb 2021 15:28:42 -0800 (PST)
Received: from [192.168.0.21] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id 3sm2097365otn.18.2021.02.26.15.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 15:28:42 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20210214222630.3901-1-rpearson@hpe.com>
Message-ID: <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
Date:   Fri, 26 Feb 2021 17:28:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210214222630.3901-1-rpearson@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/21 4:26 PM, Bob Pearson wrote:
> Three errors occurred in the fix referenced below.
> 
> 1) The on and off again 'if (skb)' got dropped but was really
> needed in rxe_rcv_mcast_pkt() to prevent calling ib_device_put()
> on the non-error path.
> 
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
> 
> 3) In rxe_comp.c the function free_pkt() did not clear skb which
> triggered a warning at done: and could possibly at exit: in
> rxe_completer(). The WARN_ONCE() calls are not required at done:
> and only in one place before going to exit.
> 
> This patch fixes these errors.
> 
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c | 5 +++--
>  drivers/infiniband/sw/rxe/rxe_net.c  | 7 ++++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 6 ++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index a8ac791a1bb9..13fc5a1cced1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -671,6 +671,9 @@ int rxe_completer(void *arg)
>  			 * it down the road or let it expire
>  			 */
>  
> +			/* warn if we did receive a packet */
> +			WARN_ON_ONCE(skb);
> +
>  			/* there is nothing to retry in this case */
>  			if (!wqe || (wqe->state == wqe_state_posted))
>  				goto exit;
> @@ -750,7 +753,6 @@ int rxe_completer(void *arg)
>  	/* we come here if we are done with processing and want the task to
>  	 * exit from the loop calling us
>  	 */
> -	WARN_ON_ONCE(skb);
>  	rxe_drop_ref(qp);
>  	return -EAGAIN;
>  
> @@ -758,7 +760,6 @@ int rxe_completer(void *arg)
>  	/* we come here if we have processed a packet we want the task to call
>  	 * us again to see if there is anything else to do
>  	 */
> -	WARN_ON_ONCE(skb);
>  	rxe_drop_ref(qp);
>  	return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 36d56163afac..8e81df578552 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -406,12 +406,17 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
>  
>  void rxe_loopback(struct sk_buff *skb)
>  {
> +	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
> +
>  	if (skb->protocol == htons(ETH_P_IP))
>  		skb_pull(skb, sizeof(struct iphdr));
>  	else
>  		skb_pull(skb, sizeof(struct ipv6hdr));
>  
> -	rxe_rcv(skb);
> +	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev)))
> +		kfree_skb(skb);
> +	else
> +		rxe_rcv(skb);
>  }
>  
>  struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 8a48a33d587b..a5e330e3bbce 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -299,8 +299,10 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>  
>  err1:
>  	/* free skb if not consumed */
> -	kfree_skb(skb);
> -	ib_device_put(&rxe->ib_dev);
> +	if (unlikely(skb)) {
> +		kfree_skb(skb);
> +		ib_device_put(&rxe->ib_dev);
> +	}
>  }
>  
>  /**
> 
Just a reminder. rxe in for-next is broken until this gets done.
thanks

bob
