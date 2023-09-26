Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F017AEC28
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 14:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjIZMJP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 08:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZMJO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 08:09:14 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF89E6;
        Tue, 26 Sep 2023 05:09:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VswpDWa_1695730143;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VswpDWa_1695730143)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 20:09:04 +0800
Date:   Tue, 26 Sep 2023 20:09:03 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Alexandra Winter <wintera@linux.ibm.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20230926120903.GD92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230926104831.GJ1642130@unreal>
 <76a74084-a900-d559-1f63-deff84e5848a@linux.ibm.com>
 <20230926114104.GL1642130@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926114104.GL1642130@unreal>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 26, 2023 at 02:41:04PM +0300, Leon Romanovsky wrote:
>On Tue, Sep 26, 2023 at 01:14:04PM +0200, Alexandra Winter wrote:
>> 
>> 
>> On 26.09.23 12:48, Leon Romanovsky wrote:
>> > This patch made me wonder, why doesn't SMC use RDMA-CM like all other
>> > in-kernel ULPs which work over RDMA?
>> > 
>> > Thanks
>> 
>> The idea behind SMC is that it should look an feel to the applications
>> like TCP sockets. So for connection management it uses TCP over IP;
>> RDMA is just used for the data transfer.
>
>I think that it is not different from other ULPs. For example, RDS works
>over sockets and doesn't touch or reimplement GID management logic.

I think the difference is SMC socket need to be compatible with TCP
socket, so it need a tcp socket to fallback when something is not working.

If SMC works with rdmacm, it still need a fallback-to-tcp socket, and
the tcp connection has to be established for each SMC socket before the
SMC socket got established, that would make rdmacm meaningless.

Best regards,
Dust

>
>Thanks
