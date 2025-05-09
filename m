Return-Path: <linux-rdma+bounces-10195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C3AB1069
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 12:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA85917253E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028D28DF5C;
	Fri,  9 May 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O0OyTsqH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B92274FEA
	for <linux-rdma@vger.kernel.org>; Fri,  9 May 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786071; cv=none; b=GNHkqsn7Cr+UNQgNgCW180LXZDBbasf2JU4cZAAo42OaQwja9zI11LmMvlCDs7GC+djgwL1IcDBRHLxwOdt9YN8fG+32LGqy914QOMkgiEEx74eK2R6+nhfEL+1Nv5qXCjSPhc6X9qvbXpE2/vrvrQIHnDByrpaNgF8g6pa6AKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786071; c=relaxed/simple;
	bh=FqBAxblzPI124Gs/63Xq+gfsdPgQK56bi/JsdBLrSZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksQvRKC7rz4QTkuwznWmZpwpuLlocpTa9VGvXiMyQtYDLWbtk5p5qBN1iMsUI3xJf0Iw2EUBux+xfEjzcQvzzZl8h2CkHaNuDu6hJfN3qntoFF/f62rFxrO7gyZmHq5PkDeLXwNls7Jscy5Jy6SaW7lpfGAIBrXSbMPPtATSVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O0OyTsqH; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3ebdaad-9911-4533-ac4c-35aa9e7184f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746786067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmHabweNHOq4Q440GkJ89iI6ajF8QS7PW41+GMp/Vk4=;
	b=O0OyTsqH8fMh/6BMCIftlSKNZV0VYa/FLZ/uBjvwsxKlWAnZrzFr3H0TGw+KFmc386J5iK
	VVJ8HmSTw2BoOkh9qoTUCvYNqDUpMJ0FUpw5NmpvkmheEr0y7LEm99snZGNeTH1mfp+wUZ
	BqR3GU0Q3iwUpL1sCIyJvD3sVb6qp60=
Date: Fri, 9 May 2025 12:21:03 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Bernard Metzler <BMT@zurich.ibm.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Daniel Wagner <wagi@kernel.org>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08.05.25 09:03, Shinichiro Kawasaki wrote:
> On Apr 16, 2025 / 12:42, Shin'ichiro Kawasaki wrote:
>> On Apr 15, 2025 / 15:18, Bernard Metzler wrote:
> [...]
>>> At first glance, to me it looks like a problem in the iwcm code,
>>> where a cmid's work queue handling might be broken.
> 
> I agree. The BUG slab-use-after-free happened for a work object. The call
> trace indicates that happened for the work handled by iw_cm_wq, not
> siw_cm_wq.
> 
> I took a close looks, and I think the work objects allocated for each cm_id
> is freed too early. The work objects are freed in dealloc_work_entries() when
> all references to the cm_id are removed. IIUC, when the last reference to the
> cm_id is removed in the work, the work object for the work itself gets removed.
> Hence the use-after-free.
> 
> Based on this guess, I created a fix trial patch below. It delays the reference
> removal in the cm_id destroy context, to ensure that the reference count becomes
> zeor not in the work contexts but in the cm_id destroy context. It moves
> iwcm_deref_id() call from destroy_cm_id() to its callers. Also call
> iwcm_deref_id() after flushing the pending works. With this patch, I observed
> use-after-free goes away. Comments on the fix trial patch will be welcomed.

It seems that this problem is related with the following commit.

commit aee2424246f9f1dadc33faa78990c1e2eb7826e4
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Wed Jun 5 08:51:01 2024 -0600

     RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

     iw_conn_req_handler() associates a new struct rdma_id_private 
(conn_id) with
     an existing struct iw_cm_id (cm_id) as follows:

             conn_id->cm_id.iw = cm_id;
             cm_id->context = conn_id;
             cm_id->cm_handler = cma_iw_handler;

     rdma_destroy_id() frees both the cm_id and the struct 
rdma_id_private. Make
     sure that cm_work_handler() does not trigger a use-after-free by only
     freeing of the struct rdma_id_private after all pending work has 
finished.

     Cc: stable@vger.kernel.org
     Fixes: 59c68ac31e15 ("iw_cm: free cm_id resources on the last deref")
     Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
     Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
     Signed-off-by: Bart Van Assche <bvanassche@acm.org>
     Link: 
https://lore.kernel.org/r/20240605145117.397751-6-bvanassche@acm.org
     Signed-off-by: Leon Romanovsky <leon@kernel.org>


Zhu Yanjun

> 
> One left question is why the failure was not observed with rxe driver, but with
> siw driver. My mere guess is that is because siw driver calls id->add_ref() and
> cm_id->rem_ref().
> 
> 
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index f4486cbd8f45..600cf8ea6a39 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -368,12 +368,9 @@ EXPORT_SYMBOL(iw_cm_disconnect);
>   /*
>    * CM_ID <-- DESTROYING
>    *
> - * Clean up all resources associated with the connection and release
> - * the initial reference taken by iw_create_cm_id.
> - *
> - * Returns true if and only if the last cm_id_priv reference has been dropped.
> + * Clean up all resources associated with the connection.
>    */
> -static bool destroy_cm_id(struct iw_cm_id *cm_id)
> +static void destroy_cm_id(struct iw_cm_id *cm_id)
>   {
>   	struct iwcm_id_private *cm_id_priv;
>   	struct ib_qp *qp;
> @@ -442,20 +439,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
>   		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
>   		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
>   	}
> -
> -	return iwcm_deref_id(cm_id_priv);
>   }
>   
>   /*
>    * This function is only called by the application thread and cannot
>    * be called by the event thread. The function will wait for all
> - * references to be released on the cm_id and then kfree the cm_id
> - * object.
> + * references to be released on the cm_id and then release the initial
> + * reference taken by iw_create_cm_id.
>    */
>   void iw_destroy_cm_id(struct iw_cm_id *cm_id)
>   {
> -	if (!destroy_cm_id(cm_id))
> -		flush_workqueue(iwcm_wq);
> +	struct iwcm_id_private *cm_id_priv;
> +
> +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> +	destroy_cm_id(cm_id);
> +	flush_workqueue(iwcm_wq);
> +	iwcm_deref_id(cm_id_priv);
>   }
>   EXPORT_SYMBOL(iw_destroy_cm_id);
>   
> @@ -1035,8 +1034,10 @@ static void cm_work_handler(struct work_struct *_work)
>   
>   		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
>   			ret = process_event(cm_id_priv, &levent);
> -			if (ret)
> -				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
> +			if (ret) {
> +				destroy_cm_id(&cm_id_priv->id);
> +				WARN_ON_ONCE(iwcm_deref_id(cm_id_priv));
> +			}
>   		} else
>   			pr_debug("dropping event %d\n", levent.event);
>   		if (iwcm_deref_id(cm_id_priv))


