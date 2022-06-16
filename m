Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8554DDF1
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359040AbiFPJLT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 05:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376594AbiFPJLR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 05:11:17 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA2554A9
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 02:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=poSN8FThgOmJc3It1MVHGjnd7JjmLzxxYSTypqcTtaI=; b=RwtPA7d2T4/nEoyrhitv2PMG5Z
        D20/j4dLQ1tatOb1wO/RktYo8LA0z0SSZPOkW4tsORc2JnhnCEq4V9semX0DR5NUyieYnx9WE/da9
        0t/L7V9JLYVwb2bVCaJjVkuGkF/ko4om8oSbv9mpFtmHVrB06zFlZLbhiYyKsU6J/NTwx52U5HGIz
        SwHQiTSR4Gc7hBWvzW7+/bdASc7OBVitpkaudSdiSfP6kmOb0Ygjy0VLUJg5+1m2OlL7U/7b1XBOW
        2jHu+PEv6mwZQeW/xC1BYS0f+5PQNC1zjz5oETZFJ2Bmc9yVcmYj7GQdvyGLfw8symnzC9FS4jWQ1
        DgeBUNEV07xtDL9ST5ByWe1WXgvnycDopIE8fBVxMVcS2HheKnOGY/4PKk3kxy+r10265fLplXJgs
        hSlSqbQrtoE6y4cbKfI4eVP9frl5qTm/cekbIFxxCfUH7bwkKTg/luMXs/UCGDEGSt5n6mQFXnWD1
        9kSbo9OT4TEWQ7Elu4TcsUtG;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1lWz-0005X9-GO; Thu, 16 Jun 2022 09:11:13 +0000
Message-ID: <ad1bb1ae-39ae-a728-07d6-2d996292d240@samba.org>
Date:   Thu, 16 Jun 2022 11:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next v11 08/11] RDMA/erdma: Add connection management
 (CM) support
Content-Language: en-US
To:     Cheng Xu <chengyou@linux.alibaba.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com, BMT@zurich.ibm.com,
        dan.carpenter@oracle.com, Bernard Metzler <BMT@zurich.ibm.com>
References: <20220615015227.65686-1-chengyou@linux.alibaba.com>
 <20220615015227.65686-9-chengyou@linux.alibaba.com>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20220615015227.65686-9-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Am 15.06.22 um 03:52 schrieb Cheng Xu:
> ERDMA's transport protocol is iWarp, so the driver must support CM
> interface. In CM part, we use the same way as SoftiWarp: using kernel
> socket to set up the connection, then performing MPA negotiation in
> kernel. So, this part of code mainly comes from SoftiWarp, base on it,
> we add some more features, such as non-blocking iw_connect implementation.

It would be great to have common parts to be unified in the long run
otherwise fixes are only applied to one version.

metze
