Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC75B3CC0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIIQNu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIIQNt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 12:13:49 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7B113C79;
        Fri,  9 Sep 2022 09:13:48 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id fs14so1956369pjb.5;
        Fri, 09 Sep 2022 09:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MadgPW3bIWnxdQfPPdsGGoJAqevbbigFAqjHQW6xs94=;
        b=wqbj3f595hULA10GcnqdI+/wbiOL01RQ7aXYAO7QeWtqf8Lvx5MKWBtUDLYeCY7Ulm
         peJfFyCT/RbdDRPPa9S4wdOaI6eQ52bYIH5zdMsuhPLJy0WG8mbCTLHv67yFgTS5zhNA
         dzA2ZKp7s9ub0qzWRb+Ai3STevtf6T/IN/pGlAKvHh6DnKVq5KkbyGccJ357qZEUL8k7
         cZroO5PEkD8s1QKzcw6pthSOR61Ck2anU4g/cWvCoajN/9fUsD0sTqtpDoq70pJZgHK1
         LzdcYZ/A6kjxLn8T4RKcrKi9OePXbefOY8j6kfiFX+EE90vCDWgjorI1DSX4oipDSp3H
         Fqgg==
X-Gm-Message-State: ACgBeo2sXyOdoleNx26JUCG88mJ38rCkVhBTvNFoXlLDKjpv5VVeYqh8
        dM1Zp8cX2qgr8WoZCW3ksLAgsuo5dR0=
X-Google-Smtp-Source: AA6agR4f0EXjtVe/wdPN2qgBLJybBWStezFCoV4aQts6Slx94J0FjuqxmV5yjOLvv3PoAUAs5X6bVg==
X-Received: by 2002:a17:90b:1e0c:b0:1f5:4e52:4866 with SMTP id pg12-20020a17090b1e0c00b001f54e524866mr10650864pjb.230.1662740027435;
        Fri, 09 Sep 2022 09:13:47 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id g14-20020aa79dce000000b00540ad46bc1dsm699614pfq.157.2022.09.09.09.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:13:46 -0700 (PDT)
Message-ID: <253db188-04d2-6bea-4d4f-33371bfae929@acm.org>
Date:   Fri, 9 Sep 2022 09:13:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] infiniband: ulp: srpt: Use flex array destination for
 memcpy()
To:     Hangyu Hua <hbh25y@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
        gustavoars@kernel.org
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909022943.8896-1-hbh25y@gmail.com>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220909022943.8896-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/8/22 19:29, Hangyu Hua wrote:
> In preparation for FORTIFY_SOURCE performing run-time destination buffer
> bounds checking for memcpy(), specify the destination output buffer
> explicitly, instead of asking memcpy() to write past the end of what looked
> like a fixed-size object.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
