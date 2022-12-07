Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0964560D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLGJI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 04:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLGJIZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 04:08:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E27DF47;
        Wed,  7 Dec 2022 01:08:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6638AB81B93;
        Wed,  7 Dec 2022 09:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4260C433C1;
        Wed,  7 Dec 2022 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670404100;
        bh=l3Fy7l4PaPataLrwAEdkLE+y3KJgvPKF6NwZXOQZYW4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o9UOxYYAZ+vwIc2FBXalSEObR0fGHixK2IHNbHXHFoJv4FkES0abhUo3Hx42bmfTB
         1RcbDbdpzByx0NAO7k41Zz6jZV+aUgpI0J/ROYjOARCiOA0T48ytFybylrgNOFLyLt
         OS5NVIJI7tGKDPVwyqK+ZE/oTHcVNIwhomKpNK2iGt1E9v0ppk8pEkwzxXZb7vLa2O
         FJ5XB/8pnUnqkz3lmBeyxEjqV54KDc0Q62qHbL7kg8mpoqoYm1ZWo5FlS7+th4XkiH
         4kJ8ciGSMsJUQJKbdbHMCIXIFhaWourniHpdhus8QBKBdG2dFvqATh1GbxtnTEpW1E
         ygYniSDhxw6+A==
From:   Leon Romanovsky <leon@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca, dennis.dalessandro@cornelisnetworks.com
In-Reply-To: <202212071632188074249@zte.com.cn>
References: <202212071632188074249@zte.com.cn>
Subject: Re: [PATCH] RDMA/hfi1: use sysfs_emit() to instead of scnprintf()
Message-Id: <167040409627.420496.10658092656332497802.b4-ty@kernel.org>
Date:   Wed, 07 Dec 2022 11:08:16 +0200
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

On Wed, 7 Dec 2022 16:32:18 +0800 (CST), ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/hfi1: use sysfs_emit() to instead of scnprintf()
      https://git.kernel.org/rdma/rdma/c/d074f0aebde564

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
