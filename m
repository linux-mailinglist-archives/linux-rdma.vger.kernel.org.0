Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB17874DB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbjHXQFZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbjHXQFV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 12:05:21 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E5E50;
        Thu, 24 Aug 2023 09:05:19 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso565455ad.1;
        Thu, 24 Aug 2023 09:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692893118; x=1693497918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38+OtvkyXnf02zDocHJo+dRMRYtmgN/w6d9FbovXz0c=;
        b=RNKlUY6E6PULzluDZ1OzI2/XISp2dUFGNWsrzQKK66iyvI5yJHvfRr6XM0NPD/apjm
         /oDtYV2EGAIwPnLzudVqMdFUvg2RImqbF2y5nZvhTczFCMr6n0n0h5/x2Zfl/HzNBUol
         JJoO9pNxTb+Sh4e+hJqFnQNpREgt+Y0w1tz1Jf4w4jS9ROmJu4FkvX4OOjQaoPr+PAv3
         5eqIHwV6ZRQ02x7tHWn8oymIZ+JXUV9p2qC3m9o+7wozq+hqUVxasRE3fLuVw7sZa5/b
         Ld/ENEqq+v/qADmbyA+7GZwcXCf+kg3ffWQmSId6/6MpT61J/6JNFJUhELqpiYjxQP8E
         oAIg==
X-Gm-Message-State: AOJu0Yw36WzhJgc+qfqYEuv83AnSM2Jv+EtNx0i1Q/4VifFy1rSaO0bz
        j0e4owXRrN2MLr1eY5W+PlA=
X-Google-Smtp-Source: AGHT+IGFZyIMWAR17FuYTBBNUHXr5hZUbuVvgP5+5UZeQl9/aCg1amnMgQfWRiFYUZabX2tqcLQJQw==
X-Received: by 2002:a17:903:1248:b0:1bd:c7e2:462 with SMTP id u8-20020a170903124800b001bdc7e20462mr14292507plh.11.1692893118435;
        Thu, 24 Aug 2023 09:05:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e6ec:4683:972:2d78? ([2620:15c:211:201:e6ec:4683:972:2d78])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001b8c689060dsm12922251plt.28.2023.08.24.09.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:05:17 -0700 (PDT)
Message-ID: <55e63dc7-a523-3a58-ea35-f1ce34d9c50f@acm.org>
Date:   Thu, 24 Aug 2023 09:05:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
 <SN7PR15MB57550E846867D9A74F00DC47991DA@SN7PR15MB5755.namprd15.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <SN7PR15MB57550E846867D9A74F00DC47991DA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/23 08:35, Bernard Metzler wrote:
> I spent some time testing the srp/002 blktest with siw, still
> trying to get it hanging.
> Looking closer into the logs: While most of the time RDMA CM
> connection setup works, I also see some connection rejects being
> created by the passive ULP side during setup:
> 
> [16848.757937] scsi host11: ib_srp: REJ received
> [16848.757939] scsi host11:   REJ reason 0xffffff98
> 
> This does not affect the overall success of the current test
> run, other connect attempts succeed etc. Is that connection
> rejection intended behavior of the test?

Hi Bernard,

In the logs I see that the SRP initiator (ib_srp) may try to log in before
the SRP target driver (ib_srpt) has finished associating with the configured
RDMA ports. I think this is why REJ messages appear in the logs. The retry
loop in the test script should be sufficient to deal with this.

Bart.
