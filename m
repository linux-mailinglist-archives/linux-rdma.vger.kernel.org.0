Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67A162D61C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbiKQJMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 04:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiKQJMt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 04:12:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F35A6EC
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 01:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09DED6212B
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 09:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9137C433C1;
        Thu, 17 Nov 2022 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668676367;
        bh=P7MxYZl5a6WaahBiEOUtyPc7RhAn77l7vmIS6Tgcvjw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bhj3NSLYikcSFu5m7BnRripzerqjzdMvk2jb/SvleSIkPlgmxs0gA8xZAP15NpzSx
         XnrR8OIovTkHnPFYbxYpQV8nT+TlFOZUuBUhYI/pi4IT0LbLMGoJDu6hQjwfHH3EX/
         oSPcZs9iyyjP3ZBlQo3v84U/Wookd3HKlXX8XbA3XjKsSu2Rmsah6q4cE9Ng/XxISE
         U0YHluJP0sQYcMI8eSQVEtlgN5+XpvZfz/TLWP7sSXudwAvWjptEZc+6JjC1tm/q4J
         FVbNTIopqjarb1BNhE+Eksm5+tq1whqqRDCP/ywzA8MK3OCh4rXN8JhZJdOueHmzZy
         bbAdrcTvUROAA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20221115011701.1379-1-shiraz.saleem@intel.com>
References: <20221115011701.1379-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH v2 for-next 0/3] irdma for-next updates 11-1-2022
Message-Id: <166867636174.514131.12539452999112801387.b4-ty@kernel.org>
Date:   Thu, 17 Nov 2022 11:12:41 +0200
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

On Mon, 14 Nov 2022 19:16:58 -0600, Shiraz Saleem wrote:
> This series adds inline support when multiple SGE's are used
> as well fixes for WC RQ completion opcodes and to not use level 2
> PBLEs for virtual CQs.
> 
> v0-->v1:
> -Fix 0-day warnings in Patch #2
> 
> [...]

Applied, thanks!

[1/3] RDMA/irdma: Fix inline for multiple SGE's
      https://git.kernel.org/rdma/rdma/c/4f44e519b6a945
[2/3] RDMA/irdma: Fix RQ completion opcode
      https://git.kernel.org/rdma/rdma/c/24419777e94311
[3/3] RDMA/irdma: Do not request 2-level PBLEs for CQ alloc
      https://git.kernel.org/rdma/rdma/c/8f7e2daa6336f9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
