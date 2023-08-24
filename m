Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50AE7871D7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHXOie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbjHXOiL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 10:38:11 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4415A1BC9
        for <linux-rdma@vger.kernel.org>; Thu, 24 Aug 2023 07:38:08 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bf7423ef3eso32972975ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 24 Aug 2023 07:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887888; x=1693492688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j/3iapEUONhkVV9sZculefEdMuJO4tSgB4r285xjQQ=;
        b=UIf3DkWMWnCGkRLst7EWT920aZWRcGTyEYB7g8OnmI5z6DNZWwyY40nF0JAL1ZHg5I
         kwlAtrAn1LdbawC5fKG4T1NWp/9rGMy1T/oOiLVKHJ4nns1nKIxlwVfh/hmn5novq5ov
         SLpk62nSiP6fFv1p0S13fNbp5eDMgkXcdRx1vzTWHcQupCwXvXbW5popQXcHvmYF0Xwf
         BAA4PUgxaTwP6K/oumcik99eBS70ZqvwIkSO3Gz+UmBCFKQHlPBU8GNDqXg3uLDAS6l4
         Bm2CMNYo7l2IQFeqWzZMyrb+vmPZnpnpCvjIIYFOsOxrCEBuhL02TeQZauujdfKf5bEf
         c8Cg==
X-Gm-Message-State: AOJu0Yxpj9PiNv1hbB+8phXkEzDMsnUlxWwUUPui7ad6fshcd4ABUlKa
        RQaLK1IZxXxPSvW/94fz+0I=
X-Google-Smtp-Source: AGHT+IHdGHWZGJvMAzqMYI1FC2I3JDpe81euMDxPrVk/V2Zmf0Yh0ajimLnLjXVxxw02okFqawnZEw==
X-Received: by 2002:a17:902:d507:b0:1bf:3c10:1d70 with SMTP id b7-20020a170902d50700b001bf3c101d70mr15303196plg.6.1692887887572;
        Thu, 24 Aug 2023 07:38:07 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e6ec:4683:972:2d78? ([2620:15c:211:201:e6ec:4683:972:2d78])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b001bde77f3d0esm12941595plc.117.2023.08.24.07.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:38:07 -0700 (PDT)
Message-ID: <fe540444-8454-4d15-f279-92daad4be001@acm.org>
Date:   Thu, 24 Aug 2023 07:38:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <20230823205727.505681-1-bvanassche@acm.org>
 <a57g4ywpwsldusg3ow2ci5nviikma3p3fcoqeatp7pt63fe2tk@xgisoxtde3tp>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a57g4ywpwsldusg3ow2ci5nviikma3p3fcoqeatp7pt63fe2tk@xgisoxtde3tp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/23/23 19:46, Shinichiro Kawasaki wrote:
> On Aug 23, 2023 / 13:57, Bart Van Assche wrote:
>> After scmd_eh_abort_handler() has called the SCSI LLD eh_abort_handler
>> callback, it performs one of the following actions:
>> * Call scsi_queue_insert().
>> * Call scsi_finish_command().
>> * Call scsi_eh_scmd_add().
>> Hence, SCSI abort handlers must not call scsi_done(). Otherwise all
>> the above actions would trigger a use-after-free. Hence remove the
>> scsi_done() call from srp_abort(). Keep the srp_free_req() call
>> before returning SUCCESS because we may not see the command again if
>> SUCCESS is returned.
>>
>> Cc: Bob Pearson <rpearsonhpe@gmail.com>
>> Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Fixes: d8536670916a ("IB/srp: Avoid having aborted requests hang")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Thanks Bart. Do you think this patch fixes the hangs at blktests srp/002 and
> srp/011? I tried this patch and still see the hang at srp/002, but the hang at
> srp/011 looks disappearing.

I have not yet tried to verify whether the above patch affects any blktests.
The above patch is a patch that I developed a few weeks ago but that had not
yet been published on the linux-rdma mailing list.

Thanks,

Bart.
