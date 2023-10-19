Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764BF7D0259
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjJSTRO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjJSTRO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 15:17:14 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194FBE;
        Thu, 19 Oct 2023 12:17:12 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso69186b3a.2;
        Thu, 19 Oct 2023 12:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743031; x=1698347831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axkcK7ju1lV/hILMbdVCsfPNH/jiJV0uBKZl7LAw0GA=;
        b=A9fcwwAt8o/maZuVyzMK0qi3nS7s5tH3WxkFp6MTBKKYxSp0WDWB1wRGXk3eX2Mvpq
         pVxGibIqnuuZnybjD+LfRovNkFntRDAuwndiASCZhZi/5pcWXno+PvNFXCLgUhRQ4ASq
         IzNrknAaPDBoZherfTFCNBOj1nQxHqAVokcJBpveoqgIv2YSNjsM9BCpyeTOMuKTLn7Q
         DTEsA+12QUr1nlL6LIIZXCycv0YuS81uECCoauvTCOuzB3vUQ30GN286AroOeB23DxMH
         rfBQPrETMWg3dR2oaXm96qL3Tu3FuRG/i2BryQN3/DAjaJYqu8wV2ATgIfPAC5i0yF/7
         +Z/A==
X-Gm-Message-State: AOJu0YwZgWPWU4Ruwtb0+wJyT5tgUNUv6scp+IlqJ15VS+t/t8daagL+
        V6Pclpu+KOTc4a3bh5wH/soan1jPd8o=
X-Google-Smtp-Source: AGHT+IHLn+R5n7uBdyxIntDVNCoTj4q0zCMLeyI3LkCzzAifpLtp9EOiMyiSHn7uyQ67LCm4Z01kqQ==
X-Received: by 2002:a05:6a00:2d1a:b0:68e:2d59:b1f3 with SMTP id fa26-20020a056a002d1a00b0068e2d59b1f3mr2803724pfb.13.1697743031470;
        Thu, 19 Oct 2023 12:17:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3306:3a7f:54e8:2149? ([2620:15c:211:201:3306:3a7f:54e8:2149])
        by smtp.gmail.com with ESMTPSA id i14-20020a056a00004e00b0069102aa1918sm148959pfk.48.2023.10.19.12.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 12:17:10 -0700 (PDT)
Message-ID: <5f8a5236-2a31-44b4-ae54-b723b229a7ed@acm.org>
Date:   Thu, 19 Oct 2023 12:17:09 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <eab9460f-d8ae-4479-ad42-ffdeb377c0d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/18/23 14:52, Bob Pearson wrote:
> results are slightly ambiguous but I ran the command here:
> 
> rpearson:blktests$ sudo use_siw=1 ./check srp/002
> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]time  245.018s  ...
>      runtime  245.018s  ...  128.110s
>      --- tests/srp/002.out	2023-02-15 12:07:40.675530344 -0600
>      +++ /home/rpearson/src/blktests/results/nodev/srp/002.out.bad	2023-10-18 16:36:14.723323257 -0500
>      @@ -1,2 +1 @@
>       Configured SRP target driver
>      -Passed
> rpearson:blktests$
> 
> And while it was hung I ran the following:
> 
> root@rpearson-X570-AORUS-PRO-WIFI: dmsetup ls | while read a b; do dmsetup message $a 0 fail_if_no_path; done
> device-mapper: message ioctl on mpatha-part1  failed: Invalid argument
> Command failed.
> device-mapper: message ioctl on mpatha-part2  failed: Invalid argument
> Command failed.
> device-mapper: message ioctl on mpathb-part1  failed: Invalid argument
> Command failed.
> 
> mpath[ab]-part[12] are multipath devices (dm-1,2,3) holding the Ubuntu system images and not the devices created
> by blktests. When this command finished the srp/002 run came back life but did not succeed (see above)
> 
> The dmesg log is attached

Hi Bob,

Thank you for having shared these results. The 'dmsetup message' command
should only be applied to multipath devices created by the srp/002
script and not to the multipath devices created by Ubuntu but I'm not
sure how to do that.

If the above 'dmsetup message' command resolved the hang, that indicates
that the root cause of the hang is probably in user space and not in the
kernel. Did you use the Ubuntu version of multipathd or a self-built
version of multipathd? I remember that last time I ran the SRP tests on
an Ubuntu system that I had to replace Ubuntu's multipathd with a 
self-built binary to make the tests pass.

Thanks for having shared the dmesg output. I don't think it is possible 
to derive the root cause from that output, which is unfortunate.

Thanks,

Bart.

