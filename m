Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F87094A9
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjESKVC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 06:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjESKVB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 06:21:01 -0400
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41F01AD
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 03:20:59 -0700 (PDT)
Message-ID: <e13270a2-c149-6194-b283-06fc38efbd9b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684491657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2/x6o647fvkKRQ4lSsMEFjqh2VPCvaHWpW8KsvuUhc=;
        b=udnu0OVvT3ytoawjOfIe1810YEwd+/YchbDwaeS9LLPAfJdSgSv7Fl97genyHxEdc96kNe
        EalU2SNzYTM70jEQB16CBfoI2denCGZHl/8Vm3EAphdtIBbbAf8Hb6oYHlI/qQ3sUE4lvz
        g+ULGmlGlNDa2YB2/gt54yw/v2xjMF4=
Date:   Fri, 19 May 2023 18:20:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 0/7] On-Demand Paging on SoftRoCE
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <0f12adcd-0112-3b0e-57b5-ecf707670bc0@linux.dev>
 <TYCPR01MB8455648A5C9DFFB37FFB172FE57C9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <TYCPR01MB8455648A5C9DFFB37FFB172FE57C9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/19/23 17:57, Daisuke Matsuda (Fujitsu) wrote:
> On Fri, May 19, 2023 3:42 PM Guoqing Jiang wrote:
>> Hello,
>>
>> On 5/18/23 16:21, Daisuke Matsuda wrote:
>>> [2] [PATCH for-next v3 0/7] On-Demand Paging on SoftRoCE
>>> https://lore.kernel.org/lkml/cover.1671772917.git.matsuda-daisuke@fujitsu.com/
>> Quote from above link
>>
>> "There is a problem that data on DAX-enabled filesystem cannot be
>> duplicated with
>> software RAID or other hardware methods."
>>
>> Could you elaborate a bit more about the problem or any links about it?
>> Thank you.
> I am not an expert of Pmems, but my understanding is as follows:
>
> Pmem (Persistent memory) is detected as memory device during boot process.
> Physical addresses are allocated to them just like other memory in DIMM slots,
> so system have to treat them differently from traditional storage devices like HDD/SSD.
>
> It may be technically possible to duplicate data using multiple Pmems, but the duplication
> is practically not useful. For traditional storage devices, you can hot-remove and hot-add
> them easily on failure. However, Pmems are not attached to hot-pluggable slots. You have
> to halt the system and open the cabinet to change out the Pmem. This means availability
> of the system is not improved with data duplication on the same host.

I guess pmem with block translation table type would be fine since it 
can be used
like normal storage device, but I am not pmem expert as well 😁.

Thanks,
Guoqing
