Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530787DA4E7
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Oct 2023 04:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjJ1CsN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 22:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjJ1CsN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 22:48:13 -0400
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72056E5
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 19:48:10 -0700 (PDT)
Message-ID: <45c23e30-8405-470b-825c-e5166cd8a313@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698461288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LiS5gJoJXr1uvIJn0YRDnW+BVIyqW/T0Ecfm5ATtk/Q=;
        b=iThagDobBCOkgZ5mOT3iQCDgW7Ato7fhIIe2r1oieOYNrIsUHyhVeE+MfwFfOlH9XsS0F4
        YOK78tei8SSOLP9Wc+VFvjv252qRsyLS44Rrgs1Sepn4rZEmKS2qI1pERjlecn4VNHhvQE
        ekM3yXLdxVbjR1xG+ehD/e0IKU8QfaU=
Date:   Sat, 28 Oct 2023 10:48:00 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
To:     Bart Van Assche <bvanassche@acm.org>,
        Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
 <adad4ee6-ceef-4e45-a13d-048a1377e86f@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <adad4ee6-ceef-4e45-a13d-048a1377e86f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/28 5:46, Bart Van Assche 写道:
> On 10/27/23 01:17, Zhu Yanjun wrote:
>> When ULP uses folio or compound page, ULP can not work well with RXE 
>> after this commit is applied.
> 
> Isn't it the responsibility of the DMA mapping code to build an sg-list
> for folios? Drivers like ib_srp see an sg-list, whether that comes from

A folio is a way of representing a set of physically contiguous base 
pages. In current implementations of folio, it seems that sg-list is not 
used.

In Folio, some huge pages whose size is not PAGE_SIZE is dma-mapped into 
hardware.

So the page size of folio is not equal to PAGE_SIZE. If this commit is 
applied, it causes potential risks to the future folio.

I have developed some folio work for some NIC and RDMA drivers. In 
Folio, the page size of Folio is possibly not equal to PAGE_SIZE, it is 
multiple PAGE_SIZE. And when folio is dma-mapped to HW, the page size is 
equal to multiple PAGE_SIZE.

In this case, ULP with folio will not work well with current RXE after 
this commit is applied.

Removing page_size in RXE seems a plan for this problem.

Zhu Yanjun


> a folio or from something else.
> 
> Bart.

