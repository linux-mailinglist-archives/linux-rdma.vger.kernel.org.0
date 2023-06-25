Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B873CD97
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jun 2023 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFYAyS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 20:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFYAyR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 20:54:17 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8E10D8
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 17:54:16 -0700 (PDT)
Message-ID: <c973ddac-2f7f-ca8d-49a0-3f490e7343a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687654454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AErB05jdWB40vdbBAAW+enN+qEvUBzufZ13kpj8BniQ=;
        b=iSsH3AxJixyVTXAd6pKmcVt9Ba2DYGAZr/eaWfTbiBOoLXIhwRMMM8C5tQKyMuqWKHxnko
        OLQLb+whktVPqhwkB66eM3manMV0grw1wMUKPOYJapTKCqSQ9/KIhJIPLebrhgpOC2/4NV
        Wazfvr4suEkLJrlzDjkQZFjOBx3Awxo=
Date:   Sun, 25 Jun 2023 08:54:09 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6.4-rc1 v5 0/8] Fix the problem that rxe can not work in
 net namespace
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "parav@nvidia.com" <parav@nvidia.com>,
        "lehrer@gmail.com" <lehrer@gmail.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
 <4f097d4a-85f5-392f-53bb-85ca0d75e16f@gmail.com>
 <fbba95ad-a0f7-435e-c152-d6094b70bb1f@gmail.com>
 <8e13254c-f8f5-f9ce-14fe-f8fd21c0c6bd@linux.dev>
 <3f472f86-43d7-037a-d7d2-207314e183fa@gmail.com>
 <05d4a5d8-9646-49b0-9d7f-19d8966a308d@linux.dev>
 <MW4PR84MB2307BB2D7AC00BE3A63F6D5DBC20A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <9DD4E3B8-7FA1-4054-8AC0-85FC96D710A7@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <9DD4E3B8-7FA1-4054-8AC0-85FC96D710A7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/6/25 1:32, Chuck Lever III 写道:
>> The GID of rxe can not be generated with lo. This is a problem.
> I agree, and would like to see a fix. It's obviously going to be a very
> useful use case for CI environments for upper layer storage protocols
> such as NFS and SMB, for instance.
>
>
>> Now Chuck Lever <cel@kernel.org> will fix it.
> My understanding is that, because RoCE allows more than one port per egress
> device, the mechanism for enabling rxe-on-lo is going to be different than
> it is for iWARP -- or it might not be possible at all. That's why my siw
> patches do not implement a fix for rxe.
>
> Jason needs to outline a mechanism for it so we can see what needs to be
> done. At which point, any interested party should be able to fix it.

Look forward to the fix.

Zhu Yanjun

>
>
> --
> Chuck Lever
>
>
