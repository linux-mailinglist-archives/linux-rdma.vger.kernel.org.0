Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310402FD55A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 17:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbhATQTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 11:19:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:33500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391423AbhATQTH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 11:19:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611159494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhwGPxQWphgSMeJSguPtwYrihCBeHBzAbm+eouEw04o=;
        b=BVgrrLaBl6QBsPqLPVwEPCCBV8w1njgV+vK1FwcGjQUqyIr3nrPRF+TzhdyE51Fw4y6Sks
        MTQVHg5Jakb7T8texVSb3dbWsq2TjXEx7Hwa6eWp48dexn5cPER7LO/bN1XIw6WQ5pPwXm
        kYPrAw+YJAJZfF4BMp0qPWJW7MMNvWQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F98AB805;
        Wed, 20 Jan 2021 16:18:14 +0000 (UTC)
Message-ID: <02cf3cee997cec86aede2254a28e255f228066c6.camel@suse.com>
Subject: Re: Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
From:   Martin Wilck <mwilck@suse.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mohammad Heib <goody698@gmail.com>
Date:   Wed, 20 Jan 2021 17:18:13 +0100
In-Reply-To: <20210120154531.GU4147@nvidia.com>
References: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
         <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
         <CAD=hENfCoW9pqM3ACWyLaZhw9NhRr-yJz6LLqbwW2psz_SuWHw@mail.gmail.com>
         <3c3c52c5a19beb1a22c0b51af8fd14297187e82c.camel@suse.com>
         <20210120151920.GT4147@nvidia.com>
         <9ae3161750dfc8500b68b68c94a092d10ae785f4.camel@suse.com>
         <20210120154531.GU4147@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2021-01-20 at 11:45 -0400, Jason Gunthorpe wrote:
> 
> The stuff with rxe_dma_device is wrong, just delete that hunk
> completely.

Right, that function is never called. Still declared in rxe_loc.h,
though.


I'll double check and resubmit.

Thanks
Martin


