Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82E787555
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbjHXQ1v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbjHXQ1r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 12:27:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412ED1FD7;
        Thu, 24 Aug 2023 09:27:20 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bcae8c4072so32025a34.1;
        Thu, 24 Aug 2023 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692894439; x=1693499239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aa8VlfmGY02DYai6DbnbTyrEiAb2mU5zmmRxrxK2cNM=;
        b=LxBZJYLlBQ6pbfS+7hm0/NvdFfs4PAQVeL4OoF+1CzWqdAVbl14gJr1UQcnjTRi+ad
         A+oMPTZsp294kddIYRW+maW4awjkRshZv4RyX+eJQX0f6m0QbX2FBsbZ7mgrXtu9Mrdy
         f4Lygb6oztKafCYiy0czSdYhF8HGLxLBObHbkqXvDCwUy3tguySIRRduXa31iOWtandK
         a4IYV6XzibIsI0qasrp1Z5LoBMnO8VFHAOar0eblDMCuPn0d/RCLmdQDPWXr2t3gvBSX
         uunntXu5Z2e6F/m79Fc0nP5sd9IB/snC3ZAwi9uw3xEeqYc3wOdUZnYZtlYRRS1TRPZT
         cowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894439; x=1693499239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa8VlfmGY02DYai6DbnbTyrEiAb2mU5zmmRxrxK2cNM=;
        b=MobYHklWbZsQhXWB/Kmp5C3vRrktKEp/RP+hKB2MoSV4+YLvX5FpTy57/Wpm6PpjPT
         C58jqvhIEVndobCkYfe8/UPOM43s9FAYFXUgI+WzpZ7dzuZasaPSSR3CnK9GIy3bd1Vb
         8Ggmha7EXdINnNSCjItFZcPVsN9i3bbdOzQg4LLyGYzkTLUPiEAth2gIisgExv775cIm
         isi7oLLgFyYfGTdauQlEPcB5UM7KFeybaJ2HHZO3ZeWrf2ndHet0cicSL2G+j9/Yt4YO
         8THgvGP5jxNL3VfhBVkNtdBsCpbEHUVd/y4hzRYzibAooTEpcZ+C3Fu94puAmefSC45M
         FxWA==
X-Gm-Message-State: AOJu0YxyaXLWJPDeaFMGSB2nGINXkaLbO0goI/t//sHaJDRHbyRPViCn
        5Ai+scNOowxK2076n3/aDbo=
X-Google-Smtp-Source: AGHT+IH3xhWPZQfAbbCdVwCXu8my91J++3ILVFWEFHEUtSlnQvZxHChjMaUgzDJLQI8WIwGniehJOQ==
X-Received: by 2002:a05:6870:e892:b0:1bf:cb11:c97e with SMTP id q18-20020a056870e89200b001bfcb11c97emr216949oan.52.1692894439453;
        Thu, 24 Aug 2023 09:27:19 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:16dd:44f3:4ece:f186? (2603-8081-140c-1a00-16dd-44f3-4ece-f186.res6.spectrum.com. [2603:8081:140c:1a00:16dd:44f3:4ece:f186])
        by smtp.gmail.com with ESMTPSA id c15-20020a056870478f00b001c4fe8e78e1sm8257613oaq.43.2023.08.24.09.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:27:18 -0700 (PDT)
Message-ID: <069e2f07-5f15-4c56-7b95-c9b9aab18610@gmail.com>
Date:   Thu, 24 Aug 2023 11:27:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <27e31e00-74a3-6209-5ad5-1783d6e67a0d@gmail.com>
 <SN7PR15MB57550E846867D9A74F00DC47991DA@SN7PR15MB5755.namprd15.prod.outlook.com>
 <55e63dc7-a523-3a58-ea35-f1ce34d9c50f@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <55e63dc7-a523-3a58-ea35-f1ce34d9c50f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/24/23 11:05, Bart Van Assche wrote:
> On 8/24/23 08:35, Bernard Metzler wrote:
>> I spent some time testing the srp/002 blktest with siw, still
>> trying to get it hanging.
>> Looking closer into the logs: While most of the time RDMA CM
>> connection setup works, I also see some connection rejects being
>> created by the passive ULP side during setup:
>>
>> [16848.757937] scsi host11: ib_srp: REJ received
>> [16848.757939] scsi host11:   REJ reason 0xffffff98
>>
>> This does not affect the overall success of the current test
>> run, other connect attempts succeed etc. Is that connection
>> rejection intended behavior of the test?
> 
> Hi Bernard,
> 
> In the logs I see that the SRP initiator (ib_srp) may try to log in before
> the SRP target driver (ib_srpt) has finished associating with the configured
> RDMA ports. I think this is why REJ messages appear in the logs. The retry
> loop in the test script should be sufficient to deal with this.
> 
> Bart.

Thanks to both of you for taking the time to look at this.

Bob
