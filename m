Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959397591FA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGSJsw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGSJst (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 05:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666F1FD8;
        Wed, 19 Jul 2023 02:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1420361360;
        Wed, 19 Jul 2023 09:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31B7C433C7;
        Wed, 19 Jul 2023 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689760114;
        bh=pB3m7C2ISyNuQSWXIsz415DWWQwj/DbO9R2twS/7/K4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QGlnIA/1cy/m27vC456OqU4aXMq40WwChuyVhdAQJJvxDW4vytdDdE/eRHVieXebN
         vfWbMI+8GeoqQdWFUMKFswtnrpmllqh1lFW9HhuibFrNTn+fQiCLyujnZNJX3KHVsX
         GPWr3n4dCj/yvMCn7ayuufKbXTqw/8LbBJXwxG8LXwKD+5/yFD902HJF0+mHwtra06
         FeDB+/SizOTKMOlswuovZhVcwAffXNFuTbX4KEly10qsxmcfazt3tUS80Tbjo20fqU
         rq+JaeSmQv2MZL/PZw19O1U7GcakLyyQpPsXaOxj/oh6u/pHi2H7XrJ31RGd0KKukl
         qZifHocaidVPQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Markus.Elfring@web.de, Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230705103950.15225-1-duminjie@vivo.com>
References: <20230705103950.15225-1-duminjie@vivo.com>
Subject: Re: [PATCH v2] RDMA/qedr: Remove a duplicate assignment in
 qedr_create_gsi_qp()
Message-Id: <168976011020.1099718.7601409753250892373.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 12:48:30 +0300
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


On Wed, 05 Jul 2023 18:39:50 +0800, Minjie Du wrote:
> Delete a duplicate statement from this function implementation.
> 
> 

Applied, thanks!

[1/1] RDMA/qedr: Remove a duplicate assignment in qedr_create_gsi_qp()
      https://git.kernel.org/rdma/rdma/c/296609e6b64cd1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
