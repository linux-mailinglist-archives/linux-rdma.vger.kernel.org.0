Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260D65A7884
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiHaIGy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 04:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHaIGx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 04:06:53 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD571F4C
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661933210; i=@fujitsu.com;
        bh=K5aKl+9mET3NT1Arxdxb9mwetRz6ruMH7qoIwL71WDA=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=vAYmPzgjhCdGO8aacp1Pspdkzv/IWaszuOpi50EVIac9iQNLJigPozK0M082nfn/8
         0PrHd+2p6lMQCYDzN9aYTT4Np4hAj5Q/hux54v3M7rRwONh81cPIRGYRSdJjNDBPcl
         709gRYcLPC9PmQI1+DySFt3xCYbDQhNimKAq7Z6+MOCy7RTVo6oxQd2X8AXomT77+L
         A/FD7G1mn1lF+MA2fo4bhlhkUN0iT/3+HHnNoxmXw22fAsfS+MKvsvBtR17oMNPX7M
         mScQBEeeGtDB8k/dF6a0bzfjPiO/Hml/uUTDJQX/+BfZWIRGmBh8pavK/NT5nN8SJW
         a8wwKKYvzxXmA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRWlGSWpSXmKPExsViZ8ORpDtTjD/
  ZoGe2nsWVf3sYLVoWXWGzmPJrKbPFs0O9LBZfpk5jtjh/rJ/dgc1j56y77B67djWye2xa1cnm
  0dv8js3j8ya5ANYo1sy8pPyKBNaM2Ve+sRQ8ZKn4vWAqewPjb+YuRi4OIYGNjBItW3awQjhLm
  SQeL5jHBuFsZ5TYe6SXsYuRk4NXwE5iZvM3ZhCbRUBVYvmTp2wQcUGJkzOfsIDYogIREg8fTQ
  KzhQUCJfatvM0EYjMLiEvcejIfzBYB6l254C7YNmaB64wSnV/mQN1xi1Hi4NTnrCBVbAIaEvd
  aboJt5hRQkzi5eg8rxCQLicVvDrJD2PIS29/OAbtIQkBR4kjnXxYIu1Ki9cMvKFtN4uq5TcwT
  GIVnITl2FpKjZiEZOwvJ2AWMLKsYrZKKMtMzSnITM3N0DQ0MdA0NTXWNdQ0tLfUSq3QT9VJLd
  ctTi0t0DfUSy4v1UouL9Yorc5NzUvTyUks2MQJjMKWY+fgOxil9P/UOMUpyMCmJ8tZy8ycL8S
  Xlp1RmJBZnxBeV5qQWH2KU4eBQkuDtEAHKCRalpqdWpGXmANMBTFqCg0dJhDdQFCjNW1yQmFu
  cmQ6ROsWoKCXOqweSEABJZJTmwbXBUtAlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK870Gm
  8GTmlcBNfwW0mAlo8cMl3CCLSxIRUlINTFmnvhWfn/clRXTdw6eRfFd+uu+MqzSZtjWWdemO2
  wLCN3Zeal7SnHLF+qD/rA+FLFvqPZ3uMn/6f7/BJWvV4vdmD+as6FX9brd/4XnhdV8kBRYc8T
  586IVdDPvxHdGHLUQOz1qtZHggorNvdbHPt4pVSZZ6Fjv/xssUHvnUEx65XWPOzVirQp3cIy8
  vxd/ZzBHy+tUuK6POFVluAdteCU9aUe20U1e/8CmPXuARvqLCjMDZsw0zW4R5DhUHZPPnd8VI
  rRWc1hj4bILyyR/C9TXP3h9f9cLX7/ypeGfBi1Pb+JLXrZdc0aR/a+oMA9HzK+5IJvAH3mWfu
  2FySZJd2f5t7LKqOx/HVVpm/8veGKnEUpyRaKjFXFScCADspeZkvAMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-7.tower-587.messagelabs.com!1661933209!524582!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24168 invoked from network); 31 Aug 2022 08:06:49 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-7.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Aug 2022 08:06:49 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 59B261AC;
        Wed, 31 Aug 2022 09:06:49 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 4DB9F1AB;
        Wed, 31 Aug 2022 09:06:49 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 31 Aug 2022 09:06:46 +0100
Message-ID: <2124b2b6-8fd9-64a3-5c66-3e7ef7565606@fujitsu.com>
Date:   Wed, 31 Aug 2022 16:05:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc
 routines
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220805183523.32044-1-rpearsonhpe@gmail.com>
 <TYCPR01MB93059478A187A821F8F8469AA5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
 <fa1fb86c-fd1c-d431-954b-98540299bf4a@fujitsu.com> <Yw7/KilXI8l+1/uA@unreal>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <Yw7/KilXI8l+1/uA@unreal>
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

Leon,


On 31/08/2022 14:26, Leon Romanovsky wrote:
> On Wed, Aug 31, 2022 at 01:48:08PM +0800, Li Zhijian wrote:
>> BTW: this patch should be for-rc instead.
> It can't be in -rc without Fixes line and more clear description.

Fixes: cf40367961d8 ("RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()") ?

IIRC, This patch fixes a kernel crash newly introduced by v6.0 merge window
it's an alternative for my former patch: https://lore.kernel.org/all/42ec06bb-9e97-3b43-5fb9-9801407d301e@fujitsu.com/
So if you agree it should go to for-rc, does Bob need to repost a new one with more details ?


>
> Thanks

