Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D755BECB8
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiITSWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITSWL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 14:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D80543E3
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 11:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B6C1625BD
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 18:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D8FC433B5;
        Tue, 20 Sep 2022 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663698129;
        bh=ljmiITlRv3/EHEVVRsfkE4oTYzcJaioT+PtAycWou3Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Aqs2/6g1cs137kYibQ5+eO8Gs0jeQeRw111k3yKknnGpPh+weE+LDjTU/IsWrvZOF
         VZgb0zzPV+kd0PwWjC3Nn6Qk82h5llVRyPaQEPpHh3D62ooLDTlMjuYyaUW6ov5Iip
         JtO82Ne4cNMcWc1xld/J3xr5n9ot3XJb8ZaKm4J+v2bXz7k5uOJcv17uzRWwmX0ag5
         g7skk5EKG/YW+BG0mkd4MIsOEk110WQwNy/q0cH+HSt5GyXhz+1fCPNPLj4W6lUsJc
         +OBqyrQJ/nhovvdpRAl4mB+gF2qXl93nOpe8fhXNq0o0jvyl0NzL5STlFdHKmhPOud
         c5oSnT2YKTvow==
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
In-Reply-To: <20220920081202.223629-1-bmt@zurich.ibm.com>
References: <20220920081202.223629-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/siw: Always consume all skbuf data in sk_data_ready() upcall.
Message-Id: <166369812555.317747.1553449990860336985.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 21:22:05 +0300
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

On Tue, 20 Sep 2022 10:12:02 +0200, Bernard Metzler wrote:
> For header and trailer/padding processing, siw did not consume new
> skb data until minimum amount present to fill current header or trailer
> structure, including potential payload padding. Not consuming any
> data during upcall may cause a receive stall, since tcp_read_sock()
> is not upcalling again if no new data arrive.
> A NFSoRDMA client got stuck at RDMA Write reception of unaligned
> payload, if the current skb did contain only the expected 3 padding
> bytes, but not the 4 bytes CRC trailer. Expecting 4 more bytes already
> arrived in another skb, and not consuming those 3 bytes in the current
> upcall left the Write incomplete, waiting for the CRC forever.
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: Always consume all skbuf data in sk_data_ready() upcall.
      https://git.kernel.org/rdma/rdma/c/754209850df836

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
