Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD251588101
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHBR2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiHBR2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 13:28:44 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532D48E96;
        Tue,  2 Aug 2022 10:28:43 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso9049205pjq.0;
        Tue, 02 Aug 2022 10:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6d45g8YxgzfmSxBicyPqIYIzq8Y324sqlVxs4AZJWpM=;
        b=nVxICO8o7OcEA6lr4emu8o6UrNiKnc9WKbmtMGDGdm39sT4Ah4sMKpzrV4jw2oxI7p
         RcygyWNoOfW0bxpT3bo+iOivv+MD/v+vr8Q4SKxsKkXfdPkT49WuGphhBT1/lsFbQdWs
         zPxLST+WopU0gmkzFL5ToiT9S8D9VGpM5rSRnklqA+Rftt7ZCGIv4iTQs/UDwblBwp1D
         WEGRmHGeqdGkbDphWhqMTnmOfhaFGESwfXz3iMjBCz3+ft34ed+J8v1Ui5I15t6czaOR
         NSKkm/JkdH/+rVC1a8h6JfVpw1a4Z02OFzPEhYdglIYfMx6ggebmOI7MYLepzXVc8pVn
         jcOw==
X-Gm-Message-State: ACgBeo1Qph/8Nv/ldCCvAtcPwjzfdaLtVByEhf6i68C2DgP1bemCDMM7
        vtnqAGDVEolr0r1ncfqocEE=
X-Google-Smtp-Source: AA6agR5VxGYxDPxcI0XQsfdV7DY3CJ0qhe24Z6iA6SHSZy7JoQsYLBH6a5omlRLfW+04ztL79Aadiw==
X-Received: by 2002:a17:902:edc4:b0:16c:d2ef:7fd2 with SMTP id q4-20020a170902edc400b0016cd2ef7fd2mr22023804plk.160.1659461322908;
        Tue, 02 Aug 2022 10:28:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5297:9162:3271:e5df? ([2620:15c:211:201:5297:9162:3271:e5df])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b0016bdeb58611sm12398511plh.112.2022.08.02.10.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 10:28:42 -0700 (PDT)
Message-ID: <c4153499-fc79-15a2-57e7-b82dc6c5ea5a@acm.org>
Date:   Tue, 2 Aug 2022 10:28:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/ib_srpt: unify checking rdma_cm_id condition in
 srpt_cm_req_recv()
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
 <bb20de72-fc15-feb1-541a-91454593e043@acm.org>
 <c37397fc-f406-db4a-64db-294457384c40@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c37397fc-f406-db4a-64db-294457384c40@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/1/22 20:35, lizhijian@fujitsu.com wrote:
> On 02/08/2022 00:46, Bart Van Assche wrote:
>> Although the above patch looks fine to me, I'm not sure this kind
>> of changes should be considered as useful or as churn?
> 
> Just want to make it more clear :). you can see below cleanup path,
> it's checking rdma_cm_id instead. When i first saw these conditions,
> i was confused until i realized rdma_cm_id and ib_cm_id are always
> exclusive currently after looking into its callers

Ah, that's right. Thanks for the clarification.

Bart.
