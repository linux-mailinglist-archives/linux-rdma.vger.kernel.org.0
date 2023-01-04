Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529B865CD75
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 08:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjADHCh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 02:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjADHCg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 02:02:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F511A15
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 23:02:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 292B1CE1408
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 07:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC9FC433EF;
        Wed,  4 Jan 2023 07:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672815750;
        bh=6t5l4WRQvwpLUy+KgInkg+M8JV5UN2E1mzlZYvgBmBs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cDcvR3lZ+mXM4966SwfwjmYKDfWxO2cE3+SswP/gnHna5+0dBnN+fwHHYCfdgJWCb
         KnUVrnJzhd+VVxcM6zvmBo5RxKBAc3GEwq7IztYaYHicdC/vS1dg2ENHYAm08sXTLk
         jPFOGpxR6opzOeZ551WoQYVuhlCKtX/Lk4thnVPX9i9CYsmlj4tzNZQjmGGLqt52Nu
         0ZF2ioIZYAUJe54UmM1+gMNZAFbPY8G19NDkKPjAeHyqkuEEQ0QSKgaaXg2sB7PLp7
         6a7x7ACD3wOXxmNVFaukeaW9J6jKCznpmxtaZWxbr4Uh/oQ6q3PW/xqTrvNnDrRn12
         Io6i/uOBghSWw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230104064333.660344-1-yanjun.zhu@intel.com>
References: <20230104064333.660344-1-yanjun.zhu@intel.com>
Subject: Re: [PATCH for-next 1/1] RDMA/irdma: One variable err is enough
Message-Id: <167281574575.996455.15315471805029120621.b4-ty@kernel.org>
Date:   Wed, 04 Jan 2023 09:02:25 +0200
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

On Wed, 4 Jan 2023 01:43:33 -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the function irdma_reg_user_mr, err and ret exist. Actually,
> one variable err is enough.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: One variable err is enough
      https://git.kernel.org/rdma/rdma/c/bd99ede8ef2dc0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
