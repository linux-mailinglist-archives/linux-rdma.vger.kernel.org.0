Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB27B6A05
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjJCNQA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 09:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjJCNP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 09:15:58 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE2711C
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 06:15:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-haqGrWbKN46Bzjf3YqUNmg-1; Tue, 03 Oct 2023 09:15:36 -0400
X-MC-Unique: haqGrWbKN46Bzjf3YqUNmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 436C4185A79C;
        Tue,  3 Oct 2023 13:15:34 +0000 (UTC)
Received: from hog (unknown [10.45.226.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1201054F80;
        Tue,  3 Oct 2023 13:15:29 +0000 (UTC)
Date:   Tue, 3 Oct 2023 15:15:27 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/10] octeontx2-pf: mcs: update PN only when
 update_pn is true
Message-ID: <ZRwT76YcQAFXKD4k@hog>
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
 <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2023-09-28, 11:44:25 +0300, Radu Pirea (NXP OSS) wrote:
> When updating SA, update the PN only when the update_pn flag is true.
> Otherwise, the PN will be reset to its previous value.

This is a bugfix and should go through the net tree with a Fixes
tag. I'd suggest taking patches 3,5,6 out of this series and
submitting them all to net, with a Fixes tag for patches 5 and
6. Patch 7 doesn't fix a bug and could go through the net-next tree.

-- 
Sabrina

