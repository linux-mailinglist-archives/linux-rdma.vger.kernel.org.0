Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCBF63D0C5
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 09:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiK3Ifc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 03:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiK3IfE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 03:35:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C092A975
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 00:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37E36B8199E
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 08:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA45BC433C1;
        Wed, 30 Nov 2022 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669797234;
        bh=pC5lRW5tc9d+H3UpdaJmElv2stkge7QWZAtwitcmHGs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ScU0fk45Ldghz+VqHnRPuKMaGQ36cj8R5C8xbOsMBPYCqlCBkX6y1/kLaEiBcFFga
         qb6jLLaIc87t7o+QeAY/cxX9lifre0Fj7SUL/5/Z1QFQsakXzfLTIRmVYtsm7zcSxD
         ow/SfUgfQndclzN5RhfApCnDig9Rij/9jb2cAv9nunA43thm/upEuPLbU6bI9fnQvX
         xwC1AHAyU7JfDwdQT2mEnEjuUoZuWageGNwr5ajRLqswhFhvflRrY36EMJ6/ODzLiQ
         4L8998aV1d64jQXC9UWaAaOyZTggHGu4Ti/PjWJ19L4illpm4p+Q7ZNtggoNawli9z
         92ZiWFWvMIRNw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        linux-rdma@vger.kernel.org, Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <bd924da89d5b4f5291a4a01d9b5ae47c0a9b6a3f.1669636336.git.leonro@nvidia.com>
References: <bd924da89d5b4f5291a4a01d9b5ae47c0a9b6a3f.1669636336.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/nldev: Add NULL check to silence false warnings
Message-Id: <166979722984.13532.14005160348325182533.b4-ty@kernel.org>
Date:   Wed, 30 Nov 2022 10:33:49 +0200
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

On Mon, 28 Nov 2022 13:52:45 +0200, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> Using nlmsg_put causes static analysis tools to many
> false positives of not checking the return value of nlmsg_put.
> 
> In all uses in nldev.c, payload parameter is 0 so NULL will never
> be returned. So let's add useless checks to silence the warnings.
> 
> [...]

Applied, thanks!

[1/2] RDMA/nldev: Add NULL check to silence false warnings
      https://git.kernel.org/rdma/rdma/c/67e6272d53386f
[2/2] RDMA/nldev: Fix failure to send large messages
      https://git.kernel.org/rdma/rdma/c/fc8f93ad3e5485

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
