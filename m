Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF784B790F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiBOUuh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 15:50:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbiBOUuf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 15:50:35 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40DBC11
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:50:23 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id m22so265321pfk.6
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vuOkWZE676nd7YIgDsMK/ihOA+L2rjA79g23Qe3490g=;
        b=pJ8dS9IwwmX5FcOq2jJy05DZ6x3r0emCfT3A/xsBsLLd4W/72NaP3pYOylkOExeW86
         uT/l4GSnOCIldhuCxG2JQF1xMuk/XzePB/TffiM1UK338ON2l19n1PQgrvaC9gR2UT6X
         G5xPDwPKnPMpVllFdjYnpiKYgfM6gCo+HmGIAPKTDf2rsU5JFgy4YsP6Ymfahko9YIxS
         nJkumayZblYWA6uaFXdZVQ3Jr+sriiDoS9q6uJAASXWBkzteiLvU5xPh9pKcOE/zb55Q
         yrDwFGWNmeXVUD4GyHbZBxyTuICzwSNTro21m3fDEfIbgtJBnj5zHdxyNdZTSwaIN1T5
         2NUw==
X-Gm-Message-State: AOAM532DeyaxJnSvzQ/ypUKijEU5hgX1XD7dU4LSF42V5yBNFTPy0LoX
        oZFjzeg/CIuXHC6lRsmVaN0=
X-Google-Smtp-Source: ABdhPJzNmGDpmlV4QEYhM701uqNKctzd8Eb3nyenlnd+ad1pbKl/UDGzgwzDfUQNBYmR+AZzKf0G4Q==
X-Received: by 2002:a62:2982:: with SMTP id p124mr498200pfp.53.1644958222067;
        Tue, 15 Feb 2022 12:50:22 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id n5sm3466962pgt.22.2022.02.15.12.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:50:21 -0800 (PST)
Message-ID: <d4118358-756b-2d6c-eeac-bbe053a459a4@acm.org>
Date:   Tue, 15 Feb 2022 12:50:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/3] ib_srp: Fix a deadlock
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+831661966588c802aae9@syzkaller.appspotmail.com
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-4-bvanassche@acm.org> <Ygv2OkMeJYrTwdbi@unreal>
 <a281d1be-857e-be6a-0440-648bed837d4e@acm.org>
 <20220215204142.GA1037534@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220215204142.GA1037534@ziepe.ca>
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

On 2/15/22 12:41, Jason Gunthorpe wrote:
> On Tue, Feb 15, 2022 at 12:37:43PM -0800, Bart Van Assche wrote:
>> On 2/15/22 10:51, Leon Romanovsky wrote:
>>> On Tue, Feb 15, 2022 at 10:26:50AM -0800, Bart Van Assche wrote:
>>>> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
>>>> index 2db7429b42e1..8e1561a6d325 100644
>>>> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
>>>> @@ -4044,12 +4044,10 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
>>>>    		mutex_lock(&host->target_mutex);
>>>>    		list_for_each_entry(target, &host->target_list, list)
>>>>    			srp_queue_remove_work(target);
>>>> +		list_for_each_entry(target, &host->target_list, list)
>>>> +			flush_work(&target->tl_err_work);
>>>
>>> Sorry for my silly question, but why do you do flush and not cancel
>>> here? You anyway remove SRP device, so the result of flush is not
>>> really important, am I right?
>>
>> That's a great question. It probably doesn't matter much whether
>> flush_work() or cancel_work_sync() is called in this context since
>> srp_queue_remove_work() indirectly cancels tl_err_work. See also the
>> following code in srp_remove_target():
>>   	cancel_work_sync(&target->tl_err_work);
> 
> If it is already canceled then why call flush?

I'll see whether I can leave the flush_work(&target->tl_err_work) calls out.

Thanks,

Bart.
