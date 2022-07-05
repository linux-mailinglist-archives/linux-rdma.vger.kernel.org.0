Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8275673DC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiGEQKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGEQKf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 12:10:35 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E513F5B;
        Tue,  5 Jul 2022 09:10:34 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id fz10so6521799pjb.2;
        Tue, 05 Jul 2022 09:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZNTQnk49H2igi0K6Q0jxdfi1a4YgDcy0NhVMvg7bnDQ=;
        b=ikplLSPOU+RmjOFlWSmZG+ScUZ3Jw1FimpRtDx8st1tuLC7KxEd+VcFqAdhasyuWe/
         n+E9nrJHpcCMUuWi2zJNmizKYwtQjvP9ySVPfy3RcMq00R5n+FffAzUhTiW2n3V86wvb
         W7gKXFv1764kcyjj8SXQ1dyfx40HKFUTaLBf3I3psUJAoTDG3nHnKgbC8L4UETsclpXr
         rr4ELLQ5qh3spVIhPSFA7vrdUX8+xKshl5vBD9yUtKqaptAKyHTvrjdM1uGianpSP8Ji
         OP0OclP663/RjD2/yPqgsRJVlMPfqag+3CujW4TznbJ7Qup5Db70fPYuuPJWHylHr8GF
         7dMQ==
X-Gm-Message-State: AJIora8W6HrmF6K7wkiUMo00bws4xE1jz6dMixd/PSZn3FwB9EZ0BFqd
        Qupivi1vYQAgdyoY0RvMnCHJU0mhwzc=
X-Google-Smtp-Source: AGRyM1uDO/Py3wsxe/B9UjRraSQsGptcSXXY6FmxKvltGVVP5jYMSB5UDDBIAoTrgnh++2846CwQCg==
X-Received: by 2002:a17:90a:6741:b0:1ef:7f62:6cd1 with SMTP id c1-20020a17090a674100b001ef7f626cd1mr17873644pjm.89.1657037433778;
        Tue, 05 Jul 2022 09:10:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902bd4500b0016a565f3f34sm23192699plx.168.2022.07.05.09.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 09:10:32 -0700 (PDT)
Message-ID: <2e8b080c-cda5-9224-1e46-95fb0b4f7036@acm.org>
Date:   Tue, 5 Jul 2022 09:10:31 -0700
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
 <20220704001157.1644-1-hdanton@sina.com>
 <20220705114050.1979-1-hdanton@sina.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220705114050.1979-1-hdanton@sina.com>
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

On 7/5/22 04:40, Hillf Danton wrote:
> If no compat devices can be added to ib_device with DEVICE_REGISTERED
> cleared then they can be removed without ib_device's refcount dropping
> to zero.
> Even if that is not strictly true, a new flag that marks ib device
> disabled and prevents new compact devices from being added can be added
> in bid to cut the wait for completion.
> 
> Hillf
> 
> +++ b/drivers/infiniband/core/device.c
> @@ -1265,6 +1265,7 @@ static void disable_device(struct ib_dev
>   
>   	down_write(&devices_rwsem);
>   	xa_clear_mark(&devices, device->index, DEVICE_REGISTERED);
> +	// device->disabled = true;
>   	up_write(&devices_rwsem);
>   
>   	/*
> @@ -1282,17 +1283,10 @@ static void disable_device(struct ib_dev
>   	}
>   
>   	ib_cq_pool_cleanup(device);
> +	remove_compat_devs(device);
>   
>   	/* Pairs with refcount_set in enable_device */
>   	ib_device_put(device);
> -	wait_for_completion(&device->unreg_completion);
> -
> -	/*
> -	 * compat devices must be removed after device refcount drops to zero.
> -	 * Otherwise init_net() may add more compatdevs after removing compat
> -	 * devices and before device is disabled.
> -	 */
> -	remove_compat_devs(device);
>   }

I'm not convinced the above patch is a step in the right direction nor 
that it is correct. Anyway, since the RDMA maintainers know this code 
better than I do I will let them comment on the above patch.

Bart.
