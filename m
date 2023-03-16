Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD16BD6CE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Mar 2023 18:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCPROf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Mar 2023 13:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCPROe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Mar 2023 13:14:34 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A6BE049
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 10:14:32 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id o19-20020a056820041300b005259de79accso344539oou.9
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678986871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//2Z9tV4ZQN/6ZFiA+gFuz5b8FvMnmMwEU8H8wd4zZQ=;
        b=KrqlPI3Gm5h+KMe0XkXJ1zfs423mVJ0/MWAkULdOfOWwL582lWs/obm2Cpqa4DChxe
         bdNMwOoJqHL4S6w0fUNRy2QT5zh5fqYtUqHpQfLbaTLfZ3d0PhLgkVWBvQAybvSqIwGy
         71wZ1Q3v0pws0cbOvN4pqJEQzcwYEw8P3MpZgsK9JGMyrB5VZwtkFa5uOP5pfP8fOlEb
         JCdHJrDY1/p9tuLA+tElQFfz+pvq3iikr1dsItMX+Qr0V0niNACneV6aLKretYx2+ZJB
         j6dHM7TKPMJIlbibWfwnYVOm/9EI2p22QugKlz6LgqnKBhbU0V/aikMf4RCoX5Jtzacc
         pCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678986871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//2Z9tV4ZQN/6ZFiA+gFuz5b8FvMnmMwEU8H8wd4zZQ=;
        b=XmZI5MHJOKSHFKGiRAKpCPuyr0XFF0qy7eUSHiQ8u+iWRIkGang9yk7exex/1c2uZi
         Sqp6FA7kc0NPeIfGqxlU3XUSZqrGHeWiEJ9vM2nJBK0vPD7gL+bkfQu/QXpQTmsWQ1w1
         WLFjgnN6B5bnxNk4ev0hx4ScKpj5yPl4T9LjdXqKYV8xq/v48cjpNZP8qCAgUhAp8ipa
         /Ve6viJd8J4OqUjSNsKeUXB4Awxf95T6cPnLW8t7eqjSt7H3QzPksVrs3pEwj2I1ZD0Z
         zmaBA5f0u2DVkzJstfa1jw5+i5MjQMHgBGz1PU2Jikp3bJLYGLWZ+6kK51gsWOp95+gI
         nrrw==
X-Gm-Message-State: AO0yUKUEhcVPGPnNmZBeycAmTU0RGWLYORHgR5Gc2jVlB7/vRKhJ8E5V
        Ucb03PPAWqjJB7+tOzkw8tJsT3gqD9s=
X-Google-Smtp-Source: AK7set+eA5Y5/i84pIOfodyFwKtZdsaMSbs81kHAQf6H5qQMZ7/2qlmo3uahjx8hE3P6j7LJSlpW7g==
X-Received: by 2002:a05:6820:1522:b0:520:f76:11e2 with SMTP id ay34-20020a056820152200b005200f7611e2mr22874699oob.9.1678986871399;
        Thu, 16 Mar 2023 10:14:31 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fede:bff3:4cac:d43b? (2603-8081-140c-1a00-fede-bff3-4cac-d43b.res6.spectrum.com. [2603:8081:140c:1a00:fede:bff3:4cac:d43b])
        by smtp.gmail.com with ESMTPSA id b25-20020a4ad899000000b0051763d6497fsm3421837oov.38.2023.03.16.10.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:14:31 -0700 (PDT)
Message-ID: <3d8576fc-eab5-c962-95bb-badadd18c85f@gmail.com>
Date:   Thu, 16 Mar 2023 12:14:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: question about the completion tasklet in the rxe driver
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <d61963cf-77ef-ef0a-8c94-2de89cb6a5a6@gmail.com>
 <SA0PR15MB3919EAF4C949E82D2887C1AA99BC9@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <SA0PR15MB3919EAF4C949E82D2887C1AA99BC9@SA0PR15MB3919.namprd15.prod.outlook.com>
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

On 3/16/23 04:40, Bernard Metzler wrote:
> 
> 
>> -----Original Message-----
>> From: Bob Pearson <rpearsonhpe@gmail.com>
>> Sent: Wednesday, 15 March 2023 22:56
>> To: Jason Gunthorpe <jgg@nvidia.com>; Zhu Yanjun <zyjzyj2000@gmail.com>;
>> linux-rdma@vger.kernel.org; Bernard Metzler <BMT@zurich.ibm.com>
>> Subject: [EXTERNAL] question about the completion tasklet in the rxe driver
>>
>> I have a goal of trying to get rid of all the tasklets in the rxe driver
>> and with the replacement of the
>> three QP tasklets by workqueues the only remaining one is the tasklet that
>> defers the CQ completion
>> handler. This has been in there since the driver went upstream so the
>> history of why it is there is lost.
>>
>> I notice that the mlx5 driver does have a deferral mechanism for the
>> completion handler but the siw driver
>> does not. I really do not see what advantage, if any, this has for the rxe
>> driver. Perhaps there is some
>> reason it shouldn't run in hard interrupt context but the CQ tasklet is a
>> soft interrupt so the completion
>> handler can't sleep anyway.
>>
>> As an experiment I removed the CQ tasklet in the rxe driver and it runs
>> fine. In fact the performance is
>> slightly better with the completion handler called inline rather than
>> deferred to another tasklet.
> 
> That is what I would suggest to do. Why would you leave receive
> processing or failing send processing w/o creating the CQE and
> kicking the CQ handler, if you are in a context with
> all information available to build a CQE, signal its availability
> to the consumer and kick a user handler if registered and armed?
> 
> Only exception I see: If you process the SQ in post_send() user context
> and a failure results in immediate CQE creation, direct CQ handler calling
> is not allowed - see Documentation/infiniband/core_locking.rst
> Not sure though, if rxe allows for direct SQ processing out of user
> context.
> 
> Cheers,
> Bernard.

And you did. I am not sure why the mlx5 driver defers the completion handler call
to a tasklet. I could be that it gets called in a hard interrupt and completion
handling is deferred to a soft interrupt context. But for rxe the completion
is always already in a soft interrupt context or a process context.

Bob

> 
>> If we can eliminate this there won't be anymore tasklets in the rxe driver.
>>
>> Does anyone know why the tasklet was put in in the first place?
>>
>> Thanks,
>>
>> Bob

