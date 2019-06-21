Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D24EF9B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 21:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFUTrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 15:47:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34436 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUTrm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 15:47:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so8183650qtu.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s+bkxi6ZYtom963UsLURVNVuKt4FdWJ/wDrh5jBIE1k=;
        b=L2Wv4jb/KDBQdHZkToKxkVyEYWJVxtmIsZNoPCze1ubWN6UXNlFrrSusBD4O1U9Dn6
         VTg48dW9bnDGypSTtoPi7zmJJTLy6fcdjd5Fd9sMT+Q5lr61a3UJTeHP4gW2cmvC08cB
         rUyotXZlYOzjgp7roM/UwyhYAQz2zZriaTekMbj3bXfBxN1MmqPmH1CgG7CaStTTJuO6
         ePVBPp3nFqrZ3CCMD/kGLlqGRP4arCrrMoS7GkwgQ+GjjkIbLel40ZjoStX4sNOKTl0N
         tN3t0wGYrBGkyNAs+J8KA7zYAk6fgUT8joCsl24lwXxOJ9yKAgHowWTsJgbgrOtuiHY7
         xlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s+bkxi6ZYtom963UsLURVNVuKt4FdWJ/wDrh5jBIE1k=;
        b=TYlPGeXZMKXQbPsElDDwPM+xAKpJCw7FC9TxiRR53d4RLg3ShnZK+1LN0E/XxgI7bi
         7s1f61HsnbJPYxqlWXAMlDJKp+RVLT2WGncTXeD+WZ+fh1qWEztG++oGn4UHPTffTMN5
         HJyYghsak7sF4kAhS27fypdLbtmJefgtOzSq9PNRJt2Bmi7BOZAoP/slGuz6PBqTfnPu
         aKBFcPjSWtkilj+z2R1IAxnNBI+eSQDKBMS4YClEMiUs72BKEoDhNA45iUYtouG8xdIn
         KeYXkIRe6iAvPLwnK0VKQSdxqS2GNLS0sE01h+KvwIgzzc8hVzipBOCefRvWIOcGG0bY
         JtrQ==
X-Gm-Message-State: APjAAAXTMtp6mjkWuN32IIqg79P9aYpqbS8+nJ+MQwGOQRwHpb+JVA4N
        qrW2u2nklNpzVeZY/Ds+w/C5hw==
X-Google-Smtp-Source: APXvYqyDtLtbGuh1q7CyS9wpeipZqt2gepZVJ5+7e5a1FuSp/CF9OXPpzh/UlnqnIacMwZ79HNCa1g==
X-Received: by 2002:ac8:7349:: with SMTP id q9mr114851249qtp.151.1561146461111;
        Fri, 21 Jun 2019 12:47:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e125sm1952078qkd.120.2019.06.21.12.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 12:47:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hePVc-0007y3-6z; Fri, 21 Jun 2019 16:47:40 -0300
Date:   Fri, 21 Jun 2019 16:47:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        dledford@redhat.com, hch@lst.de, bvanassche@acm.org,
        israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 00/21 V6] Introduce new API for T10-PI offload
