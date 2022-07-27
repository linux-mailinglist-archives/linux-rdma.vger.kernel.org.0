Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A787858326E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 20:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiG0SxC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 14:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiG0Swq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 14:52:46 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271E12B3AB
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 10:47:49 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 72so16540368pge.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 10:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DSU2V1M086hRr8v32EbseeRdTl86rXqxlgrvcP5dJD0=;
        b=TjgHz3eTMtKme04+X/CYib7urjnSjIkk7BzNh760pd7J/gycrBx/AXzCeNuyXPOPk/
         TAGp15eUFB6nGHCQh+zqJdXqyRWcjHkKYwHnoI0cJGeDJXmVmhEGouAbFVvNtXsTjZMa
         OrPJLHLvw29lJd0IE3ClBx8iEQvasNbwWoTwgt6H44BK7YN2bOL50NvWXl6VFkkoKD+K
         TJjTOqusDA6+TrZENvwNygcuP+MmAjFDYuHWdt8VbHMwbvVJPru87qPQiWdZFPM1rfOY
         dKyzM7GhD+sb4LzI+UH7tGqA7INTUYCoWBjyhRH4WS785zP/+KrORYG03lYKWPnrCiQO
         5fdQ==
X-Gm-Message-State: AJIora8Ls4fse6+cIZ/hucn4hZivl5mpfWtisYqxUQSkMeACdjFsa0wx
        ciUhas74oOs91euoXJwlImc=
X-Google-Smtp-Source: AGRyM1s2+XyeCA6Avhf7rBKGWtg6r3HYLhPPydzLjtsbyCF21tEMWldey1nNbhbS8GqGD7ucDELwPQ==
X-Received: by 2002:a63:2fc3:0:b0:41b:f16:645c with SMTP id v186-20020a632fc3000000b0041b0f16645cmr10405568pgv.370.1658944068128;
        Wed, 27 Jul 2022 10:47:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id me6-20020a17090b17c600b001f2fbf2c42esm2127889pjb.26.2022.07.27.10.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:47:47 -0700 (PDT)
Message-ID: <a5036c5d-9658-37a0-3003-aa2138819b58@acm.org>
Date:   Wed, 27 Jul 2022 10:47:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Christoph Lameter <cl@gentwo.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>
References: <20220726212156.1318010-1-bvanassche@acm.org>
 <20220726212156.1318010-4-bvanassche@acm.org> <YuEHOM/iGFEtaGde@unreal>
 <alpine.DEB.2.22.394.2207271426110.1244244@gentwo.de>
 <YuEwK35/xuNe24/G@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YuEwK35/xuNe24/G@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/22 05:31, Leon Romanovsky wrote:
> On Wed, Jul 27, 2022 at 02:26:43PM +0200, Christoph Lameter wrote:
>> On Wed, 27 Jul 2022, Leon Romanovsky wrote:
>>
>>> Please no BUG_ON() in new code.
>>
>> Do we now prefer NULL pointer dereferences causing bugs?
> 
> There are two possible scenarios.
> 1. "NULL can be in this flow." - In such case, the code should deal with
> such flow and do not crash whole machine.
> 2. "NULL can't be in this flow." - Put WARN_ON() which serves as a
> documentation/debug help to catch situations that are not possible.

Hi Leon and Christoph,

Thanks for having taken a look. Since the wwn.priv pointers cannot be 
NULL, I will remove the BUG_ON() statements that check these pointers.

Bart.
