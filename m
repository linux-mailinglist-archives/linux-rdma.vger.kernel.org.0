Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B903387DE7
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346721AbhERQxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhERQxo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 May 2021 12:53:44 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F2C061573
        for <linux-rdma@vger.kernel.org>; Tue, 18 May 2021 09:52:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id z1so5277863qvo.4
        for <linux-rdma@vger.kernel.org>; Tue, 18 May 2021 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kYQfhZjGiB21uwvvii/eDl4WBostiu4HLhRObj8C+iE=;
        b=FxbWpdm0IGamsgn5IAHkrTg5jNhGHVEvUDe5Kvnef6Ejvv72ZkKfKFszCiOhBk8zZb
         cHlseBtwFAt6roLP7q6SLV+7/H7/MQB3nPy47Uj2ywlj2dpvYhR7qVnoRy/Qj7vsTPXf
         2HrwfeKjER0STv3afEBVzmnYEPkfqBS1Eg4eUDivQDxK0allmhz/F3q5NhR65wuge/AU
         lyDq3LwBpyK6nMhQNjsynGnk3Hn97TCe1WTZD2imE/c9mNgjoh5Tb4LtEED9QuA4nF8w
         +w+FDYS2yXUzyCp619HgVehdTXU3rB4A+XT/wtUHQyoWDlvZDtAA54E1mGXAkjhITlxA
         YvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kYQfhZjGiB21uwvvii/eDl4WBostiu4HLhRObj8C+iE=;
        b=Hma1aZaq5fd5aJkx4f/Usonj9+6j2NAaAJxeE3XqnD6h2xGcCwD5cFADHjvPiY4dBD
         oIHtMGyBAZCN0zMA1ZC2zsWrJsVFnMTNObyb6rnBkdGlBaZWnUjYpWPKvk823NnuHEd/
         +wEzvs5FzJHVMOpWvXPJeafkAkKD4bKQETqWJ+qxVE2GLdyofoXUqr7E117f1+asyJ+5
         DrcVd+3MBnFGmYmE1V52Vrh0fvXGEMCdsUfuVeobk88YCP1+4EzhNKjeEzEbYEBGpB6v
         0S4u7expm4n3EvMRd7EhsgQ0dSn5u3iXdZ6CFt45ZenbFefznhuS0D1dts77tSKiWhRj
         j7Pw==
X-Gm-Message-State: AOAM531IZMADeN4nKQeo879j6g8jsijuoLEe6TjYWGEHO9VOi642glC4
        KJoLhBRDjM7OirLL/p1ohABVzw==
X-Google-Smtp-Source: ABdhPJzOVjvr8hWPrgrF7NAZj7ND3/sNqIGJupou1P68bmQVgnS5sFhzm63OZGfJulIBnmyBUsmBXA==
X-Received: by 2002:ad4:42b3:: with SMTP id e19mr6693632qvr.62.1621356744149;
        Tue, 18 May 2021 09:52:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id g5sm14962434qtm.2.2021.05.18.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 09:52:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lj2xC-00ALLW-ET; Tue, 18 May 2021 13:52:22 -0300
Date:   Tue, 18 May 2021 13:52:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     WANG Chao <chao.wang@ucloud.cn>, linux-rdma@vger.kernel.org
Subject: Re: Mellanox CX6DX switchdev mode VF fails rdma-core
 tests.test_mlx5_dc.DCTest
Message-ID: <20210518165222.GS1096940@ziepe.ca>
References: <20210518092537.mzlmqn7eua4ugztu@MacBook-Air.local>
 <13a4c4a3-0914-c8c9-1873-da83ca0177ed@nvidia.com>
 <20210518124411.vps2uyjfzo4ikjjz@MacBook-Air.local>
 <4eb5c13e-6e9a-5d79-da7d-bd4219eef447@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb5c13e-6e9a-5d79-da7d-bd4219eef447@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 18, 2021 at 09:00:29PM +0800, Mark Zhang wrote:
> On 5/18/2021 8:44 PM, WANG Chao wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 05/18/21 at 08:30P, Mark Zhang wrote:
> > > On 5/18/2021 5:25 PM, WANG Chao wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > Hi All
> > > > 
> > > > I'm running tests from https://github.com/linux-rdma/rdma-core/tree/master and
> > > > got the following errors from all tests.test_mlx5_dc.DCTest tests:
> > > > 
> > > > build/bin/run_tests.py --dev mlx5_2 --port 1 tests.test_mlx5_dc.DCTest.test_dc_rdma_write
> > > > E
> > > > ======================================================================
> > > > ERROR: test_dc_rdma_write (tests.test_mlx5_dc.DCTest)
> > > > Traceback (most recent call last):
> > > >     File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 62, in test_dc_rdma_write
> > > >       send_ops_flags=e.IBV_QP_EX_WITH_RDMA_WRITE)
> > > >     File "/data/rdma-core.master/tests/test_mlx5_dc.py", line 53, in create_players
> > > >       self.client.pre_run(self.server.psns, self.server.qps_num)
> > > >     File "/data/rdma-core.master/tests/mlx5_base.py", line 36, in pre_run
> > > >       self.to_rts()
> > > >     File "/data/rdma-core.master/tests/mlx5_base.py", line 31, in to_rts
> > > >       self.dct_qp.to_rtr(attr)
> > > >     File "qp.pyx", line 1113, in pyverbs.qp.QP.to_rtr
> > > > pyverbs.pyverbs_error.PyverbsRDMAError: Failed to modify QP state to RTR. Errno: 22, Invalid argument
> > > > 
> > > > Ran 1 test in 0.051s
> > > > 
> > > > FAILED (errors=1)
> > > > 
> > > > ===
> > > > Additional information:
> > > > 
> > > > - VF is LAG and VF binds to host.
> > > > - DC tests fail when NIC is in switchdev mode while legacy mode is fine.
> > > > - Tested on 5.12 inbox driver or OFED 5.3, neither is working.
> > > > - 5f:00.0 Ethernet controller [0200]: Mellanox Technologies MT2892 Family [ConnectX-6 Dx] [15b3:101d]
> > > > - firmware-version: 22.30.1004 (MT_0000000536)
> > > > 
> > > > I worked a bit tracepoint on 5.12 inbox driver. It seems like there's a firmware
> > > > command error for CREATE_DCT.
> > > > 
> > > > I can provide more information if you ask.
> > > > 
> > > > Thanks
> > > > WANG Chao
> > > > 
> > > Is there any syndrome in kernel log? Try to reproduce with debug log
> > > enabled:
> > > echo -n "func mlx5_cmd_check +p" > /sys/kernel/debug/dynamic_debug/control
> > 
> > [26538.391991] mlx5_core 0000:5f:00.2: mlx5_cmd_check:820:(pid 27332): CREATE_DCT(0x710) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xa22b82)
> > 
> This syndrome indicates DCT is not supported in VF LAG mode here.

Is this out of order:

    def test_odp_dc_traffic(self):
        send_ops_flag = e.IBV_QP_EX_WITH_SEND
        self.create_players(OdpDc, qp_count=2, send_ops_flags=send_ops_flag)
        self.check_odp_dc_support()
         ^^^^^^^^^^^^^^^^^^^^^

?

Jason

