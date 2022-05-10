Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88673520C76
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 05:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiEJD5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 23:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiEJD5q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 23:57:46 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C864231096
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 20:53:51 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 202so13618733pgc.9
        for <linux-rdma@vger.kernel.org>; Mon, 09 May 2022 20:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cLBKz/kc2GV9Cb7sj88RNRtLICYKk0ZPvGQRTE6q7WQ=;
        b=jtejHPIHU7BLFUBNFvzZyTfE+RsnrQ1pqwJF1GL5SUXgTSS+0O6y/Nr/iNxe7mnztP
         jn1f5jRbqVjETCz6RB4uzAXJVi+aBX+KGm73YvDrDqQaoHsy93rWDm6YrdhS9tXX2Yzo
         5IMPclVBRxGnkquELz3A4ikaIPzGD6N7ClJ2JENJmuawX4qpTaHbs3T8lE1jBcNSX4Zf
         E1U6K3B3AhzjSc3tPBbvhDbKRh6ZG9dWT0klHb9n06Jqzb7Z/zybSxoZMrz+P80VPuLi
         APPApzbQ4HZ+0qS3hmK5j0VYxx9+crgJ9XPO7qUtOKt4zCTQMiB21J9ztYO/lsz6wKKa
         l9Uw==
X-Gm-Message-State: AOAM532B1aNd2MDaZj7HmNsKso37ZQR5ilFgvOKaQFCvJoKwUBQK+NWb
        4KjRvKi6fjPdESWTHz7vFC3LdAQIamEFvA==
X-Google-Smtp-Source: ABdhPJxM5t5Vup3WeeJNOD4J8db3k+WIQYjXmqV8Y99eRSM0fVwoEVQLFvD1kP0lsnQVT2VWPVv81g==
X-Received: by 2002:a05:6a00:1acf:b0:50e:1872:c6b1 with SMTP id f15-20020a056a001acf00b0050e1872c6b1mr18707526pfv.76.1652154830348;
        Mon, 09 May 2022 20:53:50 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id b8-20020a62a108000000b0050dc762816fsm9472615pff.73.2022.05.09.20.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 20:53:49 -0700 (PDT)
Message-ID: <4e9d834d-2423-0664-a015-4e55b1535ae2@acm.org>
Date:   Mon, 9 May 2022 20:53:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <09333bbb-25b0-031d-a208-a81de34ad6a6@leemhuis.info>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <09333bbb-25b0-031d-a208-a81de34ad6a6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/8/22 23:56, Thorsten Leemhuis wrote:
> #regzbot ^introduced v5.17..v5.18-rc6
> #regzbot title rdma: hangs in blktests since 5.18-rc1+
> #regzbot ignore-activity

#regzbot fixed-by: f19fe8f354a6 ("Revert "scsi: scsi_debug: Address 
races following module load"")
