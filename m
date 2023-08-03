Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1F76F191
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Aug 2023 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHCSOe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHCSOd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 14:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570AE6B
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 11:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 278DC61E4A
        for <linux-rdma@vger.kernel.org>; Thu,  3 Aug 2023 18:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2737C433C7;
        Thu,  3 Aug 2023 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086471;
        bh=Y7ARXuusFB8Nd1TKw5q/f5b1VCw/JSExi5gO8fL5MIg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m1PDIl3tJCc4Da0XFfpF7YoTH2xaj5qjmvAMNiGZW3MkZtsh+GiNQks7GkyjFLR2V
         jwCX+7/xbxqQHRopfV8CLF3yFbt8ZOXcR8OTXHTrK+i5uOeHhQAWiWpolqbmy0WQlo
         JBrCIvMsgTkMNuyuZTbbbITQZY5tLk6/V1CgPcEHPcsPfjOCakVS8dxmoNvIHPPPGC
         R2dBDu6LEVXxJmudbypzliZoUNMPvCq3WtABucpqE4mtsO+OW8UYWHHYfV4Rt+JE0D
         EQtyrFb9zCKl7tWcVrzhb7eUHfnX39/0IuG10MvByaDUMF74GRA6o7sJuyqSj3O6/1
         Av9u9uSEwLiBg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Douglas Miller <doug.miller@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C169099756100=2E3927190=2E15284930454106475280=2Est?=
 =?utf-8?q?git=40awfm-02=2Ecornelisnetworks=2Ecom=3E?=
References: =?utf-8?q?=3C169099756100=2E3927190=2E15284930454106475280=2Estg?=
 =?utf-8?q?it=40awfm-02=2Ecornelisnetworks=2Ecom=3E?=
Subject: Re: [PATCH for-rc] IB/hfi1: Fix possible panic during hotplug remove
Message-Id: <169108646692.1410871.4675498166691983672.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 21:14:26 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 02 Aug 2023 13:32:41 -0400, Dennis Dalessandro wrote:
> During hotplug remove it is possible that the update counters work
> might be pending, and may run after memory has been freed.
> Cancel the update counters work before freeing memory.
> 
> 

Applied, thanks!

[1/1] IB/hfi1: Fix possible panic during hotplug remove
      https://git.kernel.org/rdma/rdma/c/4fdfaef71fced4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
