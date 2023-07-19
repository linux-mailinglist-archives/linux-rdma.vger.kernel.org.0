Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2757B759212
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGSJvx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSJvx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 05:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CBBEC;
        Wed, 19 Jul 2023 02:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022F861360;
        Wed, 19 Jul 2023 09:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9582FC433C7;
        Wed, 19 Jul 2023 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689760311;
        bh=vENifo+F/YJAiBdMljUMng/Va3f/ZD6dZZx8Kdp00A8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pE3gsvTAkEGDosLx/Zi2mApAW+pQRouOYcPDbsXwwM02ggyEejJiqAOHxWNxGTtvt
         iw4RmCH/GXsCBzhDoKnvUAdVHhcYJ4OTvCgKJujCSW9B4V4j95Iwl0n1roLkrz63v8
         JkoxjF63sZg5GCUutxoRW7Su+rnBoAcbTOF905FymL+Ipt1fMH/BP/sD0fCE18wHdj
         Nf1rB2aykt65unX8P/+qasN82wjZKJ5rv2QBfp1A607Uv36TUgNUxKZnjhXwiAw4zd
         JGUQQwQfpCIYF5QXGEBD+sYy5fEP8q+hw9+beew0lvci7fdao/imTAyYyAzfkHfB6L
         iyWnr7lKO2l9Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230705031849.2443-1-duminjie@vivo.com>
References: <20230705031849.2443-1-duminjie@vivo.com>
Subject: Re: [PATCH v1] drivers: hw: Remove duplicate assignments
Message-Id: <168976030702.1102365.6665424403788331605.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 12:51:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 05 Jul 2023 11:18:49 +0800, Minjie Du wrote:
> make iwqp->ietf_mem.va avoid double assignment.
> 
> 

Applied, thanks!

[1/1] drivers: hw: Remove duplicate assignments
      https://git.kernel.org/rdma/rdma/c/58259a2ec13d32

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
