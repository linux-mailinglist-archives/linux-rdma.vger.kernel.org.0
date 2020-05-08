Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12251C9F70
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHAIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 20:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgEHAIN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 May 2020 20:08:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D988C05BD09
        for <linux-rdma@vger.kernel.org>; Thu,  7 May 2020 17:08:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c64so8210688qkf.12
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2020 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jGrCheF+xcDEz7z4ioHUwe8UBu2trZjlpvbQqyH8U0s=;
        b=N3irBq46VSPNifsOgvIB8UjOTsmPKIGoQFutM2D0eCd+TiynzDLtxcdpZ0eY8DIOBU
         biGoBS4dGlzM83L6fGm7KWbpbT2qn3FI07VCACR+bBO3scfHa6B5Do6fvgqUNFsJdnke
         2zOEnP5zGVFsON9+97bJ05Evs+lHuNpMD9E31/XrRbCDo82uRFFqrneDTnLDhnZ2Tqe3
         Bu5gyu7AHeoemQvsdF/ArU5nbBtkZIVmoWNSx9Y2XaeFOCLto37JMxXLhOViXwj/MJrh
         XSbcLcDCYvfnskHa5UJChOkKkKaK3eEDUDwA7Qe6+9r2+DcWRqCt/2EJIEheWaIeadRd
         RPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jGrCheF+xcDEz7z4ioHUwe8UBu2trZjlpvbQqyH8U0s=;
        b=Irp1xJv7XeY99s9F7EOmBFeTcgvbfvkJzllNN8iCRK5oyQwTUK2fQHdce4bm+KNMlQ
         i/nPYrZRuukzCjw9hzPP9MthhwH9/WFlyXiq5K+G/+jwOhNmwYq7dpb31LkdnBXSZISl
         YsGfVBg0iSYudA0DMXbEr2oEAweQra/bB/KYXbBfrcL9OQwsVytHrfNc/3S2/ZZHS2Au
         NT+jB9AWMmRS8XPaA3bAinvggMQSzD2ZGG/WtIiFsUJX8o6N0SgRM+yFqYLWpTUTNQG0
         NKAz+OONpXawO22HjArlvZJ0A3yyMpBhFni/zMo8CUZhR0N3i8tlU5BN35XVqHYFW69G
         8Agw==
X-Gm-Message-State: AGi0PuaJqm8zcND8zUPcNg0S+s5981VCb6OBxjYUszHT3cD9OLC7Mw5m
        8zUCoTEnRZuWO6InaPSmtba6zg==
X-Google-Smtp-Source: APiQypJ0HbaPuD3VaiAGy4AkJ4UVGib5UgUhYsqYiv6WhZjBHoE0vKqjIfmzrhPWnUlOT+CDXmMnbw==
X-Received: by 2002:a37:a785:: with SMTP id q127mr53947qke.179.1588896490475;
        Thu, 07 May 2020 17:08:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j11sm4899305qkk.33.2020.05.07.17.08.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 17:08:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWqYj-0001YM-Ee; Thu, 07 May 2020 21:08:09 -0300
Date:   Thu, 7 May 2020 21:08:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Message-ID: <20200508000809.GM26002@ziepe.ca>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 07, 2020 at 11:34:47AM -0700, Divya Indi wrote:
> This patch fixes commit -
> commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
> 
> Above commit adds the query to the request list before ib_nl_snd_msg.
> 
> However, if there is a delay in sending out the request (For
> eg: Delay due to low memory situation) the timer to handle request timeout
> might kick in before the request is sent out to ibacm via netlink.
> ib_nl_request_timeout may release the query if it fails to send it to SA
> as well causing a use after free situation.
> 
> Call Trace for the above race:
> 
> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
> [<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
> [<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
> [<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
> [<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
> [rds_rdma]
> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
> [rds_rdma]
> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
> [<ffffffff810a02f9>] process_one_work+0x169/0x4a0
> [<ffffffff810a0b2b>] worker_thread+0x5b/0x560
> [<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
> [<ffffffff810a68fb>] kthread+0xcb/0xf0
> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90
> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> ....
> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
> 
> To resolve this issue, we introduce a new flag IB_SA_NL_QUERY_SENT.
> This flag Indicates if the request has been sent out to ibacm yet.
> 
> If this flag is not set for a query and the query times out, we add it
> back to the list with the original delay.
> 
> To handle the case where a response is received before we could set this
> flag, the response handler waits for the flag to be
> set before proceeding with the query.
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>  drivers/infiniband/core/sa_query.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index 30d4c12..ffbae2f 100644
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -59,6 +59,9 @@
>  #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
>  #define IB_SA_CPI_MAX_RETRY_CNT			3
>  #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
> +
> +DECLARE_WAIT_QUEUE_HEAD(wait_queue);
> +
>  static int sa_local_svc_timeout_ms = IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
>  
>  struct ib_sa_sm_ah {
> @@ -122,6 +125,7 @@ struct ib_sa_query {
>  #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
>  #define IB_SA_CANCEL			0x00000002
>  #define IB_SA_QUERY_OPA			0x00000004
> +#define IB_SA_NL_QUERY_SENT		0x00000008
>  
>  struct ib_sa_service_query {
>  	void (*callback)(int, struct ib_sa_service_rec *, void *);
> @@ -746,6 +750,11 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query *query)
>  	return (query->flags & IB_SA_CANCEL);
>  }
>  
> +static inline int ib_sa_nl_query_sent(struct ib_sa_query *query)
> +{
> +	return (query->flags & IB_SA_NL_QUERY_SENT);
> +}
> +
>  static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
>  				     struct ib_sa_query *query)
>  {
> @@ -889,6 +898,15 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>  		spin_lock_irqsave(&ib_nl_request_lock, flags);
>  		list_del(&query->list);
>  		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> +	} else {
> +		query->flags |= IB_SA_NL_QUERY_SENT;
> +
> +		/*
> +		 * If response is received before this flag was set
> +		 * someone is waiting to process the response and release the
> +		 * query.
> +		 */
> +		wake_up(&wait_queue);
>  	}
>  
>  	return ret;
> @@ -994,6 +1012,21 @@ static void ib_nl_request_timeout(struct work_struct *work)
>  		}
>  
>  		list_del(&query->list);
> +
> +		/*
> +		 * If IB_SA_NL_QUERY_SENT is not set, this query has not been
> +		 * sent to ibacm yet. Reset the timer.
> +		 */
> +		if (!ib_sa_nl_query_sent(query)) {
> +			delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
> +			query->timeout = delay + jiffies;
> +			list_add_tail(&query->list, &ib_nl_request_list);
> +			/* Start the timeout if this is the only request */
> +			if (ib_nl_request_list.next == &query->list)
> +				queue_delayed_work(ib_nl_wq, &ib_nl_timed_work,
> +						delay);
> +			break;
> +		}
>  		ib_sa_disable_local_svc(query);
>  		/* Hold the lock to protect against query cancellation */
>  		if (ib_sa_query_cancelled(query))
> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
>  
>  	send_buf = query->mad_buf;
>  
> +	/*
> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
> +	 * processing this query. If flag is not set, query can be accessed in
> +	 * another context while setting the flag and processing the query will
> +	 * eventually release it causing a possible use-after-free.
> +	 */

This comment doesn't really make sense, flags insige the memory being
freed inherently can't prevent use after free.

Jason
