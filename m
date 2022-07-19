Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9208057A366
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiGSPoO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiGSPoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 11:44:12 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5A6352E55
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 08:44:11 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id DpH2oh7Z2sKAkDpH2oqpnh; Tue, 19 Jul 2022 17:36:39 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 19 Jul 2022 17:36:39 +0200
X-ME-IP: 90.11.190.129
Message-ID: <7075158a-64c1-8f69-7de1-9a60ee914f05@wanadoo.fr>
Date:   Tue, 19 Jul 2022 17:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kai Shen <kaishen@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
 <20220712090110.GL2338@kadam> <20220719125434.GG5049@ziepe.ca>
 <20220719130125.GB2316@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220719130125.GB2316@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 19/07/2022 à 15:01, Dan Carpenter a écrit :
> On Tue, Jul 19, 2022 at 09:54:34AM -0300, Jason Gunthorpe wrote:
>> On Tue, Jul 12, 2022 at 12:01:10PM +0300, Dan Carpenter wrote:
>>
>>> Best not to use any auto-formatting tools.  They are all bad.
>>
>> Have you tried clang-format? I wouldn't call it bad..
> 
> I prefered Christophe's formatting to clang's.  ;)
> 
> regards,
> dan carpenter
> 
> 

Hi,

checkpatch.pl only gives hints and should not blindly be taken as THE 
reference, but:

   ./scripts/checkpatch.pl -f --strict 
drivers/infiniband/hw/erdma/erdma_cmdq.c

gives:
   CHECK: Lines should not end with a '('
   #81: FILE: drivers/infiniband/hw/erdma/erdma_cmdq.c:81:
   +	cmdq->comp_wait_bitmap = devm_bitmap_zalloc(

   total: 0 errors, 0 warnings, 1 checks, 493 lines checked

(some other files in the same directory also have some checkpatch 
warning/error)



Don't know if it may be an issue for maintainers.

CJ
