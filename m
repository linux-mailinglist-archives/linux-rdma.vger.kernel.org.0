Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDA520A49
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 02:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiEJAjl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 20:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiEJAji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 20:39:38 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFCBC15
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 17:35:42 -0700 (PDT)
Message-ID: <a52a0cc3-7f29-05f3-04f3-585483cd5d1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652142940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9Sr7dl6ONbd9WbGyxIocQz05RVzzN6rjQndLMm7MK4=;
        b=BTocY93N+X2qqyjD6Ry4/9YhpejKqYAXX4Mr9nqb5USzCc5hKXZ2NjAl+cB30WFrw05/Au
        O7oQG/x94Rtw96Ps//3u/teT4g8bkfoaMESa85odwAyU4AIyo+CfM1DLOlPK2O4vKsHVo2
        SznrpXKMOEmoMpPQh3d3oPWbFsEm1DQ=
Date:   Tue, 10 May 2022 08:35:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220509182353.GA927104@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/5/10 2:23, Jason Gunthorpe 写道:
> On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:
> 
>> Bob Pearson (10):
>>    RDMA/rxe: Remove IB_SRQ_INIT_MASK
>>    RDMA/rxe: Add rxe_srq_cleanup()
>>    RDMA/rxe: Check rxe_get() return value
>>    RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
>>    RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
>>    RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
>>    RDMA/rxe: Enforce IBA C11-17
> 
> I took these patches with the small edits I noted
> 
>>    RDMA/rxe: Stop lookup of partially built objects
>>    RDMA/rxe: Convert read side locking to rcu
>>    RDMA/rxe: Cleanup rxe_pool.c
> 
> It seems OK, but we need to fix the AH problem at least in the destroy
> path first - lets try to fix it in alloc as well?

I do not mean to bring more efforts to Bob.
But normally a new feature is merged into rdma. some test cases should 
also be added to rdma-core to verify this new feature.

But if Bob is busy with AH problem, I am OK with it.

Zhu Yanjun

> 
> Jason

