Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BD6100CC
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiJ0S4T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiJ0S4Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE2360B8
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s206so3404742oie.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmmnai3yy6+siJuEOWQiQM7ESkK155WaHovW0sa1DXM=;
        b=UAPRUe1IgzO5GJHvVjK8s0hUrovNSjnpMscyIKlaTmqav75wk0rldzgGXxYzz/i+cj
         bIOFvSNTXUHlzqIiyeTHgaRxuq4V/MT4eBbloyg4loYxEBQs7OfqM8107eEZ06eQaGV0
         dyYyS0Q0sbNshxM3b8b0iM5uFZRd9jiASkNqK4WZZKcNJ73/qlzL2qHX3/tIKrf3eUbz
         2Bh7kNqZVCEJ+I4MFVXtelhuWIBe0lNkvpnDNIi/0/dsco7P20TtpP4ieGe3c1zrP1QU
         D/5p2l3CF4I7e2T6BPaD648B7q7I7eFNjG4tBA2Qj2DlTviC6lXsfAO8cjzJFKj+S/i6
         WSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmmnai3yy6+siJuEOWQiQM7ESkK155WaHovW0sa1DXM=;
        b=Fxti9vb3VwTIED3DkZatBaGHH2P+f6JTuPwGbCxKQygYwhW3q/GoMON54FuuBh0686
         uYvvI96B6tBy/agzJSqvULgK/mXN7Pka1qlZRZTAGfrynkBXxrfYqYX3/Vm6jPcvsGza
         oulXlBbp3cNWUGGERk8f8efWWj9d/CBa1gqPvg35UAJNe3US9DQfkREHy1B44tzSuLlW
         bJw13ypTmb5MovCnpkgWCRNY1JgJ+0XVzlUsYRIHC0KBDVfRWKzG+uvZzaNvpYO9KgGU
         6oMjWu3sm6XLrp4LKZ0afvgMle33li03gRlMUt/tH/2i/8ARk8wq2kV9TxrSD5Km4tLU
         E63w==
X-Gm-Message-State: ACrzQf1T9UIRQqlCKBsjPVCgLzN3eY9c+K+9bj0K0aDZu5mbvG7Savt+
        4T8QLbEzwYSyEBFf1hcJ45c=
X-Google-Smtp-Source: AMsMyM4dvDcb0+NndGI+m5F0hcJsizyH/NIw20655i0yBjoYtyVYnX7ftdsWUwlVVrb+g5Rt6RxA+A==
X-Received: by 2002:aca:bbc3:0:b0:355:18ba:8168 with SMTP id l186-20020acabbc3000000b0035518ba8168mr5544620oif.273.1666896971233;
        Thu, 27 Oct 2022 11:56:11 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 00/17] RDMA/rxe: Enable scatter/gather support for skbs
Date:   Thu, 27 Oct 2022 13:54:54 -0500
Message-Id: <20221027185510.33808-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series implements support for network devices that can
handle or produce fragmented packets. This has the performance
advantage of reducing the number of copies of payloads for large
packets.

On the send side packets packets are created with the network and
roce headers in the linear portion of the skb and the payload in
skb fragments. The pad and icrc are appended in an additional fragment
pointing at data stored in free space in the tail of the linear
buffer.

On the receive side any fragmented skb is supported.

This patch series is based on the current wip/jgg-for-next branch.

Bob Pearson (17):
  RDMA/rxe: Isolate code to fill request roce headers
  RDMA/rxe: Isolate request payload code in a subroutine
  RDMA/rxe: Isolate code to build request packet
  RDMA/rxe: Add sg fragment ops
  RDMA/rxe: Add rxe_add_frag() to rxe_mr.c
  RDMA/rxe: Add routine to compute the number of frags
  RDMA/rxe: Extend rxe_mr_copy to support skb frags
  RDMA/rxe: Add routine to compute number of frags for dma
  RDMA/rxe: Extend copy_data to support skb frags
  RDMA/rxe: Replace rxe by qp as a parameter
  RDMA/rxe: Extend rxe_init_packet() to support frags
  RDMA/rxe: Extend rxe_icrc.c to support frags
  RDMA/rxe: Extend rxe_init_req_packet() for frags
  RDMA/rxe: Extend response packets for frags
  RDMA/rxe: Extend send/write_data_in() for frags
  RDMA/rxe: Extend do_read() in rxe_comp,c for frags
  RDMA/rxe: Enable sg code in rxe

 drivers/infiniband/sw/rxe/rxe.c       |   3 +
 drivers/infiniband/sw/rxe/rxe.h       |   3 +
 drivers/infiniband/sw/rxe/rxe_comp.c  |  47 ++-
 drivers/infiniband/sw/rxe/rxe_icrc.c  |  65 +++-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  30 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 419 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.c   | 137 +++++++--
 drivers/infiniband/sw/rxe/rxe_recv.c  |   1 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 286 +++++++++++-------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 209 ++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  15 +-
 11 files changed, 865 insertions(+), 350 deletions(-)


base-commit: c9eeabac5e8d27a3f40280908e089058bab39edb
-- 
2.34.1

