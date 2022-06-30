Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0556223C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 20:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiF3Sm5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiF3Sm4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 14:42:56 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF524162D;
        Thu, 30 Jun 2022 11:42:55 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so318110pjb.2;
        Thu, 30 Jun 2022 11:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GJcM7Vwr3H/bLC7hAn6JczygD8HdfVoG28VG/DeZhMI=;
        b=meIno/FSJ8pDhMIZPSW0auwqyGwTyZTxoUw9m5Gen3VxCbdjrRi83yiKhhpB/a9YIO
         pm9utu91C9Rcc85aLVkSAN6OBjg83/lKx5cNXQbVMBcTOMsqIdEPloxZ5IhTUKBQXEhm
         hgUg95aZtE3jHkmxdDj1+3IxvKST1evZnA/K6ws05QKpjYRJDZn1uPnKShesSbPmKly0
         YfBCaeRsfC+95yX82Fy+G1dHtRd4oHxCHh9xfkcXex9Ffx4GjAVqbg3KZV7hZHm1dvPH
         BcEyUlSH+OFtL7YU9yaCRIkBBvM5x2kaH8tywt9roEm8C0wI9Iv7hVDwAs+pfcFmYkZ1
         XyJw==
X-Gm-Message-State: AJIora8cxC7zkDeeF5sS0x9tk5W5zRq1y3mKqk28RZA2CeQxnWMjrMZu
        m5/hqWyW5c+ptCoDkGJr7qJvnmxIm/33kQ==
X-Google-Smtp-Source: AGRyM1siPgQM2hR9N+3A4Q34PKCMq944l7nXmBa35c23h8l1gwx5qSzuxTuqOlMmziW60kLwnnmQkA==
X-Received: by 2002:a17:903:32c4:b0:16a:4227:cd68 with SMTP id i4-20020a17090332c400b0016a4227cd68mr17064005plr.173.1656614575093;
        Thu, 30 Jun 2022 11:42:55 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090a3f1600b001ecfa85c8f0sm2308090pjc.26.2022.06.30.11.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:42:54 -0700 (PDT)
Message-ID: <0c8a4d70-3ef9-bc1c-51ad-9063fdfb43bc@acm.org>
Date:   Thu, 30 Jun 2022 11:42:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: use-after-free in srpt_enable_tpg()
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
 <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
 <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
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

On 6/30/22 09:40, Mike Christie wrote:
> On 6/27/22 11:37 AM, Bart Van Assche wrote:
>> On 6/27/22 00:09, lizhijian@fujitsu.com wrote:
>>> So far, I doubt if the previous defect of configfs mentioned in
>>> 9b64f7d0b: "(RDMA/srpt: Postpone HCA removal until after configfs
>>> directory removal)" has got a better solution. if not, i have no a
>>> clear mechanism to avoid it yet.
>>>
>>> feedbacks are very welcome.
>> Mike, are you perhaps aware of any plans to add functions to the LIO core for removing tpg and wwn objects?
>>
> 
> I don't know any work being done in this area. I was only working
> on the refcounting/configfs parts for sessions in those configfs/sysfs
> patchsets. However, I think I hit similar issues with the session.
> I went around the world with solutions but didn't really like them
> so I never pushed the patches for inclusion.
> 
> What was the hang caused by 9b64f7d0bb0a?

Hi Mike,

I have not been able to find Honggang's bug report that led to the 
revert of that commit. I guess that the hang happened in the while-loop 
in srpt_release_sport() that was modified by commit 9b64f7d0bb0a.

Thanks,

Bart.
