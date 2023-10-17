Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F07CCC0A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjJQTSi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 15:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTSh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 15:18:37 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ACAB0;
        Tue, 17 Oct 2023 12:18:36 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso3462166fac.3;
        Tue, 17 Oct 2023 12:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570315; x=1698175115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyTOPHnqANUhueraadoEvNRhNazWFntTshu8gviQAZk=;
        b=Mu3IuIyNbOFsM/H78wokJMObaxOPcuMPaMH0o2yT+OD85SYu46oegCRR4He+81xp+6
         2wY528EfYCfZkxmhoRByyC2CN7J4p+avJ/atJpN7970MawZJf5wTL6HHpGY6UXUzUpkZ
         LCttieQ9nMAgrQLu5410K6CXEu9AwXJeW4OAyNUByvsSmNKYFeSMlzqO+9YyNANdpEVr
         o/NnT7LRIz67YKxdlmiyXxI6IUI/7o1DgPUHDwTCmKaPBATl05KMpJvxhQWEwkt+MunJ
         Ol/f5O8xRQeNKsVyW6xl7KKrZzT9AXK5mVsgYkrgPHA4ZL3wBFHRtBVQ1StnSO5Pbu6N
         yZ+g==
X-Gm-Message-State: AOJu0YzYKRHSRT6kecO2S3//bUR2megvgnjAnptgmuD4rDmK0lIN+jfJ
        Q6p+RxjrYZQ6wY8iW6z7eXY=
X-Google-Smtp-Source: AGHT+IFxf9kxZnolJQu91WiA66z6SIIgNXdZPv5uRzz41O4Qn+y2N+TxZ+AqQxydcHsOPHbOZzbbrA==
X-Received: by 2002:a05:6359:29c4:b0:143:897e:6e31 with SMTP id qf4-20020a05635929c400b00143897e6e31mr3158374rwb.7.1697570315281;
        Tue, 17 Oct 2023 12:18:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id x129-20020a626387000000b006a77343b0ccsm1881834pfb.89.2023.10.17.12.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 12:18:34 -0700 (PDT)
Message-ID: <99efdfe9-0d86-4c37-bea1-9ed59624c786@acm.org>
Date:   Tue, 17 Oct 2023 12:18:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <20231017175821.GG282036@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231017175821.GG282036@ziepe.ca>
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

On 10/17/23 10:58, Jason Gunthorpe wrote:
> eg this kind of design pattern carries a subtle assumption that the rx
> and send CQ are ordered together. Getting a rx CQ before a matching tx
> CQ can trigger the unusual scenario where the send side runs out of
> resources.

If an rx CQ is received before the matching tx CQ by srp_queuecommand(),
then srp_queuecommand() will return SCSI_MLQUEUE_HOST_BUSY and the SCSI
core will retry the srp_queuecommand() after a small delay. This is a
common approach in Linux kernel SCSI drivers.

Thanks,

Bart.

