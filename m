Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636E463EC6E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 10:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLAJ2Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 1 Dec 2022 04:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLAJ2Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 04:28:25 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DF646B;
        Thu,  1 Dec 2022 01:28:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 614FB636DD54;
        Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wy15M_caSQ6A; Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1F60D636DD5A;
        Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CL8-7XLNLvLL; Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F2E91636DD4F;
        Thu,  1 Dec 2022 10:28:14 +0100 (CET)
Date:   Thu, 1 Dec 2022 10:28:14 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1246601249.327108.1669886894894.JavaMail.zimbra@nod.at>
In-Reply-To: <Y4hyPPzyQiI3i9jh@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org> <Y4hyPPzyQiI3i9jh@unreal>
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: IB/qib: don't use qib_wc_x86_64 for UML
Thread-Index: f2COGTrJT+QspUCPV5hCPvg3sKp3dg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

----- Ursprüngliche Mail -----
> I would advocate to add this line to whole drivers/infiniband.
> None of RDMA code makes sense for UML.

Yes. Makes sense.

Thanks,
//richard
