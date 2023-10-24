Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F5B7D5A4F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 20:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJXSUH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjJXSUG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 14:20:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9EE10D3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 11:20:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F5AC433C7;
        Tue, 24 Oct 2023 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698171602;
        bh=kQSB0HWwC+m2mU2JwUU46eOwI6W/YMpOs4VlBNDN8d4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaIzzLGaoZxlOzSr8gRBwmFMbF6YcnfasOGaEfEWVZInrSOi2FcCEYg+ZTyU5dy9d
         a1FFvc67U6WLa/evUKrZmZe4/ndK9PRMvwHf+WJ8gDPxFCOVW0T74jGAnXbrtmqX6C
         lzOF9QmPj7pQkiIqEHht0dbfsgaj5jSckrmaJbcKO6t9coDn6NP6V8p0YzLSkM70sx
         TE3ymT5eUwUhs+Lr8rFgwzNzxTi5HqeZIqdBbHsnqsK2Lo3GWvLjd5+i/IS6C6WQ6u
         +8l4eyMW4ins1gdY2hQ10+bPVXw5+sqaUuNUYZmaGb4C4D90vCEayP+2kG4OZP05gG
         MVhVtohgkav4g==
Date:   Tue, 24 Oct 2023 21:19:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V2 00/20] Cleanup for siw
Message-ID: <20231024181957.GD1939579@unreal>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231024140959.GA1939579@unreal>
 <SN7PR15MB5755962D628D7026A95D968999DFA@SN7PR15MB5755.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR15MB5755962D628D7026A95D968999DFA@SN7PR15MB5755.namprd15.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 24, 2023 at 05:22:38PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Tuesday, October 24, 2023 4:10 PM
> > To: Guoqing Jiang <guoqing.jiang@linux.dev>; Bernard Metzler
> > <BMT@zurich.ibm.com>
> > Cc: jgg@ziepe.ca; linux-rdma@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH V2 00/20] Cleanup for siw
> > 
> > On Fri, Oct 13, 2023 at 10:00:33AM +0800, Guoqing Jiang wrote:
> > > V2 changes:
> > > 1. address W=1 warning in patch 12 and 19 per the report from lkp.
> > > 2. add one more patch (20th).
> > >
> > > Hi,
> > >
> > > This series aim to cleanup siw code, please review and comment!
> > >
> > > Thanks,
> > > Guoqing
> > >
> > > Guoqing Jiang (20):
> > 
> > Bernard, did you return from the vacation?
> > 
> 
> Hi Leon, yes. I have it on my list. I hope to get to it tomorrow.
> Sorry for the delay!

Thanks

> 
> Bernard.
