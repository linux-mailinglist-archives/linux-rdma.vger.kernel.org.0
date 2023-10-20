Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDA7D1506
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbjJTRmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjJTRl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 13:41:59 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF9A3;
        Fri, 20 Oct 2023 10:41:58 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso1010560b3a.1;
        Fri, 20 Oct 2023 10:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823717; x=1698428517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/bmuWhpvn5f4m0roKqeGdetZ0Ya2dh5nl8fv3xeulA=;
        b=i891JFQEMi2oPFDfGTnOTT+ppf4R60QG7CFiUrSHRIkycO5KUjIxdIpOK1oxgdpdHn
         Ep0OrjDQwFDLMpz3RkMVVmRZk0TWhfL3Vpa18PBTHgQ82melMChHgLBeQ7CN6oNTUygW
         db78EZXFbhJGjCNaHDMsz3TUC5RCQ85Gev4S3dY9oPPnRVDqzOoukd+vD3yw7r77EzXa
         e+lZXjS4Xd4SfdZrJqIelwRxwvrZccAx9sPmnSso089XopEfiRV8DhFlEBvPxt7D4MRa
         Rcsbx/0c+SZgjttjr44rI5ICT/PeprQOcoXKrEsugahE8xnq+cJbuXtjcIYxBJ9WZMs+
         FOfg==
X-Gm-Message-State: AOJu0YxbvvikGomRrgjpwCadtREqWliypTChqqUz07cur5knR1C0Zg3Q
        AFqKWcwxfbj5qQ+IWkghT+U=
X-Google-Smtp-Source: AGHT+IEij3r2ns5b+e53CAOyh/tJNiEhGDapxu+VLLVMsgPqlAiWtU730tuws36aDvZWL1ndfiX/4Q==
X-Received: by 2002:a05:6a00:9398:b0:6b9:a3d3:772a with SMTP id ka24-20020a056a00939800b006b9a3d3772amr2424771pfb.14.1697823717556;
        Fri, 20 Oct 2023 10:41:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:72ba:c99b:d191:901c? ([2620:15c:211:201:72ba:c99b:d191:901c])
        by smtp.gmail.com with ESMTPSA id s66-20020a625e45000000b0068bc6a75848sm1873676pfb.156.2023.10.20.10.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:41:57 -0700 (PDT)
Message-ID: <8285a8c6-de4f-44dd-8bf2-7724f3a633ff@acm.org>
Date:   Fri, 20 Oct 2023 10:41:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
 <20231018191735.GC691768@ziepe.ca>
 <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
 <fb5f6da5-5017-440d-9cb5-38796554366c@gmail.com>
 <6f5ed2dd-3809-4805-8d31-de24f3f14486@acm.org>
 <MW4PR84MB2307BE5EEC6DF51918FCCDF1BCD5A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <7ea5a4b0-26b8-4521-a53b-99cbdb02c594@acm.org>
 <eab9460f-d8ae-4479-ad42-ffdeb377c0d2@gmail.com>
 <5f8a5236-2a31-44b4-ae54-b723b229a7ed@acm.org>
 <0d8cfab5-f956-4758-858c-2cc16082e64b@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0d8cfab5-f956-4758-858c-2cc16082e64b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/20/23 10:12, Bob Pearson wrote:
> The results from yesterday are from Ubuntu 23.04 which has 
> multipath-tools at version 0.8.8. Ubuntu 23.10 has version 0.9.4. 
> Github has head of tree at 0.9.6. Do you recall which version made
> it work when you were looking at this? It may be less risky for me
> to upgrade to Ubuntu 23.10 than try and build multipath-tools from 
> source.

Hi Bob,

I haven't tested Ubuntu 23.10 yet but I think it's worth trying to
upgrade to Ubuntu 23.10. I switched to openSUSE Tumbleweed for running
blktests. Sorry but I do not remember the version number of the broken
Ubuntu multipath-tools package.

Bart.
