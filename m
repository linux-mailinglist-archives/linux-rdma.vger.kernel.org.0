Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B86119FD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 20:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJ1SQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1SQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 14:16:19 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DF236423
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 11:16:14 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso3410282otq.11
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22uxSD4imOaNI6/t1IyeDjy1rg6Zrf1hW1dge3CSafg=;
        b=PmmnWAjXk0jhbVGe4MoFG0EZFZvEYG6WmH9XYTOoNktPv3yeZ2145LlSJXA6S+fUYY
         1TWl30GQuJ4D7ks6iYKxQfxggfIF8yV4J/y59kmr+ePnsJEpzkLvQ8ohI+QXulXRibe+
         sz9yAQbvOdiCyXNhbj5oLsJE8bOt6VX6qz0hddJSFeiyBrBI1IyCRpJZ+VBpI9vze85h
         MB0aTcRdiy7O1ymvRnhgs0oQ+mX+YFpfgPp0nLOduFSDeokfjA79qCshhQ1vtTFiaNhh
         l6Uz13DFbbq2whXgAv6ZLX9eb0H8sIaTQ2+88VGLwdyskphLVPvmc6Q5K3fC+/UZJ+ec
         zVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22uxSD4imOaNI6/t1IyeDjy1rg6Zrf1hW1dge3CSafg=;
        b=kNElhV7oYVSFVUS5e0AyZPv7Hi1mEhcdk09b48YfmSr6vBzcSpr7Dxeiq7PgNN2eSO
         5NcJYGSTIFot8gzaqD+lAblSWJVS2Ut/xRhMK2m/3YMQs0EQxGHlHLC/NctD1LBv/oC4
         7HqjmYaGvKHu6Cn+qqmcRiNWOOs7b7txce4teBO959bDU4Od/EkOs04n9vNlrFT2moAe
         gu61NwpGjwiJMDBfKGTpVs5iz9nHLvgu3683b9Lq9b64+RMHhXR1d8uM/NdbxuagCLNQ
         t6jnJ5rP3DLhX9HcaHygNfOFEcJdaHSXY6ANFmpCABOQwyFqvRdlMUaEiSQEc1AUSRvX
         OgYg==
X-Gm-Message-State: ACrzQf1D8q7oABXXVnFVPj0kDeMcaD3mnZxnhQiDalbv2wkS92oeUke7
        kBnogrzL1ZrQAH6tpCdzIXA=
X-Google-Smtp-Source: AMsMyM4ucVzcIVjbTKH0DaqEk+xpKhESZdus6ghhndzvZfPTvZRXoq6R3XtAonYmQcrwT0+KMPW2aw==
X-Received: by 2002:a9d:2f65:0:b0:66c:3766:ea2c with SMTP id h92-20020a9d2f65000000b0066c3766ea2cmr290316otb.385.1666980973418;
        Fri, 28 Oct 2022 11:16:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ff6f:6a:59a:5162? (2603-8081-140c-1a00-ff6f-006a-059a-5162.res6.spectrum.com. [2603:8081:140c:1a00:ff6f:6a:59a:5162])
        by smtp.gmail.com with ESMTPSA id e18-20020a05680809b200b00359a9663053sm1764218oig.4.2022.10.28.11.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 11:16:12 -0700 (PDT)
Message-ID: <6696eff3-2558-6aba-2d62-47b9d4b73fc6@gmail.com>
Date:   Fri, 28 Oct 2022 13:16:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 00/18] Implement work queues for rdma_rxe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, jhack@hpe.com,
        ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <Y1wLi5lFAGeeS9T3@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y1wLi5lFAGeeS9T3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/22 12:04, Jason Gunthorpe wrote:
>> Bob Pearson (18):
>>   RDMA/rxe: Remove redundant header files
>>   RDMA/rxe: Remove init of task locks from rxe_qp.c
>>   RDMA/rxe: Removed unused name from rxe_task struct
>>   RDMA/rxe: Split rxe_run_task() into two subroutines
>>   RDMA/rxe: Make rxe_do_task static
> 
> I took these patches into for-next, the rest will need reposting to
> address the 0-day and decide if we should strip out the work queue
> entirely
> 
> Jason

I'm guessing you meant tasklet??
