Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75893565886
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiGDOV5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiGDOV5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 10:21:57 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E087647
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 07:21:56 -0700 (PDT)
Message-ID: <bc7eb915-d1c0-4bb6-0714-1943701f4068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656944514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Svx+N2I2SXf6AqokarVkN8w35UTsqDYO76CSeZfYAJc=;
        b=qEylGGQukAXhh7CUl0BLjjJPBiAPs9EuZihING1wL2XlK1+05X9iGgejpT+QKLMEQxJJYH
        X4eLwjHue/I/uId1N01CBXnmn8tLUuAdGaAdNiVyHIlhJwyvWaIMurrTM7nRwTrbxxusdr
        JIq7KPZnu9p9Vvf9JA1Tdrrjb5JL4ag=
Date:   Mon, 4 Jul 2022 22:21:37 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in
 rxe_qp_do_cleanup
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
References: <20220705012212.294534-1-yanjun.zhu@linux.dev>
 <20220704125430.GA23621@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220704125430.GA23621@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/7/4 20:54, Jason Gunthorpe 写道:
> On Mon, Jul 04, 2022 at 09:22:12PM -0400, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> In some error handlers, both scq and rcq are set to NULL before
>> calling rxe_qp_do_cleanup.
> Describe the error flows in the commit message please

Got it. I will send the latest commit very soon.

Zhu Yanjun

>
> Jason
