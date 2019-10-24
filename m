Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48CFE3919
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409956AbfJXRB3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 24 Oct 2019 13:01:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40651 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405976AbfJXRB3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 13:01:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so12156177pll.7
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 10:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0HTNOu0h/a/wnnv5DEWGiw+SGTaWlhkaa3voLU81QH0=;
        b=M8vgXfeSnQG3EHy1i0Etvh8u0Nr8NIGh+S9N1q+dfl3wADJ5lSwtyRILsXM6zdPf4C
         LWbyCixcIaQAvcyRs/ZpiqHscP3fDyw4rYj3j0UCABYKJHtdHm/X1wruGkVnOhuK/hEB
         lIMmHNgAAB+PC4nB7f26G6xvMkbSjJVkoti08Mt5/GOPNknz09aIHAyY8flvEaFmRP5r
         PHmBt61Wv0E7H/LNskFis6UA9yMTFAlmE0YMVQfJorDs8CGnMFdaKca4noosXmDvTeoo
         jDcctQu2swjFUl7Zj90MLge3ZfwRlUB+XEPdWbp8lHyFmQ/evnI6E3gYIMCobAdZ3eVf
         x3BA==
X-Gm-Message-State: APjAAAUbOKFRK3dEUYGJz5/l+hlrX/WudACswUIP8TpWfSwehjwMS9jD
        lRea81JHNNh82Y4VopTYUb0Hb3jwQm0=
X-Google-Smtp-Source: APXvYqwMWwcsmHHsGrCcQmUBAmEBoIscJnO4Ee9gEjkhvNOFBrOzMtBVEKa8okaE+/AcZAc+rweVAQ==
X-Received: by 2002:a17:902:8216:: with SMTP id x22mr10078046pln.232.1571936487641;
        Thu, 24 Oct 2019 10:01:27 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id b24sm12366356pfo.4.2019.10.24.10.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:01:26 -0700 (PDT)
Subject: Re: [PATCH rdma-next 6/6] RDMA/srpt: Use private_data_len instead of
 hardcoded value
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-7-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <688bd3de-be93-3fca-a80d-8740060eb996@acm.org>
Date:   Thu, 24 Oct 2019 10:01:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020071559.9743-7-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/20/19 12:15 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Reuse recently introduced private_data_len to get IBTA REJ message
> private data size.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index daf811abf40a..e66366de11e9 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2609,7 +2609,7 @@ static int srpt_cm_handler(struct ib_cm_id *cm_id,
>  	case IB_CM_REJ_RECEIVED:
>  		srpt_cm_rej_recv(ch, event->param.rej_rcvd.reason,
>  				 event->private_data,
> -				 IB_CM_REJ_PRIVATE_DATA_SIZE);
> +				 event->private_data_len);
>  		break;
>  	case IB_CM_RTU_RECEIVED:
>  	case IB_CM_USER_ESTABLISHED:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

