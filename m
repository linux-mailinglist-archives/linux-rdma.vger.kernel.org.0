Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD93354ECF
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhDFIlx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232876AbhDFIlx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 04:41:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3657613C2;
        Tue,  6 Apr 2021 08:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617698505;
        bh=eI95+cmKFt9u1HuWMfpCHasidcTJeLzuN5/l13HuNzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bO1ric2tqZitcb3g9lgivcS1rHFAKFXniD9gXFKyUZCkjj4ff6lC9b7NCSYs+f2iY
         leNPpvCEja3RJUwMd12Ob3lAXn2RZSXfzCId07qcaGNW4nkX1JexkDIX1xO0KbU2V7
         CKoPEEb9S0yKx3Lluxt3iyHS+Te49+s9dfQdygeLiUlXbQIjZwEEKpeK+4K8TOt5jd
         tmWOd6F0EeIAQmKvz+muccGiCO2l6OUz9j428bfC+LXMx/7+NE8G8nmeidT3pX9FA2
         28HDKUxaqE3ND4xFK4thOBW2EPmBaplYvoBI2cnJqv6kdd4Vo5KX0J/itTDrotevdL
         t6ywjXUfiboGA==
Date:   Tue, 6 Apr 2021 11:41:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/6] RDMA/core: Add necessary spaces
Message-ID: <YGwexRBkApaxvnGp@unreal>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
 <1617697184-48683-4-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617697184-48683-4-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 04:19:41PM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
> 
> Space is required before '(', around '==' and around '='.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/cm.c      | 2 +-
>  drivers/infiniband/core/cm_msgs.h | 4 ++--
>  drivers/infiniband/core/iwcm.c    | 2 +-
>  drivers/infiniband/core/ucma.c    | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 32c836b..28c8d13 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -3099,7 +3099,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
>  	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
>  
>  	spin_lock_irqsave(&cm_id_priv->lock, flags);
> -	switch(cm_id_priv->id.state) {
> +	switch (cm_id_priv->id.state) {
>  	case IB_CM_REQ_RCVD:
>  		cm_state = IB_CM_MRA_REQ_SENT;
>  		lap_state = cm_id->lap_state;
> diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
> index 0cc4065..8462de7 100644
> --- a/drivers/infiniband/core/cm_msgs.h
> +++ b/drivers/infiniband/core/cm_msgs.h
> @@ -22,7 +22,7 @@
>  static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
>  {
>  	u8 transport_type = IBA_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg);
> -	switch(transport_type) {
> +	switch (transport_type) {
>  	case 0: return IB_QPT_RC;
>  	case 1: return IB_QPT_UC;
>  	case 3:
> @@ -37,7 +37,7 @@ static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
>  static inline void cm_req_set_qp_type(struct cm_req_msg *req_msg,
>  				      enum ib_qp_type qp_type)
>  {
> -	switch(qp_type) {
> +	switch (qp_type) {
>  	case IB_QPT_UC:
>  		IBA_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg, 1);
>  		break;
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index da8adad..ee5ab1c 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -211,7 +211,7 @@ static void free_cm_id(struct iwcm_id_private *cm_id_priv)
>   */
>  static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
>  {
> -	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
> +	BUG_ON(atomic_read(&cm_id_priv->refcount) == 0);

Simply delete this BUG_ON.

Thanks

>  	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
>  		BUG_ON(!list_empty(&cm_id_priv->work_list));
>  		free_cm_id(cm_id_priv);
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 21dda69..15d57ba 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -231,7 +231,7 @@ static void ucma_copy_conn_event(struct rdma_ucm_conn_param *dst,
>  		memcpy(dst->private_data, src->private_data,
>  		       src->private_data_len);
>  	dst->private_data_len = src->private_data_len;
> -	dst->responder_resources =src->responder_resources;
> +	dst->responder_resources = src->responder_resources;
>  	dst->initiator_depth = src->initiator_depth;
>  	dst->flow_control = src->flow_control;
>  	dst->retry_count = src->retry_count;
> @@ -1034,7 +1034,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
>  {
>  	dst->private_data = src->private_data;
>  	dst->private_data_len = src->private_data_len;
> -	dst->responder_resources =src->responder_resources;
> +	dst->responder_resources = src->responder_resources;
>  	dst->initiator_depth = src->initiator_depth;
>  	dst->flow_control = src->flow_control;
>  	dst->retry_count = src->retry_count;
> -- 
> 2.8.1
> 
