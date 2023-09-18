Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11B47A40E5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 08:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbjIRGM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbjIRGMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 02:12:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9053D11A;
        Sun, 17 Sep 2023 23:12:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55BDC433C8;
        Mon, 18 Sep 2023 06:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695017557;
        bh=tlidCVK90ZbvQxpDKx3+A03UVl7rYVSMOdOwRtf7ues=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sc3Xjj2EIURwSWee/GbBsCNgUjwdxEZMwtvBv+HhcuItNn6AxYscsMdvS9uv1LC9x
         I2gQwGawVrO1gOg3OUne2Q/+6j3GrbTXEUwfNjQA/uhtkReDvNFMIS6b7G1uPdo6mW
         GLItXXcGqys+hSdugSLW8K6Aw5nGysQuyPycd4ssReQIl9/0TG4FskUFBaba833LPZ
         4ZoJ27kR+f5ELs/gGc1D1e9m3CqqqLJ8vDtec0mjXQiTes08DLLQd3IxiJYoE5fTVH
         R4A3+Pklgf3HghccSpndKFzYLPb4kCOzdRtzLSh3CnkrL+V8jzL3onsExgtVB644kT
         /ECXBjUgGJTng==
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <1eb400d5-d8a3-4a8e-b3da-c43c6c377f86@moroto.mountain>
References: <1eb400d5-d8a3-4a8e-b3da-c43c6c377f86@moroto.mountain>
Subject: Re: [PATCH] RDMA/erdma: Fix error code in erdma_create_scatter_mtt()
Message-Id: <169501755395.62733.5570197144363281019.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 09:12:33 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 06 Sep 2023 14:23:52 +0300, Dan Carpenter wrote:
> The erdma_create_scatter_mtt() function is supposed to return error
> pointers.  Returning NULL will lead to an Oops.
> 
> 

Applied, thanks!

[1/1] RDMA/erdma: Fix error code in erdma_create_scatter_mtt()
      https://git.kernel.org/rdma/rdma/c/6b5f0749ce48c1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
