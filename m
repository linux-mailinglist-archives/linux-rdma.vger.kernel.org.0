Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9A6EDB83
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Apr 2023 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjDYGKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Apr 2023 02:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjDYGKi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Apr 2023 02:10:38 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43046AD39
        for <linux-rdma@vger.kernel.org>; Mon, 24 Apr 2023 23:10:37 -0700 (PDT)
Message-ID: <f353ba56-0c12-edad-0cd6-6c8bb01c6ddc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682403033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJOrQjtPfl2Tyb5ZoSXL0180S26nwert7SVu8THRMC4=;
        b=ku7sNlfzBk5RGRTEJJcVP0uH7tStZyV9mCdczeJDVyHAqlydL5Luiw+4hS4XmV2jSHVjKa
        EL0jA5AfUbwgQ7O2g3MWU+sfFKWkUznvT7MvHZ5GDMIi6mGJHVEVAAwNIHbxA6OfqxqOgW
        k1VGhMaF574mZo76HuVQ4OgOx64zekc=
Date:   Tue, 25 Apr 2023 14:10:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 3/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     Jinpu Wang <jinpu.wang@ionos.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
 <1682213212-2-4-git-send-email-lizhijian@fujitsu.com>
 <c5a35877-4b73-b24a-0b59-22cfcb491810@linux.dev>
 <5a40c35b-7c6d-3eb2-a637-015a8a0b9dd6@fujitsu.com>
 <CAMGffE=M+DKumLvj=pyebxjDg3Ot+h5BGkcqxyJPiYu0C_6KHQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAMGffE=M+DKumLvj=pyebxjDg3Ot+h5BGkcqxyJPiYu0C_6KHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/24/23 12:33, Jinpu Wang wrote:
>>> Can we factor out a function for above? Then rtrs_clt_stop_and_destroy_conns
>>> might reuse it as well.
>> I'm open to this. but they are a bit difference IMHO.
> we can do the refactor later after bugfix.

Yes, maybe next cycle.

Thanks,
Guoqing
