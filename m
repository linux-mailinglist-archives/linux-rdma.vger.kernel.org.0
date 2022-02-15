Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E74B76DA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiBOUel (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 15:34:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiBOUek (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 15:34:40 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C2689CD4
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:34:30 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id u16so200998pfg.12
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jzcgp3RIGNhHd3NFlgXmCspOHlsW3THR4IwEo2BpkHw=;
        b=wB9xz/6Q4jPJxPsD2Wd1/F4o04sxDz9amsYV2vErqWIkGxzKot7/f9g73U7dNA4zZB
         gRxJw/IPjwAWUdyDECU1xTN5onlEO5sFWH2NvpzQ5XlxE9QSyyAuKv3v0L8g8FkFN1Am
         Nr7YyhwTe770ejvSMJ56TC07yUwDV69aT7ErACMucyJZJWYRGN2iITtXz1c+xJPCO9gs
         VeDYLpcmeDHgqhSqeGmwYkNRZONvI4FP3xROQ9j4Xrv60xzR3TzEahELWTQxK0Kp84XB
         458fn7U/CuHZSSSlukSAqK/IcLByfN9y1rMORFbUYeuTx1pYifQS/oGHm0dWxGpB39mX
         zkZA==
X-Gm-Message-State: AOAM5303nVQGn7s2vQfGAVu2CUvmarsl4zu/VR+/XecLQyz1yt2LaaZe
        TRv5jd4mcOAUcAS6lQZZOaGGHfAL83Smzw==
X-Google-Smtp-Source: ABdhPJzmKo0MUKNGuXEQeX36Oh+EMM5xXSGCG21iPEm/2YCMGik/LQFva6Ys9PwnKyVQf2/MkSFizg==
X-Received: by 2002:a63:5c1f:: with SMTP id q31mr553379pgb.176.1644957269768;
        Tue, 15 Feb 2022 12:34:29 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id j6sm6696403pfc.217.2022.02.15.12.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:34:28 -0800 (PST)
Message-ID: <d76031cc-29bb-5dad-6f30-b69fee5966cb@acm.org>
Date:   Tue, 15 Feb 2022 12:34:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/3] ib_srp: Add more documentation
Content-Language: en-US
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-2-bvanassche@acm.org> <Ygv0IhNMJxFHSi8Q@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Ygv0IhNMJxFHSi8Q@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/15/22 10:42, Leon Romanovsky wrote:
> On Tue, Feb 15, 2022 at 10:26:48AM -0800, Bart Van Assche wrote:
>>   /*
>> + * RDMA adapter in the initiator system.
>> + *
>> + * @dev_list: List of RDMA ports associated with this RDMA adapter (srp_host).
> 
> Isn't this list of RDMA devices and not ports?

Please take a look at srp_add_port(). I think that function establishes 
a 1:1 relationship between an RDMA port and struct srp_host.

Thanks,

Bart.

