Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2359CD42
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 02:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiHWAjd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 20:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiHWAjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 20:39:32 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405524BD0E
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 17:39:31 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: No need to check IPV6 in rxe_find_route
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661215169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RKeu5raZdsKEPGUmbCeUYR8RizTi79uyNPx+sR0JISs=;
        b=TWV8aQVgGCcyjS4RgVIxc6lP8s0+3w1G9SWwiPebZyOg2xHSD/45pitA5erYL34n8S2f6y
        EcvWsmIxOLuOZLJZmabblnlDt30kkIboHOgckgRy8pOFkU1ow7vxiNlDUFDW15fM7nqMp9
        VZ2S3Lm1J1oAifUQz+ToL5SM2hWpZ/w=
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220822112355.17635-1-guoqing.jiang@linux.dev>
 <6E8EBFAA-E346-413E-9DEC-84EC779CBAB6@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <aa78da33-d829-e8c9-3c14-f64219028307@linux.dev>
Date:   Tue, 23 Aug 2022 08:39:17 +0800
MIME-Version: 1.0
In-Reply-To: <6E8EBFAA-E346-413E-9DEC-84EC779CBAB6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/23/22 12:33 AM, William Kucharski wrote:
> Rather than remove the #if guard here, shouldn't it instead be expanded
> to cover the entire
>
>      else if (av->network_type == RXE_NETWORK_TYPE_IPV6) {
>
> clause?
>
> There is no need to check for RXE_NETWORK_TYPE_IPV6, make assignments
> to the stack-allocated pointers or call rxe_find_route6() unless
> CONFIG_IPV6 is true.
>
> In fact, if CONFIG_IPV6 is false, as rxe_find_route6 would also return
> NULL, the else clause to the RXE_NETWORK_TYPE_IPV4 check could instead
> become a simple
>
>      return NULL;

Thanks for the suggestion! And it could also resolve the issue reported by
LKP too.

Thanks,
Guoqing
