Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9572B7826
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 09:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgKRIIG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 03:08:06 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:14221 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKRIIG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 03:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605686886; x=1637222886;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4wFjCvbY729StTlVw+oIaT1Ti3zePYLG75hWimVbV6E=;
  b=hvy9jkuht2mP9+865/jxe2NJxuzWjuM+N+9GRRYehZLzt2ybZfmP5TvJ
   MANfF8u7SMFh+mQZBfJZMxhPNBktyEZv+0XA5qd1H0zprBd7xDSCpwr21
   Mb9nTCZwcOgGaTN9RHAjfUsPVnfjJZmWJ3vGbGzZ2S3hYuUDIWjpMLftV
   s=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="64634750"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Nov 2020 08:07:59 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 2873A241242;
        Wed, 18 Nov 2020 08:07:57 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.55) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 08:07:54 +0000
Subject: Re: [PATCH 4/9] efa: Move the context intialization out of
 efa_query_device_ex()
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <096f7bfc-518c-f017-6dd8-93449f7d2120@amazon.com>
Date:   Wed, 18 Nov 2020 10:07:48 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.55]
X-ClientProxiedBy: EX13D50UWC004.ant.amazon.com (10.43.162.109) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/11/2020 22:23, Jason Gunthorpe wrote:
> When the user calls efa_query_device_ex() it should not cause the context
> values to be mutated, only the attribute shuld be returned.
> 
> Move this code to a dedicated function that is only called during context
> setup.
> 
> Cc: Gal Pressman <galpress@amazon.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  providers/efa/efa.c   | 14 +------------
>  providers/efa/verbs.c | 46 +++++++++++++++++++++++++++++++++++--------
>  providers/efa/verbs.h |  1 +
>  3 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/providers/efa/efa.c b/providers/efa/efa.c
> index 35f9b246a711ec..b24c14f7fa1fe1 100644
> --- a/providers/efa/efa.c
> +++ b/providers/efa/efa.c
> @@ -54,10 +54,7 @@ static struct verbs_context *efa_alloc_context(struct ibv_device *vdev,
>  {
>  	struct efa_alloc_ucontext_resp resp = {};
>  	struct efa_alloc_ucontext cmd = {};
> -	struct ibv_device_attr_ex attr;
> -	unsigned int qp_table_sz;
>  	struct efa_context *ctx;
> -	int err;
>  
>  	cmd.comp_mask |= EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH;
>  	cmd.comp_mask |= EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR;
> @@ -86,17 +83,8 @@ static struct verbs_context *efa_alloc_context(struct ibv_device *vdev,
>  
>  	verbs_set_ops(&ctx->ibvctx, &efa_ctx_ops);
>  
> -	err = efa_query_device_ex(&ctx->ibvctx.context, NULL, &attr,
> -				  sizeof(attr));
> -	if (err)
> +	if (!efa_query_device_ctx(ctx))
>  		goto err_free_spinlock;

This return error on success seems to be the issue, will verify.
