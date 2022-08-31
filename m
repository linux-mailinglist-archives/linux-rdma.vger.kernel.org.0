Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0365A75E8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 07:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiHaFtH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 01:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHaFtG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 01:49:06 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64EBA9C6
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 22:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661924943; i=@fujitsu.com;
        bh=cyTJGf1upYI7FQKHfolbe5GrLPqtEpC9kRTHD+YWBqk=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=A33TtqVJgYGOgUKd4ShjTeheIDL9/351p2pIuJHnXyIOFaa9db1RvG7qU1Rri83B9
         tVkJDUtWb2SaY6Qb7fmFlAM5sdm9SciwKUBlXeyrbYQe01bz7CzAiwZJR4wnj4s/vw
         cPtUSoK4H22idm3KOA5PHXhm+KkXzuCeNoMkufGHWeOQk/sMeeAOicRR+QnQFHl8/f
         LnfWqSZmrwp+7a3a1Q/tNo6phKZ9QEA7z5YYSE3ubePXSc4GJWqRhpUJ+Q8/jW/NE2
         o4kXH1+GZFJBrYVK5tQYPA2fw8HNps4uCLeGgNOcUEUvQk6RbdWO2+eloy4Rp5yMUR
         +5ifTRxRvUppw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRWlGSWpSXmKPExsViZ8OxWdfvG1+
  ywZ/fohZX/u1htGhZdIXN4tmhXhaLL1OnMVucP9bP7sDqsXPWXXaPXbsa2T16m9+xeXzeJBfA
  EsWamZeUX5HAmnF311amgnvMFVdeVjcw9jB3MXJxCAlsZJS4ffM1E4SzhEniw/kf7BDOdkaJt
  T97WLoYOTl4Bewkjrx7xQZiswioSnzuW8sMEReUODnzCViNqECExMNHk8BsYYFAiX0rbzOB2M
  wC4hK3nswHs9kENCTutdxkBFkgInCdUWLVogXsIAkhgR5GiaOrc0BsToFYiXWbljFDNFtILH5
  zkB3ClpfY/nYOWFxCQFHiSOdfFgi7UqL1wy8oW03i6rlNzBMYhWYhuW8WkjtmIRk7C8nYBYws
  qxitkooy0zNKchMzc3QNDQx0DQ1NdY3NdQ0t9RKrdBP1Ukt1y1OLS3SN9BLLi/VSi4v1iitzk
  3NS9PJSSzYxAmMqpVhVeAdjx8qfeocYJTmYlER5f63kSxbiS8pPqcxILM6ILyrNSS0+xCjDwa
  EkwTv9C1BOsCg1PbUiLTMHGN8waQkOHiURXq2vQGne4oLE3OLMdIjUKUZdjtN/ph9gFmLJy89
  LlRLnzQYpEgApyijNgxsBSzWXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzcoNM4cnMK4Hb
  9AroCCagIx4u4QY5oiQRISXVwJSw/Qe7jflGH9/Tqesmylb7FyhPujRVOGBFV++JM40payo36
  a2a9L3mfMI7k9mWz3obWd8vdQlrO94ZuzZWbjmjw4k99meSnLeeVWK/PHVRTqN+2rypL3erMJ
  dM0M1WyZ+ncNnDy67IcM05168fRI236Ty6Urvv6eIV87m1Fk98y7vmZH+Kvuc2JeUcjqlhp+6
  nnKkI5hCPTGmdGOhxNKF5y8W3wm6vxZc/3Nfq8adm/g/JW+e9GNYYsJ8JUfe6+st8boflwX3T
  zn+We7xOsMLNUHRNXghb9gvhyOiSmJWh4W3T3xV/ZRZVaHy8vlry1//rb792tZsvyz+TJFm73
  fD2grnSE15Em7J/ZD8nnavEUpyRaKjFXFScCABWUktGsAMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-23.tower-571.messagelabs.com!1661924942!503285!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1236 invoked from network); 31 Aug 2022 05:49:02 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-23.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Aug 2022 05:49:02 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 11F44142;
        Wed, 31 Aug 2022 06:49:02 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 05A3073;
        Wed, 31 Aug 2022 06:49:02 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 31 Aug 2022 06:48:57 +0100
Message-ID: <fa1fb86c-fd1c-d431-954b-98540299bf4a@fujitsu.com>
Date:   Wed, 31 Aug 2022 13:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc
 routines
Content-Language: en-US
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220805183523.32044-1-rpearsonhpe@gmail.com>
 <TYCPR01MB93059478A187A821F8F8469AA5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB93059478A187A821F8F8469AA5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

BTW: this patch should be for-rc instead.


On 22/08/2022 13:46, lizhijian@fujitsu.com wrote:
> Bob,
>
> Sorry for the late reply. Just back to office from a vacation :)
>
>> Move setting of pd in mr objects ahead of any possible errors so that it will
>> always be set in rxe_mr_complete() to avoid seg faults when rxe_put(mr_pd(mr))
>> is called.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Looks good to me
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
>

