Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3560F05C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 08:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ0Ge2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 02:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiJ0Ge1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 02:34:27 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AA1F38
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666852464; i=@fujitsu.com;
        bh=jIuunR9sj3rQKleKGeOla4NwN2YYG3zAOSAPcTKsnzU=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=aXtp2t/eXKGpGKQ+FO8A/Se7CkNF6zUNkY3a3/FFxUKiF1OxfSTS3MwZj+doUqa1M
         T85rOCseCDC0Qxmug4Yq2eUZkIpCLY0GE/z3HMBkWK479Cfi95V/6VQczaqf/9NJWC
         MmJ9RUD7CwZW76DaZ67YfaElynS1AEg/94DP9V7xDZ2k7jHZTz5CvoA6KXwA5gbqS4
         lTdGb3MdVHIV4KO4/Mkva6Wxq+rjOlQ3KISMo/FJtbG2KAGb/b8WtkMUJEZkx/F6+M
         gbpFpqAHrGJUCv0Ox+ZDRX3WMXvpil5803F1UX7JfeCQkOOhWlbaitHBj5gB43CAhW
         jd+iobF4pAbaQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsViZ8MxSTdfLSr
  Z4MFOE4uZM04wWkz5tZTZ4tmhXhYHZo9NqzrZPD5vkvPY+vk2SwBzFGtmXlJ+RQJrxpc5S1kL
  7rBV3Lr3jKWB8TJrFyMXh5DAFkaJ5WcusUE4y5kk1tw5xwzhbGOUWLnvM3sXIycHr4CdxI1J+
  5hAbBYBVYlru46zQsQFJU7OfMICYosKJElc3XAXKM7BISzgIbH/jw9IWASofOWCu2DlzAKxEv
  fXf2YDsYUEQiSeXtsE1som4Cgxb9ZGsDingJrE5JYzzBD1FhKL3xxkh7DlJba/nQMWlxBQlGh
  b8o8dwq6QmDWrjQnCVpO4em4T8wRGoVlIrpuFZNQsJKMWMDKvYjQrTi0qSy3SNTTUSyrKTM8o
  yU3MzNFLrNJN1Est1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAiMiZRihuk7GH8u+6N3i
  FGSg0lJlDeRKSpZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSvsjJQTrAoNT21Ii0zBxifMGkJDh
  4lEV59kDRvcUFibnFmOkTqFKMux9TZ//YzC7Hk5eelSonzLlAFKhIAKcoozYMbAUsVlxhlpYR
  5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ884GWcWTmVcCt+kV0BFMQEesmRsGckRJIkJKqoFJL0S+
  1vPIqrST19d2r9Z5x6n3LfLE4RU6k6bd3v//ndNab27vC7o/L7649UIgfMLqrIUeHifNrsiWX
  M1ONGr5d2SnznH7suVPxEL1Pj06rqXSt2j/0RkmaxcoSqUdjtgjuK1H6PCp5OrtKS5f1b5vYX
  v63GfPwd37niasu/Zer+uKfiBH0inlNZMfeMmdaLE6HF3R6vQpdP+BG1dj762peWjWbcZ45We
  tbvH2vqv9dzMmW1ycHBvxRejqGsYnG6+mxsx9mLC38bxojq9Wq8scN9MZX+/FxbOcnPTwj0bY
  nmWTS5rd6o8VJHQ0f73qfODnliPdy1+Iyatf+WFw+5XJvWuM9evFFjarh1w9+S2+/bgSS3FGo
  qEWc1FxIgBYujIxkAMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-8.tower-591.messagelabs.com!1666852463!495093!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9712 invoked from network); 27 Oct 2022 06:34:23 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-8.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2022 06:34:23 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 78F9F1000EE;
        Thu, 27 Oct 2022 07:34:23 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6B1B51000E9;
        Thu, 27 Oct 2022 07:34:23 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 27 Oct 2022 07:34:21 +0100
Message-ID: <f661cd24-b3e7-75c9-7358-1159205596fa@fujitsu.com>
Date:   Thu, 27 Oct 2022 14:34:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
References: <20221021134513.17730-1-yangx.jy@fujitsu.com>
 <Y1Z9oYf+nnY6B19L@unreal>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Y1Z9oYf+nnY6B19L@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/10/24 19:57, Leon Romanovsky wrote:
> On Fri, Oct 21, 2022 at 01:45:17PM +0000, yangx.jy@fujitsu.com wrote:
>> The member 'type' is included in both struct rxe_mr and struct ib_mr
>> so remove the duplicate one of struct rxe_mr.
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
>>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> Please fix you From field and resubmit.
> 
> 71d236399160 (HEAD -> build) RDMA/rxe: Remove the member 'type' of struct rxe_mr
> WARNING: From:/Signed-off-by: email name mismatch: 'From: "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>' != 'Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>'
> 
Hi Leon,

Thanks for your reminder. I will resend it shortly.

Best Regards,
Xiao Yang
> 
> Thanks
