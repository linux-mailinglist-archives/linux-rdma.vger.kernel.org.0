Return-Path: <linux-rdma+bounces-527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD88228C9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 08:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758C028486C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A751803D;
	Wed,  3 Jan 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E8xyDbrf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFB18032
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbc5636b8eso2872014b6e.2
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jan 2024 23:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704266131; x=1704870931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+HykofkC4XCLsN/IzjEfRBYAAlCw6MbbcBMKDxRgT4=;
        b=E8xyDbrfTBAwDKR4vO84lsiLQKxmfCQ4WGv/oKNgFMGqghj1bJKAtJXWmxP8S/0L/A
         7dBqLxTBrrypGGpPYKZHpIgaM9A/UXAdkKMS48fhUqUVZM5dNoDLNVaKukR9RoswRvZW
         MP6+c9XdZa0PUER4EXLOuf9o17LoQPN+XQxC3cZ7mT1Bd5es8Q1S0cNawZGFeFt/yLxe
         fprUZZAY7RjjFDEgmpIDIOBlL2xARg5l3TR5VlXSUiNhnuOCgLFLcijaq3xcQsznlzpA
         P6qqLAVFYzO2f2gOChpYYyNxg6K1vo1xBveVfanSRa/47tZbFP8xEozmkc1e1H/xIp8P
         JCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704266131; x=1704870931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+HykofkC4XCLsN/IzjEfRBYAAlCw6MbbcBMKDxRgT4=;
        b=q14oG+0Rnq19zMFyarWm47SmK+xDvgdOrvDrqPnkdyAeJPF3Nd55GJOOljrTsZ6V+2
         bRKRO8HfWdxc2ML7tbDT1+vJuJ6UF0Ho705DNFyTfzftj+ui2PGs1R3qlweJ6ur9WMwk
         sLl01zsNdiAkDxsyaPL6lUTJfP3rIY9bH30BDv9zR2uqI5rRd8IEKyiDAaO4RmFGMYXS
         DKk+pAn34zlUWr8YJbKSfmckFBACkZ9mmKdQGNOggzV3ljYG8X0bQeazKutkWopvUcU2
         y6ktq0fQUvAs5rH0uzqwLQs4WQVMokO8+LmFklFmf1bMsr7gqC6uFvzC5K5I/RCTuoPG
         FdyQ==
X-Gm-Message-State: AOJu0YyHTlt3msb3MpuL5KgBOv9olS5YOCL6zRZQ+Ao4gO8hJRUorDrV
	8AU/3hqPYk5aWDOc68AUauIYVEWrTpgjZA==
X-Google-Smtp-Source: AGHT+IH+xvy/OeTFf/SWMRhuHGPa1pwpUpecal2gwTnR99sG6ObXLueMCn5D0t07TFbtdjQ1qr4y5Q==
X-Received: by 2002:a05:6808:bd0:b0:3bc:22e6:a9cc with SMTP id o16-20020a0568080bd000b003bc22e6a9ccmr831123oik.40.1704266131162;
        Tue, 02 Jan 2024 23:15:31 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id w67-20020a626246000000b006da04f1b884sm12272607pfb.105.2024.01.02.23.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 23:15:30 -0800 (PST)
Message-ID: <e996faab-0376-498a-abdd-43508cd2df99@bytedance.com>
Date: Wed, 3 Jan 2024 15:15:26 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] RDMA/rxe: Fix port state on associating netdev
 successfully
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103020133.664928-1-pizhenwei@bytedance.com>
 <96f1e8d4-18fc-461e-9916-f7ddd6ea4b26@linux.dev>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <96f1e8d4-18fc-461e-9916-f7ddd6ea4b26@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/3/24 14:47, Zhu Yanjun wrote:
> 在 2024/1/3 10:01, zhenwei pi 写道:
>> Originally, after adding a RXE device successfully, the RXE device
>> gets ready, it still reports 'PORT_DOWN' state. Set the state to
>> *IB_PORT_ACTIVE* once it becomes ready to access.
> 
> IB_PORT_ACTIVE is set in the function rxe_port_up.
> 
> The followings are the call chain.
> 
> rxe_net_add -- > rxe_register_device -- > ib_register_device -- > 
> enable_device_and_get -- > rxe_enable_driver -- > rxe_set_port_state -- 
>  > rxe_port_up
> 
> In this commit, in rxe_net_add, the port->attr.state is set to 
> IB_PORT_ACTIVE.
> 
> But then in the function rxe_init_port_param, port->attr.state is set to 
> IB_PORT_DOWN again.
> 
> Zhu Yanjun
> 

Thanks, I guess anything got wrong in my env(virtual interface in a 
virtual machine), let's drop this.

>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
>> b/drivers/infiniband/sw/rxe/rxe_net.c
>> index cd59666158b1..eafcb2351a7b 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -524,6 +524,7 @@ int rxe_net_add(const char *ibdev_name, struct 
>> net_device *ndev)
>>   {
>>       int err;
>>       struct rxe_dev *rxe = NULL;
>> +    struct rxe_port *port;
>>       rxe = ib_alloc_device(rxe_dev, ib_dev);
>>       if (!rxe)
>> @@ -537,6 +538,11 @@ int rxe_net_add(const char *ibdev_name, struct 
>> net_device *ndev)
>>           return err;
>>       }
>> +    if (netif_running(ndev) && netif_carrier_ok(ndev)) {
>> +        port = &rxe->port;
>> +        port->attr.state = IB_PORT_ACTIVE;
>> +    }
>> +
>>       return 0;
>>   }
> 

-- 
zhenwei pi

