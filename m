Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC2646BFB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 10:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLHJe2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 04:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHJe1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 04:34:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B159FFA
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 01:34:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECCC4B821EA
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 09:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3534CC433C1;
        Thu,  8 Dec 2022 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670492064;
        bh=ObSqnYschTJtUr6li/AqImcIrj61HKr2uRyfcTYMFGs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bPUhLdJMZbF/41Cp+GxmD5gzyf2wdgSms2igw/otNWgIFCqmHFbWu7BRV1nHeLWoy
         hj9f96tgEvX3NmYGTZilzv6BR8uqsAbIpEs1bJS+OocpyUjKYhU4I3lI5kehruLnFX
         ZX1B4BAP4N80flPJ+VdRbC5X4RzH8/N1Tx7qaC33C4WEoQrns4askl1g5yW0ptLMn3
         RdSdIcvRkjkLwuZdZ9t6qJt7H3oe+jM5BTl9KgKlG8llJoCeGZ47wTkcE8xzP5/wg1
         fuYvic/c4U0c3dV/6Xn1CEgppfdwGtc2BmbTonibyAeFjwIFroKGNpfphughJXgbC3
         PE29zMHLGpYPg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
In-Reply-To: <20221208101954.687960-1-yanjun.zhu@intel.com>
References: <20221208101954.687960-1-yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] RDMA/mlx5: Mlx5 does not support IB_FLOW_SPEC_IB
Message-Id: <167049206050.564613.5485954685929650545.b4-ty@kernel.org>
Date:   Thu, 08 Dec 2022 11:34:20 +0200
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

On Thu, 8 Dec 2022 05:19:54 -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> IB_FLOW_SPEC_IB is not supported in MLX5. As such, LAST_IB_FIELD need
> not be checked.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Mlx5 does not support IB_FLOW_SPEC_IB
      https://git.kernel.org/rdma/rdma/c/6cfe7bd0dfd330

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
