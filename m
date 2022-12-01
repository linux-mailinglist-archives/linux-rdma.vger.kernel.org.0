Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11A63EC03
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 10:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiLAJKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAJKY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 04:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE2E5DB82;
        Thu,  1 Dec 2022 01:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14470B81E65;
        Thu,  1 Dec 2022 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331DFC433D6;
        Thu,  1 Dec 2022 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669885820;
        bh=B4rSBBn+9jnyDFWA3h9tdw7f7e5sffBAfT1JE8gR29k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bbug4YKhfGPHOQn/6C9j/vx7Tc4DLK/cnBo3bzUFK8KLhcK2nJjsPyDS6RF4Mw7xq
         EdtjUVO9YmF7cVgJIz19YESD7PUJ3WgCQEFi6qwwoQF4X9fHfAQX0J857nbkHBXVgv
         Iyr/lDd1kA3f3aIo+UYTYhWvzJCdC07WTFahUKBXCv0TRBtd0lZFL6y/wXtZkqBCre
         wiHXyQKw5Uptni0YTZWDdCcNwGUCc+xy+seLuGoEz0OP0YLk34gc5QdjDjQ1ZlwBlD
         G71NNKJE+bdZmHWgffPw3gAMt0oDXRRMgUA07ifP515qkXFoBeVej7l7qsCTJOSjPQ
         2puXiD58+Q+jQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     yang.yang29@zte.com.cn, jgg@ziepe.ca,
        dennis.dalessandro@cornelisnetworks.com
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <202211301744378304494@zte.com.cn>
References: <202211301744378304494@zte.com.cn>
Subject: Re: [PATCH] IB/hfi1: switch to netif_napi_add()
Message-Id: <166988581627.44464.17864367397107451165.b4-ty@kernel.org>
Date:   Thu, 01 Dec 2022 11:10:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 30 Nov 2022 17:44:37 +0800 (CST), yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> There is no need to use netif_napi_add_weight() when the weight argument
> is 64. See "net: drop the weight argument from netif_napi_add".
> 
> 

Applied, thanks!

[1/1] IB/hfi1: switch to netif_napi_add()
      https://git.kernel.org/rdma/rdma/c/10aa7cd398a9ea

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