Message-ID: <20190621194740.GA30600@ziepe.ca>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 06:52:36PM +0300, Max Gurtovoy wrote:
> Hello Sagi, Christoph, Keith, Jason, Doug, Leon and Co
> 
> This patchset adds a new verbs API for T10-PI offload and
> implementation for iSER initiator and iSER target (NVMe-oF/RDMA host side
> was completed and will be sent on a different patchset).
> This set starts with a few preparation commits to the RDMA/core layer.
> It continues with introducing a new MR type IB_MR_TYPE_INTEGRITY.
> Using this MR all the needed mappings will be done in the low level drivers
> and not be visible to the ULP. Later patches implement the needed functionality
> in the mlx5 layer. As suggested by Sagi, in the new API, the mlx5 driver
> will allocate a single internal memory region for the UMR operation to
> register both PI and data SG lists and it will look like:
> 
>     data start  meta start
>     |           |
>     |d1|d2|d3|d4|m1|m2|m3|m4|
> 
> The sig_mr stride block would be using the same lkey but different
> offsets in it (offset 0 and offset d1+d2+d3+d4). The verbs layer will
> use a special mr type that will describe everything and will replace
> the old API, that enforce using 3 different memory regions (data_mr,
> protection_mr, sig_mr) and their local invalidations. This will ease
> the code in the ULP and will improve the abstraction of the HW (see
> iSER code changes). 
> The patchset contains also iSER initator and target patches that using
> this new API.
> 
> For iSER, the code was tested vs. LIO iSER target using Mellanox's
> ConnectX-4/ConnectX-5.
> 
> This series applies cleanly on top of kernel 5.2.0-rc4 tag plus patchest
> "[PATCH 0/7] iser/isert/rw-api cleanups" that was applied to for-next (Jason).
> We should aim to push this code during 5.3 merge window.
> 
> Next steps are:
>  - merge NVMe-oF/RDMA host side after merging this patchset
>  - Implement metadata support for NVMe-oF/RDMA target side with new API
> 
> Changes since v5:
> 
>  - Rebase the code over kernel 5.2.0-rc4
>  - Change return value of ib_map_mr_sg_pi() to success/fail
>    (patches 4, 6, 11 and 16 were changed - Sagi).
>  - Squash and refactor "Validate signature handover device cap" and
>    "Move signature_en attribute from mlx5_qp to ib_qp".
>    (patch 15/21 - Christoph)
>  - Split out helper function at RW (patches 16/21 and 17/21 - Christoph)
>  - Rename signature qp create flag and signature device capability
>    (patch 14/21 - Sagi)
>  - Added Reviewed-by signatures
> 
> Changes since v4:
> 
>  - Rebase the code over kernel 5.2.0-rc2
>  - Remove some cleanups patches (they were applied to Jason's for-next)
>  - Merge iser_create_fastreg_desc and iser_alloc_reg_res (patch 11/20)
>  - Add meta_length to ib_sig_attrs structure (patch 5/20)
>  - Fix RW API in case of sig_type IB_SIG_TYPE_NONE (patch 16/20)
>  - Refactor MR descriptors allocation (patch 20/20)
> Changes since v3:
> 
>  - Add new mr types IB_MR_TYPE_USER and IB_MR_TYPE_DMA at patch 02/25
>  - Fix kernel-doc syntax at include/rdma/signature.h
>  - Remove struct ib_scaterlist
>  - Rebase the code over kernel 5.1.0
>  - Added Reviewed-by signatures
>  - Use new API in iSER LIO target and remove the old API
>  - If possibe, avoid doing a UMR operation to register data and
>    protection buffers at patch 25/25
> Changes since v2:
> 
>  - Rename IB_MR_TYPE_PI to IB_MR_TYPE_INTEGRITY (Sagi)
>  - Rename IB_WR_REG_PI_MR to IB_WR_REG_MR_INTEGRITY (Sagi)
>  - Refactor iser_login_rsp (Christoph)
>  - Unwind WR union at iser_tx_desc (patch 16/18 - Christoph)
>  - Rebase the code over kernel 5.0 plus 2 iser fixes
>  - Added Reviewed-by signatures
> Changes since v1:
> 
>  - Add a missing comma at patch 01/17
>  - Fix coding style at patches 03/17, 05/17 and 09/17
>  - Fix srp_map_finish_fr function at patch 04/17
>  - Rebase the code over 5.0-rc5
> 
> Israel Rukshin (9):
>   RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrity
>     API
>   IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
>   IB/iser: Unwind WR union at iser_tx_desc
>   RDMA/core: Add an integrity MR pool support
>   RDMA/core: Rename signature qp create flag and signature device
>     capability
>   RDMA/rw: Introduce rdma_rw_inv_key helper
>   RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
>   RDMA/mlx5: Remove unused IB_WR_REG_SIG_MR code
>   RDMA/mlx5: Improve PI handover performance
> 
> Max Gurtovoy (12):
>   RDMA/core: Introduce new header file for signature operations
>   RDMA/core: Save the MR type in the ib_mr structure
>   RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
>   RDMA/core: Add signature attrs element for ib_mr structure
>   RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
>     mlx5_ib_alloc_mr_integrity
>   RDMA/mlx5: Add attr for max number page list length for PI operation
>   RDMA/mlx5: Pass UMR segment flags instead of boolean
>   RDMA/mlx5: Update set_sig_data_segment attribute for new signature API
>   RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work
>     request
>   RDMA/core: Validate integrity handover device cap
>   RDMA/mlx5: Use PA mapping for PI handover
>   RDMA/mlx5: Refactor MR descriptors allocation

Applied to for-next, thanks

Jason
