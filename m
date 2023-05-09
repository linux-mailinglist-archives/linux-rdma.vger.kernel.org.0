Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6282D6FC11A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 10:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjEIICA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 04:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjEIIBg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 04:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C7CAD21;
        Tue,  9 May 2023 01:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C7D644D5;
        Tue,  9 May 2023 07:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1ACC433D2;
        Tue,  9 May 2023 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683619156;
        bh=Ug8ROzQGSwAutbCDs2QKJ4IB4ZEVJihh3y21TtTDAo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+xgbhlEue63cYYBXu7r+yU/mCQPYj1J2puEF+3vcqGXeFOUMbi4s80qbcOwNHrwF
         +SxIRdluGzuCWFUTte4nYdDRlYPuhtb+xA3pHvKs1mPDRECRzDlw/Hq74EQLdS46pz
         qUH7A9x6TRH6rAw6wVGpHJ6uMmICF93TXWVtTR95WFp1QWULL0MT+WNILl7Oo8OZrG
         Wzk3EOUbg8V5V/sk5aZOaK6ruC3mz7CaV7FnWYrY633ArdNMHSQewmFf58C8/8j4gH
         ogIidxI9RnL/YkemoI++BsyEFygIaLKy8vMGTl8paU6Ks4IEs6ffxxva5p81x0cB+M
         2v0kwVO9RDXbg==
Date:   Tue, 9 May 2023 10:59:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "guoqing.jiang@linux.dev" <guoqing.jiang@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next v3 0/3] RDMA/rtrs: bugfix and cleanups
Message-ID: <20230509075911.GE38143@unreal>
References: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
 <4b85e9bc-e06c-c0c2-0945-c68a52ce16d6@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b85e9bc-e06c-c0c2-0945-c68a52ce16d6@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 09, 2023 at 01:20:09AM +0000, Zhijian Li (Fujitsu) wrote:
> ping

There is no need to ping, -rc1 was opened yesterday only.

Thanks
