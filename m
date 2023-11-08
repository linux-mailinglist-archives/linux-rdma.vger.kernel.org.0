Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E07E52C7
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjKHJnD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 04:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJnC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 04:43:02 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB24199;
        Wed,  8 Nov 2023 01:42:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvxlGB8_1699436575;
Received: from 30.221.147.99(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VvxlGB8_1699436575)
          by smtp.aliyun-inc.com;
          Wed, 08 Nov 2023 17:42:56 +0800
Message-ID: <2bc5d6b3-e349-1fc6-e354-9bad955eab20@linux.alibaba.com>
Date:   Wed, 8 Nov 2023 17:42:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: avoid data corruption caused by decline
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        wintera@linux.ibm.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699329376-17596-1-git-send-email-alibuda@linux.alibaba.com>
 <20231107183809.58859c8f@kernel.org>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231107183809.58859c8f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/8/23 10:38 AM, Jakub Kicinski wrote:
> On Tue,  7 Nov 2023 11:56:16 +0800 D. Wythe wrote:
>> This issue requires an immediate solution, since the protocol updates
>> involve a more long-term solution.
> Please provide an appropriate Fixes tag.

Thanks for reminder.

D. Wythe
