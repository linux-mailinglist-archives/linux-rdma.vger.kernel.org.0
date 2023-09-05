Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F097925AD
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjIEQBC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354555AbjIEMhN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 08:37:13 -0400
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43CDC1AD;
        Tue,  5 Sep 2023 05:37:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.81.81.211])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gw.red-soft.ru (Postfix) with ESMTPSA id 276823E1A8B;
        Tue,  5 Sep 2023 15:37:05 +0300 (MSK)
Date:   Tue, 5 Sep 2023 15:37:03 +0300
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] infiniband: cxgb4: cm: Check skb value
Message-ID: <ZPcg7/QbN73C/OYK@localhost.localdomain>
References: <20230904115925.261974-1-artem.chernyshev@red-soft.ru>
 <fe404996-6568-e2ad-656d-e75523d96637@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe404996-6568-e2ad-656d-e75523d96637@kernel.org>
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 179655 [Sep 05 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 529 529 a773548e495283fecef97c3e587259fde2135fef, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;red-soft.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/09/05 05:09:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/09/05 09:52:00 #21801295
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 04, 2023 at 10:07:26PM +0200, Krzysztof Kozlowski wrote:
> On 04/09/2023 13:59, Artem Chernyshev wrote:
> > get_skb() can't allocate skb in case of OOM.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> > ---
> >  drivers/infiniband/hw/cxgb4/cm.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > index ced615b5ea09..775da62b38ec 100644
> > --- a/drivers/infiniband/hw/cxgb4/cm.c
> > +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > @@ -1965,6 +1965,10 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
> >  	int win;
> >  
> >  	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> > +	if (!skb) {
> > +		pr_err("%s - cannot alloc skb!\n", __func__);
> 
> I don't think we print memory allocation failures.
> 
> Best regards,
> Krzysztof
> 

Sure, will fix that in v2

Thanks,
Artem
