Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A354B782C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiBOUfg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 15:35:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbiBOUfc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 15:35:32 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8779ED76D5
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:35:21 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso309953pjg.0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 12:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mDobkrF7w1Oj74l/W29IjjKhnIv03oAC0enVntAkIRc=;
        b=jkQl5CrUrDQq7EUnbh651gpHOgWkaIJrYi2yg2sPTpf9DqKh0JSwKM1AsKSoYWOuJL
         6RB3yfHpu7E6qBLBHDa49/7Rm6/6LZNVuCT4P7JcGvv32L1czqHxzyjXIamccT/1/w49
         c5YkSaQZDMNY28baa++8DbwdnQIIGFq8FrasOzpfZw9QdYmLwl1bL3dIMYymNLzHCO5z
         w7xkyzOsWNUdu7609ATcDOV2R9TwXZ3b1XzPQZYRGbsavv7IHnsXXWbfhdCUvYtU9vZt
         pHANHZEjmw0pAJydf9l6GV4JYWAJnumVEfrEUfv/c2TI9Z7/FWuIZ7rFsqQDUtb/5g0x
         ctlg==
X-Gm-Message-State: AOAM533OPcYK5q4NRG5dBQ3IAjfTM4XZDPE1iEbudYyQY+C+BM4BOpRX
        HU+dh46gtXt0nGo3DpjQA58=
X-Google-Smtp-Source: ABdhPJyq0gTELV+9+wVr1xcj3URCuO8jqjeFJYlGIBMSSllDvjYrfBpSwa45oIyqMMDl+wS+8EVktA==
X-Received: by 2002:a17:902:a9c2:: with SMTP id b2mr773643plr.168.1644957320831;
        Tue, 15 Feb 2022 12:35:20 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id t200sm7452961pfc.35.2022.02.15.12.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:35:20 -0800 (PST)
Message-ID: <57896982-d0da-9ad8-a1c9-362cfc236643@acm.org>
Date:   Tue, 15 Feb 2022 12:35:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/3] ib_srp: Protect the target list with a mutex instead
 of a spinlock
Content-Language: en-US
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20220215182650.19839-1-bvanassche@acm.org>
 <20220215182650.19839-3-bvanassche@acm.org> <Ygv0od2d8wXdBLj/@unreal>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Ygv0od2d8wXdBLj/@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/15/22 10:44, Leon Romanovsky wrote:
> On Tue, Feb 15, 2022 at 10:26:49AM -0800, Bart Van Assche wrote:
>> This patch makes the next patch in this series easier to read.
> 
> It is not readability change, but move to lock that can sleep (mutex),
> which is always good thing.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks for the review, but please note that I wrote that this patch 
improves readability of the next patch in this series.

Bart.
