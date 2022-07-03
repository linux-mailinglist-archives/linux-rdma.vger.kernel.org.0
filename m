Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7625556482F
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Jul 2022 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiGCOzJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Jul 2022 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiGCOzI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 3 Jul 2022 10:55:08 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8AF5F5C;
        Sun,  3 Jul 2022 07:55:07 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id x4so6834539pfq.2;
        Sun, 03 Jul 2022 07:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kxKzGfxWGfKBHp9F8W62mmiucykNyoEbmozsyWHPQSM=;
        b=d1lh/1mBMMLHDmqj2Ij8wIXP/v8XZbqUmBJah63ic+W0++MHJlwnQuVE60Z/wFUhnk
         WrJUdnscYKAu9R1kA0oSmXjMPgNS2KXQVPH7aIHOsua1iknVwNUP4/6JC/h0MU5/fsJQ
         P79pTxY1JDxxYfK91J0lbRzxM7r+M8Omsh4BjADFZ9sFOV2GjADbawKvwCSGkb2RjgQT
         lPhvbrrMCH0gISY1fuUg+BgqnfxeFEjuya7o/18gtcqIY6rIJW1zh8JjqgTVKDzT94/4
         dIE1WiSmJ1PZrPcWAG/M9pF7Xmb8DS5RK2ByUaCL7O6Ife1/5mWozkG4qzcbRiCOZqsS
         8OvQ==
X-Gm-Message-State: AJIora9fo4oFn0xWr2cHbHIaJpxh12MiKu9O2AESLNebSNAeoBttpP0W
        /U8K4JZtFI0Lrepi3YbY7hI=
X-Google-Smtp-Source: AGRyM1vNwKItYGfQdO3d4S6lgVRggBMRNaa0YOd45v0UMb597XCV+l8z9rytiJJk8z/SL/YvOR04Ww==
X-Received: by 2002:a63:4526:0:b0:40d:f426:9f4b with SMTP id s38-20020a634526000000b0040df4269f4bmr22055292pga.595.1656860107288;
        Sun, 03 Jul 2022 07:55:07 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id nn12-20020a17090b38cc00b001ef59378951sm654399pjb.13.2022.07.03.07.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 07:55:06 -0700 (PDT)
Message-ID: <19f203e5-e965-23bd-401b-0ae8d9a73a5d@acm.org>
Date:   Sun, 3 Jul 2022 07:55:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: use-after-free in srpt_enable_tpg()
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
 <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
 <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
 <20220701015934.1105-1-hdanton@sina.com>
 <20220703021119.1109-1-hdanton@sina.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220703021119.1109-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/2/22 19:11, Hillf Danton wrote:
> On Sat, 2 Jul 2022 15:26:33 -0700 Bart Van Assche wrote:
>> As long as a session is live the ch->qp pointer may be
>> dereferenced. The sdev->pd pointer is stored in the pd member of struct
>> ib_qp and hence may be dereferenced by any function that uses ch->qp.
> 
> If it is still an issue after ib_dealloc_pd(sdev->pd) then it goes beyond the
> aperture of my proposal and needs another fix.
> 
> Hillf
> 
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -3235,6 +3235,8 @@ static void srpt_remove_one(struct ib_de
>   
>   	ib_set_client_data(device, &srpt_client, NULL);
>   
> +	/* make sdev survive ib_dealloc_pd(sdev->pd); */
> +	atomic_inc(&sdev->port_refcount);
>   	/*
>   	 * Unregistering a target must happen after destroying sdev->cm_id
>   	 * such that no new SRP_LOGIN_REQ information units can arrive while
> @@ -3250,6 +3252,9 @@ static void srpt_remove_one(struct ib_de
>   	srpt_free_srq(sdev);
>   
>   	ib_dealloc_pd(sdev->pd);
> +
> +	if (0 == atomic_dec_return(&sdev->port_refcount))
> +		kfree(sdev);
>   }
>   
>   static struct ib_client srpt_client = {

Do you perhaps want to combine the above patch with the previous patch? 
I don't think that any reference counting scheme can fix all 
use-after-free issues related to srpt_remove_one(). Immediately after 
srpt_remove_one() returns the caller of this function calls 
ib_device_put() and ib_client_put(). These functions free data 
structures that can be reached from the pointers that are stored in 
struct ib_qp. Holding a reference on struct ib_device as long as any 
session is live would allow to remove the while-loop from 
srpt_release_sport(). However, I'm not sure that would make a 
significant difference since there is a similar while-loop in one of the 
callers of srpt_remove_one() (disable_device() in the RDMA core).

Bart.
