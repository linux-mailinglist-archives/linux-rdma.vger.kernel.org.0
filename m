Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40067CE965
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJRUuB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRUuB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 16:50:01 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF649B;
        Wed, 18 Oct 2023 13:49:59 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c9e06f058bso849385ad.0;
        Wed, 18 Oct 2023 13:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662199; x=1698266999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJvsg4Y7eeEKUR6F8yWD8i9+CEex+RR/NTJ0XNlEV/Y=;
        b=p2SDcYQd1Vj/HLOcTZjL614cL8RTnAlHK6bOqQBi+yPwRYb0il5eOWJEG6oGC2JTzM
         3k4C8XEtduBndD9Hlz9s292uNgBWkHAXz4qZOvodrbJ/T551UCuvTmkRrq+O7hnKHfnF
         p/0c5oGMhnXaUiuN+bmDMLFWt+yDso+UyKCbjBfiDlCxsREn/Y4ZcKDhK5NfIP0fZHQ/
         6Fa3rcNtV/+XALJDLjVfwHJaKAuPG59mXJ+6yHEp9mtppoACFA6ic9eM8Hy3B54M8fHR
         60N77ZAGeQ4YgaJdCP5lHmspYBqHSx4uvnRuBFWhdaXRlMH21gC5TaN5Kxb8wNE9HS5Q
         vIYg==
X-Gm-Message-State: AOJu0Yx+Ad7QCmaAei3yUR4pcHm04xNXV0WsrdzkOc0EH+NBDTjeA+d4
        JgFYC4WOVhRyYy6797TxCRQ=
X-Google-Smtp-Source: AGHT+IEsYMYoSas7XDXDlbth4qByY5YAxpQTFxWvXiA0qPcFnrVuwAS7T+bHGDw5PRS6eKUjnyY4mA==
X-Received: by 2002:a17:902:ec83:b0:1c7:27a1:a9e5 with SMTP id x3-20020a170902ec8300b001c727a1a9e5mr666646plg.33.1697662199256;
        Wed, 18 Oct 2023 13:49:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709027c1300b001c3721897fcsm352476pll.277.2023.10.18.13.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:49:58 -0700 (PDT)
Message-ID: <6f5ed2dd-3809-4805-8d31-de24f3f14486@acm.org>
Date:   Wed, 18 Oct 2023 13:49:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fb5f6da5-5017-440d-9cb5-38796554366c@gmail.com>
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

On 10/18/23 13:29, Bob Pearson wrote:
> OK, with clean code from current rdma for-next branch with the .config I sent before, if I run:
> 
> rpearson:blktests$ sudo use_siw=1 ./check srp/002
> [sudo] password for rpearson:
> srp/002 (File I/O on top of multipath concurrently with logout and login (mq))
> 
> It hangs. The dmesg trace is attached.

Thank you for having shared the dmesg output. If the test setup is still 
in the same state, please try to run the following command:

$ dmsetup ls |
   while read a b; do dmsetup message $a 0 fail_if_no_path; done

If this resolves the hang, this hang is not a kernel bug but a bug in 
multipathd or in the test scripts.

Thanks,

Bart.
