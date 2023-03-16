Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05B26BD303
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Mar 2023 16:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCPPMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Mar 2023 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjCPPMa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Mar 2023 11:12:30 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 08:12:20 PDT
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [IPv6:2001:41d0:203:375::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A133C2DB2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Mar 2023 08:12:19 -0700 (PDT)
Message-ID: <d0cf93b8-427f-7f95-1863-a4c370919cd5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678979198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhmYnqbDlguzFkcJyLeSaFb+hInQe0N/n59cpU6Cl4o=;
        b=Cpa1HTGzMB7iHNRzu8Bo/OXzdjkqtKB5Algg7emEHrBhSPRufYDwP3Glt6+e9vwSNj/blp
        tTYWYQZXf4YhSONBoW6tX8g7ICNgcZVBq4l07KLoAgLarcDBviB0TJ2HGXejO1Jux7Z4R4
        TsTqFbRRu+U8ThsNedUbf5fxidhlvUo=
Date:   Thu, 16 Mar 2023 17:06:36 +0200
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
Subject: Re: [PATCH] RDMA/efa: Add data polling capability feature bit
To:     Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     sleybo@amazon.com, matua@amazon.com, ynachum@amazon.com,
        Yehuda Yitschak <yehuday@amazon.com>
References: <20230219081328.10419-1-mrgolin@amazon.com>
Content-Language: en-US
In-Reply-To: <20230219081328.10419-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/02/2023 10:13, Michael Margolin wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> Add feature bit to existing device caps field. EFA supports data polling
> of 128 bytes blocks.
> 
> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>

Acked-by: Gal Pressman <gal.pressman@linux.dev>
