Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0DB7A5C69
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjISIXi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjISIXh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 04:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B08102
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 01:23:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC0EC433C7;
        Tue, 19 Sep 2023 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695111811;
        bh=mhxHxuPSdi8ZliGFlvfEXB/DUndATaIlDEpHoRJxLck=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dwLynm/WRZSCkgwii996tpoQDXiuiQlgaKNbn8twG+/Hd728zf02ZUmIkxOPitdsh
         ZKaJKXeApFqJl7JNqnCARwJpcQ+xR03xXZfQBjCsl7LtqzIhUWWnHWzwR8f0P470if
         nx2u1zuIwfNSaixCkqYCmtgw7nbCIVBGYtVoTl50qKbUOg9VDkmJiNQuSalljJRBWE
         j6Pb4PEXV0DU5x5rPYi4+kW/udP6va+N+IT/Z59hfY8HWYfe3HGCbyAXmPU46Rl1Lu
         KhkiI9tHjgmRKrsoTL/HhDL6XqZEsVPvdf7J1QpDwWrrWSH09fq9IbObJepi0v3Tj4
         /yv7gHVua1+7Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230919073727.540207-1-yanjun.zhu@intel.com>
References: <20230919073727.540207-1-yanjun.zhu@intel.com>
Subject: Re: [PATCH v2 1/1] RDMA/rtrs: Require holding rcu_read_lock explicitly
Message-Id: <169511180717.47105.6288240424900804018.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 11:23:27 +0300
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


On Tue, 19 Sep 2023 15:37:27 +0800, Zhu Yanjun wrote:
> No functional change. The function get_next_path_rr needs to hold
> rcu_read_lock. As such, if no rcu read lock, warnings will pop out.
> 
> 

Applied, thanks!

[1/1] RDMA/rtrs: Require holding rcu_read_lock explicitly
      https://git.kernel.org/rdma/rdma/c/20a02837fb5e16

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
