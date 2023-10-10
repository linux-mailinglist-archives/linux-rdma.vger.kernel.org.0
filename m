Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D797BF551
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbjJJIJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 04:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346700AbjJJIJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 04:09:46 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71FA4
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 01:09:44 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-qRlSN9UqOC2zM01Za9DlmA-1; Tue, 10 Oct 2023 04:09:32 -0400
X-MC-Unique: qRlSN9UqOC2zM01Za9DlmA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A86F3185A79B;
        Tue, 10 Oct 2023 08:09:30 +0000 (UTC)
Received: from hog (unknown [10.45.225.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83FF8400F36;
        Tue, 10 Oct 2023 08:09:26 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:09:24 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        sebastian.tobuschat@oss.nxp.com, phaddad@nvidia.com,
        ehakim@nvidia.com, raeds@nvidia.com, atenart@kernel.org
Subject: Re: [PATCH net v7 0/4] Add update_pn flag
Message-ID: <ZSUGtMn6hl2Ua8qx@hog>
References: <20231005180636.672791-1-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005180636.672791-1-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2023-10-05, 21:06:32 +0300, Radu Pirea (NXP OSS) wrote:
> Patches extracted from
> https://lore.kernel.org/all/20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com/
> Update_pn flag will let the offloaded MACsec implementations to know when
> the PN is updated.
> 
> Radu P.
> 
> Radu Pirea (NXP OSS) (4):
>   net: macsec: indicate next pn update when offloading
>   octeontx2-pf: mcs: update PN only when update_pn is true
>   net: phy: mscc: macsec: reject PN update requests
>   net/mlx5e: macsec: use update_pn flag instead of PN comparation

Thanks Radu! For the series:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>


While reviewing this, I noticed that octeon can leave the HW in an
inconsistent state during upd_txsa and upd_rxsa: these ops do 2
separate changes that can both fail, and if the 2nd change fails, we
don't roll back the first change. This is an older issue (not
introduced by this patch) and can be looked at later (I don't know
what happens to the HW and why setting the PN would fail, maybe it's
not recoverable at that point).

-- 
Sabrina

