Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E320A584567
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiG1SEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiG1SEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 14:04:23 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1D74CE3
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 11:04:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u76so3265743oie.3
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sUNvs8r1vknkVSSd8Fd3JWTdCYICDAv/mdgULeJ6VdY=;
        b=YQqp3/e3vIx5pmk7Ei2GxX1Rl0kqNbAxxsHsj50POeBtGQ5HGrqu0DPPon/tnRBdpH
         Po1gMUtAxcSNgIB8Qvu8hk3n2fnBxU1FusBdy303yAncos94LoWZDPEGw3rbDRYraDA1
         bKTsKoYVyveVZtXyeDnvJsC/CgeaPMQy1B5D2SLN0R50kOV77dxvL/Y8K/pakXeesC4H
         462yTHnEf44tFNPf9boX5AeHU0YBZshAwvvW7VhtsXMA8nqTcpoeeA2n0d2uRwLuwrMG
         5AesrANZHK0xr6esiLz0sHKRq2HPXCn7wKIGqALyXb+bCoT3/s9YR6k4nAVg8y8XNurD
         7ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sUNvs8r1vknkVSSd8Fd3JWTdCYICDAv/mdgULeJ6VdY=;
        b=KZNCqOnUf8BIvZc9fgClu0BYNdxuYrCkJVNMGKGMWLI+P9Ti5CKy/7rttEMcqBZ6na
         7vI1tqitiJVa6TQN4vOn90BGmgx5uFDTvXl2VU02KpPI8eg+R3C2ZZUtBD6icD+zHi+1
         C9wOR/c1ZXPsP7Mc7+keTqBcfcTj5B7ZBwWRRf6Wux618s/UYwaYYSMjwthELRc/SUiS
         9QF1ITD5GidgPpPHS0OMiTHb//bgSzXGgBIhERGdf53Bns4v6qoUHj4e1SoXmCEcecsA
         3toaC661rjjxOAbxW1/t578Swwg/n6Jlzhd+tCGuT9jDjCF8hMSqvhx2eSdm6nLcp8Xo
         UoKA==
X-Gm-Message-State: AJIora/MTMyjn1nx3PgGslgm3luHQqxMHwLLj9hi3sGz99jRSCXJz7tE
        53xQ85dDMYWP0vEu2ZjPiwcVyL3DSr8=
X-Google-Smtp-Source: AGRyM1sggNNnHyGSonYDaBIPqInpJT4aLcx2/wqN+BmYxwa1YJShachOvqdfFP3NEtQhG2uN/e2gJg==
X-Received: by 2002:a05:6808:1b8c:b0:33a:d44f:2169 with SMTP id cj12-20020a0568081b8c00b0033ad44f2169mr22750oib.13.1659031461346;
        Thu, 28 Jul 2022 11:04:21 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:74e9:26b8:3420:6d55? (2603-8081-140c-1a00-74e9-26b8-3420-6d55.res6.spectrum.com. [2603:8081:140c:1a00:74e9:26b8:3420:6d55])
        by smtp.gmail.com with ESMTPSA id z5-20020a056870e30500b0010d7e268e1esm677609oad.10.2022.07.28.11.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 11:04:19 -0700 (PDT)
Message-ID: <afbf4443-493e-c564-7997-406ab90edc7d@gmail.com>
Date:   Thu, 28 Jul 2022 13:04:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next v2] RDMA/rxe: Cleanup rxe_init_packet()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, haris.iqbal@ionos.com,
        linux-rdma@vger.kernel.org
References: <20220727163651.6967-1-rpearsonhpe@gmail.com>
 <YuK0a67aTpMWJgeE@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <YuK0a67aTpMWJgeE@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/28/22 11:08, Jason Gunthorpe wrote:
> On Wed, Jul 27, 2022 at 11:36:52AM -0500, Bob Pearson wrote:
>>  	unsigned int hdr_len;
>>  	struct sk_buff *skb = NULL;
>> -	struct net_device *ndev;
>> -	const struct ib_gid_attr *attr;
>> +	struct net_device *ndev = rxe->ndev;
>>  	const int port_num = 1;
>> -
>> -	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
>> -	if (IS_ERR(attr))
>> -		return NULL;
> 
> An ib_device can have many netdevs associated with the gid indexes, eg
> from VLANs or LAG. The core code creates these things
> 
> I think it is nonsense for rxe to work like this, and perhaps it
> doesn't work at all, but until rxe blocks creation of these other gid
> indexes I'm not sure it makes sense to delete this code..
> 
> Jason


Somehow I had the vague impression that rxe didn't support vlans but
I just looked at the following commit

commit fd49ddaf7e266b5892d659eb99d9f77841e5b4c0

Author: Mohammad Heib <goody698@gmail.com>

Date:   Tue Aug 11 18:04:15 2020 +0300



    RDMA/rxe: prevent rxe creation on top of vlan interface

    

    Creating rxe device on top of vlan interface will create a non-functional

    device that has an empty gids table and can't be used for rdma cm

    communication.

    

    This is caused by the logic in

    enum_all_gids_of_dev_cb()/is_eth_port_of_netdev(), which only considers

    networks connected to "upper devices" of the configured network device,

    resulting in an empty set of gids for a vlan interface, and attempts to

    connect via this rdma device fail in cm_init_av_for_response because no

    gids can be resolved.

    

    Apparently, this behavior was implemented to fit the HW-RoCE devices that

    create RoCE device per port, therefore RXE must behave the same like

    HW-RoCE devices and create rxe device per real device only.

    

    In order to communicate via a vlan interface, the user must use the gid

    index of the vlan address instead of creating rxe over vlan.

    

    Link: https://lore.kernel.org/r/20200811150415.3693-1-goody698@gmail.com

    Signed-off-by: Mohammad Heib <goody698@gmail.com>

    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>



which jibes with what you are saying. The immediate impact of this is that
rxe->ndev should probably not be used unless you know you want the physical device.

Bob
