Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2770342C8BB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 20:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJMSfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 14:35:45 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:56210 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhJMSfn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 14:35:43 -0400
Received: by mail-pj1-f45.google.com with SMTP id om14so2894555pjb.5;
        Wed, 13 Oct 2021 11:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4XmJ1jC9DPXCMuf8a+fhehsw5ASjCFlKX2CL8Hazd58=;
        b=lSvBR0WCHxZ+4vaWxQSwOO+ehKuzawMWIXlhqMi5SDp095XMPLQvxWBdd4DbxwXsqX
         U1qkP0zu/floAT8r8ErVB1BV0Z2pvAWv1FDjgKCKrvaTYMdCEdpKPuecv+hHOOJIlPpZ
         hw9Ri0nzUlkZpPCojvxgOsVAgS9F7Y0Bry864l1EF40Eo3AwU9/LDWK6SuZJu1uEgg6+
         TSCuIhnzrhu7wUEndineBcyTytajVrp0w1OxB+dTJaaLfyQqkD4kCkSTAkyWLzfzvIVC
         +pMVtr9X385pLdRJD0X8N/4DuwsHLQBsaW6Cg2UBaCHk39vUvAHmux9C/kKWuVN2fAu4
         zPDg==
X-Gm-Message-State: AOAM533HYabEDZ05EOsyQYftRvIfBGFHJUzAadsZ2VJrYQfja8+oSuVH
        if7ymVZm/tZTD0vDJRlspYM=
X-Google-Smtp-Source: ABdhPJz9+PJn+XMP/2yVysc274MYh3vDJSSYXwrBfoOu9RYy9tqyuIvTbIcEuiqgsU9EfeJWlk9gOA==
X-Received: by 2002:a17:90b:1c82:: with SMTP id oo2mr1003840pjb.53.1634150018223;
        Wed, 13 Oct 2021 11:33:38 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ae3:1dc1:f2a3:9c06])
        by smtp.gmail.com with ESMTPSA id u24sm223779pfm.27.2021.10.13.11.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 11:33:37 -0700 (PDT)
Subject: Re: [PATCH] RDMA/core: Set sgtable nents when using
 ib_dma_virt_map_sg()
To:     Logan Gunthorpe <logang@deltatee.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20211013165942.89806-1-logang@deltatee.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5eec6b1b-726e-b26d-bd82-f03fd5462b8f@acm.org>
Date:   Wed, 13 Oct 2021 11:33:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211013165942.89806-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/13/21 9:59 AM, Logan Gunthorpe wrote:
> ib_dma_map_sgtable_attrs() should be mapping the sgls and setting nents
> but the ib_uses_virt_dma() path falls back to ib_dma_virt_map_sg()
> which will not set the nents in the sgtable.
> 
> Check the return value (per the map_sg calling convention) and set
> sgt->nents appropriately on success.
> 
> Link: https://lore.kernel.org/all/996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org/T/#u
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Bart Van Assche <bvanassche@acm.org>

Does this patch need a "Fixes:" tag?

Thanks,

Bart.
