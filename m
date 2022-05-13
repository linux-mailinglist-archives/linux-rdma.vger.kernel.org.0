Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B6525A46
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 05:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350219AbiEMDk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 23:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiEMDk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 23:40:26 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928F2670B7
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 20:40:24 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id v11so6580609pff.6
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 20:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BWeg+w0ocO51p3r+I7iALMN70zF2qUFPcMktnAQncAc=;
        b=E98r+rbs3t1KoyO+TpGk2Ag8pjJI8v3NVocyfIJBIsobLNMkLzC1xMomeur11RufiG
         cMIwBytCsvN4+GAkKptB/oQ4U3cv4+kySzpkJVmbkN0y6V+Lg09BM99w1tYbkk8EdqZr
         VOnQ2+vM9gOJqCcGHULk3sY9znYGJhAdSCXZMlxrWgSCs/lpZhYgtmZIrkiRC/XXCfpw
         wpatLtBDw90Q5SykbH6wDD4vIKNk/v3JXmPiCQmSfuor1Pm+KUUdbt/s5LWZxTdPLrEy
         ZO4EyAZOSS5aqtBIy73+/Q8oKKRtXsh6pV/97BORVnMR78ln7IaNYKJAeAX+u+W+f2TY
         viVA==
X-Gm-Message-State: AOAM531Rw7tFq/A/K6jfNZLt5udSY55ZjR4gj4WmX+FjN+Xe3gQB+ohF
        l9X8Y9A4+2wDUVmuEXcsO0c=
X-Google-Smtp-Source: ABdhPJzyPJ0cJktDWia56NTepN/fAefUkDN5PtxNDIwoYrvff8GkcDEkdLBxel3HvnEucozJokmZzg==
X-Received: by 2002:a65:4007:0:b0:3c6:c6e2:1ccc with SMTP id f7-20020a654007000000b003c6c6e21cccmr2269251pgp.500.1652413224159;
        Thu, 12 May 2022 20:40:24 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id p26-20020a62b81a000000b0050dc7628177sm574140pfe.81.2022.05.12.20.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 20:40:23 -0700 (PDT)
Message-ID: <7b8f7d5c-cda5-a160-b988-186b371a6e4d@acm.org>
Date:   Thu, 12 May 2022 20:40:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
 <43c2fed8-699f-19fe-81fa-c5f5b4af646f@gmail.com>
 <4c3439c3-6279-804f-63b2-99d8529e5d3d@acm.org>
 <b2908c39-636a-1cba-db22-838640385d84@gmail.com>
 <529dbb0a-0b75-9752-62a3-a1235565aa1a@acm.org>
 <66379f8e-c7ab-1daf-b2a8-19d0368e229f@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <66379f8e-c7ab-1daf-b2a8-19d0368e229f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/12/22 17:41, Bob Pearson wrote:
> OK thanks. I don't exactly know how to merge "the latest master branch". I did merge the tag v5.18-rc2 and am now trying
> v5.18-rc4. As far as I can tell rc6 is the latest branch. When I tried to merge the git repo it didn't work.

Hmm ... what didn't work? Merging or running blktests?

Anyway, this is how I merge Linus' latest branch:

$ git remote add origin \
     git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ git fetch origin
$ git merge origin/master

I also found which commit I merged from the master branch (see also my 
email from May 7):
$ git merge 4b97bac0756a

Thanks,

Bart.
