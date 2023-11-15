Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E17EC51C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbjKOO0W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 09:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjKOO0V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 09:26:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ACCE7;
        Wed, 15 Nov 2023 06:26:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E9BC433C7;
        Wed, 15 Nov 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700058377;
        bh=i+fNJ/Tm8f6CULGHTu6mifl+Pse6PCwH1Lncgf+r01E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K03ScaPQTlBNPfR4SG8Sm3QxReki9UYIIGvktDSa/PZYwu8CgAeyUAiE9J4MOmisL
         eaxdG6Z8xZ2pdt786M5/wKLSx8UhKomJ04oScNHjo1xuWdBY1RIFWAP1pq47A1Gcx+
         Qvtid6EJRXDXJuSDrl+xfWbkMR0zdmNKNQwrb1UA9lCKHRlgCpAum/l7bcy8FqavD5
         YS05LNTH1fWkb6rHcx2+u2PX5uNejd/PjgK4iSSRik+wXf1hxHsxSLlfAoMVsVe/JR
         HC13u0quLTDV2qeiJnfs+2gFTvtyLpIxD+U4l+s24A6oi7LZGroxP+5CJkCDfs78PC
         pMGgW/6GtvN6w==
Date:   Wed, 15 Nov 2023 16:26:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 3/3] RDMA/hns: Support SW stats with debugfs
Message-ID: <20231115142613.GD51912@unreal>
References: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
 <20231114123449.1106162-4-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114123449.1106162-4-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 14, 2023 at 08:34:49PM +0800, Junxian Huang wrote:
> Support SW stats with debugfs.
> 
> Query output:
> $ cat /sys/kernel/debug/hns_roce/hns_0/sw_stat/sw_stat
> aeqe                 --- 3341
> ceqe                 --- 0
> cmds                 --- 6764
> cmds_err             --- 0
> posted_mbx           --- 3344
> polled_mbx           --- 3
> mbx_event            --- 3341
> qp_create_err        --- 0
> qp_modify_err        --- 0
> cq_create_err        --- 0
> cq_modify_err        --- 0
> srq_create_err       --- 0
> srq_modify_err       --- 0
> xrcd_alloc_err       --- 0
> mr_reg_err           --- 0
> mr_rereg_err         --- 0
> ah_create_err        --- 0
> mmap_err             --- 0
> uctx_alloc_err       --- 0

From one side, 
Everything will be much easier if you use one file == one value. It will
remove the need in seq_* calls. Your "cat ../sw_stat" is not atomic and
doesn't present snapshot anyway.

From another,
It is debugfs and it is upto you.

Let's wait a couple of days more and if no one complains, I'll apply it as is.

Thanks
