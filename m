Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837087D9D3D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbjJ0Pos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0Por (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 11:44:47 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF2EC2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 08:44:45 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5af6c445e9eso10248367b3.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 08:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421484; x=1699026284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyxUdMU85bnOr+OgHHb8c7wkf8DiNKsj/0ep/MIXAcs=;
        b=SmDLEfUhZvXyspDlnEG3iU7/lYHFKsd1V+7IPYzCS1uMgKzg6gKGoHbiFYscgcVIB/
         NscI9NVLTcPaaAjIkEKlvIY9C7MLo9eAlHp9/vqG8nY9f0usdBZ99s9/yGuzCPWFsmYH
         klFQFw5KiTTg6HFxrtTdEhLi7FjONhDViJNJUpqTO4+pQHcOSSriUPtzv8BX7ymAqKnQ
         4jACTVbqGdeqUcTBcHCrcheKl4z8KLSVGiApMkT/8tHXwYOO1nooq7+Kuu2l1yUcka+q
         4DdGUpVmsDegezz0Lq8DZ7+iys6GRTruKb0HxCRjwvd1C3neIHYrnwGibA4H1I7iKz+2
         DWSw==
X-Gm-Message-State: AOJu0YwtBSf+do7noPUGZdaY9rI8PXbPM4pm0Ep3LWg2+lElmATj6qJ3
        Kn6AGzwiPl8NAl5oWIbe1giQ6XIJDSM=
X-Google-Smtp-Source: AGHT+IG8/waX9Xj4rZzXxGGcYT2Yqdmfooqv+ezGy5wXJ0k/Kd3rxf59yR95rcTxlbUydy0/pUIatg==
X-Received: by 2002:a17:90a:fc93:b0:27d:b87b:a9d4 with SMTP id ci19-20020a17090afc9300b0027db87ba9d4mr2915328pjb.7.1698421473166;
        Fri, 27 Oct 2023 08:44:33 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id d88-20020a17090a6f6100b0027e022bd3e5sm1519267pjk.54.2023.10.27.08.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:44:32 -0700 (PDT)
Message-ID: <b8b224c0-4b58-4574-9f82-fdd5ab2bcc9c@acm.org>
Date:   Fri, 27 Oct 2023 08:44:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
 <143f03b7-08ba-411c-a7ad-580141c06cfe@acm.org>
 <20231026134300.GV691768@ziepe.ca>
 <fa4fab22-4d59-43f8-883c-d5a70a69a964@acm.org>
 <OS3PR01MB9865DFC2FE195813D2330DD3E5DCA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <OS3PR01MB9865DFC2FE195813D2330DD3E5DCA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/26/23 18:26, Daisuke Matsuda (Fujitsu) wrote:
> OnFri, Oct 27, 2023 6:48 AM Bart Van Assche wrote:
>> Bob, do you plan to convert the above change into a patch or do you
>> perhaps expect me to do that?
> 
> It looks Bob has not been involved in this thread.

Please take a look at the "To:" field of my email.

Thanks,

Bart.

