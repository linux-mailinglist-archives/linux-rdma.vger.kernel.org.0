Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF54F9FC2
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 00:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiDHWww (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiDHWww (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 18:52:52 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B52BD5
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 15:50:47 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e189so10281349oia.8
        for <linux-rdma@vger.kernel.org>; Fri, 08 Apr 2022 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=aDou1XjJPcvv4fmmQt2a8E0jK4ICtrAy2+BKOKPDBaY=;
        b=heV1kRgyAUaTrcULbcAiFGNM2vd9rIftSD93XsoaMyNN/FSTjXz1cSSN8FmSPhJzu7
         353z3wGThKo45dDDXC34cIoZx9af/k6xOEcUF3mXYfMRSuWkIE5YKy8jGNT8U4SiOgY/
         eeIIfHpMci0qCsl7MdYCS5i2TzbMd+lQW853zAjp45ZIZe38mPEpGwJNDNTb3fEXUihp
         wPm8aSOOFdT5zX4S/3b5rUZAbmCd2mBTforzdcW5e5Ga5nCbJezO5Q2z1GjHK9rZokBO
         fiuz//amSSi7H9m1YYL09hqsy/ZN6YfL0yDLLfquJuITgbUoFECdUmm1KRwXvZsdd+HR
         NWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=aDou1XjJPcvv4fmmQt2a8E0jK4ICtrAy2+BKOKPDBaY=;
        b=5sqrl6Y8UNWIWm2+mclS2F14RsLUjXl2Kuu7gsc5Acchzq9aUY2ZV3oNDbKWLhH84y
         NKOKdhSyZrsmy/sm6Xq2fvBtrBZzsYBatRpkg4AT6gzxzygFrj6AGaWGlEwXYAZXHWvL
         fFl9Vp8fe8LuiVmxPqrGOXe1M8hBN57Av4zbiAaIlODkzMvzyUZvr4fITagTSelcllwB
         6WF/Hf++z1NxpBuDa0lWWzWFamtnGLciFAhDRCTzbJCwjz0sQO4hwqyOY46d+tlzpdFX
         0SXilGVjPeG67GTaa2en6Pb8tjPZjSeU8/AcMd64vtejXx6aFKz7qQo8XnMO+AGbuDCV
         KKWw==
X-Gm-Message-State: AOAM533b/LGQXjSRIghaW6Vu96pNENRqaJ9tZTBMJUkeTGooSZH84BAy
        s2K+T1K9/IgqYAXsDVmhwX4=
X-Google-Smtp-Source: ABdhPJwiFNNmNB2vO1r/0kMYOEe504vqcfEaYxLUwsfJEpeNUvJBKXgwpwwoVid98CeqjNOPXgUVYA==
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id t22-20020a056808159600b002f75d89eec7mr963030oiw.228.1649458246861;
        Fri, 08 Apr 2022 15:50:46 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d36a:c09a:7579:af8a? (2603-8081-140c-1a00-d36a-c09a-7579-af8a.res6.spectrum.com. [2603:8081:140c:1a00:d36a:c09a:7579:af8a])
        by smtp.gmail.com with ESMTPSA id d9-20020a9d51c9000000b005b2466cd7b3sm9464047oth.36.2022.04.08.15.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 15:50:46 -0700 (PDT)
Message-ID: <28b4c636-c5a7-451b-965b-6201ac5af460@gmail.com>
Date:   Fri, 8 Apr 2022 17:50:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: blktest failures
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
In-Reply-To: <533dc3b0-e58a-0bc8-2f07-5dbfb3d1235e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/8/22 17:10, Bob Pearson wrote:
> Bart,
> 
> I finally was able to build a kernel with lockdep enabled correctly and saw the error that you and others reported.
> I am not familiar with lockdep output but I am guessing that it is reporting a mismatch between a _bh spinlock
> and a _irqsave spinlock (since those are the only two types used by the driver.)
> 
> I went on campaign a while back to replace all the locks with _bh locks because I figured they would be
> faster than _irqsave locks and because the driver never touched a lock except from a verbs API call or from
> a tasklet (softirq.) As it turned out some code makes verbs API calls while in hardirq context which broke
> that assumption. So some of the locks were reverted back to irqsave locks which fixed those warnings.
> 
> Now it is happening again. I did an experiment and went through the rxe driver and replaced all spinlocks
> with _irqsave locks. Now the lockdep splats have gone away and the srp/001 test reports success. BUT,
> it hangs and doesn't finish. If I try to run all the tests I get warnings about unable to remove the
> scsi_debug driver. I am able to remove the rdma_rxe driver and reload it. I am not seeing any errors in
> the rxe driver.
> 
> Do you have any ideas what to look at next?
> 
> Bob

Actually it doesn't hang forever but I get the following

......
[  107.579576] sd 4:0:0:0: [sdb] Synchronizing SCSI cache

[  291.970133] sd 4:0:0:0: [sdb] Synchronize Cache(10) failed: Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK

[  292.247547] rdma_rxe: unloaded

So it waits for about 3 minutes for something and then gives up.

Bob
