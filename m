Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E6853341E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 01:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiEXX4e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 19:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242833AbiEXX4b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 19:56:31 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D11C93C
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 16:56:29 -0700 (PDT)
Message-ID: <10df6324-0c48-5902-3a7c-7cd898cd561d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653436587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46lr3Vr0coJYfV6DOH2k9OphJMRrCIXi0yf3VBhWXDs=;
        b=EBn7DzYKu2fJ/Iol0Qd7RdU3yA4t8VzmYggi9Gl9YI8nkdzjhdsK7WF3KcUDO1omTi/d01
        jGue+riDsoXxHlkzOG09uwVDZ2N3fqVQJIPSlEL1uZfs63h0N9ac+piykFs/gNMoY+VKMn
        7mgazpWkx1/1KbvE3JEacxbrwkcsSvE=
Date:   Wed, 25 May 2022 07:56:21 +0800
MIME-Version: 1.0
Subject: Re: null pointer in rxe_mr_copy()
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1b0ae089-ff3f-7e84-4c07-a5d97554e3c0@gmail.com>
 <CAD=hENdM=VEF4MM_L=W1PtiX=x2s_kucMLc41WWmK-6c6s2Nrg@mail.gmail.com>
 <CAD=hENet+KQe35eqXabM+EpucHh3mYypUo4H8S-XmwNPcOv4+A@mail.gmail.com>
 <84888208-ac2e-115c-43d5-2ef211948c78@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <84888208-ac2e-115c-43d5-2ef211948c78@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/5/24 21:18, yangx.jy@fujitsu.com 写道:
> On 2022/4/11 13:34, Zhu Yanjun wrote:
>>    738         if (res->state == rdatm_res_state_new) {
>>    739                 mr = qp->resp.mr;
>> <----It seems that mr is from here.
>>    740                 qp->resp.mr = NULL;
>>    741
> 
> Hi Bob and Yanjun
> 
> I wonder if the following patch has fixed the null pointer issue in
> rxe_mr_copy().

Yes.

Zhu Yanjun

> 
> commit 570a4bf7440e9fb2a4164244a6bf60a46362b627
> Author: Bob Pearson <rpearsonhpe@gmail.com>
> Date:   Mon Apr 18 12:41:04 2022 -0500
> 
>       RDMA/rxe: Recheck the MR in when generating a READ reply
> 
> Best Regards,
> Xiao Yang

