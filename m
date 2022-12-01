Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA763F276
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiLAOQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLAOQf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:16:35 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7A8BD8BD
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669904187; i=@fujitsu.com;
        bh=iHsk0O7DS71upT3abbg1gshvh3BG3T25EE5CdHn41YU=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=jojKOtLBOEBtYU1+hJ+vxscvZ77XnuWRKp2Xi7Qv4O6sLr2cmf0UoFUN+O9JtrRm/
         LYVGaClb2UxO2pFQmglHWhe0YCxGyYVHp9fa76VDLc+1z1a3lGlVC0JyXcmXOzhizk
         BSW26gbEZjk+kfMVstIcpiOCemH33hwU8XkDfLNF58+bLnWJQ79ptfuKDUHVtV+IXD
         1L0iI/S9HofWvr8ifhQW0K8tvWHNHd57ZiQzuUwbZkf8F3af7zfObN4ffUwfcxq99P
         o5MGVVBTDUdpjIV20Z3HXlQo7MDIg01rb3IiLWjmt9wMg/A00oXDuPQ1CAF3xNkJns
         PQ8jc05aLFk+g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleJIrShJLcpLzFFi42Kxs+HYrGu1vSP
  Z4OZ0U4sr//YwWkz5tZTZ4tmhXhaLL1OnMVucP9bP7sDqsXPWXXaPTas62Tx6m9+xeXzeJBfA
  EsWamZeUX5HAmrF13h+Wgl62ij/bxBsYn7N0MXJxCAlsZJR4cnEFK4SzhEni2quJTBDOVkaJU
  0c2sncxcnLwCthJXO1vBLNZBFQkmlZdhooLSpyc+YQFxBYVSJK4uuEuK4gtLOAgceHdQrC4CF
  D9iRNn2EGGMgssYpJYcHQHM8SG1YwSc5qWMINUsQmoSeyc/hKsg1NAS2LW/7dgcWYBC4nFbw6
  yQ9jyEtvfzgGLSwgoSrQt+ccOYVdIzJrVxgRhq0lcPbeJeQKj0CwkB85CMmoWklELGJlXMZoW
  pxaVpRbpmuglFWWmZ5TkJmbm6CVW6SbqpZbqlqcWl+ga6SWWF+ulFhfrFVfmJuek6OWllmxiB
  MZMSrGq5w7GP0v/6B1ilORgUhLlre7sSBbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwXt0E1BOsC
  g1PbUiLTMHGL8waQkOHiURXt71QGne4oLE3OLMdIjUKUZdjqmz/+1nFmLJy89LlRLnPb8VqEg
  ApCijNA9uBCyVXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzPtkM9AUnsy8ErhNr4COYAI6
  IlKsDeSIkkSElFQDU2P3h7Mnf/iz/FOcaNIovVKG13oNb8WqaesPJC6xWsPFU7haVMVr/vUNU
  9iMROQCJy42Nd1a8+VRAMf9yTZPVN7+FHrUuzs1+0fi1M1/nAMYi8ylt511uaOh4iJ6auL+wm
  mvf9zY9ezhmcYfcodsdaSOGGhKmjMtXp5388d6nQ+6nAG/FTpEHy4uss2XXLnh3QbBQ/M+G+g
  ydDy7/6Tj8sSfF0qq/1uonsuQl51RWaGgd1XmQfSmpmVWXJUHr22yOR/mvNAksCfu1fRLNwvO
  HFUx33/cyLLPvlhI+uDfbU+6vR5/rJ8nJ7x96/UvJ46/frduTdmzeQVpr08lTP8sfnHxCYOtq
  9K6/m5WqE+dvWCVEktxRqKhFnNRcSIAKPgDcqADAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-3.tower-565.messagelabs.com!1669904186!229563!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14175 invoked from network); 1 Dec 2022 14:16:26 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-3.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:16:26 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 8E88515B;
        Thu,  1 Dec 2022 14:16:26 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 81B22159;
        Thu,  1 Dec 2022 14:16:26 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:16:23 +0000
Message-ID: <5fa61fdf-b161-7699-c551-164be118d80c@fujitsu.com>
Date:   Thu, 1 Dec 2022 22:16:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
 <Y30o/2LDLO5bw+tA@nvidia.com>
 <c10c62d4-fee9-4824-1383-8c6cdcf1c71c@fujitsu.com>
 <Y4ik9iEfvMNefraR@nvidia.com>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <Y4ik9iEfvMNefraR@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/12/1 20:58, Jason Gunthorpe wrote:
> It is not really "empty line" it is that the last character in the
> file should be '\n', and all files are like that.
Hi Jason,

Thanks for your explanation.

I think my latest patch has added an "empty line", right?
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 6a875fdd..c78a2284 100644
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
...
@@ -507,4 +510,4 @@ cdef extern from "<infiniband/tm_types.h>":
          IBV_TMH_NO_TAG
          IBV_TMH_RNDV
          IBV_TMH_FIN
-        IBV_TMH_EAGER
\ No newline at end of file
+        IBV_TMH_EAGER

# cat -A pyverbs/libibverbs_enums.pxd | tail -2
         IBV_TMH_FIN$
         IBV_TMH_EAGER$

Best Regards,
Xiao Yang
> 
> Jason
